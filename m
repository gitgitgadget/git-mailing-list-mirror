Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C2AC433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 01:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhLRBeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 20:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLRBeS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 20:34:18 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E657C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 17:34:18 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DD7975D49D;
        Sat, 18 Dec 2021 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1639791253;
        bh=xWyCxj6xqko9faUhX4kz186uhivOqkeWMz8Hta1Prwk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=r3rHNYXCtLQo5kmZrEV6QzB3SYeagPcwy/B/k06BrX86Cn1GfreeE5T22TzBKGTRQ
         qxAXPytgEDrUFZSz7xSoG7xdwRzGnDh6I5B5uJHPT08kTC3VTbs5P3RHYnofPv9xEE
         O7DOf7LJBwyo4+G9RPKFTPhZmTZ2u43AaHIm0oRanm5G+my/KTZY+N5uKnCp5kjt2+
         5mSlyWCEn+0M/lvcCxF4KBtyGl0Zjsr3rt+WFTH8L79v9saPG1Z2t459xWTz/ym8GL
         g9QqyOjtMXVhwAKPpKzVi4UvvcWtBAfRmcUl3e5hKaz5SPPpn8u3mrZm7QiBtC0Bj6
         83rECwV5IKxAnV5h2JkyIJkq65FFsLJ58CuDOPuMJfqeuBwecpvgw1URzko10pqzeZ
         ANJHHGOB6o3W3MqI9Psde8lSHf3feLBeVi8Zte5zyPeLqZJlyo0pAslII9X1isC6JE
         z6YpEJnaMOXT6iTyzYxqe0DpJHwkkXOyrjP2auW3oQlxlmO159I
Date:   Sat, 18 Dec 2021 01:34:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Sm/Do28=?= Victor Bonfim 
        <JoaoVictorBonfim@protonmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fw: Curiosity
Message-ID: <Yb06k5ob+bl/oE68@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Sm/Do28=?= Victor Bonfim <JoaoVictorBonfim@protonmail.com>,
        Martin Fick <mfick@codeaurora.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
 <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
 <xmqq8rwl91yf.fsf@gitster.g>
 <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
 <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
 <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
 <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t/osB+WdFh/yjU5e"
Content-Disposition: inline
In-Reply-To: <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t/osB+WdFh/yjU5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-18 at 00:15:59, Jo=C3=A3o Victor Bonfim wrote:
> > I suspect that for most algorithms and their implementations, this would
> >
> > not result in repeatable "recompressed" results. Thus the checked-out
> >
> > files might be different every time you checked them out. :(
>=20
> How or why?
>=20
> Sincere question.

A lossless compression algorithm has to produce an encoded value that,
when decoded, must produce the original input.  Ideally, it will also
reduce the file size of the original input.  Beyond that, there's a
great deal of freedom to implement that.

Just taking Deflate, which is used in zlib and gzip, as an example,
there are different compression settings that control the size of the
window to use that affect compression speed, quality of compression
(resulting size), and memory usage.  One might prefer using gzip -1 to
get better performance or use less memory, or gzip -9 to reduce the file
size as much as possible.

Even when the same settings are used, the technique used can vary
between versions of the software.  For example, GitHub effectively uses
git archive to generate archives, and one time when they upgraded their
servers, the compression changed in the tarballs and zip files, and
everybody who was relying on the archives being bit-for-bit identical[0]
had a problem.

So it would be nearly impossible to produce bit-for-bit repeatable
results without specifying a specific, hard-coded implementation, and
even in that case, the behavior might need to change for security
reasons, so it would end up being difficult to achieve.

[0] Neither Git nor GitHub provides this guarantee, so please do not
make this mistake.  If you need a fixed bit-for-bit tarball, save it as
a release artifact.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--t/osB+WdFh/yjU5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYb06kwAKCRB8DEliiIei
gSsiAQDCzmsARoiNmvT4nTGTORHmnUgc4o0DkJpCkV5oKn6b4AEAtAunfTl3A+1/
lH2pYYr+vWLdZWlLldNje3kPxvkB8A0=
=OUlo
-----END PGP SIGNATURE-----

--t/osB+WdFh/yjU5e--
