Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11382211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLFWPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:15:32 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38564 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLFWPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:15:31 -0500
Received: by mail-yb1-f193.google.com with SMTP id d187so1527135ybb.5
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6F3kR2Nwqa53dDIBFfv8wgV57ujdTVscV6fx6bZzMsA=;
        b=tbIYk7R5JAmPhEs/qMzXFYrKdZ/QNVSqsXzEs404L3gWWtCny8qFLsh45BELJ9K6aT
         a/zxf1OWZ9huySka+RWvyXIHVoWX4+xeooKke60HUyWi3Ive1PpPVgyzwfdirn79fHWR
         OGxax0giF3KlvAnxJF22Ft/VicN8V8akledo6lsMOfVO2+rP6z1UC+rg1Fr/Auk6WE7i
         AKR/Rz1SRLtM0Rcxftz6ecBYMhUONntMUmjKf1NY45tXvoMwiuBFlEXLuIw7cH3OkBSl
         JdN6ssG6EZvwEmW7waTTrSF7UjaTeiTAGuAmVcyNNfzuqE0SNnR03hZUfg2bqDKg4jXW
         3UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6F3kR2Nwqa53dDIBFfv8wgV57ujdTVscV6fx6bZzMsA=;
        b=hNYmqvb7r9qcjbwM3vHtPz3z9pEqN7OrRyfH5dxLJVUxrld/Gcm2ngaPU2M1u1+w6B
         aKeR/fICn+9xjkAPOKHZafjAwxviOn11AdRNLYAa5sjnuTQl+UCc+tTmHll3vWgg5sIU
         XhO1CxhbMgrQghIn4oWiI0UOAS5J00Y2z3Qh/nyyMs9gq2MaiTAML5RsmBcPwuakGHik
         SlPxJ/177oakuXhscolhnC2qOHpMGIYzljmgx/GXXG2izvqWT3hEwiq0qD4YHWfmcU+S
         6FSWYUDLucPrXPrCIQ3riOWtRD2MYS+elaIcZ0USxNraFxRwQNDMmJQgR2ltQSts7Nda
         w0Dg==
X-Gm-Message-State: AA+aEWa5JhlO1tWXLtnLE8Ja+U8SZgzt7jCdrT7iTD/HPh2b9m0uGvQF
        A3504FSiTL4u1QPNXTBR2KK7QCCg
X-Google-Smtp-Source: AFSGD/V+xpueRguTTKfaJIe/yl1ADiL1EDf+ZxTuPd4Qmrgeh8auNUVVJ92ZWmViCIZn0rR/gDJivg==
X-Received: by 2002:a25:8446:: with SMTP id r6mr4033384ybm.474.1544134529946;
        Thu, 06 Dec 2018 14:15:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:9040])
        by smtp.gmail.com with ESMTPSA id u84sm412493ywb.12.2018.12.06.14.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:15:28 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:15:26 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        kernel-team@fb.com
Subject: Re: [RFC] cherry-pick notes to find out cherry-picks from the origin
Message-ID: <20181206221526.GP2509588@devbig004.ftw2.facebook.com>
References: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
 <20181115144044.GA16450@sigill.intra.peff.net>
 <20181205161103.GO2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205161103.GO2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Jeff.

So, this is what I currently have.  It still does the same thing but a
lot more generic in terms of both interface and implementation.

* All core logics are implemented as core helpers / features.

  * Trailer parsing and reverse-mapping in trailer_rev_xrefs_*().

  * Note refs which start with xref- (cross-reference) are recognized
    by notes core.  When notes are added, a dedicated combine_notes
    function is used to remove duplicates and curl unreachable
    commits.  When xref- notes are formatted for printing, it
    automatically follows and prints nested xrefs.

* note-cherry-picks is replaced with reverse-trailer-xrefs which can
  use other trailers, note refs and tags.  --xref-cherry-picks option
  makes it use the cherry-pick presets.

Please note that the patch is still a bit rough.  I'm polishing and
documenting.  Please let me know what you think.

Thanks.

