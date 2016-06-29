Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77F21FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbcF2Lgr (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:36:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:52082 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbcF2Lgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:36:46 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAyVY-1bAUZS14L6-009x35; Wed, 29 Jun 2016 13:36:42
 +0200
Date:	Wed, 29 Jun 2016 13:36:41 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] Report bugs consistently
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c4J7aEZwVj+yDZUoqOCNM4chQF+9oKowuJJ8c+GkNEPI0wMjjsd
 V7VT+oiChzej5P0V7u9m7beoMfxHKOVhVWCbvrnW8TwnNfrwPnqlrpebtEeLdHLkWfwVF+U
 9fpMRRHc72RK0wHsL4BqHBOj1QFWvY8fBRdMDNDOepuyXsSGPgCpOL2XUy94rCcshASmrdC
 Frdc3mX518dDgjQEx2Yvg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uhKovBqM4ow=:qZZDurtriXTtWtP7SJR+Vf
 tRSAf7oTxQsRwUhnm+JvDjmCH6ZFwCqy/cQ/QYaS5jz51zWbp1MMvbZe4OOvv573KB07XcKn1
 lYY9u7ct2a73c1FQ5963OYDHonTHPEMaW1jfXqbebCc9o0VbnUCDF10SZfp3rTI+fe+Kw6Ily
 lXFFavd+ShQKqeqSZ4tuXpbG3HVdfBdHgKpRNiJYmV+ikLGb+/5mMhbvGweUGGNNZg8mZ4hnk
 POecKKyS/Z/Zc1hl1LX6sDVx5lPAES3xgtnTAR3nsINiEn0HkNrAAW/t0d8Xhqoh1XN7uGEna
 d/qy2PQoiNkRRu57KwTFOQpoMdAcgoucSMIaAIDAvOxpkdrHIEoYtg88ewCrEK2CeqXnq6/av
 bRly2TgwdyZx3Hbtu/2SzHVGvyLPKKF/GzodJV3iLgJAvu0PKgCykJ3OjAuLfCNrlKFT/1Vie
 iqJgD6EivUHGjxfpfkdNNEqxcNnXO/R2nwc/btkL/a6wG62jDwfY0VFZDhqeQ8u1t/mjp/7kE
 SsFINJfP7jJOMSdXJ4zw097J3ldYYsaQSl9rLAnE5SdWAaTd/V7UPfFbnylXkjz12c/7EHH6z
 DwVTGZ/PGaDE2reLflbtCCubBJePw4WaukyGYbeL2u4T0FQWu3RBocZKZbwqdq7xPMgPuZNUY
 0MmuBqWwQVzOWt1fm8Q/bs3zMYuDYe+r2eTogDEFfjg7YBNQJy6cLj51kgjOCEvWPKmJyGRrf
 baqpPryBcH+v1PcaKnG2yUAsxdUVjI0XT9iZE2E799/eepJRhsKpx3qEpQFYSMjHjV79csiWe
 NMWMGtu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The vast majority of error messages in Git's source code which report a
bug use the convention to prefix the message with "BUG:".

As part of cleaning up merge-recursive to stop die()ing except in case of
detected bugs, let's just make the remainder of the bug reports consistent
with the de facto rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/ls-files.c     |  3 ++-
 builtin/update-index.c |  2 +-
 grep.c                 |  8 ++++----
 imap-send.c            |  2 +-
 merge-recursive.c      | 13 ++++++-------
 sha1_file.c            |  4 ++--
 trailer.c              |  2 +-
 transport.c            |  2 +-
 wt-status.c            |  4 ++--
 9 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f02e3d2..00ea91a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -118,7 +118,8 @@ static void show_killed_files(struct dir_struct *dir)
 				 */
 				pos = cache_name_pos(ent->name, ent->len);
 				if (0 <= pos)
