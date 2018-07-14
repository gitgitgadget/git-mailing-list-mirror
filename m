Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD771F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeGNWFT (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54293 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbeGNWFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so1394960wmb.4
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZBgv6Jqk9EVh6/Hijetao3liAdLmN6CKEeHufmaRQ8=;
        b=tHo7os4HmQS8lGkrvPX6u/38a/WTh2sEkhj3KjVLzf25oSuQTg+0eZ0/UNy7ED90+c
         w8zIPrPQU65VklYW3FuPGSDCK/8/yye44+QoilfZHFfaCtz/IJir6OucB/RwS19PptBq
         raWP/zRSBVL9xZK8mnS5gAt3CugzExtZq+j10c5qQW8BgvGxbmRoyZyrtl7lF0ytigTs
         rrEc3mKjs4IHaU38cNQrMPuQzqJ9Mghjj4n6gNaCxK6PB/cPAqz1S2czHj4SFUf77ILA
         Ag9DaYooPnEN3Clqa/B4+SnNz/6/b7mhlMu05bE3uOdepbWni3gD6ypMWDNiRF7r5RxF
         lkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZBgv6Jqk9EVh6/Hijetao3liAdLmN6CKEeHufmaRQ8=;
        b=UWm18gwWr5H04n1J4xrhCTL+LoFqoVmAnbPxMFdHJs1YmtFylk3rjbvNeDzJjj9euf
         N2h+u23e9daOAIHPPLhBF9q7leUcEXiYVOEGDseUlvQ/fMtZCkUPcYbhqhYsxuFlmliQ
         ce4i0I13hx6Cgse5/7VmF/HCKAfYTACoKORTMi8IeCG3pOk6MN3o3Im03ekTbJcoD4Zs
         MkYRG1IlP3Abp68XrrKdyOrB8razd+W4myOqS0SUojzyEMKQiK0vb5WGJvowKn5rP3hz
         XX0lye3BfGTIzNOGz64uu9qGcw1UIO+Ul0tfvaTtwDcb/wJ7qRFuRHCp/77oo0vrpotU
         6bXQ==
X-Gm-Message-State: AOUpUlGm1iiM2NSBP8EtbqLjIA6U3z9Y6XeO/CJYP23cywQ39UclcSOC
        +9bCWjZ3W3MKFQDQIp8TAbhCOpP/
X-Google-Smtp-Source: AAOMgpdcqSl+IwzzA4Zx6R9izM6uDkPQavlta5biMAjufZ6KAVJsL/wP63xiEe10r5leV7oP5bIi+w==
X-Received: by 2002:a1c:6354:: with SMTP id x81-v6mr6138721wmb.23.1531604691854;
        Sat, 14 Jul 2018 14:44:51 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id a13-v6sm11875751wrf.93.2018.07.14.14.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 02/11] rerere: lowercase error messages
Date:   Sat, 14 Jul 2018 22:44:34 +0100
Message-Id: <20180714214443.7184-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines mentions that error messages should be
lowercase.  Prior to marking them for translation follow that pattern
in rerere as well, so translators won't have to translate messages
that don't conform to our guidelines.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/rerere.c b/rerere.c
index 473d32a5cd..c5d9ea171f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -484,12 +484,12 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	io.input = fopen(path, "r");
 	io.io.wrerror = 0;
 	if (!io.input)
-		return error_errno("Could not open %s", path);
+		return error_errno("could not open %s", path);
 
 	if (output) {
 		io.io.output = fopen(output, "w");
 		if (!io.io.output) {
-			error_errno("Could not write %s", output);
+			error_errno("could not write %s", output);
 			fclose(io.input);
 			return -1;
 		}
@@ -499,15 +499,15 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 
 	fclose(io.input);
 	if (io.io.wrerror)
-		error("There were errors while writing %s (%s)",
+		error("there were errors while writing %s (%s)",
 		      path, strerror(io.io.wrerror));
 	if (io.io.output && fclose(io.io.output))
-		io.io.wrerror = error_errno("Failed to flush %s", path);
+		io.io.wrerror = error_errno("failed to flush %s", path);
 
 	if (hunk_no < 0) {
 		if (output)
 			unlink_or_warn(output);
-		return error("Could not parse conflict hunks in %s", path);
+		return error("could not parse conflict hunks in %s", path);
 	}
 	if (io.io.wrerror)
 		return -1;
@@ -690,11 +690,11 @@ static int merge(const struct rerere_id *id, const char *path)
 	/* Update "path" with the resolution */
 	f = fopen(path, "w");
 	if (!f)
-		return error_errno("Could not open %s", path);
+		return error_errno("could not open %s", path);
 	if (fwrite(result.ptr, result.size, 1, f) != 1)
-		error_errno("Could not write %s", path);
+		error_errno("could not write %s", path);
 	if (fclose(f))
-		return error_errno("Writing %s failed", path);
+		return error_errno("writing %s failed", path);
 
 out:
 	free(cur.ptr);
@@ -720,7 +720,7 @@ static void update_paths(struct string_list *update)
 
 	if (write_locked_index(&the_index, &index_lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die("Unable to write new index file");
+		die("unable to write new index file");
 }
 
 static void remove_variant(struct rerere_id *id)
@@ -878,7 +878,7 @@ static int is_rerere_enabled(void)
 		return rr_cache_exists;
 
 	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
-		die("Could not create directory %s", git_path_rr_cache());
+		die("could not create directory %s", git_path_rr_cache());
 	return 1;
 }
 
@@ -1031,7 +1031,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 */
 	ret = handle_cache(path, sha1, NULL);
 	if (ret < 1)
-		return error("Could not parse conflict hunks in '%s'", path);
+		return error("could not parse conflict hunks in '%s'", path);
 
 	/* Nuke the recorded resolution for the conflict */
 	id = new_rerere_id(sha1);
@@ -1049,7 +1049,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		handle_cache(path, sha1, rerere_path(id, "thisimage"));
 		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 			free(cur.ptr);
-			error("Failed to update conflicted state in '%s'", path);
+			error("failed to update conflicted state in '%s'", path);
 			goto fail_exit;
 		}
 		cleanly_resolved = !try_merge(id, path, &cur, &result);
-- 
2.17.0.410.g65aef3a6c4

