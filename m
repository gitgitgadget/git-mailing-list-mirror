Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB6E20248
	for <e@80x24.org>; Thu,  7 Mar 2019 06:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfCGGoZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 01:44:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34304 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfCGGoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 01:44:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so10683744pfn.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 22:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYKfr0i0DgHLlF5KxPm3TGBVX5M9cyv4fgtVaFU7zKo=;
        b=FspQ8e2yn9HxZkyQFgdEIG4ceWV3/Lw/ycxPoKy/QKXE8LWaOMyPrZYZ/Fd7ZSejlM
         4cZGiG70dIno5MYAKDXtF+OjzxWUgcpISYhwXECgrbbWGyw9HY4KCNCU4Sqq2c2692UA
         GoqiMtWuXHu6K5AMWqCBZhHW4r1T3jCdp5ZSSqFmj4uJxn7GWkjX6lQgrGVrQSx3n4S3
         z0VWnHqnizsMoMKsXPts6VW/59VSeOI0rKgNybUELGM/pFFzNpP4llsi/SbH4wbMDoPF
         yUGvtv9cTGR1zEOTQNLZggQ0iUgV9ikB/Qe9ad0dSacrlhctP1VlIeo5iAKVXr2Be7OL
         xzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYKfr0i0DgHLlF5KxPm3TGBVX5M9cyv4fgtVaFU7zKo=;
        b=hOXISsX1yrTlzJg+t4cZMS9jYz/hjCwB5DZ/tqVNxvV3yE1yCc5pKXC2yDkxLTnUF7
         WlcuNLBvAxi9skJZISe+17fyyALNY1u8RabHqHOMY4vPbjwLd/mKv/VrISIh5EEn/QvK
         O3jcjIvHgXgJgC39FGDkyv4GS3p/aCBBV0oLHp8tRcyUMIbDbb1znC7gAAGp+MEzm6sE
         tFwS2MLSPfU8fVL/650D2Wv8pkZxC64TseamGytKHlhYyBRJRgzlm2r2186ibQhWf8WW
         wjoaMTcTIl3vCSJeLCOwYB5iJeHBz4ExEDHYnoaGpXUq07/bTsW25QK9l/gzhYqs6wf1
         2wSg==
X-Gm-Message-State: APjAAAUZCq1D1zm2+Q4jy9pl8RYn3T6IGGWdP77kMkx+RoXvjx/YeWOI
        lA3m0hmIwZFAtTOuBiFMbvFxnz3l
X-Google-Smtp-Source: APXvYqwbXg9zXaH1EY90BajJkGhyKE4PQBu6DlOysikSJDV9deu8LdwCWne93R8zekN8t2Gn4NrBGA==
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr11284428pld.297.1551941063622;
        Wed, 06 Mar 2019 22:44:23 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id v26sm5140552pgn.46.2019.03.06.22.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:44:22 -0800 (PST)
Date:   Wed, 6 Mar 2019 22:44:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] cherry-pick/revert cleanup scissors fix
Message-ID: <cover.1551940635.git.liu.denton@gmail.com>
References: <cover.1551867827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551867827.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I stated earlier[1], I discovered today that git revert (and thus,
git cherry-pick as well) do not place the scissors line properly as
well. This patchset adds a scissors line when conflicts arise in both
cherry-pick and revert, which fixes the same bug present in git-merge
earlier.

This patchset should apply on top of dl/merge-cleanup-scissors-fix.

Changes since v1:

* Address Phillip's concern of calling get_cleanup_mode with use_editor = 1;
  only set to 1 if we are calling for revert or cherry-pick, else 0 to maintain
  original behaviour (for rebasing).

* Do not die if provided an invalid cleanup option, instead just warn and
  fallback to default option.

[1]: https://public-inbox.org/git/20190306014143.GA2580@dev-l/


Denton Liu (3):
  t3507: cleanup space after redirection operators
  cherry-pick/revert: add scissors line on merge conflict
  sequencer.c: don't die on invalid cleanup_arg

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 builtin/merge.c                   |  13 +---
 builtin/rebase--helper.c          |   2 +-
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  39 +++++-----
 sequencer.h                       |   3 +-
 t/t3507-cherry-pick-conflict.sh   | 122 +++++++++++++++++++++++++-----
 8 files changed, 149 insertions(+), 49 deletions(-)

Range-diff against v1:
1:  70a508ca0b ! 1:  8fdc5bfb15 cherry-pick/revert: add scissors line on merge conflict
    @@ -8,11 +8,11 @@
     
         Note that the removal of the if-else tower in git_sequencer_config may
         appear to be a no-op refactor but it actually isn't. First of all, we
    -    now accept "default" as a configuration option and also we die on an
    -    invalid cleanup mode. Most importantly, though, if
    +    now accept "default". More importantly, though, if
         commit.cleanup = scissors, the cleanup enum will be set to
    -    COMMIT_MSG_CLEANUP_SCISSORS instead of COMMIT_MSG_CLEANUP_SPACE. This
    -    allows us to append scissors to MERGE_MSG in the case of a conflict.
    +    COMMIT_MSG_CLEANUP_SCISSORS instead of COMMIT_MSG_CLEANUP_SPACE when we
    +    are reverting or cherry-picking. This allows us to append scissors to
    +    MERGE_MSG in the case of a conflict.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ -77,6 +77,22 @@
      	strbuf_release(&msgbuf);
      	fclose(fp);
     
    + diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
    + --- a/builtin/rebase--helper.c
    + +++ b/builtin/rebase--helper.c
    +@@
    + 		OPT_END()
    + 	};
    + 
    ++	opts.action = REPLAY_INTERACTIVE_REBASE;
    + 	sequencer_init_config(&opts);
    + 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
    + 
    +-	opts.action = REPLAY_INTERACTIVE_REBASE;
    + 	opts.allow_ff = 1;
    + 	opts.allow_empty = 1;
    + 
    +
      diff --git a/builtin/revert.c b/builtin/revert.c
      --- a/builtin/revert.c
      +++ b/builtin/revert.c
    @@ -108,6 +124,18 @@
      diff --git a/sequencer.c b/sequencer.c
      --- a/sequencer.c
      +++ b/sequencer.c
    +@@
    + static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
    + static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
    + 
    ++static inline int is_rebase_i(const struct replay_opts *opts)
    ++{
    ++	return opts->action == REPLAY_INTERACTIVE_REBASE;
    ++}
    ++
    + static int git_sequencer_config(const char *k, const char *v, void *cb)
    + {
    + 	struct replay_opts *opts = cb;
     @@
      		if (status)
      			return status;
    @@ -123,10 +151,22 @@
     -		else
     -			warning(_("invalid commit message cleanup mode '%s'"),
     -				  s);
    -+		opts->default_msg_cleanup = get_cleanup_mode(s, 1);
    ++		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts));
      
      		free((char *)s);
      		return status;
    +@@
    + 	git_config(git_sequencer_config, opts);
    + }
    + 
    +-static inline int is_rebase_i(const struct replay_opts *opts)
    +-{
    +-	return opts->action == REPLAY_INTERACTIVE_REBASE;
    +-}
    +-
    + static const char *get_dir(const struct replay_opts *opts)
    + {
    + 	if (is_rebase_i(opts))
     @@
      		die(_("Invalid cleanup mode %s"), cleanup_arg);
      }
-:  ---------- > 2:  f3af8000ae sequencer.c: don't die on invalid cleanup_arg
-- 
2.21.0.368.gbf248417d7

