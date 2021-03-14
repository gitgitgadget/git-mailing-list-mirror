Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4FCC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 19:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA6164EB6
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 19:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCNTXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 15:23:23 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:4724 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhCNTXB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Mar 2021 15:23:01 -0400
X-Greylist: delayed 1855 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2021 15:23:01 EDT
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12EInowH074060
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 14:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=ccbeuYPg/iJ98IhmuGUHc2nJ8K314C6Hgv2kE2rLPxM=;
 b=dMmAqWPEazIMZ8TNjxP0D1cBTqC2q1dN8ScFB9N0l0mcQ3FjN3G/W5OHuk2Ys+W6npAz
 PsXC10ta/6bbUY5eqAYlAeo5+b7AMRd8Jc18KT8Mx/BEiQ3ZN6ATCCK09F91W50wbxQ7
 1zlBOCpD9bn+6GvtEk0qgqVloAJGU+yrVrnrQuRSkr3RCmxsH/ONW58l+R1/iPHM4fqx
 cXfdEmXpbZQY1+tpDuPuROHJIdBICF35jaDhSIddorC7mW/7zQqc39CeHZiKWm/x3XcY
 +3lQigZzuCy5MEbRiG4S9IWNrHW84Dfxa6cDraGg6w2an1JWdcnkatuIMojgHNR9d1Hy ew== 
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 379bv8qaga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 14:52:06 -0400
Received: by mail-il1-f197.google.com with SMTP id d15so6683024ila.10
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccbeuYPg/iJ98IhmuGUHc2nJ8K314C6Hgv2kE2rLPxM=;
        b=kNyRmdQeCfOAQR+UQgVDJFWOJ2fm3EUv+TgqxuHeCIkGMUs/htSSGe/80oxNLLIFw3
         yPj9R0tGQ2z5zctQufzM5dvibnIDXfjKOgENdCatRcnkQwKa/rZZb72RFniBOAK1TMmT
         9nVEf3EK0Y3CATKY9wI3K3gLpOY7nS745YAYHSLojjnPSKIv3atO3Uh61sOwSb3MrFRO
         WM/oEz8kbHVET/lpWxgdLjKevzM1x9yebUkGpZvLidnr28c7rIgldrN2H5msMFDXVph5
         fpSc3Ay460S0YaO+YUOPJTuY+QoPWcvAQzdu6pyzst4LUwNf4XlqGAAQOnYLYoPbNrDg
         8yLw==
X-Gm-Message-State: AOAM5308poF8ECWpI63UvKvZ4TEoAhptvliwuux5Y4Um4kQkdK2IolqF
        FVCZLMwier28Oea9zyKN4BtXuCnHqmZYKlAlCrGCYyt13VWWQLrTinIZDuBP7A7ujJ/q6UY+P0y
        snGlWtDkZbmI=
X-Received: by 2002:a05:6e02:d4e:: with SMTP id h14mr9117138ilj.80.1615747925393;
        Sun, 14 Mar 2021 11:52:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqBe6Q4IWGmqoDgdEYrLWgVi9hj2x/shzwVLLPBtCG5qndgC2eJ1EXu76WuQ6L0SzFn5QUWg==
X-Received: by 2002:a05:6e02:d4e:: with SMTP id h14mr9117131ilj.80.1615747925167;
        Sun, 14 Mar 2021 11:52:05 -0700 (PDT)
Received: from meme-cluster (69-174-157-65.symrinaa.metronetinc.net. [69.174.157.65])
        by smtp.gmail.com with ESMTPSA id i4sm6413769ila.70.2021.03.14.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:52:04 -0700 (PDT)
Date:   Sun, 14 Mar 2021 14:52:03 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Christian Strasser <christian@avr-fun.de>
Cc:     git@vger.kernel.org
Subject: Re: Git install crashed nearly whole System
Message-ID: <YE5bU18AExEHkwtX@meme-cluster>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B87UaZgGHwt2M2SA"
Content-Disposition: inline
In-Reply-To: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
X-Orig-IP: 209.85.166.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140144
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--B87UaZgGHwt2M2SA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

On Sun, Mar 14, 2021 at 07:23:40PM +0100, Christian Strasser wrote:
> Hello all,
>=20
> I installed Git yesterday on my system. For that I used =E2=80=9Csudo apt=
-get
> install git-all=E2=80=9D. =20

I'm not sure if this list is aware of this specific debian meta-package,
but this reads like a scary packaging mistake that needs fixing asap. I
think this would probably be sent to the Debian packager for git-all.
You can probably ask the people listed as uploaders in here[1]

