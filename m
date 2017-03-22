Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1FD2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbdCVWvN (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:51:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36447 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbdCVWvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:51:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id n37so27222081qtb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KLYfVB5fg3RN+M4c1SsPEvREj9HoJYfVVl2YgHgpb3o=;
        b=onSmPNkTHaE8XNQ5M1OoYxgit+2CUbTzHK4KCzUxYzfuO7mInkJI39m9EE8myQ3nwh
         SRVX+/sIeuQaseErOox6MGJ5ohvnFV/flIhBW/WXkk7WsIQxDkORJo+EZAq21aGB07It
         egs8nficU8zo/tH5aAzSwr+khA8CvtdqAGe1uRSo3fB8XsB7Gy1BXTnIsYFH30z9ajkf
         Q3adRzbmHT16RC2R6V+BzykrAzVunCRrShXMqEIEZ6VL+33QH8KgwZtsbsXqnKah/0sm
         qlvN2rVMVR+2rHGgufLPt2rkLeeGMknINqAiiD012zi8nUsDt69Nr/yosFEr89E5WJ5V
         Q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLYfVB5fg3RN+M4c1SsPEvREj9HoJYfVVl2YgHgpb3o=;
        b=OjJV0goc53YERyNts/HAhBuZSHNdmN+bUfIs4hcrgpfZLVx+jzM1cXrHuvcverDfXF
         eIpXbQVlmEUwy8AzS5u6OIZXQz+LrVy2vvchvvuHbdZ5gEG5rtaHV+ECBciZRnWgef8K
         Nv01CNOe/3AIzKhK6AaWMm9rJeW+iX5eH+3ZbphvBvNb2mTQhIltquZgNuKBCbDjzOXa
         /b5K2cp7bX8K+msAEqiSKUz3BYbaZAhXKSx2i/uVovsTO7mdyPTz0e3OZRuUZ/Y5egKd
         NcLxWDoiEUci3mO5QQP14ZUP2qhDwQLxSJk4OUvKsEplkhQOXMfI0850BWPB4Xe+DfuV
         hUow==
X-Gm-Message-State: AFeK/H35RF+7YOwSXaXNwWWHi0wpcz+cR9jUBLjTG0a0F/xjXPY6llTEq4Oe5wSt5AXM/JsS
X-Received: by 10.200.50.165 with SMTP id z34mr38415107qta.205.1490223069728;
        Wed, 22 Mar 2017 15:51:09 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id d136sm1974108qke.32.2017.03.22.15.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:51:09 -0700 (PDT)
Date:   Wed, 22 Mar 2017 18:51:08 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
 <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
 <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
 <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
 <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lskehgyyxkqhjxdp"
Content-Disposition: inline
In-Reply-To: <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lskehgyyxkqhjxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 06:41:24PM -0400, Jeff King wrote:
> > In that case, something like this would be closer to the desired
> > behavior?
>=20
> Yes, though you can spell:
>=20
>   cat >expect <<-\EOF
>   EOF
>=20
> as just:
>=20
>   >expect

Ah, that sounds like a better way to fix this with a smaller diff.
>=20
> > I'm also unsure on what would be the right thing to put on the commit
> > message.
>=20
> I think the argument is:
>=20
>   1. It's safer not to expound on tags that have failed verification (so
>      that the caller cannot accidentally use them). Especially since the
>      --format cannot tell anything about the GPG status.
>=20
>      That means that
>=20
>        tag=3D$(git verify-tag --format=3D'%(tag)' foo)
>=20
>      can use a non-blank $tag without having to wonder whether it is
>      valid or not.
>=20
> and
>=20
>   2. That's what we've done since the feature was released.
>=20
> The only thing that would give me pause is if were to later add
> %G-like formatters, and then:
>=20
>   xargs git verify-tag --format=3D'%(gpg:status) %(tag)' |
>   while read status tag
>   do
>      ...
>   done
>=20
> would become useful, but we'd be tied to the behavior that we omit the
> tag when the gpg verification failed (for backwards compatibility).
> OTOH, we could perhaps make the rule "ignored unless %(gpg) formatters
> are used". Which would be backwards-compatible and safe for old formats,
> and work correctly for new ones.

