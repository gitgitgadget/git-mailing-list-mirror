Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAC920248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfBXKLU (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45088 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfBXKLT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id d9so5177989edh.12
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1KfqgYxo67isv1ht55+KiQb0LLDKefG1fDEjCa2V3uM=;
        b=KRfu+32ozHQAANmQWTLyatsr6PoFewF2MJSIegrd+McGwpqSVRg4Iz/eVqpgkNWETr
         QrckoUV83w4VVRKJRz49eILMRqFtoY3JRG1MtoL2upkH3+mTSh9MaIUpZH7cFJuJP2qS
         2ztipv8g5OLz2bLL6tLykZKHGLVfino1vGiU3Wkkl4ibPKjhFIyfDy6wb43xGSfr/itO
         3804bIw+DYRIJcDQm284Nqm+axkXXMZpfNvNtRRaUfbpQxdnbUWx4Rp+aUbSyIOdEnI0
         xF20d7h8Lir+HkfHk95bWcqHT/Mo2z+xYhp8NJ16QPV8N9OGefq7G1GXbqonP91w6+zD
         3uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1KfqgYxo67isv1ht55+KiQb0LLDKefG1fDEjCa2V3uM=;
        b=ajF2UUx5S3Czh6dIIB70sB+N4PTBdug+hwfHNEXv/fMjNNNO3oa5KBAQNklYArJhEk
         yAg2L/SLojLnXLWlFFg4K2snbx5Lmw4F5wuMeUCx1KsUINlNgfgbzGsPPN71OEKVWMw0
         t1/Ch8pw4G37tTL9VSQ9x4P6xeqnt+2zJU6Vwe8Ty8tX9R5YRApijzi2ZjQeoK8UCixU
         ccKZQprGxFjxYHoontVufaCEAhuvjmdDhDRbuNvKHqz53XmAQVobV80sY8KmapNd1yJ+
         ALIxZcRiPwJ+4rtNBoj9Nfv35RehyeVEFmkwJ39bHpy/k8tkYP/+FMeMVgV4AMSht0Z2
         Sumw==
X-Gm-Message-State: AHQUAuZNnCsmITgRm71LUTtDKdwK2bIpTm96kslO0ztG0/EYPZG0VBd4
        w+hCz2Jt+8TpMBgwtixvp76WHvcT
X-Google-Smtp-Source: AHgI3IYUVg0/KTdiY+x5hnpThKQRDMJyxIybiO2yaG3SVak3hqKseQKRQt5WnGyr59cZTdSJEwDeyw==
X-Received: by 2002:aa7:cb52:: with SMTP id w18mr9817697edt.257.1551003077343;
        Sun, 24 Feb 2019 02:11:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm1822374edi.53.2019.02.24.02.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:16 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:16 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:50 GMT
Message-Id: <bb04df4bfb3b045e3496e4d05eecc729c3228217.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Tanushree Tumane via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/26] bisect--helper: change `retval` to `res`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Conversion of variable `retval` to `res` to have a
uniformity of a single variable all over the patch series,
which makes the patch series unvaried.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 50 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e672ee9f18..5093e55273 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -206,31 +206,31 @@ static int bisect_write(const char *state, const char *rev,
 	struct object_id oid;
 	struct commit *commit;
 	FILE *fp = NULL;
-	int retval = 0;
+	int res = 0;
 
 	if (!strcmp(state, terms->term_bad)) {
 		strbuf_addf(&tag, "refs/bisect/%s", state);
 	} else if (one_of(state, terms->term_good, "skip", NULL)) {
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	} else {
-		retval = error(_("Bad bisect_write argument: %s"), state);
+		res = error(_("Bad bisect_write argument: %s"), state);
 		goto finish;
 	}
 
 	if (get_oid(rev, &oid)) {
-		retval = error(_("couldn't get the oid of the rev '%s'"), rev);
+		res = error(_("couldn't get the oid of the rev '%s'"), rev);
 		goto finish;
 	}
 
 	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
 		       UPDATE_REFS_MSG_ON_ERR)) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
 	fp = fopen(git_path_bisect_log(), "a");
 	if (!fp) {
-		retval = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+		res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
 		goto finish;
 	}
 
