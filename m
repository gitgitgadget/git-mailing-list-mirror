Received: from sonic306-31.consmr.mail.bf2.yahoo.com (sonic306-31.consmr.mail.bf2.yahoo.com [74.6.132.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE535972
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708295; cv=none; b=usrLMpuChn88Jp4jN+ZxhoMU+NSAGN1viT6ffzGZ0rTtPwIbHnMX5pn4tPzCmYSHM+1Y6YJZP5yTLoCqs96KDLNb18bDNwRHfUJOBS/Q21z3J/xN7Yb9nMNw86yNuXP75V7kdfhmDokTFePsysgERtvLgDVPSJgZ1em6GbPYq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708295; c=relaxed/simple;
	bh=ef8y+YATv2BetHYMYpc7tKq6UyYfVK8mZI7uV6ELD+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=oqFdg/jw+sJx08n2XxKp5GHBTrzQypRGpLJE/VmvcN1tmB9CFpVQXLjuVQWjohEuZEieIe5O5NpmDdTrN70YefFfG2DCU/sgMDbZuygVHpZjKt74D1b6uM/gmVCYL+0ZDo+WKxqRpisZetUQhDu6ljYJnwpYlpdyRGRd3ah7Th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UqpNFIG4; arc=none smtp.client-ip=74.6.132.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UqpNFIG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773708293; bh=4dTwniQklVeXx40jYpQSYlPTndZRhNM/ZbcC+qX1Q6w=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=UqpNFIG4UhceNmDnir+OUs+z57L2HQKQ4f5LPO0Jkg0bsCvnY5KTQWIMpSCKPxHdnDEEW89v1rHgdm3XPGNM57G9Q4UQF5FE8uHs/PHZsoUKxCnfBE612saccUpKXwviFyU89Ky+vNiyYidRdx9fDzd84Y9dYmDtDGsorlERhdMlyWTUxCDN8eRZQUvXhaoGSjj1RRJ7Ctb+1cLSja7owKzVe/dYARJrAFlnELR+the59YzW8V5iV1MjfAO2ettJK6AX3KXZ/lq2rrV1WrGe+SF0jCMEi6U2MANHh1q02NtlNcnloSUWK9oTbzrxhQK3A31mWxjGdGY9HexNKTZGKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773708293; bh=oBX6MoKcaOv/VqQMWvuvxL733kIeOLKXw53mqOG2S8I=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GX45zNZZ03cljpkW+fvbCNG0lHrvi7qa+Mv36CT4+32XH5a4CJjHJ0exWcSrqqqdcSScm2pbIR/YetviZIl0M0Dw6wZqnJQ0U63lwgOcmhQ93EqRYBfCAx5f9wxoLLO0QWpSd1kwfxN2k/qsUXx3nM8XJZaTbdgh2TiqHrWs4sU9YswuuV1wsiSexUne7wZLdSNidvRgDZKferwl8EJRPQMfPc3D6EXkLHlbTPgFPGPByqjOH5tsf6sXvHH1TC/+hSNFk2YbyY2yoN6GkOmbpFLqayZzZee3MydjGt6iXKekXEHDSLobEsiqtRTLT2FIIWCSWsEEoF7WoJ5e/pvmoQ==
X-YMail-OSG: NTXZYg0VM1kSHtdj9n8g3Wg4mk01jcr7jogv7DfNlbwWs3gfIqF1QhQZBLe6Sxt
 F3VRRULv_ro3PUMfXw.J5YE0tSiVB..C04qx2GXVQCWrOlPUNO4_bIKJ4633BanwTCBAJlFJUUTw
 0cUf.CHnFchSOhaZz9qjg6AMQzChAqnn_gPAEfpxvSFFUIY_bvno04kTLuRq1_b.lhzmOL.rnaEW
 QltRTW3xkjIw3GFrzFAwraMGzTZqm6thfPhJM5X4SOq8VgrGAYjOK_199IL7VKBHk36.si2Fuu0P
 9IJeKWHnwlsZKyEOkSvEH6nKnNQwjUFtgAEKOjysMCQ78R_Ds_r5Rqun5xgJMAzAsLQN5v5_r86e
 kK5brkqKn5WyWNqTCBfGGbBCTrKpua_neXUvlVaAeNYRTrWuZhRW6MzaMEuXHXx7YDU4A.pyUtoW
 pTZDGMhL031sRJS9G0Pp6U15s_C2tI5G277hM1syqx_gIEOj3t8ZjvmIQSSUDHhyUhlofj3JoVtV
 akNtUjkmKlIbGqdGgZJpEgJCUFsYjzA7hKiHGOnXdwOD51Q8F4WJ04seWtFIYMGtGiYNjeOTEs1_
 UqpC_rVCYLm6cmvRh8Az2Wu4aVZv_.laLR.BF2i5Rrr8l8o6sya1psVvWlsZ3KPIwHlfbhP3H8t1
 LV4c6uAJltEzakpi25XMyCe8o_bLsr1ZDEs.z0q.80dQoF4P3OAZAI0M6UpCkkOZL0LcE5E4MCTa
 nUpgG5gMaKB97t9ruhWRZfDYpTzkyEtKaK3vrRGxvWOjQ64xtGkuFxdA1oSDuX8cnsIQRnSmvgUG
 XBLZD_VfJgq0GcVZR1rvUqHmw5iblaVbXatoBluVoVv0yngE77sdlrnSKPMbIU0fUcKpVLOAhbn4
 B4A4_X07N3DzTJD86QPygkj5_6QXlaBRmhDc7709OUEPkaUJ.fVKsDde3LiyQMC4uYwlWCuuF2ly
 YMlk7VDF8nwS8yw6Hyuwbt6BSJnBl08uuaLVv5KffUn_absuQNiqnCc8RZl.UJZ6EVNiY8UXQONH
 G76QNReGz3vBEK5Y_ztlYocymXA4onC9Re5_WSQYpZmF98PX0PVpXc0Vc1xdP3sU74tAUv1CHU_z
 ZnafLnusvBwBC6IPG42f6WYdM9FEt3U3Fn9LzAIN5t4Bkmsb0AF.uJ8w3_3WyS4aw_acTYCR9a96
 pAgWyN6elr_NTlXDqfTS3Lj2ZNljWBgRKg81jqkaprDgBJYy63VJkm.hMg.ZAUNCy26SLzMY.d0L
 oZcGO4sNfCj.95f7uDPM.QwQoAUmYFCXGvhLTPV5Edaf.wrofI79_Gjal5pX1kK3RgFNBcu5VcW7
 Cd6FL5sHjOTYA8RNsBDNxbyYcBIQUsPoQa2RF62HpZnOU7ZOxQWdvIDq6.eFRiTIK25OBMjV6VHu
 WMb.T.6XOxKGN0LSfSzH9pVHxzFIQRlI_vwaCU0B2MFIV0_Ea85v1eMugZtdOOtWOqq5L7s4pehH
 j7zICz1d0ylAYMnBhL8FEWYFbijibG_OW0OLzoZwZz3XarhMOLdS90XjbDXz3gHOBCblv6P91OKT
 BKsaA4LlX5p4PnOUavbv_W6xMp9QuULjJozzjfjUBb0s0._iJuxR02UU8kZBToxMkDk9NL9fQOJj
 G.E2CxDXBK5T1C4u0SqrDh9xVLH55WjGaU6.u44TS2K6IPVojVEtSZz4q11AEJUQ_LeRFl6ons1a
 lRb_l4EzTuk6u43FvVsgran7X9CFJzUde40B22w0oMP22aZ_9m8iQZAResEjZC36MFm3nm1R8GXM
 qpIrUc0G49TQdem1csAPxPnEZGHFGAbxo0wwEjWuBHsbMebJb6J6yVZoEKIMJTvU_yynwqmqdKXU
 zguyfYm954yKqWSJeAO687HmZ.cbjIvgYNucl0DUGi6OqrRwI9pUfsYM_rpg4Pyg7RYl1beG.GKr
 FUKCRPbiYEgxWYE7D01h9yzpxyivvkKdnZzIEa8AR2qkbOKU.ejDtc3QKxkqqz3bwe2HIsM5D8ap
 lYZU.P8mq8qFY.zTk9MPMrGJLI_eLA7dcANuDE1yprpCjtVeLqB0AHDtNYVzYYZR6a6rm2E9aLBc
 CPevac_TqLlkFJz12SYgIF90gNeWFzOQ4jB07Q98wK_uxZF0DPATrJ4iX.HdSLW4AZkl76YyXn8V
 LDW2H6EO8LHUdQYThEzIxq7.dGia9bVJXMFV8T_v2iBCqjwALdc.rZD6oNq6OGwDxwz47EeKD3qP
 SefBuLx6eQvPLj6D6KL5z3GUwlCnuXcgi6CFOeeN73A8tbVsQL14WbTadSictRPeFAPxp426JzKJ
 oKB3PmKtFiq31tAv0SwIDXtOt2c40GPmi2UroTa86Q7M40cfUFiJy1C3i5NXbtRKr2Ehuuvg53Zn
 r
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 7060fd3b-c78e-4d84-8bdf-851207271b74
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 00:44:53 +0000
Received: by hermes--production-bf1-697f88457-w2c9n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 40bda95d94267529e03b41d3e5674003;
          Tue, 17 Mar 2026 00:22:36 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC PATCH] apply: report input location in binary and garbage patch errors
Date: Mon, 16 Mar 2026 20:22:35 -0400
Message-ID: <20260317002235.6121-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260317002235.6121-1-jerrywang183.ref@yahoo.com>

Several binary parsing paths in apply.c still report only line
numbers. When more than one patch input is fed to a single
invocation, that does not tell the user which input the line belongs
to.

Report the patch input location for corrupt and unrecognized binary
patches, as well as the "patch with only garbage" case, and update
the related tests.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 apply.c                 | 10 ++++++----
 t/t4100-apply-stat.sh   | 12 ++++++++++++
 t/t4103-apply-binary.sh | 20 +++++++++++++++++++-
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index 700809f3e6..84b4a569c5 100644
--- a/apply.c
+++ b/apply.c
@@ -2110,8 +2110,8 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
  corrupt:
 	free(data);
 	*status_p = -1;
-	error(_("corrupt binary patch at line %d: %.*s"),
-	      state->linenr-1, llen-1, buffer);
+	error(_("corrupt binary patch at %s:%d: %.*s"),
+	      state->patch_input_file, state->linenr-1, llen-1, buffer);
 	return NULL;
 }
 
