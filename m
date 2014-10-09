From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Thu, 9 Oct 2014 21:22:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-8-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, msysGit <msysgit@googlegroups.com>, 
    Ray Donnelly <mingw.android@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRB3WA3OQQKGQERUJXT6Q@googlegroups.com Thu Oct 09 21:22:25 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB3WA3OQQKGQERUJXT6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f56.google.com ([74.125.83.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB3WA3OQQKGQERUJXT6Q@googlegroups.com>)
	id 1XcJI7-0001E1-Il
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 21:22:23 +0200
Received: by mail-ee0-f56.google.com with SMTP id e49sf194568eek.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=pHqtLwmKyWvNxKEtblI09H3MbBAdmV3NJWeV+jyIUbs=;
        b=pX9I8DRqRlsKWMqB53Vn9ufzhEorEtZKS2oNCVeVzmBiDXoIena6kHcarbM4q/ZU6r
         RSIe/TUoYVkyEHoiH9+godEE2mD3rQJY9aPLadowZ8l214CaFo7RWaewEeIcjmq8vohI
         wH/XlQD2waWrhxifTw2d8DXatrwd+gezte3lhbu7pGIfcY4b7o+IoyZmg7ameHjOjLot
         FiRjYa7MSRrDGoiwK/lvlTjCFG+OU7o3O7wqJZ8s89uVSuHMNsFd1AfXm4cozUq/wXzd
         cIA8pMEcHQ0zoAFCAfmz5BX8q6HFoe6sodfLHOU42qYYrAROho0EL9sQ4IUfE1CKEyM2
         Hsdg==
X-Received: by 10.180.107.99 with SMTP id hb3mr1853wib.13.1412882543275;
        Thu, 09 Oct 2014 12:22:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.126.104 with SMTP id mx8ls8198wib.38.canary; Thu, 09 Oct
 2014 12:22:22 -0700 (PDT)
X-Received: by 10.180.109.67 with SMTP id hq3mr1162530wib.1.1412882542552;
        Thu, 09 Oct 2014 12:22:22 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id us10si653542lbc.1.2014.10.09.12.22.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 12:22:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MNIO5-1XaPcD32HB-006sse;
 Thu, 09 Oct 2014 21:22:20 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1412791267-13356-8-git-send-email-marat@slonopotamus.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:haJAyY+Wk5BkK+6RHup8EiT2RVW/2Sf7A6YHp/hPFMsvtJHxoUb
 BrZWStlqzuidQB/FaZQSWEiakX7t0hJB9FVw24E3kDuxxjqZMaG4UPOhB9P4kh4gdUpxDTG
 qzXJ6cFIABOgeESwEl3hDqtaizwJbnkJDC/C6ojwOjeqmUC3GKprTapHKPltTAY/F/tzDsZ
 tFORbiSVkcmgAUaRkgjRg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
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

On Wed, 8 Oct 2014, Marat Radchenko wrote:

> +CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo not')

There is a rather huge problem with that. The latest mingw-w64 release,
4.9.1, does not do what you expect here: while '.../mingw32/bin/gcc -m32
-o 32.exe test.c' and '.../mingw32/bin/gcc -m64 -o 64.exe test.c' work
fine, producing i686 and x86_64 executables respectively,
'.../mingw32/bin/gcc -dumpmachine' prints i686-w64-mingw32 *always*, even
when specifying the -m64 option.

So unfortunately, the test introduced by this patch (intended to figure
out whether the build targets i686, and skip a compiler and a linker
option otherwise) is incorrect.

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
