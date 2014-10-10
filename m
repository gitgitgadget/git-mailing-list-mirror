From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Fri, 10 Oct 2014 12:55:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410101252240.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-8-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info> <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
 <alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info> <CAOYw7dtouon0EXYQPnvpc7ZMARKwaureNTK6ZL+aByknpPG-9A@mail.gmail.com> <alpine.DEB.1.00.1410100809450.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    gitster@pobox.com, msysGit <msysgit@googlegroups.com>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBOXW32QQKGQE7STEEFQ@googlegroups.com Fri Oct 10 12:55:59 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBOXW32QQKGQE7STEEFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBOXW32QQKGQE7STEEFQ@googlegroups.com>)
	id 1XcXra-0002qo-9k
	for gcvm-msysgit@m.gmane.org; Fri, 10 Oct 2014 12:55:58 +0200
Received: by mail-la0-f63.google.com with SMTP id ge10sf301551lab.18
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Oct 2014 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=BTOhlk8VY8Ejm0a6I1pRQXn2OnAjghx78LKl8lWbUsE=;
        b=FLQHrXh4ZsVPk+8P0VsdpvBe27sLqZmTeg5G8tONeQ4F7JcT0UB+zo1l9fZSXTL7/d
         Iz4K0GL5JG9CU2ot7RnCMtABg4Xl1ssSDXZ4xLtrRtjZAiJNApuv/t6eU/KWdm6chUug
         27C4ppxOHBsXiBmAZoouuVahWXU+ZkY+tASsgkx41TPanHaT4qOAIqBSj1P+x+ZY/vzD
         1MfQO2WZavp5pGUTYuFZoyMSihnJcjafuuMjG3MX+MlaQzD42uyJIKBn9HLh5CFXRP2+
         2b4aIn+DnJ1nIbMjKw5UgeLXoFqnLFVv8jc+fzpCrpZR99/j4eflsJPA9JeJkF8hqvW/
         4yBQ==
X-Received: by 10.152.203.200 with SMTP id ks8mr20124lac.8.1412938555834;
        Fri, 10 Oct 2014 03:55:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.87.132 with SMTP id ay4ls254788lab.46.gmail; Fri, 10 Oct
 2014 03:55:53 -0700 (PDT)
X-Received: by 10.152.26.225 with SMTP id o1mr827320lag.4.1412938553801;
        Fri, 10 Oct 2014 03:55:53 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id us10si259388lbc.1.2014.10.10.03.55.53
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Oct 2014 03:55:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MWTfu-1XibLv0iBW-00XaqU;
 Fri, 10 Oct 2014 12:55:05 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1410100809450.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:QW48cMw+janAliObt8z7SEK5Mj2GXk8qg+GzO0hwPVQQuxwOU7l
 07psNz70u3BtFHlESyVKfCSf5IDxfZHbMbjPiWnEY1UeMWuqq30veblCltXJDq5KdiSfEJ2
 V8RWJ+0PYtRJXOTvkGjcIe1+db5/ACX2NNGgYlCNXQR3g/m7OTkqqfWySCyw/p7xDOMJcG1
 scD6ZhtcEFKUhr/jSz92g==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
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

Hi,

On Fri, 10 Oct 2014, Johannes Schindelin wrote:

> With this [mingw-w64] compiler, and the 'w64' branch from
> https://github.com/dscho/git =E2=80=93 intended to be merged into
> https://github.com/git-for-windows/git =E2=80=93 the following command-li=
ne
> produces 64-bit Git:
>=20
> 	PATH=3D/path/to/unpacked/mingw-w64/mingw64/bin/:$PATH \
> 	make \
> 		CROSS_COMPILE=3Dx86_64-w64-mingw32- CC=3D'$(CROSS_COMPILE)gcc' \
> 		AR=3Dar RC=3Dwindres \
> 		NO_ICONV=3D1 NO_OPENSSL=3D1 NO_CURL=3D1 NEEDS_LIBICONV=3D USE_LIBPCRE=
=3D
>=20
> The test suite passes so far (still running, at the time of writing it is
> going through t3404).

And it stopped at t3900-i18n-commit.txt:

not ok 15 - ISO8859-1 should be shown in UTF-8 now
not ok 16 - eucJP should be shown in UTF-8 now
not ok 17 - ISO-2022-JP should be shown in UTF-8 now
not ok 23 - ISO8859-1 should be shown in UTF-8 now
not ok 24 - eucJP should be shown in UTF-8 now
not ok 25 - ISO-2022-JP should be shown in UTF-8 now
not ok 27 - ISO-2022-JP should be shown in eucJP now
not ok 28 - eucJP should be shown in ISO-2022-JP now

Inspecting the test case 15 above, it appears as if ISO-8859-1 was still
shown as ISO-8859-1 instead of UTF-8:

$ hexdump.exe /git/t/t3900/1-UTF-8.txt trash
directory.t3900-i18n-commit/current
---- /git/t/t3900/1-UTF-8.txt ----
0000  c3 84 c3 8b c3 91 c3 8f  c3 96 0a 0a c3 81 62 c3
0010  a7 64 c3 a8 66 67 0a
---- trash directory.t3900-i18n-commit/current ----
0000  c4 cb d1 cf d6 0a 0a c1  62 e7 64 e8 66 67 0a

So I fear we have still a ways to go before Git works as a 64-bit Windows
binary...

Ciao,
Johannes

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
