Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C19E1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeFEUsD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55791 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeFEUr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:47:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so7445967wmh.5
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NgudV8pvPfFBYHGl3RIq9hPsw1q8E/+T5s4Q94mTcoQ=;
        b=jN1fVsEhQK580rzXXxYgWWe/bSHXud7/5HxzDEpx731g4ktXQtr0IKckrq6/oUI7iV
         35c+1M6QlgK2AIRrDGprzIxl26fnvf7ZkUX9Vn19GA3nfzxwKYA/z0bgUc6lzFh6hITG
         wkcImO9yNoN1hz8zvs+UozE06IG/4TipIHUjrKPMETSx5HZmecSOkMX9Ig/Ts5vQO3Tg
         HIy+9SLbGZlumpjhKZJdWxlUokxNr5wg4rY2pPJsgPiIGXw8m5Cr2QKsO4ehiAP0RC9E
         bukERFrjrVDCFXkcWgFJ5awmU/L7uLhzyi1F196gzR+RNiqvJCnT77Uxh2X8ypyCrGTM
         YVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NgudV8pvPfFBYHGl3RIq9hPsw1q8E/+T5s4Q94mTcoQ=;
        b=ewp2LhALy/+THTCs6A1eLuSD0R4BUTbdJtIeVQaanUyhS+OZ4wczOBaVo7+WIhj9Bk
         YWpXqwIt4UrifBdnIJkY2STrf8Q0L95M7pa/527rz0SsjwHiliC+NlXhoMN35ClKfYDP
         EiOK6x/WF8F/Gg/7jifhePT39bDYpcmLLYLOTbY08WyFadwzNq609g7+36CBeOu0Oglw
         en7t2/3cPr5ympp/zzQKgjUQ+q41MPjmTLg1tj557U7w35LJnWCc6HgZf+8VIUpBMO32
         OSGHThmZTYef8P5axpLgHLGKFmmifTQZU9wtojb44KApniu32NWgPBXvtElvuNXfp6cv
         bhHg==
X-Gm-Message-State: APt69E09qJsIT17BujK74C/9+9OxY+0AGBeoV/Y2UXPR2t8KlbirdAja
        +XRzqFhY0mvb6md7sEN1kIQC/YfQ
X-Google-Smtp-Source: ADUXVKK7FlpSaCXIFfw7mR5FojwvCIaS+ik98+fd7P9eBTtgZEbBlZ1q9dO0SIXXfyKvQrgVHtZ/6Q==
X-Received: by 2002:a1c:3789:: with SMTP id e131-v6mr437182wma.20.1528231677832;
        Tue, 05 Jun 2018 13:47:57 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s132-v6sm3256898wmf.5.2018.06.05.13.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:47:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 02/10] rerere: lowercase error messages
Date:   Tue,  5 Jun 2018 22:52:11 +0100
Message-Id: <20180605215219.28783-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines mentions that error messages should be
lowercase.  Prior to marking them for translation follow that pattern
in rerere as well.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/rerere.c b/rerere.c
index 4b4869662d..eca182023f 100644
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
@@ -721,7 +721,7 @@ static void update_paths(struct string_list *update)
 
 	if (write_locked_index(&the_index, &index_lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die("Unable to write new index file");
+		die("unable to write new index file");
 }
 
 static void remove_variant(struct rerere_id *id)
@@ -879,7 +879,7 @@ static int is_rerere_enabled(void)
 		return rr_cache_exists;
 
 	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
-		die("Could not create directory %s", git_path_rr_cache());
+		die("could not create directory %s", git_path_rr_cache());
 	return 1;
 }
 
@@ -1032,7 +1032,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 */
 	ret = handle_cache(path, sha1, NULL);
 	if (ret < 1)
-		return error("Could not parse conflict hunks in '%s'", path);
+		return error("could not parse conflict hunks in '%s'", path);
 
 	/* Nuke the recorded resolution for the conflict */
 	id = new_rerere_id(sha1);
-- 
2.17.0.410.g65aef3a6c4

