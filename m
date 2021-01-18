Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844D3C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B45722CA0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436520AbhARSBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:01:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55720 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406248AbhARSAo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 13:00:44 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0CF1760781;
        Mon, 18 Jan 2021 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610992801;
        bh=1AKt2Ttqr+PwgSOvN3VrwughnbaMOpuMbOYPR0QotaY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TQ0Da5Ilu2SdFRmLkj7QEU/JIxPxMDdB5wzFkDMBoq81OKVQKTp9ZlD2Pt4i8EpTT
         V5p39AQ+fVEZ6dz/7yBi1HDklhb2XR7V1UswCwv5N3hUp7LWYxXMQU6Y9B43RjMcGH
         qDVng3FtNRuN8CXE6QJEKgKCNBapat/qgJ9+kKlL0Q1mecMaJETo+FNr4EEkIqaD6C
         LsiDoLKXT6pVfIcdpFKp4tJC5HQ3kDGvLTnMjUatgY99JhU3wiYutDCIpog4zcXv8B
         vB21cMtos/yjzllmeUFJMQzmsfKqPMsBZTnzfIK0Q0o+dkmF0Tfs4426w5U8uRtA3B
         f70QoEK/OnPxPcLYUBKEsnKqCFsiXZY5Ru8iRhNPVGF5RMTLPQ+ourG2R7QWtpBnIr
         bfOXYCktqRH25aX21ngC0Yk22fA4tYZ846QJFlamDPY57puUTggtqF/zqRgRwnFfhR
         a2yFe+eVF8xlbDvYUd21kNLB07a1xWfHogRy4klQhj/+6CU6K0N
Date:   Mon, 18 Jan 2021 17:59:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Utku <ugultopu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to commit without an index file?
Message-ID: <YAXMmtIXB9gXUi9C@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Utku <ugultopu@gmail.com>, git@vger.kernel.org
References: <A31FEB7F-0A81-4500-9B1D-F65A5F8823AA@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bQbyvVGk3iXfuA0R"
Content-Disposition: inline
In-Reply-To: <A31FEB7F-0A81-4500-9B1D-F65A5F8823AA@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bQbyvVGk3iXfuA0R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-18 at 16:58:56, Utku wrote:
> In my program, I have the file paths, permissions and Git object IDs of
> everything that I want to appear in the next commit. Hence, I want to
> create a commit without creating an index file.
>=20
> Essentially it's like to combining `--cacheinfo` from `update-index`
> with `commit` like:
>=20
> 	git commit \
> 		-m "Commit message" \
> 		--branch my-branch \
> 		--cacheinfo "100644,0123456789abcdef0123456789abcdef01234567,path/to/fi=
rst/file=E2=80=9D \
> 		--cacheinfo "100755,123456789abcdef0123456789abcdef012345670,path/to/se=
cond/file=E2=80=9D \
> 		--cacheinfo "100644,23456789abcdef0123456789abcdef0123456701,path/to/th=
ird/file"
>=20
> In this example, the command would not read the index file, but would
> get the information necessary to create the commit tree as arguments (or
> from STDIN). The command would handle recursively creating trees for the
> intermediate directories. The object ID for the final tree would be used
> for the `tree` field of the commit.

You could use git mktree, git commit-tree, and git update-ref for this.
If you have the object IDs for all the existing blobs and trees, then
you can create any necessary trees, pass the root tree to git
commit-tree, and then use git update-ref to update the branch from the
old value to the new value.

Note that if you're doing this in an otherwise busy repository, you
should definitely specify the old value of the ref to avoid a race
condition where someone else updates it at the same time.

If this seems like a lot of inconvenient work, then you'll see why we
have the index.

If you just want to create a commit without modifying the _main_ index
file, then you can use the GIT_INDEX_FILE environment variable to use a
temporary file as the index and then read data into there and commit
using git read-tree, git update-index, git commit-tree, and git
update-ref.  We do that elsewhere in Git, and this will definitely be
easier than writing your own trees using git mktree.

> So I guess this is the best it gets? If I wanna make it better, I guess
> I will need to use libgit2?

This may be slightly easier with libgit2, depending on your needs.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bQbyvVGk3iXfuA0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAXMmQAKCRB8DEliiIei
gZKZAP4sd3LaUAi8Wu49sMJaQ8fuBhmYZMqnmheNlfd27ZeSFgD8DJXZLgjXwdzx
QQuDhWPUlE0VCU9MNF9shyymkbAx0Qg=
=zePe
-----END PGP SIGNATURE-----

--bQbyvVGk3iXfuA0R--
