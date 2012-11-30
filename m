From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/5] win32: support echo for terminal-prompt
Date: Fri, 30 Nov 2012 13:30:16 -0500
Message-ID: <20121130183016.GF7197@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSZ7YRgvS1=SR=Nx0wcn+NXCVwqjVShk-ug3=yX62RH-oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBOXW4OCQKGQEK2X7FUY@googlegroups.com Fri Nov 30 19:30:33 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBOXW4OCQKGQEK2X7FUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f186.google.com ([209.85.223.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBOXW4OCQKGQEK2X7FUY@googlegroups.com>)
	id 1TeVM8-0002G7-Hw
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:30:32 +0100
Received: by mail-ie0-f186.google.com with SMTP id c14sf765219ieb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=JeWXYqlJpIMGQz0yOt0gIEuVeLn0JmgPOFwn4ESmFoU=;
        b=hiw68gko0Bkx+DAZwchbhl9hsC+2FD5PBWQTl/b17+80OS9P0swlCDcv2TmEQH5ToI
         0l54aqel2ITo1nLvDywU4hrrLBP9tcw3U1mQ28NCu/pcp5+wSl1QVSFIN3vWtfI4g6iA
         87c/bybjLxbqV080qiNUg+2CZ84NQCa5PKa7nMYeQ+O6BKjPI1V+Klov3XXXrw9h+HHC
         HxTtieS2mvYrwT5VmAFT99s3YnyDSCmsOHV7usmfXIXF1LK8BOWggur1/h6o8fh7a9zS
         AqTQ8q2i8NNftCfYz3P8NqQKxirdsbfStt4IeDzGCoC6szpnCddZIzhERAOXF5Rl8Goe
       
Received: by 10.50.193.194 with SMTP id hq2mr2426997igc.6.1354300220682;
        Fri, 30 Nov 2012 10:30:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.152.205 with SMTP id va13ls1944igb.31.canary; Fri, 30 Nov
 2012 10:30:18 -0800 (PST)
Received: by 10.50.213.37 with SMTP id np5mr1964567igc.5.1354300218366;
        Fri, 30 Nov 2012 10:30:18 -0800 (PST)
Received: by 10.50.213.37 with SMTP id np5mr1964565igc.5.1354300218354;
        Fri, 30 Nov 2012 10:30:18 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id dx8si1393980igc.1.2012.11.30.10.30.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 10:30:18 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 5484 invoked by uid 107); 30 Nov 2012 18:31:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 13:31:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 13:30:16 -0500
In-Reply-To: <CABPQNSZ7YRgvS1=SR=Nx0wcn+NXCVwqjVShk-ug3=yX62RH-oQ@mail.gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210941>

On Fri, Nov 30, 2012 at 11:16:59AM +0100, Erik Faye-Lund wrote:

> Ping?

Thanks for the reminder; your initial series came while I was traveling.

I think it looks good. The compat/terminal code ends up a little uglier,
but I think you overall did a good job of balancing code reuse across
platforms with readability.

-Peff

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
