Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A99E20248
	for <e@80x24.org>; Sat, 13 Apr 2019 15:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfDMPT1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 11:19:27 -0400
Received: from mout.web.de ([217.72.192.78]:56523 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfDMPT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 11:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555168736;
        bh=yIzuufiX/y6FKPT90FzOxwZrLPcCpt+4qKOu6MDFVKk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p4UNP7JiPuoOEEYq7r/uINu8cFOBnRvzdprT7jfBX4aulfFgzLkAWPVe45gUQG/tx
         NuMWLd5dWG2pcmCrS3c7IlOn/E5xXp98a1GU2pBebzM26enn6OUMvPeVmsZMgg0FPO
         2BU11f6tdBn76uWszY0M1VePDcWALrgo968X9vUU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MWj2N-1hM4iE0qZn-00XuAt; Sat, 13 Apr 2019 17:18:55 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, thomas.braun@virtuell-zuhause.de,
        philipoakley@iee.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/1] Use size_t instead of 'unsigned long' for data in memory
Date:   Sat, 13 Apr 2019 17:18:50 +0200
Message-Id: <20190413151850.29037-1-tboegi@web.de>
X-Mailer: git-send-email 2.21.0.158.g67d3d1bf9e
In-Reply-To: <20181117151139.22994-1-tboegi@web.de>
References: <20181117151139.22994-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SgrDscjVZm+ShO5rKHMP1/7otq+h8i/PmwacO/EFNbGfrSOamU5
 WZCojuI5JqkYfE4KGpyYoEfvbxzlloKKSzf8iuFkTWxLb21yqk9nyT6NxhcmfEi3wa1rd5l
 JjmL6/YJL5emqiwhP7zKR7Skg/hqiXzjH+LIj6Ed/J5KfnLEDmCp9aKMV4I6ud25v3OhOgk
 B+QfyoXjZcbQ0aeHnuQJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W1CB6iyBZmc=:9jUHDWm3+stOuJ0DdvZpJb
 8Wpox34LBxsbtis4oe6wvfXARvp9dGIdwYynoeE0o5i9mRlItCkJHeXd5hVDPkAdU7gznzZzM
 O+IssgSHFJ8VmbQsqa6OlPCHoQtePc/l6crX0XCm3SRMoK9cdQWiG5ZsxDr8lf/3S2+TCOSV8
 60fYWrV3yfKMCd6SLOlckTXq2J6yOxe0b7CGyjPbEsoW9y/1WKTj/s3LaJ0Cj31tWpGHotSkn
 6YZQ2q9Q0uXc5EvDsc7u1fgsu6j4IMapkldv4D4CVBoAzbIMWJSLCEJLED+OkMMp0GkH7Qd/t
 ijA/xxZjg7KQVht/cLxlPSWdyjAjNfJnypG1Zoclj9aiBcgUW/6inQLyD49ffSsSObiGtxBYr
 PnNsF7eLmRS5RMCumESLqcCpzXTWVfsWovv2YwI0fdi5hT0x8oDuKYnZcWL7feWM6vU6kRYsP
 y/7nSDrm6XJ55NO4pulAZ3ID9kX+S6876/E5ApQF/r9taW7G2WYsEl56I/HKp3FT/zd6S7bi1
 TOXemkZsWh3n/FFpVwn90RvA59SE84X+GwMiMUC+C2P7IHKtYbSIZjNMrI/nKbsUejLQ7I/LF
 918BiaDqGKq0ZWFhPjZdQ95TfHudeAdc5uUrGQXz0cGEuK7FEPo+J5ARU2oqylus295T4wvzN
 xX7iJ7txPxggnWJP7T0AoR3aF/XPy3HTYSa8Tr29oPk/fwpIS25szZ64Ul9i238ea1+yPk+MG
 SO92tJGBsE2RRW6vJT9IWHKYekh6PSTKfmLTlenAB9Dm0WhrW+wHOHr99V02fVhGHLJTwyv2f
 fapIV05a4D2iDCpiDTmbKgIoTlT6yNMGvT9gXbY9zZSRjZelm6Kpd2YtI9tk1oBk4BK7FRqA0
 pn4onIvQPNGjQPvr3AJUGvgPRuBI8Qm2xKL18qpW5jV3I4z/9W1w0ktqbCJGZM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Currently the length of data which is stored in memory is stored
in "unsigned long" at many places in the code base.
This is OK when both "unsigned long" and size_t are 32 bits,
(and is OK when both are 64 bits).
On a 64 bit Windows system am "unsigned long" is 32 bit, and
that may be too short to measure the size of objects in memory,
a size_t is the natural choice.

Improve the code base in "small steps", as small as possible.
The smallest step seems to be much bigger than expected.
See this code-snippet from convert.c:
        const char *ret;
        unsigned long sz;
        void *data =3D read_blob_data_from_index(istate, path, &sz);
        ret =3D gather_convert_stats_ascii(data, sz);

The corrected version looks like this:
        const char *ret;
        size_t sz;
        void *data =3D read_blob_data_from_index(istate, path, &sz);
        ret =3D gather_convert_stats_ascii(data, sz);

However, when the Git code base is compiled with a compiler that
complains that "unsigned long" is different from size_t, we end
up in this huge patch, before the code base cleanly compiles.

And: there is more to be done in the zlib interface.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

This is the 3rd version of the patch.
 - Dscho contributed with a code-review (converted 2 more unsigned long)
 - Thomas Braun and Philip Oakley have done more work:
   https://github.com/tboegi/git/pull/1
   Those changes are not part of my patch series
 - Applying this patch on 'pu' gives 3 conflicts (blame.c, packfile.[ch])

  apply.c                  | 78 ++++++++++++++++++++--------------------
 archive-tar.c            | 18 +++++-----
 archive-zip.c            |  2 +-
 archive.c                |  2 +-
 archive.h                |  2 +-
 bisect.c                 |  2 +-
 blame.c                  |  6 ++--
 blame.h                  |  2 +-
 builtin/cat-file.c       | 10 +++---
 builtin/difftool.c       |  2 +-
 builtin/fast-export.c    |  6 ++--
 builtin/fmt-merge-msg.c  |  4 +--
 builtin/fsck.c           |  6 ++--
 builtin/grep.c           |  8 ++---
 builtin/index-pack.c     | 26 +++++++-------
 builtin/log.c            |  4 +--
 builtin/ls-tree.c        |  2 +-
 builtin/merge-tree.c     |  6 ++--
 builtin/mktag.c          |  4 +--
 builtin/notes.c          |  6 ++--
 builtin/pack-objects.c   | 70 ++++++++++++++++++------------------
 builtin/reflog.c         |  2 +-
 builtin/replace.c        |  2 +-
 builtin/tag.c            |  4 +--
 builtin/unpack-file.c    |  2 +-
 builtin/unpack-objects.c | 34 +++++++++---------
 builtin/verify-commit.c  |  4 +--
 bundle.c                 |  2 +-
 cache.h                  | 11 +++---
 combine-diff.c           | 11 +++---
 commit.c                 | 22 ++++++------
 commit.h                 | 10 +++---
 config.c                 |  2 +-
 convert.c                | 16 ++++-----
 delta.h                  | 20 +++++------
 diff-delta.c             |  4 +--
 diff.c                   | 30 ++++++++--------
 diff.h                   |  2 +-
 diffcore-pickaxe.c       |  4 +--
 diffcore.h               |  2 +-
 dir.c                    |  6 ++--
 dir.h                    |  2 +-
 entry.c                  |  4 +--
 fast-import.c            | 26 +++++++-------
 fsck.c                   | 12 +++----
 fsck.h                   |  2 +-
 fuzz-pack-headers.c      |  4 +--
 grep.h                   |  2 +-
 http-push.c              |  2 +-
 list-objects-filter.c    |  2 +-
 mailmap.c                |  2 +-
 match-trees.c            |  4 +--
 merge-blobs.c            |  6 ++--
 merge-blobs.h            |  2 +-
 merge-recursive.c        |  4 +--
 notes-cache.c            |  2 +-
 notes-merge.c            |  4 +--
 notes.c                  |  6 ++--
 object-store.h           | 22 ++++++------
 object.c                 |  4 +--
 object.h                 |  2 +-
 pack-check.c             |  2 +-
 pack-objects.h           | 14 ++++----
 pack.h                   |  2 +-
 packfile.c               | 44 +++++++++++------------
 packfile.h               | 10 +++---
 patch-delta.c            |  8 ++---
 range-diff.c             |  2 +-
 read-cache.c             | 48 ++++++++++++-------------
 ref-filter.c             | 16 ++++-----
 remote-testsvn.c         |  4 +--
 rerere.c                 |  2 +-
 sha1-file.c              | 66 +++++++++++++++++-----------------
 sha1dc_git.c             |  2 +-
 sha1dc_git.h             |  2 +-
 streaming.c              | 12 +++----
 streaming.h              |  2 +-
 submodule-config.c       |  2 +-
 t/helper/test-delta.c    |  2 +-
 tag.c                    |  6 ++--
 tag.h                    |  2 +-
 tree-walk.c              | 14 ++++----
 tree.c                   |  2 +-
 xdiff-interface.c        |  4 +--
 xdiff-interface.h        |  4 +--
 85 files changed, 422 insertions(+), 420 deletions(-)

