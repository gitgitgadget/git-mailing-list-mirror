Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33760389105
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521827; cv=none; b=dIXxqSzUEedZA9HeTgcNWgz+v03R4vp/eo+cESyzKgol4q9qmAZAnlfKe8Pd7RZgGdcKM95ROs2n3+w8RaR9/JaG5cvfjIbIra4t0KI26rHkYNep5AGbEumNeKGcoRBLU3FAQvtSnIjbP5fQueKUkVatU6jT8COGYM99Qu1mKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521827; c=relaxed/simple;
	bh=AtfN/yQsIZcUpS9mgE7x5feJWOu0FcbXtqrMdW4/7sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD9ax+4FRk0Wn3kgH5QCEqd/fgVcAAfFdJ1wIvHVJi+/8O2sYNA5Dv372XZdT51uLaXiOQ22ISz9xshxXFvxBaMW36lq2w61/9ZsGSGmtnY606oQ0irSel8mPxVkSLYDHsGCzj9KsgiI+zjpZStVD/X2rwzdNlWZdrryZ+8VrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHq65+ow; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHq65+ow"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so19509455e9.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521824; x=1777126624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJAjXcNtKdKtYxsy7A24KjWPQmZXRNijVMpbtV6d6uo=;
        b=JHq65+owbNtulsrp9MeeTuKXlm6hu9wqpJ2ygkA5Qs4SGW0UYQDqYOblZfgOQfH7Cw
         JVUObpiQBPF9Thg4zOAvrMEXFVmisUKObPguZQ5vhr7K8o3OU67c0ZtesIxXkSp2fFvk
         2gRxzcHi3kIuWP+kGc0iLru5IzRz++0uDccSjOp/wgSfWgZL+MuCNN8T2QQhJgf5RXfs
         S8UOj0zpwAdmGFrMO+NhUwwreGTBNH+7uM87FSO16TxWBsSR+uhm7FC/RUthFkKP2ZZL
         XvLmx5F0w1W+k6oMvNh0VEHm/lA+0VCZVvEyJoIot66Oz0EAwbE/RYN724BoXHu/5L0/
         TIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521824; x=1777126624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJAjXcNtKdKtYxsy7A24KjWPQmZXRNijVMpbtV6d6uo=;
        b=rBXVg8b4wfxEjHNB5S5M5utBRddcx+4PwaoJG4rh1XBNSvYLWvmF/7UDFZjyRjMfRs
         WEhQaUkUhtlr5IElpLytkjmkhjgVixPl8PEv5tQw+njRWgxoBnlj82YQQ+DVYR6gVRL4
         Z8ZjJ7hGUl8rRQ8sHQW1Yp6fD5iOc8MneHWbo7y0aJIvnzye6sYO1UbantXfWWHW3lDk
         VtWw+2v2AlPWHlZrd+IguQKmrRFtxh5V5Wh3AX9QDJIw4NGRk62yZYFqR0PfVqXsa70C
         VZL71g+J08ki60ssj9/7Si4cLbTK9B3GQ0YJi53W9UyOsISjXPPhgQ0DDKWw8bcYNhKj
         fUrw==
X-Gm-Message-State: AOJu0YyGSqVq/OxvSgiVcrS36ajx3pRJb65LpLCH6AFsrVXeA5SBxRhA
	HZDlEWolrwH2eInwX8C+V/baMobr7vIVPb95WTLKpZsPrEH7g+HC3IJG/2ebCw==
X-Gm-Gg: AeBDies90GLoLazY4UuR4YQRuXgcua45gYxbsXlbs2kmCQ4nKQTboJLS+TbQP8CgbZF
	A/EQdn9Rat0ARbJAuda+nLKeV5yWOe7WQZXVCxzD5KoylvMdB9JEBXloeQJ9jRkapKSCft+iA1T
	gynfHQPs/eqlNyrVGBBmguuzpoBQjZCm+PTi0XxHGeGPylq5D1D8dquHQdQOMcLLpPxOL6yiymV
	jyli/9HlQprnF1kFUcOUDP0e8L/vyu3Ev1tawmf9GCI2uGU4Cnclp9j49C5iOBk8PZzGFQcZsdx
	rJrpyJQQfAE77+5H6Tq1g/dUeSjAtU5qzkBrNOuqTfRl8wsijk+JNIcwjeZGt3q/lASwBVBXoLJ
	FJF/ywbQ2Kc6ItYV9vf8463Sh/99lGaglef58mmTc74G7QJ9zg3FNUVGKEPpeZBDulUykL5jj1Q
	vgls+DfioHFnhBmVYyN+e9TTae1WfjxYawoUkG3EHUE5GQklEFuk2g6Aed1LEVu1+gJcj/Gdwsh
	Mx6CIXxpo7lzPWGOXg=
X-Received: by 2002:a05:600c:4687:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-488fb73d7e9mr104002315e9.3.1776521824179;
        Sat, 18 Apr 2026 07:17:04 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc13938fsm193627035e9.10.2026.04.18.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:17:03 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:17:01 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 2/6] repack-promisor add helper to fill promisor file
 after repack
Message-ID: <de28baad3839f5c6e74352eae4de7763124e7fb8.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>

A ".promisor" file may contain ref names (and their associated hashes)
that were fetched at the time the corresponding packfile was downloaded.
This information is used for debugging reasons. This information is
stored as lines structured like this: "<oid> <ref>".

Create a `write_promisor_file_after_repack()` helper function that allows
this debugging info to not be lost after a `repack`, by copying it inside
a new ".promisor" file.

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

