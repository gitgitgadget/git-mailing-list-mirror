Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE494347BB9
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764616; cv=none; b=ZrkZPBP9YzFlYlrNuB0lGGiUHWHrVhalnTQrcU10/YYdr6vkQsdnNDYN4xHt/4x7PqlwScGPcxSHics/yD71kHrqftSxrigJpJCEF7wFi6AxTBku2cQHTg731x6vwliJmw2a1MvgWeXZZsYRprS8gCAx+ofZ6+sBswAiFEwxjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764616; c=relaxed/simple;
	bh=/QjHsASi8Qz1HcAoG2t6tclFHPPTs7KL3gRnoMhXR9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR9PHVh3m0dQwurqwtx/wwqsi4MaEjoCLWZdg2Jb2iUTdhRebeH7Ywwmw6IB3Zi2qSSJlMJd6KHpOa1r0tWmVkn+0VbfSdE2/jPL/Z04ad0vdnN4p7zct9ItBt4YIyX0NgbwOldTq5wjmfWrYR/CzR9rS2EZGIoN6F/qSs2iu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Xe8QGaK4; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xe8QGaK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773764613; bh=soDRodfIopKGwmkaQ3Om0tXtt72l7jGQDcCPqw4n85g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Xe8QGaK4bdHai6l/IyuVX1T50xgqNXQO9FzNWSIJDIK0a3JbO+3vZPOXhjVU7xjHDtqJodAjLK4DpdvF6KYEiRPkQslnmcgzzCpUx7HVSO/Ihm2GRUaqHqnq34bWWeqRgZW4S4KBavyR99KjvSHPMMDhTbaGpDLshPaRm9uy5O/BYYJ9q9139Af1fD9NHL6v05dOe3RarpLD1QhQGWRovMdJo72BRcwYyX9weZOwZ3nUUi4kE/tIoFu03XTleYZnVVmIZ5WcfwR9j3wtP1tma6X+eWw2tHMwrbtOBSxAO2WHdQuHW1ClvDy5RkIDcrQFQNqhJY4r1XaesZmc9L17RQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773764613; bh=mIuJWD6KhVaCx4YTrlwiyEsHXqcdJ+xB41bprwHkkuY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=muYLygL7n+Atb9rMqGa59/Vey+AuDLA5QYQb4YNIPXotHpa1ahqVB3Es5enbPAv6ROOk0R1OyF23n2VmIXAafVDJqLszzTPGSWgiUWgUiOtlxWk42TzJyuCpX3Aqr2HsyhPRxbwBYmfARjQXvkRVItywNVlMovK8sKOh3DlvETe8ZNvXMV3XUiJFg8VwPnTClW8CWZ5yzDeS3WIzdr5yuUnpTWU8a3C6rCmjqzW+z/vAwKHsZLGP8aKjf9afauWDBo+wZAU8AY+k2/V2sGQp7OfNUU5XBnoOF7txQEx5qUzy+LD8D5DMi8r5xyrMtjjtuYnudI7Z0BcYJ63C5RZiew==
