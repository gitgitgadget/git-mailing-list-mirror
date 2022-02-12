Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FAC433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiBLUfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiBLUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F70E606E4
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so6910349wrg.11
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1VXzmrUXLaqAzreEkcNWjV5iEmmyfWYCQPv/gZp6R9k=;
        b=Wo1H4b4PsudjEl5ONVh9nMlQdlzFKCik1rtzi8GX9kFMtAyImI4AIdPDNZRl1y99PF
         o1hNBeT2NaaGv8oM8ot/FtmybKj0UfyQ0SZfx3DeRBQ2yl3jXGPISblibCIlNM5eGQGZ
         rS0rUpXOcNxgJXRntI5OdTL0tFkwvQ0owVYLW0Nwx2g19rQC5aKVX6INwWrFrrI1XxTb
         wQl5h8aOSdPkCxGmrjRaT2QkVVkYtG4unOrDJy/F3KZwXIZede7dJu63GdTWY16HbiNp
         atyRmbHhV/LjrZ29o2IF9FZkXwW4gDCyXe2iDzD6IYS49s9QJec+6BoBBiUMT7Xg7Grc
         vERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1VXzmrUXLaqAzreEkcNWjV5iEmmyfWYCQPv/gZp6R9k=;
        b=IdcutzxvS+r8gTBRhBvDSw/sy6KAwvKaUABeZRyZ0EIka3w1+zv+ocdghFAyOSw1qM
         LAjNrsD5vGGFlnofDxJK1BF+3IGbt1RrEzTG3DIqKr4vrwdnkYFqZg8WtW5HGVsH240d
         NwY9pWPwzcNW4VKEYX9Xhz7xoyNRYvjJxqPH9PF9ILwSTiM+kliknrjhEj8pYHEPli06
         UsmTOs3Bymni3M7IP3k/LvQJc4IdwiR1g59tdbsuAF7tYHXASqXlgZFC3swuZK3+3zcM
         ga9H4wAi/IM01DAl3/IoK6cJtCxOEFHgYWP+U1CuqKQ7lGn0gXyokezy38YEh/SYhKKi
         TgQw==
X-Gm-Message-State: AOAM5300WsGqedpZF3QyMEhfDV/nh9t4PnayXJPuwJD0BiO5MnDuUdSE
        qTtqHRKdwuTSKbVTAffgS8TYoFcRqYc=
X-Google-Smtp-Source: ABdhPJyMWrsgDR0ZkFMhsYqsZd07kHzKidAEVjikQGlw830ANEY0f7l++R9Ms616n6oeeCK/ondFRg==
X-Received: by 2002:adf:f5d2:: with SMTP id k18mr6038024wrp.381.1644698102944;
        Sat, 12 Feb 2022 12:35:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm7052583wmp.31.2022.02.12.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:35:02 -0800 (PST)
Message-Id: <5f253e298b39a9af3f7f9bd473c63ef9ca34b2df.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:51 +0000
Subject: [PATCH v4 10/12] merge-tree: allow `ls-files -u` style info to be NUL
 terminated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much as `git ls-files` has a -z option, let's add one to merge-tree so
that the conflict-info section can be NUL terminated (and avoid quoting
of unusual filenames).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 21 +++++++++++++----
 builtin/merge-tree.c             |  6 +++--
 t/t4301-merge-tree-write-tree.sh | 40 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 6502ee0669e..ada4595b4fc 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -50,6 +50,12 @@ discuss the first form.
 OPTIONS
 -------
 
+-z::
+	Do not quote filenames in the <Conflicted file info> section,
+	and end each filename with a NUL character rather than
+	newline.  Also begin the messages section with a NUL character
+	instead of a newline.  See OUTPUT below for more information.
+
 --name-only::
 	In the Conflicted file info section, instead of writing a list
 	of (mode, oid, stage, path) tuples to output for conflicted
@@ -84,7 +90,8 @@ OID of toplevel tree
 
 This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
-files within this tree may have embedded conflict markers.
+files within this tree may have embedded conflict markers.  This section
+is always followed by a newline (or NUL if `-z` is passed).
 
 Conflicted file info
 ~~~~~~~~~~~~~~~~~~~~
@@ -96,19 +103,25 @@ This is a sequence of lines with the format
 The filename will be quoted as explained for the configuration
 variable `core.quotePath` (see linkgit:git-config[1]).  However, if
 the `--name-only` option is passed, the mode, object, and stage will
-be omitted.
+be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
+character instead of a newline character.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This always starts with a blank line to separate it from the previous
-sections, and then has free-form messages about the merge, such as:
+This always starts with a blank line (or NUL if `-z` is passed) to
+separate it from the previous sections, and then has free-form
+messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
   * "Failed to merge submodule <submodule> (<reason>)"
   * "Warning: cannot merge binary files: <filename>"
 
+Note that these free-form messages will never have a NUL character
+in or between them, even if -z is passed.  It is simply a large block
+of text taking up the remainder of the output.
+
 EXIT STATUS
 -----------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 1d4d6637b90..825255667b1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -448,7 +448,7 @@ static int real_merge(struct merge_tree_options *o,
 	if (o->show_messages == -1)
 		o->show_messages = !result.clean;
 
-	puts(oid_to_hex(&result.tree->object.oid));
+	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
@@ -470,7 +470,7 @@ static int real_merge(struct merge_tree_options *o,
 		string_list_clear(&conflicted_files, 1);
 	}
 	if (o->show_messages) {
-		printf("\n");
+		putchar(line_termination);
 		merge_display_update_messages(&opt, &result);
 	}
 	merge_finalize(&opt, &result);
@@ -496,6 +496,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
 			   &o.name_only,
 			   N_("list filenames without modes/oids/stages"),
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 4ee85439372..fe476ed1bcc 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -173,4 +173,44 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	test_cmp conflicted-file-info actual
 '
 
+test_expect_success 'NUL terminated conflicted file "lines"' '
+	git checkout -b tweak1 side1 &&
+	test_write_lines zero 1 2 3 4 5 6 >numbers &&
+	git add numbers &&
+	git mv numbers "Αυτά μου φαίνονται κινέζικα" &&
+	git commit -m "Renamed numbers" &&
+
+	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	#   "Αυτά μου φαίνονται κινέζικα" should have a conflict
+	echo HASH | lf_to_nul >expect &&
+
+	q_to_tab <<-EOF | lf_to_nul >>expect &&
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~tweak1
+	100644 HASH 2Qwhatever~tweak1
+	100644 HASH 1QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 2QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 3QΑυτά μου φαίνονται κινέζικα
+
+	EOF
+
+	cat <<-EOF >>expect &&
+	Auto-merging greeting
+	CONFLICT (content): Merge conflict in greeting
+	CONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
+	CONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
+	Auto-merging Αυτά μου φαίνονται κινέζικα
+	CONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