This sounds like a helpful addition to implement. We could update/add
tests for compliance on this once the feature is addded and fix the
ambiguous behavior in the tests now.

Thanks,
-Santiago.

---
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f..0581053a0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -896,17 +896,15 @@ test_expect_success GPG 'verifying a forged tag shoul=
d fail' '
 '
=20
 test_expect_success 'verifying a proper tag with --format pass and format =
accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : signed-tag
-	EOF &&
+	EOF
 	git tag -v --format=3D"tagname : %(tag)" "signed-tag" >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'verifying a forged tag with --format fail and format =
accordingly' '
-	cat >expect <<-\EOF
-	tagname : forged-tag
-	EOF &&
+test_expect_success 'verifying a forged tag with --format should fail sile=
ntly' '
+	>expect &&
 	test_must_fail git tag -v --format=3D"tagname : %(tag)" "forged-tag" >act=
ual &&
 	test_cmp expect actual
 '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index d62ccbb98..173a88e89 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -126,17 +126,15 @@ test_expect_success GPG 'verify multiple tags' '
 '
=20
 test_expect_success 'verifying tag with --format' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : fourth-signed
-	EOF &&
+	EOF
 	git verify-tag --format=3D"tagname : %(tag)" "fourth-signed" >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'verifying a forged tag with --format fail and format =
accordingly' '
-	cat >expect <<-\EOF
-	tagname : 7th forged-signed
-	EOF &&
+test_expect_success 'verifying a forged tag with --format should fail sile=
ntly' '
+	>expect &&
 	test_must_fail git verify-tag --format=3D"tagname : %(tag)" $(cat forged1=
=2Etag) >actual-forged &&
 	test_cmp expect actual-forged
 '

--lskehgyyxkqhjxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAljS/9oACgkQRo8SLOgW
IpVFxA/+K2usB7pL6niXvakebHpBLR8cNgjWBstKIXm24THkZsJ8DevSpIFFseUH
Y/cv3Yq0L7sr+SBjNzAnvRd9cItVM4xyTlehSTzgbNqUBt/tV3/cWYd9l8yszE7v
dgAqbt/TxU4B7HRhhJiE6dWwUr2AAte4Lhf6n6uxG5NjhrwpFgn64aRNjkZzletr
a7LoSPRSMeuZZr3eRLZr2towma/lMJrNZ1fOyC6CQoW2wWCiXS2stlEXlmhY6YCg
vcbgLUl014fUcR0htarPXWo43KANaGSYjiZt/plY19vS8H5VSwWUS4YkU/fn5uJe
8THZcqIe0GnlKmVjaVuwr+lUQ0bGVEMGxcUlXYQLGs0uNpCNTPMV+/MeSUWx2b8i
P1tkxGmBE5XYnk3B2YEaxIeO/vK+Q1eiqKNH88Iou/WdBm6mwMCAphEQFJUWX5j2
VWVEgWzrYX5CX0B+B1/MLx5UtfDQgs701WZBhK6mP1tWi61jAovMUhzRiiDhB5rN
V1ZmDtbfbNCIWxzeTR/iMUtuKklnt2Z0oXcjLMNgu0HArZQ9xyN0CglVBB7A923a
bSAb9adfAsEzk8+d7I+WCA3X6B44BQoTpHvnJ4lulpuRGH6kBNZSksfaTCxi3U/v
DdzkEc3imsoxKd2RCzjPi4qowGV63RdqwD7D8x8BO2a7iCcr054=
=HXMh
-----END PGP SIGNATURE-----

--lskehgyyxkqhjxdp--