> During the installation a lot of very important
> packages got removed! It was horrible, and I couldn=E2=80=99t use my gnome
> desktop environment at all! A lot off dependencies got lost!
> Fortunately, I could save my system through read out the information
> about removed packages from the apt history.
>=20
> Today I totally removed git and tried to install everything again with
> the same instruction. The same misbehavior did happen!=20
>=20
> For more information I added the history as an attachment to this
> email.=20
>=20
> Information about my system:
>=20
> Kernel          : Linux 4.19.0-14-amd64 (x86_64)
> Version         : #1 SMP Debian 4.19.171-2 (2021-01-30)
> C Library       : GNU C Library / (Debian GLIBC 2.28-10) 2.28
> Distribution    : Debian GNU/Linux 10 (buster)
>=20
> Gnome           : Version: 3.30.2-11~deb10u2 (apt-cache show gnome-
> shell  grep Version) -> 3.30.2
>=20
> Best regards,
> Christian

> ...
> Start-Date: 2021-03-13  19:10:24
> Remove: gnome-color-manager:amd64 (3.30.0-2), gnome-session:amd64 (3.30.1=
-2), gvfs-backends:amd64 (1.38.1-5), gnome-control-center:amd64 (1:3.30.3-2=
~deb10u1), chrome-gnome-shell:amd64 (10.1-5), rtkit:amd64 (0.11-6), gnome-s=
oftware:amd64 (3.30.6-5), gnome-settings-daemon:amd64 (3.30.2-3), network-m=
anager-gnome:amd64 (1.8.20-1.1), gnome-sushi:amd64 (3.30.0-2), gdm3:amd64 (=
3.30.2-3), network-manager:amd64 (1.14.6-2+deb10u1), packagekit-tools:amd64=
 (1.1.12-5), gnome-tweak-tool:amd64 (3.30.2-1), gnome-disk-utility:amd64 (3=
=2E30.2-3), gnome-tweaks:amd64 (3.30.2-1), gnome-music:amd64 (3.30.2-1), ud=
isks2:amd64 (2.8.1-4), gvfs-fuse:amd64 (1.38.1-5), nautilus:amd64 (3.30.5-2=
), gnome-shell-extension-dash-to-panel:amd64 (18-1), systemd-sysv:amd64 (24=
1-7~deb10u6), libpam-systemd:amd64=20

These last removals in particular look rather bad, but I don't see how
they could be triggered by downloading git-all. Are you sure this only
happens when you run apt install git-all?

Cheers!
-Santiago

[1] https://tracker.debian.org/pkg/git

--B87UaZgGHwt2M2SA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAmBOW04ACgkQRo8SLOgW
IpUXOw/6AkOWKrHss0p1WkMrXhV071jLdK5FH1DyEnE5DHSaqM7MUlZQpD4jampk
LxC3v3XMPrZOtSag/VaGlcw2DTdBg3dq3UhOZH6xHE2mq5ndUjJ/KQonLQvCbE51
BNrURCpOKrHRu75oeWKxYR2BM6vLkdfazTyJ1uDm81ORK3i0ZC02vxXDQ5WEdC2+
LNej30xqzn5dsURq/SjIBmytnu5XZyEinueBHgwI/2BfAae4A0Ji0Rdx54sJK4m1
4BPfOTl6Za2OLE0Gp5FkAZpTL5MEnjLleG52BI/YZsUwonbqu2bQA5jLmeYHkx5e
46oHWyaVy2eMH8InUu22BEyQmFTalliAhYkFl8ZZ3X7VvfM2DAbLWyCUfjVnN4TM
y2lgZVoPuuMQivufKl5gBB8u/GB6ipbRjhInxzpa6PC+QAIj0AUuEnuc36VacziU
J5SKw+Xr5bPGtNC1jBMW25ILLgxX00MAujUQmbrJ3cnnE1xx5vVUu298vr97YE+V
sHD2AnKCFiIvlyGqQ2/XXPxTbq88BL9cYWYRCJ5/vG+8MsTAzFjoMs11hOkk/EhZ
C73qnsxONy/iE5ZcUXA8F4Ngu8YsuLwTDgZG3v8NDPDZSvDsm4oJwinf4Wj01TKh
k4DyJMwxKOkjIq3eNWavh/2t8sqBI3ERACM1qnhPT/JGthsoy7g=
=NKFU
-----END PGP SIGNATURE-----

--B87UaZgGHwt2M2SA--
