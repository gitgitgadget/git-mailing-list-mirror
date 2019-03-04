Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48ECA20248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCDUXG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:23:06 -0500
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:36866 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbfCDUXF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Mar 2019 15:23:05 -0500
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24KLLpP103149
        for <git@vger.kernel.org>; Mon, 4 Mar 2019 15:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=n+6r9okvnDwjnXks1Ncad6Qg8sfs8gkO/eGwXnmsyu4=;
 b=gi2aGA/thOyBnbf8Rxj3tJQLXabZnlgqal7srtGMvH0mOos0JGCtNSqnTUSFKCVwtz1v
 UuiJ5KUEYkwlSargYxigmtmiGIMfEhzHnr538Kq7CBToHiKqnxlz28Em6UpS47sMXCv+
 UMSGGO75gvKGixaKdFI1cJoNbtHPdlH08ROzCTEN+ZJDIDtKYPO6+hQD5dmWfKy0tuPE
 9pNflANRpnjUFTGcr3e6SZrJSiCxwwoElYQbVwJbYU4m5U0IF7hhtDIZIptpPve3eQ2/
 6fAW039J5ajxf4mJ5TwXWg39hDvYMN9rHcbwNVWYUOs4v8pF/jYE/TtQKYXrBBcgjfwb /g== 
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by mx0b-00256a01.pphosted.com with ESMTP id 2r145m7v12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 15:23:04 -0500
Received: by mail-ot1-f71.google.com with SMTP id i5so2432723otl.12
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 12:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+6r9okvnDwjnXks1Ncad6Qg8sfs8gkO/eGwXnmsyu4=;
        b=SGuwtj4PENzXmT2u2yVBbJSyLwjAQr4W2d/a6b03Y4L585vRRyMLT4XwmTrtvx02xs
         2xZP7N6MViWPWn0GMp0gH3rKNnza6Pol4Wi9wf0UjdFTjFBzPwR4JCmKqgc1Dm6RVMUb
         gO1KCdR5wSpALC69YmRuIEWjhY6MKdg0lBmANtdInOdm08nyyS7SKgz/zthWpXUG19fk
         glj9DeZYajLTWhEVrEwjrA299Jg9/oY7wPRjJ4D9TtAxFj3nMeTnIQRPFBOcSuXaGFJK
         an41J3m4xYoCazKxlEuxcSzqfVsjZgLnVkycFbgcGfphW/Uo0XcTTAMNEgzKyFPWIXGs
         JMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+6r9okvnDwjnXks1Ncad6Qg8sfs8gkO/eGwXnmsyu4=;
        b=RKpm9pzNuj+xmbyQ9gBuIyBPUKJsDUx2fB2EZ56Z9CRQc055wM0Gom5Toi0+molSzT
         Y//43OiqbC/a1tc1+exOxDrl4wxucSVOS9Stw9PUsC18Quu9D9NR8MxK4r0ktoAE0+BH
         fiSDQbSmI0IdZN4Y6eWrKQ8/3vPYJLrHHbt1LPPByQCtlUwa3D4hkCL06gfv30hDeo+t
         OVGBGFjF/dqYeoHBzns3puDxlI/MgMfBM6MonacJm/l9DhoEsEhfSd6uuT5Zytq3vLxi
         XnaxzIZwspp+/s3KK5tsvs+raTcOKLLajf/P0vglqNtO/kRyucaGhczmVmi+y73IboLl
         e1Zw==
X-Gm-Message-State: APjAAAXp1Hrr/tXoLeYk7FPydM3Ak+kWipasFmOcdp0DXCOYvUvdEc+p
        fsGEmA5apS3Kwtmmrb7V5YEDTyDv3l/vEOft1z106DdmeHKPUwMpX1xXWvNpCSNdHg9aFvIT7cx
        VgzmJMkatzrk=
X-Received: by 2002:a9d:7cca:: with SMTP id r10mr14021696otn.81.1551730983568;
        Mon, 04 Mar 2019 12:23:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSr4YtdGI/uNbeujANtMP35N4vlbeSJ8aZHlaA100CyGpuiYhReZVqhSueoXF8UTklq/zxPg==
X-Received: by 2002:a9d:7cca:: with SMTP id r10mr14021680otn.81.1551730983338;
        Mon, 04 Mar 2019 12:23:03 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-141.natpool.nyu.edu. [216.165.95.141])
        by smtp.gmail.com with ESMTPSA id y19sm2602802oih.42.2019.03.04.12.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 12:23:00 -0800 (PST)
