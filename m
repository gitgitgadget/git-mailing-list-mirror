Received: from sonic309-14.consmr.mail.bf2.yahoo.com (sonic309-14.consmr.mail.bf2.yahoo.com [74.6.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D64207A
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954562; cv=none; b=R9mftJTEj6tNYkWdsGGmJIon1ag5/mrw2w20kXHcqC244cKNHw8mLvATKTEAPfMUDAiavfLGMMG2suY6jKrfs/vk8NtyIm/+moP1SYNgpaIOHMOcp2dxBLR/zn3QaEghCXuhNNmZAr/dPLRgziQP4JXofOJWFlbh5cd+kkO57Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954562; c=relaxed/simple;
	bh=I2sfJZW4r6xzvMrFsA4BR7rXlpaycX5QjFMQ9h+RqIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ7JUPYFHvHplPSQiNw9WRFYWvV3AL5UQM1urOw/FLEVKeKU93PlkHwYfK3s8pSRcAH393DSHH8D/uEARe71aH9VidXS1e9Y9LZQMIFDO42qz+JwYEKIZJDv6QBY+bk9COBDMUZYYDAwQbNY9mu9RvF/oyIzCMZ9tXY3esv+L/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SoLVt7F2; arc=none smtp.client-ip=74.6.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SoLVt7F2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773954552; bh=i7H49bDR6GHxoSwk+CFs8wpQQJxQhpTEVZsgA45uMkc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SoLVt7F25xUhES4PckaH7uquIl8tQXie0L/B6ROEDtz98zFMRyTmYQt3SXCuTthE59lIh1LHL0AAszIyn6yp6GLgkMLrc5++HIxUA234gwX1RdccLO8MC51IzuY+OKK6yRP+36DLg7QA/VJD2u/Fhai1fnibgy2dEEny+S/jkttbb0cViERTtJuzOzm26nj35w5DTsBjqKJ9mDwYtUtvd3ovnuKihmQFdIYgk1Uh0JkOLpDO7r+aigfbUq8P/TdxRkqRiMSoXtWHrcbZXKASyv92i9IbDTEjQL8k+KXxS59cz9XhUZih6/1ih3oLVccaU+ZdwPbvAffOG8tDpPiCbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773954552; bh=j06Cf6wIDUOFZJ4fjO5uoodJiysbJNygCWBnvviFZeI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qK5fGLDpn67S7iomOh0XoPON8xdJurButy1HrcBpMvAVV1jM1lShkMMKO0r0XlNLDG0t0X87Wm5ZVTOmCwVPrOsmmaX90MXvHFSaHDKWVM3Nkc/rSX39EWaUHog6dZjierlw2Kq3FDsarbERjSrb3dM6aO4tqYxSNea4Q64pUd3wLYDIfUmMIRP5Bii9SfyqKYs7i3PlzJfiGwmEoe1yf1fqUnIoIdX9szDhqahwFVqAvZOSxAP8Va7u30i2OOti4FqR51vkCRHiokgPVPdfTjtIkKCEl4TOe2QDAO8imIqFF8o2ljhw8hp8cdLFt00J/lWSkZ87KBrICRmGmVFIYw==
X-YMail-OSG: hbnccD8VM1kYf14DgKjPy8UaCE51bJ4n.XuoU.zvx2fCDsUjLp9zBnFnyktJSaT
 X0ItdiaORsfhO0xEZs.LOH_CY1XUFfJq.9HzzNz5sl.AL24P0H2k7hAan6wwwZSrqQYqPN_puxaO
 LtsNYbcUsO1MbD4QAfimUtTOLSLnNg_Vd1fjJLhz.Xg0CpwdmATzGbBEpxrFRHPrJs4H7friMvq9
 c.C4CLbzjnx6Bl_V2csb6Cqp_6zRh79TUzFj7jgZVJRfqyRimqlS1_NYE7aMdl742QS5Uh0gvzgO
 6ywtruEbAIp_uXRs6hlNrF1q2SNfxEuhNMsGlqczZUsZ9PjvQOY19enok3wUcKfQ5reGKNVFSFwu
 PtgSJ9vzm8JSmUy1B_mFjycrwgc9PY08dIk6SgaAN8eF6yjQVIDLLvf8AKgftK_C6rA32PzctfLI
 IOULOM_wIpV5gnNK5rZHP8D1ZLJZERMmT.6wTs3nd.Xe4gxYDjFOuk8C15mu4B.SBqXWqnMEfTV1
 AknSFZHtfnLgNDRWLSLNDEe0Pi1HeA6K_Qmv_zLmSC1M6pvobYW7P6ZoCjms6KQtAw8966noQJx4
 Wr1lhCqf7oOeXOAAoorCH912kZTvDRRkBbDEqfBFekuqG3CFq8vjAfO2ld3mmu0MI5DUbfuY5P75
 e8h5_0ZABuhW6jX9_Uq5tsy1c0v9K8Wo0WWkE7UN_BI2MfzyDqItlQxqLTw1ecaU.lPWrKId9map
 mgd1ibkZTlhhtmXL4IhHpgl4mPepgYolITnYhIFX3M763ESvB0YflAOIX7q0Qde8bLn3PoDB2IaH
 u_srUuUbIjvkfKWY.yLHUrDzqsjVlkPbYPJGHL2r.a3jExf_WbBWn47q11wOhzXmsBt7AwvF62tL
 KWh9RxLiM.cfzOVgFVVALpLD6SZ7WotSWO1fzw3Ag12uGdrSOHLBAPBBZEu2JriKO4GMWX1J.IV2
 i.0LznYWhzvQDwJaCCuXV3ynLVKI0ZBjxetJsrsjHLWOI78oGTVGEhnXjn_3qCwNAJT0dmjI144D
 13IgrU0ikkaPOdI9XfinocpUGkiRCBlqyVVcwKpBakrf7p2wjfT5fIv5ylsE5n8Tfb9NaufijPcC
 .hGxUAnYqogwcNfM_4hrde0IrErlTtW1PC0ZtdSPiDBOZYh6pRnjg9z4YWgPZLvj4qXjz0HPLiH7
 9qMplDvywyKj.9jPoepXC1yupE5DJhN3LSwnOSJHcaudamkldubji80e88uhwpkhyga.QBwfISij
 ZIE9i1O7.RQIWFtd42wFlL0RlApN.WftZvK01pxldS7y3j69bpirwaIe40dK6MT8wiLBFkuymKAo
 IzIkw1B4RP9DourP0_s2w1EbJW8Rovcy10eJohMBpKj5v.3qWwVCH8vly8bk9jfN4GWyRzkOcPbC
 kBOXun8oWHjbQKZGgxFgTzBqVRDMutrW86bvJGsJncfsg81znnVuj3OdNYtQp8cz_6D3JDJUw.9K
 swq53Tui4BTK5aatXImEXDbqlV4CiIzFTaiKLKJGaG.z3v0lnhoP9PLrn4AVphEdZe3k5WARfRB5
 0qm8XMIUEBWNgWZID8XhTUYF1fhX9ZdgUZ9e2rmKE95MYvu7vzbbh5cXHAs.VVAFM7pgGPa86nVi
 6xE0E8SeAXNB0jZx8T2FM14tfXQhjx9Yp.O4Ga_c3gTM7KA3s5lG3Bq8LQcnImDe7wxqdjTZ7tPV
 40LkL7mgf5FJk10ubb6Zx7esdHONHlXHJZIJf5CRO6HXZmmkfRY6wNC3vygV79MXBU2jk_Fh7Z0p
 w2qXJ9axaaiwr8bpoPtOQzhtPMILe0XP..QbXQMlZyNLG1JPdAfiYTWBVeiTlR4g_ZuNqUATv0Pc
 y6S9rQKK7rD0kL7GQ.J5Xvgc96jfOXQ8YQXra1zvlvYyL.d9nzJ9InK7XM.7o5cduEKQJ0_oLMmZ
 3Qoh9wP5m82b3S_wV1__gujcTSTcaeEmroA.ECRJ_NY4cBldSrMryJCqIF.jNJc1xv74qQiRLgLS
 bUx5paXyp8Nm9HBXrsI1VdX5SOMRhq0H9kZum7eQ5aS50Qk001q04iTaRS_4xYkQKfCKR3sBVuog
 6wQAFbZs.lOnDT9cTuzHOkDTF7P3ACi7n23CD28NF2s1.TIrsOqSL1.F.9gllP9lyZG_AjNxjNAf
 euqvYZJi82wj5U7B8fHQRwrTVNgQwStYlQUVC11o7SPjOByojxsLBjxhMLRJPpSP8wKMK0QFM7Au
 cgzOlYdXI9Titz0i0lH0xZg6k8PBouqEZ.7cNhqB4OELJhJspscnA9QD3F6qJUX8UAh2K4H8aMlx
 B1wF9sQGJcNtlMExPJACaSRwlyQG6Mu7Ku1MS8Q--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: cb3792a9-3f45-4678-abe2-626690ee7d17
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 19 Mar 2026 21:09:12 +0000
Received: by hermes--production-bf1-697f88457-nlvcm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa0190ad330aef8d097e9ea92360d188;
          Thu, 19 Mar 2026 20:59:03 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	eslam.reda.div@gmail.com,
	gitgitgadget@gmail.com,
	phillip.wood123@gmail.com,
	lucasseikioshiro@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [PATCH] t1900: cover repo info path keys in non-default layouts
Date: Thu, 19 Mar 2026 16:59:03 -0400
Message-ID: <20260319205903.15242-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the path-key coverage in t1900 to exercise layouts where the
reported paths differ from a regular worktree.

Add comparisons against rev-parse for path.git-dir, path.common-dir,
and path.toplevel in a linked worktree and a repository created with
--separate-git-dir. Also cover path.git-dir with --path-format=relative
in the separate-git-dir case, and path.superproject-working-tree with
--path-format=relative in a submodule.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 t/t1900-repo.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 6605394d1f..3f39d2b9f6 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -241,6 +241,60 @@ test_expect_success 'path.superproject-working-tree matches rev-parse in submodu
 	test_cmp expect actual
 '
 
+test_expect_success 'path keys match rev-parse in linked worktree' '
+	git init path-linked-main &&
+	echo x >path-linked-main/x &&
+	git -C path-linked-main add x &&
+	git -C path-linked-main commit -m x &&
+	git -C path-linked-main worktree add ../path-linked-worktree &&
+
+	expected_value=$(git -C path-linked-worktree rev-parse --absolute-git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-linked-worktree repo info path.git-dir >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-linked-worktree rev-parse --path-format=absolute --git-common-dir) &&
+	echo "path.common-dir=$expected_value" >expect &&
+	git -C path-linked-worktree repo info path.common-dir >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-linked-worktree rev-parse --show-toplevel) &&
+	echo "path.toplevel=$expected_value" >expect &&
+	git -C path-linked-worktree repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path keys match rev-parse with --separate-git-dir' '
+	git init --separate-git-dir path-separate.git path-separate-worktree &&
+
+	expected_value=$(git -C path-separate-worktree rev-parse --absolute-git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-separate-worktree repo info path.git-dir >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-separate-worktree rev-parse --path-format=absolute --git-common-dir) &&
+	echo "path.common-dir=$expected_value" >expect &&
+	git -C path-separate-worktree repo info path.common-dir >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-separate-worktree rev-parse --show-toplevel) &&
+	echo "path.toplevel=$expected_value" >expect &&
+	git -C path-separate-worktree repo info path.toplevel >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-separate-worktree rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-separate-worktree repo info --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative path.superproject-working-tree matches rev-parse in submodule' '
+	expected_value=$(git -C path-superproject-parent/sm rev-parse --path-format=relative --show-superproject-working-tree) &&
+	echo "path.superproject-working-tree=$expected_value" >expect &&
+	git -C path-superproject-parent/sm repo info --path-format=relative path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'path category returns all path keys' '
 	git init path-category &&
 	>expect &&
-- 
2.51.0

