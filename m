From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Sat, 11 Oct 2014 13:12:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410111310530.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-8-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info> <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
 <alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info> <CAOYw7dtouon0EXYQPnvpc7ZMARKwaureNTK6ZL+aByknpPG-9A@mail.gmail.com> <alpine.DEB.1.00.1410100809450.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1410101252240.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    gitster@pobox.com, msysGit <msysgit@googlegroups.com>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBP5B4SQQKGQEAO47WZY@googlegroups.com Sat Oct 11 13:13:04 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBP5B4SQQKGQEAO47WZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f191.google.com ([209.85.216.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBP5B4SQQKGQEAO47WZY@googlegroups.com>)
	id 1Xcubg-0000h1-8V
	for gcvm-msysgit@m.gmane.org; Sat, 11 Oct 2014 13:13:04 +0200
Received: by mail-qc0-f191.google.com with SMTP id c9sf667825qcz.18
        for <gcvm-msysgit@m.gmane.org>; Sat, 11 Oct 2014 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=A8Ve9mwPukXujlmxKfgUwl24vnRX1975PAaQIqKlEHs=;
        b=kOyfbCWzJq8wgfh4k1cQV08T6uIbC7z7R2ftJOUFTePFpasteMqhf1v36Ea+gLFofX
         HBFaBIDssBtuycRTrygOLW4xYQ6OeYhYXDx6ujz25ppl/LNRuE9isPHKrzqS+bUiILYD
         ghcrkrv+p/Mjp2PzdhPsOm0TEXgiG1QPCE3Wnz1Ac5MXafJLV+3RNxfPiu0z93ZqxU+t
         i4fNX1y8Scm4EAy9AZ04NZICwMGHOM+7eKmSEdACg1gv0DpyH3PQBK+/Esfidwdamibc
         Wjo23LOhqPiIgGDEhPw+bYAJH2fgcHOVT7I4MyPj5/o0w1fzvzM8uOUjimyyzOZOtPWt
         DjXg==
X-Received: by 10.140.106.163 with SMTP id e32mr13611qgf.7.1413025983514;
        Sat, 11 Oct 2014 04:13:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.40.232 with SMTP id x95ls1186507qgx.76.gmail; Sat, 11 Oct
 2014 04:13:03 -0700 (PDT)
X-Received: by 10.236.222.166 with SMTP id t36mr2602793yhp.24.1413025983061;
        Sat, 11 Oct 2014 04:13:03 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id fl6si825066qcb.0.2014.10.11.04.13.02
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 04:13:03 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MUTSJ-1Xm5oZ2Boh-00RHmy;
 Sat, 11 Oct 2014 13:12:32 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1410101252240.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:YHSW3GZwK/JHx+7Hka8WRjCZtSBtuWLbakpQwOk0rn+5xNqn1EH
 ZbdxLFiwzp3KZR0ZensAsXPlDByUbMa5cBLZhQWh0qsWP72sExtJ81CWhsF6mPWumBHAfLV
 uC/W2UagFv/B7kKettQC8F9VAPfiAgaJ9suqm/gu6YmojZPd4Xj+H8ud/vxuVCALlcG/MKP
 5sVSIwh0k7+20cw3yf82Q==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as
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

> On Fri, 10 Oct 2014, Johannes Schindelin wrote:
>=20
> > With this [mingw-w64] compiler, and the 'w64' branch from
> > https://github.com/dscho/git =E2=80=93 intended to be merged into
> > https://github.com/git-for-windows/git =E2=80=93 the following command-=
line
> > produces 64-bit Git:
> >=20
> > 	PATH=3D/path/to/unpacked/mingw-w64/mingw64/bin/:$PATH \
> > 	make \
> > 		CROSS_COMPILE=3Dx86_64-w64-mingw32- CC=3D'$(CROSS_COMPILE)gcc' \
> > 		AR=3Dar RC=3Dwindres \
> > 		NO_ICONV=3D1 NO_OPENSSL=3D1 NO_CURL=3D1 NEEDS_LIBICONV=3D USE_LIBPCRE=
=3D
> >=20
> > The test suite passes so far (still running, at the time of writing it =
is
> > going through t3404).
> [...]
>=20
> So I fear we have still a ways to go before Git works as a 64-bit Windows
> binary...

It seems to be not *all* that bad: only t3900, t3901, t4041, t4205, t4210,
t5100, t6006 and t7102 display test failures.

Ciao,
Dscho

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
