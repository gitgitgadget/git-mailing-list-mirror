Received: from sonic309-13.consmr.mail.bf2.yahoo.com (sonic309-13.consmr.mail.bf2.yahoo.com [74.6.129.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398F283CBF
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662728; cv=none; b=NVh9TXMww+svXdf+L8Tw0DkEpQNwUqqnY5JpOJ1zcrB1dRFW88DLvc9DLcdgdw72Ev8Cfmd13Un/dPSyy9jM+0qUy0Ov/NbB22SQEWk5s2gzFLKZArOGFWWU7kpq5Kmqk2NwsHKIgu3pX/rq1KtSTfLMM4EP5oghA8P5VJDSeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662728; c=relaxed/simple;
	bh=BCErlpH8StCntoXHd3OXBX64G8V/62xVtdZ6kxDfAZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvKSIpHX3RwTYlKpxjJnb/7HfLw1l+CW6Df4cGY5fcFpSWv/UhYpPV2t+vi2/s7Ce0aspwbVDXI59jQvA2YxxJNK6TSC1U+T4xw9zQg/MIPnGzTW1psW0eLXlyRVKvZQnV4Amkft08WfVsNLOKmJr5/7STqq6ndvljlycFVb73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NuPOVgMo; arc=none smtp.client-ip=74.6.129.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NuPOVgMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773662726; bh=+bsH+n6DpDWPTkXTWcP9kghYBDS7dm92sLam7Cr8+C8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NuPOVgMoUFTIkljqfnjMswHpYUQ+k9M6VmdqSHPTfOB4Ap7CreKsF89nl8fqnTCcGhk4wQXScfmcGOpnVuxI6ZXCsEey+o4LTdQh0iIQ3P/P32oAwaw0s++YCW1dXgVyqf9oDuf3UPc+PicPdgC77dv3rpEndSf4+B0PAMZgBXOodS+C6Kxsm7cSJXcjeSZvVLgoVjeaI2J4oPn3h8GFX2kFLp32HNxXaiz1RIOqNmsRLBgHvlfwrSDVMIQVd5VOEe/rWpNQ4KK0sCo1Cyn84KXU/SxlU29+Gf+BPddND8P3jiC0ymEmx2vyE2j8Q8Yszuy/G9S5EuMFVfGl9z5BUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773662726; bh=5Yji2c8NE5kxNKMzv+w1RgesnJ90u25P+7t8kuTrYmO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Z2w/iJVcDX3T05yQOte0D4KdVzYCk0BOUH17wHGAU1DSVgxWrutlTLGlwsOtWPM+NkP9yArsnbniETUAOoefqLz3frZ0mJJSBKg8UZHHfNgoxrXg0OB6FDlJ9Zh9KzjRsGZFwQMUFyo/8Qw7RM11nXirKn7NxQQullu1/PmM+7MnEV+8mktjgHmC95y8o4GXrcLY82eupE8gnPfpU5q7JTMpMy97vE/tPgv5rtMGCGwS/C8At8eBiN+G55zbnorc0T2y++OCy/FZJ+w5zZNdz5haQTRf5k2aQqrYoCKtwuL5UDRkV9yEDyKiJzQKPXu801vyWVBCD5CHN6tpfG1wEw==
X-YMail-OSG: 1ZIh0OwVM1nF7cVxwhgpW6o8r3Bn6yWMcAzveW8KCdajBALcGsvVMBwNipGD9_m
 wZycAyJnHuogbtDOs8dzW_eapmU6uup11jvkrF0xIR4neaKWBikzz778cE5tNYxnyjlPKphrNPPS
 oAJGAERIu8QyIPoWV96Zp3P5tobkVjz1vJU2Cbf.riJvm7GS4QtNkv9u_a_JGW4WGEGOITswW9Ce
 QW.7p7yiwEgI7I5S0_PUaiBM8YOe3Dn95gOmylXwjayYZ594M3fkzl3t7R74T3lDaxLOjW3rodff
 lNE2OJmZASEYOEMpCoc7Pg4LYoSHk4DXH5EoMdF5T3ERzL8ceglZcGA2HQSa.5z0vTDPkAuTx_0X
 HrXO5.ob8NTTKYg9AwwyMQs8zFOqZExpYVVi_YVu4KOB4qXJMcseS8bf_ntuKXO8__ymug5P.yP5
 W90j55JJl.opC4Wr.6DXvEJdQfRKNIZeXrEERBasdtZjaT1Qu9H11IqJXYziTGWLg.Tbkz_k10nN
 Ng1Uel1WEaOsj5F6qUg_9mv60puRvAipqqa.zujni23mUnBId_vv1m.iaga6dF8gJkR3UK7kpVBq
 faY5De6fFDj80ZRH75UPx7bhZAhkqmrQLA8LR8IIZ6AEgYr3cU_QpqhzZG8vdnIojLN92TeJtQZ9
 Jn_tu.pyuCuM6mQfaCHcG1u4rDfd7YpuHUA35tY_tJWJ1mGiC_xn8JW4sU8BpbpbBM.tRJnKUAmw
 5rAadprWOF0pYSSM7cmp4u77cUG7TbkJYEfbTZ4ToEiMKrWHR.lZdsYIB7yDhP6sQ8GGj17HMhUB
 iupWj6tVzp7VEuy11jDAIHBz41dXuyNcCyjBs7.IdkUwfj4CMPArkvRrsZVzXuGSUSqZgO2KRzLc
 1MrDs3_ePY2BCLC.L3ZG.x7bgLesy81H0R7IQRgwYNyDFhTgp7FIaFRvuTIXZALu88CwZKiljPjF
 Emzsh1M05fBoQTuAvkfuZs5FfauwbOvmHot0Bz4nyN85iUu2aqmExmW9OyyvylTWT9dLS7wyNLHA
 f.f5EXghL2GVsCueZXdvwx0t7updVEgaRNYRfZ_ZY1bMwiYr1h04ojUB.xek8RsY7YB4hK4XlYAk
 tL808DUeJc4WQYfHCJcizbKY7UQHzSTCmlFSTdwCIn94bxjS.KwF4OExqppBOB78vU9VvGde1vD2
 nHHN8J81XTHdrG_s4aMCu9HQqtqRFev_kHy0ExevmQjbDishAIVpmUmU97Fh66qKOC_.7CQyuOnT
 gtpzmpU.oY_EhW4wxTv9vqXHaKCyMff6fJ1gorNInBiPobeNx5YpCDgcbnJyePtGMXqsCohagv6B
 NMRcw0ZtnTjIim8NJeME5sdeuQlZXCBj7pw1D_mU_jX5SVDPnIbu0WYm297DIrwyquG_O7Yp_ZbL
 RlYReUkKzhrADU0BaNHKEFXtj9qA7SUeRY5BVQe7UWUqb2K.1Xm6cJqcQcLizCWolXf3D7gDbOMk
 dXckJyMdHhnIDKewNPmBcfmnyEYaVVfBDDZtc7WxYocnZCLh5DT8GR5XTtceZWxSILL9fZ2oDFfS
 yHArngyPkHMdS8cxRE1O2ZU9u97QrXRccQBPv63bfvRmaDFi63UkwFqyd5Xev1bEKoVQaYTYx4NU
 w20qt.MCY7oXIy5HCbrMPDxEYx24dIhnQNKPm8JEf7ZBEwIi7sqsSlZMAXafm14yl_vWPcQoqtEx
 zXarNcHf3c4kaQgygmcnZf.ByTTtpOpy3jWcQz2ST904l4LgFny4UWTVsDVxMAUTuLBoSMPIB2Xc
 9K_2ud2sROnh7ddWCtKqmqgzQi5m.u02Z6FVRtl7V1O4cRHSUUzKuUaSQWBtMN7xV0wWTwLsNl9A
 BbsSE_jtLxHs3f4DIuxUGTfH8Vc5BNdYQfRWiPA2imRLUb71W75BTmrNQkRUq_drM3CGMgIVq_gn
 UT4HJDRIdZWoeVwjN4t5.VDOHuAOi1o8FD2r_6zySAIo4W1ydH_FTnsYFiNir0wTL3K80MxaBgNO
 MX4SngyqRLUd1ECPajzJw3Q7oRk6_Pr9Bea8U1pl0DR4l_M_RT0ACmnsZRsaxeOZTBxro03TwBXq
 cBRp5OJju8aiTQiRvPkPxsMInEeje0ubQyyMS6gtZnHmt1mJw6WA0AH1BIwwkcemHhDCC6oUO_j_
 8vK1KHqv1fgMP79kRfK5BK9iGZg2UYGogkrVXOYkSydA7B53JGL_FSigELvhr5izwMnCdMxNwYpW
 brYiKMy4IGNu6nGv1bqVmx5QNWa.9OqPdasmRH78wvhG3.EgngQ31370UgWQZ9zR7PSMm7KAFcDW
 WQtzdktF.TY3dRB4yHT.4BjH1pprriQ--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: df7aa206-0dec-48a7-84f1-c81262724d16
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 12:05:26 +0000
Received: by hermes--production-bf1-697f88457-5cjx5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c4eac7c302a7592941f4c26be4777d13;
          Mon, 16 Mar 2026 11:34:59 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC PATCH v2] apply: report the location of corrupt patches
Date: Mon, 16 Mar 2026 07:34:59 -0400
Message-ID: <20260316113459.77794-1-jerrywang183@yahoo.com>
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

Include the patch input path in the error message, and reset the line
number for each patch input so the reported location remains useful
when multiple patch files are provided.

Add tests for file input, standard input, and multiple patch inputs.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
Changes since v1:
- reset the line number for each patch input
- add a test for multiple patch inputs where one input is corrupted

 apply.c               |  4 +++-
 t/t4100-apply-stat.sh | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

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
