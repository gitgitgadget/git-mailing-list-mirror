Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FC11F453
	for <e@80x24.org>; Sun, 10 Feb 2019 22:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfBJW7F (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 17:59:05 -0500
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:58248 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbfBJW7E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Feb 2019 17:59:04 -0500
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2019 17:59:04 EST
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1AMmFoe013751
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 17:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=H0nppfCqYkgrlZJi0YdikcXxY86M54/hy4GZRKgg1gM=;
 b=KpDktI2b6rt0VBgnofBIdaHzwdvtx1tDZXz1CmNF/lv4Le2CMhkoubUqMLsVcEtTyMVB
 m582FLGde1YBmeEWMnTR6om+vYfXLt1VclpMkiWaBVBpG1YZb+gJ58erSo6+2b7ExYY3
 22VIBitmRNa/6zrPKRSXGQpnXi8uMt/LMU7GjVRwVZXDRl+RGzRw/vuQc316iiZWpcHD
 jtnA1iFP52FRyeo5Yl65ClfokuVdkCbGVtmn0p/3flOkqb6FP622fXUnDB4dzcHJyNqA
 19kfC/xuXxzcid94RhkVUhYE5dExbwEDewTMspw6/l7rxFiipfcIeAcYbzn+qOIxWBcn hQ== 
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mx0b-00256a01.pphosted.com with ESMTP id 2qjv28rm66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 17:48:15 -0500
Received: by mail-qk1-f199.google.com with SMTP id v67so10215645qkl.22
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 14:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H0nppfCqYkgrlZJi0YdikcXxY86M54/hy4GZRKgg1gM=;
        b=A1Wk+tRB7ZZ5rBSzGpwQlzF7uSxG9q2VR5CITXOVqB9nAoArAchAEgM1JKYYpvbpPQ
         2yloX2ouB51tyWvq3Yw79qPYZlrpklA2gJl2rgtPkUo6fVzProWw8m7oRNcfotNu63hH
         SSX8Ds4t/HcedZiToNBntjfXeDN7pCO14dGc3PhfrAc+SskSxJhnbdYD7OKkCGJ+GfMm
         Hne2RZPjzDHGEGV1L9IGzjtGN8EaxKUeV2JyzndkKd5k1aaFTQzcrwIH1srWpHcdCfE5
         wBlp5ycKfvyMNeVd+Em8YfhtfXWyZfx+wKuMhtkJ6IIa/Fn/hDswyoOp6XqRbngmKObz
         sGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H0nppfCqYkgrlZJi0YdikcXxY86M54/hy4GZRKgg1gM=;
        b=KEVc/xOyKjYPu/BDl2dEqxFCxy8ARBEcYfWlEYeGt1EvuZD5BKD4s6k6uZfwfaJUiK
         BdSo913Ox8SbGXS0INrxYg0ZNcms+2qy+aVVE3hKEYvliGgugHG3ygUQYe6PG5nLzguh
         2heO5TON8qWzBrFD9vJ6wceY4WZa3SbR+OM22o2GehPn0V9/yGMr32Gjq9zrdspNQeav
         We8Ux6bK6xbcrQR/MjfOIvq1YFy/suRq423P4CEv9c78r7PG0aJaZ4Fiyouw61BoTNnR
         04bHUdVfucR7Rmsu+Ubuetubo3j57SbYlzsPFcN7/N/Y9FoHYzLIVc1sQyz4dSTfhg+o
         zpng==
X-Gm-Message-State: AHQUAuYM5CEViTfmmBQrc5fwm2MPqjWJJAt2Dt49/9JDukJozjebtM6P
        gEjb7u1RLQ2S7uqMNkp+W1T0JPQskokTCCHMUZEn1vpB90n8W78Ws+ueqdgGawv1OP8KCwzr3J8
        xjD1Fe+78h6Q=
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr25857048qtn.107.1549838894146;
        Sun, 10 Feb 2019 14:48:14 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYHdPosuP4T3z4rb1NbYBW6s+0S6R0SaVCYez/7tN2Y9mYcroW8WLqmVeJv3AUEBL/EXRXelw==
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr25857042qtn.107.1549838894021;
        Sun, 10 Feb 2019 14:48:14 -0800 (PST)
Received: from LykOS.localdomain (cpe-68-173-125-182.nyc.res.rr.com. [68.173.125.182])
        by smtp.gmail.com with ESMTPSA id r20sm4316142qtp.68.2019.02.10.14.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 14:48:13 -0800 (PST)
Date:   Sun, 10 Feb 2019 17:48:12 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Am a newby and I cannot compile git
Message-ID: <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
References: <1549835814.5977.11.camel@libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmdm4nlun6lei6q3"
Content-Disposition: inline
In-Reply-To: <1549835814.5977.11.camel@libero.it>
X-Orig-IP: 209.85.222.199
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=724 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902100174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wmdm4nlun6lei6q3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It'd be difficult to debug without more context:

Do you mind sharing your build log and more informationa about your
setup? (e.g., what OS are you running, what packages are installed, how
did you get the git sources, etc.)

Thanks,
-Santiago.

On Sun, Feb 10, 2019 at 10:56:54PM +0100, Fabio Aiuto wrote:
> Hello again my problem is that I cannot compile git.
> The error message says:
>=20
> 	Type'z_stream' could not be resolved
>=20
> I don't know why, because I installed the package zlib1g-dev and in the
> header file zlib.h this structure is declared. Help me!!!
> Fabio.

--wmdm4nlun6lei6q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlxgqisACgkQRo8SLOgW
IpUF7w//ZreyI4bQcnR/dpDav5As7/hIpi8x5e1zOjAzkyCwnOo9oDkE1wBTLB10
0qdFr5YmsxHdwZs7f2zBOIXdI4RbYWg336bmONGcV+Cvaq8IebmKf5barqWQn7+G
AUCC2vl74CV4oQJRXr4lBAqf1sknEod/b3pChkWHM/lHpHwLPZFHftMdk5s/ud70
nxmQeYUC1ZcbwpkTPRig2Xm//twEcfHKuRQkj3miWBYuvF4R27feL2R3Z8F2NPTY
q0Am6v7jv/vjqDJV7mtwiu+WZwzbInrIz2INftEqPPvU1wZTKuuCa/mPbb5TyK0A
lgpd3OkoAW4s388jFGW/bTVtm6Lc7+rnBfA4UWlOdfqi9v7HQsLwcmlcSt384o+X
k3Rt9xNZUHQp7KS++fffCtvqfsSY4ZR7OSDvDwvwkUApkz1hN1IwLGYdDR8PKkQd
x0pzeSwoDVkFqqiDpQAcy49wRwc7vdh5Y3YdgSnbLftEJhdKC/i4n24CpuG4261x
t2bcM2aTlMug0naZImhgXLR0Wnk87Vcc5VpUcXXH3ts2DOuEwThGhLuLN6P7ltCL
lk9Wz4jBHeVK7IXb7VVgZLy+rGkL/yLd9odoGgVWQvnjTJlsAbB8r7A2sywW/5Se
h6fTiCF6Id0/NyQ54GppSZpIrwpxFfQqOxLpFxgnRIAjaV/rrhU=
=lTsb
-----END PGP SIGNATURE-----

--wmdm4nlun6lei6q3--
