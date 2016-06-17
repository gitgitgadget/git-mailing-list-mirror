Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477CD2018A
	for <e@80x24.org>; Fri, 17 Jun 2016 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbcFQHqW (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 03:46:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42800 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755075AbcFQHqT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 03:46:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D409209EC;
	Fri, 17 Jun 2016 03:46:18 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 17 Jun 2016 03:46:18 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=d5WSS8X1w9OoMMe0UnekJV6aY3k
	=; b=Pytht3NHUUMaEElQBOSYfcVHxAc6o8fwzqOEt0s2AaCJ8ZuQneyqEWSo4Bs
	OVjJj4p0mO4/crTAcQ+30WezaH53NE+6Ns0ZCKNaNpAKIPnkZZ93AnKvSJRXnj2c
	sUVKYLFDOrE8y74KrwjijpENy7P89MB3BpHjQTbBoCCJJ7Ho=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=d5WS
	S8X1w9OoMMe0UnekJV6aY3k=; b=UPQTUTEPK90aKpEvVAaZQG0uD9yjSpbNT26t
	BriaqsyyJeFrU3Gwajf5IPBDH2j+eNenckNBQhU5WBfQjUbGUg/Hq4/NRP9NIxaa
	PejJl3WWw8uXbcuUJHnI1bnZMmDpZhlbIkTP+sDkmsLvJjBa2V8WtGDiArwJ9TMi
	dKk0Hg8=
X-Sasl-enc: b08W8mnLjyXUhIEQ7732uQfwdnhdI7j8jU0FQ4KyRB+Z 1466149577
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id A3162F29F3;
	Fri, 17 Jun 2016 03:46:17 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCH 3/5] Documentation/technical: signed commit format
Date:	Fri, 17 Jun 2016 09:46:10 +0200
Message-Id: <d2e095403e10e128c79cfb3421151c2e3acd79bb.1466148698.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <cover.1466148698.git.git@drmicha.warpmail.net>
References: <cover.1466148698.git.git@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/signature-format.txt | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 833afff..8ae1dc3 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -62,3 +62,51 @@ signed tag
 
 signed tag message body
 ----
+
+== Commit signatures
+
+- created by: `git commit -S`
+- payload: commit object
+- embedding: header entry `gpgsig`
+  (content is preceded by a space)
+- example: commit with subject `signed commit`
+
+----
+tree eebfed94e75e7760540d1485c740902590a00332
+parent 04b871796dc0420f8e7561a895b52484b701d51a
+author A U Thor <author@example.com> 1465981137 +0000
+committer C O Mitter <committer@example.com> 1465981137 +0000
+gpgsig -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1
+ 
+ iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
+ HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
+ DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
+ zn075rtEERDHr8nRYiDh8eVrefSO7D+bdQ7gv+7GsYMsd2auJWi1dHOSfTr9HIF4
+ HJhWXT9d2f8W+diRYXGh4X0wYiGg6na/soXc+vdtDYBzIxanRqjg8jCAeo1eOTk1
+ EdTwhcTZlI0x5pvJ3H0+4hA2jtldVtmPM4OTB0cTrEWBad7XV6YgiyuII73Ve3I=
+ =jKHM
+ -----END PGP SIGNATURE-----
+
+signed commit
+
+signed commit message body
+----
+
+- verify with: `git verify-commit [-v]` (or `git show --show-signature`)
+
+----
+gpg: Signature made Wed Jun 15 10:58:57 2016 CEST using RSA key ID B7227189
+gpg: Good signature from "Eris Discordia <discord@example.net>"
+gpg: WARNING: This key is not certified with a trusted signature!
+gpg:          There is no indication that the signature belongs to the owner.
+Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
+tree eebfed94e75e7760540d1485c740902590a00332
+parent 04b871796dc0420f8e7561a895b52484b701d51a
+author A U Thor <author@example.com> 1465981137 +0000
+committer C O Mitter <committer@example.com> 1465981137 +0000
+
+signed commit
+
+signed commit message body
+----
-- 
2.9.0.382.g87fd384

