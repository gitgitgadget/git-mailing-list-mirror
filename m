From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/10] i18n: apply: mark strings for translation
Date: Mon, 23 Apr 2012 19:30:27 +0700
Message-ID: <1335184230-8870-8-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIU1-0005mi-3Q
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab2DWMfC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:35:02 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:35:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CrQrDk/e9CNTN1dJosjOQuXasa8KTGmtLS9Ms3VXvUc=;
        b=EEgBdek0Rc8siZTqVmMCA9LjFFgj/qKPFJNKJuU5sth8tyMCHvUXbu0bkRTzU7NIAl
         mqazKjeVfVW45fYXBg1ZcHCMUVEasxifvZhIs1Isaauy/W6pZKUXgv/mREDgiZns//0U
         PGO0A+I5W6XsVOiU1fpyD510p8CoPIiENo8Bb5nBv0vgzJHdrwvqqjNrYFuvFW/jveos
         fPrzxNpKLbpsBGLe57pQXQT50BHIOi2XNvHZWOeLEmXbsKWRQX+asexZ39Zal7wIuYOv
         hTukvgkRBb1R1M0crGJ0f9qvpwQEgeEUPND2dvX4k2StVP3q8bSopjNI+uBkN/LVPUcs
         qQ/g==
Received: by 10.68.221.74 with SMTP id qc10mr36084457pbc.80.1335184499970;
        Mon, 23 Apr 2012 05:34:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id pv9sm4906849pbc.37.2012.04.23.05.34.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:42 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196121>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |  174 +++++++++++++++++++++++++++++------------------=
--------
 1 files changed, 91 insertions(+), 83 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..4bb6354 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -103,7 +103,7 @@ static void parse_whitespace_option(const char *opt=
ion)
 		ws_error_action =3D correct_ws_error;
 		return;
 	}
-	die("unrecognized whitespace option '%s'", option);
+	die(_("unrecognized whitespace option '%s'"), option);
 }
=20
 static void parse_ignorewhitespace_option(const char *option)
@@ -118,7 +118,7 @@ static void parse_ignorewhitespace_option(const cha=
r *option)
 		ws_ignore_action =3D ignore_ws_change;
 		return;
 	}
-	die("unrecognized whitespace ignore option '%s'", option);
+	die(_("unrecognized whitespace ignore option '%s'"), option);
 }
=20
 static void set_default_whitespace_mode(const char *whitespace_option)
@@ -770,7 +770,7 @@ static int has_epoch_timestamp(const char *nameline=
)
 	if (!stamp) {
 		stamp =3D xmalloc(sizeof(*stamp));
 		if (regcomp(stamp, stamp_regexp, REG_EXTENDED)) {
-			warning("Cannot prepare timestamp regexp %s",
+			warning(_("Cannot prepare timestamp regexp %s"),
 				stamp_regexp);
 			return 0;
 		}
@@ -779,7 +779,7 @@ static int has_epoch_timestamp(const char *nameline=
)
 	status =3D regexec(stamp, timestamp, ARRAY_SIZE(m), m, 0);
 	if (status) {
 		if (status !=3D REG_NOMATCH)
-			warning("regexec returned %d for input: %s",
+			warning(_("regexec returned %d for input: %s"),
 				status, timestamp);
 		return 0;
 	}
@@ -857,7 +857,7 @@ static void parse_traditional_patch(const char *fir=
st, const char *second, struc
 		}
 	}
 	if (!name)
-		die("unable to find filename in patch at line %d", linenr);
+		die(_("unable to find filename in patch at line %d"), linenr);
 }
=20
 static int gitdiff_hdrend(const char *line, struct patch *patch)
@@ -886,17 +886,17 @@ static char *gitdiff_verify_name(const char *line=
, int isnull, char *orig_name,
 		name =3D orig_name;
 		len =3D strlen(name);
 		if (isnull)
-			die("git apply: bad git-diff - expected /dev/null, got %s on line %=
d", name, linenr);
+			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"), name, linenr);
 		another =3D find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
-			die("git apply: bad git-diff - inconsistent %s filename on line %d"=
, oldnew, linenr);
+			die(_("git apply: bad git-diff - inconsistent %s filename on line %=
d"), oldnew, linenr);
 		free(another);
 		return orig_name;
 	}
 	else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] !=3D '\n')
-			die("git apply: bad git-diff - expected /dev/null on line %d", line=
nr);
+			die(_("git apply: bad git-diff - expected /dev/null on line %d"), l=
inenr);
 		return NULL;
 	}
 }
