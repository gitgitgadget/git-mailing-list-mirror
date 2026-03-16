Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B93EDAAF
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691732; cv=none; b=rdiQOd6PV++lmZaGtVI37uYNXNM2Kpx8tJJX4c9Z/f5LE8O1/UpzYAYabJJimFW5Qs0lw2iELPHOr1EuZ8FbB2rx9+k2Gd/Fj3mqgxGaobPbZS1auWNfeXjTStC1jSCWXdZPBCktIbyhXD8slMndLk7RjI1FAtV7MCLieaqa0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691732; c=relaxed/simple;
	bh=/QjHsASi8Qz1HcAoG2t6tclFHPPTs7KL3gRnoMhXR9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPCIRcWWBhycZOJC2LTy3Qi5lFm8c+LNjQ39hsF39oUh+OxPyIGfD+UFmyU9eSKYvMY/HLVJZO1rkZQOujq1dMKPHz6zFYgZJ4MoDtdj7jpNnwg/NFfu4/ozpqVypfTDXIlIPb8dq8kvkJA77WfK7o6G9XbX9tBS2BhS7Oyl5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ell+ENcY; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ell+ENcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773691730; bh=soDRodfIopKGwmkaQ3Om0tXtt72l7jGQDcCPqw4n85g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ell+ENcYuw/ME3xysVQKo+EpjWKKmQbOMS23wlFl5h88S7OqeAe4D4AOD1SOPrnLvQqKRpUUYtgcoD2QWkM12SrMBAp+nitNl5khto5eYuF3ppCCl1jphJ0y6Jq76hWgRWcvTJl9bUescq39pEkpeWp9I/jqCwwnXuk/JFJlnvam9KF/BXnl6W2mnbOsTwvbuIOVTUKgCJSHqS3TEilOO2DHcZhoEnvcPZtVe8UzQHbJffyBYFEsBHjOW2wbHO+kovLD1s24xhy5ibS1XDl8/fb5059ivyWLnsmOI5EcNcjrvC6KNqZPl/d2FuK5AW2jMza7kTYl0+gvXJ02794tVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773691730; bh=VzI7UGzNhMLKoJSO6UmIuZI5e3MbpE//X2vnBAm79tw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FDCvxrpN5kEi5EHxjgycOPd4d5zN7jxdM/Bg83ydqMCeSEWCImSIkG8VYs4ZWRwAnDrQErM1dDiiC03BpRJ34PC+uuf+TDky5CzvDRdtYz1xwxL9691XcfNPq+ZwL4/YWJjZ912nvVGFYJRUi5yaxqFhl28o+hCgZ61L4oFFTEvd0G3h3M4LcUHtcck203+ptKubGaVoAphuOKt4uDHD2YsD97lorAXnrrqbORZb5f0O+6SO8mdYcYQP5nnt0ZpNcOeC0c9z69Q9LXuUW5fAEzXN4tbLHH1iKmuw2rq7eQd8iDLr5gX4LJ+nmRI9H6BhQjrsAKOZNe14v8AMKAVA0g==
