From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] Make the msvc-build scripts work again
Date: Thu, 25 Jun 2015 08:10:39 -0700
Message-ID: <xmqqh9pv258w.fsf@gitster.dls.corp.google.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>,  MsysGitList <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRB4NTWCWAKGQEVK3V77A@googlegroups.com Thu Jun 25 17:10:42 2015
Return-path: <msysgit+bncBCG77UMM3EJRB4NTWCWAKGQEVK3V77A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f56.google.com ([209.85.213.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB4NTWCWAKGQEVK3V77A@googlegroups.com>)
	id 1Z88na-0005Zi-60
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 17:10:42 +0200
Received: by yhzz6 with SMTP id z6sf17045599yhz.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=XpUJLAXms1I7wH5uvi4pyuttgrjPmVhTU+FmFZIultc=;
        b=d+NdTo3nsGpEAqfI5TDNATGaXJHb+fv9z9fZSbhc+44Rc82kRWsoCBnsCwkjSuPqs6
         0wEAvdz+gFtRGeyh0AHgkcZiR2o6CbW2Z+9oPttMdT7Mz6B0HMIZY29cMvILUnHdzjAp
         RYmAAerHX5pwsFSPiMrJlNFwj/mBspUZHq+ZBu6m0r2Q01qHmOkUBBa15Gu0dfs3M/RX
         r6V3TOFdVbNKhZSw3oB4pGgwN3k9xpc1hMF/jemk4mHqiaxDaIjEimFAF0pw2zkdDT3M
         gGqZlNT1Nr2pFD1psvDTYdP7DvQqoKQGDllvQ39aqN6J38yrYMLpRa0mHbshdfr/tgFS
         lXLA==
X-Received: by 10.140.22.199 with SMTP id 65mr727500qgn.15.1435245041550;
        Thu, 25 Jun 2015 08:10:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.20.69 with SMTP id 63ls1454582qgi.30.gmail; Thu, 25 Jun
 2015 08:10:40 -0700 (PDT)
X-Received: by 10.13.200.67 with SMTP id k64mr59531471ywd.54.1435245040911;
        Thu, 25 Jun 2015 08:10:40 -0700 (PDT)
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com. [2607:f8b0:4001:c03::22f])
        by gmr-mx.google.com with ESMTPS id o7si546328igp.1.2015.06.25.08.10.40
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 08:10:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c03::22f as permitted sender) client-ip=2607:f8b0:4001:c03::22f;
Received: by mail-ie0-x22f.google.com with SMTP id rt9so56514858ieb.2
        for <msysgit@googlegroups.com>; Thu, 25 Jun 2015 08:10:40 -0700 (PDT)
X-Received: by 10.43.164.66 with SMTP id mr2mr43227752icc.85.1435245040789;
        Thu, 25 Jun 2015 08:10:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id x83sm38950ioi.6.2015.06.25.08.10.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 08:10:40 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <1435190633-2208-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 25 Jun 2015 01:03:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c03::22f
 as permitted sender) smtp.mail=jch2355@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272683>

Philip Oakley <philipoakley@iee.org> writes:

> Hopefully it's not too late in the cycle for a review of this contrib/compat
> item.

Has this been discussed in the Windows land and folks are all happy
with this change?  If so the only thing we would need review on the
main list is the top-level change outside compat/ and contrib/, so
it may be possible to sneak it in before -rc1.

Otherwise, no, but we can still polish it during the prerelease
freeze and aim to merge it in the first batch after the upcoming
release.


> Philip Oakley (17):
>   .gitignore: improve MSVC ignore patterns
>   .gitignore: ignore library directories created by MSVC VS2008
>     buildsystem
>   (msvc-build) Vcproj.pm: remove duplicate GUID
>   Makefile: a dry-run can error out if no perl. Document the issue
>   engine.pl: fix error message (lib->link)
>   engine.pl: Avoid complications with perl support
>   engine.pl: Properly accept quoted spaces in filenames
>   engine.pl: Fix i18n -o option in msvc buildsystem generator
>   engine.pl: ignore invalidcontinue.obj which is known to MSVC
>   engine.pl: name the msvc buildsystem's makedry error file
>   engine.pl: delete the captured stderr file if empty
>   engine.pl: add debug line to capture the dry-run
>   engine.pl: provide more debug print statements
>   Vcproj.pm: list git.exe first to be startup project
>   vcbuild/readme: Improve layout and reference msvc-build script
>   msvc-build: add complete Microsoft Visual C compilation script
>   config.mak.uname: add MSVC No_SafeExeceptionHandler option
>
>  .gitignore                                |  8 ++-
>  Makefile                                  |  3 ++
>  compat/vcbuild/README                     | 27 +++++++---
>  compat/vcbuild/scripts/msvc-build         | 89 +++++++++++++++++++++++++++++++
>  config.mak.uname                          |  9 ++++
>  contrib/buildsystems/Generators/Vcproj.pm | 34 ++++++------
>  contrib/buildsystems/engine.pl            | 37 ++++++++++---
>  7 files changed, 174 insertions(+), 33 deletions(-)
>  create mode 100644 compat/vcbuild/scripts/msvc-build


>  mode change 100755 => 100644 contrib/buildsystems/engine.pl

Why?

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
