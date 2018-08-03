Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61D71F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeHCRkk (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:40:40 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:44958 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727171AbeHCRkj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 13:40:39 -0400
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73FgbZ2193723
        for <git@vger.kernel.org>; Fri, 3 Aug 2018 11:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=t05+0v3qG3ujHIWbwLU31PiGUwuU7PLKrPMQAaeiLrg=;
 b=nu+I7SCU1nJ659lUpwGRCs9iEFztCjquVDrZwhWEn6KTtkjaDrQ/TaDF1FF4eAKsAjFA
 4SYz947uJYiWzZAIziosBqhBXYI5JBZHm5wKLUVOY0JgFbRLLGh+jCLGaBxERBUofNoN
 xp7nej3rw3+drdI4sFz/Rqggg4s2mGcheo0JQ3rEPhqG46O1/U2BT6LAzL9XmtZiE/an
 Rk5ymdFNW/kwkYq+/leR/hfKQvzdyEoc3qtLIngwA31iUUJISqoB+cCun+4QZhzx04e+
 MBDWGUmKOYhHbG6sV4ymkCIBIvNKdG2IroaVLwLmU9wuWUDLE2OHCMO0wEq9Qod8Chcc Gw== 
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 2km6hgkh4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 11:43:46 -0400
Received: by mail-qt0-f197.google.com with SMTP id b7-v6so4581262qtp.14
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t05+0v3qG3ujHIWbwLU31PiGUwuU7PLKrPMQAaeiLrg=;
        b=JUFOiYQjyya+4XERT2QwGt5Net0VlXSX3wJ5MxOIBJusF69Qt4a5RezPG/9wQLz9Tu
         pUhleO3yye8xS0KVXmj/JaFXOPogxXu0NTl9t2KgwfzrF3ttmN9ecm9vZHF2Lz8CbcAk
         V0LMfyzCgi8A7LDBM+H/EHqCJymA0bAMBAQ1yBJx4CJYGT/skio1YvPlG7mH2oxhdzMo
         2klh37xo04hfj2j6QCQy3645YjwgSD67X5lNB05s20orJn2wEjlkXJE27QeSz2H4ww7r
         U7zFU8TejNxUYr9VD92jpxZ0THBDFA8D7H29xDf2PPSNgKn4+0JGZIs0JXvknZMpvtUS
         a/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t05+0v3qG3ujHIWbwLU31PiGUwuU7PLKrPMQAaeiLrg=;
        b=W01Xlf/g+Uk6XijCDypFBaFeGPhLLnQKYnePILCN5caKJ7C7vzxFFNSueUSgR72qde
         49buJyKsS35HcoqDPwrUofuE594zYJ00RpLjFVRtFu4tyhSE8B6GjdZq7CcsG5RU8ScM
         UkoWehRw5m8sgA6sGg8zva7zxZrL+h6Wk0zGT0BYyzc5Tkyel49QmQIWdZpmuEe6ewX5
         zyYuB7L6FR86wYzx+6io1Uf7NOksp3YWQJxNfnR3ged60K1DTDRz+OYzpHpvYhT6ajY6
         jxOL27/l0Nt8ZSjE7bbsuYM+/Rkb8OGjM+vin3WwxybLIxCLZEhwbQ2P0QcKMMGXw/Kl
         ZusA==
X-Gm-Message-State: AOUpUlFLaQQOSS3xCqvCbQKNIUTAzOP1z0JwfXnWEdgS8mvYF8PnkApx
        ehhOAj4hcw7DK5GZyrOKBPxGF0REhZ9TYHWFv3tVKcTvhnC4P+G3Am29ARW5fyu6t0yqY9STpPg
        Z5N301JVp++c=
X-Received: by 2002:ac8:2672:: with SMTP id v47-v6mr4411753qtv.287.1533311025444;
        Fri, 03 Aug 2018 08:43:45 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpdEl956gcOEYMGvEnlTq9hbWTfoKGWeF3aUczZi5dIIIX2tEie9zXWkhvcGk9SgLKurU9xmEQ==
X-Received: by 2002:ac8:2672:: with SMTP id v47-v6mr4411739qtv.287.1533311025275;
        Fri, 03 Aug 2018 08:43:45 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-134.NATPOOL.NYU.EDU. [216.165.95.134])
        by smtp.gmail.com with ESMTPSA id d71-v6sm3631173qke.57.2018.08.03.08.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 08:43:44 -0700 (PDT)
Date:   Fri, 3 Aug 2018 11:43:44 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3fjiwdp6jkwfk6ez"
Content-Disposition: inline
In-Reply-To: <20180803133630.32oxubwttealvhxk@work-pc>
X-Orig-IP: 209.85.216.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=565 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3fjiwdp6jkwfk6ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > disable fetching keys from hkp servers. This way signature verification
> > should fail.
> >=20
> > Thanks,
> > -Santiago.
>=20
> This is not a deviation. GPG correctly recognizes difference between trus=
ted,
> untrusted and unknown levels. git on the other hand does not. Well it did=
 until
> the commit a4cc18f29. That one removed GPG exit code propagation.

Oh wow. Sorry my assumption parted from looking at the code back in the
day where this happens. I assumed git was quietly propagating the gpg
error code and took it from there.=20

Now that I think about it though, verify tag can verify more than one
tag. I assume that this would make it difficult to propagate individual
errors in trusting. I honestly don't know what's the best way to modify
this behavior then.

Thanks,
-Santiago

--3fjiwdp6jkwfk6ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAltkeC4ACgkQRo8SLOgW
IpWzHBAA2PkBgikvrCgCCvB2uPCnPMn0+qCpwPDH/+XFSSQjod2XRzFXRdw1wicK
mrUiGgFF5TEjFK+/LmtSoW7z67asYe9NMFvWQcineQvJoU3hWMxdjz43QHpU3qyb
KOwQJwcdsw6wBV+WVAC/FPRy9H6ShyJ0Zk20te0s+pmYHpwClUR9McUgNHVvoCFT
hQKC+JMXKv9ay7v/YtdtnHtKgWHxEbIP90pNt77V7RVFvlnNAuHmuzjyUzvQm2km
6fhu0Dz3AnLfQCA9bki1Gq7qXsDHWNAXH43d52XHB5U8kpN2lUxZhOB5FNlZ8b8i
Csf4AIHObT9rVgt+Sy7ysZegRdoyBPiMrWLMauMMweXhcVYNxJUEAMtVf8dBWOKt
S5y6FpH7lv+Xmx0rYGvksQN447eMCndzx1UJp8ngVEOENminjTkHDl6iCXtmsrfN
kfpVY82X4YK7dXJdZ72bB9aM3aa4YYPgBxdv4mKth3h9eP4Iw25FUJexsWfko/FL
AgaMWsbHUhcY1UDtSeEUfQjKWWcmJI9WLaEUFxgZnrWncyi/BIqOuBrCu1OgSYI6
be1wwklNLP7oEu4566Yw3ykYoC/+Io4bLgswPuqS3mBQLTz9whJ4c+MFFCs6w7NE
kmZrCs199kWCYKJLZr5kZIyrq6kVi2kMH5vBlHPiKwMcnC32CMY=
=uIax
-----END PGP SIGNATURE-----

--3fjiwdp6jkwfk6ez--
