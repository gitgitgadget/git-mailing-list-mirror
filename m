Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6626C1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeHMSCu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:02:50 -0400
Received: from mail.nic.cz ([217.31.204.67]:56523 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMSCu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:02:50 -0400
Received: from [IPv6:2001:1488:fffe:6:83a:b589:ce68:b04] (unknown [IPv6:2001:1488:fffe:6:83a:b589:ce68:b04])
        by mail.nic.cz (Postfix) with ESMTPSA id 2A5E06271F;
        Mon, 13 Aug 2018 17:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1534173606; bh=N8yuZPeYsw5YEWBfRSI6m07ELZQsMQB6K/beXe0zBXk=;
        h=From:To:Date;
        b=tFT4UOhSE4awSwS7vO5VG86FiWW1I/amOlVykud3M3qBJsvYYHrblN7g/AFEe/JH6
         zJ30TiGVCanaDIvgPQLVG3UU48U19cBisJXV1ZePoLdHLyobszt3Q3J5vjl6At97pT
         EiuPkHv5r976P1BE+VGByNK/p4uvnkIikbNdLzGY=
From:   Vojtech Myslivec <vojtech.myslivec@nic.cz>
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?S2FyZWwgS2/EjcOt?= <karel.koci@nic.cz>
Autocrypt: addr=vojtech.myslivec@nic.cz; prefer-encrypt=mutual; keydata=
 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
 gy8WZQDS
Subject: [PATCH] test verify-commit/tag to exit unsuccessfully
Message-ID: <b196ad40-544a-6909-abec-d87ccfd78aca@nic.cz>
Date:   Mon, 13 Aug 2018 17:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------38726762ED098C2693C91A36"
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------38726762ED098C2693C91A36
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello

There was a discussion in the mailing list with subject
'verify-tag/verify-commit should exit unsuccessfully when signature is
not trusted' which leads to handling exit code of untrusted signatures
in 4e5dc9ca1.

git verify-commit and verify-tag should exit unsuccessfully when
processing a signature by a gpg key with trust level set to 'never'.

This commit introduce verify checks with trust-model set to direct in
gpg.conf (to force trust level of the second key in the keychain to
never). In these tests, 'git verify-tag/verify-commit eighth-signed-alt'
must exit unsuccessfully and includes 'We do NOT trust this key!' on the
stderr (gpg output).

Formatted patch is attached.

Vojtech Myslivec

--------------38726762ED098C2693C91A36
Content-Type: text/x-patch;
 name="0001-test-verify-commit-tag-to-exit-unsuccessfully.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-test-verify-commit-tag-to-exit-unsuccessfully.patch"

=46rom 013678ac78ef42ef424a46da3b463ad96c2eb58d Mon Sep 17 00:00:00 2001
From: Vojtech Myslivec <vojtech.myslivec@nic.cz>
Date: Sat, 11 Aug 2018 22:59:49 +0200
Subject: [PATCH] test verify-commit/tag to exit unsuccessfully

git verify-commit and verify-tag should exit unsuccessfully when
processing a signature by a gpg key with trust level set to 'never'.

This commit introduce verify checks with trust-model set to direct in
gpg.conf (to force trust level of the second key in the keychain to
never). In these tests, 'git verify-tag/verify-commit eighth-signed-alt'
must exit unsuccessfully and includes 'We do NOT trust this key!' on the
stderr (gpg output).

Helped-by: Karel Koci <karel.koci@nic.cz>
---
 t/t7030-verify-tag.sh    | 34 ++++++++++++++++++++++++++++++++++
 t/t7510-signed-commit.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 041e319e7..6bde65c9e 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -172,4 +172,38 @@ test_expect_success GPG 'verifying a forged tag with=
 --format should fail silent
 	test_must_be_empty actual-forged
 '
=20
+test_expect_success GPG 'verify signatures with direct trust-model' '
+	(
+		echo "trust-model:0:\"direct" | gpgconf --change-options gpg
+	) &&
+	(
+		for tag in initial second merge fourth-signed sixth-signed seventh-sig=
ned
+		do
+			git verify-tag $tag 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+		do
+			test_must_fail git verify-tag $tag 2>actual &&
+			! grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in eighth-signed-alt
+		do
+			test_must_fail git verify-tag $tag 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			grep "do NOT trust" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+
 test_done
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 4e37ff8f1..6e34f98a6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -234,4 +234,40 @@ test_expect_success GPG 'check config gpg.format val=
ues' '
 	test_must_fail git commit -S --amend -m "fail"
 '
=20
+test_expect_success GPG 'verify signatures with direct trust-model' '
+	(
+		echo "trust-model:0:\"direct" | gpgconf --change-options gpg
+	) &&
+	(
+		for commit in initial second merge fourth-signed \
+			fifth-signed sixth-signed seventh-signed tenth-signed
+		do
+			git verify-commit $commit 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned sixth-unsigned \
+			seventh-unsigned ninth-unsigned
+		do
+			test_must_fail git verify-commit $commit 2>actual &&
+			! grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in eighth-signed-alt
+		do
+			test_must_fail git verify-commit $commit 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			grep "do NOT trust" actual &&
+			echo $commit OK || exit 1
+		done
+	)
+'
+
 test_done
--=20
2.18.0


--------------38726762ED098C2693C91A36--
