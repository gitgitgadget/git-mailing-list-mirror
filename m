Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E2720248
	for <e@80x24.org>; Tue, 26 Feb 2019 03:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfBZDUL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 22:20:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35036 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfBZDUK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Feb 2019 22:20:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:a4e9:9ba4:4fd2:4493])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFB7560429;
        Tue, 26 Feb 2019 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1551151207;
        bh=vM9GXni+/zrfm9vaoAex1GDH2RVNwEDCwFJmYbwyR5Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=abqg4nlHZvhNx4qujmIP2M/4S6XXE4VJokJOPohsPSWN4X9JzaVW2PB6l4l+MAybS
         bMdTwOB7j4HN88j3/iAmX1j8oWhSR8Be/yldFXjrlH3UQVItMxql1cuxkBZqf1xSDm
         6nNpIKgRJkz/UeiZLMBLL8Hum0FQfqM6YBcw8tXrbtOaKtzcc6DnyOyLrDxSxK0nJ4
         QdzUVSAQ74oz4wOwuqu7FsTx+crBPpopTUBWFkRRmo91vzeIs7T1YL4n2KEU1d3KhC
         kHhEdxP25szzrH0fWNQGf031vIoZDhC0v86fFNUCo7EgjElwcAL8co0Wcv2rpk/5Pv
         nIPcdvYYMwaV94OA6U3tSmzfTBpUMsbCrRb1/JWNSwruE42JiMEZyrjZH90ByuDXHl
         roUXJKvnEMUH24XPgxJsjE34IsQI9MtiSfBm5eyUsAyKG4L88/vx6H8wN2wOAKs4ue
         IhLfCtju9yyp+PxIk4foG74vfHXIEdtPlvkqJl9WjAigK4ZRrZc
Date:   Tue, 26 Feb 2019 03:20:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] asciidoctor-extensions: fix spurious space after
 linkgit
Message-ID: <20190226032000.GC601925@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1551123979.git.martin.agren@gmail.com>
 <41d9ea21c37a634b2310b5b2f68935bcd612665c.1551123979.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <41d9ea21c37a634b2310b5b2f68935bcd612665c.1551123979.git.martin.agren@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 09:02:40PM +0100, Martin =C3=85gren wrote:
> When we render, e.g., "linkgit:gitglossary[7]." with Asciidoctor, we get
> "gitglossary(7) ." with a space between the linkgit macro expansion and
> the punctuation. We can fix this by dropping the trailing newline after
> we've turned `linkgit:foo[bar]` into `<citerefentry>..</citerefentry>`.
>=20
> The diff produced by `USE_ASCIIDOCTOR=3DYes ./doc-diff HEAD^ HEAD` is
> almost 6000 lines large and shows how this fixes "git-foo(x) ,", "(see
> git-bar(y) )" and so on. One might wonder whether this also turns, e.g.,
> "see linkgit:foo[1] for more" into "see foo(1)for more", but no. We get
> "...</citerefentry> for more" in the XML, see, e.g., git-am.xml, so the
> space ends up in git-am.1 just fine.
>=20
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/asciidoctor-extensions.rb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asci=
idoctor-extensions.rb
> index ec83b4959e..f7a5982f8b 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -16,7 +16,7 @@ module Git
>            "<citerefentry>\n" \
>              "<refentrytitle>#{target}</refentrytitle>" \
>              "<manvolnum>#{attrs[1]}</manvolnum>\n" \
> -          "</citerefentry>\n"
> +          "</citerefentry>"
>          end
>        end
>      end

Yeah, I think this is clearly correct. I also like that you mentioned
the concern about potentially not including the space, which might not
be obvious to someone not intimately familiar with DocBook and the
stylesheets.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlx0sGAACgkQv1NdgR9S
9ov3Ew//WsW6cjVWwC4U1lzrFCf0GsBE3Mmb5XveDkU5NPaS1yoHdUTzfUdgUxP4
mFS8z7ChPfQpcmfj6GQJ0e/t9HICBZMFAFxndJlewoyY+NFNb+B+vths1NIkCpcq
kX069Qgklyyg0c5dLyoALLT/bfK4zlS6bDd7nV0FyTn3RCa1+x8Kb2+jytzUZgTW
JxE0SJIzMypA7zpyA4RgZkv9TTSquj8MsIiLudicO7+xiBOsfhT+P/ncZ9lWCai9
kQpkPMXp2m6Td9KxkSmOH0bNaZvt1XapS/ekPEUdiSf1qWieCNszUtP3LmLzYG2J
e69+sVkZV/aIlu4QzaxI+mcMUhAVgalvInjdJbHihdRFuRrnS1/v+MwiJcIhXLPo
zkdPvBcaPJyoYwjHUebixTLXGE452Gexy/3QaZHs7fg+7PW/aTULBZREGV59qe6l
UhoN/adNIlm7IOI2BSnXNaPqRnDva0OZeASklY31ZO1cr4jvL/cZmnzq6Il9Kj+h
vLCtyRlRR/2ZSxF0KUg26foezRcJjuNefNjER+zKVmAZq/m3Q6I9ulnaOVg85OUC
0ZhNgXONg8LHuGLw/8VcY0TdZ9kDhyfLZepuLhwDp79UhJyLZKiTGglVNaNGoYJe
z6EYtDica7HVCNrtWWmPwEarNUnMwRyW2Azol09AUpKQ5OVQD+M=
=FtiM
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
