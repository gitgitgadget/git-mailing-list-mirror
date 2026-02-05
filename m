Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B713B293
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261900; cv=none; b=U1CuUF2fw0hghOuu7U5M4WP32SQ80UKwVOTQxzQDTa65fDnUKXGvGH6zd0Py+Tlbl0SQZiZkz4yMqoCH8Sr+HiaZvBxcJU8tvdl7b/wB8kUi0q7Y2nvse3OyJSWXspB5+zXLh4Uu8GO9NyZEtf2xu3MejyjyL+DicPgadAg8QBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261900; c=relaxed/simple;
	bh=V4HBydHukV2Gpd43faVnWlA60SSLellwFzzMA9JZ4F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SyssEFM+/h+TMw3BtURJMXrucZx0OlgvK9dbTsPuhXgGYrIJnetB5FBOA78l/zf7h5AVz/7PhvdQy9GTC4saUQRZL2ZR8nSZll5ALllw8Hd5xUI4qvFQ5sfa9lpLfif+jDr4WufNrBYC31eYK2Kd9j/T6ly3Wf9JZzJWvUcfVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hyla6ts2; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyla6ts2"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso540794c88.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 19:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770261899; x=1770866699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86V2O6yKxv3vZ+TzWTAMy++eeUx5mNOrue3yNzQa/SM=;
        b=Hyla6ts2HlbMt4b2ntuDuQlw38yda402ph4njTHPhLz4l6luXUwq3wyVkl6uIk1dlD
         251HqUsg/01JjeCvJsJTMvi4N7TJ6RdkuXzBzz+LoPA2tFT9QTDDRPr+Rw7cgxD/ypzR
         vhSI8TXGqHPQjQP8/c0ojUmS8r0ro8VocfDhw2K4oGvJ1N53d7bOwja22fBlUCHsiuZD
         mDaVkbQfL48aEngvTKsEo3k1ffJkx3NF+EtxrBMUBypjizXmMcAbOVuk1d497XR560ev
         n8alaJWTQRzKxZocp5Lk6zv9LmjqvInzYE8veGV+Pri07Ib+vJD9bHS9FEi1VfqSEVcQ
         Kaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770261899; x=1770866699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86V2O6yKxv3vZ+TzWTAMy++eeUx5mNOrue3yNzQa/SM=;
        b=fnGalKev9frwupH+tCyC7HLgBINJyWBgcxN0kQcXzRkvE3DKDp7NLb1h7+nLCju3ut
         D2aKzfee0htK4jMJf+/Oh4smXWBT9+sGI5ddAKrB0Pf7TLRyCtwNf4pR+IiLWhyAuwHK
         FKX5Cs3eTs4FBDE/hk9VqMolaQ3iEqiIiuN+MxWVqQhEs4BcsFCVMPekWufvWRDomyQY
         f0mA5SuAeaR4hmkdnjClPRPnfWtZBKsI9pWPbg7EFstjYYkYyhkBANgzNK7JgECdpKuA
         c5E2+EHCdNLHRnlQD/3wOJXP1NAqKwl4OMJzFziGW+XTO9b1uV2N+4H1vLZWfvcSI5gL
         bS+g==
X-Gm-Message-State: AOJu0YzIr9Sz5PHaZaHucnstcWLLFiRixqxt75ULpfzdZ8ylfjk55/HK
	0M3kI02INC/wEIGb/us8nAgPDL2SGnFdNXX7baPe5HkT1TDZ8rQoYSYWDyPG5Q==
X-Gm-Gg: AZuq6aIsldT+WHSH77o/D4FJ1VFUgLjnt+i36P6tRswf2QvN9Q0E7plnwO2vyuiPfMP
	hcABoOQq9JEXNljTCMaQt2+T+ZQew+GC0AmP6xiCo/7B9JDEKQmY3OaQYDKEAtGGXjf5AiQGzJF
	1jaoZkdTV3QvRU5IY+k80qZSVfRrxLFSj+381wJzDyk342MlkmuWvR3YOnkI4GpTilHczuJk3oN
	yu7n1HMa8LTkuNsrCkp2TLPPSZDoDr+xg63prXfmj/v6H6vUmKZs3fhC/Okn1aNRPwe5CSFhI9m
	DezBBAmtXw3hbjkuAtUeEC/ePr7I2yWHEbtGehvz1UQylE47BV1j0ioHzcUao5R4F/X8L9Wd1tB
	PYugwdAs1dY/xmP3R5xwLRJIkFtP9AL5eyVD9ngw8tjBEPgqRW3ytLDTC3veP2W60/jNl6OZr1R
	9qSo3j5oNtMEJE
X-Received: by 2002:a05:7022:606:b0:122:8d:3680 with SMTP id a92af1059eb24-126f47d9c22mr2273388c88.40.1770261898561;
        Wed, 04 Feb 2026 19:24:58 -0800 (PST)
