Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9DEC433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA5D2074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JBap/IwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgG3Agq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:36:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56681 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgG3Agq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:36:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EAD2F6EA6;
        Wed, 29 Jul 2020 20:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aPAWsI3GpB/grR1MtGoOBa0Um8w=; b=JBap/I
        wWmUz5aUS9b3nUf9b1J8R7SoMxGhBHblC/Czgv3qPous5Cz7KD/sG+knCypxBpZ1
        JElMdAxVQRKzvq7fsWVl5BGWhCnwS8rNmtJ64jQNqtcKpXra6EfuJ7JAuCJ5xmMc
        iwCwTVs5rQRiheb6JnafLDh7D/yFe57WO0sfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ETbWs2DDoKV2PrKH/DlGUR8yetChR21r
        w6ppGn/ZMSNBCW4XD/f47c+RCXWDtHFdaq5nHKGjv2AjaEpucm84b6iUAIhUyqPh
        CdcAxFNeqcu5E8XVxh/IWf6dRG9bbXceODXFNiJpPNGP4+M4EtK34ZloT9mYPIqa
        9S0cyS6V0M8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B650F6EA5;
        Wed, 29 Jul 2020 20:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D1D5F6EA4;
        Wed, 29 Jul 2020 20:36:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        <xmqqime69jfc.fsf@gitster.c.googlers.com>
        <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
        <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
        <20200729205846.GA2992025@coredump.intra.peff.net>
        <xmqqv9i6814y.fsf@gitster.c.googlers.com>
        <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
Date:   Wed, 29 Jul 2020 17:36:31 -0700
In-Reply-To: <xmqqlfj27x7q.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Jul 2020 15:50:01 -0700")
Message-ID: <xmqq5za596uo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7ECBEFA-D1FC-11EA-9CBF-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A rough outline I did while waiting for today's integration builds
> to finish looks like this, which does not look _too_ bad.

This time, with full test suite, documentation and a log message.

A few bugs in the code are also fixed since the preview version.

 - I was confused about wildmatch's return value.

 - wildmatch is now called with WM_PATHNAME.

 - Not just the "unvalued truth", but an empty string also works as
   a "clear the list of globs" now.

 - The final LF still needs to be added even when we suppress "into X".

-- >8 --
Subject: [PATCH] fmt-merge-msg: allow merge destination to be omitted again

In Git 2.28, we stopped special casing 'master' when producing the
default merge message by just removing the code to squelch "into
'master'" at the end of the message.

Introduce multi-valued merge.suppressDest configuration variable
that gives a set of globs to match against the name of the branch
into which the merge is being made, to let users specify for which
branch fmt-merge-msg's output should be shortened.  When it is not
set, 'master' is used as the sole value of the variable by default.

Because this reverts the behaviour to that of pre-2.28 in
repositories that have no relevant configuration, revert most of the
changes made to the tests back then.  At the end of t6200, add a few
tests to document the behaviour with the new configuration variable
and protect it from future regression.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/fmt-merge-msg.txt        | 12 ++++
 fmt-merge-msg.c                               | 24 ++++++-
 t/t1507-rev-parse-upstream.sh                 |  2 +-
 t/t4013-diff-various.sh                       |  4 +-
 t/t4013/diff.log_--decorate=full_--all        |  2 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
 t/t4013/diff.log_--patch-with-stat_master     |  2 +-
 .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ..._--root_--patch-with-stat_--summary_master |  2 +-
 .../diff.log_--root_--patch-with-stat_master  |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4013/diff.log_--root_-p_master             |  2 +-
 t/t4013/diff.log_--root_master                |  2 +-
 t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
 t/t4013/diff.log_-m_-p_master                 |  4 +-
 t/t4013/diff.log_-p_--first-parent_master     |  2 +-
 t/t4013/diff.log_-p_master                    |  2 +-
 t/t4013/diff.log_master                       |  2 +-
 t/t4013/diff.show_--first-parent_master       |  2 +-
 t/t4013/diff.show_-c_master                   |  2 +-
 t/t4013/diff.show_-m_master                   |  4 +-
 t/t4013/diff.show_master                      |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4202-log.sh                                | 72 +++++++++----------
 t/t6200-fmt-merge-msg.sh                      | 56 ++++++++++-----
 t/t7600-merge.sh                              | 14 ++--
 t/t7608-merge-messages.sh                     | 10 +--
 30 files changed, 148 insertions(+), 94 deletions(-)

diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/config/fmt-merge-msg.txt
index c73cfa90b7..a8e8f74d0a 100644
--- a/Documentation/config/fmt-merge-msg.txt
+++ b/Documentation/config/fmt-merge-msg.txt
@@ -8,3 +8,15 @@ merge.log::
 	most the specified number of one-line descriptions from the
 	actual commits that are being merged.  Defaults to false, and
 	true is a synonym for 20.
+
+merge.suppressDest::
+	By adding a glob that matches the names of integration
+	branches to this multi-valued configuration variable, the
+	default merge message computed for merges into these
+	integration branches will omit " into <branch name>" from
+	its title.
++
+An element with an empty value can be used to clear the list
+of globs accumulated from previous configuration entries.
+When there is no `merge.suppressDest` variable defined, the
+default value of `master` is used for backward compatibility.
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index cfb8ff2f33..5fe879207b 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -10,6 +10,8 @@
 #include "commit-reach.h"
 
 static int use_branch_desc;
+static int suppress_dest_pattern_seen;
+static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
@@ -22,6 +24,12 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			merge_log_config = DEFAULT_MERGE_LOG_LEN;
 	} else if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc = git_config_bool(key, value);
+	} else if (!strcmp(key, "merge.suppressdest")) {
+		if (!value || !*value)
+			string_list_clear(&suppress_dest_patterns, 0);
+		else
+			string_list_append(&suppress_dest_patterns, value);
+		suppress_dest_pattern_seen = 1;
 	} else {
 		return git_default_config(key, value, cb);
 	}
