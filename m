Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A3823DD
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775435099; cv=none; b=WwY85hCCbj2lAMu62eBy5NYEvYLCfuO58xNhvzySz7hrtL6qH5JzPbJGlx1gjTwIJEFu+H3HTItX3X6SWrIXH7lMSP/5IfVolpwZEf8bUu3nU0ia5I7aDafExvF5LVTkhX0dajsrekI8R63TJ2GlIrgSNBWSxBtvpTCsqwaPiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775435099; c=relaxed/simple;
	bh=TAZgIqf6AqfaR+2AluWblU5Q64unHwFKWEQ6gOrb7dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsk7I4fHBJTj/qObqzuy4CzvMrJddtuIAvmfQ1ouW1L5YWkHTvQ1SElDdtUJbIib7SzooWw7s7kIMpx3sZ4hUZUdQ6JnbVwN5PDHPdzmLDSwBxgVkKit7PW5o8e056NQIvJBwzWPAAYqBrbV9Nv23hdZuCJyXezH5b99HAr0dgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltk1D9oR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltk1D9oR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so31809625e9.0
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775435096; x=1776039896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llFbqDcJt2TvDdhYp/2C9VOuFcxJwFat+35ggy3QuhU=;
        b=Ltk1D9oROPl3XWyg2Gri94ZnWkVxd9nssIxOkhlSJZKgj/cOw4K8RJVFsVLHgawUfx
         ICM85C0J3ijNXnjIRt9l1P1+m8ibzoy9L5LzPnTaq+aZza37le1k0MsS944o9eMJZI0w
         77z3A59PphTqAdgZ7g5ji8JQXNUMn76oTbcA98Nb7Bqg/4n2F/Ezo48O94yfDk79uC/z
         RJcMoGQ3z3FbXH58wKRO5vOTT1U4cgrVJvtK0ou6DI+qVuKeUEmbucj9x0/Jw5z0fwq8
         muX9/ysI6SI2hNH6p+8GChTRxS0dUwAqKY7pEo8/O3iasSLlvAfujrzlpUB8ssLW5zAI
         xnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775435096; x=1776039896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llFbqDcJt2TvDdhYp/2C9VOuFcxJwFat+35ggy3QuhU=;
        b=VIvfXOV8dq0BAQJZrNxI8zzTjZCyCrnaa5adkwPr76SJwxCffCLoKR6M40yFXZsH9u
         Ahpt5xkz6OEfHTg3EE1cn9wQuSaLkiIuYhPVt+MvEk+DAJLosxv1CLbHdjbPSkwf6oJJ
         VKymZMjvcOxPYOJj+GjmSjYl0YqsmJVzdlGUA/N9qR4FgNLakERPXKnqGo1kP0WFMIJy
         eWufKfW7n8JRk7qASbGLoFjAfdhyEDlzPw5uIRayBUa7dITZX10n0IXJ6LsUJnfkDM7t
         ZvCqt7qjoPAmd8EoH725E2BqWeqosIrDIEpVek3N70Vorp32jzNes3gBIh80L/loSW9P
         h/Mg==
X-Gm-Message-State: AOJu0YwJ3MrQKSitxbkaaKoShZhm7539H5GTb+XSUo+4ZqdnMCBOStZH
	r+1p/354nXpucFf3NcJO3WDCs2+S6lq4PgCb3/FhCIvw2NWVmnD5fKWy61X0hnSRHN8=
X-Gm-Gg: AeBDieusV70Nip5sTmvhLgmICDl8kV7snPsMBXyM0pNJ1llUAv6qTx63dpbvRx7KIuE
	xrZlx3RuoEmlXL499aFmBfnF42+YlKHqy405VrkWJJAkfEM5Fjet0WwrBSJBUebPnVuLqFQ7R9W
	pLUjkB5S9c8tp7MQ1z3eIpg2wBQYQLZDWl04UxYCiEyQnmy0r/Ih1D8b8ws+T3x8LVq/MpzhC+E
	Hbg0deneyiJzqshgL/6Do8/0mkoZHCgPqdoXTOHotlXl0hL42VJQi5KPecrmJu86+4HZJhYJBSn
	93btlFVKbcaEFoB8tJYCbmYn75dZMbBO8Tz0y68vJhkZeX92a2taAuLm+vvB/zXivW2c8IZvm8Z
	N2WN0lVmnMh92WErPHx430kQGuutTtwXkqH08i9L+FWWtIfhlti8nmtc+4+1wuDjedO8GKN8KeH
	lGmt1q9OHfIHOwi6CyRofwHikXMLteNaP4MRHp0epir90=
X-Received: by 2002:a05:600c:6cf:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-488a825014fmr41159275e9.26.1775435095925;
        Sun, 05 Apr 2026 17:24:55 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83e906sm500849245e9.8.2026.04.05.17.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:24:55 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:24:53 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>

A ".promisor" file may contain ref names (and their associated hashes)
that were fetched at the time the corresponding packfile was downloaded.
This information is used for debugging reasons. This information is
stored as lines structured like this: "<oid> <ref>".

Create a `copy_promisor_content()` helper function that allows this
debugging info to not be lost after a `repack`, by coping it inside a new
".promisor" file.

The function logic is the following:
 * Take all ".promisor" files contained inside the given `repo`.
 * Ignore those whose name is contained inside the given `strset
   not_repacked_names`, which basically acts as a "promisor ignorelist"
   (intended to be used for packfiles that have not been repacked).
 * Read each line of the remaining ".promisor" files, which can be:
    * "<oid> <ref>" if the ".promisor" file was never repacked. If so,
      add the time at which the ".promisor" file was last modified <time>
      to the line to create the string: "<oid> <ref> <time>".
    * "<oid> <ref> <time>" if the ".promisor" file was repacked. If so,
      don't modify it.
 * Ignore the line if its <oid> is not present inside the
   "<packtmp>-<dest_hex>.idx" file.
 * If the destination file "<packtmp>-<dest_hex>.promisor" does not
   already contain the line, append it to the file.

The function assumes that the contents of all ".promisor" files are
correctly formed.

The time of last data modification is used in place of the time of file
creation, because the former is much easier to obtain than the latter
one.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 repack-promisor.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..6da452e8ff 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -34,6 +34,125 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
+/*
+ * Go through all .promisor files contained in repo (excluding those whose name
+ * appears in not_repacked_basenames, which acts as a ignorelist), and copies
+ * their content inside the destination file "<packtmp>-<dest_hex>.promisor".
+ * Each line of a never repacked .promisor file is: "<oid> <ref>" (as described
+ * in the write_promisor_file() function).
+ * After a repack, the copied lines will be: "<oid> <ref> <time>", where <time>
+ * is the time at which the .promisor file was last modified.
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
+			struct strbuf **parts;
+			struct object_id oid;
+
+			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
+			parts = strbuf_split_max(&line, ' ', 3);
+
+			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
+			strbuf_rtrim(parts[0]);
+			get_oid_hex_algop(parts[0]->buf, &oid, repo->hash_algo);
+			if (!find_pack_entry_one(&oid, dest_pack))
+				continue;
+
+			/* If <time> doesn't exist, retrieve it and add it to line */
+			if (!parts[2]) {
+				struct tm tm;
+				localtime_r(&source_stat.st_mtim.tv_sec, &tm),
+				strbuf_addch(&line, ' ');
+				strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);
+			}
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
+			strbuf_list_free(parts);
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
2.53.0.585.g1533fa96a8

