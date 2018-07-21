Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866291F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeGUIl5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42337 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeGUIl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so11240266ljc.9
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o94a4eMMNNyKsJmmpBXn2vW/2G+akRWvPTNlTcovJOw=;
        b=QiitYV25DdvA1OK6xBzbdIa5EsSRdqSr8Hop5d/Ht3M1lW3MoeLjdqc/jwuOxdxnfC
         f/qUi10GM+liZdq2jYX+iuXxgnDF+EVBR8Q1qnbvY5605r4hgdWMrQRE0FbCW3Kt1lAn
         wdpfmq+sTYARqIDRIBj5LBZXxuM/X0GRMddfIcx3EXbALZ/BRa8KrqR+kwx9Vow3+yuk
         OBPu2enPUzoTngy/F73Or7CJdZpwPNuTLP6QUX3uKbP42ZT/Mb2lXMZjyfaCEza+i6md
         YjNSt/qU9asF3AgER597v4mPidsaLj45sdcDfS5gAW107FEBOCui+1M6iYpY6tXEv5X3
         bVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o94a4eMMNNyKsJmmpBXn2vW/2G+akRWvPTNlTcovJOw=;
        b=oWmyJvJ4EvrvmGpTUexDNIL1BsiFg6OxGyUKHcoFbl+eAeo25LpKie1LsQfuYac9ON
         C2DuEtrHLvx+wfdsDnplOCHGiqOh3rs3MyvUZGyM1O+CnmnAUJNjaa1Ep2K1dA91VlNf
         J2UKZdvcpbng9ARNdTb+gPuP9W+g2STF7oWyzzjO8e9GVBp2gyz3iQwxLZf3ZsUwLtuW
         Oos3pcxOVU74RUYqaStVK/2ZyZH6EGluNx96DAQs42ZvY5Unuyq5RumIL9CLdkpMxJZY
         dztT40CiG6NEvkcCb0pjM3wTSQQ5dLJ6MBDOrrVwjVXWfivyJOG9kevBLJ4XsXvgMVaX
         sSMA==
X-Gm-Message-State: AOUpUlE8eVh/OW1LiH02ROxTRSPTRvs1BWUyaF0qPvWXTSChuc/g/9wj
        N3TXW3bH5QH2W17LWkMaCv4=
X-Google-Smtp-Source: AAOMgpeEQnqH8gJMW2qduFpVhCm+WdJ+KAaCkJ2sP0XQ01RlfpvS5TKpeN/SEer54EE1MEhVudhymg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr3888639lji.17.1532159407391;
        Sat, 21 Jul 2018 00:50:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 11/23] convert.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:29 +0200
Message-Id: <20180721074941.14632-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 convert.c             | 38 ++++++++++++++++++++------------------
 t/t0021-conversion.sh |  2 +-
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/convert.c b/convert.c
index f47e60022e..e53911d4f8 100644
--- a/convert.c
+++ b/convert.c
@@ -190,7 +190,7 @@ static enum eol output_eol(enum crlf_action crlf_action)
 		/* fall through */
 		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
-	warning("illegal crlf_action %d", (int)crlf_action);
+	warning(_("illegal crlf_action %d"), (int)crlf_action);
 	return core_eol;
 }
 
@@ -207,7 +207,7 @@ static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
-				  " endings in your working directory."), path);
+				  " endings in your working directory"), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
@@ -217,7 +217,7 @@ static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("LF will be replaced by CRLF in %s.\n"
 				  "The file will have its original line"
-				  " endings in your working directory."), path);
+				  " endings in your working directory"), path);
 	}
 }
 