X-YMail-OSG: .BH31dMVM1lv.bBDRgBDaZiJCeYFeeoUNDsB82ff0f07P_zdbrICQP.aL2Fg4ZM
 ufOx.7Lne6MgWggD4pNw87j_BqBmwA5GSMoJumhO0fmwpJRtDBGefW22JVYCJN56o3f.FGQ4tHZC
 1gzEeasaIPQ7r0PZ3ON08o1eZQbUf71fvOPs8ylqvgP30B9.FiRwoVikxqmmbSNhL1.7Qi4EO1h4
 _JPGf4fumICbgm8Yvx.ZyGKnAyCF9eYw6.VDoRpnXeBgDrqpUFclaKbwipbT.uFzlAudYy06_EYF
 wdq5FHKnJEAQhz8BG1IXZieff4VRKg18tGYBi5NeGH1.gnUJw5u8cJa_tlnHaYMoo5kwh.YZRhKF
 QQ6ofggi2HsCvQAAxTDgth7CrhPn0SNKcfOCN1mVpMgXUuHmde1x1y71Ux5uoMfP2mz8ZpNb9j0h
 MOxLV7zCW7jiuYui8O9hCX1c5RoBjEXzcaLQ.WWlullRPLj.9Gs_5g1EWSqLw01GgX55p1f3xBw3
 kBbIq951JJZ7y.4qpGk8Wxf5V4gbxFjESd2J0mE.EMmkrhwUfwJb7JDpb6n30FBQPEaqe784pojh
 qV2s4asCfZhNP9U.ZCuDGK1N.dzxRH8vrqEW_avoMosVLzVR1by3Z14pUqeB2FzYnyAXPYuS6iAN
 0kGiL1qgerOwC.koJlNEm4x.uA7Qg4cKnEXLfH7.Z1q3lSEQyAp04tv9Brxl9J9A7Rb.tuJ6Q4hY
 GSZorMhiQgDF4gRIotq3ZRPzXYLRTbnN6I_K9ot54bRv7Rzru..ks1dEbx9GWPmYF9Sgaq6CzSp6
 qWuVlbpthEdhp_tS9ipBuiULPZgjHpNJ5pdoCXKrzMi45uLl0GwyULAc1Rjvr3CMmvrMhxdQ25dw
 YNbPT99374e_e0KnFXxTu_p5.JlTnAn8fr1ZaklwOh3p9THHhlv_KDs7loO0EHmQm89_Olu7Wk__
 Ve5XGyb1EtbGGm0reQ4jjFVSiC06LkOOf2C9Jf6ehVcClzAuV23rmEFd0libqGdEcBnNCK0w.m.A
 J1C.mv17wMO_XJo7q9EA.ylmYp50SoIAr_GN5CI1J_vrv5FjmUyUnKvphm54HUJB0ekNM582OjVZ
 T0MlgZNbag83xo_VWdrGJnoqWEi6IxIvUkVV7xJJrn2mEHo6P9Yp_0zJtyKwEtWwlkbaycWI6WuK
 QupgGKC3b170eqZ20b0xJ3mBuYHCu2ckgux2354S0heQGsP6CYRjHkgNN28EP50j08XhceOxRKNN
 B0O21.QZMP0ZGV3U9CpHCDOJ4R1Bx1CKFEwj840LQa8pTXDReqU_6.RPDZHk8J8WGcLog3WuXhMT
 kMXsUnSsRjss2c6OiJmBmZJSRcRjaqQjQxxkCTpHXi.6LIMaLHgjS_YXs83qEB11.2xg5fWxeCtl
 czo8AjLKJFYrtp4tGLw_Di22e2aXx1rGa3wfk369gp.SglvdZkMAQhe1DdmzvX4kmBTVA2nnU9R.
 ATN0vmhVaVjL0y5zJl0fWkzJzkOXTmaUZzrJmDeHKvhpCITmvEsDI5fWnKgtWBc8o9HIiMhS3De7
 VRo6KGP01mlsA7mWrJk7RjY5c.GqDXUgfPGu0w_J7IL9ILdt4VaNh8mTfJHYsnsXAuoH2.9vJy_i
 hj80JcmlAT.G90sGZOv9lT4R8rVHWzgq73rK9wfmnWBAOCjWZmFyvM55b9rHF7YM..DXwD8Bp32L
 mndSHdHQbR9koeMDFH2zKmIhxqFhnxZk.1kESq2.KES_Z2jADa7kCPSVO6KDZ1.waIdl_LVvDtQ0
 yX5ueqk22cYpFJ2Rnj4ywW4ExtaHgGbQtwHxb5XKNCPy0pwp66FmD4_zc2wgyOOyGTtK82IdmolB
 g6XGDCoz39PaVVVTM2Q5VKGFxXyJmx3PgUUlR_tEjNI1.ImNZpXAUGy3BmqvK_vaA0I50VADdu6v
 duzRlcCUKYSOV9H_upR37dxP9MBtJddiisrUUvS8edqhYqG55LbCcoiGZZniwfXt7rqX9fBS4hUD
 B7BFkJVqe_DapmtXF3TMitaVPpYLv4dR_8vBsVXfedCfAZa.OpmkkLohPJZxQMxIIhamo029wKzp
 rBYJVp02AoqivWhQixCq_iXp7OwbPC5nolS0SALagW8raHw5umyI_5gDNfnRZaGe0k5tyeUFCyma
 b40DKFL1FUmmT2Rvf6V90r2Ptc918o25Nya_.7kDuMcQbdDS9_GewvE93rdMWKayKdWrGfsaDk60
 7Tp1GV4qt9qAQBDb259NgNhp.b1MwMnfROa50nT7mTm_awKDSla7sZSBfBPKEGYzKN.VvF43SF82
 6TE.lHDXY_pXwLe6valFzoaYPKT9j6h4fIOMH
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 6f1029c4-b7d5-4437-8399-c8ce3d38660b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 20:08:50 +0000
Received: by hermes--production-bf1-697f88457-fdj24 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0537d95ffa927146055b0122d53956ce;
          Mon, 16 Mar 2026 19:58:39 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	jerrywang183@yahoo.com
Subject: [GSoC PATCH] apply: report input location in header parsing errors
Date: Mon, 16 Mar 2026 15:58:38 -0400
Message-ID: <20260316195838.92367-1-jerrywang183@yahoo.com>
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

