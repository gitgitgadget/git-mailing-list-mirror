From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: turn off git-daemon tests if FIFOs are
 not available
Date: Thu, 29 May 2014 11:57:10 -0400
Message-ID: <20140529155710.GA3763@sigill.intra.peff.net>
References: <20140529113614.GA24293@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysgit@googlegroups.com
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDO2DJFKTEFBBWNRTWOAKGQEPBHYPJY@googlegroups.com Thu May 29 17:57:18 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBWNRTWOAKGQEPBHYPJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f191.google.com ([209.85.220.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBWNRTWOAKGQEPBHYPJY@googlegroups.com>)
	id 1Wq2he-0001RA-PB
	for gcvm-msysgit@m.gmane.org; Thu, 29 May 2014 17:57:14 +0200
Received: by mail-vc0-f191.google.com with SMTP id id10sf168569vcb.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 29 May 2014 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=JP4MmMr/1BMkA+bhfjmDGsnKEexp2ar9Z1k0AFDmD2E=;
        b=eAsBzWr05mA1Q9dkFPMpH//alnfaz0ubJp1GAtdeWJWiWJG8GldvfWAqVwE1OHUd/7
         xvHcwqp/SItiXF6YWuI+B0z0G+N7EJh91qljdpkdjxqk8lSMynu4B0PCX8Ji1kP+Xyqn
         87k43vxPR+ycsaIgU/yQRBSmhssAvng3rW+IAIY6/4hurdRrCSPTMZ282mKZypKlaQ+T
         XEhuo/g+InlA0gzFxpuqaa3JT5mY4aa6asHzMbaAc3+/iFGGRwYRZzYgNAS8sHdFsbiz
         0Bb33MFJulb6/97WtNqeU8iVm7reidt3POxBI543wOL0NNadyzuqcbnP8JLE5nvW3XYw
         MPkg==
X-Received: by 10.182.247.2 with SMTP id ya2mr68704obc.20.1401379033996;
        Thu, 29 May 2014 08:57:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.210.132 with SMTP id mu4ls198449obc.93.gmail; Thu, 29 May
 2014 08:57:13 -0700 (PDT)
X-Received: by 10.182.106.229 with SMTP id gx5mr3401838obb.31.1401379032993;
        Thu, 29 May 2014 08:57:12 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id t6si1027900igk.0.2014.05.29.08.57.12
        for <msysgit@googlegroups.com>;
        Thu, 29 May 2014 08:57:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 2778 invoked by uid 102); 29 May 2014 15:57:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 10:57:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 11:57:10 -0400
In-Reply-To: <20140529113614.GA24293@camelia.ucw.cz>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250373>

On Thu, May 29, 2014 at 01:36:14PM +0200, Stepan Kasal wrote:

> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> 
> Hi,
>   mingw does not have FIFOs, so it cannot run git-daemon tests.

Thanks. I took a peek at the mkfifo call here. It is used to make sure
the daemon has started before we run the tests which depend on it. I
suspect we could do something with a regular pipe, but the code would be
rather tricky.  Simply skipping the daemon tests is a reasonable
compromise until somebody feels like trying to make it work without a
fifo.

-Peff

-- 
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

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
