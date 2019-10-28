Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0772B1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 12:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfJ1M5W (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 08:57:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35455 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfJ1M5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 08:57:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so9777948wrb.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CXwhP+Jaw9J5oZRI57uEhKhQgqRCYghthPlfsJq8Hyo=;
        b=BZUzsdicwoewrU8+hhP/P1CdemeO8c9wNeeeqPMMZ2vrHjPD1AFXofaT8tpK480m5g
         yKzyloG7f+PdKysWsRhBmq5oNb2P3rapDTQxFc8+3dZwof/Qmab2Q8r3yJkcM2zZQVoa
         bqE7+HOtzSzyjZKRjHKTRQH2hIkZlaNTGcx4xYXM+SWBwRne6uH3CGsZbtVLVOdC1EqX
         j5cbFWZLqi3ZIz+Zb42wulS8yheit2DIT35Kaicic439Mq4HtGqpLfV4lERGfrUhLEP0
         c4dIRsgo4oNPuZ2tjahCOcXGtmLUWLLwh+mY4pxpcCeheNsWXw9TiUSnAQ4fqmvkVQTp
         mACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CXwhP+Jaw9J5oZRI57uEhKhQgqRCYghthPlfsJq8Hyo=;
        b=FO/rd9sbobfYmynimgOm6qpN+h6ks2fjKW08EtQuVa1Fi/HyBtbnvo5l8iAqYONs7+
         DStFTbKYuKksb/29wjkB/8/h/yyxm5FS5UjsuxPRMo/a1+V5eJjAN45dBJ4JErTSBUj3
         reb5brvJjNOkb/YIemJY6GZM52zcsy0SpBzmEGFfWiEeTcs16l7HD0Qq8YkhXC7OH+d6
         PHw1MPM3EUwD9QFS6cXRoJe276HSZ/BWJMojz6fX0BXnI3Xgf56uH6ox7jQ8S2r48dtd
         Ba/OYU7FYwT9fZrR7gti+Fz4piCpcSGYEksAJhfaedgpqb4hTjPpOH7BCLPY+73qSepY
         XkHQ==
X-Gm-Message-State: APjAAAWcL1R46hse1TthbnxlHruybBf0wrNNxI8h3Oyf7RkG2JArILYN
        BC9yx7e/PvJ0Prm/0A9Q00QlzE2K
X-Google-Smtp-Source: APXvYqwNNKmtzJbx0QK9zXxo/7Nvw4xOnfmarOi7SUZisT33rHPLKRuvDkf4z2IlhOwD8FmW99EB/w==
X-Received: by 2002:adf:8011:: with SMTP id 17mr15461758wrk.367.1572267439414;
        Mon, 28 Oct 2019 05:57:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm11471737wmc.22.2019.10.28.05.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:57:18 -0700 (PDT)
Message-Id: <pull.401.v4.git.1572267438.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
References: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 12:57:16 +0000
Subject: [PATCH v4 0/2] Handle git_path() with lock files correctly in worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled over this during my recent work in Git GUI
[https://github.com/gitgitgadget/git/pull/361] that was originally really
only intended to use the correct hooks directory.

It turns out that my fears that index.lock was mishandled were unfounded,
hence this patch series has a lot lower priority for me than "OMG we must
push this into v2.24.0!".

Technically, the first patch is not needed (because I decided against adding
a test to t1400 in the end, in favor of t1500), but it shouldn't hurt,
either.

I verified locally that this patch pair does not conflict with 
sg/dir-trie-fixes.

Changes since v3:

 * Instead of duplicating the path when it has a .lock suffix, we now use 
   strbuf manipulation to strip the suffix temporarily.
 * The test case in t1500 was scrapped in favor of a much simpler pair of
   test cases in t0060.

Changes since v2:

 * Adjusted the commit message to really not talk about index.lock.
 * Instead of modifying the code inside trie_find() to special-case .lock, I
   now copy the string without the suffix .lock (if any) before handing it
   off to trie_find().

Changes since v1:

 * Clarified the commit message to state that index.lock is fine, it is 
   logs/HEAD.lock that isn't.

Johannes Schindelin (2):
  t1400: wrap setup code in test case
  git_path(): handle `.lock` files correctly

 path.c                |  6 ++++++
 t/t0060-path-utils.sh |  2 ++
 t/t1400-update-ref.sh | 18 ++++++++++--------
 3 files changed, 18 insertions(+), 8 deletions(-)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-401%2Fdscho%2Flock-files-in-worktrees-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-401/dscho/lock-files-in-worktrees-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/401

Range-diff vs v3:

 1:  cf97c5182e = 1:  cf97c5182e t1400: wrap setup code in test case
 2:  8b1f4f089a ! 2:  d98810875e git_path(): handle `.lock` files correctly
     @@ -28,46 +28,40 @@
       --- a/path.c
       +++ b/path.c
      @@
     - static void update_common_dir(struct strbuf *buf, int git_dir_len,
     + #include "path.h"
     + #include "packfile.h"
     + #include "object-store.h"
     ++#include "lockfile.h"
     + 
     + static int get_st_mode_bits(const char *path, int *mode)
     + {
     +@@
       			      const char *common_dir)
       {
     --	char *base = buf->buf + git_dir_len;
     -+	char *base = buf->buf + git_dir_len, *base2 = NULL;
     -+
     -+	if (ends_with(base, ".lock"))
     -+		base = base2 = xstrndup(base, strlen(base) - 5);
     + 	char *base = buf->buf + git_dir_len;
     ++	int has_lock_suffix = strbuf_strip_suffix(buf, LOCK_SUFFIX);
      +
       	init_common_trie();
       	if (trie_find(&common_trie, base, check_common, NULL) > 0)
       		replace_dir(buf, git_dir_len, common_dir);
      +
     -+	free(base2);
     ++	if (has_lock_suffix)
     ++		strbuf_addstr(buf, LOCK_SUFFIX);
       }
       
       void report_linked_checkout_garbage(void)
      
     - diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
     - --- a/t/t1500-rev-parse.sh
     - +++ b/t/t1500-rev-parse.sh
     + diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
     + --- a/t/t0060-path-utils.sh
     + +++ b/t/t0060-path-utils.sh
      @@
     - 	test_cmp expect actual
     - '
     - 
     -+test_expect_success 'git-path in worktree' '
     -+	test_tick &&
     -+	git commit --allow-empty -m empty &&
     -+	git worktree add --detach wt &&
     -+	test_write_lines >expect \
     -+		"$(pwd)/.git/worktrees/wt/logs/HEAD" \
     -+		"$(pwd)/.git/worktrees/wt/logs/HEAD.lock" \
     -+		"$(pwd)/.git/worktrees/wt/index" \
     -+		"$(pwd)/.git/worktrees/wt/index.lock" &&
     -+	git -C wt rev-parse >actual \
     -+		--git-path logs/HEAD --git-path logs/HEAD.lock \
     -+		--git-path index --git-path index.lock &&
     -+	test_cmp expect actual
     -+'
     -+
     - test_expect_success 'rev-parse --is-shallow-repository in shallow repo' '
     - 	test_commit test_commit &&
     - 	echo true >expect &&
     + test_git_path GIT_OBJECT_DIRECTORY=foo objects2 .git/objects2
     + test_expect_success 'setup common repository' 'git --git-dir=bar init'
     + test_git_path GIT_COMMON_DIR=bar index                    .git/index
     ++test_git_path GIT_COMMON_DIR=bar index.lock               .git/index.lock
     + test_git_path GIT_COMMON_DIR=bar HEAD                     .git/HEAD
     + test_git_path GIT_COMMON_DIR=bar logs/HEAD                .git/logs/HEAD
     ++test_git_path GIT_COMMON_DIR=bar logs/HEAD.lock           .git/logs/HEAD.lock
     + test_git_path GIT_COMMON_DIR=bar logs/refs/bisect/foo     .git/logs/refs/bisect/foo
     + test_git_path GIT_COMMON_DIR=bar logs/refs/bisec/foo      bar/logs/refs/bisec/foo
     + test_git_path GIT_COMMON_DIR=bar logs/refs/bisec          bar/logs/refs/bisec

-- 
gitgitgadget
