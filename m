Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6BC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B63520771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mS4U7y7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHNUMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:12:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41520 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgHNUMB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 16:12:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 567A360456;
        Fri, 14 Aug 2020 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597435919;
        bh=Fi0rZgAySA/MxLmFF6a23Bgg6emt5D0Xd+9Hg6To/+w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mS4U7y7nYQ6m1vFNI7Tm2sPmuGaW+LoBVikJQIKO2QlGADH+GUz1OI5OreSwqyiDx
         bYZbLXkSThHZVH7AhrGiyi6wjJUh210CT2Z6JNP9pygPugUd+kg5LfPcwGxc4XVNvS
         Jf1pvYDJ70XPdzupk58j3B9pK64NsKQ1m9ffMf0zl+Z/3L6IoMJiJrnbvJ1RcNmld+
         kywWz7WeEJTA2uaMQdtjuN0ogJmRhVHrKb0tDMvZXnPF5kKBRJjvqAm80Q0pQa+cGz
         KTxxFP1IOmwyksUyBiCRHuJgXqPPLexKDd8TrvtVillxF3JRLcJuZE3jgW0rSIdO+o
         vMGn4IEtPUYKMB33TQj9nTwedAqy/2LbEs7u+JHPyjnIa2/SJJCu/MCVoOzbOSL9p1
         OWAjWoHT8htfxG/alPrEr//P5RsNp+KEd83zlUWNR2MOga3ge4QMpyUI/5mq9r14oF
         LubcD+fTXCFojUuIoxL6zMX8UbDKOnZQWdoNNSVcy4g8NOR48Gk
Date:   Fri, 14 Aug 2020 20:11:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit-graph: use the hash version byte
Message-ID: <20200814201153.GK8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline
In-Reply-To: <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 18:07:19, Derrick Stolee via GitGitGadget wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index e51c91dd5b..d03328d64c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -179,7 +179,11 @@ static char *get_chain_filename(struct object_direct=
ory *odb)
> =20
>  static uint8_t oid_version(void)
>  {
> -	return 1;
> +	if (the_hash_algo->rawsz =3D=3D GIT_SHA1_RAWSZ)
> +		return 1;
> +	if (the_hash_algo->rawsz =3D=3D GIT_SHA256_RAWSZ)
> +		return 2;
> +	die(_("invalid hash version"));
>  }

Can we maybe say something like this?

  switch (hash_algo_by_ptr(the_hash_algo)) {
    case GIT_HASH_SHA1:
      return 1;
    case GIT_HASH_SHA256:
      return 2;
    default:
      die(_("invalid hash version"));
  }

That way if SHA-256 gets broken and we switch to another 256-bit hash
(SHA-3-256?), we'll be forced to update this properly.

>  static struct commit_graph *alloc_commit_graph(void)
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index c21cc160f3..906af2799d 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -6,6 +6,12 @@ test_description=3D'git log for a path with Bloom filter=
s'
>  GIT_TEST_COMMIT_GRAPH=3D0
>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0
> =20
> +OID_VERSION=3D1
> +if [ "$GIT_DEFAULT_HASH" =3D "sha256" ]
> +then
> +	OID_VERSION=3D2
> +fi

Can we do something like this in the setup test instead?

  test_oid_cache <<-EOF
  oid_version sha1:1
  oid_version sha256:2
  EOF

  OID_VERSION=3D$(test_oid oid_version)
  # or, inline
  $(test_oid oid_version)

That uses the existing test framework to ensure we produce the right
results if someone adds another hash algorithm and that we produce a BUG
if the value is missing.  It will also make it easier to write tests if
we end up creating SHA-1- or SHA-256-specific tests, since we can look
up those values directly with test_oid.

Since you're using this across several tests, you could even just add
this to t/oid-info/hash-info like so:

  commit_graph_oid_version sha1:1
  commit_graph_oid_version sha256:2

and then it's set in one place and can be used without any required
test_oid_cache invocations at all.  I think three tests is sufficient
basis for us to add an entry there.
--=20
brian m. carlson: Houston, Texas, US

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzbwCAAKCRB8DEliiIei
gb6tAPsHZ5hZdE/k7DV3LYYzGwKk0BNirGCkqEPFKTh0QSh2qwD/XMSmGDV8zKt2
XaMD7breFaHfznCNqwTo6JB6+dYRCAQ=
=cPn9
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--