---
 Makefile                        |    1 
 builtin.h                       |    1 
 builtin/reverse-trailer-xrefs.c |  148 ++++++++++++++++++++++++
 git.c                           |    1 
 notes.c                         |  245 +++++++++++++++++++++++++++++++++++++++-
 notes.h                         |   10 +
 object.c                        |    4 
 object.h                        |    6 
 trailer.c                       |  102 ++++++++++++++++
 trailer.h                       |   26 ++++
 10 files changed, 540 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 1a44c811a..3c23ecf9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,6 +1086,7 @@ BUILTIN_OBJS += builtin/multi-pack-index.o
 BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
+BUILTIN_OBJS += builtin/reverse-trailer-xrefs.o
 BUILTIN_OBJS += builtin/pack-objects.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
diff --git a/builtin.h b/builtin.h
index 6538932e9..51089e258 100644
--- a/builtin.h
+++ b/builtin.h
@@ -195,6 +195,7 @@ extern int cmd_multi_pack_index(int argc, const char **argv, const char *prefix)
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_notes(int argc, const char **argv, const char *prefix);
+extern int cmd_reverse_trailer_xrefs(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
diff --git a/builtin/reverse-trailer-xrefs.c b/builtin/reverse-trailer-xrefs.c
new file mode 100644
index 000000000..b2879be6c
--- /dev/null
+++ b/builtin/reverse-trailer-xrefs.c
@@ -0,0 +1,148 @@
+#include "builtin.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "repository.h"
+#include "config.h"
+#include "commit.h"
+#include "blob.h"
+#include "notes.h"
+#include "notes-utils.h"
+#include "trailer.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "object-store.h"
+#include "parse-options.h"
+
+static const char * const reverse_trailer_xrefs_usage[] = {
+	N_("git reverse_trailer_xrefs [<options>] [<commit-ish>...]"),
+	NULL
+};
+
+static const char cherry_picked_prefix[] = "(cherry picked from commit ";
+static int verbose;
+
+static void clear_trailer_xref_note(struct commit *commit, void *data)
+{
+	struct notes_tree *tree = data;
+	int status;
+
+	status = remove_note(tree, commit->object.oid.hash);
+
+	if (verbose) {
+		if (status)
+			fprintf(stderr, "Object %s has no note\n",
+				oid_to_hex(&commit->object.oid));
+		else
+			fprintf(stderr, "Removing note for object %s\n",
+				oid_to_hex(&commit->object.oid));
+	}
+}
+
+static void record_trailer_xrefs(struct commit *commit, void *data)
+{
+	trailer_rev_xrefs_record(data, commit);
+}
+
+static int note_trailer_xrefs(struct notes_tree *tree,
+			      struct commit *from_commit, struct object_array *to_objs,
+			      const char *tag)
+{
+	char from_hex[GIT_MAX_HEXSZ + 1];
+	struct strbuf note = STRBUF_INIT;
+	struct object_id note_oid;
+	int i, ret;
+
+	oid_to_hex_r(from_hex, &from_commit->object.oid);
+
+	for (i = 0; i < to_objs->nr; i++) {
+		const char *hex = to_objs->objects[i].name;
+
+		if (tag)
+			strbuf_addf(&note, "%s: %s\n", tag, hex);
+		else
+			strbuf_addf(&note, "%s\n", tag);
+		if (verbose)
+			fprintf(stderr, "Adding note %s -> %s\n", from_hex, hex);
+	}
+
+	ret = write_object_file(note.buf, note.len, blob_type, &note_oid);
+	strbuf_release(&note);
+	if (ret)
+		return ret;
+
+	ret = add_note(tree, &from_commit->object.oid, &note_oid, NULL);
+	return ret;
+}
+
+int cmd_reverse_trailer_xrefs(int argc, const char **argv, const char *prefix)
+{
+	static struct notes_tree tree;
+	struct rev_info revs;
+	int i, ret;
+	struct setup_revision_opt s_r_opt = {
+		.def = "HEAD",
+		.revarg_opt = REVARG_CANNOT_BE_FILENAME
+	};
+	int cherry = 0, clear = 0;
+	const char *trailer_prefix = NULL, *notes_ref = NULL, *tag = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "xref-cherry-picks", &cherry, N_("use options for xref-cherry-picks notes")),
+		OPT_STRING(0, "trailer-prefix", &trailer_prefix, N_("prefix"), N_("process trailers starting with <prefix>")),
+		OPT_STRING(0, "ref", &notes_ref, N_("notes-ref"), N_("update notes in <notes-ref>")),
+		OPT_STRING(0, "tag", &tag, N_("tag"), N_("tag xref notes with <tag>")),
+		OPT_BOOL(0, "clear", &clear, N_("clear trailer xref notes from the specified commits")),
+		OPT__VERBOSE(&verbose, N_("verbose")),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	init_revisions(&revs, prefix);
+	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
+	argc = parse_options(argc, argv, prefix, options,
+			     reverse_trailer_xrefs_usage, 0);
+
+	/* allow inidividual options to override parts of --cherry */
+	if (cherry) {
+		if (!trailer_prefix)
+			trailer_prefix = cherry_picked_prefix;
+		if (!notes_ref)
+			notes_ref = NOTES_CHERRY_PICKS_REF;
+		if (!tag)
+			tag = NOTES_CHERRY_PICKED_TO_TAG;
+	}
+
+	if (!notes_ref || (!clear && (!trailer_prefix || !tag)))
+		die(_("insufficient arguments"));
+
+	if (argc > 1)
+		die(_("unrecognized argument: %s"), argv[1]);
+
+	if (!tree.initialized)
+		init_notes(&tree, notes_ref, NULL, NOTES_INIT_WRITABLE);
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	if (clear) {
+		traverse_commit_list(&revs, clear_trailer_xref_note, NULL, &tree);
+	} else {
+		struct trailer_rev_xrefs rxrefs;
+		struct commit *from_commit;
+		struct object_array *to_objs;
+
+		trailer_rev_xrefs_init(&rxrefs, trailer_prefix);
+		traverse_commit_list(&revs, record_trailer_xrefs, NULL, &rxrefs);
+
+		trailer_rev_xrefs_for_each(&rxrefs, i, from_commit, to_objs) {
+			ret = note_trailer_xrefs(&tree, from_commit, to_objs,
+						 tag);
+			if (ret)
+				return ret;
+		}
+	}
+
+	commit_notes(&tree, "Notes updated by 'git reverse-trailer-xrefs'");
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 2f604a41e..4948c8e01 100644
--- a/git.c
+++ b/git.c
@@ -515,6 +515,7 @@ static struct cmd_struct commands[] = {
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
+	{ "reverse-trailer-xrefs", cmd_reverse_trailer_xrefs, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
diff --git a/notes.c b/notes.c
index 25cdce28b..c32064bfe 100644
--- a/notes.c
+++ b/notes.c
@@ -9,6 +9,7 @@
 #include "tree-walk.h"
 #include "string-list.h"
 #include "refs.h"
+#include "hashmap.h"
 
 /*
  * Use a non-balancing simple 16-tree structure with struct int_node as
@@ -79,6 +80,10 @@ static struct notes_tree **display_notes_trees;
 
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct int_node *node, unsigned int n);
+static void parse_xref_note(const char *note, unsigned long size,
+			    const struct object_id *commit_oid,
+			    struct object_array *result,
+			    struct string_list *result_lines);
 
 /*
  * Search the tree until the appropriate location for the given key is found:
@@ -914,6 +919,60 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	return ret;
 }
 
+int combine_notes_cat_xrefs(struct object_id *cur_oid,
+			    const struct object_id *new_oid)
+{
+	char *cur_msg = NULL, *new_msg = NULL;
+	unsigned long cur_len, new_len;
+	enum object_type cur_type, new_type;
+	struct object_array xrefs = OBJECT_ARRAY_INIT;
+	struct string_list lines = STRING_LIST_INIT_DUP;
+	struct strbuf output = STRBUF_INIT;
+	int i, j, cur_nr, ret;
+
+	/* read in both note blob objects */
+	if (!is_null_oid(new_oid))
+		new_msg = read_object_file(new_oid, &new_type, &new_len);
+	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
+		free(new_msg);
+		return 0;
+	}
+	if (!is_null_oid(cur_oid))
+		cur_msg = read_object_file(cur_oid, &cur_type, &cur_len);
+	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
+		free(cur_msg);
+		free(new_msg);
+		oidcpy(cur_oid, new_oid);
+		return 0;
+	}
+
+	/* parse xrefs and de-dup */
+	parse_xref_note(cur_msg, cur_len, NULL, &xrefs, &lines);
+	cur_nr = xrefs.nr;
+	parse_xref_note(new_msg, new_len, NULL, &xrefs, &lines);
+
+	for (i = 0; i < cur_nr; i++)
+		for (j = cur_nr; j < xrefs.nr; j++)
+			if (!strcmp(xrefs.objects[i].name,
+				    xrefs.objects[j].name))
+				lines.items[j].string[0] = '\0';
+
+	/* write out the combined object */
+	for (i = 0; i < lines.nr; i++)
+		if (lines.items[i].string[0] != '\0')
+			strbuf_addf(&output, "%s\n", lines.items[i].string);
+
+	ret = write_object_file(output.buf, output.len, blob_type, cur_oid);
+
+	strbuf_release(&output);
+	object_array_clear(&xrefs);
+	string_list_clear(&lines, 0);
+	free(cur_msg);
+	free(new_msg);
+
+	return ret;
+}
+
 static int string_list_add_one_ref(const char *refname, const struct object_id *oid,
 				   int flag, void *cb)
 {
@@ -996,8 +1055,12 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	if (!notes_ref)
 		notes_ref = default_notes_ref();
 
-	if (!combine_notes)
-		combine_notes = combine_notes_concatenate;
+	if (!combine_notes) {
+		if (starts_with(notes_ref, "refs/notes/xref-"))
+			combine_notes = combine_notes_cat_xrefs;
+		else
+			combine_notes = combine_notes_concatenate;
+	}
 
 	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
@@ -1189,6 +1252,67 @@ void free_notes(struct notes_tree *t)
 	memset(t, 0, sizeof(struct notes_tree));
 }
 