Received: from localhost.localdomain ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832f8e987sm2489856eec.18.2026.02.04.19.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 19:24:58 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH] global: constify some pointers that are not written to
Date: Wed,  4 Feb 2026 19:24:19 -0800
Message-ID: <342b01acd42f1fcaa3abefa38dc589e12ccb1134.1770261829.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent glibc 2.43 release had the following change listed in its
NEWS file:

    For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
    strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return
    pointers into their input arrays now have definitions as macros that
    return a pointer to a const-qualified type when the input argument is
    a pointer to a const-qualified type.

When compiling with GCC 15, which defaults to -std=gnu23, this causes
many warnings like this:

    merge-ort.c: In function ‘apply_directory_rename_modifications’:
    merge-ort.c:2734:36: warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
     2734 |                 char *last_slash = strrchr(cur_path, '/');
          |                                    ^~~~~~~

This patch fixes the more obvious ones by making them const when we do
not write to the returned pointer.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 add-patch.c                    | 2 +-
 apply.c                        | 2 +-
 builtin/commit.c               | 2 +-
 builtin/receive-pack.c         | 2 +-
 builtin/remote.c               | 2 +-
 builtin/shortlog.c             | 2 +-
 config.c                       | 2 +-
 convert.c                      | 3 ++-
 diff.c                         | 4 ++--
 diffcore-rename.c              | 2 +-
 fmt-merge-msg.c                | 3 ++-
 fsck.c                         | 2 +-
 gpg-interface.c                | 2 +-
 help.c                         | 2 +-
 http-push.c                    | 2 +-
 mailinfo.c                     | 2 +-
 mem-pool.c                     | 2 +-
 merge-ort.c                    | 2 +-
 object-name.c                  | 2 +-
 pack-revindex.c                | 2 +-
 pkt-line.c                     | 6 +++---
 reflog-walk.c                  | 3 ++-
 scalar.c                       | 2 +-
 strbuf.c                       | 2 +-
 string-list.c                  | 2 +-
 t/unit-tests/clar/clar/print.h | 2 +-
 transport.c                    | 2 +-
 wrapper.c                      | 2 +-
 28 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..70242617ef 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -342,7 +342,7 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 {
 	struct hunk_header *header = &hunk->header;
 	const char *line = s->plain.buf + hunk->start, *p = line;
-	char *eol = memchr(p, '\n', s->plain.len - hunk->start);
+	const char *eol = memchr(p, '\n', s->plain.len - hunk->start);
 
 	if (!eol)
 		eol = s->plain.buf + s->plain.len;
diff --git a/apply.c b/apply.c
index 3de4aa4d2e..9de2eb953e 100644
--- a/apply.c
+++ b/apply.c
@@ -4144,7 +4144,7 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 	 */
 	struct fragment *hunk = p->fragments;
 	static const char heading[] = "-Subproject commit ";
-	char *preimage;
+	const char *preimage;
 
 	if (/* does the patch have only one hunk? */
 	    hunk && !hunk->next &&
diff --git a/builtin/commit.c b/builtin/commit.c
index 8e901fe8db..0326546548 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -816,7 +816,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				  logfile);
 		hook_arg1 = "message";
 	} else if (use_message) {
-		char *buffer;
+		const char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (buffer)
 			strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9c49174616..e8b6f960fa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -393,7 +393,7 @@ struct command {
 static void proc_receive_ref_append(const char *prefix)
 {
 	struct proc_receive_ref *ref_pattern;
-	char *p;
+	const char *p;
 	int len;
 
 	CALLOC_ARRAY(ref_pattern, 1);
diff --git a/builtin/remote.c b/builtin/remote.c
index 7ffc14ba15..ace390c671 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -332,7 +332,7 @@ static int config_read_branches(const char *key, const char *value,
 		info->remote_name = xstrdup(value);
 		break;
 	case MERGE: {
-		char *space = strchr(value, ' ');
+		const char *space = strchr(value, ' ');
 		value = abbrev_branch(value);
 		while (space) {
 			char *merge;
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index b91acf45c8..d80bf1a7d0 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -76,7 +76,7 @@ static void insert_one_record(struct shortlog *log,
 		if (!eol)
 			eol = oneline + strlen(oneline);
 		if (starts_with(oneline, "[PATCH")) {
-			char *eob = strchr(oneline, ']');
+			const char *eob = strchr(oneline, ']');
 			if (eob && (!eol || eob < eol))
 				oneline = eob + 1;
 		}
diff --git a/config.c b/config.c
index 7f6d53b473..156f2a24fa 100644
--- a/config.c
+++ b/config.c
@@ -160,7 +160,7 @@ static int handle_path_include(const struct key_value_info *kvi,
 	 * based on the including config file.
 	 */
 	if (!is_absolute_path(path)) {
-		char *slash;
+		const char *slash;
 
 		if (!kvi || kvi->origin_type != CONFIG_ORIGIN_FILE) {
 			ret = error(_("relative config includes must come from files"));
diff --git a/convert.c b/convert.c
index c7d6a85c22..a34ec6ecdc 100644
--- a/convert.c
+++ b/convert.c
@@ -1122,7 +1122,8 @@ static int count_ident(const char *cp, unsigned long size)
 static int ident_to_git(const char *src, size_t len,
 			struct strbuf *buf, int ident)
 {
-	char *dst, *dollar;
+	char *dst;
+	const char *dollar;
 
 	if (!ident || (src && !count_ident(src, len)))
 		return 0;
diff --git a/diff.c b/diff.c
index a68ddd2168..2d92665159 100644
--- a/diff.c
+++ b/diff.c
@@ -1961,7 +1961,7 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
 	struct strbuf sb = STRBUF_INIT;
 
 	while (count) {
-		char *p = memchr(buf, '\n', count);
+		const char *p = memchr(buf, '\n', count);
 		if (print)
 			strbuf_addstr(&sb, diff_line_prefix(o));
 
@@ -3049,7 +3049,7 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 		struct dirstat_file *f = dir->files;
 		int namelen = strlen(f->name);
 		unsigned long changes;
-		char *slash;
+		const char *slash;
 
 		if (namelen < baselen)
 			break;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7723bc3334..d9476db35a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -379,7 +379,7 @@ struct dir_rename_info {
 
 static char *get_dirname(const char *filename)
 {
-	char *slash = strrchr(filename, '/');
+	const char *slash = strrchr(filename, '/');
 	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
 }
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index c9085edc40..1626667c0d 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -246,7 +246,8 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 static void record_person_from_buf(int which, struct string_list *people,
 				   const char *buffer)
 {
-	char *name_buf, *name, *name_end;
+	char *name_buf;
+	const char *name, *name_end;
 	struct string_list_item *elem;
 	const char *field;
 
diff --git a/fsck.c b/fsck.c
index 3afec0d0d3..0f02cf8f77 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1026,7 +1026,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 			int *tagged_type)
 {
 	int ret = 0;
-	char *eol;
+	const char *eol;
 	struct strbuf sb = STRBUF_INIT;
 	const char *buffer_end = buffer + size;
 	const char *p;
diff --git a/gpg-interface.c b/gpg-interface.c
index 47222bf31b..87fb6605fb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -398,7 +398,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 {
 	const char *line, *principal, *search;
 	char *to_free;
-	char *key = NULL;
+	const char *key;
 
 	/*
 	 * ssh-keygen output should be:
diff --git a/help.c b/help.c
index 3c36d9c218..be334d7642 100644
--- a/help.c
+++ b/help.c
@@ -857,7 +857,7 @@ struct similar_ref_cb {
 static int append_similar_ref(const struct reference *ref, void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
-	char *branch = strrchr(ref->name, '/') + 1;
+	const char *branch = strrchr(ref->name, '/') + 1;
 
 	/* A remote branch of the same name is deemed similar */
 	if (starts_with(ref->name, "refs/remotes/") &&
diff --git a/http-push.c b/http-push.c
index cc0f809346..9ae6062198 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1768,7 +1768,7 @@ int cmd_main(int argc, const char **argv)
 				usage(http_push_usage);
 		}
 		if (!repo->url) {
-			char *path = strstr(arg, "//");
+			const char *path = strstr(arg, "//");
 			str_end_url_with_slash(arg, &repo->url);
 			repo->path_len = strlen(repo->url);
 			if (path) {
diff --git a/mailinfo.c b/mailinfo.c
index 99ac596e09..a2f06dbd96 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1141,7 +1141,7 @@ static void output_header_lines(FILE *fout, const char *hdr, const struct strbuf
 {
 	const char *sp = data->buf;
 	while (1) {
-		char *ep = strchr(sp, '\n');
+		const char *ep = strchr(sp, '\n');
 		int len;
 		if (!ep)
 			len = strlen(sp);
diff --git a/mem-pool.c b/mem-pool.c
index 62441dcc71..8bc77cb0e8 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -169,7 +169,7 @@ char *mem_pool_strdup(struct mem_pool *pool, const char *str)
 
 char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
 {
-	char *p = memchr(str, '\0', len);
+	const char *p = memchr(str, '\0', len);
 	size_t actual_len = (p ? p - str : len);
 	char *ret = mem_pool_alloc(pool, actual_len+1);
 
diff --git a/merge-ort.c b/merge-ort.c
index e80e4f735a..6f30471b49 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2731,7 +2731,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 
 	while (1) {
 		/* Find the parent directory of cur_path */
-		char *last_slash = strrchr(cur_path, '/');
+		const char *last_slash = strrchr(cur_path, '/');
 		if (last_slash) {
 			parent_name = mem_pool_strndup(&opt->priv->pool,
 						       cur_path,
diff --git a/object-name.c b/object-name.c
index 8b862c124e..e1b09d823c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1756,7 +1756,7 @@ int repo_interpret_branch_name(struct repository *r,
 			       struct strbuf *buf,
 			       const struct interpret_branch_name_options *options)
 {
-	char *at;
+	const char *at;
 	const char *start;
 	int len;
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 8598b941c8..56cd803a67 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -544,7 +544,7 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
 				struct midx_pack_key *key,
 				uint32_t *pos)
 {
-	uint32_t *found;
+	const uint32_t *found;
 
 	if (key->pack >= m->num_packs + m->num_packs_in_base)
 		BUG("MIDX pack lookup out of bounds (%"PRIu32" >= %"PRIu32")",
diff --git a/pkt-line.c b/pkt-line.c
index fc583feb26..3fc3e9ea70 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -384,10 +384,10 @@ int packet_length(const char lenbuf_hex[4], size_t size)
 		hexval(lenbuf_hex[3]);
 }
 
-static char *find_packfile_uri_path(const char *buffer)
+static const char *find_packfile_uri_path(const char *buffer)
 {
 	const char *URI_MARK = "://";
-	char *path;
+	const char *path;
 	int len;
 
 	/* First char is sideband mark */
@@ -417,7 +417,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 {
 	int len;
 	char linelen[4];
-	char *uri_path_start;
+	const char *uri_path_start;
 
 	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
 		*pktlen = -1;
diff --git a/reflog-walk.c b/reflog-walk.c
index 4f1ce04749..4dbeaa93a7 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -157,7 +157,8 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	int recno = -1;
 	struct string_list_item *item;
 	struct complete_reflogs *reflogs;
-	char *branch, *at = strchr(name, '@');
+	char *branch;
+	const char *at = strchr(name, '@');
 	struct commit_reflog *commit_reflog;
 	enum selector_type selector = SELECTOR_NONE;
 
diff --git a/scalar.c b/scalar.c
index c9df9348ec..4efb6ac36d 100644
--- a/scalar.c
+++ b/scalar.c
@@ -393,7 +393,7 @@ static int delete_enlistment(struct strbuf *enlistment)
 {
 	struct strbuf parent = STRBUF_INIT;
 	size_t offset;
-	char *path_sep;
+	const char *path_sep;
 
 	if (unregister_dir())
 		return error(_("failed to unregister repository"));
diff --git a/strbuf.c b/strbuf.c
index 59678bf5b0..3939863cf3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1119,6 +1119,6 @@ void strbuf_stripspace(struct strbuf *sb, const char *comment_prefix)
 
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
-	char *path_sep = find_last_dir_sep(sb->buf);
+	const char *path_sep = find_last_dir_sep(sb->buf);
 	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
 }
diff --git a/string-list.c b/string-list.c
index 08dc00984c..7c34a425da 100644
--- a/string-list.c
+++ b/string-list.c
@@ -327,7 +327,7 @@ static int split_string(struct string_list *list, const char *string, const char
 		BUG("string_list_split() called without strdup_strings");
 
 	for (;;) {
-		char *end;
+		const char *end;
 
 		if (flags & STRING_LIST_SPLIT_TRIM) {
 			/* ltrim */
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index 6a2321b399..59b7dc14a1 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -127,7 +127,7 @@ static void clar_print_tap_error(int num, const struct clar_report *report, cons
 
 static void print_escaped(const char *str)
 {
-	char *c;
+	const char *c;
 
 	while ((c = strchr(str, '\'')) != NULL) {
 		printf("%.*s", (int)(c - str), str);
diff --git a/transport.c b/transport.c
index c7f06a7382..845fd441be 100644
--- a/transport.c
+++ b/transport.c
@@ -1657,7 +1657,7 @@ int transport_disconnect(struct transport *transport)
  */
 char *transport_anonymize_url(const char *url)
 {
-	char *scheme_prefix, *anon_part;
+	const char *scheme_prefix, *anon_part;
 	size_t anon_len, prefix_len = 0;
 
 	anon_part = strchr(url, '@');
diff --git a/wrapper.c b/wrapper.c
index b794fb20e7..16f5a63fbb 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -115,7 +115,7 @@ void *xmemdupz(const void *data, size_t len)
 
 char *xstrndup(const char *str, size_t len)
 {
-	char *p = memchr(str, '\0', len);
+	const char *p = memchr(str, '\0', len);
 	return xmemdupz(str, p ? p - str : len);
 }
 
-- 
2.52.0

