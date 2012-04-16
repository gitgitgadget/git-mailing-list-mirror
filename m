From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 08/11] i18n: apply: mark strings for translation
Date: Mon, 16 Apr 2012 19:50:00 +0700
Message-ID: <1334580603-11577-9-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:52:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlPw-0007LD-BY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2DPMwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:52:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab2DPMwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:52:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6309124pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+GOPlBkI/saXHZ6jOM8/GQw2rzOirqX6TPg4Xy31R/8=;
        b=ko02BhyRnbX6R9+z2lGXAO786k4ulL7Mu6QlE6jMh+iWyZmSb9Z7WCeJZaF7a1gpGI
         MK8dgasjVYtgPjkDw4AFYruMJD6dgKcGYrb6OMyhqGNA7FmbEO5+jx6JHmQPyUH4RZsf
         MyDM7ZZJKiMvB9yu/+mPxIFCRSAfePZojGpBWqVkub18nlergIH1UVKrvDe9PEAx4iyX
         +w5y/Wu235VQlfsw5M5M/gf6RJ6ZQUyOnauenudPEac2W7A21ZAxgaQGmebRUNyO7PVI
         0KssSNaEo4xSGc0oA1+qQUzjCw35LjgNKFQTov76L5yxW+kNpYGBo4xPwRECG5Es/Oro
         BgGQ==
Received: by 10.68.72.138 with SMTP id d10mr28111166pbv.15.1334580741268;
        Mon, 16 Apr 2012 05:52:21 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id va9sm11529546pbc.66.2012.04.16.05.52.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:52:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:51:29 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195631>

---
 builtin/apply.c |  226 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 114 insertions(+), 112 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..6e9a02e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -50,7 +50,7 @@ static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
-	"git apply [options] [<patch>...]",
+	N_("git apply [options] [<patch>...]"),
 	NULL
 };
 
@@ -103,7 +103,7 @@ static void parse_whitespace_option(const char *option)
 		ws_error_action = correct_ws_error;
 		return;
 	}
-	die("unrecognized whitespace option '%s'", option);
+	die(_("unrecognized whitespace option '%s'"), option);
 }
 
 static void parse_ignorewhitespace_option(const char *option)
@@ -118,7 +118,7 @@ static void parse_ignorewhitespace_option(const char *option)
 		ws_ignore_action = ignore_ws_change;
 		return;
 	}
-	die("unrecognized whitespace ignore option '%s'", option);
+	die(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
 static void set_default_whitespace_mode(const char *whitespace_option)
@@ -770,7 +770,7 @@ static int has_epoch_timestamp(const char *nameline)
 	if (!stamp) {
 		stamp = xmalloc(sizeof(*stamp));
 		if (regcomp(stamp, stamp_regexp, REG_EXTENDED)) {
-			warning("Cannot prepare timestamp regexp %s",
+			warning(_("Cannot prepare timestamp regexp %s"),
 				stamp_regexp);
 			return 0;
 		}
@@ -779,7 +779,7 @@ static int has_epoch_timestamp(const char *nameline)
 	status = regexec(stamp, timestamp, ARRAY_SIZE(m), m, 0);
 	if (status) {
 		if (status != REG_NOMATCH)
-			warning("regexec returned %d for input: %s",
+			warning(_("regexec returned %d for input: %s"),
 				status, timestamp);
 		return 0;
 	}
@@ -857,7 +857,7 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 		}
 	}
 	if (!name)
-		die("unable to find filename in patch at line %d", linenr);
+		die(_("unable to find filename in patch at line %d"), linenr);
 }
 
 static int gitdiff_hdrend(const char *line, struct patch *patch)
@@ -886,17 +886,17 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		name = orig_name;
 		len = strlen(name);
 		if (isnull)
-			die("git apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
+			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
-			die("git apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
+			die(_("git apply: bad git-diff - inconsistent %s filename on line %d"), oldnew, linenr);
 		free(another);
 		return orig_name;
 	}
 	else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die("git apply: bad git-diff - expected /dev/null on line %d", linenr);
+			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
 		return NULL;
 	}
 }
