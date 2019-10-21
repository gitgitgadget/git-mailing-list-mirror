Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814F91F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 21:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfJUVyr (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 17:54:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43048 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 17:54:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so10425590wrr.10
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ub/8I3+AHyufmoA90malLXP8CD6qLR0vaHVofFYW6vY=;
        b=tcj/jiWB/Z49UmhLAccZ2ePs0WqE9pOz1ktAsjDvTqcAKRTMKnW9txDF3Ww/WVJyMl
         OEDSahzDd6IUCy0VIEx9h8QHutiU0s0dKXGMPO9BvT26wBYfvMHxvBETtr8fD/6JULSg
         vhMp4xGqcZ/rlhnMxkdcfvNtIfSYNUzPPW+wjIkE+VDzNyuJsapkxA9Fx7+2+DEdNGH/
         NULrzD8z0MSY/OfsMM2bEZbsixIo1mFTiZARctu3/2VP6iUzDXrU6jwsFgw4y2yS2jva
         zQqRX3Je1Sdplapt/7a23F2rWMxnaowFCARFP0kTpnZjJ049FDldTRXeM+aolmsnPI6f
         dnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ub/8I3+AHyufmoA90malLXP8CD6qLR0vaHVofFYW6vY=;
        b=gMb4PA3BHqcRjEuyYZT1MgxUr8AHg/Yt5+neWbbUASpniQ+FUcSc5f3ovUGCHU5z9U
         mxcgpunOMpY/dkDLiYKRlOS2mBRnVVD7gFLvLlGsfOLadZZEn+HdDbjlmtnOwAO4PxYu
         ba75Z73Egg2R1TU7USl6uaD86+oLk1YryUo1c/p5INLdEjTfhJJCwn96qnaXpSfRxRMt
         Q3TxwdlVYpGxg2p9dmya+pPzooSwB1jLVObaKLDIksDMg0y0/9JGVV+HK14T2+t6MIBP
         Efs3P5T/tNAR0FuQNl5zIvf7XkB3hXZ58H11c1egq+Ho8AjiKmUIq50MUcrf0FZa44gw
         Fojg==
X-Gm-Message-State: APjAAAV1qpve1MXRbsFQkwFdbmKUuQfTgaM4wnYF6hJaTEKIEvzhgwZz
        jMit9lp8i5w6oj1wwea+Sym7JGAv
X-Google-Smtp-Source: APXvYqw8MuPfnJ+F0oRdCPOJuq+co9J2vr/9iqQbvZAoIt5VAEBE7IvWevVlOOSzQaASMmoWFsYi6A==
X-Received: by 2002:adf:a109:: with SMTP id o9mr344467wro.96.1571694883886;
        Mon, 21 Oct 2019 14:54:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm22666013wra.70.2019.10.21.14.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 14:54:43 -0700 (PDT)
Message-Id: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 21:54:40 +0000
Subject: [PATCH v3 0/2] Handle git_path() with lock files correctly in worktrees
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

 path.c                |  8 +++++++-
 t/t1400-update-ref.sh | 18 ++++++++++--------
 t/t1500-rev-parse.sh  | 15 +++++++++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-401%2Fdscho%2Flock-files-in-worktrees-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-401/dscho/lock-files-in-worktrees-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/401

Range-diff vs v2:

 1:  cf97c5182e = 1:  cf97c5182e t1400: wrap setup code in test case
 2:  93dba5a3a3 ! 2:  8b1f4f089a git_path(): handle `.lock` files correctly
     @@ -4,12 +4,12 @@
      
          Ever since worktrees were introduced, the `git_path()` function _really_
          needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
     -    specific to the worktree). However, the wrong path is returned for
     -    `logs/HEAD.lock`.
     +    specific to the worktree, and therefore so is its reflog). However, the
     +    wrong path is returned for `logs/HEAD.lock`.
      
          This does not matter as long as the Git executable is doing the asking,
     -    as the path for that `index.lock` file is constructed from
     -    `git_path("index")` by appending the `.lock` suffix.
     +    as the path for that `logs/HEAD.lock` file is constructed from
     +    `git_path("logs/HEAD")` by appending the `.lock` suffix.
      
          However, Git GUI just learned to use `--git-path` instead of appending
          relative paths to what `git rev-parse --git-dir` returns (and as a
     @@ -19,7 +19,8 @@
          let's be safe rather than sorry.
      
          Side note: Git GUI _does_ ask for `index.lock`, but that is already
     -    resolved correctly.
     +    resolved correctly, due to `update_common_dir()` preferring to leave
     +    unknown paths in the (worktree-specific) git directory.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -27,23 +28,23 @@
       --- a/path.c
       +++ b/path.c
      @@
     - 	int result;
     - 	struct trie *child;
     - 
     --	if (!*key) {
     -+	if (!*key || !strcmp(key, ".lock")) {
     - 		/* we have reached the end of the key */
     - 		if (root->value && !root->len)
     - 			return fn(key, root->value, baton);
     -@@
     - 
     - 	/* Matched the entire compressed section */
     - 	key += i;
     --	if (!*key)
     -+	if (!*key || !strcmp(key, ".lock"))
     - 		/* End of key */
     - 		return fn(key, root->value, baton);
     + static void update_common_dir(struct strbuf *buf, int git_dir_len,
     + 			      const char *common_dir)
     + {
     +-	char *base = buf->buf + git_dir_len;
     ++	char *base = buf->buf + git_dir_len, *base2 = NULL;
     ++
     ++	if (ends_with(base, ".lock"))
     ++		base = base2 = xstrndup(base, strlen(base) - 5);
     ++
     + 	init_common_trie();
     + 	if (trie_find(&common_trie, base, check_common, NULL) > 0)
     + 		replace_dir(buf, git_dir_len, common_dir);
     ++
     ++	free(base2);
     + }
       
     + void report_linked_checkout_garbage(void)
      
       diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
       --- a/t/t1500-rev-parse.sh

-- 
gitgitgadget