+/*
+ * Parse a "[TAG:]HEX" line.  @xref is trimmed.  If @tag_p is not NULL and
+ * TAG exists, the string is split.  Returns the pointer to the OID and
+ * *@tag_p is updated to the TAG if requested.
+ */
+static char *parse_xref(char *xref, char **tag_p)
+{
+	char *p, *hex;
+
+	while (isspace(*xref))
+		xref++;
+
+	p = strchr(xref, ':');
+	if (p) {
+		if (tag_p) {
+			*tag_p = xref;
+			*p = '\0';
+		}
+		p++;
+		while (isspace(*p))
+			p++;
+		hex = p;
+	} else {
+		if (tag_p)
+			*tag_p = NULL;
+		hex = xref;
+	}
+
+	p = hex;
+	while (*p != '\0' && !isspace(*p))
+		p++;
+	*p = '\0';
+	return hex;
+}
+
+static void walk_xrefs(const char *tree_ref, struct object_id *from_oid,
+		       struct strbuf *sb, int level)
+{
+	struct object_array xrefs = OBJECT_ARRAY_INIT;
+	struct string_list lines = STRING_LIST_INIT_DUP;
+	int i;
+
+	read_xref_note(tree_ref, from_oid, &xrefs, &lines);
+
+	for (i = 0; i < xrefs.nr; i++) {
+		char *line = lines.items[i].string;
+		char *tag;
+
+		parse_xref(line, &tag);
+		strbuf_addf(sb, "    %s%s%*s%s\n",
+			    tag ?: "", tag ? ": " : "", 2 * level, "",
+			    xrefs.objects[i].name);
+		if (xrefs.objects[i].item)
+			walk_xrefs(tree_ref, &xrefs.objects[i].item->oid, sb,
+				   level + 1);
+	}
+
+	object_array_clear(&xrefs);
+	string_list_clear(&lines, 0);
+}
+
 /*
  * Fill the given strbuf with the notes associated with the given object.
  *
@@ -1208,6 +1332,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
+	int format_xrefs;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -1250,6 +1375,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 		}
 	}
 
+	format_xrefs = !raw && starts_with(t->ref, "refs/notes/xref-");
+
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
@@ -1257,6 +1384,14 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
+
+		if (format_xrefs) {
+			struct object_id oid;
+
+			msg_p[linelen] = '\0';
+			if (!get_oid_hex(parse_xref(msg_p, NULL), &oid))
+				walk_xrefs(t->ref, &oid, sb, 1);
+		}
 	}
 
 	free(msg);
@@ -1309,3 +1444,109 @@ void expand_loose_notes_ref(struct strbuf *sb)
 		expand_notes_ref(sb);
 	}
 }
+
+struct notes_tree_entry {
+	struct hashmap_entry ent;
+	struct notes_tree tree;
+};
+
+static int notes_tree_cmp(const void *hashmap_cmp_fn_data,
+			  const void *entry, const void *entry_or_key,
+			  const void *keydata)
+{
+	const struct notes_tree_entry *e1 = entry;
+	const struct notes_tree_entry *e2 = entry_or_key;
+
+	return strcmp(e1->tree.ref, e2->tree.ref);
+}
+
+static void parse_xref_note(const char *note, unsigned long size,
+			    const struct object_id *commit_oid,
+			    struct object_array *result,
+			    struct string_list *result_lines)
+{
+	struct strbuf **lines, **pline;
+
+	lines = strbuf_split_buf(note, size, '\n', 0);
+
+	for (pline = lines; *pline; pline++) {
+		struct strbuf *line = *pline;
+		const char *target_hex;
+		struct object_id target_oid;
+		struct object *target_obj;
+
+		target_hex = parse_xref(line->buf, NULL);
+		if (get_oid_hex(target_hex, &target_oid)) {
+			if (commit_oid)
+				warning("read invalid sha1 on %s: %s",
+					oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		target_obj = parse_object(the_repository, &target_oid);
+		if (!target_obj || target_obj->type != OBJ_COMMIT) {
+			if (commit_oid)
+				warning("read invalid commit on %s: %s",
+					oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		add_object_array(target_obj, target_hex, result);
+		if (result_lines) {
+			assert(result_lines->strdup_strings);
+			string_list_append(result_lines, line->buf);
+		}
+	}
+
+	strbuf_list_free(lines);
+}
+
+/*
+ * Read a cross-referencing note.
+ *
+ * Notes in @notes_ref contains lines of "[TAG:]HEX" pointing to other
+ * commits.  Read the target commits and add the objects to @result.  If
+ * @result_lines is non-NULL, it should point to a strdup'ing string_list.
+ * The verbatim note lines matching the target commits are appened to the
+ * list.
+ */
+void read_xref_note(const char *notes_ref, const struct object_id *commit_oid,
+		    struct object_array *result,
+		    struct string_list *result_lines)
+{
+	static struct hashmap *notes_tree_map = NULL;
+	unsigned hash = memhash(notes_ref, strlen(notes_ref));
+	struct notes_tree_entry key, *ent;
+	const struct object_id *note_oid;
+	unsigned long size;
+	enum object_type type;
+	char *note;
+
+	if (!notes_tree_map) {
+		notes_tree_map = xcalloc(1, sizeof(struct hashmap));
+		hashmap_init(notes_tree_map, notes_tree_cmp, NULL, 0);
+	}
+
+	hashmap_entry_init(&key.ent, hash);
+	key.tree.ref = (char *)notes_ref;
+	ent = hashmap_get(notes_tree_map, &key, NULL);
+	if (!ent) {
+		ent = xcalloc(1, sizeof(struct notes_tree_entry));
+		init_notes(&ent->tree, notes_ref, NULL, 0);
+		hashmap_entry_init(&ent->ent, hash);
+		hashmap_put(notes_tree_map, ent);
+	}
+
+	note_oid = get_note(&ent->tree, commit_oid);
+	if (!note_oid)
+		return;
+
+	note = read_object_file(note_oid, &type, &size);
+	if (!size) {
+		free(note);
+		return;
+	}
+
+	parse_xref_note(note, size, commit_oid, result, result_lines);
+	free(note);
+}
diff --git a/notes.h b/notes.h
index 414bc6855..fb8153334 100644
--- a/notes.h
+++ b/notes.h
@@ -2,10 +2,14 @@
 #define NOTES_H
 
 #include "string-list.h"
