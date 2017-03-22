Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097052095F
	for <e@80x24.org>; Wed, 22 Mar 2017 22:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdCVWes (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:34:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35910 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdCVWeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:34:46 -0400
Received: by mail-qt0-f195.google.com with SMTP id n37so27183011qtb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qZHrMGBPyiqIJ8Cu9RWSNAL5dKGEgIg1VbQztuy6K2k=;
        b=j4fuh/LZgg5OSJIcOTyZh1QbqktgmJ6/QFl/X3Yo3n83zDWtxxJA3XEo6ZqTY4UFg4
         mS+JQhsMOEXkqrax0YnnbcnDwsgpAQ5/2IxyGP7UaYJlHnuLNEvdlxyaLmkUjQy+Uw1c
         2bKk9le/5JrK6edFpbYdeeYa+Q1zL9eR4iMEWRmcR8vdWxswXg6bN0eQNfOWoVOXxraU
         xPfzb99ouDcGU91HyDliQWyj4/U+D+k1j/nWxqn1cfOFzFWfiIvoNyvvlMaPw6eRFISP
         S3OqvQmnsIQyxod8MBqGFEPlog5HLrV2gqy8X6HzgGHFuwNdh1yZjJiu8mF1qoK1JK2c
         gE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZHrMGBPyiqIJ8Cu9RWSNAL5dKGEgIg1VbQztuy6K2k=;
        b=mVxY5oF96hZ1nLchiWiVHd6S3BNvZJRvizFnLm6/7hKhS5hu5rwc44feFeXiih5wJL
         d1h1KVS1ytdGrCPqwwWJlGczPPKwekf8qmvgPmw+k3qibdcBbJKtkYbftc2EzcQetpm/
         88/3Is6VZ26em8Ef4H8Fgvjs2ktDpeR/fIHnBWgAlUDTPEtdGl0EgXqeEIptVXKwZAOu
         /jGhIuopa3jOYWoixm7YEXbNTypfjZYEBxLNSc3UXrDuwAqwgvPmrvx+Z6M2en76PqTi
         f03q05u0nIgtotBpM0NIAZOCMq7yDHepCqxBD3zSlh2YLbVMtNeV3Ikoa0a6kbNQu0Lk
         haNw==
X-Gm-Message-State: AFeK/H2LDQak80u8/LkjOaB/FFTgTXhPaI+9dNcJKQBvOqJFJG9CQxJ67c0hV+untvGq1ZES
X-Received: by 10.200.56.141 with SMTP id f13mr29038688qtc.206.1490222085129;
        Wed, 22 Mar 2017 15:34:45 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id k30sm1941919qkh.50.2017.03.22.15.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:34:44 -0700 (PDT)
Date:   Wed, 22 Mar 2017 18:34:43 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
 <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
 <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wrqyllerdlwmijjv"
Content-Disposition: inline
In-Reply-To: <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wrqyllerdlwmijjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I worked up the patch to do that (see below), but I got stumped trying
> to write the commit message. Perhaps that is what the test intended, but
> I don't think tag's --format understands "%G" codes at all. So you
> cannot tell from the output if a tag was valid or not; you have to check
> the exit code separately.
>=20
> And if you do something like:
>=20
>   git tag -v --format=3D'%(tag)' foo bar |
>   while read tag
>   do
>      ...
>   done
>=20
> you cannot tell at all which ones are bogus. Whereas with the current
> behavior, the bogus ones are quietly omitted. Which can also be
> confusing, but I'd think would generally err on the side of caution.

In that case, something like this would be closer to the desired
behavior?

I'm also unsure on what would be the right thing to put on the commit
message.

-Santiago.

---
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f..70f6d4646 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -896,19 +896,18 @@ test_expect_success GPG 'verifying a forged tag shoul=
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
+test_expect_success 'verifying a forged tag with --format should fail sile=
ntly' '
+	cat >expect <<-\EOF &&
 	tagname : forged-tag
-	EOF &&
-	test_must_fail git tag -v --format=3D"tagname : %(tag)" "forged-tag" >act=
ual &&
-	test_cmp expect actual
+	EOF
+	test_must_fail git tag -v --format=3D"tagname : %(tag)" "forged-tag"
 '
=20
 # blank and empty messages for signed tags:
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index d62ccbb98..ba0aafa1f 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -126,19 +126,18 @@ test_expect_success GPG 'verify multiple tags' '
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
+test_expect_success 'verifying a forged tag with --format should fail sile=
ntly' '
+	cat >expect <<-\EOF &&
 	tagname : 7th forged-signed
-	EOF &&
-	test_must_fail git verify-tag --format=3D"tagname : %(tag)" $(cat forged1=
=2Etag) >actual-forged &&
-	test_cmp expect actual-forged
+	EOF
+	test_must_fail git verify-tag --format=3D"tagname : %(tag)" $(cat forged1=
=2Etag)
 '
=20
 test_done

--wrqyllerdlwmijjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAljS+/8ACgkQRo8SLOgW
IpW2oQ/9GHcvmSM7+mK9u7oQwoR5bEv39CjeiBPioh0TwXsVDWWyDzUEVRd6B5lI
mvSFH3vvzLCFK3ie/zhxPLampp9j7wKn1xeE9sdxSWrwEfRZV78xOMtJutySrg3o
2z91h4+f4f0WrcFQUbZTg/vPrgXbX4TiWvQBQ+a5ruWpzar6z8nR+aiKuAiaiHb3
KbWrX7GnxpZvqcJx7XU64qr38QkON/VFjmg4lfuIhIJ1jBmsQT/NxVkEzXPq9Ci6
+WfDAMBkdbc3mfVXeERazlv+xBFVyE80qtRamO+1Xtc3PM0MDBz/yXB4z24vA8rZ
L0K4NDslk7RQVz2W/ZrpurfP7KglKsGnmzOHJf8KPlglk/dufKFigpj23SJGjG+H
W2VbQyUq3O2p7MJDESCsdiyVF8YVbEWPqSQUbGuec5bJcuVF2Jeyk25gCgADJlOr
ed3a9MTjeW0iV9LioioX65piy/b3pLfwl8i8weLbc1+V9bwHZd3gMyqWLsXuPsDi
q9AGek5VFfhBdjFHP9NlcSOAyFkLmU5Nhu2FpOBSietNllSqVYFw95CugNHi0de7
9kcqTUnc/ezgwQM1v5LjEOCS2lzsH24skp5t7IPoSDah/qMRRs03552Gj4YtZSIE
z2dETvRPw4bDFX/yH4giVIon1xyxdJMFJ/6jn/WP5j3gT3NJ6/k=
=vLnK
-----END PGP SIGNATURE-----

--wrqyllerdlwmijjv--
