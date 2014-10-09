From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 9 Oct 2014 09:04:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410090848380.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-15-git-send-email-marat@slonopotamus.org> <xmqqoatm8irn.fsf@gitster.dls.corp.google.com> <20141009050318.GA17479@seldon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBJPH3CQQKGQEFZFOA3Y@googlegroups.com Thu Oct 09 09:05:13 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBJPH3CQQKGQEFZFOA3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJPH3CQQKGQEFZFOA3Y@googlegroups.com>)
	id 1Xc7mh-00010k-AU
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 09:05:11 +0200
Received: by mail-ig0-f186.google.com with SMTP id uq10sf226532igb.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=QXC+tDq1WxKtrLx2NuWVfrgaiGi7J16WAiTE5uNmmQg=;
        b=NjLC3Fpd/2G3B8cLu0ETRDdz4pzekPhavJAmQVwdXUJrCtVHWFFA3VL9hG6915O2Sa
         ey1uZprdl15wEUrkuxES3phfeMpI6VJ1uA6eT1BuyfVgCq5sO0/0jFh8KgGStpHqbuyk
         +thiLOrflvFCTRgE3SJaPpgnh3Jb5QrFfSNWSHGXp/ub9KNFzNjqRwULaOSKyQ0kXthO
         KrSd3RgWhTIcyM482A6qRV41A/98nn06pfly8kzX/NLtpnmZtPyTnaiHTK03P9+Xjh8J
         LYtDVUdrmCMg/sMZZzY3CYDy+kcNlO7z4q3nYkVKiEuEAHtVf+UI3Fp2JqNUGLrl5NjH
         6jjA==
X-Received: by 10.140.95.113 with SMTP id h104mr1329qge.36.1412838310315;
        Thu, 09 Oct 2014 00:05:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.42.165 with SMTP id c34ls189567qga.8.gmail; Thu, 09 Oct
 2014 00:05:09 -0700 (PDT)
X-Received: by 10.236.24.225 with SMTP id x61mr10789723yhx.43.1412838309698;
        Thu, 09 Oct 2014 00:05:09 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id tr5si25361igb.1.2014.10.09.00.05.08
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 00:05:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Mhdex-1Xp65Q3BgJ-00Mrjt;
 Thu, 09 Oct 2014 09:04:51 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141009050318.GA17479@seldon>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:kEyqCM/umFsKIJf2LxMVvuH6QvxqpnwnYi8kWEPL6+eJFUHUF3h
 slYCxsE04g6u00Gz6Oix5/Pz/nN9BcFTnkdej4Ah1/Hd9UvX6Dd+BsDfjZVEcC1FBEdcPM7
 KG8oe9fC9hVC3PSlzONTiBs6s+zY9skvZQku5756Opd3fTGx+z1ytR/CiGEqtU08nUMjJ5z
 4WtbycGbuYQxZQOkVKm4w==
X-UI-Out-Filterresults: notjunk:1;
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Hi Marat,

On Thu, 9 Oct 2014, Marat Radchenko wrote:

> On Wed, Oct 08, 2014 at 12:26:52PM -0700, Junio C Hamano wrote:
> > Marat Radchenko <marat@slonopotamus.org> writes:
> > 
> > > When crosscompiling, one cannot rely on `uname` from host system.
> > 
> > That may well be true, but is that limited to cross-compiling to
> > mingw?   Would it be generally true for any cross compilation,
> > wouldn't it?
> > 
> > What I am wondering is if it is a better solution to make it easier
> > to allow somebody who is cross compiling to express "Mr.  Makefile,
> > we know better than you and want you to do a MINGW build for us
> > without checking with `uname -?` yourself", i.e.
> > 
> > 	$ make uname_O=MINGW uname_S=MINGW
> > 
> > which would hopefully allow cross-compilation into other
> > environments, not just MINGW.
> 
> So, do you really want this patch to be changed from 5-liner into
> a full-blow system detection rewrite based on `cc -dumpmachine`
> instead of `uname`?

Junio's responsibility as a maintainer is to keep this project afloat for
a broader audience than this patch series tries to reach. Keeping that in
mind, a patch that fixes a broad issue (in this case, cross-compiling)
*just* for one small use case (in this case, cross-compiling for Windows
using MinGW) might need a very good argument to convince the maintainer
that a broader solution is either not achievable or so much more
complicated that it is completely outside of the scope of this patch
series.

FWIW this is *exactly* what I pointed out here:

	https://github.com/dscho/git/commit/e31124d4e8ba4e48181306198648cdfe73ff9c30#comments
	Hmm. This is a very narrow solution to the underlying problem.
	Just think about cross-compiling for e.g. MacOSX. The solution
	presented in this commit works for MinGW, only for MinGW, and for
	MinGW alone. The commit message needs to do a much better job to
	make that clear.

And Junio actually pointed out that a broader solution is neither
impossible nor complex: Junio hinted at the use of the conditional
assignment "FOO ?= bar":

	https://www.gnu.org/software/make/manual/make.html#index-_003f_003d

IMHO it would make tons of sense to replace the := assignments in
https://github.com/dscho/git/blob/e31124d4e8ba4e48181306198648cdfe73ff9c30/config.mak.uname#L3-L8
by ?= assignments.

Of course it is very obvious where the idea for the patch we are
discussing here comes from: the current config.mak.uname has this:

	ifdef MSVC
		# avoid the MingW and Cygwin configuration sections
		uname_S := Windows
		uname_O := Windows
	endif

This could be cleaned up in the same run: to be assigned *before* the
conditional assignments of uname_S. Likewise, the MINGW-specific part
should be done by searching for "mingw" in CROSS_COMPILE, also before the
block of the uname_* variable assignments.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
