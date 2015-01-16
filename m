From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Thu, 15 Jan 2015 22:34:46 -0500
Message-ID: <20150116033445.GA29572@peff.net>
References: <54B6C897.5030405@web.de>
 <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
 <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net>
 <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
 <20150115235752.GB25120@peff.net>
 <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
 <20150116013256.GA25894@peff.net>
 <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBWEN4KSQKGQEWAIJFKI@googlegroups.com Fri Jan 16 04:34:50 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBWEN4KSQKGQEWAIJFKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f192.google.com ([209.85.160.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBWEN4KSQKGQEWAIJFKI@googlegroups.com>)
	id 1YBxgQ-00007q-3p
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 04:34:50 +0100
Received: by mail-yk0-f192.google.com with SMTP id 79sf2486006ykr.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 Jan 2015 19:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=SjdfwtPqQDzUC6VW+Xp6xGLrM/mHeUpg889mTLj6NAY=;
        b=rukBugNhT8s4naayoKna4OT3iRIC8paZdClrvTNoqVy2N/ITBCHDTQhCKmBq66jsh+
         jH+FfJjwOAXCAl0d7Fwmhu7hQTm//y2OHQue0bSoZgok7IGS5PGyHlkgMwbCnfLdK+3p
         AAFq5YZ9I0YTDRN6SoZPeYPl+4Gp0YvrLWPeTXs2Z3wvtfcbNcmpk+zZsfFKWl4e1H+b
         RmdiOrUa2s9LN3opblcPkJ2Nfd09+sJA8zeKU9Dn79104+KY33Ca9aM11vy9ADQZp3Hw
         WjweW+Van6Lhzfou0q2aQHiNWjEdy54ikCYP1dQzj4075+wQXXioWDUbPiRm21cxfHTj
         VM4w==
X-Received: by 10.140.92.52 with SMTP id a49mr3200qge.10.1421379289441;
        Thu, 15 Jan 2015 19:34:49 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.107.8 with SMTP id g8ls1301357qgf.22.gmail; Thu, 15 Jan
 2015 19:34:48 -0800 (PST)
X-Received: by 10.236.29.177 with SMTP id i37mr9968744yha.1.1421379288829;
        Thu, 15 Jan 2015 19:34:48 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id f3si119655igr.1.2015.01.15.19.34.48
        for <msysgit@googlegroups.com>;
        Thu, 15 Jan 2015 19:34:48 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 18149 invoked by uid 102); 16 Jan 2015 03:34:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 21:34:48 -0600
Received: (qmail 19775 invoked by uid 107); 16 Jan 2015 03:35:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 22:35:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 22:34:46 -0500
Content-Disposition: inline
In-Reply-To: <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262537>

On Thu, Jan 15, 2015 at 07:27:34PM -0800, Kyle J. McKay wrote:

> >We implement NOT_ROOT by checking perl's "$>" variable,
> >since we cannot rely on the "id" program being available
> >everywhere (and we would rather avoid writing a custom C
> >program to run geteuid if we can).
> 
> Does it make a difference that id is POSIX [1]?

I don't know. Do all of the platforms where we run http tests have it
(and conforming to POSIX-ish options or output)? It may be OK to guess
yes and see if anybody complains (the worst case is skipping http
tests).

> "id -u" works for me in MSYS and cygwin (each appears to have it's own
> id.exe).

That's comforting. MSYS was the one I was most worried about. What UID
do they report? I.e., do they correctly tell us if we are root (or
more accurately, if we are not root)?

> >+test_lazy_prereq NOT_ROOT '
> >+	uid=$(perl -e "print \$<") &&
> >+	test "$uid" != 0
> >+'
> 
> Does NO_PERL affect this?  Or is Perl always required to run the tests.

No, we use a very limited subset of perl in our tests when necessary
(basic enough that any perl5 will do), regardless of the NO_PERL
setting.

> Also "$<" is real user id.  Don't you want effective user id ("$>"), that's
> what the comment says...

Yeah, I bungled this initially and thought I fixed it, but clearly not.
:-/

I'll re-roll, but if we can get away with "id -u" I think that's
preferable.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
