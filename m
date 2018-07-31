Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FC71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbeGaVyr (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:54:47 -0400
Received: from mail.nic.cz ([217.31.204.67]:34774 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732814AbeGaVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:54:47 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2018 17:54:45 EDT
Received: from [IPv6:2001:1488:fffe:6:83a:b589:ce68:b04] (unknown [IPv6:2001:1488:fffe:6:83a:b589:ce68:b04])
        by mail.nic.cz (Postfix) with ESMTPSA id 63155604D8;
        Tue, 31 Jul 2018 22:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1533067526; bh=+u4a6LgHNq0TG5GTNaYZZjzIvr+tIKLljuRtJKoS5+U=;
        h=To:From:Date;
        b=Jy+ZDIQuqcnixyy1IQODXrU3sOcl+ap0rANBhLJxQhwR5YtfrdqOkfxqcJJPVhCyZ
         /CzPwL7VvcMqIHPqXVCWXnpIKTIUloT99wUquW+F/8LxAqHGB8wy1Ed8ThZeOP3QfE
         VZucfPWjRdrXejIBZEoM83EsTQILURghNZXI6cCA=
To:     git@vger.kernel.org
From:   Vojtech Myslivec <vojtech.myslivec@nic.cz>
Autocrypt: addr=vojtech.myslivec@nic.cz; prefer-encrypt=mutual; keydata=
 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
 gy8WZQDS
Cc:     =?UTF-8?B?S2FyZWwgS2/EjcOt?= <karel.koci@nic.cz>
Subject: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully when
 signature is not trusted
Message-ID: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
Date:   Tue, 31 Jul 2018 22:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J1JdOdN582QkYpOOHW1U33Opk8z14T3cs"
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J1JdOdN582QkYpOOHW1U33Opk8z14T3cs
Content-Type: multipart/mixed; boundary="nNpVZFDSmoLNfwmkkCOEmNtaMqZuqrHG1";
 protected-headers="v1"
From: Vojtech Myslivec <vojtech.myslivec@nic.cz>
To: git@vger.kernel.org
Cc: =?UTF-8?B?S2FyZWwgS2/EjcOt?= <karel.koci@nic.cz>
Message-ID: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
Subject: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully when
 signature is not trusted

--nNpVZFDSmoLNfwmkkCOEmNtaMqZuqrHG1
Content-Type: multipart/mixed;
 boundary="------------B3A55C7DCFB783AF18949BB0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B3A55C7DCFB783AF18949BB0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

me and my colleague are struggling with automation of verifying git
repositories and we have encountered that git verify-commit and
verify-tag accepts untrusted signatures and exit successfully.

We have done some investigation of the GPG verification changes in git
repository which I includes in this patch message. GPG results
`TRUST_NEVER` and `TRUST_UNDEFINED` in raw output is treated as
untrusted in git (U) and should not be accepted in verify-commit and
verify-tag command.


In 434060ec6d verify-tag and verify-commit was centralized into
check_signature function and good (G) and untrusted (U) signatures were
marked as valid and exited successfully. In this commit it is
incorrectly stated that this behavior is adopted from older verify-tag
function however original verify-tag behavior was to return exit code
from gpg process itself (removed in a4cc18f29).

Also rejecting untrusted (U) signature is the pull/merge with
--verify-signatures behavior (defined in builtin/merge.c cmd_merge
function and presented in eb307ae7bb).

The behavior of merge/pull --verify-signatures and
verify-commit/verify-tag should be the same.


With regards,
Vojtech Myslivec and Karel Koci


--------------B3A55C7DCFB783AF18949BB0
Content-Type: text/x-patch;
 name="0001-gpg-interface-Do-not-accept-untrusted-signatures.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-gpg-interface-Do-not-accept-untrusted-signatures.patch"

=46rom c9c7b555da284c4f67fe36dc95d592644089544a Mon Sep 17 00:00:00 2001
From: Vojtech Myslivec <vojtech.myslivec@nic.cz>
Date: Tue, 31 Jul 2018 20:32:32 +0200
Subject: [PATCH] gpg-interface: Do not accept untrusted signatures

In 434060ec6d verify-tag and verify-commit was centralized into
check_signature function and good (G) and untrusted (U) signatures were
marked as valid and exited successfully. In this commit it is
incorrectly stated that this behavior is adopted from older verify-tag
function however original verify-tag behavior was to return exit code
from gpg process itself (removed in a4cc18f29).

Also rejecting untrusted (U) signature is the pull/merge with
--verify-signatures behavior (defined in builtin/merge.c cmd_merge
function and presented in eb307ae7bb).

The behavior of merge/pull --verify-signatures and
verify-commit/verify-tag should be the same.
---
 gpg-interface.c          | 2 +-
 t/t7030-verify-tag.sh    | 4 ++--
 t/t7510-signed-commit.sh | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 09ddfbc26..83adc7d12 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -86,7 +86,7 @@ int check_signature(const char *payload, size_t plen, c=
onst char *signature,
 	strbuf_release(&gpg_status);
 	strbuf_release(&gpg_output);
=20
-	return sigc->result !=3D 'G' && sigc->result !=3D 'U';
+	return sigc->result !=3D 'G';
 }
=20
 void print_signature_buffer(const struct signature_check *sigc, unsigned=
 flags)
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 291a1e2b0..d6f77c443 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -63,7 +63,7 @@ test_expect_success GPG 'verify and show signatures' '
 	(
 		for tag in eighth-signed-alt
 		do
-			git verify-tag $tag 2>actual &&
+			test_must_fail git verify-tag $tag 2>actual &&
 			grep "Good signature from" actual &&
 			! grep "BAD signature from" actual &&
 			grep "not certified" actual &&
@@ -103,7 +103,7 @@ test_expect_success GPG 'verify signatures with --raw=
' '
 	(
 		for tag in eighth-signed-alt
 		do
-			git verify-tag --raw $tag 2>actual &&
+			test_must_fail git verify-tag --raw $tag 2>actual &&
 			grep "GOODSIG" actual &&
 			! grep "BADSIG" actual &&
 			grep "TRUST_UNDEFINED" actual &&
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6e2015ed9..5cb388cb6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -89,8 +89,8 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
=20
-test_expect_success GPG 'verify-commit exits success on untrusted signat=
ure' '
-	git verify-commit eighth-signed-alt 2>actual &&
+test_expect_success GPG 'verify-commit exits unsuccessfully on untrusted=
 signature' '
+	test_must_fail git verify-commit eighth-signed-alt 2>actual &&
 	grep "Good signature from" actual &&
 	! grep "BAD signature from" actual &&
 	grep "not certified" actual
@@ -118,7 +118,7 @@ test_expect_success GPG 'verify signatures with --raw=
' '
 	(
 		for commit in eighth-signed-alt
 		do
-			git verify-commit --raw $commit 2>actual &&
+			test_must_fail git verify-commit --raw $commit 2>actual &&
 			grep "GOODSIG" actual &&
 			! grep "BADSIG" actual &&
 			grep "TRUST_UNDEFINED" actual &&
--=20
2.18.0


--------------B3A55C7DCFB783AF18949BB0--

--nNpVZFDSmoLNfwmkkCOEmNtaMqZuqrHG1--

--J1JdOdN582QkYpOOHW1U33Opk8z14T3cs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEExoB7V2ZdP0Ia+gPaP34ZKxNJtIQFAltgwQIACgkQP34ZKxNJ
tIQamQ//euu9zAMhUQTzhcal7pOO6fpR7QtCE+23AP0sPMPz9EGxvCLIoW0h6aqP
cOtH4hLeN4ggKfbZEL1b7YQZATNe6iEC/tl5OlmLyvp01UzfDimmSMpOFSa077O6
x8YpDmB6mQO5FJUpAtaR+CPD2YoMgASupwzikuXHQhufzUW3C3rDnycY45Jv/rqW
WwxrqQCafXeqsiqVYt3LxirULiXXpSXndSY0cSyUL52hx/7Y0LxQtf6b8Gv2G3QP
JIfbeiNCXQJO0ilLA6prpkGN59VWgeCiBWL4Dvr4eyHctOcL4BCWEz59Pit1puF/
cR4bisuseV9AyrVbsFOIPlciBl19cU3jBXs+zalPCwcU9bVnZUu2ScCx1WaAtctU
LVkiPJTVVbHu0yuSUZzLKkY4zb+5ig+0wPuukq/EpqoJXQsw1QBUdpqp3Pvr0YvX
XQoTvivGWULp+GOSUCjIWXw3LYTo1/MUgeCvjF9N1IFHEhCbkM5Wt8ASFPeLQ69c
9ECmHGIk4f5PK1XujT4p885n7TSbnK1zeBn4ZzHrlq1GQ+/Equ9VXkNuTSbImKd2
gpQT0zY/10+g4OHA+Kn74kBh9iMPrkJgBs9K9fg7aLCsHXcuzq5uiyEUiIzvwln8
fNUFCCNoclkDE/7nIc0G8O+D48bFV5uCdFVwSg8aQa2bUuptiYw=
=04bc
-----END PGP SIGNATURE-----

--J1JdOdN582QkYpOOHW1U33Opk8z14T3cs--
