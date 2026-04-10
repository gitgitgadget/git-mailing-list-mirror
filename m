Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DA318ED9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861717; cv=none; b=i5k55OgYrr1oPv8m7PRY+gl57nW+xJWUdhd9Z+2Lc34klBml6V7PtRnCu/rGaUzOspWV3W59skWnodJZAmg6xxkYlRh2e31tm65M8ZQB3eKEXO2GOLRSna0OpEHc1mJaukScT78Sk3O5UBKfycuxJsGK5W1qWkA9KFSxgL0Hu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861717; c=relaxed/simple;
	bh=37n2JGg2LjPBAvLgjXTM5OQvcZ+fvivXhEj9d3ETAFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXGfnBlTb6z42Sn11Lpt8qkWTeWaPbAzFJzRtppOXCZPcTo6aR15Gr2/E4yBPZKYWd7LVOIJSQRFKWs57JXxxL13SW4sF0WWIqd0JwBlAt9YnjTgkcxkNDYJwuhYpL6TI7JmgGQWQsr0bS3rPgwGiMRsSGXduUHyR2EYSmifYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpUHZKiD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpUHZKiD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso30126775e9.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861714; x=1776466514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dECtjt5JAv3eQt7rMJCDiLYN4rEOa0E7jrz7H8ROmoE=;
        b=YpUHZKiDkWoC44p03jzy1famNp6H7yeJzm/nOFcmpQIafshs5OHSp9F11RosE5jqOO
         KlfU08xy+32qtBNkWnCDbXMqCVfprXo9XAjgzya6ADWXKuL8t54yUitne8nATXkMdc2+
         uK9VPQPJwN6f/vWOIrPqEnY9weh1NF/jFLRC+Rs+ZtfYt6j2SuTgNIS8xmFP4+k/eSIP
         yRQd9aBcD901LdY/LKPx5nelsRpq+Usbwa8Oltsaa29dljEQtOPEFoEbbzkZvTUBciNm
         o28Mafjh9K8d//rHcfUuN4nT7pr6bieVk1bEoaoaEmLkfEZRgt7ogQIsdgxzvNZbpL1Z
         /4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861714; x=1776466514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dECtjt5JAv3eQt7rMJCDiLYN4rEOa0E7jrz7H8ROmoE=;
        b=mBfLoSKZrVYcatHOKsH/Zkncxna9eJaCGJ/FxxRYPPCzsAPY3+zsx1ZIySK3vPvWr8
         6618aYIBxE3+5t6xKl0ODUIU+aBoK5D0fSooD323m+oL4fw9RiqEZ7xiO9rtRYGfEOTO
         hONT7WQXFZP+caWBjB7TTK0bncjr/eQgmzgFB/mbk0L9y0+r7HJPaawqUEiquED44CBf
         xCFQH5WKHreoqNn47UEAXpdB/IWRZxkWzH69QMNaHv/oe6yh0A/e7W9zzG6OTaMKE1mE
         IU6fqkrt6bgaa2h1nyM06M9dskMscDhCx8T5/u51y81nACbPSaORNeYlOsyLNUaaJFa4
         sbnQ==
X-Gm-Message-State: AOJu0Ywwd/Kamy2a6S7EBS61fxCPDdLKaFz3od0r8cKtsQdlhbpYY0Ts
	HZf3phJ9l7k9pKaOJrXqbZuLsAHJKNeKtswlIvXox/K+vOWRDAz4a1A5w9qmxUK0ebc=
X-Gm-Gg: AeBDiesEkR/iEvre9cex6s0zgwHIcRJmHnp/z4nHvoaFmXwywY3N54JeXG5HgwcjtjC
	W97swxaO7zTxfte16mgYNbjJTa53dioK8iR6I4gbqqDb9wUBAjMgTSaENA4qB6niG13Z++oxC9o
	prRopJ9AXW0mH4ZekTVjnLU01zKQARVB1hoNJK/i0lARPvwOEGMZfoRWqsSs8yL9qbCZOPXyf2v
	UCsChw7tl1yQGJTTTmNjyLz8ZEmMWNdAfyRWqzHt5HsYaF2t5nZY5UmLA+AkA3v8jsmENdt+6P6
	zn1oJ589Pxg7kqPz15sHsfjw0KiC7nIwA+YJ1iOeXAjZL55tjcFEB7WKCVOsdcobdAJywyGtrp3
	XnP0jz2pJt5tnP6jYwAFhtPCmY6oMTssxue8zLiaUJ75ND3MAykHr8YxKwaKy4QxzUFzKl6fPxt
	wlKx+11KhCaxxRDrb9qZyVsOHtbI7ClcFt
X-Received: by 2002:a05:600c:8907:b0:488:c744:49b with SMTP id 5b1f17b1804b1-488d67d2cfcmr43914235e9.7.1775861713848;
        Fri, 10 Apr 2026 15:55:13 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm51555905e9.4.2026.04.10.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:55:13 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:55:11 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 2/6] repack-promisor add helper to fill promisor file
 after repack
Message-ID: <3558bb38956b522c91057598db645eb42ffb48b2.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

A ".promisor" file may contain ref names (and their associated hashes)
that were fetched at the time the corresponding packfile was downloaded.
This information is used for debugging reasons. This information is
stored as lines structured like this: "<oid> <ref>".

Create a `copy_promisor_content()` helper function that allows this
debugging info to not be lost after a `repack`, by copying it inside a
new ".promisor" file.