@@ -2147,7 +2147,8 @@ static int parse_binary(struct apply_state *state,
 	forward = parse_binary_hunk(state, &buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error(_("unrecognized binary patch at line %d"), state->linenr-1);
+		return error(_("unrecognized binary patch at %s:%d"),
+			     state->patch_input_file, state->linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
@@ -2309,7 +2310,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch))) {
-			error(_("patch with only garbage at line %d"), state->linenr);
+			error(_("patch with only garbage at %s:%d"),
+			      state->patch_input_file, state->linenr);
 			return -128;
 		}
 	}
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index b3d93d8ed6..8393076469 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -125,4 +125,16 @@ test_expect_success 'applying a patch with an invalid mode reports the input' '
 	EOF
 	test_cmp expect err
 '
+
+test_expect_success 'applying a patch with only garbage reports the input' '
+	cat >garbage.patch <<-\EOF &&
+	diff --git a/f b/f
+	--- a/f
+	+++ b/f
+	this is garbage
+	EOF
+	test_must_fail git apply garbage.patch 2>err &&
+	echo "error: patch with only garbage at garbage.patch:4" >expect &&
+	test_cmp expect err
+'
 test_done
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 8e302a5a57..f2d41e06bc 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -179,6 +179,24 @@ test_expect_success PERL_TEST_HELPERS 'reject truncated binary diff' '
 	" <patch >patch.trunc &&
 
 	do_reset &&
-	test_must_fail git apply patch.trunc
+	test_must_fail git apply patch.trunc 2>err &&
+	line=$(awk "END { print NR + 1 }" patch.trunc) &&
+	grep "error: corrupt binary patch at patch.trunc:$line: " err
+'
+
+test_expect_success 'reject unrecognized binary diff' '
+	cat >patch.bad <<-\EOF &&
+	diff --git a/f b/f
+	new file mode 100644
+	index 0000000..7898192
+	GIT binary patch
+	bogus
+	EOF
+	test_must_fail git apply patch.bad 2>err &&
+	cat >expect <<-\EOF &&
+	error: unrecognized binary patch at patch.bad:4
+	error: No valid patches in input (allow with "--allow-empty")
+	EOF
+	test_cmp expect err
 '
 test_done
-- 
2.51.0