Date:   Mon, 4 Mar 2019 15:22:59 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190304202258.ywnnzd4zaay5q7z4@LykOS.localdomain>
References: <1551729517.4092.1.camel@libero.it>
 <20190304201011.j7dopqp6ug66ccum@LykOS.localdomain>
 <1551730792.4573.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uyi5gejxgsnkkd25"
Content-Disposition: inline
In-Reply-To: <1551730792.4573.1.camel@libero.it>
X-Orig-IP: 209.85.210.71
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uyi5gejxgsnkkd25
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It happens.=20

Something that I liked playing with to get myself a better handle of how
git works is using libgit2 and its python bindings. I find the codebase
a little bit smaller and its bindings to higher-level languages can help
you abstract the memory management and other low-level stuff that is
sometimes distracting.

Good luck!
-Santiago.


On Mon, Mar 04, 2019 at 09:19:52PM +0100, Fabio Aiuto wrote:
> What a pity, It would have been very useful for me, to debug around
> that simple version, to understand how everithing works.
> Thank you Santiago.
> Fabio.
> Il giorno lun, 04/03/2019 alle 15.10 -0500, Santiago Torres ha scritto:
> > This commit is about 14 years old:
> >=20
> > =A0=A0=A0=A0Date:=A0=A0=A0Thu Apr 7 15:13:13 2005 -0700
> >=20
> > Unless you have a toolchain from around that time, I'd be very
> > surprised
> > if things build. Notably, there you're having an issue with the
> > symbols
> > that lssl is exposing (I suspect you're not even using the openssl
> > 1.0.0
> > series anymore.
> >=20
> > Thanks,
> > -Santiago.
> >=20
> > On Mon, Mar 04, 2019 at 08:58:37PM +0100, Fabio Aiuto wrote:
> > > Hi to all,
> > >=20
> > > I'm trying to build first commit of git made by Linus. I mean the
> > > one
> > > named e83c5163316f89bfbde7d9ab23... (I think this is enough).
> > > But at building stage i have the following error:
> > >=20
> > > make all=A0
> > > gcc -g -o update-cache update-cache.o read-cache.o -lssl
> > > /usr/bin/ld: update-cache.o: undefined reference to symbol
> > > 'SHA1_Update@@OPENSSL_1_1_0'
> > > //usr/lib/i386-linux-gnu/libcrypto.so.1.1: error adding symbols:
> > > DSO
> > > missing from command line
> > > collect2: error: ld returned 1 exit status
> > > make: *** [update-cache] Errore 1
> > > Makefile:16: set di istruzioni per l'obiettivo "update-cache" non
> > > riuscito
> > >=20
> > > I run a debian stretch on my machine. Could anyone help me?
> > > Thanks in advance.
> > > Fabio.
> > >=20

--uyi5gejxgsnkkd25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlx9iSIACgkQRo8SLOgW
IpV7RBAAnN6cOQ9qwwGd4fI2R3B1tTgTpjDS71AETqteg3JzocZ5P7S8XxnNR8qb
3VTaR6tO0du3H5r2StWhCoTwg69rCRXmDiCx5OluLVNsr7YoDeh9kzR7AdksdI5V
fmO1B4T7p+kxXxwGTaO7dmoWwFO+K+mtw8O//jP2v76ASvPzaWIK41AM0h4NUq+v
uwkKZPSTnWh60qVZOLEvRG0pKd/pzqCeMfGBdCsYCkGOm0Agb4OvDpgncz51LBGc
e5eFvsmRyGhEVyQh3MaatzfBaoQzaM/T4lknsIzMk8j4EE38ce+wSDdvm7LIfoF9
WYrfavqZVYZ8pGJPl1P4blvIUqe9VFi8HCybfkxy2Pm3PEy7blATt4c9hAHR+nkB
PYQgLeOROwl9QjHWapd/nVmCj2qDKcfr8LuF6ezognjvMTG54AWwFrCkevA41h6u
EO8hjYxI+fNxmPEVpBcUl+cX5sHcOA4vafetciJY4t/NGWOT5HgkCSX4pMC5i5Vo
x62gEM7cbzu0upx/6RKIlMN2wI32nPjMnplzR7njJoz9syi+zq3RTpW5KZBJ+5TX
21euqZZeG+4o0j3aRXRVgO/9YYKqgCAfHjbqD4EiSktDL17WhrdMfkbWrxqYFUuM
wRcY+Rin9g5rFlIBTyziUrLXicZY8gsQ/HMpVeCMuMAofWQHPiA=
=C0iF
-----END PGP SIGNATURE-----

--uyi5gejxgsnkkd25--