The function logic is the following:
 * Take all ".promisor" files contained inside the given `repo`.
 * Ignore those whose name is contained inside the given `strset
   not_repacked_names`, which basically acts as a "promisor ignorelist"
   (intended to be used for packfiles that have not been repacked).
 * Read each line of the remaining ".promisor" files, which can be:
    * "<oid> <ref>" if the ".promisor" file was never repacked. If so,
      add the time (in Unix time) at which the ".promisor" file was last
      modified <time> to the line, to obtain: "<oid> <ref> <time>".
    * "<oid> <ref> <time>" if the ".promisor" file was repacked. If so,
      don't modify it.
 * Ignore the line if its <oid> is not present inside the
   "<packtmp>-<dest_hex>.idx" file.
 * If the destination file "<packtmp>-<dest_hex>.promisor" does not
   already contain the line, append it to the file.

The function assumes that the contents of all ".promisor" files are
correctly formed.

The time of last data modification, for never-repacked ".promisor" file,
can be used when comparing the entries in it with entries in another
".promisor" file that did get repacked. With these timestamps, the
debugger will be able to tell at which time the refs at the remote
repository pointed at what object. Also, when looking at already
repacked ".promisor" files, the same ref may appear multiple times, and
having timestamps will help understanding what happened over time.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 repack-promisor.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..72677f8c9f 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -34,6 +34,122 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
+/*
+ * Go through all .promisor files contained in repo (excluding those whose name
+ * appears in not_repacked_basenames, which acts as a ignorelist), and copies
+ * their content inside the destination file "<packtmp>-<dest_hex>.promisor".
+ * Each line of a never repacked .promisor file is: "<oid> <ref>" (as described
+ * in the write_promisor_file() function).
+ * After a repack, the copied lines will be: "<oid> <ref> <time>", where <time>
+ * is the time (in Unix time) at which the .promisor file was last modified.
+ * Only the lines whose <oid> is present inside "<packtmp>-<dest_hex>.idx" will
+ * be copied.
+ * The contents of all .promisor files are assumed to be correctly formed.
+ */
+static void copy_promisor_content(struct repository *repo,
+					      const char *dest_hex,
+					      const char *packtmp,
+					      struct strset *not_repacked_basenames)
+{
+	char *dest_idx_name;
+	char *dest_promisor_name;
+	FILE *dest;
+	struct strset dest_content = STRSET_INIT;
+	struct strbuf dest_to_write = STRBUF_INIT;
+	struct strbuf source_promisor_name = STRBUF_INIT;
+	struct strbuf line = STRBUF_INIT;
+	struct object_id dest_oid;
+	struct packed_git *dest_pack, *p;
+	int err;
+
+	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
+	get_oid_hex_algop(dest_hex, &dest_oid, repo->hash_algo);
+	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);
+
+	/* Open the .promisor dest file, and fill dest_content with its content */
+	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
+	dest = xfopen(dest_promisor_name, "r+");
+	while (strbuf_getline(&line, dest) != EOF)
+		strset_add(&dest_content, line.buf);
+
+	repo_for_each_pack(repo, p) {
+		FILE *source;
+		struct stat source_stat;
+
+		if (!p->pack_promisor)
+			continue;
+
+		if (not_repacked_basenames &&
+			strset_contains(not_repacked_basenames, pack_basename(p)))
+			continue;
+
+		strbuf_reset(&source_promisor_name);
+		strbuf_addstr(&source_promisor_name, p->pack_name);
+		strbuf_strip_suffix(&source_promisor_name, ".pack");
+		strbuf_addstr(&source_promisor_name, ".promisor");
+
+		if (stat(source_promisor_name.buf, &source_stat))
+			die(_("File not found: %s"), source_promisor_name.buf);
+
+		source = xfopen(source_promisor_name.buf, "r");
+
+		while (strbuf_getline(&line, source) != EOF) {
+			struct string_list line_sections = STRING_LIST_INIT_DUP;
+			struct object_id oid;
+
+			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
+			string_list_split(&line_sections, line.buf, " ", 3);
+
+			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
+			get_oid_hex_algop(line_sections.items[0].string, &oid, repo->hash_algo);
+			if (!find_pack_entry_one(&oid, dest_pack)) {
+				string_list_clear(&line_sections, 0);
+				continue;
+			}
+
+			/* If <time> doesn't exist, retrieve it and add it to line */
+			if (line_sections.nr < 3)
+				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);
+
+			/*
+			 * Add the finalized line to dest_to_write and dest_content if it
+			 * wasn't already present inside dest_content
+			 */
+			if (strset_add(&dest_content, line.buf)) {
+				strbuf_addbuf(&dest_to_write, &line);
+				strbuf_addch(&dest_to_write, '\n');
+			}
+
+			string_list_clear(&line_sections, 0);
+		}
+
+		err = ferror(source);
+		err |= fclose(source);
+		if (err)
+			die(_("Could not read '%s' promisor file"), source_promisor_name.buf);
+	}
+
+	/* If dest_to_write is not empty, then there are new lines to append */
+	if (dest_to_write.len) {
+		if (fseek(dest, 0L, SEEK_END))
+			die_errno(_("fseek failed"));
+		fprintf(dest, "%s", dest_to_write.buf);
+	}
+
+	err = ferror(dest);
+	err |= fclose(dest);
+	if (err)
+		die(_("Could not write '%s' promisor file"), dest_promisor_name);
+
+	close_pack_index(dest_pack);
+	free(dest_idx_name);
+	free(dest_promisor_name);
+	strset_clear(&dest_content);
+	strbuf_release(&dest_to_write);
+	strbuf_release(&source_promisor_name);
+	strbuf_release(&line);
+}
+
 static void finish_repacking_promisor_objects(struct repository *repo,
 					      struct child_process *cmd,
 					      struct string_list *names,
-- 
2.53.0.584.ge8720aaf12