@@ -244,7 +244,7 @@ static int bisect_write(const char *state, const char *rev,
 	if (fp)
 		fclose(fp);
 	strbuf_release(&tag);
-	return retval;
+	return res;
 }
 
 static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
@@ -294,7 +294,7 @@ static const char *need_bisect_start_warning =
 static int bisect_next_check(const struct bisect_terms *terms,
 			     const char *current_term)
 {
-	int missing_good = 1, missing_bad = 1, retval = 0;
+	int missing_good = 1, missing_bad = 1, res = 0;
 	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	const char *good_glob = xstrfmt("%s-*", terms->term_good);
 
@@ -308,7 +308,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		goto finish;
 
 	if (!current_term) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
@@ -329,21 +329,21 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
-			retval = -1;
+			res = -1;
 		goto finish;
 	}
 	if (!is_empty_or_missing_file(git_path_bisect_start())) {
-		retval = error(_(need_bad_and_good_revision_warning),
+		res = error(_(need_bad_and_good_revision_warning),
 			       vocab_bad, vocab_good, vocab_bad, vocab_good);
 	} else {
-		retval = error(_(need_bisect_start_warning),
+		res = error(_(need_bisect_start_warning),
 			       vocab_good, vocab_bad, vocab_good, vocab_bad);
 	}
 
 finish:
 	free((void *) good_glob);
 	free((void *) bad_ref);
-	return retval;
+	return res;
 }
 
 static int get_terms(struct bisect_terms *terms)
@@ -397,7 +397,7 @@ static int bisect_terms(struct bisect_terms *terms, const char *option)
 
 static int bisect_append_log_quoted(const char **argv)
 {
-	int retval = 0;
+	int res = 0;
 	FILE *fp = fopen(git_path_bisect_log(), "a");
 	struct strbuf orig_args = STRBUF_INIT;
 
@@ -405,25 +405,25 @@ static int bisect_append_log_quoted(const char **argv)
 		return -1;
 
 	if (fprintf(fp, "git bisect start") < 1) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
 	sq_quote_argv(&orig_args, argv);
 	if (fprintf(fp, "%s\n", orig_args.buf) < 1)
-		retval = -1;
+		res = -1;
 
 finish:
 	fclose(fp);
 	strbuf_release(&orig_args);
-	return retval;
+	return res;
 }
 
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos, retval = 0;
+	int flags, pathspec_pos, res = 0;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
 	struct strbuf start_head = STRBUF_INIT;
@@ -524,7 +524,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			argv_array_pushl(&argv, "checkout", start_head.buf,
 					 "--", NULL);
 			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-				retval = error(_("checking out '%s' failed."
+				res = error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
 					       start_head.buf);
@@ -574,7 +574,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		get_oid(start_head.buf, &oid);
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			retval = -1;
+			res = -1;
 			goto finish;
 		}
 	}
@@ -586,26 +586,26 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	for (i = 0; i < states.nr; i++)
 		if (bisect_write(states.items[i].string,
 				 revs.items[i].string, terms, 1)) {
-			retval = -1;
+			res = -1;
 			goto finish;
 		}
 
 	if (must_write_terms && write_terms(terms->term_bad,
 					    terms->term_good)) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
-	retval = bisect_append_log_quoted(argv);
-	if (retval)
-		retval = -1;
+	res = bisect_append_log_quoted(argv);
+	if (res)
+		res = -1;
 
 finish:
 	string_list_clear(&revs, 0);
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
 	strbuf_release(&bisect_names);
-	return retval;
+	return res;
 }
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
-- 
gitgitgadget

