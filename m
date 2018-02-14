Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBA31F404
	for <e@80x24.org>; Wed, 14 Feb 2018 15:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031809AbeBNPuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 10:50:14 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:39852 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031713AbeBNPuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 10:50:13 -0500
Received: by mail-yw0-f169.google.com with SMTP id v196so15047110ywc.6
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mycode-ai.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=pIVvCed13vEallFBuXPyvc+uud/nFUz/fUaINdAONMI=;
        b=IecOxiBN2dmvojB3umWwyqCvmjBfY3NysR0skb3S4GLjpx98AAfGmQATIqj/YUIn07
         e4SmCzT7X0RZkf1RzERROMMwmlt6Y0fM2rAec9gUeAuidwrnsccmx1DT13qmtWf7+B22
         oDjo/RbzpIJD6f9Og45IGHb/nA9IiHBxA+qwBX7D+C9M/0uzBG/B9TNNB3wMx4ac/lhr
         Zbp3x5/sJHPkCrZ6swDWGclc+p/HdObCbVBUicKBdIsDquPs3R9map8hoIdJ9Ts8cAYn
         7jPAz9bQEDfagpluJrJl1bpQ8W3u5Y90EmIt5NgrrZJIa7IQSrsZbV6hw1fXWShsgMaX
         SUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pIVvCed13vEallFBuXPyvc+uud/nFUz/fUaINdAONMI=;
        b=dXcalI3GMndncaYoQOsct0PdSLDmTUOhCb3bsWXlYVTNYX4kpw7SttBWxJI7paYO2+
         3cxT4xhngZFPEbKTdZ+ep7RZ5WAITXWdu7dz+vkbUvcNPWXlKoRrZolnQZSnSXC98ICm
         ZTXF/lExMOXlQb19vKXOzaE58cBGIHkHV2zh9N/b88fL0Vgz0mIV2jqJiNinL1W1w8MC
         Fl9I9I6jL9bR3zLeYKBgLAYR3h4EyurlOnqK793J9w99xNtZRPijTZaHinv/h5wCqoLc
         5RaSiUQ9QUb8eRT426BpOjNAPFScpD9I6PhHhGkCkvAWqKuA2yfYYoQ6Hha/z6D/pWou
         iEAg==
X-Gm-Message-State: APf1xPCL/Ozu/8AcW0IONUDfxzCSfqHItgVu8nr6sK+qF6TrQgOW0OOn
        6j0qcCsj3jbFHP0x0S9qIJlVFX558lsrZgkVQoEZkHVRkyo=
X-Google-Smtp-Source: AH8x224OpXWkxFI85tHCzJdSoUQ30C0MYgL99bORPYElyQm+tQupSg/72+4uIu90/swKvfNB5tFpPfQ+6k6MCgeWGkU=
X-Received: by 10.37.210.199 with SMTP id j190mr3455566ybg.483.1518623412644;
 Wed, 14 Feb 2018 07:50:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.48.13 with HTTP; Wed, 14 Feb 2018 07:50:12 -0800 (PST)
From:   Code AI <techsupport@mycode.ai>
Date:   Wed, 14 Feb 2018 10:50:12 -0500
Message-ID: <CAGm8dMApDdLEzeKU-h16G0NSpnuk9LMTWA29t4MxO1qcNpUvhA@mail.gmail.com>
Subject: [PATCH] CodeAI fixes 1 Allocator sizeof() operand mismatch, 2 Null
 Pointer Dereference, and 2 Dead Code
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi my name is Benjamin Bales.

I am the founder and creator of CodeAI,
the first non-human contributor to your software project. CodeAI finds
and fixes security defects for you. It fixed 18. It wants to merge 5
commits - 1 Allocator sizeof() operand mismatch, 2 Null Pointer
Dereference issues and 2 Dead Code issues in git. To view all 18 fixed
issues from the run claim your free open source account at mycode.ai
and the Dockerfile used to build and run your project in CodeAI, here-
https://drive.google.com/open?id=12d2poeHabdc0DSShDcekSU5bI0Il6Qv- .
It is always free for open source projects.

If you have any questions about these results or have general
inquiries about CodeAI, please send an email to techsupport@mycode.ai

Allocator sizeof() mismatch:
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 1145d51..c3ea5c1 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -86,7 +86,7 @@ static void perf_hashmap(unsigned int method,
unsigned int rounds)
        unsigned int i, j;

        entries = malloc(TEST_SIZE * sizeof(struct test_entry *));
-       hashes = malloc(TEST_SIZE * sizeof(int));
+       hashes = malloc(TEST_SIZE * sizeof(unsigned));
        for (i = 0; i < TEST_SIZE; i++) {
                snprintf(buf, sizeof(buf), "%i", i);
                entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);


Null dereference fixes:
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4c51aec..f26858a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1604,7 +1604,7 @@ static void show_pack_info(int stat_only)
                             "non delta: %d objects",
                             baseobjects),
                          baseobjects);
-       for (i = 0; i < deepest_delta; i++) {
+       for (i = 0; chain_histogram && (i < deepest_delta); i++) {
                if (!chain_histogram[i])
                        continue;
                printf_ln(Q_("chain length = %d: %lu object",

diff --git a/unpack-trees.c b/unpack-trees.c
index 96c3327..fcd9332 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1721,7 +1721,7 @@ static int verify_absent(const struct cache_entry *ce,
                         enum unpack_trees_error_types error_type,
                         struct unpack_trees_options *o)
 {
-       if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
+       if (ce && (!o->skip_sparse_checkout && (ce->ce_flags &
CE_NEW_SKIP_WORKTREE)))
                return 0;
        return verify_absent_1(ce, error_type, o);
 }


Dead code fixes:
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -235,7 +235,6 @@ static int edit_patch(int argc, const char **argv,
const char *prefix)
        init_revisions(&rev, prefix);
        rev.diffopt.context = 7;

-       argc = setup_revisions(argc, argv, &rev, NULL);
        rev.diffopt.output_format = DIFF_FORMAT_PATCH;
        rev.diffopt.use_color = 0;
        rev.diffopt.flags.ignore_dirty_submodules = 1;

diff --git a/fsck.c b/fsck.c
index 032699e..78563c3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -704,7 +704,6 @@ static int fsck_ident(const char **ident, struct
object *obj, struct fsck_option
            !isdigit(p[4]) ||
            (p[5] != '\n'))
                return report(options, obj, FSCK_MSG_BAD_TIMEZONE,
"invalid author/committer line - bad time zone");
-       p += 6;
        return 0;
 }

-- 
Sincerely,

CodeAI Tech Support Team
