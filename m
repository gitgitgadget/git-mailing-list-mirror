Received: from sonic305-2.consmr.mail.bf2.yahoo.com (sonic305-2.consmr.mail.bf2.yahoo.com [74.6.133.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4F33A039
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681123; cv=none; b=i2PSlA+NZSsiA/bBzaOsiTrYIHeyMwEKhNtnSq64j5tuxTpHgM9hnur5nUlENur7oimkx9IjLHEQ0m6lWE8AgyCVM4U68LSAYeLg0/qPlkKgzF6I9YnGrXOZvsbUid0da/jLQ4YR2FyjyPs9u/51Iv412fxeX/2xhp5/Di+Qhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681123; c=relaxed/simple;
	bh=z02p49StLcjPzY3O2H5hpVyej9zhOPnW42Rw4ZStjSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3s3e8OVmOyzNAi5PLl463y60gK2K3lsD6XQb3JtfYvyoZBM4dFWpr+uzEdmKGbIG+IbfUvo8rYazcfk63nEcB+6Px1uXeU7rI7fpwWpzz+V6zzZhiFE7rtVMiKy6+M7rSwsX7/SR/nEg+a83YUynWP9vOC9JaqIv2Q/jLUZdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UQcItfL+; arc=none smtp.client-ip=74.6.133.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UQcItfL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773681121; bh=0/b+NMCxbZhTaS74jxbbas+xgtYw3zXB1stVjfYP0/Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UQcItfL+EFvXq7o74WAAXeeK9zrkledhjsNjLmVEZJL0AOnIBR4w8it89OXj0ou9J2AReF45dq+7dJS90WY5kYmkTeB5VghjYzjWgR1Re6sl0nfDEZisN6O5iNFyIqiBBlZNXMhD1YHV4+wuuer6t5A5EZ+XPdZKslAVbH9Q/Om4uf5LKYMfxr9IOWGS7aOolITzYhWLOv+WjLOtgp8x4kgqWC8Ne4kxuozrRQdflghOFI8P4NFZr0c7ET9kzJ45psIp4EMNblSxRt8mEoLnj9aFVfEdEc9WYO+Zkfi4BeMD2pMFV2hVkArJQs1s18tEJLGg69Ma0HL1LyomumM/Og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773681121; bh=9sOAw9SKTm4fBEmNmrt/A7+IBa2Jvj3i0m89ugCZGRe=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=r3fpKiKNHpr9W2sB20Dw7XOmPLKeYBxm/plyBbQ/S8WADn55BY2Shw/9q+tARfW2QAJHtU25C7QZ6XMNmyd1UGcSJ+uAGNJB4uPs65x0o+wmD9iZQ+hLOhv3Yx29XV+wELZ6VrOeBcs0O7FdnB7ziXbQV474Kq7t/KzniP7r7JqDwYsVbvQVQnRr9y9XbDU8o3N2LmmJ4nvpn75S+l6bO1OpL3HlocpDpwwUpId8LcGYV91i1BfOewgO9GddXVFovfQk0I+iPvij2ZZVxXVlfPEmd2BRQDFe94diNRubre4EqRNVf7gOfRcmsPDKGLDl8gdmSsNpJahTuUs3wP63DQ==
X-YMail-OSG: q3gsP4YVM1kUPt2Xj.jYE9I.g_LDZAYn32GkSsqruwQgzY5jYQowmtoF2fXysTA
 XSAKj1bOXkt8u8iDe_r2fCglMsimHp7m0aQdq4kdfukbDhqynAhy4EFG4Q7RCpi77qAjkS4dS82A
 e130PEBrcm.5jKXHd7Yx1c9eFdry5wbIyrjn1L0iISue1.BlxNabnoZLO.ChZQgEiqVfwjLx1gSr
 f72zeQDFk2btYfE3vdQDFUzbibKVkR5xU3BucgAd50T6CZJkXTcot7luagwV6fok846GJgOcevgW
 vI4hwGa7Gp0yvReDYAWPdGJhMWAAQmP33y6xJKQcDx_q.bE3iAeyhIiGLvdkaxlt1MPQ3qKaPVlF
 uT6nND39e7SIQGVMQx1IbOkzjghc676x5.8Ar2bYym5hK2OeIE3_zNB9ZRSktyCbfYhwLJQUqH2I
 JZ278GGdOfKimLcys6xYIVDAj7q86rEeFGJLNADMpv_JsGO.6ge4l46h5FWTBwTYZsX2CvdrTR1k
 AhhvDCKMNApUoSAroAANRnzklE1fbx7wWCzQTxLIGCKG_7wv.fz8fwsPfbOE7O8rC5wquMUvHEiq
 qZ6wQOH1z2Cz3.V4ST46HSqzUKQnPpA_gebeKrgHwGHOgjq0sW3bm.JT757QRm.Fph2pbnxTQQPN
 e9jxFX_SAplnK8CNNw1zlop0c5YzSDt2CLsyPLSL2rgD7MK90dq6OMcTxu2SWL3el0oDvS9UAmHU
 mqnLFFg407LIDg6mOunvxqo0o1dweiJypo633tXoRPf_k0cxhEK8ymoqv6npKh.tpyRMWsp4xFIJ
 9dtv_nsV9Bq7rvdGniJcg3AQOJ13gCmm7YTxFUys.ealPPr2NArvwOIyFZ3GARMg0CR14Uu0Z8pP
 c90YkO4thkHWdf1Pt1sZ5o8cDVgJjABxMmDvHYFB.UbdP7HKILYRkh0W_o3.J23IvYpQ3kIGDfCb
 A3gFeV6nM37YVipQ8srkmy7ccDtkzuktjiJw2sc.rxoGFyKUUTpTY9bM7.1HscZnxdX.T96pSQc6
 YHTbv9f2wNAfa7Qs8u31GTm2tzLepqWkHCwTd8Nc5u5SQtYycRVmm4YsNA67MjIljXFEqqp_yUZi
 AUND0yM_Y3tcbZncaAi_JkWw7NfKlRICQck7NlImIO_bGHLILC7l.3O._wmumhKs4ClT39btD03D
 YnoLPF.xrJqRhlV0sJNwERE7r4qemM6No7QaiYWr0dvPj3uTSa1Me7sar2xEVIweOyISI1kZvH3P
 rHL6qgLbua87Us_QuAKJzN1x2AUKLlDjH_rMWB9jocf7wNmlqfyJiR6d2U2LZqYcLkgiAkhoRhTs
 oh9KnV6JVjlbI.ChlKv3H6yTgT6GqpMWbpB38t.1GSQggIzfv6d_DKUac_hRyzfU.B0Eb4wLJqOb
 kCDH5rk_S1Pzh6IBUcqg75zAEsGJsMD4qHYbf8YHHFi_TTgRxMTIAv8oMEGsiTl2botiBtL2yYyF
 8xE3wSCWCHr_d0ctpZFCtFI_dy5FtWJ.noZsS8krCt7snL_PkuuHK6iQV1YQZsLPkNvIGiux3D43
 rq_qOrzIr9i2zk4EL8RNvi4me_8lkUUN.AWoWicV3.z.qz6JnNBPGH.fa.tE6pnKdy7qHFlvgYFc
 GtpOAI7GLKbo_gaUBVX0u5SpBkg.JrNuikxER80YxdrsgiZBDdXnbuCZ1nU4xqMGduqhkZOaLPH9
 5KC_xoXw7VUqzvs_P7XBSmzRwmclO5Fblrglz7g4VIKkcbpHhQrQ1y.7ZEfiTP0K3rhOXWPAg5_H
 tP6qA.UlJHwiLbHcZtvyU24M0CqwSsfJPRZx75BYNdhdHHfHgAC2x6RDhMRyUPJcPZkt4ep.j8_v
 kLE5BZ01BAnpr9aHTT6hlHfqnUkrfU9DhGw5NiIWvlXgOcqTPSHsBngDpXdLV4Kk3bN7293bI7gL
 M3_V0x8E8dGlsJPjzW3ydqR8OaNHSI9hsv8UPgQPUdKCB9PLQ.VGwyuNb59W9tG7kYn7IbnebM9j
 ZA55kM.dBXxiWfM9xEONA9Mcr9b_JQIJ9tbNVWrbiNqLBWyzjO88i39.nnhcpWNrFsr07pGJz4RG
 eY._M5dqnlG5l6Fa6HEnLrCu3FZoXHP9f_oqxJjlPbVyZ4H0bkPYdihzvgYEg6RztFGiN9eyYhN9
 jY8plE30d9BRIWRuKIFMN3TI1sewx1qPvaXXtYFG8PMWJTpjj4fkrGkjMn_GkqVVXkd8xtbU7N1T
 jNvR611p5N6VraJaJUwug7G1dsobxGmwRgYHdYoTy5yGkq7QkcQ_vvH8hQwQTEBep223YgIR3Ajz
 FLYVYIlZ4NWS_zz0TZ.Gz1iY5DUA2_UKMOsA-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: f1c04ef4-6b07-45a9-8cb7-4ded98fb59f4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 17:12:01 +0000
Received: by hermes--production-bf1-697f88457-frvld (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa82ae2f37a216edfe9aa66572e44e19;
          Mon, 16 Mar 2026 16:21:24 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: jerrywang183@yahoo.com,
	karthik.188@gmail.com
Subject: [GSoC PATCH v3] apply: report the location of corrupt patches
Date: Mon, 16 Mar 2026 12:21:23 -0400
Message-ID: <20260316162123.84532-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315231538.68586-1-jerrywang183@yahoo.com>
References: <20260315231538.68586-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing a corrupt patch, git apply reports only the line number.
That does not tell the user which input the line number refers to.

Include the patch input path in the error message so the reported
location is easier to use.

Reset the line number for each patch input so the reported location stays
correct when multiple input files are provided.

Add tests for file input, standard input, multiple patch inputs, and
existing binary-diff corrupt patch cases.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
Changes since v2:
- update t4012-diff-binary.sh for the new corrupt patch location format

 apply.c                |  4 +++-
 t/t4012-diff-binary.sh |  4 ++--
 t/t4100-apply-stat.sh  | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index b6dd1066a0..b7b0a201b3 100644
--- a/apply.c
+++ b/apply.c
@@ -1875,7 +1875,8 @@ static int parse_single_patch(struct apply_state *state,
 		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0) {
 			free(fragment);
-			return error(_("corrupt patch at line %d"), state->linenr);
+			return error(_("corrupt patch at %s:%d"),
+				     state->patch_input_file, state->linenr);
 		}
 		fragment->patch = line;
 		fragment->size = len;
@@ -4825,6 +4826,7 @@ static int apply_patch(struct apply_state *state,
 	int flush_attributes = 0;
 
 	state->patch_input_file = filename;
+	state->linenr = 1;
 	if (read_patch_file(&buf, fd) < 0)
 		return -128;
 	offset = 0;
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index d1d30ac2a9..97b5ac0407 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*broken:\\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
@@ -77,7 +77,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*broken:\\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index a5664f3eb3..b19fc9fe50 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -48,7 +48,43 @@ test_expect_success 'applying a hunk header which overflows fails' '
 	+b
 	EOF
 	test_must_fail git apply patch 2>err &&
-	echo "error: corrupt patch at line 4" >expect &&
+	echo "error: corrupt patch at patch:4" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'applying a hunk header which overflows from stdin fails' '
+	cat >patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -98765432109876543210 +98765432109876543210 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply <patch 2>err &&
+	echo "error: corrupt patch at <stdin>:4" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'applying multiple patches reports the corrupted input' '
+	cat >good.patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1 +1 @@
+	-a
+	+b
+	EOF
+	cat >bad.patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -98765432109876543210 +98765432109876543210 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply --stat --summary good.patch bad.patch 2>err &&
+	echo "error: corrupt patch at bad.patch:4" >expect &&
 	test_cmp expect err
 '
 test_done
-- 
2.51.0
