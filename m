From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Thu, 9 Oct 2014 21:47:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-8-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
 <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    gitster@pobox.com, msysGit <msysgit@googlegroups.com>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBSWM3OQQKGQEG65YK5Q@googlegroups.com Thu Oct 09 21:47:24 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBSWM3OQQKGQEG65YK5Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBSWM3OQQKGQEG65YK5Q@googlegroups.com>)
	id 1XcJgJ-0004am-I1
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 21:47:23 +0200
Received: by mail-la0-f57.google.com with SMTP id mc6sf175771lab.12
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=7EhmYlvtV6SASeGqCj8Z2eGmcjN6Mq1RtfP2mD6EmS4=;
        b=X5iWoRH0O6OCCq+emiRzgeWrr4IhBDDi0t7Hb9q/uMWdlJYXCHFJFNeB8a+O6tu9DQ
         aIl4s6LonrrfTBRhENybBLmMXvHOUo672D2m7XSXRD711ju0030tNKOCacvJ7YR3C++W
         m4CMhsscSTFmGP/UyrHWt6BN1wqL8Du79MRCjKh44UM9PwOx7MSdsDmOZ24CPbU27oQU
         ZmRPqia/5MbNC2Asyi/J3rCF3BNViWV6O7sCI66wJ4l+4KB+PkjRFfPkglM+H59O0Ti+
         DRxKQ6C8Iqn/7AJTQ/ZBTUo78oybnLcXhdGF3GKBunaLfGuP+qdOjPOsNJZGCaeLPOD1
         BE9w==
X-Received: by 10.180.221.102 with SMTP id qd6mr3946wic.10.1412884043365;
        Thu, 09 Oct 2014 12:47:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.211.42 with SMTP id mz10ls11409wic.35.gmail; Thu, 09 Oct
 2014 12:47:22 -0700 (PDT)
X-Received: by 10.180.160.169 with SMTP id xl9mr68396wib.7.1412884042513;
        Thu, 09 Oct 2014 12:47:22 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id us10si661945lbc.1.2014.10.09.12.47.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 12:47:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0M0h9K-1YTSX30hCw-00uoiz;
 Thu, 09 Oct 2014 21:47:19 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:lgW5l5MUsXZknJeqvFsiy8S8hVahsfnqjyUwFCbNx+TwklMKwX9
 eMkeURn/H0GxgDxxBCu6/ednklZIXcIJmH2DhtHrJJnFxzyWBBA9pnW5uQpQCLvzowTyjhM
 30784fhQAS5KtNb+JeKDvp0RUIpBzq7KDBBylIZV3lgI+vRsSogpHQFXMbCtymhgkAa+ead
 Vv396UL0jp97Zkgojb/9g==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
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

Hi Ray,

On Thu, 9 Oct 2014, Ray Donnelly wrote:

> On Thu, Oct 9, 2014 at 8:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 8 Oct 2014, Marat Radchenko wrote:
> >
> >> +CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo not')
> >
> > There is a rather huge problem with that. The latest mingw-w64
> > release, 4.9.1, does not do what you expect here: while
> > '.../mingw32/bin/gcc -m32 -o 32.exe test.c' and '.../mingw32/bin/gcc
> > -m64 -o 64.exe test.c' work fine, producing i686 and x86_64
> > executables respectively, '.../mingw32/bin/gcc -dumpmachine' prints
> > i686-w64-mingw32 *always*, even when specifying the -m64 option.
> >
> > So unfortunately, the test introduced by this patch (intended to
> > figure out whether the build targets i686, and skip a compiler and a
> > linker option otherwise) is incorrect.
> 
> Which release are you talking about? Can you point me to the tarball
> please?

Certainly:

http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.1/threads-win32/sjlj/

(rev1, not rev0)

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