X-YMail-OSG: zU4ngSkVM1nhffhNBbIUpXKFmROnMxcEvnshnvf.gbcWEDnXGEAeOlV4GoIzbYV
 fl6_eKbNIV0jzcWw_W15XMt83CdvIP9Ye8fuWqRvupAL1uIicqiFLGA1NjqoP6Jyu8VvXWCMHawI
 5rb6ah66VG8MM2vkqLDRVa2VyCRVbKajGm494EEy.Ed3rmpM53P8_2aNtpOvqLsejbaTq_wAy3BR
 KeRwhbdvK_Nd7fdRrkq1uRIIbt8_suY79SMInUuBgisljyGl1YHP8.Ow_p.ZXJN0BzDgQ0fcB1z1
 P395TQLKM61lDAIjW4UGA2DcNC3GiGJ9_4vnDJzjoN.PTdVew0xId6DwHGc7kMx_xjSvCQvfWLzl
 IXjFHIC1ZJe3LrsmLY8reYIOMzhE1NpzAPiNSHZAQ1Z9M8cH.37Qds5rhT0ANRlW1iZtju4QAzro
 vX_7g2TOB9hJhw2fN.7soo.6X5Xd.lbXCyOWotTDRsUfWGmhgDSGBMRn6KGNbnQGaCTvKlvjUQ1R
 NRRDB6pna2oKpNQL98lKO_MGCjXwMwOIIKs0DvPvdyDqltveO3fFp40RrAhjBEPoHSnFmAkustAY
 7cmLPCxd5TBtskE6_ptEpu36kyIFbCYk72QZKJ0QeA2AXQTWpmJejDRvYwyRA_t6M6jBaget3Rq4
 ZyD7Yy7zieocjq3noWfUadlPiin762hS_BQ0JVn09mmmGZjN9Us8ac.BDZ01kJCcyqPgNLQF.BcK
 wCITIO.tRVB9uEqfTNGoZB6VRcXMVNm6RZyDgvL9psdJi1pVgiNTdteZG8lQtFa5AsQXYsRpaepO
 9nrhpvpmXhwGeq9KCSgzCLSRvpsmstNxPl7XULy2pCP4akgaS0HR2n07.VRcLUO1hfXHA_Ao2fC2
 L8vcm7F_mGfJs4DxKKzNa3VxqpjUErUdZnoMlrqkFRsq1J2J3w1V9KeiatQLnqZkx4L9tdHwoTHD
 WBuvYr0sqf_KfWkVu_6IlnPiZnWPRo6FCwJRXsElmtyrZ3f3ve2iyzwjieFyk58gkXEcX2Qpj5XZ
 HWAM4226MCUasGOU5PuoxqMsTCTA..d4CdPDHH0GpVnXtcTBCZCkYLWh53pMpvU0vQbhO3pot5be
 E1C4y7FYhmMCc67zE_x6gomOte.FkCFLH7oThIl6XqI4nvMW.Aj31yVj2kG9MhIQz4bh4KOxPlej
 3TINTbUfsDdfghSV2IHhrVXYpMb77EP9KrLL20IdFcqJI07450LsbIlHybhUMmxn4.eetvBaX4ik
 VbbNBA2MwM0jOhhPfnckF65cVl9chmbGbDyPBRVGCJBnCkll8bBBdyf8hUqfTVmrw_sirynUQk4Y
 LuGVpbcjxWqotySPSYPiVFcTS7SnOuVk.7h3LbyNaY5hGHF6H84fu4HsXPOF4BN6utFfVDCOCTnU
 ztmfSOQ4_haYbvWE4AuJBuxz3IxwgqzwXqDJeDR_hVlyKZ9sPb0QG.YTZk5gSAw1HAAaK.3n7jKo
 4RdOWauWuHn6PAA7zWzY8uSRhbhkxDzRyK2ACg5q_oTVXyTt6HmRoRrPje5ke1L9Ocgrerv2CSKx
 0nGSut2K4ia.j4IZg2IrlBs4dO9IzZirSrxFOL2wHkr4kspnfdIc5DtACNwv_jMRAOpR75i.3qE7
 vH5MieB7lU_AdGJeRtGkS2EBuvEr3vAjO5zxZ_K2tlsEXFtXvySpb9OJAjWv55T3v16UZ2EhIQgR
 Yh7J6DWwrzfte08hoZxDWawdnwMIm_tmskVUSr.CQZPfRnP.9g78hJWEQB5GhILLWdSNPfNWtbnd
 6bRZy1uEXRG2u2CXydQN8.OMRMnmAcVF1neQFVuL6IqQ_Db9YwdsS.UCI8xhUZ0G6GgEv8qFPVxS
 PAeGkiujR8Pstq.H_DOGsMHJW3zwdIC7XPz.AdyDzIhvlhupQoWFlaRwv_BkqOFOHNWJRkej96Dk
 F0ZJcALiEyPFVSAcS5eBUXEChFH4XzaAMfYbqfKe0z0OA59LOxJXASbjjfx_H9Auranw12pYPHHW
 l8.kTjHZYovHHtniFkBvKGYfmHyyuHzHaymkOgW7lZTPYfigjyBYgg.SyKCSqc6d_pfqRzzRVHwC
 ftSvZSn2pioEdwMIcoqrMlF42QQMyBNJhCqRbZ2JAIgGrK6x2pQUFEjNdlMv0iLhaZWxtDMk46Rh
 dEsCEZ4E33xbfJHZTDysMv.FMw2_zQ3H3Hskb7zau5Du.r23lnfGEtHhUZ_KKdAOK9I8Usvmfwkz
 sL3_DKBx47QON31VlU7RBVY4VMIfY72mvPUSerof407UlA9pY9C13PhOA4VicVoCy7BQQcotKJU.
 uI52PRUGTeXlu0ojI6lbH_nJRQv73bnREuf4M3r2JlbM-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 5bddbfe0-9df5-4911-9300-c44b0f0bd6f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 16:23:33 +0000
Received: by hermes--production-bf1-697f88457-f5brd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 275727739a5229c22067aab3db4f1e1d;
          Tue, 17 Mar 2026 16:23:33 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [PATCH v4 2/3] apply: report input location in header parsing errors
Date: Tue, 17 Mar 2026 12:23:20 -0400
Message-ID: <20260317162321.71812-3-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317162321.71812-1-jerrywang183@yahoo.com>
References: <20260316162123.84532-1-jerrywang183@yahoo.com>
 <20260317162321.71812-1-jerrywang183@yahoo.com>
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

