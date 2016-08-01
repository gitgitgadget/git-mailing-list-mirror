Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5502A1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbcHALi3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:38:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:60525 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbcHALiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:38:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LxLcc-1bEOyD2ys6-016tPY; Mon, 01 Aug 2016 13:36:47
 +0200
Date:	Mon, 1 Aug 2016 13:36:46 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 02/16] Report bugs consistently
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <652c5d3fc999a19e163e7a3591391d2866c70ea1.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nAcqXN8NBvhahLFxBxdv4wz7DS+h3QpgTvCeNbgTmREOjtYx77/
 IRBKg1I5qmwoVCb0Q3p5Ojor0VQeG/6rEix4FrQgrytq49helntBoEPQEWeiquDyDA3DA6b
 miX9TSr34ILIKvi0+h8n5kRKwXes7BPXssIV+b5OdhacCBd+i/cIW33So3EDwe6BJcYiXT3
 wlFkhKt/WR8lHw1L2UGWw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QzZLKsMI1Gg=:lu68n1xFuJ4d1Butip2xYl
 /+aVJ9TYRmtWWmr/VDZ7Gmik2Hg6oqrZBBqwXx5w7Ah9A1K7Ykvlm1g5/VYjjacWCvXqMcE6T
 6Frtg6n+FRbokO8XRFZwl2yogniiGkJ2tXFNe056b+tVrPf8y3ecHeocx2+JibyQCENbswr2H
 tkQqymwbu8xgEy89x8E277gYlSEXeFpbrRVyOHxEaYOUUvQiHwxoCa9zQowXmXePH6No+GftF
 P/DerM6yCgEwkFjeuUGsm5Kx1qC8f06K6VzvtqLLNRV681hI50409KEOaGvj0LH09w93BSeoK
 HNSvVqejkxXdA31p8d+pfBU4uk2GcKP3lOyECKnL6IsKP3liC91LmCJSEBPOqTkRmaCTtgnxZ
 MZs3/Xdta1Q6QUigLWsETZNC6WiDcDxG1Nf/RXM2tlGc8gPId9wajBEyrtQZ5AnBxpLtF9mgO
 IXWDt2eRa+2Uwfow6p/rj89C4Ygup5BHw5e3nm6JgMjB7l7owfMNPnzX4Y3hFCRgYEDy8WSjh
 5unB9YWk7J8Sj860oOHT6XRTRcus/25aoH+TbR7J0yobOmpKWpf8K1ixHdeIIn144Z2LMC0na
 21WrOfzjpSq/3xqy0U2ffhtn7xKa9rB8cf4s8SuZ4lWYpJeAb1HS7M+C4RmkKZNgRdIQb98Wf
 xeAOvVOtJ3LG4oqaYSLdsJOyAPDkJoAlGud7/rw7Dm247Bv8l7iE0c4EGJLWYuX37cZ5GCYsd
 q+CDDMx6NMptekFcrdIX/DMmmo/CG54gByP7HIsV/Jracfbn3D+95LDTIgUrdqR7jdAukrLYr
 X5kbpr3
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
 merge-recursive.c      | 15 +++++++--------
 sha1_file.c            |  4 ++--
 trailer.c              |  2 +-
 transport.c            |  2 +-
 wt-status.c            |  4 ++--
 9 files changed, 21 insertions(+), 21 deletions(-)

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
index 394c856..22cbb73 100644
--- a/grep.c
+++ b/grep.c
@@ -693,10 +693,10 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
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
 
@@ -709,7 +709,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 		h = compile_pattern_atom(&pp);
 		if (!h || pp != p->next)
-			die("bug: malformed header expr");
+			die("BUG: malformed header expr");
 		if (!header_group[p->field]) {
 			header_group[p->field] = h;
 			continue;
@@ -1514,7 +1514,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		case GREP_BINARY_TEXT:
 			break;
 		default:
-			die("bug: unknown binary handling mode");
+			die("BUG: unknown binary handling mode");
 		}
 	}
 
diff --git a/imap-send.c b/imap-send.c
index db0fafe..0f5f476 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -511,7 +511,7 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 
 	va_start(va, fmt);
 	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
-		die("Fatal: buffer too small. Please report a bug.");
+		die("BUG: buffer too small. Please report a bug.");
 	va_end(va);
 	return ret;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index a4a1195..4338b73 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -268,7 +268,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
-		die("Bug in merge-recursive.c");
+		die("BUG: unmerged index entries in merge-recursive.c");
 	}
 
 	if (!active_cache_tree)
@@ -966,9 +966,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
-		} else {
-			die(_("unsupported object type in the tree"));
-		}
+		} else
+			die(_("BUG: unsupported object type in the tree"));
 	}
 
 	return result;
@@ -1354,7 +1353,7 @@ static int process_renames(struct merge_options *o,
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
 			if (strcmp(ren1_src, ren2_src) != 0)
-				die("ren1_src != ren2_src");
+				die("BUG: ren1_src != ren2_src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
@@ -1388,7 +1387,7 @@ static int process_renames(struct merge_options *o,
 			ren2 = lookup->util;
 			ren2_dst = ren2->pair->two->path;
 			if (strcmp(ren1_dst, ren2_dst) != 0)
-				die("ren1_dst != ren2_dst");
+				die("BUG: ren1_dst != ren2_dst");
 
 			clean_merge = 0;
 			ren2->processed = 1;
@@ -1812,7 +1811,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("Fatal merge failure, shouldn't happen."));
+		die(_("BUG: fatal merge failure, shouldn't happen."));
 
 	return clean_merge;
 }
@@ -1870,7 +1869,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("Unprocessed path??? %s"),
+				die(_("BUG: unprocessed path??? %s"),
 				    entries->items[i].string);
 		}
 
diff --git a/sha1_file.c b/sha1_file.c
index cb571ac..ebc640e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -795,7 +795,7 @@ void close_all_packs(void)
 
 	for (p = packed_git; p; p = p->next)
 		if (p->do_not_close)
-			die("BUG! Want to close pack marked 'do-not-close'");
+			die("BUG: want to close pack marked 'do-not-close'");
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
index b233e3e..04d9454 100644
--- a/transport.c
+++ b/transport.c
@@ -566,7 +566,7 @@ void transport_take_over(struct transport *transport,
 	struct git_transport_data *data;
 
 	if (!transport->smart_options)
-		die("Bug detected: Taking over transport requires non-NULL "
+		die("BUG: taking over transport requires non-NULL "
 		    "smart_options field.");
 
 	data = xcalloc(1, sizeof(*data));
diff --git a/wt-status.c b/wt-status.c
index 19cbc39..f8ae0c2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die("bug: unhandled unmerged status %x", stagemask);
+		die("BUG: unhandled unmerged status %x", stagemask);
 	}
 }
 
@@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die("bug: unhandled diff status %c", status);
+		die("BUG: unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-- 
2.9.0.281.g286a8d9


