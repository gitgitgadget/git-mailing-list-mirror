Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331EBC05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBQWlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQWlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:41:50 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58EE1C32B
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:41:48 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 19A365A1E1;
        Fri, 17 Feb 2023 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1676673708;
        bh=v6YuQc2hQ9dUFf5iCJ8ee8mvqPxM9oueCENqo4OcnZI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kfPuKse88mSR1oTEJlwJOoKQyTXGEDQxroaz9i4IIArkh2U0VH6dy/3d/bGHYcI2K
         FMPdJtSK7i+QYna5JgWbKclb8dvFUpj8NPl0+0evviFsmRwAvgxLiUlOiPN+76Wy7T
         jGVL5tYvfNccTL+m0rqlE+bUeibdjWLlIsG2Bp76y3WigixhfM2eykZLUfUax1ZxAI
         eQu3SxgqtfB/ohN6NVqnq3HrBY7tSOGEPlQHC55a/JrIqnQXIqUBTtk2sfz9a2Dd3R
         Hz57zrAVbFfcgUll3XMets7DMNDNAqe5j8sBdHqrNA0Xp5R6Myzwc7EnvdvkaaOYDM
         CROkfou+5st6/kH5Ll2BlQ9OC2tkaWmHeN8D9dbO0AW/NDZ0uYPKDjhwlJIg7o3m3W
         6c/+QxezcIhYGv36TtYp8ca9jpB9z0PET9o7UThl/NFaqj24Ch6A8GagmSHFctgM6h
         hRrMZOtryuy39sugEHT62Gke4s1szbhSaQ6m/P47nz/KGzNCq1G
Date:   Fri, 17 Feb 2023 22:41:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
 <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HRgAeZiM12QIov86"
Content-Disposition: inline
In-Reply-To: <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HRgAeZiM12QIov86
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-17 at 21:38:34, Emily Shaffer wrote:
> For example, I seem to remember you saying during the SHA-256 series
> that the next hashing algorithm would also be painful to implement;
> would that still be true if the hashing algorithm is encapsulated well
> by a library interface? Or is it for a different reason?

Right now, most of the code for a future hash algorithm wouldn't be too
difficult to implement, I'd think, because we can already support two of
them.  If we decide, say, to implement SHA-3-512, we basically just add
that algorithm, update all the entries in the tests (which is kind of a
pain since there's a lot of them, but not really difficult), and then
move on with our lives.

The difficulty is dealing with interop work, which is basically
switching from dealing with just one algorithm to rewriting things
between the two on the fly.  I think _that_ work would be made easier by
library work because sometimes it involves working with submodules, such
as when updating the submodule commit, and being able to deal with both
object stores more easily at the same time would be very helpful in that
regard.

I can imagine there are other things that would be easier as well, and I
can also imagine that we'll have better control over memory allocations
and leak less, which would be nice.  If we can get leaks low enough, we
could even add CI jobs to catch them and fail, which I think would be
super valuable, especially since I find even after over two decades of C
that I'm still not very good about catching all the leaks (which is one
of the reasons I've mostly switched to Rust).  We might also be able to
make nicer steps on multithreading our code as well.

Personally, I'd like to see some sort of standard error type (whether
integral or not) that would let us do more bubbling up of errors and
less die().  I don't know if that's in the cards, but I thought I'd
suggest it in case other folks are interested.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--HRgAeZiM12QIov86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY/ACqgAKCRB8DEliiIei
gX0kAP4n7Gbty9WHYMUhsAYpXum37Vb9lNp0U9zec8h8k37VKQEAsbVPOcLdX39c
EGnpb7Va1BjARSoU84+9/F7K8GmHrg4=
=Vy7p
-----END PGP SIGNATURE-----

--HRgAeZiM12QIov86--