@@ -492,7 +492,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 	dst = reencode_string_len(src, src_len, enc, default_encoding,
 				  &dst_len);
 	if (!dst) {
-		error("failed to encode '%s' from %s to %s",
+		error(_("failed to encode '%s' from %s to %s"),
 		      path, default_encoding, enc);
 		return 0;
 	}
@@ -670,7 +670,8 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 
 	if (start_command(&child_process)) {
 		strbuf_release(&cmd);
-		return error("cannot fork to run external filter '%s'", params->cmd);
+		return error(_("cannot fork to run external filter '%s'"),
+			     params->cmd);
 	}
 
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -689,13 +690,14 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
-		error("cannot feed the input to external filter '%s'", params->cmd);
+		error(_("cannot feed the input to external filter '%s'"),
+		      params->cmd);
 
 	sigchain_pop(SIGPIPE);
 
 	status = finish_command(&child_process);
 	if (status)
-		error("external filter '%s' failed %d", params->cmd, status);
+		error(_("external filter '%s' failed %d"), params->cmd, status);
 
 	strbuf_release(&cmd);
 	return (write_err || status);
@@ -730,13 +732,13 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 		return 0;	/* error was already reported */
 
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
-		err = error("read from external filter '%s' failed", cmd);
+		err = error(_("read from external filter '%s' failed"), cmd);
 	}
 	if (close(async.out)) {
-		err = error("read from external filter '%s' failed", cmd);
+		err = error(_("read from external filter '%s' failed"), cmd);
 	}
 	if (finish_async(&async)) {
-		err = error("external filter '%s' failed", cmd);
+		err = error(_("external filter '%s' failed"), cmd);
 	}
 
 	if (!err) {
@@ -790,7 +792,7 @@ static void handle_filter_error(const struct strbuf *filter_status,
 		 * Something went wrong with the protocol filter.
 		 * Force shutdown and restart if another blob requires filtering.
 		 */
-		error("external filter '%s' failed", entry->subprocess.cmd);
+		error(_("external filter '%s' failed"), entry->subprocess.cmd);
 		subprocess_stop(&subprocess_map, &entry->subprocess);
 		free(entry);
 	}
@@ -838,7 +840,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	else if (wanted_capability & CAP_SMUDGE)
 		filter_type = "smudge";
 	else
-		die("unexpected filter type");
+		die(_("unexpected filter type"));
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -849,7 +851,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 
 	err = strlen(path) > LARGE_PACKET_DATA_MAX - strlen("pathname=\n");
 	if (err) {
-		error("path name too long for external filter");
+		error(_("path name too long for external filter"));
 		goto done;
 	}
 
@@ -923,8 +925,8 @@ int async_query_available_blobs(const char *cmd, struct string_list *available_p
 	assert(subprocess_map_initialized);
 	entry = (struct cmd2process *)subprocess_find_entry(&subprocess_map, cmd);
 	if (!entry) {
-		error("external filter '%s' is not available anymore although "
-		      "not all paths have been filtered", cmd);
+		error(_("external filter '%s' is not available anymore although "
+			"not all paths have been filtered"), cmd);
 		return 0;
 	}
 	process = &entry->subprocess.process;
@@ -1395,7 +1397,7 @@ int convert_to_git(const struct index_state *istate,
 
 	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL);
 	if (!ret && ca.drv && ca.drv->required)
-		die("%s: clean filter '%s' failed", path, ca.drv->name);
+		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
 
 	if (ret && dst) {
 		src = dst->buf;
@@ -1429,7 +1431,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	assert(ca.drv->clean || ca.drv->process);
 
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
-		die("%s: clean filter '%s' failed", path, ca.drv->name);
+		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
 
 	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
@@ -1472,7 +1474,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
-		die("%s: smudge filter %s failed", path, ca.drv->name);
+		die(_("%s: smudge filter %s failed"), path, ca.drv->name);
 
 	return ret | ret_filter;
 }
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9479a4aaab..306b862d7f 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -583,7 +583,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
 
 		grep "smudge write error at" git-stderr.log &&
-		grep "error: external filter" git-stderr.log &&
+		test_i18ngrep "error: external filter" git-stderr.log &&
 
 		cat >expected.log <<-EOF &&
 			START
-- 
2.18.0.656.gda699b98b3

