Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E651F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeHET0G (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55545 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHET0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so11430900wmc.5
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATpQxy0wR+AeeBLYzdcmGIK5ARyCupVIiab+mhAiRaM=;
        b=lg4gNsXlbs21nY8A9GrMHKomOBeAbkyBIu5LkYd+hjgMxDAqoMygo8e5lbmFZN2VFD
         GeWjg8uqcgw2kwgi/sgFfarCph58yum8aEY2ZJmnfjxqn/u8hZImhOodO7Pt/pIq2yVs
         /w/d7RzhbiVWwpxt5ByicTb0cpwMPhWsOq0Ko8S/p1lD0pZgJDrJpgV1YC4zNmMiJ1ll
         ehYyd3uK/xPMns03djRfMB5t4FvQ6nPQJu/eXP/7YUF32aw9hyxkQb9UsB1wfTSeySve
         yT0i6dgBo6cS3UEaWFdVr0IqRrtZmzIduvUwpZvKwH4FghVoRBXtI7VEVKeGg/U+fccZ
         bA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATpQxy0wR+AeeBLYzdcmGIK5ARyCupVIiab+mhAiRaM=;
        b=VNi3s1lxIl70N2+IT+W3U4J4TV5S8XvLAhP/s5curfvlYI43QfmiFgLsUuAkF+MQUZ
         1BuA9FUHsb9gxXgcJ5GmvzdoufQQqqBivN9DiMon0oHZhY0rv6eidOXP60QEH/x887pJ
         Ui4u+ck+22YXbp9YKDKTfoDXqSoSzdlw1kKp9IAXjwzwDu2ZW2QecO9QYS/SXmx3cDmj
         XhKccrpCwWPN5Hp6U2k8kwDgCcGxVwKytjFIJlT16eR6YnQULWvyM6jYaAPj9tg8LufU
         oitWKUW0n5Qlvq4QfkIdvKwHuJMRg06cbzUtLNU3vkll6gl2FIlIitYV8uk6ZQVZZcbl
         7QgQ==
X-Gm-Message-State: AOUpUlGgSg/gQVG8hEsDXE1ZqhiHXwZl4T0Y6IJvagN6/ekgZ0Hvenm3
        LRK/EgnzYrTPZQVlnf8tydeV6ieq
X-Google-Smtp-Source: AAOMgpcRSPeXLroV54zkQwnKQf/aR3bSItCDafpMmB8xlNzBeqHawxwLdQxoX1GkufOXx/5bBy0KCQ==
X-Received: by 2002:a1c:63d4:: with SMTP id x203-v6mr9521617wmb.9.1533489648299;
        Sun, 05 Aug 2018 10:20:48 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id w8-v6sm11003180wrp.72.2018.08.05.10.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:47 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 02/11] rerere: lowercase error messages
Date:   Sun,  5 Aug 2018 18:20:28 +0100
Message-Id: <20180805172037.12530-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.18.0.720.gf7a957e2e7

