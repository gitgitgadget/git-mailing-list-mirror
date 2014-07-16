From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 0/3] fix test suite with mingw-unicode patches
Date: Wed, 16 Jul 2014 11:29:59 +0200
Message-ID: <20140716092959.GA378@ucw.cz>
References: <20140712075035.GA12400@ucw.cz>
 <1405431797-20899-1-git-send-email-kasal@ucw.cz>
 <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
 <53C5B0A1.4060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBGEMTGPAKGQEVSZER7I@googlegroups.com Wed Jul 16 11:30:02 2014
Return-path: <msysgit+bncBCU63DXMWULRBGEMTGPAKGQEVSZER7I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBGEMTGPAKGQEVSZER7I@googlegroups.com>)
	id 1X7LXF-0004aT-6j
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 11:30:01 +0200
Received: by mail-la0-f62.google.com with SMTP id hz20sf79315lab.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Jul 2014 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ap32hmGiuQCoDAQDVXX+Z8lgA7UAswofmfhA9/SuM2w=;
        b=Fes4G+kJk8NrfKvNuAWFpDQtt/oaU8y/LJIWFu6yVRkjYkvu6dQd5uxnV79B9ClFQP
         c6AIbI6ntgnUSibKHtKZp/aBnwOX6n0nXcwxEOI10plCvESlPIsXvw+AxsMc2MS+9KYs
         ItYGQc5KgQoOJC8dKzznwCiWjMBA/NEE0VqNhrwOGgORloGhsYWK/fpu73uAOixZd/Ye
         tscsu9CMSh4gF4o9yhi3mMVnq+3iSvG+hqOmKXpFth2haduZRY9t6pKSK6uhdKrEHrIx
         3Vo55KnWDrG0mIU2JSHFGjictngw4rtigOh/GsEy4cqbwhMpN33ziimiMfZGViuzpCZC
         SUGQ==
X-Received: by 10.180.212.71 with SMTP id ni7mr20947wic.6.1405503001014;
        Wed, 16 Jul 2014 02:30:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.80.34 with SMTP id o2ls724833wix.39.canary; Wed, 16 Jul
 2014 02:29:59 -0700 (PDT)
X-Received: by 10.180.20.140 with SMTP id n12mr1035326wie.7.1405502999844;
        Wed, 16 Jul 2014 02:29:59 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id cj4si791383wid.0.2014.07.16.02.29.59
        for <msysgit@googlegroups.com>;
        Wed, 16 Jul 2014 02:29:59 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 9610C1C01D2; Wed, 16 Jul 2014 11:29:59 +0200 (CEST)
In-Reply-To: <53C5B0A1.4060502@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253659>

Hello Karsten,

thanks for your analysis.  Most of the patches you refer to are simply
switching off tests for MINGW; let me comment on the remaining ones:

> * t0110-urlmatch-normalization: 1
> 
> Passing binary data on the command line...would have to
> teach test-urlmatch-normalization.c to read from stdin or file.
> https://github.com/msysgit/git/commit/be0d6dee

Indeed, that would be better solution.  For now, I'm going to submit the
switch-off patch you mention.

> * t4036-format-patch-signer-mime: 1
> 
> Passing non-ASCII by environment variable, will be fixed by Unicode
> environment support.

Will submit that patch series soon.

> * t7001-mv: 6
> cp -P fails in MinGW - perhaps use the long option forms (--no-dereference)?

"cp -P" fails with our 2001-edition of cp, so msysgit had to revert:
https://github.com/msysgit/git/commit/6d3e23d4

But I was ashamed to mention that upstream; and I hope mingwGitDevEnv is
going to solve that.

> * t8001-annotate/t8002-blame: 5
> 
> Msys.dll thinks '-L/regex/' is an absolute path and expands to '-LC:/msysgit/regex/'.
> https://github.com/msysgit/git/commit/2d52168a

Nice!  But I'm afraid the patch cannot be submitted upstream as it is.

I think the hack could be automated by processing options "-L*" this way:
    sed 'sX\(^-L\|,\)\^\?/X&\\;*Xg'
Then it would become only few lines at the top of the script, executed
on mingw only.
I hope to submit the patch in this form soon.

Have a nice day,
	Stepan

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
