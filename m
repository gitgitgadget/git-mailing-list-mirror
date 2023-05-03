Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF50FC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 22:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjECWyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjECWya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 18:54:30 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C246A4
        for <git@vger.kernel.org>; Wed,  3 May 2023 15:54:19 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 24EB65A35F;
        Wed,  3 May 2023 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1683154459;
        bh=6QBkWORHkmM6yAjal1J+gCBhOv9h6cwoOzM8u6owVSM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oe8AsIPThIDzDcwsWIfb8mrw5i7rFQNvQZO+S9Ob38Oj0Z61gi7rn1a99NmEq6siP
         VrMElxcZ36lEq7fKS7qkhj2rvPoD8dZ/iF2TS4uCz+ElyxbBmWUyaDJbiICfE3Nimh
         uGgdmALSafIaPqLVxWXMPcMRTEqu1DdewCXtg9QRxlApMXfVAQh0jezVbtHc4qnvaf
         vjkUhpI5CWXVDKqLKUsB3W3Jn5tes8QxBLULEXAhpbt4A5LWlJf7noCUqtIJ2S0uLT
         Y7CryXsFeinUEJFlwJ3mwDAiu5G9M64IiL+sFncFsySrGYAdJWTbapddoL1/ztWrMc
         Hb3pN9i/IM0hOELoVyh95qXX58Meu23e1Vc6mNBbAuRKv62/aZO/i0S93uvAJP7bLT
         fZFpwFI94sbKjmbBZKkJ0WSuTkMBz8R7skhwyLTa6BNoB8ihUV7Q7St2S+7LFpUlpR
         I4z5gise0hrsKY0h71JrcLdQ3HcksZdkzuAi46KcTmk5ghKZCCy
Date:   Wed, 3 May 2023 22:54:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Message-ID: <ZFLmGYXgvyydLB5E@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JUkE04ncryDxi3m8"
Content-Disposition: inline
In-Reply-To: <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JUkE04ncryDxi3m8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-02 at 23:46:02, Felipe Contreras wrote:
> In my view one repository should be able to have part SHA-1 history,
> part SHA3-256 history, and part BLAKE2b history.

That is practically very difficult and it means that it's hard to have
confidence in the later history because SHA-1 is weak and you have to
rely on it to verify the SHA-256 history later.  Since attacks always
get better, SHA-1 will eventually be so weak that collisions can be
computed in the amount of time we now take for MD4 or MD5 collisions
(i.e., seconds), and with your plan, we'd have to retain that history
forever with the resulting lack of confidence in part of the history.

This also doesn't work with various structures like trees, the index,
and pack and index formats, which have no indication of the algorithm
used and simply rely on fixed-size, often 4-byte aligned object IDs
without any metadata.  In addition, the internals of the code often
don't pass around enough data to make these values variable and thus
this approach would substantially complicate the code in many ways.

Also, we've already decided on the current design a long time ago with
the transition plan after extensive, thoughtful discussion by many
people.  Very few people other than me have worked on sending patches to
work on the hash function transition, and that work up to now has all
been done on my personal time, without compensation of any sort, out of
a desire to improve the project.  Lots of people have opined on how it
should have been different without sending any patches.

If you would like to propose patches for the extensive amount of work to
implement your solution, then we could consider them, although I will
warn you that your approach will likely require at least several hundred
patches.  However, I refer you to the list archives to determine why
your approach is not the one we chose and is not, in my view, the best
path forward.  I should also be clear that I have no intention of
submitting patches to change our approach now or in the future, or
redoing the patches I've already sent.

> The fact that apparently it's so easy to clone a repository with
> the wrong hash algorithm should give developers pause, as it means the
> whole point of using cryptographic hash algorithms to ensure the
> integrity of the commit history is completely gone.

No, it doesn't.  It means that our empty repositories until recently
lacked any indication of the algorithm or other capabilities, which was
a mistake in our original protocol design that has now been corrected.

If you interact with the repository later on when it has data, then if
you're using the wrong hash algorithm, you'll find that you get a
helpful error message that that's not yet supported.  If you patched Git
to ignore that check, you'd find that your repository would just be very
broken in many ways with lots of random crashing and seemingly unrelated
error messages instead of subtly using the wrong algorithm.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--JUkE04ncryDxi3m8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZFLmGQAKCRB8DEliiIei
gX+RAP9yRszto8oIG4sZ7UlOnbUF5BVjruQaIsfdHH8ZXB6hpwD9EgZ0JRb/NCmh
dFO39iF25a2/dQzKC8Ngv5CjqkdNUwg=
=RLY1
-----END PGP SIGNATURE-----

--JUkE04ncryDxi3m8--
