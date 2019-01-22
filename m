Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BDE61F453
	for <e@80x24.org>; Tue, 22 Jan 2019 16:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfAVQE4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 11:04:56 -0500
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:54532 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728952AbfAVQE4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 Jan 2019 11:04:56 -0500
X-Greylist: delayed 808 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 11:04:55 EST
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MFoilf079683
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=QlVM+k129grNdUMnJGcNzWFdYnxlFMdskCm+qlSHvrk=;
 b=Tad3wihDaD33FLRvIVFGTHCVUWgKoBuvLj6zI3PqdfgGZNn9mqL0WXZEo9gROBb4lGVr
 AOL44joAgGCSzMyrB7tCafJuKWVPjn9U4mdxf60mV4fpnFzB3eTZjzC/MtiZ3MR83IEQ
 cmbK0S+/hZTa9u9y/TDB9JQz81G4pSXjOYJRy1IVDthpTP7SKeQzVucHttxznKEQE5wN
 Nw3lckMudGn6Z9gEmpllcbdLvYcWkROsW4nRKYlGui5JTtRvJef7xTLqVSuNzVWBII7g
 uDBsWqI9Q/73GlurEu5P/xZaILodEdxaL9KKP9pM3dT10ei9VkogHPU7nwqYK9ae2L4t tA== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 2q5m7rubtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:51:26 -0500
Received: by mail-qt1-f197.google.com with SMTP id w19so24966580qto.13
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QlVM+k129grNdUMnJGcNzWFdYnxlFMdskCm+qlSHvrk=;
        b=YXsNR02uiOB5ZrM3AQhbSqd5zlBeQII+gMF2tH5uBVe5jPpu8bQWBUYJN5QAl/WrEP
         6VUvJS7KS3En+epsGjOyye8o9rVWtl5kwdzqBDCL62HfWRWlyfGSONxxR0d0YDfuP9Xc
         ZaVZflCq3CgOfqec6u1kVadbJPUO3sgArMuQvajZM2f5BThr4YB6F/ivMUWznDmRk+rL
         2Q2iNH6imvZCOM8rrvOciHjGUWFsfzNmSB15guKuKL3nieC1O+puQuNPTSjoaOfBanU3
         wnKM6xl8nR57bPeb8/OLNTF9Sog1+7bfIsBeULObJJj/ejmlrVPn8Mtoogw4WPPj8v5+
         CkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QlVM+k129grNdUMnJGcNzWFdYnxlFMdskCm+qlSHvrk=;
        b=nEmY5V/T1Wj6sf2yIVQLxj4hn1vAVHEwK9H0C59DWJCBDpWaOgfRT1K7zt7rQMvW1T
         4wbbWWkeEVGmteylmIuEh47j+IzlRqAOUG2LR21j5NMvHoVG/WAHgxIhNbq2o/Z7zcrA
         nkCPqgwXqtnTI+hIYtghIw0tsE2TWQgCyi5OXkdV5weNZ2i+6r/9c1uPcRQ6RoWZrjd1
         l1n98otc1EfLm2FbGeH4axNcvoYKAFASJcj1G6VaRBPrFili4fw2FQHCEW4Vaxnk7wv0
         772qtmY8m0qBjk0fgtwWvaIgK01VNxt2Su5h39qMEXc54lsKCKsIlec9wbpY+TMgHx8Q
         ozPQ==
X-Gm-Message-State: AJcUukeb3Xa8IhboD2/7LZaooEVWh803lYeeEYj79Ditm2n99fNHs7yj
        74vpksvmSdwdxOV7S5YDGX1UXtE9ETdadVd9RC+sSQZoAUgdnHU/+ltG9I/micsSDOlfrUc9Gws
        1JJGhDCJRPLs=
X-Received: by 2002:a37:6f85:: with SMTP id k127mr28112267qkc.240.1548172286344;
        Tue, 22 Jan 2019 07:51:26 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4nhdwPF8dZt+LzxCttmAkAgyoIMgarWIoDLTsIUtnODLrrwHtLzAc4OXh6o8X8ra33J8RCHw==