@@ -1327,7 +1327,7 @@ static void recount_diff(char *line, int size, struct fragment *fragment)
 			break;
 		}
 		if (ret) {
-			warning("recount: unexpected line: %.*s",
+			warning(_("recount: unexpected line: %.*s"),
 				(int)linelen(line, size), line);
 			return;
 		}
@@ -1384,7 +1384,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			die("patch fragment without header at line %d: %.*s",
+			die(_("patch fragment without header at line %d: %.*s"),
 			    linenr, (int)len-1, line);
 		}
 
@@ -1556,9 +1556,9 @@ static int parse_fragment(char *line, unsigned long size,
 	patch->lines_deleted += deleted;
 
 	if (0 < patch->is_new && oldlines)
-		return error("new file depends on old contents");
+		return error(_("new file depends on old contents"));
 	if (0 < patch->is_delete && newlines)
-		return error("deleted file still has contents");
+		return error(_("deleted file still has contents"));
 	return offset;
 }
 
@@ -1576,7 +1576,7 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 		fragment->linenr = linenr;
 		len = parse_fragment(line, size, patch, fragment);
 		if (len <= 0)
-			die("corrupt patch at line %d", linenr);
+			die(_("corrupt patch at line %d"), linenr);
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1612,12 +1612,14 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 		patch->is_delete = 0;
 
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
 
 	return offset;
 }