+#include "object.h"
 
 struct object_id;
 struct strbuf;
 
+#define NOTES_CHERRY_PICKS_REF		"refs/notes/xref-cherry-picks"
+#define NOTES_CHERRY_PICKED_TO_TAG	"Cherry-picked-to"
+
 /*
  * Function type for combining two notes annotating the same object.
  *
@@ -38,6 +42,8 @@ int combine_notes_ignore(struct object_id *cur_oid,
 			 const struct object_id *new_oid);
 int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 				const struct object_id *new_oid);
+int combine_notes_cat_xrefs(struct object_id *cur_oid,
+			    const struct object_id *new_oid);
 
 /*
  * Notes tree object
@@ -317,4 +323,8 @@ void expand_notes_ref(struct strbuf *sb);
  */
 void expand_loose_notes_ref(struct strbuf *sb);
 
+void read_xref_note(const char *notes_ref, const struct object_id *commit_oid,
+		    struct object_array *result,
+		    struct string_list *result_lines);
+
 #endif
diff --git a/object.c b/object.c
index e54160550..f79652a34 100644
--- a/object.c
+++ b/object.c
@@ -404,7 +404,7 @@ void object_array_clear(struct object_array *array)
 /*
  * Return true iff array already contains an entry with name.
  */
-static int contains_name(struct object_array *array, const char *name)
+int object_array_contains_name(struct object_array *array, const char *name)
 {
 	unsigned nr = array->nr, i;
 	struct object_array_entry *object = array->objects;
@@ -422,7 +422,7 @@ void object_array_remove_duplicates(struct object_array *array)
 
 	array->nr = 0;
 	for (src = 0; src < nr; src++) {
-		if (!contains_name(array, objects[src].name)) {
+		if (!object_array_contains_name(array, objects[src].name)) {
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
 			array->nr++;
diff --git a/object.h b/object.h
index 796792cb3..a0b3dd312 100644
--- a/object.h
+++ b/object.h
@@ -172,6 +172,12 @@ typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data);
 
+/*
+ * Returns 1 if array already contains an entry with the specified name.
+ * Otherwise, 0.
+ */
+int object_array_contains_name(struct object_array *array, const char *name);
+
 /*
  * Remove from array all but the first entry with a given name.
  * Warning: this function uses an O(N^2) algorithm.
diff --git a/trailer.c b/trailer.c
index 0796f326b..3afa38d25 100644
--- a/trailer.c
+++ b/trailer.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "string-list.h"
 #include "run-command.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tempfile.h"
 #include "trailer.h"
@@ -1170,3 +1171,104 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	format_trailer_info(out, &info, opts);
 	trailer_info_release(&info);
 }
+
+implement_static_commit_slab(trailer_rxrefs_slab, struct object_array *);
+
+static struct object_array *get_trailer_rxrefs(
+			struct trailer_rev_xrefs *rxrefs, struct commit *commit)
+{
+	struct object_array **slot =
+		trailer_rxrefs_slab_peek(&rxrefs->slab, commit);
+
+	return slot ? *slot : NULL;
+}
+
+static struct object_array *get_create_trailer_rxrefs(
+			struct trailer_rev_xrefs *rxrefs, struct commit *commit)
+{
+	struct object_array **slot =
+		trailer_rxrefs_slab_at(&rxrefs->slab, commit);
+
+	if (*slot)
+		return *slot;
+
+	add_object_array(&commit->object, oid_to_hex(&commit->object.oid),
+			 &rxrefs->from_commits);
+	*slot = xmalloc(sizeof(struct object_array));
+	**slot = (struct object_array)OBJECT_ARRAY_INIT;
+	return *slot;
+}
+
+void trailer_rev_xrefs_init(struct trailer_rev_xrefs *rxrefs, const char *tag)
+{
+	rxrefs->tag = xstrdup(tag);
+	rxrefs->tag_len = strlen(tag);
+	init_trailer_rxrefs_slab(&rxrefs->slab);
+	rxrefs->from_commits = (struct object_array)OBJECT_ARRAY_INIT;
+}
+
+void trailer_rev_xrefs_record(struct trailer_rev_xrefs *rxrefs,
+			      struct commit *commit)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	struct trailer_info info;
+	int i;
+
+	buffer = read_object_file(&commit->object.oid, &type, &size);
+	trailer_info_get(&info, buffer, &opts);
+
+	/* when nested, the last trailer describes the latest cherry-pick */
+	for (i = info.trailer_nr - 1; i >= 0; i--) {
+		char *line = info.trailers[i];
+
+		if (starts_with(line, rxrefs->tag)) {
+			struct object_id from_oid;
+			struct object *from_object;
+			struct commit *from_commit;
+			struct object_array *to_objs;
+			char cherry_hex[GIT_MAX_HEXSZ + 1];
+
+			if (get_oid_hex(line + rxrefs->tag_len, &from_oid))
+				continue;
+
+			from_object = parse_object(the_repository, &from_oid);
+			if (!from_object || from_object->type != OBJ_COMMIT)
+				continue;
+
+			from_commit = (struct commit *)from_object;
+			to_objs = get_create_trailer_rxrefs(rxrefs, from_commit);
+
+			oid_to_hex_r(cherry_hex, &commit->object.oid);
+			add_object_array(&commit->object, cherry_hex, to_objs);
+			break;
+		}
+	}
+
+	free(buffer);
+}
+
+void trailer_rev_xrefs_release(struct trailer_rev_xrefs *rxrefs)
+{
+	clear_trailer_rxrefs_slab(&rxrefs->slab);
+	object_array_clear(&rxrefs->from_commits);
+	free(rxrefs->tag);
+}
+
+void trailer_rev_xrefs_next(struct trailer_rev_xrefs *rxrefs, int *idx_p,
+			    struct commit **from_commit_p,
+			    struct object_array **to_objs_p)
+{
+	if (*idx_p >= rxrefs->from_commits.nr) {
+		*from_commit_p = NULL;
+		*to_objs_p = NULL;
+		return;
+	}
+
+	*from_commit_p = (struct commit *)
+		rxrefs->from_commits.objects[*idx_p].item;
+	*to_objs_p = get_trailer_rxrefs(rxrefs, *from_commit_p);
+	(*idx_p)++;
+}
diff --git a/trailer.h b/trailer.h
index b99773964..5a9704e19 100644
--- a/trailer.h
+++ b/trailer.h
@@ -2,6 +2,8 @@
 #define TRAILER_H
 
 #include "list.h"
+#include "object.h"
+#include "commit-slab.h"
 
 struct strbuf;
 
@@ -99,4 +101,28 @@ void trailer_info_release(struct trailer_info *info);
 void format_trailers_from_commit(struct strbuf *out, const char *msg,
 				 const struct process_trailer_options *opts);
 
+declare_commit_slab(trailer_rxrefs_slab, struct object_array *);
+
+struct trailer_rev_xrefs {
+	char *tag;
+	int tag_len;
+	struct trailer_rxrefs_slab slab;
+	struct object_array from_commits;
+};
+
+void trailer_rev_xrefs_init(struct trailer_rev_xrefs *rxrefs, const char *tag);
+void trailer_rev_xrefs_record(struct trailer_rev_xrefs *rxrefs,
+			      struct commit *commit);
+void trailer_rev_xrefs_release(struct trailer_rev_xrefs *rxrefs);
+
+void trailer_rev_xrefs_next(struct trailer_rev_xrefs *rxrefs,
+			    int *idx_p, struct commit **from_commit_p,
+			    struct object_array **to_objs_p);
+
+#define trailer_rev_xrefs_for_each(rxrefs, idx, from_commit, to_objs)		\
+	for ((idx) = 0,								\
+	     trailer_rev_xrefs_next(rxrefs, &(idx), &(from_commit), &(to_objs));\
+	     (from_commit);							\
+	     trailer_rev_xrefs_next(rxrefs, &(idx), &(from_commit), &(to_objs)))
+
 #endif /* TRAILER_H */
