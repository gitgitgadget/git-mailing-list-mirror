Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A477C20954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdKVQIw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:08:52 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40281 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdKVQIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:08:51 -0500
Received: by mail-wm0-f52.google.com with SMTP id b189so11247155wmd.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N0stWAnlXBJ2wdXbHWZdKRQYkDnJl/Utr2OJA54MDV8=;
        b=TPWbxf7dfoFB79xIgAYaK/74fR9Ah9PILWYod7kMir2UD/dGb0N23XMHTK0Qx+yjPO
         dafNhjxx7YjkcEtkE3C3lvp5rzHGsXSBGDwKfqCdUjayHKy247QorTsTNjwzh/z5zC2x
         bo3emyU2yPuVtIdO4JQlUULI9fqXmRYrgfcZ/IsPq/wTI+pnyMtiDl552SsJjp/VmhhD
         2lLLnb36ZP03p1FB07Ij/TWyLjF2eIkh28TPGIT+QYHtaBChhE2AXbXciLRbJ66PB3iE
         BP4+aiyTVjOD3dvC6ZXxrNbt6FU+yKCTEcsSUD0Lsp42pu+a0Mvu5iR4VK/CB36bXTgu
         3BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N0stWAnlXBJ2wdXbHWZdKRQYkDnJl/Utr2OJA54MDV8=;
        b=Ey1zZ783GiCMu9sTwcqHDkygW+UL6wprwuGO6p3v1I2gIc317Kbd/HYtPT6Vde5cnc
         OhKri1KzFAjjt878kZUd8zvqf3V8pS12jKZvNDh2HSWdPKXT90hMUPxNyceUKZa47Tlg
         YvhO85z7eskFQijd35o/SeqP+xKoAkGcjbaz12ICfHQMVkNZFOKFubHkoMrGU0TgraRN
         D+HeGv7NR9hFKXJkUubpqdOAwDQ3qq1NEUDMYFOuoDuNlBJ8uf98kklhDdAGDAhQ4Y1O
         XQEjFbLNU0oz7ZLSdyZU6GDOhUoNod/L1GBRQwyGKlLOneedxYT2ASXBBzobeaAQGp/v
         F9Og==
X-Gm-Message-State: AJaThX6HFijJl79dPn2NeHqZAAka/ffaDsCuwq6nEbkbG4Rd1FJwmU7i
        DHIWY5SGRvLDIyZFCOXW/XZ0Vw==
X-Google-Smtp-Source: AGs4zMYt4A8px2BeqS/+TpqSqZJTulpoUAbzG2xZyVXg/n83fDppxRHeA87Tn9boR6VFI9XdXXI9wA==
X-Received: by 10.80.215.89 with SMTP id i25mr30909280edj.274.1511366930454;
        Wed, 22 Nov 2017 08:08:50 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-144.NATPOOL.NYU.EDU. [216.165.95.144])
        by smtp.gmail.com with ESMTPSA id z56sm11383931edb.72.2017.11.22.08.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 08:08:49 -0800 (PST)
Date:   Wed, 22 Nov 2017 11:10:16 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Nathan Neulinger <nneul@neulinger.org>
Cc:     git@vger.kernel.org
Subject: Re: git status always modifies index?
Message-ID: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e4jmqsa2p6mvikkv"
Content-Disposition: inline
In-Reply-To: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e4jmqsa2p6mvikkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 09:37:09AM -0600, Nathan Neulinger wrote:
> What I'm meaning is - why does it need to write the index back out to dis=
k?
>=20
> From looking at the code in builtin/commit.c it looks like it takes a lock
> on the index, collects the status, and then unconditionally rewrites the
> index file.
>
Hmm, I just took a look at those lines and I see what you mean. From
what I understand, this is to cache the result of the index computation
for ensuing git calls.

> I'm proposing that the update_index_if_able call not actually be issued if
> it would result in a ownership change on the underlying file - such as a
> simple case of root user or other privileged account issuing 'git status'=
 in
> a directory.

I don't think this would be a desire-able default behavior. I'd wager
that running git status using different accounts is not a great idea ---
specially interacting with a user repository as root.

> I understand completely that it would be expected to be altered if the
> privileged user did a commit/add or any other operation that was inherent=
ly
> a 'write' operation, but doesn't seem like status should be one of those
> cases.

I think it's because of the reasons above. That being said, I don't know
what the rest of the community would think of something akin to a
--no-update-index type flag.

Cheers!
-Santiago.

--e4jmqsa2p6mvikkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloVoWQACgkQRo8SLOgW
IpUREQ//WWnYi9c+Ggnx+SPjqxN2Di4LZ+QzH/CRoNP17396giOg1FOZXpMcPGHW
kM1SXnQ0AKGxWyUgD3TFsizx8KA3jnX9ZzTXIGhSV1QZ3hwQR11mD6aJ30nGOn+P
TwBzlpbx2sxO1lNHTxL76GUcNgYKimKB8h9pblfowNw4h+hPMNKFIYlhPaf8BIwl
DGe8CkShExGdrpal14QErwws2t97LEJtdV5HHS8Cgmd07sA5kChNoZytmupo0iqH
PSz+qiVxCJiGMb+r9b+zDJfqJWZUDSYAhH3LMwq2Pq1sgkjPbchrP2uR7foOkdAo
Kpd3Z0lAqH6uxuFtkb5E7e+0wvQ0a4ee1RkEW+g2md7D926AztO/B9FZR8F9Zqhd
WxpX2OO2Ab+Y90D0R8DQcBnyTmm2s8lELNHExMJ4owcqpcDiVbP3WqT5pzArYsUZ
IVucFNpz0B71IRwJ7G7l9Z8Vkpza7eizkRrytaQL6/FkOXK08GG56TQewU0ZjLBI
MCqQyOSS/qcxqC7KFSVsUNK2PulfGs5TDEF66qfYyZJI5m2q8hrQyZjhmP5f3K9e
PW6Qc6YdtggUIBC2mQJZbhFbOEnlSD4dOek3TbLf2A6shbQdvhCH2oiWZqPE4dCG
bk0a8VQXf9CXBrOjJ9Meq8IvBITyCGM747BPuIi+FDuv8FI7AWI=
=+ra/
-----END PGP SIGNATURE-----

--e4jmqsa2p6mvikkv--