@@ -1755,7 +1757,7 @@ static struct fragment *parse_binary_hunk(char **buf_p,
  corrupt:
 	free(data);
 	*status_p = -1;
-	error("corrupt binary patch at line %d: %.*s",
+	error(_("corrupt binary patch at line %d: %.*s"),
 	      linenr-1, llen-1, buffer);
 	return NULL;
 }
@@ -1784,7 +1786,7 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	forward = parse_binary_hunk(&buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error("unrecognized binary patch at line %d", linenr-1);
+		return error(_("unrecognized binary patch at line %d"), linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
@@ -1863,7 +1865,7 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 		 */
 		if ((apply || check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die("patch with only garbage at line %d", linenr);
+			die(_("patch with only garbage at line %d"), linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -1953,11 +1955,11 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
-			return error("unable to read symlink %s", path);
+			return error(_("unable to read symlink %s"), path);
 		return 0;
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
-			return error("unable to open or read %s", path);
+			return error(_("unable to open or read %s"), path);
 		convert_to_git(path, buf->buf, buf->len, buf, 0);
 		return 0;
 	default:
@@ -2028,7 +2030,7 @@ static void update_pre_post_images(struct image *preimage,
 			ctx++;
 		}
 		if (preimage->nr <= ctx)
-			die("oops");
+			die(_("oops"));
 
 		/* and copy it in, while fixing the line length */
 		len = preimage->line[ctx].len;
@@ -2540,7 +2542,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			break;
 		default:
 			if (apply_verbosely)
-				error("invalid start of line: '%c'", first);
+				error(_("invalid start of line: '%c'"), first);
 			return -1;
 		}
 		if (added_blank_line) {
@@ -2657,9 +2659,9 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			int offset = applied_pos - pos;
 			if (apply_in_reverse)
 				offset = 0 - offset;
-			fprintf(stderr,
-				"Hunk #%d succeeded at %d (offset %d lines).\n",
-				nth_fragment, applied_pos + 1, offset);
+			fprintf_ln(stderr,
+				   _("Hunk #%d succeeded at %d (offset %d lines)."),
+				   nth_fragment, applied_pos + 1, offset);
 		}
 
 		/*
@@ -2668,13 +2670,13 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		 */
 		if ((leading != frag->leading) ||
 		    (trailing != frag->trailing))
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
 
@@ -2693,7 +2695,7 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
 	void *dst;
 
 	if (!fragment)
-		return error("missing binary patch data for '%s'",
+		return error(_("missing binary patch data for '%s'"),
 			     patch->new_name ?
 			     patch->new_name :
 			     patch->old_name);
@@ -2790,13 +2792,13 @@ static int apply_binary(struct image *img, struct patch *patch)
 		 * in the patch->fragments->{patch,size}.
 		 */
 		if (apply_binary_fragment(img, patch))
-			return error("binary patch does not apply to '%s'",
+			return error(_("binary patch does not apply to '%s'"),
 				     name);
 
 		/* verify that the result matches */
 		hash_sha1_file(img->buf, img->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
-			return error("binary patch to '%s' creates incorrect result (expecting %s, got %s)",
+			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
 				name, patch->new_sha1_prefix, sha1_to_hex(sha1));
 	}
 
@@ -2817,7 +2819,7 @@ static int apply_fragments(struct image *img, struct patch *patch)
 	while (frag) {
 		nth++;
 		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
-			error("patch failed: %s:%ld", name, frag->oldpos);
+			error(_("patch failed: %s:%ld"), name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
 			frag->rejected = 1;
@@ -2932,14 +2934,14 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	if (!(patch->is_copy || patch->is_rename) &&
 	    (tpatch = in_fn_table(patch->old_name)) != NULL && !to_be_deleted(tpatch)) {
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
@@ -2953,7 +2955,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 			}
 		} else {
 			if (read_old_data(st, patch->old_name, &buf))
-				return error("read of %s failed", patch->old_name);
+				return error(_("read of %s failed"), patch->old_name);
 		}
 	}
 
@@ -2968,7 +2970,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
-		return error("removal patch leaves file contents");
+		return error(_("removal patch leaves file contents"));
 
 	return 0;
 }
@@ -2989,7 +2991,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		if (has_symlink_leading_path(new_name, strlen(new_name)))
 			return 0;
 
-		return error("%s: already exists in working directory", new_name);
+		return error(_("%s: already exists in working directory"), new_name);
 	}
 	else if ((errno != ENOENT) && (errno != ENOTDIR))
 		return error("%s: %s", new_name, strerror(errno));
@@ -3027,12 +3029,12 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (!(patch->is_copy || patch->is_rename) &&
 	    (tpatch = in_fn_table(old_name)) != NULL && !to_be_deleted(tpatch)) {
 		if (was_deleted(tpatch))
-			return error("%s: has been deleted/renamed", old_name);
+			return error(_("%s: has been deleted/renamed"), old_name);
 		st_mode = tpatch->new_mode;
 	} else if (!cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
-			return error("%s: %s", old_name, strerror(errno));
+			return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
 	if (to_be_deleted(tpatch))
@@ -3043,7 +3045,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
-			return error("%s: does not exist in index", old_name);
+			return error(_("%s: does not exist in index"), old_name);
 		}
 		*ce = active_cache[pos];
 		if (stat_ret < 0) {
@@ -3057,13 +3059,13 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 				return -1;
 		}
 		if (!cached && verify_index_match(*ce, st))
-			return error("%s: does not match index", old_name);
+			return error(_("%s: does not match index"), old_name);
 		if (cached)
 			st_mode = (*ce)->ce_mode;
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
 			goto is_new;
-		return error("%s: %s", old_name, strerror(errno));
+		return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
 	if (!cached && !tpatch)
@@ -3074,9 +3076,9 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (!patch->old_mode)
 		patch->old_mode = st_mode;
 	if ((st_mode ^ patch->old_mode) & S_IFMT)
-		return error("%s: wrong type", old_name);
+		return error(_("%s: wrong type"), old_name);
 	if (st_mode != patch->old_mode)
-		warning("%s has type %o, expected %o",
+		warning(_("%s has type %o, expected %o"),
 			old_name, st_mode, patch->old_mode);
 	if (!patch->new_mode && !patch->is_delete)
 		patch->new_mode = st_mode;
@@ -3126,7 +3128,7 @@ static int check_patch(struct patch *patch)
 		if (check_index &&
 		    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 		    !ok_if_exists)
-			return error("%s: already exists in index", new_name);
+			return error(_("%s: already exists in index"), new_name);
 		if (!cached) {
 			int err = check_to_create_blob(new_name, ok_if_exists);
 			if (err)
@@ -3145,13 +3147,13 @@ static int check_patch(struct patch *patch)
 		if (!patch->new_mode)
 			patch->new_mode = patch->old_mode;
 		if ((patch->old_mode ^ patch->new_mode) & S_IFMT)
-			return error("new mode (%o) of %s does not match old mode (%o)%s%s",
+			return error(_("new mode (%o) of %s does not match old mode (%o)%s%s"),
 				patch->new_mode, new_name, patch->old_mode,
 				same ? "" : " of ", same ? "" : old_name);
 	}
 
 	if (apply_data(patch, &st, ce) < 0)
-		return error("%s: patch does not apply", name);
+		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
 	return 0;
 }
@@ -3219,7 +3221,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 
 		ce = make_cache_entry(patch->old_mode, sha1_ptr, name, 0, 0);
 		if (!ce)
-			die("make_cache_entry failed for path '%s'", name);
+			die(_("make_cache_entry failed for path '%s'"), name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
 			die ("Could not add %s to temporary index", name);
 	}
@@ -3362,7 +3364,7 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 {
 	if (update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
-			die("unable to remove %s from index", patch->old_name);
+			die(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
@@ -3389,19 +3391,19 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 		const char *s = buf;
 
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
-			die("unable to create backing store for newly created file %s", path);
+			die(_("unable to create backing store for newly created file %s"), path);
 	}
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-		die("unable to add cache entry for %s", path);
+		die(_("unable to add cache entry for %s"), path);
 }
 
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
@@ -3434,7 +3436,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0)
-		die_errno("closing file '%s'", path);
+		die_errno(_("closing file '%s'"), path);
 	return 0;
 }
 
@@ -3483,7 +3485,7 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 			++nr;
 		}
 	}
-	die_errno("unable to write file '%s' mode %o", path, mode);
+	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
 static void create_file(struct patch *patch)
@@ -3546,7 +3548,7 @@ static int write_out_one_reject(struct patch *patch)
 	 * contents are marked "rejected" at the patch level.
 	 */
 	if (!patch->new_name)
-		die("internal error");
+		die(_("internal error"));
 
 	/* Say this even without --verbose */
 	say_patch_name(stderr, "Applying patch ", patch, " with");
@@ -3555,7 +3557,7 @@ static int write_out_one_reject(struct patch *patch)
 	cnt = strlen(patch->new_name);
 	if (ARRAY_SIZE(namebuf) <= cnt + 5) {
 		cnt = ARRAY_SIZE(namebuf) - 5;
-		warning("truncating .rej filename to %.*s.rej",
+		warning(_("truncating .rej filename to %.*s.rej"),
 			cnt - 1, patch->new_name);
 	}
 	memcpy(namebuf, patch->new_name, cnt);
@@ -3563,7 +3565,7 @@ static int write_out_one_reject(struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error("cannot open %s: %s", namebuf, strerror(errno));
+		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git nor give extended
@@ -3576,10 +3578,10 @@ static int write_out_one_reject(struct patch *patch)
 	     frag;
 	     cnt++, frag = frag->next) {
 		if (!frag->rejected) {
-			fprintf(stderr, "Hunk #%d applied cleanly.\n", cnt);
+			fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
 			continue;
 		}
-		fprintf(stderr, "Rejected hunk #%d.\n", cnt);
+		fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
 		fprintf(rej, "%.*s", frag->size, frag->patch);
 		if (frag->patch[frag->size-1] != '\n')
 			fputc('\n', rej);
@@ -3720,7 +3722,7 @@ static int apply_patch(int fd, const char *filename, int options)
 	}
 
 	if (!list && !skipped_patch)
-		die("unrecognized input");
+		die(_("unrecognized input"));
 
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
@@ -3731,7 +3733,7 @@ static int apply_patch(int fd, const char *filename, int options)
 
 	if (check_index) {
 		if (read_cache() < 0)
-			die("unable to read index file");
+			die(_("unable to read index file"));
 	}
 
 	if ((check || apply) &&
@@ -3844,66 +3846,66 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	const char *whitespace_option = NULL;
 
 	struct option builtin_apply_options[] = {
-		{ OPTION_CALLBACK, 0, "exclude", NULL, "path",
-			"don't apply changes matching the given path",
+		{ OPTION_CALLBACK, 0, "exclude", NULL, N_("path"),
+			N_("don't apply changes matching the given path"),
 			0, option_parse_exclude },
-		{ OPTION_CALLBACK, 0, "include", NULL, "path",
-			"apply changes matching the given path",
+		{ OPTION_CALLBACK, 0, "include", NULL, N_("path"),
+			N_("apply changes matching the given path"),
 			0, option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, NULL, "num",
-			"remove <num> leading slashes from traditional diff paths",
+		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
 		OPT_BOOLEAN(0, "no-add", &no_add,
-			"ignore additions made by the patch"),
+			N_("ignore additions made by the patch")),
 		OPT_BOOLEAN(0, "stat", &diffstat,
-			"instead of applying the patch, output diffstat for the input"),
+			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOLEAN(0, "numstat", &numstat,
-			"shows number of added and deleted lines in decimal notation"),
+			N_("shows number of added and deleted lines in decimal notation")),
 		OPT_BOOLEAN(0, "summary", &summary,
-			"instead of applying the patch, output a summary for the input"),
+			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOLEAN(0, "check", &check,
-			"instead of applying the patch, see if the patch is applicable"),
+			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOLEAN(0, "index", &check_index,
-			"make sure the patch is applicable to the current index"),
+			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOLEAN(0, "cached", &cached,
-			"apply a patch without touching the working tree"),
+			N_("apply a patch without touching the working tree")),
 		OPT_BOOLEAN(0, "apply", &force_apply,
-			"also apply the patch (use with --stat/--summary/--check)"),
+			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
-			"build a temporary index based on embedded index information"),
+			N_("build a temporary index based on embedded index information")),
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			"paths are separated with NUL character",
+			N_("paths are separated with NUL character"),
 			PARSE_OPT_NOARG, option_parse_z },
 		OPT_INTEGER('C', NULL, &p_context,
-				"ensure at least <n> lines of context match"),
-		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
-			"detect new or modified lines that have whitespace errors",
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
+			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
-			"ignore changes in whitespace when finding context",
+			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
-			"ignore changes in whitespace when finding context",
+			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
-			"apply the patch in reverse"),
+			N_("apply the patch in reverse")),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
-			"don't expect at least one line of context"),
+			N_("don't expect at least one line of context")),
 		OPT_BOOLEAN(0, "reject", &apply_with_reject,
-			"leave the rejected hunks in corresponding *.rej files"),
+			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOLEAN(0, "allow-overlap", &allow_overlap,
-			"allow overlapping hunks"),
-		OPT__VERBOSE(&apply_verbosely, "be verbose"),
+			N_("allow overlapping hunks")),
+		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
-			"tolerate incorrectly detected missing new-line at the end of file",
+			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			INACCURATE_EOF),
 		OPT_BIT(0, "recount", &options,
-			"do not trust the line counts in the hunk headers",
+			N_("do not trust the line counts in the hunk headers"),
 			RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", NULL, "root",
-			"prepend <root> to all filenames",
+		{ OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
+			N_("prepend <root> to all filenames"),
 			0, option_parse_directory },
 		OPT_END()
 	};