@@ -1327,7 +1327,7 @@ static void recount_diff(char *line, int size, st=
ruct fragment *fragment)
 			break;
 		}
 		if (ret) {
-			warning("recount: unexpected line: %.*s",
+			warning(_("recount: unexpected line: %.*s"),
 				(int)linelen(line, size), line);
 			return;
 		}
@@ -1384,7 +1384,7 @@ static int find_header(char *line, unsigned long =
size, int *hdrsize, struct patc
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			die("patch fragment without header at line %d: %.*s",
+			die(_("patch fragment without header at line %d: %.*s"),
 			    linenr, (int)len-1, line);
 		}
=20
@@ -1401,8 +1401,12 @@ static int find_header(char *line, unsigned long=
 size, int *hdrsize, struct patc
 				continue;
 			if (!patch->old_name && !patch->new_name) {
 				if (!patch->def_name)
-					die("git diff header lacks filename information when removing "
-					    "%d leading pathname components (line %d)" , p_value, linenr)=
;
+					die(Q_("git diff header lacks filename information when removing =
"
+					       "%d leading pathname component (line %d)",
+					       "git diff header lacks filename information when removing =
"
+					       "%d leading pathname components (line %d)",
+					       p_value),
+					    p_value, linenr);
 				patch->old_name =3D patch->new_name =3D patch->def_name;
 			}
 			if (!patch->is_delete && !patch->new_name)
@@ -1556,9 +1560,9 @@ static int parse_fragment(char *line, unsigned lo=
ng size,
 	patch->lines_deleted +=3D deleted;
=20
 	if (0 < patch->is_new && oldlines)
-		return error("new file depends on old contents");
+		return error(_("new file depends on old contents"));
 	if (0 < patch->is_delete && newlines)
-		return error("deleted file still has contents");
+		return error(_("deleted file still has contents"));
 	return offset;
 }
=20
@@ -1576,7 +1580,7 @@ static int parse_single_patch(char *line, unsigne=
d long size, struct patch *patc
 		fragment->linenr =3D linenr;
 		len =3D parse_fragment(line, size, patch, fragment);
 		if (len <=3D 0)
-			die("corrupt patch at line %d", linenr);
+			die(_("corrupt patch at line %d"), linenr);
 		fragment->patch =3D line;
 		fragment->size =3D len;
 		oldlines +=3D fragment->oldlines;
@@ -1612,12 +1616,14 @@ static int parse_single_patch(char *line, unsig=
ned long size, struct patch *patc
 		patch->is_delete =3D 0;
=20
 	if (0 < patch->is_new && oldlines)
-		die("new file %s depends on old contents", patch->new_name);
+		die(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
-		die("deleted file %s still has contents", patch->old_name);
+		die(_("deleted file %s still has contents"), patch->old_name);
 	if (!patch->is_delete && !newlines && context)
-		fprintf(stderr, "** warning: file %s becomes empty but "
-			"is not deleted\n", patch->new_name);
+		fprintf_ln(stderr,
+			   _("** warning: "
+			     "file %s becomes empty but is not deleted"),
+			   patch->new_name);
=20
 	return offset;
 }
@@ -1755,7 +1761,7 @@ static struct fragment *parse_binary_hunk(char **=
buf_p,
  corrupt:
 	free(data);
 	*status_p =3D -1;
-	error("corrupt binary patch at line %d: %.*s",
+	error(_("corrupt binary patch at line %d: %.*s"),
 	      linenr-1, llen-1, buffer);
 	return NULL;
 }
@@ -1784,7 +1790,7 @@ static int parse_binary(char *buffer, unsigned lo=
ng size, struct patch *patch)
 	forward =3D parse_binary_hunk(&buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error("unrecognized binary patch at line %d", linenr-1);
+		return error(_("unrecognized binary patch at line %d"), linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
@@ -1863,7 +1869,7 @@ static int parse_chunk(char *buffer, unsigned lon=
g size, struct patch *patch)
 		 */
 		if ((apply || check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die("patch with only garbage at line %d", linenr);
+			die(_("patch with only garbage at line %d"), linenr);
 	}
=20
 	return offset + hdrsize + patchsize;
@@ -1953,11 +1959,11 @@ static int read_old_data(struct stat *st, const=
 char *path, struct strbuf *buf)
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
-			return error("unable to read symlink %s", path);
+			return error(_("unable to read symlink %s"), path);
 		return 0;
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
-			return error("unable to open or read %s", path);
+			return error(_("unable to open or read %s"), path);
 		convert_to_git(path, buf->buf, buf->len, buf, 0);
 		return 0;
 	default:
@@ -2028,7 +2034,7 @@ static void update_pre_post_images(struct image *=
preimage,
 			ctx++;
 		}
 		if (preimage->nr <=3D ctx)
-			die("oops");
+			die(_("oops"));
=20
 		/* and copy it in, while fixing the line length */
 		len =3D preimage->line[ctx].len;
@@ -2540,7 +2546,7 @@ static int apply_one_fragment(struct image *img, =
struct fragment *frag,
 			break;
 		default:
 			if (apply_verbosely)
-				error("invalid start of line: '%c'", first);
+				error(_("invalid start of line: '%c'"), first);
 			return -1;
 		}
 		if (added_blank_line) {
@@ -2657,9 +2663,11 @@ static int apply_one_fragment(struct image *img,=
 struct fragment *frag,
 			int offset =3D applied_pos - pos;
 			if (apply_in_reverse)
 				offset =3D 0 - offset;
-			fprintf(stderr,
-				"Hunk #%d succeeded at %d (offset %d lines).\n",
-				nth_fragment, applied_pos + 1, offset);
+			fprintf_ln(stderr,
+				   Q_("Hunk #%d succeeded at %d (offset %d line).",
+				      "Hunk #%d succeeded at %d (offset %d lines).",
+				      offset),
+				   nth_fragment, applied_pos + 1, offset);
 		}
=20
 		/*
@@ -2668,13 +2676,13 @@ static int apply_one_fragment(struct image *img=
, struct fragment *frag,
 		 */
 		if ((leading !=3D frag->leading) ||
 		    (trailing !=3D frag->trailing))
-			fprintf(stderr, "Context reduced to (%ld/%ld)"
-				" to apply fragment at %d\n",
-				leading, trailing, applied_pos+1);
+			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
+					     " to apply fragment at %d"),
+				   leading, trailing, applied_pos+1);
 		update_image(img, applied_pos, &preimage, &postimage);
 	} else {
 		if (apply_verbosely)
-			error("while searching for:\n%.*s",
+			error(_("while searching for:\n%.*s"),
 			      (int)(old - oldlines), oldlines);
 	}
=20
@@ -2693,7 +2701,7 @@ static int apply_binary_fragment(struct image *im=
g, struct patch *patch)
 	void *dst;
=20
 	if (!fragment)
-		return error("missing binary patch data for '%s'",
+		return error(_("missing binary patch data for '%s'"),
 			     patch->new_name ?
 			     patch->new_name :
 			     patch->old_name);
@@ -2790,13 +2798,13 @@ static int apply_binary(struct image *img, stru=
ct patch *patch)
 		 * in the patch->fragments->{patch,size}.
 		 */
 		if (apply_binary_fragment(img, patch))
-			return error("binary patch does not apply to '%s'",
+			return error(_("binary patch does not apply to '%s'"),
 				     name);
=20
 		/* verify that the result matches */
 		hash_sha1_file(img->buf, img->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
-			return error("binary patch to '%s' creates incorrect result (expect=
ing %s, got %s)",
+			return error(_("binary patch to '%s' creates incorrect result (expe=
cting %s, got %s)"),
 				name, patch->new_sha1_prefix, sha1_to_hex(sha1));
 	}
=20
@@ -2817,7 +2825,7 @@ static int apply_fragments(struct image *img, str=
uct patch *patch)
 	while (frag) {
 		nth++;
 		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
-			error("patch failed: %s:%ld", name, frag->oldpos);
+			error(_("patch failed: %s:%ld"), name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
 			frag->rejected =3D 1;
@@ -2932,14 +2940,14 @@ static int apply_data(struct patch *patch, stru=
ct stat *st, struct cache_entry *
 	if (!(patch->is_copy || patch->is_rename) &&
 	    (tpatch =3D in_fn_table(patch->old_name)) !=3D NULL && !to_be_del=
eted(tpatch)) {
 		if (was_deleted(tpatch)) {
-			return error("patch %s has been renamed/deleted",
+			return error(_("patch %s has been renamed/deleted"),
 				patch->old_name);
 		}
 		/* We have a patched copy in memory use that */
 		strbuf_add(&buf, tpatch->result, tpatch->resultsize);
 	} else if (cached) {
 		if (read_file_or_gitlink(ce, &buf))
-			return error("read of %s failed", patch->old_name);
+			return error(_("read of %s failed"), patch->old_name);
 	} else if (patch->old_name) {
 		if (S_ISGITLINK(patch->old_mode)) {
 			if (ce) {
@@ -2953,7 +2961,7 @@ static int apply_data(struct patch *patch, struct=
 stat *st, struct cache_entry *
 			}
 		} else {
 			if (read_old_data(st, patch->old_name, &buf))
-				return error("read of %s failed", patch->old_name);
+				return error(_("read of %s failed"), patch->old_name);
 		}
 	}
=20
@@ -2968,7 +2976,7 @@ static int apply_data(struct patch *patch, struct=
 stat *st, struct cache_entry *
 	free(image.line_allocated);
=20
 	if (0 < patch->is_delete && patch->resultsize)
-		return error("removal patch leaves file contents");
+		return error(_("removal patch leaves file contents"));
=20
 	return 0;
 }
@@ -2989,7 +2997,7 @@ static int check_to_create_blob(const char *new_n=
ame, int ok_if_exists)
 		if (has_symlink_leading_path(new_name, strlen(new_name)))
 			return 0;
=20
-		return error("%s: already exists in working directory", new_name);
+		return error(_("%s: already exists in working directory"), new_name)=
;
 	}
 	else if ((errno !=3D ENOENT) && (errno !=3D ENOTDIR))
 		return error("%s: %s", new_name, strerror(errno));
@@ -3027,12 +3035,12 @@ static int check_preimage(struct patch *patch, =
struct cache_entry **ce, struct s
 	if (!(patch->is_copy || patch->is_rename) &&
 	    (tpatch =3D in_fn_table(old_name)) !=3D NULL && !to_be_deleted(tp=
atch)) {
 		if (was_deleted(tpatch))
-			return error("%s: has been deleted/renamed", old_name);
+			return error(_("%s: has been deleted/renamed"), old_name);
 		st_mode =3D tpatch->new_mode;
 	} else if (!cached) {
 		stat_ret =3D lstat(old_name, st);
 		if (stat_ret && errno !=3D ENOENT)
-			return error("%s: %s", old_name, strerror(errno));
+			return error(_("%s: %s"), old_name, strerror(errno));
 	}
=20
 	if (to_be_deleted(tpatch))
@@ -3043,7 +3051,7 @@ static int check_preimage(struct patch *patch, st=
ruct cache_entry **ce, struct s
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
-			return error("%s: does not exist in index", old_name);
+			return error(_("%s: does not exist in index"), old_name);
 		}
 		*ce =3D active_cache[pos];
 		if (stat_ret < 0) {
@@ -3057,13 +3065,13 @@ static int check_preimage(struct patch *patch, =
struct cache_entry **ce, struct s
 				return -1;
 		}
 		if (!cached && verify_index_match(*ce, st))
-			return error("%s: does not match index", old_name);
+			return error(_("%s: does not match index"), old_name);
 		if (cached)
 			st_mode =3D (*ce)->ce_mode;
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
 			goto is_new;
-		return error("%s: %s", old_name, strerror(errno));
+		return error(_("%s: %s"), old_name, strerror(errno));
 	}
=20
 	if (!cached && !tpatch)
@@ -3074,9 +3082,9 @@ static int check_preimage(struct patch *patch, st=
ruct cache_entry **ce, struct s
 	if (!patch->old_mode)
 		patch->old_mode =3D st_mode;
 	if ((st_mode ^ patch->old_mode) & S_IFMT)
-		return error("%s: wrong type", old_name);
+		return error(_("%s: wrong type"), old_name);
 	if (st_mode !=3D patch->old_mode)
-		warning("%s has type %o, expected %o",
+		warning(_("%s has type %o, expected %o"),
 			old_name, st_mode, patch->old_mode);
 	if (!patch->new_mode && !patch->is_delete)
 		patch->new_mode =3D st_mode;
@@ -3126,7 +3134,7 @@ static int check_patch(struct patch *patch)
 		if (check_index &&
 		    cache_name_pos(new_name, strlen(new_name)) >=3D 0 &&
 		    !ok_if_exists)
-			return error("%s: already exists in index", new_name);
+			return error(_("%s: already exists in index"), new_name);
 		if (!cached) {
 			int err =3D check_to_create_blob(new_name, ok_if_exists);
 			if (err)
@@ -3145,13 +3153,13 @@ static int check_patch(struct patch *patch)
 		if (!patch->new_mode)
 			patch->new_mode =3D patch->old_mode;
 		if ((patch->old_mode ^ patch->new_mode) & S_IFMT)
-			return error("new mode (%o) of %s does not match old mode (%o)%s%s"=
,
+			return error(_("new mode (%o) of %s does not match old mode (%o)%s%=
s"),
 				patch->new_mode, new_name, patch->old_mode,
 				same ? "" : " of ", same ? "" : old_name);
 	}
=20
 	if (apply_data(patch, &st, ce) < 0)
-		return error("%s: patch does not apply", name);
+		return error(_("%s: patch does not apply"), name);
 	patch->rejected =3D 0;
 	return 0;
 }
@@ -3219,7 +3227,7 @@ static void build_fake_ancestor(struct patch *lis=
t, const char *filename)
=20
 		ce =3D make_cache_entry(patch->old_mode, sha1_ptr, name, 0, 0);
 		if (!ce)
-			die("make_cache_entry failed for path '%s'", name);
+			die(_("make_cache_entry failed for path '%s'"), name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
 			die ("Could not add %s to temporary index", name);
 	}
@@ -3362,7 +3370,7 @@ static void remove_file(struct patch *patch, int =
rmdir_empty)
 {
 	if (update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
-			die("unable to remove %s from index", patch->old_name);
+			die(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty=
) {
@@ -3389,19 +3397,19 @@ static void add_index_file(const char *path, un=
signed mode, void *buf, unsigned
 		const char *s =3D buf;
=20
 		if (get_sha1_hex(s + strlen("Subproject commit "), ce->sha1))
-			die("corrupt patch for subproject %s", path);
+			die(_("corrupt patch for subproject %s"), path);
 	} else {
 		if (!cached) {
 			if (lstat(path, &st) < 0)
-				die_errno("unable to stat newly created file '%s'",
+				die_errno(_("unable to stat newly created file '%s'"),
 					  path);
 			fill_stat_cache_info(ce, &st);
 		}
 		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
-			die("unable to create backing store for newly created file %s", pat=
h);
+			die(_("unable to create backing store for newly created file %s"), =
path);
 	}
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-		die("unable to add cache entry for %s", path);
+		die(_("unable to add cache entry for %s"), path);
 }
=20
 static int try_create_file(const char *path, unsigned int mode, const =
char *buf, unsigned long size)
@@ -3434,7 +3442,7 @@ static int try_create_file(const char *path, unsi=
gned int mode, const char *buf,
 	strbuf_release(&nbuf);
=20
 	if (close(fd) < 0)
-		die_errno("closing file '%s'", path);
+		die_errno(_("closing file '%s'"), path);
 	return 0;
 }
=20
@@ -3483,7 +3491,7 @@ static void create_one_file(char *path, unsigned =
mode, const char *buf, unsigned
 			++nr;
 		}
 	}
-	die_errno("unable to write file '%s' mode %o", path, mode);
+	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
=20
 static void create_file(struct patch *patch)
@@ -3546,7 +3554,7 @@ static int write_out_one_reject(struct patch *pat=
ch)
 	 * contents are marked "rejected" at the patch level.
 	 */
 	if (!patch->new_name)
-		die("internal error");
+		die(_("internal error"));
=20
 	/* Say this even without --verbose */
 	say_patch_name(stderr, "Applying patch ", patch, " with");
@@ -3555,7 +3563,7 @@ static int write_out_one_reject(struct patch *pat=
ch)
 	cnt =3D strlen(patch->new_name);
 	if (ARRAY_SIZE(namebuf) <=3D cnt + 5) {
 		cnt =3D ARRAY_SIZE(namebuf) - 5;
-		warning("truncating .rej filename to %.*s.rej",
+		warning(_("truncating .rej filename to %.*s.rej"),
 			cnt - 1, patch->new_name);
 	}
 	memcpy(namebuf, patch->new_name, cnt);
@@ -3563,7 +3571,7 @@ static int write_out_one_reject(struct patch *pat=
ch)
=20
 	rej =3D fopen(namebuf, "w");
 	if (!rej)
-		return error("cannot open %s: %s", namebuf, strerror(errno));
+		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
=20
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git nor give extended
@@ -3576,10 +3584,10 @@ static int write_out_one_reject(struct patch *p=
atch)
 	     frag;
 	     cnt++, frag =3D frag->next) {
 		if (!frag->rejected) {
-			fprintf(stderr, "Hunk #%d applied cleanly.\n", cnt);
+			fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
 			continue;
 		}
-		fprintf(stderr, "Rejected hunk #%d.\n", cnt);
+		fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
 		fprintf(rej, "%.*s", frag->size, frag->patch);
 		if (frag->patch[frag->size-1] !=3D '\n')
 			fputc('\n', rej);
@@ -3720,7 +3728,7 @@ static int apply_patch(int fd, const char *filena=
me, int options)
 	}
=20
 	if (!list && !skipped_patch)
-		die("unrecognized input");
+		die(_("unrecognized input"));
=20
 	if (whitespace_error && (ws_error_action =3D=3D die_on_ws_error))
 		apply =3D 0;
@@ -3731,7 +3739,7 @@ static int apply_patch(int fd, const char *filena=
me, int options)
=20
 	if (check_index) {
 		if (read_cache() < 0)
-			die("unable to read index file");
+			die(_("unable to read index file"));
 	}
=20
 	if ((check || apply) &&
@@ -3924,10 +3932,10 @@ int cmd_apply(int argc, const char **argv, cons=
t char *prefix_)
 	if (!force_apply && (diffstat || numstat || summary || check || fake_=
ancestor))
 		apply =3D 0;
 	if (check_index && is_not_gitdir)
-		die("--index outside a repository");
+		die(_("--index outside a repository"));
 	if (cached) {
 		if (is_not_gitdir)
-			die("--cached outside a repository");
+			die(_("--cached outside a repository"));
 		check_index =3D 1;
 	}
 	for (i =3D 0; i < argc; i++) {
@@ -3943,7 +3951,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
=20
 		fd =3D open(arg, O_RDONLY);
 		if (fd < 0)
-			die_errno("can't open patch '%s'", arg);
+			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin =3D 0;
 		set_default_whitespace_mode(whitespace_option);
 		errs |=3D apply_patch(fd, arg, options);
@@ -3957,32 +3965,32 @@ int cmd_apply(int argc, const char **argv, cons=
t char *prefix_)
 		    squelch_whitespace_errors < whitespace_error) {
 			int squelched =3D
 				whitespace_error - squelch_whitespace_errors;
-			warning("squelched %d "
-				"whitespace error%s",
-				squelched,
-				squelched =3D=3D 1 ? "" : "s");
+			warning(Q_("squelched %d whitespace error",
+				   "squelched %d whitespace errors",
+				   squelched),
+				squelched);
 		}
 		if (ws_error_action =3D=3D die_on_ws_error)
-			die("%d line%s add%s whitespace errors.",
-			    whitespace_error,
-			    whitespace_error =3D=3D 1 ? "" : "s",
-			    whitespace_error =3D=3D 1 ? "s" : "");
+			die(Q_("%d line adds whitespace errors.",
+			       "%d lines add whitespace errors.",
+			       whitespace_error),
+			    whitespace_error);
 		if (applied_after_fixing_ws && apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
 				applied_after_fixing_ws =3D=3D 1 ? "" : "s");
 		else if (whitespace_error)
-			warning("%d line%s add%s whitespace errors.",
-				whitespace_error,
-				whitespace_error =3D=3D 1 ? "" : "s",
-				whitespace_error =3D=3D 1 ? "s" : "");
+			warning(Q_("%d line adds whitespace errors.",
+				   "%d lines add whitespace errors.",
+				   whitespace_error),
+				whitespace_error);
 	}
=20
 	if (update_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
=20
 	return !!errs;
--=20
1.7.8.36.g69ee2
