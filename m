Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CC3F6604
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773462; cv=none; b=NabOT3UaRCPTbhtYbLGXbunVUgxmvxeA6b0ILor0+u1t/vX947oy4pFcquBrAegZj+BXqFboKFRflmFj0LCfB2A0NXR/BeRfFt2iQK3CAQE6YLQ1rDKN74+8x87WRTgj3Y70zan5lZoS5yNsBrbP77NkQu0ouCHlbP21NGQQqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773462; c=relaxed/simple;
	bh=i1Q0hc/Pa0n/6zeE5jCgc94jJMsDt8c0UMemq3Pf9Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=OtE5V+qlVLhcebSZauxXaE1nr+NDVfu9wHerJL8hLwHlOumiixU+dDiWwZ6L6kGcwqFU0lPFTNsmFZ5//zpEXqRiBetPB2r/LKqV6Il3E4oJDiALd/gUmj0mY/lJuIGxy++Y/mQWo8ygWI9F86yp8NnMEDe6NxShczASfWNvX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RDlLkNDv; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RDlLkNDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773773453; bh=bkYpbcY6mCmXDI+WfJrLzWoTvkanr13LJZg8VdiWh0A=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=RDlLkNDvBM3TOgrk9lVoyd+yUdX6TMQkl9IsokOzFyJmPg1OanKepJFXM1wXGADUCyTo+1qaBus19b+scgAJjmwHa0mf5DgTmKD4LhM27BIsIUmSwVEjRc0Z3sru9qrEJIz+ESvsYrY3ObHfapPFDCFE+psWfjwz7C2Qy0NLPUMz9Vu5bcKDXgdZilhguCWRt7qnLBT0e0HQJKIADamXUZ7/clHUnO3LHMVFNqStU5dVU1si7mzBGNwpaYpLXxi2DySnC36BVazWzMZcea5VlUBZBeFM55Ggf2GRw0GKDfrtbS9+AY72FL8HrKeW9w23Mzb8QBO61iyOiriMo9CGBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773773453; bh=7y3rXz2/Guwlk+wNLPqblx6Am0YC150hjix28R1r4S0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Lh47ff8SpQp9iKKcdtqy58hrKVciDQkpL3oxynRYyDacGKHVDlpOVfOnD0NIhIB+E2YzCQBV7ZqfZ4ZNkV7v1hv/ksbDeRr2jZjaNEEGjWYoj2qPfqytrfT2ToXNr6i3WQYAG3BHpsJrtwlPt8+RPWOocv48poqLzD8WvDN2WPPuvtlGl/6YHIUSrC2Vwkxn18+N02Ufury4sTzfk8z8Wb1ymarOjOmluTckYRVxlN4DnXT9CSCOkZDVhscpejwC/rkS1CjO60Rgmi+O9r8ibYpicPTc+m4qmv9msmkG3jvv9BJdQ9wDyNXNzglryNejDsqm1beFCciFfesciE3qaA==
