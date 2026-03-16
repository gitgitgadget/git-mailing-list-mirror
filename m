Received: from sonic315-14.consmr.mail.bf2.yahoo.com (sonic315-14.consmr.mail.bf2.yahoo.com [74.6.134.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F13ED5AE
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691743; cv=none; b=IAMemSAVtR1DqKAqzRXcaHIoqQUY7eEVMjSfnovM5vsr8HynxR1+RXXeS6pU+g/QCGdEdVA7KuhZIoqPssq5h4RoQs6CBA1w0MYYciC6ptgAVsLjfdyP+aHGiPJq6rsMnm/C400nsZjdFDEqXlObT80y2hCVXSIMwpHycswBhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691743; c=relaxed/simple;
	bh=/QjHsASi8Qz1HcAoG2t6tclFHPPTs7KL3gRnoMhXR9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INUXbW1jR6YKOK8CZvFKFqzKyfN+0NxVYdTqvGMk41zCT5rVZw+Pe6eY+uLEO4lXmWf6Ug7KxWLcjLGJYVnbNpXBvnu2l6NQxhUhKn0j3qvvxWmQqc8b75/9kt0KdD/qDVNZOZSyEQL+jMnPrmd6DLAx/Mj7eUhe6BvofdQ39TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RkYvIkPU; arc=none smtp.client-ip=74.6.134.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RkYvIkPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773691740; bh=soDRodfIopKGwmkaQ3Om0tXtt72l7jGQDcCPqw4n85g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RkYvIkPUdVrlvRFh4XYPexCMe5kTGf8Xlyw2bAZpMWpTGoFKY8xDENMEWM0CGykMJeA4/0QxlfddW9IeZFfYmCmKTbZ8VF2Zha2ESU5mXS+xO4dlAnYbIBYBRQqzwmMExSEpgxT4UYewv0qQ3sykqbF1kAwyaLIlJU4ptJtwnptnyeYpnzh/sz5jXBzkhnXhZH3tn9GYrRa3KoDV2GZ6Tr5umq8pKnuy6u2Qb5i319sFgWw3DaJIYoVVHkkVT9sxRYR2ZRoBpg0Bcu6csb1TTDmJbLxfPVfRJKFrwzUTAiaDrsnvxOMkiqOiisOL37rclJ4AGSJtqel8aZhQy4rSJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773691740; bh=G962lguBMYvO//roaFv3K/eSyxakGkfONoTK/YWGth+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CNFpohbRwxfPIyi6JbcZN4z7f+sRC8+EeVEZid/rN+PImdRPDiWRe+WaC92ZZEspX8ooDdwh6dO+5w9oy4Rb5RSISOFtOw+R9/q2ix/1auqgpZ4I3BmCHbi8kv/fR9xNC+yCONkB65p7tkCpo0Py9drm370Mv4qeEPXxxlkHSbIIVHtwT8JVxPKriUlJtc6vRyKr0OvmFFmAzc2ofoIdP7K1xY/+RKJkXJ1WGC5SFlUTol2Ka130/zvMFHUEkxF7hx0O13j7WH9IlylcbssLkUjiySH8qTzWQSfKzVzlU5nLRdVzpLtm1Bh13B3aNR+SUm6k+6CUxVtQNUUgAo81pg==
X-YMail-OSG: qSAYaBoVM1kZa1GH84d8tmTC2JcWbidQzsmHisd8vzMV5wqAA3jyt5dL6mKCozY
 oySNUkIry6rL4tcH.fx.8L8YsP8w0ncqCIqaREflccoSpaPqH9oRM0E5Y8xBiYQCA2KbC1EL9dE6
 T6IOAblV74SACZaQULQEN84V2dl6NN9.XUi208hEcuJUfVLHa7WLJDi_n8qUdPaeHT_LQwzzM0A.
 Q8gEUQZ8mJsUugpmaNEGEMKPVdoW6RUc8zExWTP55EMV.QDKwOGTJEqgzk7Rlz1jJ9cDsHrPM_hN
 yYLvrV3U9Q._5I_GP_JYmbuoMKVv3v7Il2jYec2wJRQtOM1_ymy1pALphMQnp4V_.xmBsIm6.iMr
 IH1zOBna24VN7wh_c0VsiV5V2NNkfTBmvaWXPWKPaSrNfaLNoQ4QP1Tqmk_13PKPE_yKzbGC059S
 5sMwJVrHU9k5GyIHuHEUCP1qxP0jJzwgUymiICF__5LaDwnb7JbH5sAf8FrPTEfdayS81CjbdgpG
 1YLyNG4mYmZlT_GrPB6zZyjWp5JGabh6DycMVuzkIJdn03Lww0xqxy7R3oVm85ziA.pf4IFQ3RWv
 ylMxYiKTi5jRnh0x4bzYfB7UnLaGqSgB3UOQdMa7UMhimnUpevqX4pHJNDPeWuRA4510vqsd5RaJ
 1WyrzE_csoeaSMXGIarUknf3TNGp6.FKZBAeWhYUjtCoMIeQIji5s2rYCHb0hKqopkm8RDg.CQuj
 HDSK1i3Ojr6TEMWBZva7nHxFbavsatAR.FSnGMVozA.17HHlxppDShCtUadq0LQuxMsP8KL0QjRe
 vClhctZSsSiM0.LOqo1bwYna5r.2AY2q_YjpiCTm0HpDqHZo9YZGNt20Q3d9GAIQ9Br7aF2d19Be
 RGjPXboGDmBq9pBCetxmoEodIPSmLQIUX9fOEMZ7zv3K6bnzAoO2P42qc5JpC2uIIDJnQNUak1Dt
 TLUzpYr0B8Te5COJ3JRpR2qiLLinfBzpOQGFfVXrbkdBW59EOjTt6Lxn53XQgzR4oMG0gbJ27G_X
 boPWCSVd_yaF7.3yoqBEomE8Nf93mOG0QUNs6iKJee_KLk8Bc_2fMWaHlN_tzZoI.N2jg5y8XItM
 GXDzCCghezUcjd8p9FvxpDbPwW9MjxCo7M6BEokMMNA5estPEYxC_FputayelW3szEcz57sClUHN
 LmR7h9BlkrUT6UZv3uk1C4.pSNjowKVfQs6XOQoz.qLe.VPJM_zinxkxzRFpg1o_9dNKfBbzIRfd
 .LOx7DeUdtSK_fufohqBQ4VFYcBk6rbWmhJmfApMDap_okg1Yp_yxNacsKgbfi73n2eJeucq0W.l
 m30p87qFNhpZJyXvqFT8X2zhhsw56E55PlXXqZf_oJ97OxHkrQCFT57bC5pDgMY3IYLHAQhEE7VJ
 1rlTGbNu9qg43QuVkSRVrleZ2_.y0dtE9bRQFXa2zMk108VU_KZtAybz9mu..J2unen2t6OiMkKu
 mm9MJDUi11RCmlDV2H12pFQzta9p2Wl_AfBxSX_8jpEjaepl9Uaei0Nwq0Kvk43.XG2QlG5yMTXJ
 21.uLA8Hg9lduCNmjrmcXIgpR.3Ny37S.KmrivrJQMNweY_xTLdJ257d933Aq0Xh8Ifgf3I5nILN
 Gp14Lc0FN8xrk3l_TxPAD1A9W1_etfgY05jlUjnCimxeTdeJZIvTooxG4ito2lre219K5akJ.gC2
 piGQOJqZjyhQK5gHKj_qkrfmp4tGlfR6XT.5DRl36FaWcRhKIYL98f5imCT3tewHmVf.ALgJHsha
 weWHOf2UNfUxlknUFZFtqWqplG2kfVE6cW1GQY_GowS.zn86tEEazbgM7vxRushRTWAyV_vE0RCe
 wR035yGUxiNcPpcNwvlsh0mufMvXEfu2srExJQbyXkmaTV9_UUux3zUQcQFzjBU74N1NWEpzs5eK
 IRJeN2GDN2eSRrD4xhkuk3eSZ2tcYrbhAYP5iLXanXL6XLTXXMovsb3RlMwTQNMdRFRudLqiCZST
 P0H8jvoFoKcSKLIGVgjzfPDel1xStiazA8M9e9K4tW6f2xiLvOO1BFx2xBK940Q8PSS.t7xkCPGv
 5rKatVxE4274MlIIL4Zc54SRhFeKs_4N6nwXeB25iqzpV656M0.oxV8D.8aa9aImuke.z0VkMM6U
 8BcBcWPLI2ovnOs1g6A52Bw_GM9a9COTQnu1iGvgTkLLiaxqMmfTtqqdMkA9SsKZMKTmgRLPtVI5
 1kyGdVXjOFpNBsO7rUHkSSxs1DiyjI4dI1AZVXXhpbP_b2noVhxrExA1SEF28PeYnNq9dDXLJZYb
 TY9U3ueix6nEpqDe5D9v7EeUWzya44shASRYtPOcJ
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 9fb3d910-3cea-4302-bb56-a02a096f3f77
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 20:09:00 +0000
Received: by hermes--production-bf1-697f88457-2mcdh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5ca47949ee14b67894fe181fb3be2d4f;
          Mon, 16 Mar 2026 19:58:48 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	jerrywang183@yahoo.com
Subject: [GSoC PATCH] apply: report input location in header parsing errors
Date: Mon, 16 Mar 2026 15:58:47 -0400
Message-ID: <20260316195847.92386-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <xmqq8qq6y4ql.fsf@gitster.g>
References: <xmqq8qq6y4ql.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several header parsing errors in apply.c still report only line
numbers. When applying more than one input, that does not tell the
user which input the line belongs to.

Report the patch input location for these header parsing errors, and
update the related tests.

While touching parse_git_diff_header(), update the helper state to use
the current header line when reporting these errors.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 apply.c               | 86 ++++++++++++++++++++++++++++++++-----------
 apply.h               |  1 +
 range-diff.c          |  2 +-
 t/t4100-apply-stat.sh | 38 +++++++++++++++++++
 t/t4254-am-corrupt.sh |  3 +-
 5 files changed, 106 insertions(+), 24 deletions(-)

diff --git a/apply.c b/apply.c
index b7b0a201b3..700809f3e6 100644
--- a/apply.c
+++ b/apply.c
@@ -42,6 +42,7 @@
 
 struct gitdiff_data {
 	struct strbuf *root;
+	const char *patch_input_file;
 	int linenr;
 	int p_value;
 };
@@ -900,7 +901,8 @@ static int parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		return error(_("unable to find filename in patch at line %d"), state->linenr);
+		return error(_("unable to find filename in patch at %s:%d"),
+			     state->patch_input_file, state->linenr);
 
 	return 0;
 }
@@ -937,20 +939,35 @@ static int gitdiff_verify_name(struct gitdiff_data *state,
 
 	if (*name) {
 		char *another;
-		if (isnull)
+		if (isnull) {
+			if (state->patch_input_file)
+				return error(_("git apply: bad git-diff - expected /dev/null, got %s at %s:%d"),
+					     *name, state->patch_input_file, state->linenr);
 			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 				     *name, state->linenr);
+		}
 		another = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
 		if (!another || strcmp(another, *name)) {
 			free(another);
+			if (state->patch_input_file)
+				return error((side == DIFF_NEW_NAME) ?
+					     _("git apply: bad git-diff - inconsistent new filename at %s:%d") :
+					     _("git apply: bad git-diff - inconsistent old filename at %s:%d"),
+					     state->patch_input_file, state->linenr);
 			return error((side == DIFF_NEW_NAME) ?
-			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
+				     _("git apply: bad git-diff - inconsistent new filename on line %d") :
+				     _("git apply: bad git-diff - inconsistent old filename on line %d"),
+				     state->linenr);
 		}
 		free(another);
 	} else {
-		if (!is_dev_null(line))
-			return error(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
+		if (!is_dev_null(line)) {
+			if (state->patch_input_file)
+				return error(_("git apply: bad git-diff - expected /dev/null at %s:%d"),
+					     state->patch_input_file, state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null on line %d"),
+				     state->linenr);
+		}
 	}
 
 	return 0;
@@ -974,12 +991,19 @@ static int gitdiff_newname(struct gitdiff_data *state,
 				   DIFF_NEW_NAME);
 }
 
-static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
+static int parse_mode_line(const char *line,
+			   const char *patch_input_file,
+			   int linenr,
+			   unsigned int *mode)
 {
 	char *end;
 	*mode = strtoul(line, &end, 8);
-	if (end == line || !isspace(*end))
+	if (end == line || !isspace(*end)) {
+		if (patch_input_file)
+			return error(_("invalid mode at %s:%d: %s"),
+				     patch_input_file, linenr, line);
 		return error(_("invalid mode on line %d: %s"), linenr, line);
+	}
 	*mode = canon_mode(*mode);
 	return 0;
 }
@@ -988,14 +1012,16 @@ static int gitdiff_oldmode(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	return parse_mode_line(line, state->linenr, &patch->old_mode);
+	return parse_mode_line(line, state->patch_input_file, state->linenr,
+			       &patch->old_mode);
 }
 
 static int gitdiff_newmode(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	return parse_mode_line(line, state->linenr, &patch->new_mode);
+	return parse_mode_line(line, state->patch_input_file, state->linenr,
+			       &patch->new_mode);
 }
 
 static int gitdiff_delete(struct gitdiff_data *state,
@@ -1314,6 +1340,7 @@ static int check_header_line(int linenr, struct patch *patch)
 }
 
 int parse_git_diff_header(struct strbuf *root,
+			  const char *patch_input_file,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
@@ -1345,6 +1372,7 @@ int parse_git_diff_header(struct strbuf *root,
 	size -= len;
 	(*linenr)++;
 	parse_hdr_state.root = root;
+	parse_hdr_state.patch_input_file = patch_input_file;
 	parse_hdr_state.linenr = *linenr;
 	parse_hdr_state.p_value = p_value;
 
@@ -1382,6 +1410,7 @@ int parse_git_diff_header(struct strbuf *root,
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
+			parse_hdr_state.linenr = *linenr;
 			res = p->fn(&parse_hdr_state, line + oplen, patch);
 			if (res < 0)
 				return -1;
@@ -1396,12 +1425,20 @@ int parse_git_diff_header(struct strbuf *root,
 done:
 	if (!patch->old_name && !patch->new_name) {
 		if (!patch->def_name) {
-			error(Q_("git diff header lacks filename information when removing "
-				 "%d leading pathname component (line %d)",
-				 "git diff header lacks filename information when removing "
-				 "%d leading pathname components (line %d)",
-				 parse_hdr_state.p_value),
-			      parse_hdr_state.p_value, *linenr);
+			if (patch_input_file)
+				error(Q_("git diff header lacks filename information when removing "
+					 "%d leading pathname component at %s:%d",
+					 "git diff header lacks filename information when removing "
+					 "%d leading pathname components at %s:%d",
+					 parse_hdr_state.p_value),
+				      parse_hdr_state.p_value, patch_input_file, *linenr);
+			else
+				error(Q_("git diff header lacks filename information when removing "
+					 "%d leading pathname component (line %d)",
+					 "git diff header lacks filename information when removing "
+					 "%d leading pathname components (line %d)",
+					 parse_hdr_state.p_value),
+				      parse_hdr_state.p_value, *linenr);
 			return -128;
 		}
 		patch->old_name = xstrdup(patch->def_name);
@@ -1409,8 +1446,12 @@ int parse_git_diff_header(struct strbuf *root,
 	}
 	if ((!patch->new_name && !patch->is_delete) ||
 	    (!patch->old_name && !patch->is_new)) {
-		error(_("git diff header lacks filename information "
-			"(line %d)"), *linenr);
+		if (patch_input_file)
+			error(_("git diff header lacks filename information at %s:%d"),
+			      patch_input_file, *linenr);
+		else
+			error(_("git diff header lacks filename information (line %d)"),
+			      *linenr);
 		return -128;
 	}
 	patch->is_toplevel_relative = 1;
@@ -1577,8 +1618,9 @@ static int find_header(struct apply_state *state,
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			error(_("patch fragment without header at line %d: %.*s"),
-				     state->linenr, (int)len-1, line);
+			error(_("patch fragment without header at %s:%d: %.*s"),
+			      state->patch_input_file, state->linenr,
+			      (int)len-1, line);
 			return -128;
 		}
 
@@ -1590,7 +1632,9 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_diff_header(&state->root, &state->linenr,
+			int git_hdr_len = parse_git_diff_header(&state->root,
+								state->patch_input_file,
+								&state->linenr,
 								state->p_value, line, len,
 								size, patch);
 			if (git_hdr_len < 0)
diff --git a/apply.h b/apply.h
index 90e887ec0e..5f2f03d3ed 100644
--- a/apply.h
+++ b/apply.h
@@ -167,6 +167,7 @@ int check_apply_state(struct apply_state *state, int force_apply);
  * Returns -1 on failure, the length of the parsed header otherwise.
  */
 int parse_git_diff_header(struct strbuf *root,
+			  const char *patch_input_file,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
diff --git a/range-diff.c b/range-diff.c
index 57edff40a8..2712a9a107 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -140,7 +140,7 @@ static int read_patches(const char *range, struct string_list *list,
 			if (eol)
 				*eol = '\n';
 			orig_len = len;
-			len = parse_git_diff_header(&root, &linenr, 0, line,
+			len = parse_git_diff_header(&root, NULL, &linenr, 0, line,
 						    len, size, &patch);
 			if (len < 0) {
 				error(_("could not parse git header '%.*s'"),
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index b19fc9fe50..b3d93d8ed6 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -87,4 +87,42 @@ test_expect_success 'applying multiple patches reports the corrupted input' '
 	echo "error: corrupt patch at bad.patch:4" >expect &&
 	test_cmp expect err
 '
+
+test_expect_success 'applying a patch without a header reports the input' '
+	cat >fragment.patch <<-\EOF &&
+	@@ -1 +1 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply fragment.patch 2>err &&
+	echo "error: patch fragment without header at fragment.patch:1: @@ -1 +1 @@" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'applying a patch with a missing filename reports the input' '
+	cat >missing.patch <<-\EOF &&
+	diff --git a/f b/f
+	index 7898192..6178079 100644
+	--- a/f
+	@@ -1 +1 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply missing.patch 2>err &&
+	echo "error: git diff header lacks filename information at missing.patch:4" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'applying a patch with an invalid mode reports the input' '
+	cat >mode.patch <<-\EOF &&
+	diff --git a/f b/f
+	old mode 10x644
+	EOF
+	test_must_fail git apply mode.patch 2>err &&
+	cat >expect <<-\EOF &&
+	error: invalid mode at mode.patch:2: 10x644
+
+	EOF
+	test_cmp expect err
+'
 test_done
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index ae0a56cf5e..96ddf3c53a 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -65,9 +65,8 @@ test_expect_success setup '
 test_expect_success 'try to apply corrupted patch' '
 	test_when_finished "git am --abort" &&
 	test_must_fail git -c advice.amWorkDir=false -c advice.mergeConflict=false am bad-patch.diff 2>actual &&
-	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
-	test_cmp expected actual
+	test_grep "error: git diff header lacks filename information at .*rebase-apply/patch:4" actual
 '
 
 test_expect_success "NUL in commit message's body" '
-- 
2.51.0