-					die("bug in show-killed-files");
+					die("BUG: killed-file %.*s not found",
+						ent->len, ent->name);
 				pos = -pos - 1;
 				while (pos < active_nr &&
 				       ce_stage(active_cache[pos]))
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6cdfd5f..ba04b19 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1146,7 +1146,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
-		die("Bug: bad untracked_cache value: %d", untracked_cache);
+		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
 	if (active_cache_changed) {
diff --git a/grep.c b/grep.c
index 1e15b62..f1ca0a0 100644
--- a/grep.c
+++ b/grep.c
@@ -643,10 +643,10 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
-			die("bug: a non-header pattern in grep header list.");
+			die("BUG: a non-header pattern in grep header list.");
 		if (p->field < GREP_HEADER_FIELD_MIN ||
 		    GREP_HEADER_FIELD_MAX <= p->field)
-			die("bug: unknown header field %d", p->field);
+			die("BUG: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
 
@@ -659,7 +659,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 		h = compile_pattern_atom(&pp);
 		if (!h || pp != p->next)
-			die("bug: malformed header expr");
+			die("BUG: malformed header expr");
 		if (!header_group[p->field]) {
 			header_group[p->field] = h;
 			continue;
@@ -1464,7 +1464,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		case GREP_BINARY_TEXT:
 			break;
 		default:
-			die("bug: unknown binary handling mode");
+			die("BUG: unknown binary handling mode");
 		}
 	}
 
diff --git a/imap-send.c b/imap-send.c
index 938c691..cd39805 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -511,7 +511,7 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 
 	va_start(va, fmt);
 	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
-		die("Fatal: buffer too small. Please report a bug.");
+		die("BUG: buffer too small (%d < %d)", ret, blen);
 	va_end(va);
 	return ret;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 65cb5d6..98f4632 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -259,7 +259,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
-		die("Bug in merge-recursive.c");
+		die("BUG: unmerged index entries in merge-recursive.c");
 	}
 
 	if (!active_cache_tree)
@@ -955,9 +955,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 
 			if (!sha_eq(a->sha1, b->sha1))
 				result.clean = 0;
-		} else {
-			die(_("unsupported object type in the tree"));
-		}
+		} else
+			die(_("BUG: unsupported object type in the tree"));
 	}
 
 	return result;
@@ -1343,7 +1342,7 @@ static int process_renames(struct merge_options *o,
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
 			if (strcmp(ren1_src, ren2_src) != 0)
-				die("ren1_src != ren2_src");
+				die("BUG: ren1_src != ren2_src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
@@ -1377,7 +1376,7 @@ static int process_renames(struct merge_options *o,
 			ren2 = lookup->util;
 			ren2_dst = ren2->pair->two->path;
 			if (strcmp(ren1_dst, ren2_dst) != 0)
-				die("ren1_dst != ren2_dst");
+				die("BUG: ren1_dst != ren2_dst");
 
 			clean_merge = 0;
 			ren2->processed = 1;
@@ -1853,7 +1852,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("Unprocessed path??? %s"),
+				die(_("BUG: unprocessed path??? %s"),
 				    entries->items[i].string);
 		}
 
diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..aa7006c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -795,7 +795,7 @@ void close_all_packs(void)
 
 	for (p = packed_git; p; p = p->next)
 		if (p->do_not_close)
-			die("BUG! Want to close pack marked 'do-not-close'");
+			die("BUG: Want to close pack marked 'do-not-close'");
 		else
 			close_pack(p);
 }
@@ -2330,7 +2330,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
 		if (data)
-			die("BUG in unpack_entry: left loop at a valid delta");
+			die("BUG: unpack_entry: left loop at a valid delta");
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
diff --git a/trailer.c b/trailer.c
index 8e48a5c..c6ea9ac 100644
--- a/trailer.c
+++ b/trailer.c
@@ -562,7 +562,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	default:
-		die("internal bug in trailer.c");
+		die("BUG: trailer.c: unhandled type %d", type);
 	}
 	return 0;
 }
diff --git a/transport.c b/transport.c
index 095e61f..52bf997 100644
--- a/transport.c
+++ b/transport.c
@@ -563,7 +563,7 @@ void transport_take_over(struct transport *transport,
 	struct git_transport_data *data;
 
 	if (!transport->smart_options)
-		die("Bug detected: Taking over transport requires non-NULL "
+		die("BUG: taking over transport requires non-NULL "
 		    "smart_options field.");
 
 	data = xcalloc(1, sizeof(*data));
diff --git a/wt-status.c b/wt-status.c
index 4ce4e35..311ae7c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die(_("bug: unhandled unmerged status %x"), stagemask);
+		die(_("BUG: unhandled unmerged status %x"), stagemask);
 	}
 }
 
@@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die(_("bug: unhandled diff status %c"), status);
+		die(_("BUG: unhandled diff status %c"), status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-- 
2.9.0.268.gcabc8b0