@@ -408,6 +416,8 @@ static void fmt_merge_msg_title(struct strbuf *out,
 {
 	int i = 0;
 	char *sep = "";
+	struct string_list_item *item;
+	int suppress_merge_dest = 0;
 
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
@@ -451,7 +461,16 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
-	strbuf_addf(out, " into %s\n", current_branch);
+	for_each_string_list_item(item, &suppress_dest_patterns) {
+		if (!wildmatch(item->string, current_branch, WM_PATHNAME)) {
+			suppress_merge_dest = 1;
+			break;
+		}
+	}
+
+	if (!suppress_merge_dest)
+		strbuf_addf(out, " into %s", current_branch);
+	strbuf_addch(out, '\n');
 }
 
 static void fmt_tag_signature(struct strbuf *tagbuf,
@@ -596,6 +615,9 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
 
+	if (!suppress_dest_pattern_seen)
+		string_list_append(&suppress_dest_patterns, "master");
+
 	memset(&merge_parents, 0, sizeof(merge_parents));
 
 	/* get current branch */
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index f213aa8053..dfc0d96d8a 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -137,7 +137,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=tformat:%s >actual &&
-	echo "Merge remote-tracking branch ${SQ}origin/side${SQ} into master" >expect &&
+	echo "Merge remote-tracking branch ${SQ}origin/side${SQ}" >expect &&
 	test_cmp expect actual
 )
 '
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 43267d6024..3f60f7d96c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -117,12 +117,12 @@ test_expect_success setup '
 
 : <<\EOF
 ! [initial] Initial
- * [master] Merge branch 'side' into master
+ * [master] Merge branch 'side'
   ! [rearrange] Rearranged lines in dir/sub
    ! [side] Side
 ----
   +  [rearrange] Rearranged lines in dir/sub
- -   [master] Merge branch 'side' into master
+ -   [master] Merge branch 'side'
  * + [side] Side
  *   [master^] Third
  *   [master~2] Second
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index c56783b985..3f9b872ece 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 1cbdc038f4..f5e20e1e14 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index f5b1b6516b..a18f1472a9 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log_--patch-with-stat_master
index af23803cdc..ae425c4672 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
index 814098fbf8..d5207cadf4 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index b927fe4a98..0fc1e8cd71 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index 6db3cea329..dffc09dde9 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/diff.log_--root_--patch-with-stat_master
index 98e9c320c3..55aa98012d 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index b61b1117ae..019d85f7de 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_-p_master
index 345bd9e8a9..b42c334439 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_master
index db56b1fe6b..e8f46159da 100644
--- a/t/t4013/diff.log_--root_master
+++ b/t/t4013/diff.log_--root_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff.log_-m_-p_--first-parent_master
index bcadb50e26..7a0073f529 100644
--- a/t/t4013/diff.log_-m_-p_--first-parent_master
+++ b/t/t4013/diff.log_-m_-p_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_master
index 2acf43a9fb..9ca62a01ed 100644
--- a/t/t4013/diff.log_-m_-p_master
+++ b/t/t4013/diff.log_-m_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
@@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --git a/dir/sub b/dir/sub
 index 7289e35..992913c 100644
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log_-p_--first-parent_master
index c6a5876d80..3fc896d424 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_master
index 1841cded94..bf1326dc36 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_master
index f8ec445eb3..a8f6ce5abd 100644
--- a/t/t4013/diff.log_master
+++ b/t/t4013/diff.log_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show_--first-parent_master
index 94548f4598..3dcbe473a0 100644
--- a/t/t4013/diff.show_--first-parent_master
+++ b/t/t4013/diff.show_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_master
index 1c46ed64fd..81aba8da96 100644
--- a/t/t4013/diff.show_-c_master
+++ b/t/t4013/diff.show_-c_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --combined dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_master
index 7559fc22f8..4ea2ee453d 100644
--- a/t/t4013/diff.show_-m_master
+++ b/t/t4013/diff.show_-m_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
@@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --git a/dir/sub b/dir/sub
 index 7289e35..992913c 100644
diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_master
index 57091c5d90..fb08ce0e46 100644
--- a/t/t4013/diff.show_master
+++ b/t/t4013/diff.show_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
index 5f13a71bb5..30aae7817b 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
index 8acb88267b..d1d32bd34c 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side' into master
+    Merge branch 'side'
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index fd9af658af..a0930599aa 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -483,7 +483,7 @@ test_expect_success 'set up merge history' '
 '
 
 cat > expect <<\EOF
-*   Merge branch 'side' into master
+*   Merge branch 'side'
 |\
 | * side-2
 | * side-1
@@ -502,7 +502,7 @@ test_expect_success 'log --graph with merge' '
 '
 
 cat > expect <<\EOF
-| | | *   Merge branch 'side' into master
+| | | *   Merge branch 'side'
 | | | |\
 | | | | * side-2
 | | | | * side-1
@@ -521,7 +521,7 @@ test_expect_success 'log --graph --line-prefix="| | | " with merge' '
 '
 
 cat > expect.colors <<\EOF
-*   Merge branch 'side' into master
+*   Merge branch 'side'
 <BLUE>|<RESET><CYAN>\<RESET>
 <BLUE>|<RESET> * side-2
 <BLUE>|<RESET> * side-1
@@ -555,7 +555,7 @@ cat > expect <<\EOF
 |\  Merge: A B
 | | Author: A U Thor <author@example.com>
 | |
-| |     Merge branch 'side' into master
+| |     Merge branch 'side'
 | |
 | * commit tags/side-2
 | | Author: A U Thor <author@example.com>
@@ -632,11 +632,11 @@ test_expect_success 'set up more tangled history' '
 '
 
 cat > expect <<\EOF
-*   Merge tag 'reach' into master
+*   Merge tag 'reach'
 |\
 | \
 |  \
-*-. \   Merge tags 'octopus-a' and 'octopus-b' into master
+*-. \   Merge tags 'octopus-a' and 'octopus-b'
 |\ \ \
 * | | | seventh
 | | * | octopus-b
@@ -646,14 +646,14 @@ cat > expect <<\EOF
 |/ /
 | * reach
 |/
-*   Merge branch 'tangle' into master
+*   Merge branch 'tangle'
 |\
 | *   Merge branch 'side' (early part) into tangle
 | |\
 | * \   Merge branch 'master' (early part) into tangle
 | |\ \
 | * | | tangle-a
-* | | |   Merge branch 'side' into master
+* | | |   Merge branch 'side'
 |\ \ \ \
 | * | | | side-2
 | | |_|/
@@ -735,16 +735,16 @@ test_expect_success 'log.decorate configuration' '
 
 test_expect_success 'decorate-refs with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
 	reach
 	EOF
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
 	octopus-a
@@ -765,8 +765,8 @@ test_expect_success 'decorate-refs with glob' '
 
 test_expect_success 'decorate-refs without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
 	octopus-a
@@ -779,8 +779,8 @@ test_expect_success 'decorate-refs without globs' '
 
 test_expect_success 'multiple decorate-refs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
@@ -794,8 +794,8 @@ test_expect_success 'multiple decorate-refs' '
 
 test_expect_success 'decorate-refs-exclude with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -811,8 +811,8 @@ test_expect_success 'decorate-refs-exclude with glob' '
 
 test_expect_success 'decorate-refs-exclude without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b, octopus-b)
 	octopus-a (tag: octopus-a, octopus-a)
@@ -828,8 +828,8 @@ test_expect_success 'decorate-refs-exclude without globs' '
 
 test_expect_success 'multiple decorate-refs-exclude' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -851,8 +851,8 @@ test_expect_success 'multiple decorate-refs-exclude' '
 
 test_expect_success 'decorate-refs and decorate-refs-exclude' '
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach-into-master (master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
 	octopus-a
@@ -866,8 +866,8 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
 
 test_expect_success 'deocrate-refs and log.excludeDecoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
@@ -881,10 +881,10 @@ test_expect_success 'deocrate-refs and log.excludeDecoration' '
 
 test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
+	Merge-tag-reach (HEAD -> master)
 	reach (tag: reach, reach)
 	seventh (tag: seventh)
-	Merge-branch-tangle-into-master
+	Merge-branch-tangle
 	Merge-branch-side-early-part-into-tangle (tangle)
 	tangle-a (tag: tangle-a)
 	EOF
@@ -1068,7 +1068,7 @@ cat >expect <<\EOF
 |\  Merge: MERGE_PARENTS
 | | Author: A U Thor <author@example.com>
 | |
-| |     Merge branch 'tangle' into master
+| |     Merge branch 'tangle'
 | |
 | *   commit COMMIT_OBJECT_NAME
 | |\  Merge: MERGE_PARENTS
@@ -1102,7 +1102,7 @@ cat >expect <<\EOF
 |\ \ \ \  Merge: MERGE_PARENTS
 | | | | | Author: A U Thor <author@example.com>
 | | | | |
-| | | | |     Merge branch 'side' into master
+| | | | |     Merge branch 'side'
 | | | | |
 | * | | | commit COMMIT_OBJECT_NAME
 | | |_|/  Author: A U Thor <author@example.com>
@@ -1343,7 +1343,7 @@ cat >expect <<\EOF
 *** |\  Merge: MERGE_PARENTS
 *** | | Author: A U Thor <author@example.com>
 *** | |
-*** | |     Merge branch 'tangle' into master
+*** | |     Merge branch 'tangle'
 *** | |
 *** | *   commit COMMIT_OBJECT_NAME
 *** | |\  Merge: MERGE_PARENTS
@@ -1377,7 +1377,7 @@ cat >expect <<\EOF
 *** |\ \ \ \  Merge: MERGE_PARENTS
 *** | | | | | Author: A U Thor <author@example.com>
 *** | | | | |
-*** | | | | |     Merge branch 'side' into master
+*** | | | | |     Merge branch 'side'
 *** | | | | |
 *** | * | | | commit COMMIT_OBJECT_NAME
 *** | | |_|/  Author: A U Thor <author@example.com>
@@ -1540,8 +1540,8 @@ cat >expect <<-\EOF
 * reach
 |
 | A	reach.t
-* Merge branch 'tangle' into master
-*   Merge branch 'side' into master
+* Merge branch 'tangle'
+*   Merge branch 'side'
 |\
 | * side-2
 |
@@ -1562,8 +1562,8 @@ cat >expect <<-\EOF
 * reach
 |
 | reach.t
-* Merge branch 'tangle' into master
-*   Merge branch 'side' into master
+* Merge branch 'tangle'
+*   Merge branch 'side'
 |\
 | * side-2
 |
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2b3fd498d0..7d549748ef 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -79,7 +79,7 @@ test_expect_success GPG 'set up a signed tag' '
 '
 
 test_expect_success 'message for merging local branch' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 
 	git checkout master &&
 	git fetch . left &&
@@ -107,7 +107,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 '
 
 test_expect_success 'message for merging external branch' '
-	echo "Merge branch ${apos}left${apos} of $(pwd) into master" >expected &&
+	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
 	git checkout master &&
 	git fetch "$(pwd)" left &&
@@ -118,7 +118,7 @@ test_expect_success 'message for merging external branch' '
 
 test_expect_success '[merge] summary/log configuration' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -160,7 +160,7 @@ test_expect_success 'setup FETCH_HEAD' '
 
 test_expect_success 'merge.log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -177,7 +177,7 @@ test_expect_success 'merge.log=3 limits shortlog length' '
 
 test_expect_success 'merge.log=5 shows all 5 commits' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -195,7 +195,7 @@ test_expect_success 'merge.log=5 shows all 5 commits' '
 
 test_expect_success '--log=5 with custom comment character' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
 
 	x By Another Author (3) and A U Thor (2)
 	x Via Another Committer
@@ -212,14 +212,14 @@ test_expect_success '--log=5 with custom comment character' '
 '
 
 test_expect_success 'merge.log=0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git -c merge.log=0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success '--log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -236,7 +236,7 @@ test_expect_success '--log=3 limits shortlog length' '
 
 test_expect_success '--log=5 shows all 5 commits' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -253,13 +253,13 @@ test_expect_success '--log=5 shows all 5 commits' '
 '
 
 test_expect_success '--no-log disables shortlog' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success '--log=0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
@@ -300,7 +300,7 @@ test_expect_success 'fmt-merge-msg -m' '
 
 test_expect_success 'setup: expected shortlog for two branches' '
 	cat >expected <<-EOF
-	Merge branches ${apos}left${apos} and ${apos}right${apos} into master
+	Merge branches ${apos}left${apos} and ${apos}right${apos}
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -397,7 +397,7 @@ test_expect_success 'merge-msg with nothing to merge' '
 
 test_expect_success 'merge-msg tag' '
 	cat >expected <<-EOF &&
-	Merge tag ${apos}tag-r3${apos} into master
+	Merge tag ${apos}tag-r3${apos}
 
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -418,7 +418,7 @@ test_expect_success 'merge-msg tag' '
 
 test_expect_success 'merge-msg two tags' '
 	cat >expected <<-EOF &&
-	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos} into master
+	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos}
 
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -448,7 +448,7 @@ test_expect_success 'merge-msg two tags' '
 
 test_expect_success 'merge-msg tag and branch' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos} into master
