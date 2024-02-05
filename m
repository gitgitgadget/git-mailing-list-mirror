Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750132C19B
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143759; cv=none; b=rwzgop/aKypkBDF1CDAfvXxNRuiZu8/ywAeyyp0lkqSOTrkzbqP7/FQMc04j6zoR05qOFzn9uKd7/navwbgWWPr/CBWd5uiPe9w/T3pJ6h+NOUsRCzAlZhoSwPf0pmiFY+SV8Rk6pTbs/nA1XDNtey/F82m3qk1/Z+ISPhojR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143759; c=relaxed/simple;
	bh=s1XZfNUmOu5U8U0LP+EDbjIxdum2Az1SW0uxkylOJnU=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VnUgnLtoI+uiFFbEyTBqvrqJtTxtnsTyOGxasboomT6nlUOI+2MPJZp8Go5/DIg9XDtb+WTCj46xtKv4tux2+BVh6GreOFB3z7Qqls3+dCPDmvahNH1qaxoAQ8Y1D/+PNLp1wIRNAQ1jPuS/Qreq/wXj8w12gT+8sWH52Ni8+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgL+7Nrt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgL+7Nrt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdc653665so6916495e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707143755; x=1707748555; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lAnDrUGXypS+2nfQBrND6mg3/VCu7DGQAbTlb3WLQRo=;
        b=cgL+7Nrt4FC+CHR+elITQLETXirRTZAUO6Ha2IHIGgwWQBfNArlQR7tRQUDLGg2/RD
         2IJs/3Uj50wVDyAogXVAbFLhIpJviRkdIs/zWvSN3rf89TkYIG2Hf1OSZPmbIChqlBDJ
         pmC/viVUbmSeDTwsil7SYYpekQhKbvI0SjNo66cmjoXXkDsooQY7w/lmhgw26K0Me8ki
         bz3cUSS3rtGOToXwBoPCX3EhedVKGQebU9b72ZO9rC0rLtPG0rcbXCGBLlxM6Sb3d/kA
         yr/FzTxYtQ9sFeD15spoK5ljfeAx8YiLCFRoCSkaBogNA3bZjE9MrCCU1G0/kDny2lTD
         2UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707143755; x=1707748555;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAnDrUGXypS+2nfQBrND6mg3/VCu7DGQAbTlb3WLQRo=;
        b=pTUCxTBxfi9amG2um64EzrM3D3PVAXFg7+bpMZE7KwszyQXa/zoDRva6HNmFLjHdGO
         qRJEBNIAhA4luSuVVTeYH9jQHLuIEwUnKJB88p8R/1mzM/NOEcjrhVWVWJxtQgd7mwxy
         Fff5UQExsFi+i1TmtT5X52MxgCg1y/kj6WDpNNI+SSjA9h3FLQAY8IMt7xk/U1CVFye9
         OtwS9wQkePTPWRNUO1APS0fQeqXjGPUpUfWhBN+D4ChPEnqKP4QCKbp9R+Ydw4p6w/fL
         aSb4Ffo2XJy1+OzTi7tae88+fBb88H2E/fWMj3x0cpzm66CT0N+prijeXlh5FM6QFrK+
         I/eA==
X-Gm-Message-State: AOJu0Yy1vft4kiJvFagFQDt0CBT6gIOwnQEpSRjgX+AkJJ0FJYXNwaIp
	yXTfLOx6Wf3Kios5ZqIgdSPbS7lULTB4JdI2gbiSjsqCQiFQpwemWw0TMZvs
X-Google-Smtp-Source: AGHT+IF/wKxmBm/NqGExT2g0UogVZIPDIQSFlMgkzUVu2wH7AQkKUjR4jPmGgcfMeCP3wFGZHbvlJQ==
X-Received: by 2002:a05:600c:4f91:b0:40e:5e25:4099 with SMTP id n17-20020a05600c4f9100b0040e5e254099mr5349251wmq.7.1707143754653;
        Mon, 05 Feb 2024 06:35:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b0040eee852a3dsm8812205wms.10.2024.02.05.06.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:35:54 -0800 (PST)