@@ -3924,10 +3926,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
 		apply = 0;
 	if (check_index && is_not_gitdir)
-		die("--index outside a repository");
+		die(_("--index outside a repository"));
 	if (cached) {
 		if (is_not_gitdir)
-			die("--cached outside a repository");
+			die(_("--cached outside a repository"));
 		check_index = 1;
 	}
 	for (i = 0; i < argc; i++) {
@@ -3943,7 +3945,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
-			die_errno("can't open patch '%s'", arg);
+			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(fd, arg, options);
@@ -3957,32 +3959,32 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		    squelch_whitespace_errors < whitespace_error) {
 			int squelched =
 				whitespace_error - squelch_whitespace_errors;
-			warning("squelched %d "
-				"whitespace error%s",
-				squelched,
-				squelched == 1 ? "" : "s");
+			warning(Q_("squelched %d whitespace error",
+				   "squelched %d whitespace errors",
+				   squelched),
+				squelched);
 		}
 		if (ws_error_action == die_on_ws_error)
-			die("%d line%s add%s whitespace errors.",
-			    whitespace_error,
-			    whitespace_error == 1 ? "" : "s",
-			    whitespace_error == 1 ? "s" : "");
+			die(Q_("%d line adds whitespace errors.",
+			       "%d lines add whitespace errors.",
+			       whitespace_error),
+			    whitespace_error);
 		if (applied_after_fixing_ws && apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
 				applied_after_fixing_ws == 1 ? "" : "s");
 		else if (whitespace_error)
-			warning("%d line%s add%s whitespace errors.",
-				whitespace_error,
-				whitespace_error == 1 ? "" : "s",
-				whitespace_error == 1 ? "s" : "");
+			warning(Q_("%d line adds whitespace errors.",
+				   "%d lines add whitespace errors.",
+				   whitespace_error),
+				whitespace_error);
 	}
 
 	if (update_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
 
 	return !!errs;
-- 
1.7.3.1.256.g2539c.dirty
