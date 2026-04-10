Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692563D9036
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833380; cv=none; b=p8c2A0nbrvellPK+D2Iz2j1+hUSrfsvoCEt6uwOell4KMBLg1yOMfmD8IKbXBKAyGXtn8sGc6z4qznlTqTSD3z6N41WDAchILVA/kjNlvEEIzx9BqpaVXk0OsEW9nLthTP3kWH4aYL8gtbhAGnhqJXXgssbl6eYkRDtsbO8S68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833380; c=relaxed/simple;
	bh=QAOx5COX2coQmVtWCLJ9gHN6DaW9OpaHeALEODaugx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSPyJdmkxoNZqwIU27RYsI2tSfPKjFhKByAsSlmtckkoompJm3waqfnMZLk+lIdZdAJJg2ht7FG0fxdEwE5HSMZx5LEWkXcmdQAn63PiwPDsPYs0Az9o/z6EIxdyPCg5wqT6RH1h+jDzQsVeuskbCQtvekp9CFRcM4v9PSAAJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr9dDVKK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr9dDVKK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4888375f735so21168125e9.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833375; x=1776438175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AW4Sf7Q72XcfWHzLIgSuLUaEXdV7icRN74StEjFd7Vo=;
        b=Sr9dDVKKzYiaIKJQWF8Zf3yMtP5s1vLN1QdmzbOa+5rcQ5DuU7+ItnJsLLBtom2IHA
         /fQUv5Fq0rxMyY3D3EhH4UGUAxN5VPXrq9JmH5hQu4TkbT7M90OLPBk/IX7trytUGvsl
         4mo64UTcnf/0KtFM0YsjRha5GJFVKIL3KrbqRn3vMCQMYuAjGqSsMqNvx0e4uMigkVOZ
         ACh9S4KlBUqFNTUN9KB8NnK9aWym/k6DLXDWzUXPvnIYsjha874JEi2trkcNLAC5MEyp
         TzXKeXP0ja7Z71gGHOpVoZo6uXxAVt4f+4GJaveEJpMNIOKiBF8UmQ8WS8cXW1ClJtVZ
         0WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833375; x=1776438175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW4Sf7Q72XcfWHzLIgSuLUaEXdV7icRN74StEjFd7Vo=;
        b=jWOKU2J8y5BQbZqyFqPeYFysmJrVOwyBzJDw+To1kA8IUHlwqtKBwqZHUk3RZ2z5MO
         7dtsMiEwShIfdoxcQt2p4EuxTw3LP1KTWkG4hKM7/D4kDc63BNqwBxN89kMz0vdSYoZA
         vBUZwTojOpX3IgsCjmZuwIaMwA2rrMLNLTQbyrYVu/QB2rRaax8hIaS+jHnbEo6NfuBP
         5u1UKPDKpbNNJL4RP4MvwMHL40aYSMPaFR5IIymfD0Bp/m6QnZ11Vazd5ibTX/2pI/Kp
         O9/UF39LR7Mj0jneluGDX9KF5Ecge7C2XYrWgLN+vn1j5yuWwtSpZeQGqYT7cEZFdKBH
         4IEA==
X-Gm-Message-State: AOJu0YwE316ZVxHP24BE6zWEwF7R/ha4cwnAzlKAGBH8bV+GAUmja9lW
	ANmlybGm5I7ISzlirx3pWFAISDJ43bQk0b40cQvc/3IvXSdTUMFAwRmw6u9IYTOuW14=
X-Gm-Gg: AeBDieuypqxIdU0sjtfOFJ71+AZPbeTle3m4DOF9Yt023qudyr1T0FmUIixgp3eDQEV
	neS+jojyTJeVISEMzrBtnlNRELIMuR92/JK24IUgQ2XfPgBjuDb1epVv83aOLcWqsSr/pkE/4N2
	W13R5kqnLZRZwdEiPYBLEW2R7ZSew7PCTRHQVMxWYD1LCwpsSzvMfXEU/SPx5kGvDv9arbKYYeO
	Nq6U7vTciCAHXieUilJ8qjTXVQ9xifPxATz8H4C4Cb7rDxncUOjfmWOd7XwU/qa/i+ZjYjSqL6j
	aTTLUhxte251SYIenXLjGp3gyTvA3Sxvl1yJkrq87hdCmFxNJkCQ8nirKe8MUO1KMrkFR44C1qR
	2s6+3+/9SJjXXYl64iDRVQ7xjBnnbg0FzuKyECv5xGB/oSLN+VMDRHAdFkbNG/V7KATr5802Ih7
	833sfwutgzAqsMUbgd4qvwZMFpHEDhnRmlyotvSbB4vohrIIvRvvHLyrg92W+tGyIGGHNrWeNxp
	Dvb+Xjn
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488d67ce664mr43157055e9.7.1775833374744;
        Fri, 10 Apr 2026 08:02:54 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm75065145e9.4.2026.04.10.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:02:53 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:02:51 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [GSoC PATCH v4 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>

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
index 90318ce150..797314d7b9 100644
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
+				strbuf_addf(&line, " %lld", (long long int)source_stat.st_mtim.tv_sec);
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
2.53.0.585.ge25071d955