diff --git a/apply.c b/apply.c
index f15afa9f6a..7594859ce6 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -177,9 +177,9 @@ static void set_default_whitespace_mode(struct apply_s=
tate *state)
  * of context lines.
  */
 struct fragment {
-	unsigned long leading, trailing;
-	unsigned long oldpos, oldlines;
-	unsigned long newpos, newlines;
+	size_t leading, trailing;
+	size_t oldpos, oldlines;
+	size_t newpos, newlines;
 	/*
 	 * 'patch' is usually borrowed from buf in apply_patch(),
 	 * but some codepaths store an allocated buffer.
@@ -423,9 +423,9 @@ static int read_patch_file(struct strbuf *sb, int fd)
 	return 0;
 }

-static unsigned long linelen(const char *buffer, unsigned long size)
+static size_t linelen(const char *buffer, size_t size)
 {
-	unsigned long len =3D 0;
+	size_t len =3D 0;
 	while (size--) {
 		len++;
 		if (*buffer++ =3D=3D '\n')
@@ -1321,7 +1321,7 @@ static int parse_git_header(struct apply_state *stat=
e,
 			    unsigned int size,
 			    struct patch *patch)
 {
-	unsigned long offset;
+	size_t offset;

 	/* A git diff has explicit new/delete information, so we don't guess */
 	patch->is_new =3D 0;
@@ -1391,7 +1391,7 @@ static int parse_git_header(struct apply_state *stat=
e,
 	return offset;
 }

-static int parse_num(const char *line, unsigned long *p)
+static int parse_num(const char *line, size_t *p)
 {
 	char *ptr;

@@ -1402,7 +1402,7 @@ static int parse_num(const char *line, unsigned long=
 *p)
 }

 static int parse_range(const char *line, int len, int offset, const char =
*expect,
-		       unsigned long *p1, unsigned long *p2)
+		       size_t *p1, size_t *p2)
 {
 	int digits, ex;

@@ -1517,11 +1517,11 @@ static int parse_fragment_header(const char *line,=
 int len, struct fragment *fra
  */
 static int find_header(struct apply_state *state,
 		       const char *line,
-		       unsigned long size,
+		       size_t size,
 		       int *hdrsize,
 		       struct patch *patch)
 {
-	unsigned long offset, len;
+	size_t offset, len;

 	patch->is_toplevel_relative =3D 0;
 	patch->is_rename =3D patch->is_copy =3D 0;
@@ -1529,7 +1529,7 @@ static int find_header(struct apply_state *state,
 	patch->old_mode =3D patch->new_mode =3D 0;
 	patch->old_name =3D patch->new_name =3D NULL;
 	for (offset =3D 0; size > 0; offset +=3D len, size -=3D len, line +=3D l=
en, state->linenr++) {
-		unsigned long nextlen;
+		size_t nextlen;

 		len =3D linelen(line, size);
 		if (!len)
@@ -1667,14 +1667,14 @@ static void check_old_for_crlf(struct patch *patch=
, const char *line, int len)
  */
 static int parse_fragment(struct apply_state *state,
 			  const char *line,
-			  unsigned long size,
+			  size_t size,
 			  struct patch *patch,
 			  struct fragment *fragment)
 {
 	int added, deleted;
 	int len =3D linelen(line, size), offset;
-	unsigned long oldlines, newlines;
-	unsigned long leading, trailing;
+	size_t oldlines, newlines;
+	size_t leading, trailing;

 	offset =3D parse_fragment_header(line, len, fragment);
 	if (offset < 0)
@@ -1789,11 +1789,11 @@ static int parse_fragment(struct apply_state *stat=
e,
  */
 static int parse_single_patch(struct apply_state *state,
 			      const char *line,
-			      unsigned long size,
+			      size_t size,
 			      struct patch *patch)
 {
-	unsigned long offset =3D 0;
-	unsigned long oldlines =3D 0, newlines =3D 0, context =3D 0;
+	size_t offset =3D 0;
+	size_t oldlines =3D 0, newlines =3D 0, context =3D 0;
 	struct fragment **fragp =3D &patch->fragments;

 	while (size > 4 && !memcmp(line, "@@ -", 4)) {
@@ -1864,8 +1864,8 @@ static inline int metadata_changes(struct patch *pat=
ch)
 		 patch->old_mode !=3D patch->new_mode);
 }

-static char *inflate_it(const void *data, unsigned long size,
-			unsigned long inflated_size)
+static char *inflate_it(const void *data, size_t size,
+			size_t inflated_size)
 {
 	git_zstream stream;
 	void *out;
@@ -1894,7 +1894,7 @@ static char *inflate_it(const void *data, unsigned l=
ong size,
  */
 static struct fragment *parse_binary_hunk(struct apply_state *state,
 					  char **buf_p,
-					  unsigned long *sz_p,
+					  size_t *sz_p,
 					  int *status_p,
 					  int *used_p)
 {
@@ -1911,10 +1911,10 @@ static struct fragment *parse_binary_hunk(struct a=
pply_state *state,
 	 * to 1-26 bytes, and 'a'-'z' corresponds to 27-52 bytes.
 	 */
 	int llen, used;
-	unsigned long size =3D *sz_p;
+	size_t size =3D *sz_p;
 	char *buffer =3D *buf_p;
 	int patch_method;
-	unsigned long origlen;
+	size_t origlen;
 	char *data =3D NULL;
 	int hunk_size =3D 0;
 	struct fragment *frag;
@@ -2006,7 +2006,7 @@ static struct fragment *parse_binary_hunk(struct app=
ly_state *state,
  */
 static int parse_binary(struct apply_state *state,
 			char *buffer,
-			unsigned long size,
+			size_t size,
 			struct patch *patch)
 {
 	/*
@@ -2123,7 +2123,7 @@ static int use_patch(struct apply_state *state, stru=
ct patch *p)
  *   the number of bytes consumed otherwise,
  *     so that the caller can call us again for the next patch.
  */
-static int parse_chunk(struct apply_state *state, char *buffer, unsigned =
long size, struct patch *patch)
+static int parse_chunk(struct apply_state *state, char *buffer, size_t si=
ze, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset =3D find_header(state, buffer, size, &hdrsize, patch);
@@ -2153,7 +2153,7 @@ static int parse_chunk(struct apply_state *state, ch=
ar *buffer, unsigned long si
 	if (!patchsize) {
 		static const char git_binary[] =3D "GIT binary patch\n";
 		int hd =3D hdrsize + offset;
-		unsigned long llen =3D linelen(buffer + hd, size - hd);
+		size_t llen =3D linelen(buffer + hd, size - hd);

 		if (llen =3D=3D sizeof(git_binary) - 1 &&
 		    !memcmp(git_binary, buffer + hd, llen)) {
@@ -2397,7 +2397,7 @@ static void update_pre_post_images(struct image *pre=
image,
 static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *preimage,
 				    struct image *postimage,
-				    unsigned long current,
+				    size_t current,
 				    int current_lno,
 				    int preimage_limit)
 {
@@ -2466,7 +2466,7 @@ static int match_fragment(struct apply_state *state,
 			  struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
-			  unsigned long current,
+			  size_t current,
 			  int current_lno,
 			  unsigned ws_rule,
 			  int match_beginning, int match_end)
@@ -2677,7 +2677,7 @@ static int find_pos(struct apply_state *state,
 		    int match_beginning, int match_end)
 {
 	int i;
-	unsigned long backwards, forwards, current;
+	size_t backwards, forwards, current;
 	int backwards_lno, forwards_lno, current_lno;

 	/*
@@ -2851,7 +2851,7 @@ static int apply_one_fragment(struct apply_state *st=
ate,
 	int new_blank_lines_at_end =3D 0;
 	int found_new_blank_lines_at_end =3D 0;
 	int hunk_linenr =3D frag->linenr;
-	unsigned long leading, trailing;
+	size_t leading, trailing;
 	int pos, applied_pos;
 	struct image preimage;
 	struct image postimage;
@@ -3075,9 +3075,9 @@ static int apply_one_fragment(struct apply_state *st=
ate,
 		 */
 		if ((leading !=3D frag->leading ||
 		     trailing !=3D frag->trailing) && state->apply_verbosity > verbosit=
y_silent)
-			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
+			fprintf_ln(stderr, _("Context reduced to (%"PRIuMAX"/%"PRIuMAX")"
 					     " to apply fragment at %d"),
-				   leading, trailing, applied_pos+1);
+				   (uintmax_t)leading, (uintmax_t)trailing, applied_pos+1);
 		update_image(state, img, applied_pos, &preimage, &postimage);
 	} else {
 		if (state->apply_verbosity > verbosity_normal)
@@ -3099,7 +3099,7 @@ static int apply_binary_fragment(struct apply_state =
*state,
 				 struct patch *patch)
 {
 	struct fragment *fragment =3D patch->fragments;
-	unsigned long len;
+	size_t len;
 	void *dst;

 	if (!fragment)
@@ -3189,7 +3189,7 @@ static int apply_binary(struct apply_state *state,
 	if (has_object_file(&oid)) {
 		/* We already have the postimage */
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *result;

 		result =3D read_object_file(&oid, &type, &size);
@@ -3234,7 +3234,7 @@ static int apply_fragments(struct apply_state *state=
, struct image *img, struct
 	while (frag) {
 		nth++;
 		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth))=
 {
-			error(_("patch failed: %s:%ld"), name, frag->oldpos);
+			error(_("patch failed: %s:%"PRIuMAX), name, (uintmax_t)frag->oldpos);
 			if (!state->apply_with_reject)
 				return -1;
 			frag->rejected =3D 1;
@@ -3251,7 +3251,7 @@ static int read_blob_object(struct strbuf *buf, cons=
t struct object_id *oid, uns
 		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		unsigned long sz;
+		size_t sz;
 		char *result;

 		result =3D read_object_file(oid, &type, &sz);
@@ -4280,7 +4280,7 @@ static int add_index_file(struct apply_state *state,
 			  const char *path,
 			  unsigned mode,
 			  void *buf,
-			  unsigned long size)
+			  size_t size)
 {
 	struct stat st;
 	struct cache_entry *ce;
@@ -4334,7 +4334,7 @@ static int add_index_file(struct apply_state *state,
  */
 static int try_create_file(struct apply_state *state, const char *path,
 			   unsigned int mode, const char *buf,
-			   unsigned long size)
+			   size_t size)
 {
 	int fd, res;
 	struct strbuf nbuf =3D STRBUF_INIT;
@@ -4385,7 +4385,7 @@ static int create_one_file(struct apply_state *state=
,
 			   char *path,
 			   unsigned mode,
 			   const char *buf,
-			   unsigned long size)
+			   size_t size)
 {
 	int res;

@@ -4477,7 +4477,7 @@ static int create_file(struct apply_state *state, st=
ruct patch *patch)
 {
 	char *path =3D patch->new_name;
 	unsigned mode =3D patch->new_mode;
-	unsigned long size =3D patch->resultsize;
+	size_t size =3D patch->resultsize;
 	char *buf =3D patch->result;

 	if (!mode)
diff --git a/archive-tar.c b/archive-tar.c
index 4aabd566fb..de051aa0e2 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -13,7 +13,7 @@
 #define BLOCKSIZE	(RECORDSIZE * 20)

 static char block[BLOCKSIZE];
-static unsigned long offset;
+static size_t offset;

 static int tar_umask =3D 002;

@@ -51,12 +51,12 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void do_write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, size_t size)
 {
 	const char *buf =3D data;

 	if (offset) {
-		unsigned long chunk =3D BLOCKSIZE - offset;
+		size_t chunk =3D BLOCKSIZE - offset;
 		if (size < chunk)
 			chunk =3D size;
 		memcpy(block + offset, buf, chunk);
@@ -78,7 +78,7 @@ static void do_write_blocked(const void *data, unsigned =
long size)

 static void finish_record(void)
 {
-	unsigned long tail;
+	size_t tail;
 	tail =3D offset % RECORDSIZE;
 	if (tail)  {
 		memset(block + offset, 0, RECORDSIZE - tail);
@@ -87,7 +87,7 @@ static void finish_record(void)
 	write_if_needed();
 }

-static void write_blocked(const void *data, unsigned long size)
+static void write_blocked(const void *data, size_t size)
 {
 	do_write_blocked(data, size);
 	finish_record();
@@ -116,7 +116,7 @@ static int stream_blocked(const struct object_id *oid)
 {
 	struct git_istream *st;
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	char buf[BLOCKSIZE];
 	ssize_t readlen;

@@ -199,7 +199,7 @@ static size_t get_path_prefix(const char *path, size_t=
 pathlen, size_t maxlen)

 static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
-			   unsigned int mode, unsigned long size)
+			   unsigned int mode, size_t size)
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
 	xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_ISREG(mo=
de) ? (uintmax_t)size : (uintmax_t)0);
@@ -220,7 +220,7 @@ static void prepare_header(struct archiver_args *args,

 static void write_extended_header(struct archiver_args *args,
 				  const struct object_id *oid,
-				  const void *buffer, unsigned long size)
+				  const void *buffer, size_t size)
 {
 	struct ustar_header header;
 	unsigned int mode;
@@ -241,7 +241,7 @@ static int write_tar_entry(struct archiver_args *args,
 	struct ustar_header header;
 	struct strbuf ext_header =3D STRBUF_INIT;
 	unsigned int old_mode =3D mode;
-	unsigned long size, size_in_header;
+	size_t size, size_in_header;
 	void *buffer;
 	int err =3D 0;

diff --git a/archive-zip.c b/archive-zip.c
index 155ee4a779..7bc9b8d425 100644
=2D-- a/archive-zip.c
+++ b/archive-zip.c
@@ -297,7 +297,7 @@ static int write_zip_entry(struct archiver_args *args,
 	void *buffer;
 	struct git_istream *stream =3D NULL;
 	unsigned long flags =3D 0;
-	unsigned long size;
+	size_t size;
 	int is_binary =3D -1;
 	const char *path_without_prefix =3D path + args->baselen;
 	unsigned int creator_version =3D 0;
diff --git a/archive.c b/archive.c
index 1f98324a93..4be6dc50bc 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -73,7 +73,7 @@ static void format_subst(const struct commit *commit,
 void *object_file_to_archive(const struct archiver_args *args,
 			     const char *path, const struct object_id *oid,
 			     unsigned int mode, enum object_type *type,
-			     unsigned long *sizep)
+			     size_t *sizep)
 {
 	void *buffer;
 	const struct commit *commit =3D args->convert ? args->commit : NULL;
diff --git a/archive.h b/archive.h
index 21ac010699..5b69ee1baf 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -54,6 +54,6 @@ extern int write_archive_entries(struct archiver_args *a=
rgs, write_archive_entry
 extern void *object_file_to_archive(const struct archiver_args *args,
 				    const char *path, const struct object_id *oid,
 				    unsigned int mode, enum object_type *type,
-				    unsigned long *sizep);
+				    size_t *sizep);

 #endif	/* ARCHIVE_H */
diff --git a/bisect.c b/bisect.c
index e87ac29a51..7ca069225d 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -137,7 +137,7 @@ static void show_list(const char *debug, int counted, =
int nr,
 		struct commit *commit =3D p->item;
 		unsigned flags =3D commit->object.flags;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf =3D read_object_file(&commit->object.oid, &type,
 					     &size);
 		const char *subject_start;
diff --git a/blame.c b/blame.c
index 5c07dec190..04d15a45a0 100644
=2D-- a/blame.c
+++ b/blame.c
@@ -223,7 +223,7 @@ static struct commit *fake_working_tree_commit(struct =
repository *r,
 		struct stat st;
 		const char *read_from;
 		char *buf_ptr;
-		unsigned long buf_len;
+		size_t buf_len;

 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
@@ -320,7 +320,7 @@ static void fill_origin_blob(struct diff_options *opt,
 {
 	if (!o->file.ptr) {
 		enum object_type type;
-		unsigned long file_size;
+		size_t file_size;

 		(*num_read_blob)++;
 		if (opt->flags.allow_textconv &&
@@ -1652,7 +1652,7 @@ static const char *get_next_line(const char *start, =
const char *end)
 static int prepare_lines(struct blame_scoreboard *sb)
 {
 	const char *buf =3D sb->final_buf;
-	unsigned long len =3D sb->final_buf_size;
+	size_t len =3D sb->final_buf_size;
 	const char *end =3D buf + len;
 	const char *p;
 	int *lineno;
diff --git a/blame.h b/blame.h
index be3a895043..0ef7ff1f3f 100644
=2D-- a/blame.h
+++ b/blame.h
@@ -112,7 +112,7 @@ struct blame_scoreboard {
 	 * indexed with scoreboard.lineno[blame_entry.lno].
 	 */
 	const char *final_buf;
-	unsigned long final_buf_size;
+	size_t final_buf_size;

 	/* linked list of blames */
 	struct blame_entry *ent;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f092382e1..dc50207573 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -31,7 +31,7 @@ static const char *force_path;

 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
-			 char **buf, unsigned long *size)
+			 char **buf, size_t *size)
 {
 	enum object_type type;

@@ -64,7 +64,7 @@ static int cat_one_file(int opt, const char *exp_type, c=
onst char *obj_name,
 	struct object_id oid;
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	struct object_context obj_context;
 	struct object_info oi =3D OBJECT_INFO_INIT;
 	struct strbuf sb =3D STRBUF_INIT;
@@ -191,7 +191,7 @@ static int cat_one_file(int opt, const char *exp_type,=
 const char *obj_name,
 struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
@@ -303,7 +303,7 @@ static void print_object_or_die(struct batch_options *=
opt, struct expand_data *d
 			fflush(stdout);
 		if (opt->cmdmode) {
 			char *contents;
-			unsigned long size;
+			size_t size;

 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
@@ -334,7 +334,7 @@ static void print_object_or_die(struct batch_options *=
opt, struct expand_data *d
 	}
 	else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *contents;

 		contents =3D read_object_file(oid, &type, &size);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..224f36a0fd 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -307,7 +307,7 @@ static char *get_symlink(const struct object_id *oid, =
const char *path)
 		data =3D strbuf_detach(&link, NULL);
 	} else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		data =3D read_object_file(oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9e283482ef..09ce3b1996 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -226,7 +226,7 @@ static void show_progress(void)
  * There's no need to cache this result with anonymize_mem, since
  * we already handle blob content caching with marks.
  */
-static char *anonymize_blob(unsigned long *size)
+static char *anonymize_blob(size_t *size)
 {
 	static int counter;
 	struct strbuf out =3D STRBUF_INIT;
@@ -237,7 +237,7 @@ static char *anonymize_blob(unsigned long *size)

 static void export_blob(const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	struct object *object;
@@ -707,7 +707,7 @@ static void handle_tail(struct object_array *commits, =
struct rev_info *revs,

 static void handle_tag(const char *name, struct tag *tag)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	const char *tagger, *tagger_end, *message;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a4615587fd..0f049ba87e 100644
=2D-- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -471,7 +471,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 static void fmt_tag_signature(struct strbuf *tagbuf,
 			      struct strbuf *sig,
 			      const char *buf,
-			      unsigned long len)
+			      size_t len)
 {
 	const char *tag_body =3D strstr(buf, "\n\n");
 	if (tag_body) {
@@ -493,7 +493,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	for (i =3D 0; i < origins.nr; i++) {
 		struct object_id *oid =3D origins.items[i].util;
 		enum object_type type;
-		unsigned long size, len;
+		size_t size, len;
 		char *buf =3D read_object_file(oid, &type, &size);
 		struct strbuf sig =3D STRBUF_INIT;

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d26fb0a044..96cfd64fb6 100644
=2D-- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -422,7 +422,7 @@ static void check_connectivity(void)
 	}
 }

-static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj(struct object *obj, void *buffer, size_t size)
 {
 	int err;

@@ -470,7 +470,7 @@ static int fsck_obj(struct object *obj, void *buffer, =
unsigned long size)
 }

 static int fsck_obj_buffer(const struct object_id *oid, enum object_type =
type,
-			   unsigned long size, void *buffer, int *eaten)
+			   size_t size, void *buffer, int *eaten)
 {
 	/*
 	 * Note, buffer may be NULL if type is OBJ_BLOB. See
@@ -625,7 +625,7 @@ static int fsck_loose(const struct object_id *oid, con=
st char *path, void *data)
 {
 	struct object *obj;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *contents;
 	int eaten;

diff --git a/builtin/grep.c b/builtin/grep.c
index 580fd38f41..97682a8643 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -295,7 +295,7 @@ static int grep_cmd_config(const char *var, const char=
 *value, void *cb)
 	return st;
 }

-static void *lock_and_read_oid_file(const struct object_id *oid, enum obj=
ect_type *type, unsigned long *size)
+static void *lock_and_read_oid_file(const struct object_id *oid, enum obj=
ect_type *type, size_t *size)
 {
 	void *data;

@@ -452,7 +452,7 @@ static int grep_submodule(struct grep_opt *opt,
 		struct object *object;
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base =3D STRBUF_INIT;

 		object =3D parse_object_or_die(oid, oid_to_hex(oid));
@@ -583,7 +583,7 @@ static int grep_tree(struct grep_opt *opt, const struc=
t pathspec *pathspec,
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
-			unsigned long size;
+			size_t size;

 			data =3D lock_and_read_oid_file(&entry.oid, &type, &size);
 			if (!data)
@@ -618,7 +618,7 @@ static int grep_object(struct grep_opt *opt, const str=
uct pathspec *pathspec,
 	if (obj->type =3D=3D OBJ_COMMIT || obj->type =3D=3D OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base;
 		int hit, len;

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31046c7a0a..9e3f97f282 100644
=2D-- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -20,7 +20,7 @@ static const char index_pack_usage[] =3D

 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;
+	size_t size;
 	unsigned char hdr_size;
 	signed char type;
 	signed char real_type;
@@ -36,7 +36,7 @@ struct base_data {
 	struct base_data *child;
 	struct object_entry *obj;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
 };
@@ -198,7 +198,7 @@ static unsigned check_object(struct object *obj)
 		return 0;

 	if (!(obj->flags & FLAG_CHECKED)) {
-		unsigned long size;
+		size_t size;
 		int type =3D oid_object_info(the_repository, &obj->oid, &size);
 		if (type <=3D 0)
 			die(_("did not receive expected object %s"),
@@ -412,7 +412,7 @@ static int is_delta_type(enum object_type type)
 	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
 }

-static void *unpack_entry_data(off_t offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, size_t size,
 			       enum object_type type, struct object_id *oid)
 {
 	static char fixed_buf[8192];
@@ -467,7 +467,7 @@ static void *unpack_raw_entry(struct object_entry *obj=
,
 			      struct object_id *oid)
 {
 	unsigned char *p;
-	unsigned long size, c;
+	size_t size, c;
 	off_t base_offset;
 	unsigned shift;
 	void *data;
@@ -529,7 +529,7 @@ static void *unpack_raw_entry(struct object_entry *obj=
,
 }

 static void *unpack_data(struct object_entry *obj,
-			 int (*consume)(const unsigned char *, unsigned long, void *),
+			 int (*consume)(const unsigned char *, size_t, void *),
 			 void *cb_data)
 {
 	off_t from =3D obj[0].idx.offset + obj[0].hdr_size;
@@ -706,10 +706,10 @@ struct compare_data {
 	struct object_entry *entry;
 	struct git_istream *st;
 	unsigned char *buf;
-	unsigned long buf_size;
+	size_t buf_size;
 };

-static int compare_objects(const unsigned char *buf, unsigned long size,
+static int compare_objects(const unsigned char *buf, size_t size,
 			   void *cb_data)
 {
 	struct compare_data *data =3D cb_data;
@@ -741,7 +741,7 @@ static int check_collison(struct object_entry *entry)
 {
 	struct compare_data data;
 	enum object_type type;
-	unsigned long size;
+	size_t size;

 	if (entry->size <=3D big_file_threshold || entry->type !=3D OBJ_BLOB)
 		return -1;
@@ -761,7 +761,7 @@ static int check_collison(struct object_entry *entry)
 }

 static void sha1_object(const void *data, struct object_entry *obj_entry,
-			unsigned long size, enum object_type type,
+			size_t size, enum object_type type,
 			const struct object_id *oid)
 {
 	void *new_data =3D NULL;
@@ -785,7 +785,7 @@ static void sha1_object(const void *data, struct objec=
t_entry *obj_entry,
 	if (collision_test_needed) {
 		void *has_data;
 		enum object_type has_type;
-		unsigned long has_size;
+		size_t has_size;
 		read_lock();
 		has_type =3D oid_object_info(the_repository, oid, &has_size);
 		if (has_type < 0)
@@ -1288,11 +1288,11 @@ static int write_compressed(struct hashfile *f, vo=
id *in, unsigned int size)

 static struct object_entry *append_obj_to_pack(struct hashfile *f,
 			       const unsigned char *sha1, void *buf,
-			       unsigned long size, enum object_type type)
+			       size_t size, enum object_type type)
 {
 	struct object_entry *obj =3D &objects[nr_objects++];
 	unsigned char header[10];
-	unsigned long s =3D size;
+	size_t s =3D size;
 	int n =3D 0;
 	unsigned char c =3D (type << 4) | (s & 15);
 	s >>=3D 4;
diff --git a/builtin/log.c b/builtin/log.c
index ab859f5904..586e746183 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -507,7 +507,7 @@ static int show_blob_object(const struct object_id *oi=
d, struct rev_info *rev, c
 	struct object_id oidc;
 	struct object_context obj_context;
 	char *buf;
-	unsigned long size;
+	size_t size;

 	fflush(rev->diffopt.file);
 	if (!rev->diffopt.flags.textconv_set_via_cmdline ||
@@ -535,7 +535,7 @@ static int show_blob_object(const struct object_id *oi=
d, struct rev_info *rev, c

 static int show_tag_object(const struct object_id *oid, struct rev_info *=
rev)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf =3D read_object_file(oid, &type, &size);
 	int offset =3D 0;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7cad3f24eb..b4ceca9e25 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -94,7 +94,7 @@ static int show_tree(const struct object_id *oid, struct=
 strbuf *base,
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
-				unsigned long size;
+				size_t size;
 				if (oid_object_info(the_repository, oid, &size) =3D=3D OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 34ca0258b1..08f4ba3256 100644
=2D-- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -56,7 +56,7 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }

-static void *result(struct merge_list *entry, unsigned long *size)
+static void *result(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	struct blob *base, *our, *their;
@@ -81,7 +81,7 @@ static void *result(struct merge_list *entry, unsigned l=
ong *size)
 			   base, our, their, size);
 }

-static void *origin(struct merge_list *entry, unsigned long *size)
+static void *origin(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	while (entry) {
@@ -103,7 +103,7 @@ static int show_outf(void *priv_, mmbuffer_t *mb, int =
nbuf)

 static void show_diff(struct merge_list *entry)
 {
-	unsigned long size;
+	size_t size;
 	mmfile_t src, dst;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 6fb7dc8578..955a353fde 100644
=2D-- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -24,7 +24,7 @@ static int verify_object(const struct object_id *oid, co=
nst char *expected_type)
 {
 	int ret =3D -1;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buffer =3D read_object_file(oid, &type, &size);
 	const struct object_id *repl =3D lookup_replace_object(the_repository, o=
id);

@@ -36,7 +36,7 @@ static int verify_object(const struct object_id *oid, co=
nst char *expected_type)
 	return ret;
 }

-static int verify_tag(char *buffer, unsigned long size)
+static int verify_tag(char *buffer, size_t size)
 {
 	int typelen;
 	char type[20];
diff --git a/builtin/notes.c b/builtin/notes.c
index 02e97f55c5..5f232d5e66 100644
=2D-- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -122,7 +122,7 @@ static int list_each_note(const struct object_id *obje=
ct_oid,

 static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf =3D read_object_file(oid, &type, &size);
 	if (buf) {
@@ -252,7 +252,7 @@ static int parse_reuse_arg(const struct option *opt, c=
onst char *arg, int unset)
 	char *buf;
 	struct object_id object;
 	enum object_type type;
-	unsigned long len;
+	size_t len;

 	BUG_ON_OPT_NEG(unset);

@@ -616,7 +616,7 @@ static int append_edit(int argc, const char **argv, co=
nst char *prefix)

 	if (note && !edit) {
 		/* Append buf to previous note contents */
-		unsigned long size;
+		size_t size;
 		enum object_type type;
 		char *prev_buf =3D read_object_file(note, &type, &size);

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4f953ece2f..0634f22ab6 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -81,7 +81,7 @@ static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
 static int progress =3D 1;
 static int window =3D 10;
-static unsigned long pack_size_limit;
+static size_t pack_size_limit;
 static int depth =3D 50;
 static int delta_search_threads;
 static int pack_to_stdout;
@@ -103,11 +103,11 @@ static int exclude_promisor_objects;

 static int use_delta_islands;

-static unsigned long delta_cache_size =3D 0;
-static unsigned long max_delta_cache_size =3D DEFAULT_DELTA_CACHE_SIZE;
-static unsigned long cache_max_small_delta_size =3D 1000;
+static size_t delta_cache_size =3D 0;
+static size_t max_delta_cache_size =3D DEFAULT_DELTA_CACHE_SIZE;
+static size_t cache_max_small_delta_size =3D 1000;

-static unsigned long window_memory_limit =3D 0;
+static size_t window_memory_limit =3D 0;

 static struct list_objects_filter_options filter_options;

@@ -144,7 +144,7 @@ static void index_commit_for_bitmap(struct commit *com=
mit)

 static void *get_delta(struct object_entry *entry)
 {
-	unsigned long size, base_size, delta_size;
+	size_t size, base_size, delta_size;
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;

@@ -170,11 +170,11 @@ static void *get_delta(struct object_entry *entry)
 	return delta_buf;
 }

-static unsigned long do_compress(void **pptr, unsigned long size)
+static size_t do_compress(void **pptr, size_t size)
 {
 	git_zstream stream;
 	void *in, *out;
-	unsigned long maxsize;
+	size_t maxsize;

 	git_deflate_init(&stream, pack_compression_level);
 	maxsize =3D git_deflate_bound(&stream, size);
@@ -195,13 +195,13 @@ static unsigned long do_compress(void **pptr, unsign=
ed long size)
 	return stream.total_out;
 }

-static unsigned long write_large_blob_data(struct git_istream *st, struct=
 hashfile *f,
+static size_t write_large_blob_data(struct git_istream *st, struct hashfi=
le *f,
 					   const struct object_id *oid)
 {
 	git_zstream stream;
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
-	unsigned long olen =3D 0;
+	size_t olen =3D 0;

 	git_deflate_init(&stream, pack_compression_level);

@@ -242,7 +242,7 @@ static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
 		off_t len,
-		unsigned long expect)
+		size_t expect)
 {
 	git_zstream stream;
 	unsigned char fakebuf[4096], *in;
@@ -284,10 +284,10 @@ static void copy_pack_data(struct hashfile *f,
 }

 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_no_reuse_object(struct hashfile *f, struct obj=
ect_entry *entry,
-					   unsigned long limit, int usable_delta)
+static size_t write_no_reuse_object(struct hashfile *f, struct object_ent=
ry *entry,
+					   size_t limit, int usable_delta)
 {
-	unsigned long size, datalen;
+	size_t size, datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
@@ -396,7 +396,7 @@ static unsigned long write_no_reuse_object(struct hash=
file *f, struct object_ent

 /* Return 0 if we will bust the pack-size limit */
 static off_t write_reuse_object(struct hashfile *f, struct object_entry *=
entry,
-				unsigned long limit, int usable_delta)
+				size_t limit, int usable_delta)
 {
 	struct packed_git *p =3D IN_PACK(entry);
 	struct pack_window *w_curs =3D NULL;
@@ -408,7 +408,7 @@ static off_t write_reuse_object(struct hashfile *f, st=
ruct object_entry *entry,
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 	const unsigned hashsz =3D the_hash_algo->rawsz;
-	unsigned long entry_size =3D SIZE(entry);
+	size_t entry_size =3D SIZE(entry);

 	if (DELTA(entry))
 		type =3D (allow_ofs_delta && DELTA(entry)->idx.offset) ?
@@ -479,7 +479,7 @@ static off_t write_object(struct hashfile *f,
 			  struct object_entry *entry,
 			  off_t write_offset)
 {
-	unsigned long limit;
+	size_t limit;
 	off_t len;
 	int usable_delta, to_reuse;

@@ -1210,7 +1210,7 @@ struct pbase_tree_cache {
 	int ref;
 	int temporary;
 	void *tree_data;
-	unsigned long tree_size;
+	size_t tree_size;
 };

 static struct pbase_tree_cache *(pbase_tree_cache[256]);
@@ -1237,7 +1237,7 @@ static struct pbase_tree_cache *pbase_tree_get(const=
 struct object_id *oid)
 {
 	struct pbase_tree_cache *ent, *nent;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int neigh;
 	int my_ix =3D pbase_tree_cache_ix(oid);
@@ -1420,7 +1420,7 @@ static void add_preferred_base(struct object_id *oid=
)
 {
 	struct pbase_tree *it;
 	void *data;
-	unsigned long size;
+	size_t size;
 	struct object_id tree_oid;

 	if (window <=3D num_preferred_base++)
@@ -1524,7 +1524,7 @@ static int can_reuse_delta(const unsigned char *base=
_sha1,

 static void check_object(struct object_entry *entry)
 {
-	unsigned long canonical_size;
+	size_t canonical_size;

 	if (IN_PACK(entry)) {
 		struct packed_git *p =3D IN_PACK(entry);
@@ -1536,7 +1536,7 @@ static void check_object(struct object_entry *entry)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
-		unsigned long in_pack_size;
+		size_t in_pack_size;

 		buf =3D use_pack(p, &w_curs, entry->in_pack_offset, &avail);

@@ -1702,7 +1702,7 @@ static void drop_reused_delta(struct object_entry *e=
ntry)
 	unsigned *idx =3D &to_pack.objects[entry->delta_idx - 1].delta_child_idx=
;
 	struct object_info oi =3D OBJECT_INFO_INIT;
 	enum object_type type;
-	unsigned long size;
+	size_t size;

 	while (*idx) {
 		struct object_entry *oe =3D &to_pack.objects[*idx - 1];
@@ -1905,8 +1905,8 @@ static int type_size_sort(const void *_a, const void=
 *_b)
 	const struct object_entry *b =3D *(struct object_entry **)_b;
 	const enum object_type a_type =3D oe_type(a);
 	const enum object_type b_type =3D oe_type(b);
-	const unsigned long a_size =3D SIZE(a);
-	const unsigned long b_size =3D SIZE(b);
+	const size_t a_size =3D SIZE(a);
+	const size_t b_size =3D SIZE(b);

 	if (a_type > b_type)
 		return -1;
@@ -1939,8 +1939,8 @@ struct unpacked {
 	unsigned depth;
 };

-static int delta_cacheable(unsigned long src_size, unsigned long trg_size=
,
-			   unsigned long delta_size)
+static int delta_cacheable(size_t src_size, size_t trg_size,
+			   size_t delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_ca=
che_size)
 		return 0;
@@ -1980,14 +1980,14 @@ static pthread_mutex_t progress_mutex;
  * reconstruction (so non-deltas are true object sizes, but deltas
  * return the size of the delta data).
  */
-unsigned long oe_get_size_slow(struct packing_data *pack,
+size_t oe_get_size_slow(struct packing_data *pack,
 			       const struct object_entry *e)
 {
 	struct packed_git *p;
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, size;
+	size_t used, size;
 	size_t avail;

 	if (e->type_ !=3D OBJ_OFS_DELTA && e->type_ !=3D OBJ_REF_DELTA) {
@@ -2017,11 +2017,11 @@ unsigned long oe_get_size_slow(struct packing_data=
 *pack,
 }

 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth, unsigned long *mem_usage)
+		     unsigned max_depth, size_t *mem_usage)
 {
 	struct object_entry *trg_entry =3D trg->entry;
 	struct object_entry *src_entry =3D src->entry;
-	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
+	size_t trg_size, src_size, delta_size, sizediff, max_size, sz;
 	unsigned ref_depth;
 	enum object_type type;
 	void *delta_buf;
@@ -2177,9 +2177,9 @@ static unsigned int check_delta_limit(struct object_=
entry *me, unsigned int n)
 	return m;
 }

-static unsigned long free_unpacked(struct unpacked *n)
+static size_t free_unpacked(struct unpacked *n)
 {
-	unsigned long freed_mem =3D sizeof_delta_index(n->index);
+	size_t freed_mem =3D sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index =3D NULL;
 	if (n->data) {
@@ -2196,7 +2196,7 @@ static void find_deltas(struct object_entry **list, =
unsigned *list_size,
 {
 	uint32_t i, idx =3D 0, count =3D 0;
 	struct unpacked *array;
-	unsigned long mem_usage =3D 0;
+	size_t mem_usage =3D 0;

 	array =3D xcalloc(window, sizeof(struct unpacked));

@@ -2279,7 +2279,7 @@ static void find_deltas(struct object_entry **list, =
unsigned *list_size,
 		 * between writes at that moment.
 		 */
 		if (entry->delta_data && !pack_to_stdout) {
-			unsigned long size;
+			size_t size;

 			size =3D do_compress(&entry->delta_data, DELTA_SIZE(entry));
 			if (size < (1U << OE_Z_DELTA_BITS)) {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4d3430900d..610968c174 100644
=2D-- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -82,7 +82,7 @@ static int tree_is_complete(const struct object_id *oid)

 	if (!tree->buffer) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *data =3D read_object_file(oid, &type, &size);
 		if (!data) {
 			tree->object.flags |=3D INCOMPLETE;
diff --git a/builtin/replace.c b/builtin/replace.c
index f5701629a8..915f324c5b 100644
=2D-- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -443,7 +443,7 @@ static int create_graft(int argc, const char **argv, i=
nt force, int gentle)
 	struct commit *commit;
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *buffer;
-	unsigned long size;
+	size_t size;

 	if (get_oid(old_ref, &old_oid) < 0)
 		return error(_("not a valid object name: '%s'"), old_ref);
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..3a76b590c1 100644
=2D-- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -165,7 +165,7 @@ static int git_tag_config(const char *var, const char =
*value, void *cb)

 static void write_tag_body(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf, *sp;

@@ -286,7 +286,7 @@ static void create_reflog_msg(const struct object_id *=
oid, struct strbuf *sb)
 	enum object_type type;
 	struct commit *c;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int subject_len =3D 0;
 	const char *subject_start;

diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 58652229f2..61200ed57c 100644
=2D-- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -7,7 +7,7 @@ static char *create_temp_file(struct object_id *oid)
 	static char path[50];
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	int fd;

 	buf =3D read_object_file(oid, &type, &size);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 80478808b3..69bf9c8500 100644
=2D-- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -32,7 +32,7 @@ static struct fsck_options fsck_options =3D FSCK_OPTIONS=
_STRICT;
  */
 struct obj_buffer {
 	char *buffer;
-	unsigned long size;
+	size_t size;
 };

 static struct decoration obj_decorate;
@@ -42,7 +42,7 @@ static struct obj_buffer *lookup_object_buffer(struct ob=
ject *base)
 	return lookup_decoration(&obj_decorate, base);
 }

-static void add_object_buffer(struct object *object, char *buffer, unsign=
ed long size)
+static void add_object_buffer(struct object *object, char *buffer, size_t=
 size)
 {
 	struct obj_buffer *obj;
 	obj =3D xcalloc(1, sizeof(struct obj_buffer));
@@ -94,7 +94,7 @@ static void use(int bytes)
 		die(_("pack exceeds maximum allowed size"));
 }

-static void *get_data(unsigned long size)
+static void *get_data(size_t size)
 {
 	git_zstream stream;
 	void *buf =3D xmallocz(size);
@@ -131,7 +131,7 @@ struct delta_info {
 	struct object_id base_oid;
 	unsigned nr;
 	off_t base_offset;
-	unsigned long size;
+	size_t size;
 	void *delta;
 	struct delta_info *next;
 };
@@ -140,7 +140,7 @@ static struct delta_info *delta_list;

 static void add_delta_to_list(unsigned nr, const struct object_id *base_o=
id,
 			      off_t base_offset,
-			      void *delta, unsigned long size)
+			      void *delta, size_t size)
 {
 	struct delta_info *info =3D xmalloc(sizeof(*info));

@@ -199,7 +199,7 @@ static int check_object(struct object *obj, int type, =
void *data, struct fsck_op
 		die("object type mismatch");

 	if (!(obj->flags & FLAG_OPEN)) {
-		unsigned long size;
+		size_t size;
 		int type =3D oid_object_info(the_repository, &obj->oid, &size);
 		if (type !=3D obj->type || type <=3D 0)
 			die("object of unexpected type");
@@ -229,7 +229,7 @@ static void write_rest(void)
 }

 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size);
+			 void *data, size_t size);

 /*
  * Write out nr-th object from the list, now we know the contents
@@ -237,7 +237,7 @@ static void added_object(unsigned nr, enum object_type=
 type,
  * to be checked at the end.
  */
 static void write_object(unsigned nr, enum object_type type,
-			 void *buf, unsigned long size)
+			 void *buf, size_t size)
 {
 	if (!strict) {
 		if (write_object_file(buf, size, type_name(type),
@@ -277,11 +277,11 @@ static void write_object(unsigned nr, enum object_ty=
pe type,
 }

 static void resolve_delta(unsigned nr, enum object_type type,
-			  void *base, unsigned long base_size,
-			  void *delta, unsigned long delta_size)
+			  void *base, size_t base_size,
+			  void *delta, size_t delta_size)
 {
 	void *result;
-	unsigned long result_size;
+	size_t result_size;

 	result =3D patch_delta(base, base_size,
 			     delta, delta_size,
@@ -297,7 +297,7 @@ static void resolve_delta(unsigned nr, enum object_typ=
e type,
  * resolve all the deltified objects that are based on it.
  */
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size)
+			 void *data, size_t size)
 {
 	struct delta_info **p =3D &delta_list;
 	struct delta_info *info;
@@ -316,7 +316,7 @@ static void added_object(unsigned nr, enum object_type=
 type,
 	}
 }

-static void unpack_non_delta_entry(enum object_type type, unsigned long s=
ize,
+static void unpack_non_delta_entry(enum object_type type, size_t size,
 				   unsigned nr)
 {
 	void *buf =3D get_data(size);
@@ -328,7 +328,7 @@ static void unpack_non_delta_entry(enum object_type ty=
pe, unsigned long size,
 }

 static int resolve_against_held(unsigned nr, const struct object_id *base=
,
-				void *delta_data, unsigned long delta_size)
+				void *delta_data, size_t delta_size)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
@@ -343,11 +343,11 @@ static int resolve_against_held(unsigned nr, const s=
truct object_id *base,
 	return 1;
 }

-static void unpack_delta_entry(enum object_type type, unsigned long delta=
_size,
+static void unpack_delta_entry(enum object_type type, size_t delta_size,
 			       unsigned nr)
 {
 	void *delta_data, *base;
-	unsigned long base_size;
+	size_t base_size;
 	struct object_id base_oid;

 	if (type =3D=3D OBJ_REF_DELTA) {
@@ -442,7 +442,7 @@ static void unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack;
-	unsigned long size, c;
+	size_t size, c;
 	enum object_type type;

 	obj_list[nr].offset =3D consumed_bytes;
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 7772c07ed7..0c25550ef1 100644
=2D-- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -21,7 +21,7 @@ static const char * const verify_commit_usage[] =3D {
 		NULL
 };

-static int run_gpg_verify(const struct object_id *oid, const char *buf, u=
nsigned long size, unsigned flags)
+static int run_gpg_verify(const struct object_id *oid, const char *buf, s=
ize_t size, unsigned flags)
 {
 	struct signature_check signature_check;
 	int ret;
@@ -41,7 +41,7 @@ static int verify_commit(const char *name, unsigned flag=
s)
 	enum object_type type;
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;

 	if (get_oid(name, &oid))
diff --git a/bundle.c b/bundle.c
index b45666c49b..518763818f 100644
=2D-- a/bundle.c
+++ b/bundle.c
@@ -217,7 +217,7 @@ int list_bundle_refs(struct bundle_header *header, int=
 argc, const char **argv)

 static int is_tag_in_date_range(struct object *tag, struct rev_info *revs=
)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf =3D NULL, *line, *lineend;
 	timestamp_t date;
diff --git a/cache.h b/cache.h
index 5c4aab2ff7..ed84392728 100644
=2D-- a/cache.h
+++ b/cache.h
@@ -782,7 +782,7 @@ extern int chmod_index_entry(struct index_state *, str=
uct cache_entry *ce, char
 extern int ce_same_name(const struct cache_entry *a, const struct cache_e=
ntry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *c=
e);
 extern int index_name_is_other(const struct index_state *, const char *, =
int);
-extern void *read_blob_data_from_index(const struct index_state *, const =
char *, unsigned long *);
+extern void *read_blob_data_from_index(const struct index_state *, const =
char *, size_t *);

 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
@@ -1297,10 +1297,11 @@ extern char *xdg_cache_home(const char *filename);

 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern int unpack_loose_header(git_zstream *stream, unsigned char *map, u=
nsigned long mapsize, void *buffer, unsigned long bufsiz);
-extern int parse_loose_header(const char *hdr, unsigned long *sizep);

-extern int check_object_signature(const struct object_id *oid, void *buf,=
 unsigned long size, const char *type);
+extern int unpack_loose_header(git_zstream *stream, unsigned char *map, s=
ize_t mapsize, void *buffer, size_t bufsiz);
+extern int parse_loose_header(const char *hdr, size_t *sizep);
+
+extern int check_object_signature(const struct object_id *oid, void *buf,=
 size_t size, const char *type);

 extern int finalize_object_file(const char *tmpfile, const char *filename=
);

@@ -1481,7 +1482,7 @@ extern int cache_name_stage_compare(const char *name=
1, int len1, int stage1, con

 extern void *read_object_with_reference(const struct object_id *oid,
 					const char *required_type,
-					unsigned long *size,
+					size_t *size,
 					struct object_id *oid_ret);

 extern struct object *peel_to_type(const char *name, int namelen,
diff --git a/combine-diff.c b/combine-diff.c
index 3e49f3bda8..5fe1e24faf 100644
=2D-- a/combine-diff.c
+++ b/combine-diff.c
@@ -311,7 +311,7 @@ static struct lline *coalesce_lines(struct lline *base=
, int *lenbase,

 static char *grab_blob(struct repository *r,
 		       const struct object_id *oid, unsigned int mode,
-		       unsigned long *size, struct userdiff_driver *textconv,
+		       size_t *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
 	char *blob;
@@ -403,7 +403,7 @@ static void consume_hunk(void *state_,
 	state->sline[state->nb-1].p_lno[state->n] =3D state->ob;
 }

-static void consume_line(void *state_, char *line, unsigned long len)
+static void consume_line(void *state_, char *line, size_t len)
 {
 	struct combine_diff_state *state =3D state_;
 	if (!state->lost_bucket)
@@ -433,7 +433,7 @@ static void combine_diff(struct repository *r,
 	xdemitconf_t xecfg;
 	mmfile_t parent_file;
 	struct combine_diff_state state;
-	unsigned long sz;
+	size_t sz;

 	if (result_deleted)
 		return; /* result deleted */
@@ -1016,7 +1016,8 @@ static void show_patch_diff(struct combine_diff_path=
 *elem, int num_parent,
 			    struct rev_info *rev)
 {
 	struct diff_options *opt =3D &rev->diffopt;
-	unsigned long result_size, cnt, lno;
+	unsigned long cnt, lno;
+	size_t result_size;
 	int result_deleted =3D 0;
 	char *result, *cp;
 	struct sline *sline; /* survived lines */
@@ -1134,7 +1135,7 @@ static void show_patch_diff(struct combine_diff_path=
 *elem, int num_parent,
 		is_binary =3D buffer_is_binary(result, result_size);
 		for (i =3D 0; !is_binary && i < num_parent; i++) {
 			char *buf;
-			unsigned long size;
+			size_t size;
 			buf =3D grab_blob(opt->repo,
 					&elem->parent[i].oid,
 					elem->parent[i].mode,
diff --git a/commit.c b/commit.c
index a5333c7ac6..b9d8793910 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -260,7 +260,7 @@ int unregister_shallow(const struct object_id *oid)

 struct commit_buffer {
 	void *buffer;
-	unsigned long size;
+	size_t size;
 };
 define_commit_slab(buffer_slab, struct commit_buffer);

@@ -277,7 +277,7 @@ void free_commit_buffer_slab(struct buffer_slab *bs)
 	free(bs);
 }

-void set_commit_buffer(struct repository *r, struct commit *commit, void =
*buffer, unsigned long size)
+void set_commit_buffer(struct repository *r, struct commit *commit, void =
*buffer, size_t size)
 {
 	struct commit_buffer *v =3D buffer_slab_at(
 		r->parsed_objects->buffer_slab, commit);
@@ -285,7 +285,7 @@ void set_commit_buffer(struct repository *r, struct co=
mmit *commit, void *buffer
 	v->size =3D size;
 }

-const void *get_cached_commit_buffer(struct repository *r, const struct c=
ommit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(struct repository *r, const struct c=
ommit *commit, size_t *sizep)
 {
 	struct commit_buffer *v =3D buffer_slab_peek(
 		r->parsed_objects->buffer_slab, commit);
@@ -301,12 +301,12 @@ const void *get_cached_commit_buffer(struct reposito=
ry *r, const struct commit *

 const void *repo_get_commit_buffer(struct repository *r,
 				   const struct commit *commit,
-				   unsigned long *sizep)
+				   size_t *sizep)
 {
 	const void *ret =3D get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		ret =3D repo_read_object_file(r, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
@@ -366,7 +366,7 @@ void release_commit_memory(struct parsed_object_pool *=
pool, struct commit *c)
 	c->object.parsed =3D 0;
 }

-const void *detach_commit_buffer(struct commit *commit, unsigned long *si=
zep)
+const void *detach_commit_buffer(struct commit *commit, size_t *sizep)
 {
 	struct commit_buffer *v =3D buffer_slab_peek(
 		the_repository->parsed_objects->buffer_slab, commit);
@@ -386,7 +386,7 @@ const void *detach_commit_buffer(struct commit *commit=
, unsigned long *sizep)
 	return ret;
 }

-int parse_commit_buffer(struct repository *r, struct commit *item, const =
void *buffer, unsigned long size, int check_graph)
+int parse_commit_buffer(struct repository *r, struct commit *item, const =
void *buffer, size_t size, int check_graph)
 {
 	const char *tail =3D buffer;
 	const char *bufptr =3D buffer;
@@ -455,7 +455,7 @@ int repo_parse_commit_internal(struct repository *r,
 {
 	enum object_type type;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	int ret;

 	if (!item)
@@ -976,7 +976,7 @@ int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature)
 {

-	unsigned long size;
+	size_t size;
 	const char *buffer =3D get_commit_buffer(commit, &size);
 	int in_signature, saw_signature =3D -1;
 	const char *line, *tail;
@@ -1051,7 +1051,7 @@ static void handle_signed_tag(struct commit *parent,=
 struct commit_extra_header
 	struct merge_remote_desc *desc;
 	struct commit_extra_header *mergetag;
 	char *buf;
-	unsigned long size, len;
+	size_t size, len;
 	enum object_type type;

 	desc =3D merge_remote_util(parent);
@@ -1158,7 +1158,7 @@ struct commit_extra_header *read_commit_extra_header=
s(struct commit *commit,
 						      const char **exclude)
 {
 	struct commit_extra_header *extra =3D NULL;
-	unsigned long size;
+	size_t size;
 	const char *buffer =3D get_commit_buffer(commit, &size);
 	extra =3D read_commit_extra_header_lines(buffer, size, exclude);
 	unuse_commit_buffer(commit, buffer);
diff --git a/commit.h b/commit.h
index 42728c2906..bcf3227b85 100644
=2D-- a/commit.h
+++ b/commit.h
@@ -79,7 +79,7 @@ struct commit *lookup_commit_reference_by_name(const cha=
r *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const ch=
ar *ref_name);

-int parse_commit_buffer(struct repository *r, struct commit *item, const =
void *buffer, unsigned long size, int check_graph);
+int parse_commit_buffer(struct repository *r, struct commit *item, const =
void *buffer, size_t size, int check_graph);
 int repo_parse_commit_internal(struct repository *r, struct commit *item,
 			       int quiet_on_missing, int use_commit_graph);
 int repo_parse_commit_gently(struct repository *r,
@@ -105,13 +105,13 @@ void free_commit_buffer_slab(struct buffer_slab *bs)=
;
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct repository *r, struct commit *, void *buffe=
r, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffe=
r, size_t size);

 /*
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(struct repository *, const struct co=
mmit *, unsigned long *size);
+const void *get_cached_commit_buffer(struct repository *, const struct co=
mmit *, size_t *size);

 /*
  * Get the commit's object contents, either from cache or by reading the =
object
@@ -120,7 +120,7 @@ const void *get_cached_commit_buffer(struct repository=
 *, const struct commit *,
  */
 const void *repo_get_commit_buffer(struct repository *r,
 				   const struct commit *,
-				   unsigned long *size);
+				   size_t *size);
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define get_commit_buffer(c, s) repo_get_commit_buffer(the_repository, c,=
 s)
 #endif
@@ -156,7 +156,7 @@ void release_commit_memory(struct parsed_object_pool *=
pool, struct commit *c);
  * Disassociate any cached object buffer from the commit, but do not free=
 it.
  * The buffer (or NULL, if none) is returned.
  */
-const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
+const void *detach_commit_buffer(struct commit *, size_t *sizep);

 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
diff --git a/config.c b/config.c
index 0f0cdd8c0f..d83e4eb4ae 100644
=2D-- a/config.c
+++ b/config.c
@@ -1596,7 +1596,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;

 	buf =3D read_object_file(oid, &type, &size);
diff --git a/convert.c b/convert.c
index 94ff837649..a8f94eec73 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -42,9 +42,9 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };

-static void gather_stats(const char *buf, unsigned long size, struct text=
_stat *stats)
+static void gather_stats(const char *buf, size_t size, struct text_stat *=
stats)
 {
-	unsigned long i;
+	size_t i;

 	memset(stats, 0, sizeof(*stats));

@@ -102,7 +102,7 @@ static int convert_is_binary(const struct text_stat *s=
tats)
 	return 0;
 }

-static unsigned int gather_convert_stats(const char *data, unsigned long =
size)
+static unsigned int gather_convert_stats(const char *data, size_t size)
 {
 	struct text_stat stats;
 	int ret =3D 0;
@@ -119,7 +119,7 @@ static unsigned int gather_convert_stats(const char *d=
ata, unsigned long size)
 	return ret;
 }

-static const char *gather_convert_stats_ascii(const char *data, unsigned =
long size)
+static const char *gather_convert_stats_ascii(const char *data, size_t si=
ze)
 {
 	unsigned int convert_stats =3D gather_convert_stats(data, size);

@@ -141,7 +141,7 @@ const char *get_cached_convert_stats_ascii(const struc=
t index_state *istate,
 					   const char *path)
 {
 	const char *ret;
-	unsigned long sz;
+	size_t sz;
 	void *data =3D read_blob_data_from_index(istate, path, &sz);
 	ret =3D gather_convert_stats_ascii(data, sz);
 	free(data);
@@ -223,7 +223,7 @@ static void check_global_conv_flags_eol(const char *pa=
th, enum crlf_action crlf_

 static int has_crlf_in_index(const struct index_state *istate, const char=
 *path)
 {
-	unsigned long sz;
+	size_t sz;
 	void *data;
 	const char *crp;
 	int has_crlf =3D 0;
@@ -629,7 +629,7 @@ static int crlf_to_worktree(const char *src, size_t le=
n,

 struct filter_params {
 	const char *src;
-	unsigned long size;
+	size_t size;
 	int fd;
 	const char *cmd;
 	const char *path;
@@ -1048,7 +1048,7 @@ static int read_convert_config(const char *var, cons=
t char *value, void *cb)
 	return 0;
 }

-static int count_ident(const char *cp, unsigned long size)
+static int count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=3D> "$Id$"
diff --git a/delta.h b/delta.h
index 9b67531dfa..541171230c 100644
=2D-- a/delta.h
+++ b/delta.h
@@ -42,8 +42,8 @@ extern unsigned long sizeof_delta_index(struct delta_ind=
ex *index);
  */
 extern void *
 create_delta(const struct delta_index *index,
-	     const void *buf, unsigned long bufsize,
-	     unsigned long *delta_size, unsigned long max_delta_size);
+	     const void *buf, size_t bufsize,
+	     size_t *delta_size, size_t max_delta_size);

 /*
  * diff_delta: create a delta from source buffer to target buffer
@@ -54,9 +54,9 @@ create_delta(const struct delta_index *index,
  * updated with its size.  The returned buffer must be freed by the calle=
r.
  */
 static inline void *
-diff_delta(const void *src_buf, unsigned long src_bufsize,
-	   const void *trg_buf, unsigned long trg_bufsize,
-	   unsigned long *delta_size, unsigned long max_delta_size)
+diff_delta(const void *src_buf, size_t src_bufsize,
+	   const void *trg_buf, size_t trg_bufsize,
+	   size_t *delta_size, size_t max_delta_size)
 {
 	struct delta_index *index =3D create_delta_index(src_buf, src_bufsize);
 	if (index) {
@@ -75,9 +75,9 @@ diff_delta(const void *src_buf, unsigned long src_bufsiz=
e,
  * *trg_bufsize is updated with its size.  On failure a NULL pointer is
  * returned.  The returned buffer must be freed by the caller.
  */
-extern void *patch_delta(const void *src_buf, unsigned long src_size,
-			 const void *delta_buf, unsigned long delta_size,
-			 unsigned long *dst_size);
+extern void *patch_delta(const void *src_buf, size_t src_size,
+			 const void *delta_buf, size_t delta_size,
+			 size_t *dst_size);

 /* the smallest possible delta size is 4 bytes */
 #define DELTA_SIZE_MIN	4
@@ -86,11 +86,11 @@ extern void *patch_delta(const void *src_buf, unsigned=
 long src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-static inline unsigned long get_delta_hdr_size(const unsigned char **data=
p,
+static inline size_t get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
 {
 	const unsigned char *data =3D *datap;
-	unsigned long cmd, size =3D 0;
+	size_t cmd, size =3D 0;
 	int i =3D 0;
 	do {
 		cmd =3D *data++;
diff --git a/diff-delta.c b/diff-delta.c
index e49643353b..072a5ca839 100644
=2D-- a/diff-delta.c
+++ b/diff-delta.c
@@ -316,8 +316,8 @@ unsigned long sizeof_delta_index(struct delta_index *i=
ndex)

 void *
 create_delta(const struct delta_index *index,
-	     const void *trg_buf, unsigned long trg_size,
-	     unsigned long *delta_size, unsigned long max_size)
+	     const void *trg_buf, size_t trg_size,
+	     size_t *delta_size, size_t max_size)
 {
 	unsigned int i, val;
 	off_t outpos, moff;
diff --git a/diff.c b/diff.c
index ec5c095199..adaecfb2b9 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2322,7 +2322,7 @@ static void find_lno(const char *line, struct emit_c=
allback *ecbdata)
 	ecbdata->lno_in_postimage =3D strtol(p + 1, NULL, 10);
 }

-static void fn_out_consume(void *priv, char *line, unsigned long len)
+static void fn_out_consume(void *priv, char *line, size_t len)
 {
 	struct emit_callback *ecbdata =3D priv;
 	struct diff_options *o =3D ecbdata->opt;
@@ -2524,7 +2524,7 @@ static struct diffstat_file *diffstat_add(struct dif=
fstat_t *diffstat,
 	return x;
 }

-static void diffstat_consume(void *priv, char *line, unsigned long len)
+static void diffstat_consume(void *priv, char *line, size_t len)
 {
 	struct diffstat_t *diffstat =3D priv;
 	struct diffstat_file *x =3D diffstat->files[diffstat->nr - 1];
@@ -3204,7 +3204,7 @@ static void checkdiff_consume_hunk(void *priv,
 	data->lineno =3D nb - 1;
 }

-static void checkdiff_consume(void *priv, char *line, unsigned long len)
+static void checkdiff_consume(void *priv, char *line, size_t len)
 {
 	struct checkdiff_t *data =3D priv;
 	int marker_size =3D data->conflict_marker_size;
@@ -3243,8 +3243,8 @@ static void checkdiff_consume(void *priv, char *line=
, unsigned long len)
 }

 static unsigned char *deflate_it(char *data,
-				 unsigned long size,
-				 unsigned long *result_size)
+				 size_t size,
+				 size_t *result_size)
 {
 	int bound;
 	unsigned char *deflated;
@@ -3272,10 +3272,10 @@ static void emit_binary_diff_body(struct diff_opti=
ons *o,
 	void *delta;
 	void *deflated;
 	void *data;
-	unsigned long orig_size;
-	unsigned long delta_size;
-	unsigned long deflate_size;
-	unsigned long data_size;
+	size_t orig_size;
+	size_t delta_size;
+	size_t deflate_size;
+	size_t data_size;

 	/* We could do deflated delta, or we could do just deflated two,
 	 * whichever is smaller.
@@ -4063,7 +4063,7 @@ void diff_free_filespec_data(struct diff_filespec *s=
)
 static void prep_temp_blob(struct index_state *istate,
 			   const char *path, struct diff_tempfile *temp,
 			   void *blob,
-			   unsigned long size,
+			   size_t size,
 			   const struct object_id *oid,
 			   int mode)
 {
@@ -5863,9 +5863,9 @@ struct patch_id_t {
 	int patchlen;
 };

-static int remove_space(char *line, int len)
+static size_t remove_space(char *line, size_t len)
 {
-	int i;
+	size_t i;
 	char *dst =3D line;
 	unsigned char c;

@@ -5876,10 +5876,10 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }

-static void patch_id_consume(void *priv, char *line, unsigned long len)
+static void patch_id_consume(void *priv, char *line, size_t len)
 {
 	struct patch_id_t *data =3D priv;
-	int new_len;
+	size_t new_len;

 	new_len =3D remove_space(line, len);

@@ -6642,7 +6642,7 @@ int textconv_object(struct repository *r,
 		    const struct object_id *oid,
 		    int oid_valid,
 		    char **buf,
-		    unsigned long *buf_size)
+		    size_t *buf_size)
 {
 	struct diff_filespec *df;
 	struct userdiff_driver *textconv;
diff --git a/diff.h b/diff.h
index c9db9825bb..9aba0ade75 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -477,7 +477,7 @@ int textconv_object(struct repository *repo,
 		    const char *path,
 		    unsigned mode,
 		    const struct object_id *oid, int oid_valid,
-		    char **buf, unsigned long *buf_size);
+		    char **buf, size_t *buf_size);

 int parse_rename_score(const char **cp_p);

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a9c6d60df2..7d15d4ecb9 100644
=2D-- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -19,7 +19,7 @@ struct diffgrep_cb {
 	int hit;
 };

-static void diffgrep_consume(void *priv, char *line, unsigned long len)
+static void diffgrep_consume(void *priv, char *line, size_t len)
 {
 	struct diffgrep_cb *data =3D priv;
 	regmatch_t regmatch;
@@ -71,7 +71,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
-	unsigned long sz;
+	size_t sz;
 	const char *data;

 	sz =3D mf->size;
diff --git a/diffcore.h b/diffcore.h
index b651061c0e..b47778dd36 100644
=2D-- a/diffcore.h
+++ b/diffcore.h
@@ -33,7 +33,7 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
-	unsigned long size;
+	size_t size;
 	int count;               /* Reference count */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
diff --git a/dir.c b/dir.c
index b2cabadf25..a59b99d516 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -182,7 +182,7 @@ static size_t common_prefix_len(const struct pathspec =
*pathspec)
  */
 char *common_prefix(const struct pathspec *pathspec)
 {
-	unsigned long len =3D common_prefix_len(pathspec);
+	size_t len =3D common_prefix_len(pathspec);

 	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
 }
@@ -238,7 +238,7 @@ static int do_read_blob(const struct object_id *oid, s=
truct oid_stat *oid_stat,
 			size_t *size_out, char **data_out)
 {
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	char *data;

 	*size_out =3D 0;
@@ -2825,7 +2825,7 @@ static void load_oid_stat(struct oid_stat *oid_stat,=
 const unsigned char *data,
 	oid_stat->valid =3D 1;
 }

-struct untracked_cache *read_untracked_extension(const void *data, unsign=
ed long sz)
+struct untracked_cache *read_untracked_extension(const void *data, size_t=
 sz)
 {
 	struct untracked_cache *uc;
 	struct read_data rd;
diff --git a/dir.h b/dir.h
index e3ec26143d..7dc741cd41 100644
=2D-- a/dir.h
+++ b/dir.h
@@ -360,7 +360,7 @@ void untracked_cache_remove_from_index(struct index_st=
ate *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);

 void free_untracked_cache(struct untracked_cache *);
-struct untracked_cache *read_untracked_extension(const void *data, unsign=
ed long sz);
+struct untracked_cache *read_untracked_extension(const void *data, size_t=
 sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache=
 *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
diff --git a/entry.c b/entry.c
index 0e4f2f2910..fa9802e73a 100644
=2D-- a/entry.c
+++ b/entry.c
@@ -83,7 +83,7 @@ static int create_file(const char *path, unsigned int mo=
de)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }

-static void *read_blob_entry(const struct cache_entry *ce, unsigned long =
*size)
+static void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
 	void *blob_data =3D read_object_file(&ce->oid, &type, size);
@@ -259,7 +259,7 @@ static int write_entry(struct cache_entry *ce,
 	int fd, ret, fstat_done =3D 0;
 	char *new_blob;
 	struct strbuf buf =3D STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	ssize_t wrote;
 	size_t newsize =3D 0;
 	struct stat st;
diff --git a/fast-import.c b/fast-import.c
index b7ba755c2b..adb09ef10e 100644
=2D-- a/fast-import.c
+++ b/fast-import.c
@@ -895,7 +895,7 @@ static int store_object(
 	struct object_entry *e;
 	unsigned char hdr[96];
 	struct object_id oid;
-	unsigned long hdrlen, deltalen;
+	size_t hdrlen, deltalen;
 	git_hash_ctx c;
 	git_zstream s;

@@ -1036,7 +1036,7 @@ static void stream_blob(uintmax_t len, struct object=
_id *oidout, uintmax_t mark)
 	unsigned char *out_buf =3D xmalloc(out_sz);
 	struct object_entry *e;
 	struct object_id oid;
-	unsigned long hdrlen;
+	size_t hdrlen;
 	off_t offset;
 	git_hash_ctx c;
 	git_zstream s;
@@ -1154,7 +1154,7 @@ static void stream_blob(uintmax_t len, struct object=
_id *oidout, uintmax_t mark)
  */
 static void *gfi_unpack_entry(
 	struct object_entry *oe,
-	unsigned long *sizep)
+	size_t *sizep)
 {
 	enum object_type type;
 	struct packed_git *p =3D all_packs[oe->pack_id];
@@ -1200,7 +1200,7 @@ static void load_tree(struct tree_entry *root)
 	struct object_id *oid =3D &root->versions[1].oid;
 	struct object_entry *myoe;
 	struct tree_content *t;
-	unsigned long size;
+	size_t size;
 	char *buf;
 	const char *c;

@@ -1873,7 +1873,7 @@ static int validate_raw_date(const char *src, struct=
 strbuf *result)
 {
 	const char *orig_src =3D src;
 	char *endp;
-	unsigned long num;
+	size_t num;

 	errno =3D 0;

@@ -2400,7 +2400,7 @@ static void note_change_n(const char *p, struct bran=
ch *b, unsigned char *old_fa
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!get_oid(p, &commit_oid)) {
-		unsigned long size;
+		size_t size;
 		char *buf =3D read_object_with_reference(&commit_oid,
 						       commit_type, &size,
 						       &commit_oid);
@@ -2453,7 +2453,7 @@ static void file_change_deleteall(struct branch *b)
 	b->num_notes =3D 0;
 }

-static void parse_from_commit(struct branch *b, char *buf, unsigned long =
size)
+static void parse_from_commit(struct branch *b, char *buf, size_t size)
 {
 	if (!buf || size < GIT_SHA1_HEXSZ + 6)
 		die("Not a valid commit: %s", oid_to_hex(&b->oid));
@@ -2470,7 +2470,7 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[0].oid);
 		oidclr(&b->branch_tree.versions[1].oid);
 	} else {
-		unsigned long size;
+		size_t size;
 		char *buf;

 		buf =3D read_object_with_reference(&b->oid, commit_type, &size,
@@ -2507,7 +2507,7 @@ static int parse_from(struct branch *b)
 		if (!oideq(&b->oid, &oe->idx.oid)) {
 			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id !=3D MAX_PACK_ID) {
-				unsigned long size;
+				size_t size;
 				char *buf =3D gfi_unpack_entry(oe, &size);
 				parse_from_commit(b, buf, size);
 				free(buf);
@@ -2550,7 +2550,7 @@ static struct hash_list *parse_merge(unsigned int *c=
ount)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!get_oid(from, &n->oid)) {
-			unsigned long size;
+			size_t size;
 			char *buf =3D read_object_with_reference(&n->oid,
 							       commit_type,
 							       &size, &n->oid);
@@ -2776,7 +2776,7 @@ static void parse_reset_branch(const char *arg)
 		unread_command_buf =3D 1;
 }

-static void cat_blob_write(const char *buf, unsigned long size)
+static void cat_blob_write(const char *buf, size_t size)
 {
 	if (write_in_full(cat_blob_fd, buf, size) < 0)
 		die_errno("Write to frontend failed");
@@ -2785,7 +2785,7 @@ static void cat_blob_write(const char *buf, unsigned=
 long size)
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
 {
 	struct strbuf line =3D STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	enum object_type type =3D 0;
 	char *buf;

@@ -2869,7 +2869,7 @@ static void parse_cat_blob(const char *p)
 static struct object_entry *dereference(struct object_entry *oe,
 					struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	char *buf =3D NULL;
 	if (!oe) {
 		enum object_type type =3D oid_object_info(the_repository, oid,
diff --git a/fsck.c b/fsck.c
index 2260adb71e..542b6d0a11 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -850,7 +850,7 @@ static int fsck_commit_buffer(struct commit *commit, c=
onst char *buffer,
 }

 static int fsck_commit(struct commit *commit, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	const char *buffer =3D data ?  data : get_commit_buffer(commit, &size);
 	int ret =3D fsck_commit_buffer(commit, buffer, size, options);
@@ -860,7 +860,7 @@ static int fsck_commit(struct commit *commit, const ch=
ar *data,
 }

 static int fsck_tag_buffer(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	struct object_id oid;
 	int ret =3D 0;
@@ -955,7 +955,7 @@ static int fsck_tag_buffer(struct tag *tag, const char=
 *data,
 }

 static int fsck_tag(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	struct object *tagged =3D tag->tagged;

@@ -1006,7 +1006,7 @@ static int fsck_gitmodules_fn(const char *var, const=
 char *value, void *vdata)
 }

 static int fsck_blob(struct blob *blob, const char *buf,
-		     unsigned long size, struct fsck_options *options)
+		     size_t size, struct fsck_options *options)
 {
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts =3D { 0 };
@@ -1042,7 +1042,7 @@ static int fsck_blob(struct blob *blob, const char *=
buf,
 	return data.ret;
 }

-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options)
 {
 	if (!obj)
@@ -1084,7 +1084,7 @@ int fsck_finish(struct fsck_options *options)
 	while ((oid =3D oidset_iter_next(&iter))) {
 		struct blob *blob;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf;

 		if (oidset_contains(&gitmodules_done, oid))
diff --git a/fsck.h b/fsck.h
index b95595ae5f..939ccf856b 100644
=2D-- a/fsck.h
+++ b/fsck.h
@@ -53,7 +53,7 @@ struct fsck_options {
  */
 int fsck_walk(struct object *obj, void *data, struct fsck_options *option=
s);
 /* If NULL is passed for data, we assume the object is local and read it.=
 */
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options);

 /*
diff --git a/fuzz-pack-headers.c b/fuzz-pack-headers.c
index 99da1d0fd3..d04e264e23 100644
=2D-- a/fuzz-pack-headers.c
+++ b/fuzz-pack-headers.c
@@ -5,10 +5,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t s=
ize);
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	enum object_type type;
-	unsigned long len;
+	size_t len;

 	unpack_object_header_buffer((const unsigned char *)data,
-				    (unsigned long)size, &type, &len);
+				    size, &type, &len);

 	return 0;
 }
diff --git a/grep.h b/grep.h
index fb04893721..5765213f4b 100644
=2D-- a/grep.h
+++ b/grep.h
@@ -209,7 +209,7 @@ struct grep_source {
 	void *identifier;

 	char *buf;
-	unsigned long size;
+	size_t size;

 	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
diff --git a/http-push.c b/http-push.c
index b22c7caea0..1de36435e5 100644
=2D-- a/http-push.c
+++ b/http-push.c
@@ -359,7 +359,7 @@ static void start_put(struct transfer_request *request=
)
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
-	unsigned long len;
+	size_t len;
 	int hdrlen;
 	ssize_t size;
 	git_zstream stream;
diff --git a/list-objects-filter.c b/list-objects-filter.c
index ee449de3f7..f12bfd0a30 100644
=2D-- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -236,7 +236,7 @@ static enum list_objects_filter_result filter_blobs_li=
mit(
 	void *filter_data_)
 {
 	struct filter_blobs_limit_data *filter_data =3D filter_data_;
-	unsigned long object_length;
+	size_t object_length;
 	enum object_type t;

 	switch (filter_situation) {
diff --git a/mailmap.c b/mailmap.c
index 962fd86d6d..ec7ba47eef 100644
=2D-- a/mailmap.c
+++ b/mailmap.c
@@ -217,7 +217,7 @@ static int read_mailmap_blob(struct string_list *map,
 {
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;

 	if (!name)
diff --git a/match-trees.c b/match-trees.c
index ddc4d39845..4cfb556589 100644
=2D-- a/match-trees.c
+++ b/match-trees.c
@@ -53,7 +53,7 @@ static void *fill_tree_desc_strict(struct tree_desc *des=
c,
 {
 	void *buffer;
 	enum object_type type;
-	unsigned long size;
+	size_t size;

 	buffer =3D read_object_file(hash, &type, &size);
 	if (!buffer)
@@ -175,7 +175,7 @@ static int splice_tree(const struct object_id *oid1, c=
onst char *prefix,
 	char *subpath;
 	int toplen;
 	char *buf;
-	unsigned long sz;
+	size_t sz;
 	struct tree_desc desc;
 	unsigned char *rewrite_here;
 	const struct object_id *rewrite_with;
diff --git a/merge-blobs.c b/merge-blobs.c
index ee0a0e90c9..f19ee015cc 100644
=2D-- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -9,7 +9,7 @@
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
 	void *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;

 	buf =3D read_object_file(&obj->object.oid, &type, &size);
@@ -34,7 +34,7 @@ static void *three_way_filemerge(struct index_state *ist=
ate,
 				 mmfile_t *base,
 				 mmfile_t *our,
 				 mmfile_t *their,
-				 unsigned long *size)
+				 size_t *size)
 {
 	int merge_status;
 	mmbuffer_t res;
@@ -57,7 +57,7 @@ static void *three_way_filemerge(struct index_state *ist=
ate,

 void *merge_blobs(struct index_state *istate, const char *path,
 		  struct blob *base, struct blob *our,
-		  struct blob *their, unsigned long *size)
+		  struct blob *their, size_t *size)
 {
 	void *res =3D NULL;
 	mmfile_t f1, f2, common;
diff --git a/merge-blobs.h b/merge-blobs.h
index cc31038b80..7f37952b0e 100644
=2D-- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -6,6 +6,6 @@ struct index_state;

 extern void *merge_blobs(struct index_state *, const char *,
 			 struct blob *, struct blob *,
-			 struct blob *, unsigned long *);
+			 struct blob *, size_t *);

 #endif /* MERGE_BLOBS_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c40c61c47..d2e2f6642c 100644
=2D-- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -961,7 +961,7 @@ static int update_file_flags(struct merge_options *o,
 	if (update_wd) {
 		enum object_type type;
 		void *buf;
-		unsigned long size;
+		size_t size;

 		if (S_ISGITLINK(mode)) {
 			/*
@@ -3012,7 +3012,7 @@ static int read_oid_strbuf(struct merge_options *o,
 {
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	buf =3D read_object_file(oid, &type, &size);
 	if (!buf)
 		return err(o, _("cannot read object %s"), oid_to_hex(oid));
diff --git a/notes-cache.c b/notes-cache.c
index 2473314d68..7914f1073f 100644
=2D-- a/notes-cache.c
+++ b/notes-cache.c
@@ -76,7 +76,7 @@ char *notes_cache_get(struct notes_cache *c, struct obje=
ct_id *key_oid,
 	const struct object_id *value_oid;
 	enum object_type type;
 	char *value;
-	unsigned long size;
+	size_t size;

 	value_oid =3D get_note(&c->tree, key_oid);
 	if (!value_oid)
diff --git a/notes-merge.c b/notes-merge.c
index 280aa8e6c1..c2be818112 100644
=2D-- a/notes-merge.c
+++ b/notes-merge.c
@@ -297,7 +297,7 @@ static void check_notes_merge_worktree(struct notes_me=
rge_options *o)
 }

 static void write_buf_to_worktree(const struct object_id *obj,
-				  const char *buf, unsigned long size)
+				  const char *buf, size_t size)
 {
 	int fd;
 	char *path =3D git_pathdup(NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
@@ -326,7 +326,7 @@ static void write_note_to_worktree(const struct object=
_id *obj,
 				   const struct object_id *note)
 {
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buf =3D read_object_file(note, &type, &size);

 	if (!buf)
diff --git a/notes.c b/notes.c
index 7f7cc4d511..e13f986e48 100644
=2D-- a/notes.c
+++ b/notes.c
@@ -791,7 +791,7 @@ int combine_notes_concatenate(struct object_id *cur_oi=
d,
 			      const struct object_id *new_oid)
 {
 	char *cur_msg =3D NULL, *new_msg =3D NULL, *buf;
-	unsigned long cur_len, new_len, buf_len;
+	size_t cur_len, new_len, buf_len;
 	enum object_type cur_type, new_type;
 	int ret;

@@ -852,7 +852,7 @@ static int string_list_add_note_lines(struct string_li=
st *list,
 				      const struct object_id *oid)
 {
 	char *data;
-	unsigned long len;
+	size_t len;
 	enum object_type t;

 	if (is_null_oid(oid))
@@ -1206,7 +1206,7 @@ static void format_note(struct notes_tree *t, const =
struct object_id *object_oid
 	static const char utf8[] =3D "utf-8";
 	const struct object_id *oid;
 	char *msg, *msg_p;
-	unsigned long linelen, msglen;
+	size_t linelen, msglen;
 	enum object_type type;

 	if (!t)
diff --git a/object-store.h b/object-store.h
index 14fc935bd1..21708e1aa3 100644
=2D-- a/object-store.h
+++ b/object-store.h
@@ -139,7 +139,7 @@ struct raw_object_store {
 	 * These two fields are not meant for direct access. Use
 	 * approximate_object_count() instead.
 	 */
-	unsigned long approximate_object_count;
+	size_t approximate_object_count;
 	unsigned approximate_object_count_valid : 1;

 	/*
@@ -160,16 +160,16 @@ const char *loose_object_path(struct repository *r, =
struct strbuf *buf,
 			      const struct object_id *oid);

 void *map_loose_object(struct repository *r, const struct object_id *oid,
-		       unsigned long *size);
+		       size_t *size);

 extern void *read_object_file_extended(struct repository *r,
 				       const struct object_id *oid,
 				       enum object_type *type,
-				       unsigned long *size, int lookup_replace);
+				       size_t *size, int lookup_replace);
 static inline void *repo_read_object_file(struct repository *r,
 					  const struct object_id *oid,
 					  enum object_type *type,
-					  unsigned long *size)
+					  size_t *size)
 {
 	return read_object_file_extended(r, oid, type, size, 1);
 }
@@ -178,19 +178,19 @@ static inline void *repo_read_object_file(struct rep=
ository *r,
 #endif

 /* Read and unpack an object file into memory, write memory to an object =
file */
-int oid_object_info(struct repository *r, const struct object_id *, unsig=
ned long *);
+int oid_object_info(struct repository *r, const struct object_id *, size_=
t *);

-extern int hash_object_file(const void *buf, unsigned long len,
+extern int hash_object_file(const void *buf, size_t len,
 			    const char *type, struct object_id *oid);

-extern int write_object_file(const void *buf, unsigned long len,
+extern int write_object_file(const void *buf, size_t len,
 			     const char *type, struct object_id *oid);

-extern int hash_object_file_literally(const void *buf, unsigned long len,
+extern int hash_object_file_literally(const void *buf, size_t len,
 				      const char *type, struct object_id *oid,
 				      unsigned flags);

-extern int pretend_object_file(void *, unsigned long, enum object_type,
+extern int pretend_object_file(void *, size_t, enum object_type,
 			       struct object_id *oid);

 extern int force_object_loose(const struct object_id *oid, time_t mtime);
@@ -205,7 +205,7 @@ extern int force_object_loose(const struct object_id *=
oid, time_t mtime);
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
-		      unsigned long *size,
+		      size_t *size,
 		      void **contents);

 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
@@ -234,7 +234,7 @@ extern void assert_oid_type(const struct object_id *oi=
d, enum object_type expect
 struct object_info {
 	/* Request */
 	enum object_type *typep;
-	unsigned long *sizep;
+	size_t *sizep;
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *type_name;
diff --git a/object.c b/object.c
index e81d47a79c..e0d6575609 100644
=2D-- a/object.c
+++ b/object.c
@@ -187,7 +187,7 @@ struct object *lookup_unknown_object(const unsigned ch=
ar *sha1)
 	return obj;
 }

-struct object *parse_object_buffer(struct repository *r, const struct obj=
ect_id *oid, enum object_type type, unsigned long size, void *buffer, int =
*eaten_p)
+struct object *parse_object_buffer(struct repository *r, const struct obj=
ect_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_=
p)
 {
 	struct object *obj;
 	*eaten_p =3D 0;
@@ -249,7 +249,7 @@ struct object *parse_object_or_die(const struct object=
_id *oid,

 struct object *parse_object(struct repository *r, const struct object_id =
*oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int eaten;
 	const struct object_id *repl =3D lookup_replace_object(r, oid);
diff --git a/object.h b/object.h
index 796792cb32..b97a625882 100644
=2D-- a/object.h
+++ b/object.h
@@ -140,7 +140,7 @@ struct object *parse_object_or_die(const struct object=
_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(struct repository *r, const struct obj=
ect_id *oid, enum object_type type, unsigned long size, void *buffer, int =
*eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct obj=
ect_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_=
p);

 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/pack-check.c b/pack-check.c
index 4ff725a89c..b86a5e17b5 100644
=2D-- a/pack-check.c
+++ b/pack-check.c
@@ -108,7 +108,7 @@ static int verify_packfile(struct repository *r,
 	for (i =3D 0; i < nr_objects; i++) {
 		void *data;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		off_t curpos;
 		int data_valid;

diff --git a/pack-objects.h b/pack-objects.h
index 6fde7ce27c..e4843efa35 100644
=2D-- a/pack-objects.h
+++ b/pack-objects.h
@@ -325,9 +325,9 @@ static inline void oe_set_delta_sibling(struct packing=
_data *pack,
 		e->delta_sibling_idx =3D 0;
 }

-unsigned long oe_get_size_slow(struct packing_data *pack,
+size_t oe_get_size_slow(struct packing_data *pack,
 			       const struct object_entry *e);
-static inline unsigned long oe_size(struct packing_data *pack,
+static inline size_t oe_size(struct packing_data *pack,
 				    const struct object_entry *e)
 {
 	if (e->size_valid)
@@ -338,7 +338,7 @@ static inline unsigned long oe_size(struct packing_dat=
a *pack,

 static inline int oe_size_less_than(struct packing_data *pack,
 				    const struct object_entry *lhs,
-				    unsigned long rhs)
+				    size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ < rhs;
@@ -349,7 +349,7 @@ static inline int oe_size_less_than(struct packing_dat=
a *pack,

 static inline int oe_size_greater_than(struct packing_data *pack,
 				       const struct object_entry *lhs,
-				       unsigned long rhs)
+				       size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ > rhs;
@@ -360,7 +360,7 @@ static inline int oe_size_greater_than(struct packing_=
data *pack,

 static inline void oe_set_size(struct packing_data *pack,
 			       struct object_entry *e,
-			       unsigned long size)
+			       size_t size)
 {
 	if (size < pack->oe_size_limit) {
 		e->size_ =3D size;
@@ -372,7 +372,7 @@ static inline void oe_set_size(struct packing_data *pa=
ck,
 	}
 }

-static inline unsigned long oe_delta_size(struct packing_data *pack,
+static inline size_t oe_delta_size(struct packing_data *pack,
 					  const struct object_entry *e)
 {
 	if (e->delta_size_valid)
@@ -391,7 +391,7 @@ static inline unsigned long oe_delta_size(struct packi=
ng_data *pack,

 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
-				     unsigned long size)
+				     size_t size)
 {
 	if (size < pack->oe_delta_size_limit) {
 		e->delta_size_ =3D size;
diff --git a/pack.h b/pack.h
index da99fdd1d2..6f61f83485 100644
=2D-- a/pack.h
+++ b/pack.h
@@ -77,7 +77,7 @@ struct pack_idx_entry {

 struct progress;
 /* Note, the data argument could be NULL if object type is blob */
-typedef int (*verify_fn)(const struct object_id *, enum object_type, unsi=
gned long, void*, int*);
+typedef int (*verify_fn)(const struct object_id *, enum object_type, size=
_t, void*, int*);

 extern const char *write_idx_file(const char *index_name, struct pack_idx=
_entry **objects, int nr_objects, const struct pack_idx_option *, const un=
signed char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_cu=
rs, off_t offset, off_t len, unsigned int nr);
diff --git a/packfile.c b/packfile.c
index 6afd7e30d0..e84bea8d90 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -163,8 +163,8 @@ int load_idx(const char *path, const unsigned int hash=
sz, void *idx_map,
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size =3D 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + h=
ashsz;
-		unsigned long max_size =3D min_size;
+		size_t min_size =3D 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + hashsz;
+		size_t max_size =3D min_size;
 		if (nr)
 			max_size +=3D (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size)
@@ -893,10 +893,10 @@ static void prepare_packed_git(struct repository *r)=
;
  * all unreachable objects about to be pruned, in which case they're not =
really
  * interesting as a measure of repo size in the first place.
  */
-unsigned long approximate_object_count(void)
+size_t approximate_object_count(void)
 {
 	if (!the_repository->objects->approximate_object_count_valid) {
-		unsigned long count;
+		size_t count;
 		struct multi_pack_index *m;
 		struct packed_git *p;

@@ -1044,12 +1044,12 @@ struct list_head *get_packed_git_mru(struct reposi=
tory *r)
 	return &r->objects->packed_git_mru;
 }

-unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+size_t unpack_object_header_buffer(const unsigned char *buf,
+		size_t len, enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
-	unsigned long used =3D 0;
+	size_t size, c;
+	size_t used =3D 0;

 	c =3D buf[used++];
 	*type =3D (c >> 4) & 7;
@@ -1069,7 +1069,7 @@ unsigned long unpack_object_header_buffer(const unsi=
gned char *buf,
 	return used;
 }

-unsigned long get_size_from_delta(struct packed_git *p,
+size_t get_size_from_delta(struct packed_git *p,
 				  struct pack_window **w_curs,
 				  off_t curpos)
 {
@@ -1111,11 +1111,11 @@ unsigned long get_size_from_delta(struct packed_gi=
t *p,
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
-			 unsigned long *sizep)
+			 size_t *sizep)
 {
 	unsigned char *base;
 	size_t left;
-	unsigned long used;
+	size_t used;
 	enum object_type type;

 	/* use_pack() assures us we have [base, base + 20) available
@@ -1266,7 +1266,7 @@ static enum object_type packed_to_object_type(struct=
 repository *r,

 	while (type =3D=3D OBJ_OFS_DELTA || type =3D=3D OBJ_REF_DELTA) {
 		off_t base_offset;
-		unsigned long size;
+		size_t size;
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >=3D poi_stack_alloc && poi_stack =3D=3D small_poi_sta=
ck) {
 			poi_stack_alloc =3D alloc_nr(poi_stack_nr);
@@ -1336,7 +1336,7 @@ struct delta_base_cache_entry {
 	struct delta_base_cache_key key;
 	struct list_head lru;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 };

@@ -1401,7 +1401,7 @@ static void detach_delta_base_cache_entry(struct del=
ta_base_cache_entry *ent)
 }

 static void *cache_or_unpack_entry(struct repository *r, struct packed_gi=
t *p,
-				   off_t base_offset, unsigned long *base_size,
+				   off_t base_offset, size_t *base_size,
 				   enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1434,7 +1434,7 @@ void clear_delta_base_cache(void)
 }

 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
+	void *base, size_t base_size, enum object_type type)
 {
 	struct delta_base_cache_entry *ent =3D xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
@@ -1466,7 +1466,7 @@ int packed_object_info(struct repository *r, struct =
packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs =3D NULL;
-	unsigned long size;
+	size_t size;
 	off_t curpos =3D obj_offset;
 	enum object_type type;

@@ -1551,7 +1551,7 @@ int packed_object_info(struct repository *r, struct =
packed_git *p,
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-				    unsigned long size)
+				    size_t size)
 {
 	int st;
 	git_zstream stream;
@@ -1598,13 +1598,13 @@ int do_check_packed_object_crc;
 struct unpack_entry_stack_ent {
 	off_t obj_offset;
 	off_t curpos;
-	unsigned long size;
+	size_t size;
 };

 static void *read_object(struct repository *r,
 			 const struct object_id *oid,
 			 enum object_type *type,
-			 unsigned long *size)
+			 size_t *size)
 {
 	struct object_info oi =3D OBJECT_INFO_INIT;
 	void *content;
@@ -1618,12 +1618,12 @@ static void *read_object(struct repository *r,
 }

 void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_=
offset,
-		   enum object_type *final_type, unsigned long *final_size)
+		   enum object_type *final_type, size_t *final_size)
 {
 	struct pack_window *w_curs =3D NULL;
 	off_t curpos =3D obj_offset;
 	void *data =3D NULL;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREAL=
LOC];
 	struct unpack_entry_stack_ent *delta_stack =3D small_delta_stack;
@@ -1723,7 +1723,7 @@ void *unpack_entry(struct repository *r, struct pack=
ed_git *p, off_t obj_offset,
 		void *delta_data;
 		void *base =3D data;
 		void *external_base =3D NULL;
-		unsigned long delta_size, base_size =3D size;
+		size_t delta_size, base_size =3D size;
 		int i;

 		data =3D NULL;
diff --git a/packfile.h b/packfile.h
index 7384b4a201..b3082a9079 100644
=2D-- a/packfile.h
+++ b/packfile.h
@@ -57,7 +57,7 @@ struct packed_git *get_all_packs(struct repository *r);
  * Give a rough count of objects in the repository. This sacrifices accur=
acy
  * for speed.
  */
-unsigned long approximate_object_count(void);
+size_t approximate_object_count(void);

 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
@@ -131,10 +131,10 @@ extern off_t nth_packed_object_offset(const struct p=
acked_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed=
_git *);

 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct repository *r, struct packed_git *, off_=
t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf=
, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack=
_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window *=
*, off_t *, unsigned long *);
+extern void *unpack_entry(struct repository *r, struct packed_git *, off_=
t, enum object_type *, size_t *);
+extern size_t unpack_object_header_buffer(const unsigned char *buf, size_=
t len, enum object_type *type, size_t *sizep);
+extern size_t get_size_from_delta(struct packed_git *, struct pack_window=
 **, off_t);
+extern int unpack_object_header(struct packed_git *, struct pack_window *=
*, off_t *, size_t *);

 extern void release_pack_memory(size_t);

diff --git a/patch-delta.c b/patch-delta.c
index b5c8594db6..42199fa956 100644
=2D-- a/patch-delta.c
+++ b/patch-delta.c
@@ -12,13 +12,13 @@
 #include "git-compat-util.h"
 #include "delta.h"

-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size)
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size)
 {
 	const unsigned char *data, *top;
 	unsigned char *dst_buf, *out, cmd;
-	unsigned long size;
+	size_t size;

 	if (delta_size < DELTA_SIZE_MIN)
 		return NULL;
diff --git a/range-diff.c b/range-diff.c
index 48b0e1b4ce..a70499089e 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -192,7 +192,7 @@ static void find_exact_matches(struct string_list *a, =
struct string_list *b)
 	hashmap_free(&map, 0);
 }

-static void diffsize_consume(void *data, char *line, unsigned long len)
+static void diffsize_consume(void *data, char *line, size_t len)
 {
 	(*(int *)data)++;
 }
diff --git a/read-cache.c b/read-cache.c
index 4dc6de1b55..7c6c7505c5 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -227,7 +227,7 @@ static int ce_compare_link(const struct cache_entry *c=
e, size_t expected_size)
 {
 	int match =3D -1;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct strbuf sb =3D STRBUF_INIT;

@@ -1680,7 +1680,7 @@ int verify_index_checksum;
 /* Allow fsck to force verification of the cache entry order. */
 int verify_ce_order;

-static int verify_hdr(const struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, size_t size)
 {
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
@@ -1704,7 +1704,7 @@ static int verify_hdr(const struct cache_header *hdr=
, unsigned long size)
 }

 static int read_index_extension(struct index_state *istate,
-				const char *ext, const char *data, unsigned long sz)
+				const char *ext, const char *data, size_t sz)
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
@@ -1740,7 +1740,7 @@ static int read_index_extension(struct index_state *=
istate,
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
 					    struct ondisk_cache_entry *ondisk,
-					    unsigned long *ent_size,
+					    size_t *ent_size,
 					    const struct cache_entry *previous_ce)
 {
 	struct cache_entry *ce;
@@ -1931,13 +1931,13 @@ struct load_index_extensions
 	struct index_state *istate;
 	const char *mmap;
 	size_t mmap_size;
-	unsigned long src_offset;
+	size_t src_offset;
 };

 static void *load_index_extensions(void *_data)
 {
 	struct load_index_extensions *p =3D _data;
-	unsigned long src_offset =3D p->src_offset;
+	size_t src_offset =3D p->src_offset;

 	while (src_offset <=3D p->mmap_size - the_hash_algo->rawsz - 8) {
 		/* After an array of active_nr index entries,
@@ -1965,17 +1965,17 @@ static void *load_index_extensions(void *_data)
  * A helper function that will load the specified range of cache entries
  * from the memory mapped file and add them to the given index.
  */
-static unsigned long load_cache_entry_block(struct index_state *istate,
+static size_t load_cache_entry_block(struct index_state *istate,
 			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
-			unsigned long start_offset, const struct cache_entry *previous_ce)
+			size_t start_offset, const struct cache_entry *previous_ce)
 {
 	int i;
-	unsigned long src_offset =3D start_offset;
+	size_t src_offset =3D start_offset;

 	for (i =3D offset; i < offset + nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
-		unsigned long consumed;
+		size_t consumed;

 		disk_ce =3D (struct ondisk_cache_entry *)(mmap + src_offset);
 		ce =3D create_from_disk(ce_mem_pool, istate->version, disk_ce, &consume=
d, previous_ce);
@@ -1987,10 +1987,10 @@ static unsigned long load_cache_entry_block(struct=
 index_state *istate,
 	return src_offset - start_offset;
 }

-static unsigned long load_all_cache_entries(struct index_state *istate,
-			const char *mmap, size_t mmap_size, unsigned long src_offset)
+static size_t load_all_cache_entries(struct index_state *istate,
+			const char *mmap, size_t mmap_size, size_t src_offset)
 {
-	unsigned long consumed;
+	size_t consumed;

 	if (istate->version =3D=3D 4) {
 		mem_pool_init(&istate->ce_mem_pool,
@@ -2024,7 +2024,7 @@ struct load_cache_entries_thread_data
 	struct index_entry_offset_table *ieot;
 	int ieot_start;		/* starting index into the ieot array */
 	int ieot_blocks;	/* count of ieot entries to process */
-	unsigned long consumed;	/* return # of bytes in index file processed */
+	size_t consumed;	/* return # of bytes in index file processed */
 };

 /*
@@ -2045,12 +2045,12 @@ static void *load_cache_entries_thread(void *_data=
)
 	return NULL;
 }

-static unsigned long load_cache_entries_threaded(struct index_state *ista=
te, const char *mmap, size_t mmap_size,
-			unsigned long src_offset, int nr_threads, struct index_entry_offset_ta=
ble *ieot)
+static size_t load_cache_entries_threaded(struct index_state *istate, con=
st char *mmap, size_t mmap_size,
+			size_t src_offset, int nr_threads, struct index_entry_offset_table *ie=
ot)
 {
 	int i, offset, ieot_blocks, ieot_start, err;
 	struct load_cache_entries_thread_data *data;
-	unsigned long consumed =3D 0;
+	size_t consumed =3D 0;

 	/* a little sanity checking */
 	if (istate->name_hash_initialized)
@@ -2121,7 +2121,7 @@ int do_read_index(struct index_state *istate, const =
char *path, int must_exist)
 {
 	int fd;
 	struct stat st;
-	unsigned long src_offset;
+	size_t src_offset;
 	const struct cache_header *hdr;
 	const char *mmap;
 	size_t mmap_size;
@@ -2429,7 +2429,7 @@ int repo_index_has_changes(struct repository *repo,

 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
-static unsigned long write_buffer_len;
+static size_t write_buffer_len;

 static int ce_write_flush(git_hash_ctx *context, int fd)
 {
@@ -3066,9 +3066,9 @@ static int write_split_index(struct index_state *ist=
ate,

 static const char *shared_index_expire =3D "2.weeks.ago";

-static unsigned long get_shared_index_expire_date(void)
+static size_t get_shared_index_expire_date(void)
 {
-	static unsigned long shared_index_expire_date;
+	static size_t shared_index_expire_date;
 	static int shared_index_expire_date_prepared;

 	if (!shared_index_expire_date_prepared) {
@@ -3084,7 +3084,7 @@ static unsigned long get_shared_index_expire_date(vo=
id)
 static int should_delete_shared_index(const char *shared_index_path)
 {
 	struct stat st;
-	unsigned long expiration;
+	size_t expiration;

 	/* Check timestamp */
 	expiration =3D get_shared_index_expire_date();
@@ -3325,10 +3325,10 @@ int index_name_is_other(const struct index_state *=
istate, const char *name,
 }

 void *read_blob_data_from_index(const struct index_state *istate,
-				const char *path, unsigned long *size)
+				const char *path, size_t *size)
 {
 	int pos, len;
-	unsigned long sz;
+	size_t sz;
 	enum object_type type;
 	void *data;

diff --git a/ref-filter.c b/ref-filter.c
index 3aca105307..e18e445acf 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -67,7 +67,7 @@ struct refname_atom {
 static struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	off_t disk_size;
 	struct object_id delta_base_oid;
 	void *content;
@@ -1018,7 +1018,7 @@ static const char *copy_email(const char *buf)
 	return xmemdupz(email, eoemail + 1 - email);
 }

-static char *copy_subject(const char *buf, unsigned long len)
+static char *copy_subject(const char *buf, size_t len)
 {
 	char *r =3D xmemdupz(buf, len);
 	int i;
@@ -1128,10 +1128,10 @@ static void grab_person(const char *who, struct at=
om_value *val, int deref, void
 }

 static void find_subpos(const char *buf,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	const char *eol;
 	/* skip past header until we hit empty line */
@@ -1175,7 +1175,7 @@ static void find_subpos(const char *buf,
  * If 'lines' is greater than 0, append that many lines from the given
  * 'buf' of length 'size' to the given strbuf.
  */
-static void append_lines(struct strbuf *out, const char *buf, unsigned lo=
ng size, int lines)
+static void append_lines(struct strbuf *out, const char *buf, size_t size=
, int lines)
 {
 	int i;
 	const char *sp, *eol;
@@ -1200,7 +1200,7 @@ static void grab_sub_body_contents(struct atom_value=
 *val, int deref, void *buf)
 {
 	int i;
 	const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
-	unsigned long sublen =3D 0, bodylen =3D 0, nonsiglen =3D 0, siglen =3D 0=
;
+	size_t sublen =3D 0, bodylen =3D 0, nonsiglen =3D 0, siglen =3D 0;

 	for (i =3D 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom =3D &used_atom[i];
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 3af708c5b6..38f79aaf8a 100644
=2D-- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -56,7 +56,7 @@ static char *read_ref_note(const struct object_id *oid)
 {
 	const struct object_id *note_oid;
 	char *msg =3D NULL;
-	unsigned long msglen;
+	size_t msglen;
 	enum object_type type;

 	init_notes(NULL, notes_ref, NULL, 0);
@@ -105,7 +105,7 @@ static int note2mark_cb(const struct object_id *object=
_oid,
 {
 	FILE *file =3D (FILE *)cb_data;
 	char *msg;
-	unsigned long msglen;
+	size_t msglen;
 	enum object_type type;
 	struct rev_note note;

diff --git a/rerere.c b/rerere.c
index 17abb47321..4e1d525817 100644
=2D-- a/rerere.c
+++ b/rerere.c
@@ -973,7 +973,7 @@ static int handle_cache(struct index_state *istate,

 	while (pos < istate->cache_nr) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;

 		ce =3D istate->cache[pos++];
 		if (ce_namelen(ce) !=3D len || memcmp(ce->name, path, len))
diff --git a/sha1-file.c b/sha1-file.c
index 494606f771..caef36f9b4 100644
=2D-- a/sha1-file.c
+++ b/sha1-file.c
@@ -200,7 +200,7 @@ static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
 	void *buf;
-	unsigned long size;
+	size_t size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;

@@ -871,7 +871,7 @@ void *xmmap(void *start, size_t length,
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(const struct object_id *oid, void *map,
-			   unsigned long size, const char *type)
+			   size_t size, const char *type)
 {
 	struct object_id real_oid;
 	enum object_type obj_type;
@@ -1007,7 +1007,7 @@ static int quick_has_loose(struct repository *r,
  * searching for a loose object named "oid".
  */
 static void *map_loose_object_1(struct repository *r, const char *path,
-			     const struct object_id *oid, unsigned long *size)
+			     const struct object_id *oid, size_t *size)
 {
 	void *map;
 	int fd;
@@ -1037,14 +1037,14 @@ static void *map_loose_object_1(struct repository =
*r, const char *path,

 void *map_loose_object(struct repository *r,
 		       const struct object_id *oid,
-		       unsigned long *size)
+		       size_t *size)
 {
 	return map_loose_object_1(r, NULL, oid, size);
 }

 static int unpack_loose_short_header(git_zstream *stream,
-				     unsigned char *map, unsigned long mapsize,
-				     void *buffer, unsigned long bufsiz)
+				     unsigned char *map, size_t mapsize,
+				     void *buffer, size_t bufsiz)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1058,8 +1058,8 @@ static int unpack_loose_short_header(git_zstream *st=
ream,
 }

 int unpack_loose_header(git_zstream *stream,
-			unsigned char *map, unsigned long mapsize,
-			void *buffer, unsigned long bufsiz)
+			unsigned char *map, size_t mapsize,
+			void *buffer, size_t bufsiz)
 {
 	int status =3D unpack_loose_short_header(stream, map, mapsize,
 					       buffer, bufsiz);
@@ -1074,8 +1074,8 @@ int unpack_loose_header(git_zstream *stream,
 }

 static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned ch=
ar *map,
-					 unsigned long mapsize, void *buffer,
-					 unsigned long bufsiz, struct strbuf *header)
+					 size_t mapsize, void *buffer,
+					 size_t bufsiz, struct strbuf *header)
 {
 	int status;

@@ -1110,12 +1110,12 @@ static int unpack_loose_header_to_strbuf(git_zstre=
am *stream, unsigned char *map
 }

 static void *unpack_loose_rest(git_zstream *stream,
-			       void *buffer, unsigned long size,
+			       void *buffer, size_t size,
 			       const struct object_id *oid)
 {
 	int bytes =3D strlen(buffer) + 1;
 	unsigned char *buf =3D xmallocz(size);
-	unsigned long n;
+	size_t n;
 	int status =3D Z_OK;

 	n =3D stream->total_out - bytes;
@@ -1165,7 +1165,7 @@ static int parse_loose_header_extended(const char *h=
dr, struct object_info *oi,
 				       unsigned int flags)
 {
 	const char *type_buf =3D hdr;
-	unsigned long size;
+	size_t size;
 	int type, type_len =3D 0;

 	/*
@@ -1205,7 +1205,7 @@ static int parse_loose_header_extended(const char *h=
dr, struct object_info *oi,
 		return -1;
 	if (size) {
 		for (;;) {
-			unsigned long c =3D *hdr - '0';
+			size_t c =3D *hdr - '0';
 			if (c > 9)
 				break;
 			hdr++;
@@ -1222,7 +1222,7 @@ static int parse_loose_header_extended(const char *h=
dr, struct object_info *oi,
 	return *hdr ? -1 : type;
 }

-int parse_loose_header(const char *hdr, unsigned long *sizep)
+int parse_loose_header(const char *hdr, size_t *sizep)
 {
 	struct object_info oi =3D OBJECT_INFO_INIT;

@@ -1235,12 +1235,12 @@ static int loose_object_info(struct repository *r,
 			     struct object_info *oi, int flags)
 {
 	int status =3D 0;
-	unsigned long mapsize;
+	size_t mapsize;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf =3D STRBUF_INIT;
-	unsigned long size_scratch;
+	size_t size_scratch;

 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -1408,7 +1408,7 @@ int oid_object_info_extended(struct repository *r, c=
onst struct object_id *oid,
 /* returns enum object_type or negative */
 int oid_object_info(struct repository *r,
 		    const struct object_id *oid,
-		    unsigned long *sizep)
+		    size_t *sizep)
 {
 	enum object_type type;
 	struct object_info oi =3D OBJECT_INFO_INIT;
@@ -1423,7 +1423,7 @@ int oid_object_info(struct repository *r,

 static void *read_object(struct repository *r,
 			 const struct object_id *oid, enum object_type *type,
-			 unsigned long *size)
+			 size_t *size)
 {
 	struct object_info oi =3D OBJECT_INFO_INIT;
 	void *content;
@@ -1436,7 +1436,7 @@ static void *read_object(struct repository *r,
 	return content;
 }

-int pretend_object_file(void *buf, unsigned long len, enum object_type ty=
pe,
+int pretend_object_file(void *buf, size_t len, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
@@ -1462,7 +1462,7 @@ int pretend_object_file(void *buf, unsigned long len=
, enum object_type type,
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
-				unsigned long *size,
+				size_t *size,
 				int lookup_replace)
 {
 	void *data;
@@ -1498,12 +1498,12 @@ void *read_object_file_extended(struct repository =
*r,

 void *read_object_with_reference(const struct object_id *oid,
 				 const char *required_type_name,
-				 unsigned long *size,
+				 size_t *size,
 				 struct object_id *actual_oid_return)
 {
 	enum object_type type, required_type;
 	void *buffer;
-	unsigned long isize;
+	size_t isize;
 	struct object_id actual_oid;

 	required_type =3D type_from_string(required_type_name);
@@ -1544,7 +1544,7 @@ void *read_object_with_reference(const struct object=
_id *oid,
 	}
 }

-static void write_object_file_prepare(const void *buf, unsigned long len,
+static void write_object_file_prepare(const void *buf, size_t len,
 				      const char *type, struct object_id *oid,
 				      char *hdr, int *hdrlen)
 {
@@ -1610,7 +1610,7 @@ static int write_buffer(int fd, const void *buf, siz=
e_t len)
 	return 0;
 }

-int hash_object_file(const void *buf, unsigned long len, const char *type=
,
+int hash_object_file(const void *buf, size_t len, const char *type,
 		     struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
@@ -1674,7 +1674,7 @@ static int create_tmpfile(struct strbuf *tmp, const =
char *filename)
 }

 static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, const void *buf, size_t len,
 			      time_t mtime)
 {
 	int fd, ret;
@@ -1764,7 +1764,7 @@ static int freshen_packed_object(const struct object=
_id *oid)
 	return 1;
 }

-int write_object_file(const void *buf, unsigned long len, const char *typ=
e,
+int write_object_file(const void *buf, size_t len, const char *type,
 		      struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
@@ -1779,7 +1779,7 @@ int write_object_file(const void *buf, unsigned long=
 len, const char *type,
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }

-int hash_object_file_literally(const void *buf, unsigned long len,
+int hash_object_file_literally(const void *buf, size_t len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags)
 {
@@ -1805,7 +1805,7 @@ int hash_object_file_literally(const void *buf, unsi=
gned long len,
 int force_object_loose(const struct object_id *oid, time_t mtime)
 {
 	void *buf;
-	unsigned long len;
+	size_t len;
 	enum object_type type;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
@@ -2248,14 +2248,14 @@ void odb_clear_loose_cache(struct object_directory=
 *odb)

 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
-			    unsigned long size,
+			    size_t size,
 			    const char *path,
 			    const struct object_id *expected_oid)
 {
 	git_hash_ctx c;
 	struct object_id real_oid;
 	unsigned char buf[4096];
-	unsigned long total_read;
+	size_t total_read;
 	int status =3D Z_OK;

 	the_hash_algo->init_fn(&c);
@@ -2307,12 +2307,12 @@ static int check_stream_oid(git_zstream *stream,
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
-		      unsigned long *size,
+		      size_t *size,
 		      void **contents)
 {
 	int ret =3D -1;
 	void *map =3D NULL;
-	unsigned long mapsize;
+	size_t mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];

diff --git a/sha1dc_git.c b/sha1dc_git.c
index e0cc9d988c..b24fc9af55 100644
=2D-- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -25,7 +25,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *c=
tx)
 /*
  * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
  */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len=
)
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 {
 	const char *data =3D vdata;
 	/* We expect an unsigned long, but sha1dc only takes an int */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 41e1c3fd3f..847b38fb4b 100644
=2D-- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -15,7 +15,7 @@ void git_SHA1DCInit(SHA1_CTX *);
 #endif

 void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len)=
;
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);

 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
diff --git a/streaming.c b/streaming.c
index fcd6303219..00771e8de7 100644
=2D-- a/streaming.c
+++ b/streaming.c
@@ -69,19 +69,19 @@ struct filtered_istream {

 struct git_istream {
 	const struct stream_vtbl *vtbl;
-	unsigned long size; /* inflated size of full object */
+	size_t size; /* inflated size of full object */
 	git_zstream z;
 	enum { z_unused, z_used, z_done, z_error } z_state;

 	union {
 		struct {
 			char *buf; /* from read_object() */
-			unsigned long read_ptr;
+			size_t read_ptr;
 		} incore;

 		struct {
 			void *mapped;
-			unsigned long mapsize;
+			size_t mapsize;
 			char hdr[32];
 			int hdr_avail;
 			int hdr_used;
@@ -112,7 +112,7 @@ static enum input_source istream_source(const struct o=
bject_id *oid,
 					enum object_type *type,
 					struct object_info *oi)
 {
-	unsigned long size;
+	size_t size;
 	int status;

 	oi->typep =3D type;
@@ -135,7 +135,7 @@ static enum input_source istream_source(const struct o=
bject_id *oid,

 struct git_istream *open_istream(const struct object_id *oid,
 				 enum object_type *type,
-				 unsigned long *size,
+				 size_t *size,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
@@ -516,7 +516,7 @@ int stream_blob_to_fd(int fd, const struct object_id *=
oid, struct stream_filter
 {
 	struct git_istream *st;
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	ssize_t kept =3D 0;
 	int result =3D -1;

diff --git a/streaming.h b/streaming.h
index 32f4626771..552eb1d7c5 100644
=2D-- a/streaming.h
+++ b/streaming.h
@@ -8,7 +8,7 @@
 /* opaque */
 struct git_istream;

-extern struct git_istream *open_istream(const struct object_id *, enum ob=
ject_type *, unsigned long *, struct stream_filter *);
+extern struct git_istream *open_istream(const struct object_id *, enum ob=
ject_type *, size_t *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);

diff --git a/submodule-config.c b/submodule-config.c
index 66653e86b9..e9f5f32305 100644
=2D-- a/submodule-config.c
+++ b/submodule-config.c
@@ -534,7 +534,7 @@ static const struct submodule *config_from(struct subm=
odule_cache *cache,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev =3D STRBUF_INIT;
-	unsigned long config_size;
+	size_t config_size;
 	char *config =3D NULL;
 	struct object_id oid;
 	enum object_type type;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index e749a49c88..b613cd0216 100644
=2D-- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -21,7 +21,7 @@ int cmd__delta(int argc, const char **argv)
 	int fd;
 	struct stat st;
 	void *from_buf, *data_buf, *out_buf;
-	unsigned long from_size, data_size, out_size;
+	size_t from_size, data_size, out_size;

 	if (argc !=3D 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "usage: %s\n", usage_str);
diff --git a/tag.c b/tag.c
index 7445b8f6ea..a6c07419dc 100644
=2D-- a/tag.c
+++ b/tag.c
@@ -41,7 +41,7 @@ int gpg_verify_tag(const struct object_id *oid, const ch=
ar *name_to_report,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;

 	type =3D oid_object_info(the_repository, oid, NULL);
@@ -132,7 +132,7 @@ void release_tag_memory(struct tag *t)
 	t->date =3D 0;
 }

-int parse_tag_buffer(struct repository *r, struct tag *item, const void *=
data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *=
data, size_t size)
 {
 	struct object_id oid;
 	char type[20];
@@ -195,7 +195,7 @@ int parse_tag(struct tag *item)
 {
 	enum object_type type;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ret;

 	if (item->object.parsed)
diff --git a/tag.h b/tag.h
index e669c3e497..b540b100ef 100644
=2D-- a/tag.h
+++ b/tag.h
@@ -12,7 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 extern struct tag *lookup_tag(struct repository *r, const struct object_i=
d *oid);
-extern int parse_tag_buffer(struct repository *r, struct tag *item, const=
 void *data, unsigned long size);
+extern int parse_tag_buffer(struct repository *r, struct tag *item, const=
 void *data, size_t size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 extern struct object *deref_tag(struct repository *r, struct object *, co=
nst char *, int);
diff --git a/tree-walk.c b/tree-walk.c
index 1e4bbc8a0e..d6a3f8233a 100644
=2D-- a/tree-walk.c
+++ b/tree-walk.c
@@ -83,7 +83,7 @@ int init_tree_desc_gently(struct tree_desc *desc, const =
void *buffer, unsigned l

 void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id=
 *oid)
 {
-	unsigned long size =3D 0;
+	size_t size =3D 0;
 	void *buf =3D NULL;

 	if (oid) {
@@ -109,8 +109,8 @@ static int update_tree_entry_internal(struct tree_desc=
 *desc, struct strbuf *err
 {
 	const void *buf =3D desc->buffer;
 	const unsigned char *end =3D (const unsigned char *)desc->entry.path + d=
esc->entry.pathlen + 1 + the_hash_algo->rawsz;
-	unsigned long size =3D desc->size;
-	unsigned long len =3D end - (const unsigned char *)buf;
+	size_t size =3D desc->size;
+	size_t len =3D end - (const unsigned char *)buf;

 	if (size < len)
 		die(_("too-short tree file"));
@@ -496,7 +496,7 @@ int traverse_trees(struct index_state *istate,

 struct dir_state {
 	void *tree;
-	unsigned long size;
+	size_t size;
 	struct object_id oid;
 };

@@ -539,7 +539,7 @@ int get_tree_entry(const struct object_id *tree_oid, c=
onst char *name, struct ob
 {
 	int retval;
 	void *tree;
-	unsigned long size;
+	size_t size;
 	struct object_id root;

 	tree =3D read_object_with_reference(tree_oid, tree_type, &size, &root);
@@ -608,7 +608,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(str=
uct object_id *tree_oid, c
 		if (!t.buffer) {
 			void *tree;
 			struct object_id root;
-			unsigned long size;
+			size_t size;
 			tree =3D read_object_with_reference(&current_tree_oid,
 							  tree_type, &size,
 							  &root);
@@ -704,7 +704,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(str=
uct object_id *tree_oid, c
 			goto done;
 		} else if (S_ISLNK(*mode)) {
 			/* Follow a symlink */
-			unsigned long link_len;
+			size_t link_len;
 			size_t len;
 			char *contents, *contents_start;
 			struct dir_state *parent;
diff --git a/tree.c b/tree.c
index f416afc57d..e3bfb75c45 100644
=2D-- a/tree.c
+++ b/tree.c
@@ -219,7 +219,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_=
missing)
 {
 	 enum object_type type;
 	 void *buffer;
-	 unsigned long size;
+	 size_t size;

 	if (item->object.parsed)
 		return 0;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 8509f9ea22..63039f6a37 100644
=2D-- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -169,7 +169,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)

 void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;

 	if (oideq(oid, &null_oid)) {
@@ -185,7 +185,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id=
 *oid)
 }

 #define FIRST_FEW_BYTES 8000
-int buffer_is_binary(const char *ptr, unsigned long size)
+int buffer_is_binary(const char *ptr, size_t size)
 {
 	if (FIRST_FEW_BYTES < size)
 		size =3D FIRST_FEW_BYTES;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 2d41fffd4c..6c99f8d047 100644
=2D-- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,7 +11,7 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)

-typedef void (*xdiff_emit_line_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_line_fn)(void *, char *, size_t);
 typedef void (*xdiff_emit_hunk_fn)(void *data,
 				   long old_begin, long old_nr,
 				   long new_begin, long new_nr,
@@ -25,7 +25,7 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
 int read_mmfile(mmfile_t *ptr, const char *filename);
 void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
-int buffer_is_binary(const char *ptr, unsigned long size);
+int buffer_is_binary(const char *ptr, size_t size);

 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, in=
t cflags);
 extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
=2D-
2.20.1