+	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos}
 
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -479,7 +479,7 @@ test_expect_success 'merge-msg tag and branch' '
 test_expect_success 'merge-msg lots of commits' '
 	{
 		cat <<-EOF &&
-		Merge branch ${apos}long${apos} into master
+		Merge branch ${apos}long${apos}
 
 		* long: (35 commits)
 		EOF
@@ -516,7 +516,7 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	{
 		cat <<-\EOF
-		Merge tag '\''annote'\'' into master
+		Merge tag '\''annote'\''
 
 		An annotated one
 
@@ -531,7 +531,7 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	git merge --no-commit --no-ff $annote &&
 	{
 		cat <<-EOF
-		Merge tag '\''$annote'\'' into master
+		Merge tag '\''$annote'\''
 
 		An annotated one
 
@@ -542,4 +542,24 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	test_cmp expected .git/MERGE_MSG
 '
 
+test_expect_success 'merge.suppressDest configuration' '
+	git checkout -B side master &&
+	git commit --allow-empty -m "One step ahead" &&
+	git checkout master &&
+	git fetch . side &&
+
+	git -c merge.suppressDest="" fmt-merge-msg <.git/FETCH_HEAD >full.1 &&
+	head -n1 full.1 >actual &&
+	grep -e "Merge branch .side. into master" actual &&
+
+	git -c merge.suppressDest="mast" fmt-merge-msg <.git/FETCH_HEAD >full.2 &&
+	head -n1 full.2 >actual &&
+	grep -e "Merge branch .side. into master$" actual &&
+
+	git -c merge.suppressDest="ma??er" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
+	head -n1 full.3 >actual &&
+	grep -e "Merge branch .side." actual &&
+	! grep -e " into master$" actual
+'
+
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1d45f9a4ed..5883a6adc3 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -14,9 +14,9 @@ Testing basic merge operations/option parsing.
     ! [c4] c4
      ! [c5] c5
       ! [c6] c6
-       * [master] Merge commit 'c1' into master
+       * [master] Merge commit 'c1'
 --------
-       - [master] Merge commit 'c1' into master
+       - [master] Merge commit 'c1'
  +     * [c1] commit 1
       +  [c6] c6
      +   [c5] c5
@@ -44,8 +44,8 @@ test_write_lines '1 X' 2 '3 X' 4 '5 X' 6 7 8 '9 X' >result.1-3-5-9
 test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
 
 create_merge_msgs () {
-	echo "Merge tag 'c2' into master" >msg.1-5 &&
-	echo "Merge tags 'c2' and 'c3' into master" >msg.1-5-9 &&
+	echo "Merge tag 'c2'" >msg.1-5 &&
+	echo "Merge tags 'c2' and 'c3'" >msg.1-5-9 &&
 	{
 		echo "Squashed commit of the following:" &&
 		echo &&
@@ -258,7 +258,7 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	git commit --no-edit -a &&
 
 	cat >expect <<-\EOF &&
-	Merge tag '"'"'c7'"'"' into master
+	Merge tag '"'"'c7'"'"'
 
 	# ------------------------ >8 ------------------------
 	# Do not modify or remove the line above.
@@ -808,10 +808,10 @@ test_expect_success 'merge with conflicted --autostash changes' '
 '
 
 cat >expected.branch <<\EOF
-Merge branch 'c5-branch' (early part) into master
+Merge branch 'c5-branch' (early part)
 EOF
 cat >expected.tag <<\EOF
-Merge commit 'c5~1' into master
+Merge commit 'c5~1'
 EOF
 
 test_expect_success 'merge early part of c2' '
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 2af33f195b..8e7e0a5865 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -16,7 +16,7 @@ test_expect_success 'merge local branch' '
 	git checkout master &&
 	test_commit master-2 &&
 	git merge local-branch &&
-	check_oneline "Merge branch Qlocal-branchQ into master"
+	check_oneline "Merge branch Qlocal-branchQ"
 '
 
 test_expect_success 'merge octopus branches' '
@@ -26,7 +26,7 @@ test_expect_success 'merge octopus branches' '
 	test_commit octopus-2 &&
 	git checkout master &&
 	git merge octopus-a octopus-b &&
-	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ into master"
+	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
 '
 
 test_expect_success 'merge tag' '
@@ -35,7 +35,7 @@ test_expect_success 'merge tag' '
 	git checkout master &&
 	test_commit master-3 &&
 	git merge tag-1 &&
-	check_oneline "Merge tag Qtag-1Q into master"
+	check_oneline "Merge tag Qtag-1Q"
 '
 
 test_expect_success 'ambiguous tag' '
@@ -44,7 +44,7 @@ test_expect_success 'ambiguous tag' '
 	git checkout master &&
 	test_commit master-4 &&
 	git merge ambiguous &&
-	check_oneline "Merge tag QambiguousQ into master"
+	check_oneline "Merge tag QambiguousQ"
 '
 
 test_expect_success 'remote-tracking branch' '
@@ -54,7 +54,7 @@ test_expect_success 'remote-tracking branch' '
 	git checkout master &&
 	test_commit master-5 &&
 	git merge origin/master &&
-	check_oneline "Merge remote-tracking branch Qorigin/masterQ into master"
+	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
 '
 
 test_done
-- 
2.28.0

