Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8297BC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 10:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBBKZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBBKZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 05:25:12 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AABAD3E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 02:25:10 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 178EB5A1E1;
        Thu,  2 Feb 2023 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675333510;
        bh=naAnQkYaSu489AvERt6ECY6s5Hd9AQmunJbd1eS/O6M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TKSU7pYMaphZlcfzHI5DjpSvJJ/kZC2ECa/A1mei5+G6PHyg/FPC02SJ64vB5NSBb
         IIAFOMIv1VT2JicCq/zk3edvF32/OkWOY7VBdaFBIMtLNMW+XR4reBS1omY5WPAXH+
         trmgD1cuELLX3bgHGaBLYvKLuDZ5xNieSjOtgPBbzrZRIVPmhebsRIunGDPLC8/57M
         RHAOfFdPCEma2pz07XYDoejxeNoS8hymHdMgARyug7iYKtAUHa4BCBGRGA4i2H/r8o
         WhNI6DzfoPJv0ciqJx9KcILS5n+Po+VGZ5qFCaONuE0265GsHFSAEXlnsBRh6N9XLV
         kdwG1SLRWFPVHdVZ3w6QRu7845YRAD3+OCBgHfwDT7dZvAInUPRlhsN3jvPMxWceYE
         FVgGwT3pJE99nXhPHpcx535aL4w9B3yMQuQWcvQD28w6nZ2Ov5Y4bzW9OOXSdj1kKR
         fjiuYV0BtpPtCT15mq2U/XgMs8GhEFgliUPbVYglQdktbt1R9zg
Date:   Thu, 2 Feb 2023 10:25:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 9/9] git archive docs: document output non-stability
Message-ID: <Y9uPhPnNFlCju8Fo@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W8jkwUYUKs8xJ3WJ"
Content-Disposition: inline
In-Reply-To: <patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W8jkwUYUKs8xJ3WJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-02 at 09:32:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> +[[STABILITY]]
> +OUTPUT STABILITY
> +----------------
> +
> +The output of 'git archive' is not guaranteed to be stable, and may
> +change between versions.
> +
> +There are many valid ways to encode the same data in the tar format
> +itself. For non-`tar` arguments to the `--format` option we rely on
> +external tools (or libraries) for compressing the output we generate.
> +
> +The `tar` format contains the commit ID in the pax header (see the
> +<<DESCRIPTION>> section above). A repository that's been migrated from
> +SHA-1 to SHA-256 will therefore have different `tar` output for the
> +"same" commit. See `extension.objectFormat` in linkgit:git-config[1].
> +
> +Instead of relying on the output of `git archive`, you should prefer
> +to stick to git's own transport protocols, and e.g. validate releases
> +with linkgit:git-tag[1]'s `--verify` option.
> +
> +Despite the output of `git archive` having never been promised to be
> +stable, various users in the wild have come to rely on that being the
> +case.
> +
> +Most notably, large hosting providers provide a way to download a
> +given tagged release as a `git archive`. Some downstream tools then
> +expect the content of that archive to be stable. When that's changed
> +widespread breakage has been observed, see
> +https://github.com/orgs/community/discussions/45830 for one such case.
> +
> +While we won't promise that the output won't change in the future, we
> +are aware of these users, and will try to avoid changing it
> +willy-nilly. Furthermore, we make the following promises:
> +
> +* The default gzip compression tool will continue to be gzip(1). If
> +  you rely on this being e.g. GNU gzip for the purposes of stability,
> +  it's up to you to ensure that its output is stable across
> +  versions.
> ++
> +
> +We in turn promise to not e.g. make the internal "git archive gzip"
> +implementation the default, as it produces different ouput than
> +gzip(1) in some case.

I think this is fine up to here.

> +* We will do our best not to change the "tar" output itself, but won't
> +  promise that we're never going to change it.
> ++
> +If you must avoid using "git" itself for the tree validation, you
> +should be checksumming the uncompressed "tar" output, not e.g. the
> +compressed "tgz" output.
> ++

I don't think I want to state this, because it implies that the changes
I made that broke kernel.org (making tar.umask apply to pax headers)
wouldn't have been allowed.  We should probably just state that "we
won't promise that the tar output won't change between versions". Maybe,
"We won't change the tar output needlessly, but it may change from time
to time."  That is, we won't be "let's change the format just to mix it
up for users", but if there's a valuable patch that could be applied,
then we might well take it.

As I said, it's my goal to provide more concrete guarantees in a future
patch, probably this weekend.

> +* We promise that a given version of git will emit stable "tar" output
> +  for the same tree ID (but not commit ID, see the discussion in the
> +  <<DESCRIPTION>> section above).

I think that section contradicts this.  The tree version uses the
current timestamp, which would make the archive change based on the time
of day.

> +While you shouldn't assume that different versions of git will emit
> +the same output, you can assume (e.g. for the purposes of caching)
> +that a given version's output is stable.

Unfortunately, this isn't actually true if someone uses export-subst.
That's because adding unrelated objects can increase the length of
abbreviations, and then the tar contents can be different.  I've
actually seen this in the wild.

Modulo that, yes, I agree with this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--W8jkwUYUKs8xJ3WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9uPhAAKCRB8DEliiIei
gXwZAQCe+9nx4n3ag6RxgZlKj2oDpx1k7Uh1pBhfbK6TMBwg7AEAkxC/VIVEqftq
53s2qtN5WYRMvV2jEz+2vOI1qCRElgQ=
=AhnP
-----END PGP SIGNATURE-----

--W8jkwUYUKs8xJ3WJ--
