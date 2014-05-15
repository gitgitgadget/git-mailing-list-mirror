From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 19:46:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1405151944410.14982@s15462909.onlinehome-server.info>
References: <20140514155010.GA4592@camelia.ucw.cz> <xmqq7g5okztp.fsf@gitster.dls.corp.google.com> <20140514182654.GA9218@google.com> <20140514190716.GA2715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
    Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
    msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBFH32ONQKGQEPPAZ46Q@googlegroups.com Thu May 15 19:47:04 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBFH32ONQKGQEPPAZ46Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBFH32ONQKGQEPPAZ46Q@googlegroups.com>)
	id 1WkzkC-0004VZ-Qi
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 19:47:00 +0200
Received: by mail-la0-f63.google.com with SMTP id b8sf132728lan.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ZrCttiZiZE2SPTeZUbE8FBkCXqoxAGR2xENRxGSwo+E=;
        b=XZkzZqWV0N+andf9am8Xht2u00PXavo1hy+VOex9cDWiI9Z5wY9pFfme5oSH31fJBa
         DKkiWnLHGHvuLsjgBd6ldS1mu3bmV7BDFrfibWc6hCT/xOtv8gVxe0VvILLiaSPOsPGa
         m/5gyMA0MNM8upsDHn+8OVtAIRNqnFEgy0vVQDVUacQ2ze5oUst/SKjgm0dTo4hOWFv9
         t7AfODVa8eH4+3X+hDUs7fYZXVRzcpH9wQeL+AMtGs4B/TNBtB52NcxvQ9fwRrORWKrV
         5vOGXYQgcGviO/L0ujZM4UmZiP8yyLZkxxr2JD6ENA9XY+GI8du2BuHdtO4NI3nxCZhL
         PX9w==
X-Received: by 10.180.75.178 with SMTP id d18mr64576wiw.13.1400176020634;
        Thu, 15 May 2014 10:47:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.103.39 with SMTP id ft7ls1284534wib.2.canary; Thu, 15 May
 2014 10:46:59 -0700 (PDT)
X-Received: by 10.180.211.114 with SMTP id nb18mr3713771wic.4.1400176019888;
        Thu, 15 May 2014 10:46:59 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id r49si1924855eep.0.2014.05.15.10.46.59
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 May 2014 10:46:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LbPza-1XDxqL2Wsc-00ky2I;
 Thu, 15 May 2014 19:46:51 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140514190716.GA2715@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:6qVQPMVUWJ/KMj/XPsz5RHXGAvFV8O+X8FNbkvKas8CKpMmOgqB
 Yip36xYDVhrzOn20tUElQFh1g/srkAF2VKv/PE1Q3FaebNrPLEAZaxhX2V9kiqjyLLEaFyZ
 hsrhL/RJ1IEBt5OngrgVJbD4KXaJbgbl80HunNvXFVU4r45XnmfoBCAp/Dnlx6zM6KzpTAZ
 HDxfMg4UMO7k54upLpZjA==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249170>

Hi Peff,

On Wed, 14 May 2014, Jeff King wrote:

> On Wed, May 14, 2014 at 11:26:54AM -0700, Jonathan Nieder wrote:
> 
> > "git grep" has other options that affect interpretation of the pattern
> > which this patch does not help with:
> > 
> >  * -v / --ignore-match: probably should disable this feature of -O.
> >  * -E / --extended-regexp
> >  * -P / --perl-regexp
> >  * -F / --fixed-strings: ideally would auto-escape regex specials.
> >  * -e<pattern1> --or -e<pattern2>
> > 
> > And git grep -Ovi has a similar bug, for which the fix is to add
> > \c to the pattern instead of passing an -I option.
> 
> We've already found the lines of interest to the user. It would be nice
> if we could somehow point the pager at them by number, rather than
> repeating the (slightly incompatible) search.

FWIW it is exactly that type of "I want your patch to do more than you do"
type of comments that makes it impossible for myself to contribute patches
anymore. It just does not fit inside my Git time budget anymore.

Besides, it breaks exactly the intended usage. My intent is not just to
see the matching lines in the pager, but to be able to adjust the search
pattern further if needed. Your suggestion completely breaks that usage.

Ciao,
Johannes

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
