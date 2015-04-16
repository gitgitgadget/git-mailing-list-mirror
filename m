From: Andreas Mohr <andi@lisas.de>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 14:35:52 +0200
Message-ID: <20150416123552.GA825@rhlx01.hs-esslingen.de>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <27f1120c2c5231d8c7add8bdac7e3b21@www.dscho.org>
 <20150416114235.GB30818@rhlx01.hs-esslingen.de>
 <20150416114846.GC30818@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	git-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
X-From: msysgit+bncBCY73CGE2IFRBKOZX2UQKGQEBAZ3N7Y@googlegroups.com Thu Apr 16 14:35:57 2015
Return-path: <msysgit+bncBCY73CGE2IFRBKOZX2UQKGQEBAZ3N7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCY73CGE2IFRBKOZX2UQKGQEBAZ3N7Y@googlegroups.com>)
	id 1Yij1O-0002bc-BV
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 14:35:54 +0200
Received: by lbio15 with SMTP id o15sf23969098lbi.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=p6pvK0TmonGgNfUqVlO+BeHBpXqRFlYQUskqQYZltpE=;
        b=k8DrqNhT+87VbmxKz0UIHzT2pnZm7b7sAkdSW6Saek4fw2/wjfCauQ3KI7CnTi+lce
         TVoQqU2Qz5lRt8FF1KwjHz4W8Z8X9QyFFQx+ExKZNsA3v3mkmeY6gx9l7dGBxjjCJErE
         ItKZyVmO1v1kyD6SE1AQ/wU+H3bO074RmAJ7oiaqi3ICThsDisRnsmSoezYYdsvrbDZI
         WwI4CuKup4JfLJKxZEipN805S5Pn8QVusE4nMt9Wd0gL1tVpU3Vb09GVrNFXK30Fzgkl
         qNGnTd9A8sFrij2ltFY10os71Ov98AtiE2mGOtKi/YMrnLplvHO2gMt7c2YK1FiMkOdu
         SM+g==
X-Received: by 10.152.3.73 with SMTP id a9mr377856laa.38.1429187754016;
        Thu, 16 Apr 2015 05:35:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.197 with SMTP id o5ls309621laf.66.gmail; Thu, 16 Apr
 2015 05:35:52 -0700 (PDT)
X-Received: by 10.112.162.228 with SMTP id yd4mr3128435lbb.8.1429187752867;
        Thu, 16 Apr 2015 05:35:52 -0700 (PDT)
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de. [129.143.116.10])
        by gmr-mx.google.com with ESMTPS id bc3si982976wib.2.2015.04.16.05.35.52
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 05:35:52 -0700 (PDT)
Received-SPF: none (google.com: andi@rhlx01.hs-esslingen.de does not designate permitted sender hosts) client-ip=129.143.116.10;
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id 8C8914A780; Thu, 16 Apr 2015 14:35:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150416114846.GC30818@rhlx01.hs-esslingen.de>
X-Priority: none
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Original-Sender: andi@lisas.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: andi@rhlx01.hs-esslingen.de does not designate permitted sender
 hosts) smtp.mail=andi@rhlx01.hs-esslingen.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267282>

On Thu, Apr 16, 2015 at 01:48:46PM +0200, Andreas Mohr wrote:
> OK, at this point in time it's my turn to actually verify
> that indeed it's NOT the virus scanner:
> - generate rebase-heavy activity
> - update
> - hit issue
> - unload virus (~ scanner?? I'm unsure on exact terminology to be used ;-)
> - update
> - profit!?

Despite trying hard (generating a lot of activity, with different repo projects even)
I cannot reproduce it in a timely manner,
thus I'll have to wait until repo state has degraded in a sufficient manner
for such a larger repack with that issue to occur again
(probably a matter of weeks).
Once it happens, I will:
- ensure keeping a copy of the entire (problematic-state) repo, and verify reproducibility of its (copied/preserved) breakage
- unload virus and do other tests
- report back

Andreas Mohr

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