X-Received: by 2002:a37:6f85:: with SMTP id k127mr28112255qkc.240.1548172286149;
        Tue, 22 Jan 2019 07:51:26 -0800 (PST)
Received: from LykOS.localdomain ([2607:f600:1006:3503:42ae:d7ca:88e1:26ff])
        by smtp.gmail.com with ESMTPSA id n3sm70730158qtc.81.2019.01.22.07.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 07:51:26 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:51:25 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Ralph Martin <MartinRR@cardiff.ac.uk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Improved Error Message
Message-ID: <20190122155125.6dtajiccvtscrnf4@LykOS.localdomain>
References: <EE441A47-48F0-46F3-BF28-C22FDC20169B@cardiff.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32gqotnosrtbwkpd"
Content-Disposition: inline
In-Reply-To: <EE441A47-48F0-46F3-BF28-C22FDC20169B@cardiff.ac.uk>
X-Orig-IP: 209.85.160.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220123
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--32gqotnosrtbwkpd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Ralph.

This feels like an issue of how homebrew relays information rather than
with git:

    santiago at ~ =E2=9C=94 git clone nonexistent
    fatal: repository 'nonexistent' does not exist
    santiago at ~ =E2=9C=97 git clone https://nonexistent.git
    Cloning into 'nonexistent'...
    fatal: unable to access 'https://nonexistent.git/': Could not resolve h=
ost: nonexistent.git

However, it appears that the error is not that the repository is not
found, but rather that the way that the server is set up.=20

If you'd like to debug the issue you may want to take at the GIT_TRACE
environment variables. Likewise, cask-repair could relay contextual
information when the error is found (i.e., where was it trying to
clone), rather than just transparently relaying stderr.

Cheers!
-Santiago.


On Tue, Jan 22, 2019 at 10:11:03AM +0000, Ralph Martin wrote:
> While using cask-repair -d from homebrew, I got multiple messages of the =
form
>=20
> ERROR: Repository not found.
> fatal: Could not read from remote repository.
>=20
>=20
> The author of that command tells me these were issued by git.
> Unfortunately, they are rather unhelpful, as they do not tell the user wh=
ich repository has not been found.
> Could they please be improved to include the name of the repository which=
 could not be found?

--32gqotnosrtbwkpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlxHO/wACgkQRo8SLOgW
IpWklxAA18atyGUOcvEuUzj2MC5urBCJQJQaclx+YJ8dhzWwMVZbl/LiK0B15IF5
VmJ+As9ZOP5pnMcdn/RUELuFWBLa6o2nXN4aUg9/djVsTCpIumjputkXmZIDu9tb
qv8e+CZ9QeE/J8LS4KrSm/izxwYQpmo3WJM6k3BLeovTaNWfLzeCESfUoC1irBNX
VPAvrZjBa18QmbVE2eS37/eBro88g79IGOHtxHauec4h4lzQmhwOwX3LXlCey5vs
UjF2oHDLvirK/AZzcTlshZLJ2DhbpSa5woblQhT/o/crPAs3tqCPkIlthIXiO8A4
Iz932X7esHvJdG60FTGsg4Jr0t4WmdMDYJvhDSbplO1N6PvuqBeR0AKIW7Wqis6e
knDyTefJcEBgoDo2nj3ZO65QtA/vUHCwkSkL8m0huRjGGQmxMPU4Pj2GliG4FK1i
/bkedlBgX8RPUQZN3IQ9Q9p0F7DOdEEH9OLFjw7Nx7KDi0Ad+JJgShtCD0aP69bT
UzvosKjEG57v7htoU1AdxQTVVhV5u/xlBs5KIj19MKtGJijEsxwfeJP3x3mfZ5vL
bLwz9YlaFlGObLv2+vez18LTGugp9263aW2NAN35Y5MJniomG1hpQpa4fESRDvE7
VUhwHglxq8O/ihB3jtxnwizVO6OwpYQSCydIKK5NdIr+r95EF5Q=
=5S5o
-----END PGP SIGNATURE-----

--32gqotnosrtbwkpd--
