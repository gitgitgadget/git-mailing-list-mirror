From: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] Fixing unclear messages
Date: Sun, 10 Aug 2014 18:13:27 +0300
Message-ID: <1407683607-4143-2-git-send-email-ash@kambanaria.org>
References: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
Cc: avarab@gmail.com, jn.avila@free.fr, worldhello.net@gmail.com,
	marcopaolone@gmail.com, marcomsousa@gmail.com,
	peter@softwolves.pp.se, ralf.thielow@gmail.com, gitster@pobox.com,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:13:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGUof-0007EV-6J
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 17:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbaHJPNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 11:13:46 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37508 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaHJPNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 11:13:44 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so3074069wib.10
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 08:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZAWwcCuqFdggO7HeeP63JPwT+ScpESXwJuV4gvLJytA=;
        b=JET2csyvKwP4DshBl5H02af0x9ZzxYKuCxCp+nnuo6sK5sX5ud8ueIvvPGQYe0S9gT
         e8apJt04G0b4zk/DhFoQagqygrqlOkuBoBYKFxizVItlXL0Fl+fZos/2jLlAfqZhKqr6
         QOH8v6TrOobEWRsQQSu7j5K5HMdB/BgMU+YCUJasP+1CC3WGpzutTeDLh8skTro7LkUZ
         0AHB4nGPfdV9WTyWcePrRhbWWXKWvJeuFGIoDvX1dsCGI131kfY/o1bVHQZrODEKrbWZ
         /GOUWvV3kzLboRwMCi7ARq3m4DGgtn2WbaIBAnbHLpqqBDlhJtJvVpBQWUw0xlcAHEVW
         L87g==
X-Gm-Message-State: ALoCoQkeK8SToCIc2p6Il2/ZS2+NrRpoRssVbor5jS6KNJFQmiXdesqqrOlHz8XMZ+dRF8wcIp+F
X-Received: by 10.180.212.77 with SMTP id ni13mr13800986wic.42.1407683622738;
        Sun, 10 Aug 2014 08:13:42 -0700 (PDT)
Received: from dalgonosko.localdomain (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id ft17sm32704813wjc.14.2014.08.10.08.13.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 08:13:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255094>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 builtin/clean.c      | 2 +-
 builtin/commit.c     | 2 +-
 builtin/index-pack.c | 4 ++--
 builtin/log.c        | 4 ++--
 builtin/merge.c      | 5 +++--
 builtin/remote.c     | 2 +-
 builtin/tag.c        | 2 +-
 git-bisect.sh        | 2 +-
 merge-recursive.c    | 2 +-
 9 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 1032563..9f38068 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -514,7 +514,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
 		    (is_single && bottom != top)) {
 			clean_print_color(CLEAN_COLOR_ERROR);
-			printf_ln(_("Huh (%s)?"), (*ptr)->buf);
+			printf_ln(_("Wrong choice (%s). Choose again."), (*ptr)->buf);
 			clean_print_color(CLEAN_COLOR_RESET);
 			continue;
 		}
diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..cdc8a4e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1198,7 +1198,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (argc == 0 && (also || (only && !amend)))
 		die(_("No paths with --include/--only does not make sense."));
 	if (argc == 0 && only && amend)
-		only_include_assumed = _("Clever... amending the last one with dirty index.");
+		only_include_assumed = _("You are amending the last commit only. There are additional changes in the index.");
 	if (argc > 0 && !also && !only)
 		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5568a5b..d9c5911 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1064,7 +1064,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		nr_delays--;
 	}
 	if (nr_delays)
-		die(_("confusion beyond insanity in parse_pack_objects()"));
+		die(_("fatal error in function \"parse_pack_objects\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));
 }
 
 /*
@@ -1139,7 +1139,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		int nr_unresolved = nr_deltas - nr_resolved_deltas;
 		int nr_objects_initial = nr_objects;
 		if (nr_unresolved <= 0)
-			die(_("confusion beyond insanity"));
+			die(_("fatal error in function \"conclude_pack\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));
 		objects = xrealloc(objects,
 				   (nr_objects + nr_unresolved + 1)
 				   * sizeof(*objects));
diff --git a/builtin/log.c b/builtin/log.c
index 4389722..d614a20 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -992,7 +992,7 @@ static const char *clean_message_id(const char *msg_id)
 		m++;
 	}
 	if (!z)
-		die(_("insane in-reply-to: %s"), msg_id);
+		die(_("wrong format for the \"in-reply-to\" header: %s"), msg_id);
 	if (++z == m)
 		return a;
 	return xmemdupz(a, z - a);
@@ -1065,7 +1065,7 @@ static int output_directory_callback(const struct option *opt, const char *arg,
 {
 	const char **dir = (const char **)opt->value;
 	if (*dir)
-		die(_("Two output directories?"));
+		die(_("Maximum one output directory is allowed."));
 	*dir = arg;
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index ce82eb2..e92a74a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -842,7 +842,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	struct commit_list *parents, **pptr = &parents;
 
 	write_tree_trivial(result_tree);
-	printf(_("Wonderful.\n"));
+	printf(_("The first part of the trivial merge finished successfully
+.\n"));
 	pptr = commit_list_append(head, pptr);
 	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
@@ -1400,7 +1401,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				ret = merge_trivial(head_commit, remoteheads);
 				goto done;
 			}
-			printf(_("Nope.\n"));
+			printf(_("Merge was not successful.\n"));
 		}
 	} else {
 		/*
diff --git a/builtin/remote.c b/builtin/remote.c
index 9a4640d..3f480b1 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -951,7 +951,7 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 		else if (string_list_has_string(&states->stale, name))
 			arg = _(" stale (use 'git remote prune' to remove)");
 		else
-			arg = _(" ???");
+			arg = _(" unknown state");
 		printf("    %-*s", info->width, name);
 		printf(fmt, arg);
 		printf("\n");
diff --git a/builtin/tag.c b/builtin/tag.c
index 19eb747..8a565fc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -501,7 +501,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 		stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
 
 	if (!opt->message_given && !buf->len)
-		die(_("no tag message?"));
+		die(_("missing tag message"));
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 1e0d602..c7fb095 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -421,7 +421,7 @@ bisect_replay () {
 		good|bad|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
-			die "$(gettext "?? what are you talking about?")" ;;
+			die "$(gettext "unknown command. Only \"start\", \"good\", \"bad\" and \"skip\" are possible.")" ;;
 		esac
 	done <"$file"
 	bisect_auto_next
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d332b8..bb71cb6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1858,7 +1858,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("Unprocessed path??? %s"),
+				die(_("The path \"%s\" was not processed but it had to be. This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."),
 				    entries->items[i].string);
 		}
 
-- 
1.9.3
