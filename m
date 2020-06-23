Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E541C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2152053B
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MGRzViVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgFWBF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:05:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732124AbgFWBF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 21:05:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E453C60459;
        Tue, 23 Jun 2020 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592874326;
        bh=RnrF52cPy3rTQiV/XyVMTTBJfPMPUisp6RTxXRrMTEw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MGRzViVwZHeQjjj5cvG1GLozFx4Jg6rS1FisYmWgrD7xbtBoq38I6vu9aXwmsV7Yh
         TqOCPBncyBZ+Yr6DqaWLrZUT+itOfxJzk8i9zI5GV6jTpZpRmpp0eCj9KI/uoCHChk
         BhVS3PVRaYvvsfeZqrQAV7OUZs2Q3z6SJN/m0qoVtbvgCt9mOzI4S+qX64rSUZx8Ub
         S5x16nJCLT8ZB2DpGD69d3Tr/clI+NYUc4cUGB9NnaFjKYqkJxqBWulhLkt60zWSmf
         9vsdGRukdO/1Tp67NzQvGH/yKqgCfbfK0Aj2I86rfk+sh0uCd14NyVaV+j2ZpIzuJI
         uYEYUNDbFTyF4gu2hIQv4ivLi2NA89KxgHNCtYRArOZ9G+2/20ZE+r5H7yoOkkeaof
         RwgPqMECijdqvXd061nfLwGQcIJvC3rsmLqhfxzf3l8DscmBtRuUgl4J48N+oE2iu1
         hV5et3Kk2jHMF+NXGeTuFsc/ufIu0T/mNGZ/8DTSqqnH2/ZL5p4
Date:   Tue, 23 Jun 2020 01:05:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Ward <mward@smartsoftwareinc.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Git 2 force commits but Git 1 doesn't
Message-ID: <20200623010519.GR6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
 <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
Content-Disposition: inline
In-Reply-To: <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-22 at 22:17:21, Michael Ward wrote:
> This is assuming that the repository is completely empty to start. Setup:
>=20
> git clone [repository] repo1
> git clone [repository] repo2
> cd repo1
> echo "test1" > testfile
> git add testfile
> git commit -m 'initializing test from 1'
> git push
> cd ../repo2
> git pull
> cd ../repo1
>=20
> Now for the issue:
>=20
> echo "test1 update" >> testfile
> git add testfile
> git commit -m 'update test from 1'
> git push
> cd ../repo2
> echo "test2" >> testfile
> git commit -m 'update test from 2'
> git push
>=20
> At this point using the git 2.26 client if I pull in repo1, the commit wi=
th
> comment "update test from 1" is gone and the head is now the commit from 2
> with "update test from 2" as the comment along with a borked tree. Using =
the
> 1.18 client, the push from 2 will prompt to pull first.

Thanks, I can reproduce this with the following test in t5540:

test_expect_success 'non-force push fails if not up to date' '
	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_conflict.git &&
	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_conflict.git update-server-in=
fo &&
	git clone $HTTPD_URL/dumb/test_repo_conflict.git "$ROOT_PATH"/c1 &&
	git clone $HTTPD_URL/dumb/test_repo_conflict.git "$ROOT_PATH"/c2 &&
	test_commit -C "$ROOT_PATH/c1" path1 &&
	git -C "$ROOT_PATH/c1" push origin HEAD &&
	git -C "$ROOT_PATH/c2" pull &&
	test_commit -C "$ROOT_PATH/c1" path2 &&
	git -C "$ROOT_PATH/c1" push origin HEAD &&
	test_commit -C "$ROOT_PATH/c2" path3 &&
	git -C "$ROOT_PATH/c1" log --graph --all &&
	git -C "$ROOT_PATH/c2" log --graph --all &&
	test_must_fail git -C "$ROOT_PATH/c2" push origin HEAD
'

The relevant code is here:

			if (!has_object_file(&ref->old_oid) ||
			    !ref_newer(&ref->peer_ref->new_oid,
				       &ref->old_oid)) {

In this case, ref_newer returns 1 (true), which is wrong.  _However_, if
I add a debugging statement that prints ref_newer immediately above that
line, like so:

			fprintf(stderr, "debug: a: %s %s %d\n", oid_to_hex(&ref->old_oid), oid_t=
o_hex(&ref->peer_ref->new_oid), ref_newer(&ref->peer_ref->new_oid, &ref->ol=
d_oid));

The test starts passing (that is, ref_newer must return 0).

I'm CCing Derrick Stolee, to whom that code blames, because I'm not sure
that we should be returning different results in this case with what
must be the same arguments.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvFVTwAKCRB8DEliiIei
gan9AQDYidC1Ec401nDqY/nfKIT6WzcZzlFDdfN9g3mMgXVCvwEA5UXm/CQFqtL6
0G6Cv0WVM3K4TX9g788D6kz5mYx/XQQ=
=sEPJ
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--