Message-ID: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Feb 2024 14:35:53 +0000
Subject: [PATCH] Always check the return value of `repo_read_object_file()`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are a couple of places in Git's source code where the return value
is not checked. As a consequence, they are susceptible to segmentation
faults.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Always check the return value of repo_read_object_file()
    
    I ran into this today, when I had tried git am -3 to import changes from
    a repository into a different repository that has the first repository's
    code vendored in. To make this work, I set
    GIT_ALTERNATE_OBJECT_DIRECTORIES accordingly for the git am -3 call, but
    forgot to set it for a subsequent git diff call, which then segfaulted.
    
    There are still a couple of places left where there are checks but they
    look dubious to me, as they simply continue as if an empty blob had been
    read, for example in builtin/tag.c. However, there are checks that avoid
    segfaults, so I left them alone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1650%2Fdscho%2Fsafer-object-reads-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1650/dscho/safer-object-reads-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1650

 bisect.c           |  3 +++
 builtin/cat-file.c | 10 ++++++++--
 builtin/grep.c     |  2 ++
 builtin/notes.c    |  6 ++++--
 combine-diff.c     |  2 ++
 rerere.c           |  3 +++
 6 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index f1273c787d9..f75e50c3397 100644
--- a/bisect.c
+++ b/bisect.c
@@ -158,6 +158,9 @@ static void show_list(const char *debug, int counted, int nr,
 		const char *subject_start;
 		int subject_len;
 
+		if (!buf)
+			die(_("unable to read %s"), oid_to_hex(&commit->object.oid));
+
 		fprintf(stderr, "%c%c%c ",
 			(commit_flags & TREESAME) ? ' ' : 'T',
 			(commit_flags & UNINTERESTING) ? 'U' : ' ',
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7d4899348a3..bbf851138ec 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -221,6 +221,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 								     &type,
 								     &size);
 				const char *target;
+
+				if (!buffer)
+					die(_("unable to read %s"), oid_to_hex(&oid));
+
 				if (!skip_prefix(buffer, "object ", &target) ||
 				    get_oid_hex(target, &blob_oid))
 					die("%s not a valid tag", oid_to_hex(&oid));
@@ -416,6 +420,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 		contents = repo_read_object_file(the_repository, oid, &type,
 						 &size);
+		if (!contents)
+			die("object %s disappeared", oid_to_hex(oid));
 
 		if (use_mailmap) {
 			size_t s = size;
@@ -423,8 +429,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			size = cast_size_t_to_ulong(s);
 		}
 
-		if (!contents)
-			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
 			die("object %s changed type!?", oid_to_hex(oid));
 		if (data->info.sizep && size != data->size && !use_mailmap)
@@ -481,6 +485,8 @@ static void batch_object_write(const char *obj_name,
 
 			buf = repo_read_object_file(the_repository, &data->oid, &data->type,
 						    &data->size);
+			if (!buf)
+				die(_("unable to read %s"), oid_to_hex(&data->oid));
 			buf = replace_idents_using_mailmap(buf, &s);
 			data->size = cast_size_t_to_ulong(s);
 
diff --git a/builtin/grep.c b/builtin/grep.c
index c8e33f97755..982bcfc4b1d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -571,6 +571,8 @@ static int grep_cache(struct grep_opt *opt,
 
 			data = repo_read_object_file(the_repository, &ce->oid,
 						     &type, &size);
+			if (!data)
+				die(_("unable to read tree %s"), oid_to_hex(&ce->oid));
 			init_tree_desc(&tree, data, size);
 
 			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
diff --git a/builtin/notes.c b/builtin/notes.c
index e65cae0bcf7..caf20fd5bdd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -716,9 +716,11 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 		char *prev_buf = repo_read_object_file(the_repository, note, &type, &size);
 
-		if (prev_buf && size)
+		if (!prev_buf)
+			die(_("unable to read %s"), oid_to_hex(note));
+		if (size)
 			strbuf_add(&buf, prev_buf, size);
-		if (d.buf.len && prev_buf && size)
+		if (d.buf.len && size)
 			append_separator(&buf);
 		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
 
diff --git a/combine-diff.c b/combine-diff.c
index db94581f724..d6d6fa16894 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -337,6 +337,8 @@ static char *grab_blob(struct repository *r,
 		free_filespec(df);
 	} else {
 		blob = repo_read_object_file(r, oid, &type, size);
+		if (!blob)
+			die(_("unable to read %s"), oid_to_hex(oid));
 		if (type != OBJ_BLOB)
 			die("object '%s' is not a blob!", oid_to_hex(oid));
 	}
diff --git a/rerere.c b/rerere.c
index ca7e77ba68c..13c94ded037 100644
--- a/rerere.c
+++ b/rerere.c
@@ -973,6 +973,9 @@ static int handle_cache(struct index_state *istate,
 			mmfile[i].ptr = repo_read_object_file(the_repository,
 							      &ce->oid, &type,
 							      &size);
+			if (!mmfile[i].ptr)
+				die(_("unable to read %s"),
+				    oid_to_hex(&ce->oid));
 			mmfile[i].size = size;
 		}
 	}

base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
-- 
gitgitgadget
