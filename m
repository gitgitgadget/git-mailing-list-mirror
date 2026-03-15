Received: from sonic306-3.consmr.mail.bf2.yahoo.com (sonic306-3.consmr.mail.bf2.yahoo.com [74.6.132.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B28460
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773621400; cv=none; b=EbqaFboDX2jvjLQOjGNw86WIbP1XxC7a1YuG4qDxOtgDX/MQxzpYZplNqfsx6nFAds82dMwTZZJcZWUeimm4sIG0qrDKhjofiGAwiqIMlu0B+e4Rjw3BUIeff2MDT29u7xreWBV1MmkXqxBJtlttnmAZCv7ReFeJRaOv59jeTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773621400; c=relaxed/simple;
	bh=7JOL2eSWCJhiXkx/B+K41lk5prCrO4diVCa3Zud8FBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=hhrVZv7YT4zFG7AJrfPBBNPBYy6M+Qna/fAv4DyySUNnIYPccDDkkRtA9Nvp9lmjcyeRKUi2DXSkizhjkrYdQ/2mVlaCbQqCZSgy6aB9d6LcfGu3ZaswwaDo+n91HDo61tjnT+ZIpsrwRcRfSSjzcKuHyedepHItleaS4T6o5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=scXIDoU7; arc=none smtp.client-ip=74.6.132.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="scXIDoU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773621398; bh=lE+Eg1N6wFbRf0nTFv0h1LM7ajZKSoi8r/rWUC9LWPc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=scXIDoU7uWKVrYXw1+nl34SOBmkTFRrV1sCBPc2N+P25qwFm8LS3Cf00hlDl4rWCprhqzAjAqUP14B3KuSVARRLNLxZERDU3grrE+V4jOmsSfaPZ+W72/q7Dh6kTeluFz5NBQjvzJYkuqErZZYxAlPHz66GrTFKlOe4UjElqVO3L9bsEKK7KHXdplAdP9P9fELeGsXPhYmjsGwPvFkbpMR4DbqGpB3pSz0quQ/D64LpLGXmOdlOvswzxNgbqyVbnwtwhqiXoWghLFyJb6mQEJP2aaLHzGdDwHWMzEw5F1BYhRuTOsyE2ngoRkd4eiLMtUok741rKMrg+Z0XWB1/byA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773621398; bh=kuie+ultpJQcTr0sBRuIHxkrEJrw9cfVxfQlo1ChJin=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YCmsG5XK8I3Dv81vbVelXGx9Y+iE9hZ9Co2kQxsL9JXC6y8T/cAZAaIlW4mZSOYDoA9U+LCj75Ee+ro1oMtbfNCULO5BmEKXtw6KFp6Qk437WDm1Y6SE89C8azN0OErQhhmWgeHU+zIvyKQQ+YTs38NvLQu74OSvu2wIl2K7k2CmhmLBJG9ZUmi3fu6eyuuIsjEoklTt38++e4Iy7JWgNuvA+BuW5JgInZrkNrBWuL0iRLz5KLxAtBnaBltgOpDpu/NzCZNKr45K3Fk6q/OuQuEPYxUzrXQT2gGDXK+ygiI8sfAsiCmyvjdrJ3i9J7O6iro0lGazTzlTxFv8A0SG0w==
X-YMail-OSG: p3xRAHoVM1nwqldbVPFU8WB.CaSIjcYJWeewzwKvSbzt18obz_30zvZZWj4hDx3
 w24R24JH2cLxgWzCzxMukegAwqIjRLmdYUAQbk9s5MiILCd_0ekUkHwGtFNYKh.lZKL3hvIeMIQc
 PKuU2ljPiNnnHE7jJP_uuGh4U3Sub8y9aZWrhim00DLBwyYzZJVdE54r95W2t8eca7lPEsTvpYHo
 eIIDC20CbjaUB.WX_0NG_Vj7cd9Yl6hfHIxo9ESKVJSkf7jHfDSiMM3EcgcZedC062gy_am81P1i
 gt4ie_gflCnA.dcuu4u2uR24VpX.vu571D2_LQXb7vwT6MtrBXGrNx3vN23NS05rGNaIE579Em3Q
 HBs3RfvFpBjg9LgoLqTSN2t7qf5kCsBX19hkMNIq7nUEMLrqB2TqN1Oc0cr0f6vXxy6klRGf39Qn
 FV7BGl173p.E.lbtqD_W1yB_oa3_k7Ut2K.kEDgPD21lFVk86Sjv2kMeKNDhrlMnUPv_k1RCHHIV
 dyYpxwFWmTKUW9l74s.L7h1Athbj4zgDSwmLOrDGZwG50jplea.FkKiz8sg4yUZPCLUa_L4ZI554
 UHYdNz0C6hc8dMbaS7XQk5kdtyGPOc2HGFxzoucwe5w1yw7xXArPBGkUYhQUG2GSnBHwlZ94UQKc
 8.SZoLc3gGR14XOIJGgzUn9_ahAIlqIKi.N0N4wF0iMCrDFjIvJALdLaiyPxdHuwejAZLtZ1fSdg
 Dk7l.OJg3ofsh55veoM0_BWRftSZeQ80PJVi08l_RhVgciBi.65HNZHWZU2mWS0exBXWPa1_XPJi
 jtWCkY64EJSo2gcvN1L2otosfFPLkKZ.Q058XCES1OPiCqneToUPaRA7rnz_.fd9ZrSSqUu4GNZM
 WVeZAlXVCwZFWT896YgQ4dKQZlkgaPUD8_qaiC8WFyODsgTPuY_6Kb1i2q1M1POHKc7M4wsHpUfk
 CnroUhTi.wfjKcuiYtlOwr99LzhjBgbEgsn6UZUoSgTTI5PteTWn7j8pUywswIzE3TFCfuyPcPjY
 E3cgOsq0f5Ec1823lhUwc8KexTXSmdOpEUe70y.K3EmAKkwxxYOKW_sU7W9_OceNhLwLJMbka5JN
 4nG_QvJYQiowCEntybUK2lIjLVk0GYy9k4jAcF_kbmJMlnGZnwc6JXWIkq5zMn.SbRqckK9ndcp3
 trezH56mi2_16SRbZNJrrMVE.Ewoc7dgovmP8yEn9ZIxjqhWeTLZyfUSiJcM64Iq.qOwlC3SY2z9
 U9ymo1UhN9bdLlTvFHYMG0pS_dQsV.hsYgrQQFbJOXdwgF7IfV06Ifbi19tiWZSumnQY1rd2YB8H
 HSWPaKNy8YV4qKbYIZlDr6PADV2wYLJP0vcI4_PrEnZt_NuMBwWf.Hl7uAqJ3pcaz0k4cCXUo0O2
 QZ67fTnAJk3o9WeBv_WvNhH5S78X8_E1aL6aPPGO9koacK2IL5b8HuPpF6qAlavuhrgXDIHFpoSE
 mhC6lvgQt5pEVDLWb1sYpuGA0kGAQj6eQ0UNaHnPlYxR6VyhfyQQ5vdz9U0.DUNVaXGBYtqnXEZi
 By3HXdP6IucE8yTtmg5CyAhxZHaV.EBw7RTfIkttaaPEggUFpSiWKEVwTwrmtwYBausCDyUs_fva
 vOmMvpS77glroHKF_CnSpvd4qyROcuiIDyautEHUWeNZLAvgnTcTPrCDEGNTIB98PFI.fhkFf6hQ
 oXl4jhU.Dw5m7aFhm1S0r.Uep70V7Mp1rXyjnE8Eb37QKq9dn1zHPeEMCcVVYT9l6ovNILeOnM7F
 h7XhxDCbETBzEvFrlukDdULiX3JLYlAUKYZu3eTSJ04FGH6tHAzwIdSpJUojeUUuuI7Xk175gFdf
 U4LE2ecxTP7FvZqfaNhQ1Ek.opQZXRHJIYh981q1l5fK3EXCD10bKYmt_0v4kfS3b.Dr0YNlPuUX
 gCGDtrNJrUoSCh2BRhXrAwyh4hRLDU_O.mvO8t3eyjvacsd3u_fq2HWf806DqgOeDd6orUuDcixY
 RYgNQqOceyoUcuyBeLuFO_2IJwJOXFxNaAaAj06B_MECGntkw2U7OuVIpaJTOppSBTaQcQX0PN9Z
 oR0QmW6_.hVJpTQsK2T.IBceAA4FTgTOBtH.VT3Ik2oZpoMn287hEVW2RyOE1KIMaEXxLuw3y02B
 FC5mzl73udbicpAcrOn0btHUfqjHRPflMfC9.mTlUnkm.i9FyNOtw5XIgHqX5iHe6S_oQI84YXv_
 KGUapzMpe_cucTBkinNLHLmQYk5AUv9f0NOGCP7gIae7oKw6FQLlzbi1HP4RTbm5j4F8tMfdOsSA
 AQGUFjC8tTm895Q._AtNK0.xLPAsiyIiw.g--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: e4b69ef3-d54a-406b-a7c6-d74534698d1b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 00:36:38 +0000
Received: by hermes--production-bf1-697f88457-q5phm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3c0d679b7f564603cf34049d6e595a5a;
          Sun, 15 Mar 2026 23:15:39 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC PATCH] apply: report the location of corrupt patches
Date: Sun, 15 Mar 2026 19:15:38 -0400
Message-ID: <20260315231538.68586-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260315231538.68586-1-jerrywang183.ref@yahoo.com>

When parsing a corrupt patch, git apply reports only the line number.
That does not tell the user which input the line number refers to.

Include the patch input path in the error message so the reported
location is easier to use.

Add tests for both file input and standard input.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 apply.c               |  3 ++-
 t/t4100-apply-stat.sh | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index b6dd1066a0..904d1c3e55 100644
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
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index a5664f3eb3..f99e439688 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -48,7 +48,21 @@ test_expect_success 'applying a hunk header which overflows fails' '
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
 	test_cmp expect err
 '
 test_done
-- 
2.51.0

