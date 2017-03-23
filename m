Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6200620958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756016AbdCWW2v (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:28:51 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32787 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbdCWW2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:28:50 -0400
Received: by mail-qk0-f194.google.com with SMTP id p22so4881223qka.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gn4FKlLHJIIxomgxS/yoiS8EytusPXsSJRirt+tabFo=;
        b=Z+w5s6H8+SEQNZPPvkc0UUcwPVYHSqx3vhGJe8acODRa97KfkwO72Pdy324RYaGdO6
         ouifbycnyhVtWc/YZp6qdOVqtThBzkkuIFUao2t5sQ0V0AGkNYxGzCEM8YBOBP5Ad8xq
         LXIXTd17rytIbuNha4Wmbm/9PhFUAxI6CTUDspHDB9kqsRs9ihRffubekOhN/1N3ayoV
         DSoYiXaXjlny6Dnzv7Xk8VTcj8bPSHLoZHG0jbDjX0Dp9dTCACGTIpW5HYffiQ/j+KPa
         g7Fzvbm14JDl+tlziMZB2aGnJgDNjtme0cjXnfrAoubaEVthFnGRQnB2C2H8KkIWp6nL
         46EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gn4FKlLHJIIxomgxS/yoiS8EytusPXsSJRirt+tabFo=;
        b=T/yhy12t/CBON989SQI0b6p+sAE+pj8UTO1GLz6XxL5RhjKUfrwhjOw9vZBYjK7thk
         0U1k7pcRz/pnie5Hi2YU/OgCloiaeC5ER/gUfQ+H5XNl/oCsountiLjDpznyP1PA++8D
         VfgRMDL78gWK1g22BE0cxQc0rorTX5RcovD8GQLvP1ym+RcdEaeO9v/qPdMR85n6hwHv
         pxmkAR6HX2M+W9HqWal33cR5pI765sKNhRqIIQWLW3U3OXaSXDEpqDtNveRvRZTP/rPP
         hMBoWEicEe9967V8p9kuYM1yDQzT6A/FP0GMECN2eSgfnwnoh5kKb03ygnEBEJAL87Jg
         Bb3w==
X-Gm-Message-State: AFeK/H14343+dtzTSjgOhbtHxmckWmiTMYlaxHFkNXWlsEtZYNE/3ySxiA1sq9N2A2j/Tn9b
X-Received: by 10.55.180.70 with SMTP id d67mr4872089qkf.280.1490308128738;
        Thu, 23 Mar 2017 15:28:48 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id p184sm282588qkb.17.2017.03.23.15.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 15:28:48 -0700 (PDT)
Date:   Thu, 23 Mar 2017 18:28:47 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170323222846.twxktig335o4r572@LykOS.localdomain>
References: <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
 <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
 <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
 <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
 <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
 <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
 <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4uj6p6jr5haddpkp"
Content-Disposition: inline
In-Reply-To: <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4uj6p6jr5haddpkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 03:00:08PM -0700, Junio C Hamano wrote:
> Santiago Torres <santiago@nyu.edu> writes:
=20
> OK, so has everybody agreed what the next step would be?=20

I believe it is, although I imagine getting a confirmation from Peff
would be adequate.

> Is the patch below a good first step (I still need to get it signed
> off)?

I'm adding a signoff to the patch below.

Thanks,
-Santiago

-- >8 --
Subject: t7004, t7030: fix here-doc syntax errors
=46rom: Santiago Torres <santiago@nyu.edu>

Jan Palus noticed that some here-doc are spelled incorrectly,
resulting the entire remainder of the test as if it were data
slurped into the "expect" file, e.g. in this sequence

	cat >expect <<EOF &&
	... expectation ...
	EOF
	git $cmd_being_tested >actual &&
	test_cmp expect actual

the last command of the test is "cat" that sends everything to
'expect' and succeeds.

Fixing these issues in t7004 and t7030 reveals that "git tag -v"
and "git verify-tag" with their --format option do not work as the
test was expecting originally.  Instead of showing both valid tags
and tags with incorrect signatures on their output, tags that do not
pass verification are omitted from the output.

Arguably, that is a safer behaviour, and because the format
specifiers like %(tag) do not have a way to show if the signature
verifies correctly, the command with the --format option cannot be
used to get a list of tags annotated with their signature validity
anyway.

For now, let's fix the here-doc syntax and update the expectation to
match the reality.  Maybe later when we extend the --format language
available to "git tag -v" and "git verify-tag" to include things
like "%(gpg:status)", we may want to change the behaviour so that
piping a list of tag names into

    xargs git verify-tag --format=3D'%(gpg:status) %(tag)'

becomes a good way to produce such a list, but that is a separate
topic.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
Noticed-by: Jan Palus <jan.palus@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 t/t7004-tag.sh        | 10 ++++------
 t/t7030-verify-tag.sh | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..0581053a06 100755
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
index d62ccbb98e..79864a3411 100755
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



--4uj6p6jr5haddpkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAljUTBoACgkQRo8SLOgW
IpVyARAA2NROzvOrKpCdxntJyqlAdJYsBc3PsO5tH0NRoPfg299FUD7HnW37xnPE
ttx1ERqOnvMjSn/DCH9p9OFz1l8dfSfKXPEBHM/7H476K8v+nAFHaTgu6FJZ1r2G
t18jFNT2vH8dHnM5nusPIbmvVfg6yb6BmCi9fGmei8JayHscBGpFf3KbKEv8jTtc
RvyQDD2WGRtddTUW51girSnv1Jyh3kotgJRd0rQ7Gs4PXOrDgjpbHxdZeAfGn858
044uKrmtVgLAfK2kwaCZDHclymt61LiR8MnYkUbxsHSELa2rL74U8PkSZIXCWVLL
b5lr/Y9QmQrA8tiDE2EbrgsEeIibRSnONBS8UdPWQPk/xYzcFrj3dWtKtH1yR8pu
8Bi8pTb2mSGaMONlPxYM61OJZNAwcDFy9O0nppQAsf4++B5cagoSQrUn549hlHQn
NcUAHk6zSBYcFuI/R81AjkD8/tTL1fq8syk9uDQFsXe/bkvbnvOmKWLIMQ7Tb+y7
5uQv8oRu7DYYazxQ8EgvD5DtDZOKNA6yBBkkd18TDz8FOrDgRcCG1Ew09i1u5I7J
cSJPKxPboFXYwvsovo6fDWpO16YLMLEyLR9rXuZqGV1wmVYt1S5Jlz1ZZkm731By
v/TUk63CsLb195OIND8r1O4UC0c+MY2AW1lfBWWug4s69a9B8mU=
=PMH7
-----END PGP SIGNATURE-----

--4uj6p6jr5haddpkp--