X-YMail-OSG: lxPiGoUVM1mom_b8HWh9U35M37weXYuTpRiLgbYGgUBU_gr7hGHhSG5QXPzJn9f
 HhfwwyT.z75B4_MkE81vB2jDTUZnI.1K2dC30ypX056zjirenNF1aGDAVe27nCDY8MuE2JT576aq
 QiiFVgEnELvocStxW4S7t7fgb9SVCj_TjM_mCa22iGpEGS8irpuafnFR5ukxuJR9LUxhDsz40Y3x
 .ZvAS1NTAtJ8BLvBZ85LL4lsilbUI_Jw5DI4Y1E1D24mJn3SzkXnMx0zwRdJSENeqvrRPrSPujEV
 we7vl9JkBTIiUr.MeNx8Armd7xuMoS.dh32x4R4lYEPnBxdwJ76zuMbPNcR49J5RO_eFhCfOGDhX
 dmjEtFZa_YdoIJgIUWoj2UHH0XjGEO1QlGujGEzeEju4xdzxFmWvV6vkvKEkQ6BEUqcEqhoGVCnm
 GA2Z_M2QOFNxiON15sTmrqHcgc2Q25Bbr0IxaPZF2hVQoCCQgMYO1lnboisfxpTu.PnIPAnGb_np
 X2cHE2X97kinI758boEprlQMhbXnmlLmnQzNt4tdRSnoIpoFjCJ7abJ._d49csfK6epOYmcmOPvU
 2VoQAD6xpE6k5Dk8hP8NOwVMbiy8aPyGQ_kF6dNsEck3knyhQR4t0cdv4yJ_l8XxWK447V5g216i
 a01TBWZhDP0qQnjXxpmBFOob0Jpwer3iX_bkBMSZ0QkrcCICtp97Vqb9KViQpySy.poQ59pnlivO
 ALMPoYfwGBFHNutMMvUdBCmnEclN0SU0BSEOH4DxHIrOPOwqyd9xSM.qgs.n0QJH1PKXTnnSLSNM
 CEUYmQMOBCDr3Zi.aGn9fRNubkk_B6n9d9YIiIs2gjsS0PSQZTAuw3LRjIEZJzO5W8fLa.AoMjrn
 o_eUGkZxj0qzMuoOqk8YVxzU4aw8kHobmllKbA.ZC7pGuXmq4Wqge53K_UbgSamdmkOMZO7BCqu5
 rFi1N2kFyOoq0E0p6Zz2DuTsQnv6jEQ6hdOVcuKofaM9nCtKEbPDg3l21gfk8h66FZ9._BtUuWN4
 d8MUTOgsMBdu2X1atjOZJmw8ajn4VSDKzzwiv_ynxKIyBadJ6.PjBXvpU8QDrBGz6niC3roVVMxp
 B0Mm3qiT1Iksjj_9OFKjhUcrIm8tsX3_sdLXUcPyT1Flxkver8sK9wu8zTxCA7GtHfPkK1Q28t73
 CLXGg_os9tjM1a8zHA_I1sPYtZ..Q.t0ufvUn8iTF5SysmBfqxdOvRHMz9X.teeXzpZqJgPloDiN
 QBMpuMqyibgsI6.Ph2ONKmHIuPNFymmmolNa7opz1Ej5lLL57N.r0zWjc2DpnSok8nO4HEc9AYHS
 TauMdVr_NEcw1LduqPo0Euby62x18t3BBw6y9T6hR23bKbJTn87J8mdaLHflYEDadR_xo11KJSNy
 cZk8yqk.SH4SOxrEMn72HG9Oehyr3FjnXFertdV_P6PAEC0_OPFVYfkFBHtI.svrlFlqhupfbA.L
 tLxRW3BZFjM0kyof1YQCSlPcIZKCa8PULztwU3eaq5JTMxRzK58xfb4WC6JbbhIta6pL_klOkt.r
 6PlCPQVjGSEiXSZh6TqBPr4NEGWlH0.ybkaZoKnQiIRXaO.VbFNbkDYqOA7.bYZfEDBVQ0361XzJ
 3yZnOypdMxd3dhv2bfJYaX8PfJHkEoOekqD3xCAhVuJk_iUtC0RElKYIvjHiNr5Wy6r0CrEXzBxK
 m.Kg3cDaqqnywMbgccO1RhaQsVFjOvktrS6Fj_.zHQMv6FrAomdEMhNNK4jvs6FDWqMaynBRsfh5
 ogKm3smz6ftCHG1RZffb7OBP.9HiJV6Ngyks0uv0SKEJvWimnUxIlcmzIdT6X3x9zyV77peFxLQ2
 dkx7eQid1SpO6DNkZ.m.il0K.nlxyuRynWEcGsQ5eFTWVvs5DrQahxQoC8dd25IqA_PxMYeySofJ
 kbaxJ8udrfOsIDp48Yh2QzPnZ4_GmZ4KxfHUm2uSqyuoDNftozZgGd6SqKMBY1V.76QU1etVG4BR
 EeuSVC8NsCcEpvzg4s6aTN9ml55jt.aI.BmgJdi7rdaPj9XHNWoXIGTuG5qeI_StzUh8EKheSN.6
 PsLPRBIClZhAYAJxffjeYMHBvfsrbOMQ.fZhiMM8Z2_9ijWH8lbaUWaIfnm.BJyXNEzKSmg2_NJI
 sxfW8NWRVBIgSLTFIJrjwuy9VARC1XSEMLu7JTlDG54kI7wZhiXOhMfqhh7MoUm1unpJKNPyf1LJ
 .dAUPnEslv7YkEKibhFMpO3Dxs3eAsgVC4zaBJG.drWOV0msm2mdvitbqkry804kB1Czco0s4vS8
 iFcbpTCQnAcNYhOx_qS.68EwF.Hvc.D9ZP60dSg--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 7ead7092-d131-42e1-9598-d7f996b85435
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 18:50:53 +0000
Received: by hermes--production-bf1-697f88457-629ff (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9821146f2d53ab376adab0bf4af3f1b1;
          Tue, 17 Mar 2026 18:50:52 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC PATCH] t2203: avoid suppressing git status exit code
Date: Tue, 17 Mar 2026 14:50:36 -0400
Message-ID: <20260317185048.74421-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260317185048.74421-1-jerrywang183.ref@yahoo.com>

When git status is piped into grep, the exit status of the Git
command is hidden by the pipeline. Capture the status output in a
temporary file first, and then filter it as needed, so that any
failure from git status is still noticed by the test suite.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 t/t2203-add-intent.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 192ad14b5f..44c1936e4d 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -16,7 +16,8 @@ test_expect_success 'intent to add' '
 '
 
 test_expect_success 'git status' '
-	git status --porcelain | grep -v actual >actual &&
+	git status --porcelain >actual.raw &&
+	grep -v actual actual.raw >actual &&
 	cat >expect <<-\EOF &&
 	DA 1.t
 	A  elif
@@ -26,7 +27,8 @@ test_expect_success 'git status' '
 '
 
 test_expect_success 'git status with porcelain v2' '
-	git status --porcelain=v2 | grep -v "^?" >actual &&
+	git status --porcelain=v2 >actual.raw &&
+	grep -v "^?" actual.raw >actual &&
 	nam1=$(echo 1 | git hash-object --stdin) &&
 	nam2=$(git hash-object elif) &&
 	cat >expect <<-EOF &&
@@ -171,17 +173,20 @@ test_expect_success 'rename detection finds the right names' '
 		mv first third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status >actual.raw.1 &&
+		grep -v "^?" actual.raw.1 >actual.1 &&
 		test_grep "renamed: *first -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain >actual.raw.2 &&
+		grep -v "^?" actual.raw.2 >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		 R first -> third
 		EOF
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 >actual.raw.3 &&
+		grep -v "^?" actual.raw.3 >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
 		EOF
@@ -211,11 +216,13 @@ test_expect_success 'double rename detection in status' '
 		mv second third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status >actual.raw.1 &&
+		grep -v "^?" actual.raw.1 >actual.1 &&
 		test_grep "renamed: *first -> second" actual.1 &&
 		test_grep "renamed: *second -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain >actual.raw.2 &&
+		grep -v "^?" actual.raw.2 >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		R  first -> second
 		 R second -> third
@@ -223,7 +230,8 @@ test_expect_success 'double rename detection in status' '
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 >actual.raw.3 &&
+		grep -v "^?" actual.raw.3 >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	second
-- 
2.51.0