The time of last data modification, for never-repacked ".promisor" file,
can be used when comparing the entries in it with entries in another
".promisor" file that did get repacked. With these timestamps, the
debugger will be able to tell at which time the refs at the remote
repository pointed at what object. Also, when looking at already
repacked ".promisor" files, the same ref may appear multiple times, and
having timestamps will help understanding what happened over time.

The function tries its best to deal with malformed ".promisor" files,
ignoring those lines:
 * That cannot be split into "<oid> <ref>" or "<oid> <ref> <time>".
 * Whose <oid> is not a sane hexadecimal string.
 * Whose <ref> does not have the correct format for a refname.

The function `parse_pack_index()`, which is loose in validation, can be
safely used to obtain the `packed_git` of the packs created during the
`repack` because, when `write_promisor_file_after_repack()` is called by
`finish_repacking_promisor_objects()`, we know for a fact that they were
just successfully created by `pack-objects` (also, these packs have not
yet been finalized, and so they are not part of the repository). Anyway,
if an error happens while trying to obtain the `packed_git`, the
".promisor" file will be created empty.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Tian Yuchen <cat@malon.dev>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 repack-promisor.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..8fc541d2cf 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -4,6 +4,7 @@
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
+#include "refs.h"
 #include "repository.h"
 #include "run-command.h"
 
@@ -34,6 +35,154 @@ static int write_oid(const struct object_id *oid,
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
+static void write_promisor_file_after_repack(struct repository *repo,
+								const char *dest_hex,
+								const char *packtmp,
+								struct strset *not_repacked_basenames)
+{
+	char *dest_promisor_name;
+	char *dest_idx_name;
+	FILE *dest;
+	struct object_id dest_oid;
+	struct packed_git *dest_pack, *p;
+	struct strbuf source_promisor_name = STRBUF_INIT;
+	struct strset seen_lines = STRSET_INIT;
+	struct strbuf line = STRBUF_INIT;
+	int err;
+
+	/* First of all, let's create and open the .promisor dest file */
+	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
+	dest = xfopen(dest_promisor_name, "w");
+
+	/*
+	 * Now let's retrieve the destination pack.
+	 * We use parse_pack_index() because dest_hex/packtmp point to the packfile
+	 * that "pack-objects" just created, which is about to become part of this
+	 * repository, but has not yet been finalized.
+	 * If we are here, we know that "pack-objects" did not fail, so
+	 * parse_pack_index() being loose in validation does not pose a problem.
+	 * If an error happens, we simply leave the ".promisor" file empty.
+	 */
+	if (get_oid_hex_algop(dest_hex, &dest_oid, repo->hash_algo)) {
+		warning(_("Promisor file left empty: '%s' not a hash"), dest_hex);
+		if (fclose(dest))
+			die(_("Could not close '%s' promisor file"), dest_promisor_name);
+		free(dest_promisor_name);
+		return;
+	}
+	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
+	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);
+	if (!dest_pack) {
+		warning(_("Promisor file left empty: couldn't open packfile '%s'"), dest_idx_name);
+		if (fclose(dest))
+			die(_("Could not close '%s' promisor file"), dest_promisor_name);
+		free(dest_promisor_name);
+		free(dest_idx_name);
+		return;
+	}
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
+			/* Split line into <oid>, <ref> and <time> (if <time> exists).
+			 * Check that it was actually split into 2 or 3 parts. If it was
+			 *  not, then it is malformed, so skip it.
+			 */
+			string_list_split(&line_sections, line.buf, " ", 3);
+			if (line_sections.nr != 2 && line_sections.nr != 3) {
+				string_list_clear(&line_sections, 0);
+				continue;
+			}
+
+			/* Skip the lines where <oid> is not a sane hexadecimal string */
+			if (get_oid_hex_algop(line_sections.items[0].string,
+						&oid, repo->hash_algo)) {
+				string_list_clear(&line_sections, 0);
+				continue;
+			}
+			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
+			if (!find_pack_entry_one(&oid, dest_pack)) {
+				string_list_clear(&line_sections, 0);
+				continue;
+			}
+
+			/*
+			 * Skip the lines where <ref> does not have the
+			 * correct format for a refname.
+			 */
+			printf("%s\n", line_sections.items[1].string);
+			if (check_refname_format(line_sections.items[1].string,
+							REFNAME_ALLOW_ONELEVEL)) {
+				string_list_clear(&line_sections, 0);
+				continue;
+			}
+
+			/* If <time> doesn't exist, retrieve it and add it to line */
+			if (line_sections.nr != 3)
+				strbuf_addf(&line, " %" PRItime,
+							(timestamp_t)source_stat.st_mtime);
+
+			/* If the finalized line is new, append it to dest */
+			if (strset_add(&seen_lines, line.buf))
+				fprintf(dest, "%s\n", line.buf);
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
+	err = ferror(dest);
+	err |= fclose(dest);
+	if (err)
+		die(_("Could not write '%s' promisor file"), dest_promisor_name);
+
+	close_pack_index(dest_pack);
+	free(dest_pack);
+	free(dest_promisor_name);
+	free(dest_idx_name);
+	strbuf_release(&source_promisor_name);
+	strbuf_release(&line);
+	strset_clear(&seen_lines);
+}
+
 static void finish_repacking_promisor_objects(struct repository *repo,
 					      struct child_process *cmd,
 					      struct string_list *names,
-- 
2.53.0.584.g6b87e8e9dd

