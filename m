Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E791F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeJWGZ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:25:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44729 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeJWGZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:25:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so20577325pff.11
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y/OWMp5B5RBkWNchzhmGGiQC28D/TmGzOPENbxKeD08=;
        b=MXReJVzONTkCHB8e+KqhNuxRmX5y4+EyjfEw2oJ1XX4IZ7m7NM+NmDpdrhWptq1ocx
         hZSTx1Bz8atTA/4pYDr9Pn/pAkRDoRO1j0QncTWXZJ9Fg8t6P1vOhrWIYGExXDei5oqJ
         fvjnfSmNLmSSA8dHBz5Sq8J3X9Y8te0EalRQpj2mLP26S4mJFf/LDBTWidyKJUQkhFmh
         QQq0NGGNRZ3wFVbulUj6s3VytLh8vqxS4UbFoksqxmqe/RkjAWVvybKqbq/1vK21AoBP
         xZfNA+pXzP7qwqO9fIkxkLq7Jyfm16Xwe6O9LNDXeV1RPUnvVHjeHuaY6jEm+SiE4Niq
         EdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y/OWMp5B5RBkWNchzhmGGiQC28D/TmGzOPENbxKeD08=;
        b=HmaLgqkwTz6l6wYnAGUccd+hFTg6UbViKqzIPTGIt5UNZ7EcoGd1Ka4UCKEdRz1ykp
         8YOC75bX95fBEPNJKpFoGc7IPp6efnLoTuHeTxj7Hu0mEI/EwWkULNlS1oWic7ynQ6MK
         q6ZVi7A7vqqn9O9i9gRZlIra2D7WyGb1u6zMsulegBJQxKsveZ2b//CMqthBhAO+6Anq
         Rce2DSWQiLbbkXxwc5UBkL+40ty5yFNxSV1IsJu9v9E50tdYh0x6DmpGeu53JH88MAmr
         TRsBAwSnweVh1yooA+LqoZdwIbUbZnThuiK0b5I4QNl0yq7ZbjD4DJNna6Q+5dMIjFpT
         uunA==
X-Gm-Message-State: AGRZ1gIniRQoZ5+FtQ64jFLE/GMUvcd39m8eJt1gZU+b/w2wfVclIYBJ
        cTepXffm4wes1I5CoQEZn/d2a8+w
X-Google-Smtp-Source: AJdET5ew/r3Cqtt2NatoOwK5759Mk9kKMPNpvg+HEPczgHY6buCkM7X0TMeldOIrqoRJIv/V7TBjoQ==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr4716037pgo.264.1540245936606;
        Mon, 22 Oct 2018 15:05:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id z63-v6sm40644498pfz.31.2018.10.22.15.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:05:35 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:05:35 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:05:30 GMT
Message-Id: <pull.9.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v2.git.gitgitgadget@gmail.com>
References: <pull.9.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/3] repack -ad: fix after fetch --prune in a shallow repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under certain circumstances, commits that were reachable can be made
unreachable, e.g. via git fetch --prune. These commits might have been
packed already, in which case git repack -adlf will just drop them without
giving them the usual grace period before an eventual git prune (via git gc)
prunes them.

This is a problem when the shallow file still lists them, which is the
reason why git prune edits that file. And with the proposed changes, git
repack -ad will now do the same.

Reported by Alejandro Pauly.

Changes since v2:

 * Fixed a typo in the last commit message.
 * Added an explanation to the last commit message why we do not simply skip
   non-existing shallow commits at fetch time.
 * Introduced a new, "quick prune" mode where prune_shallow() does not try
   to drop unreachable commits, but only non-existing ones.
 * Rebased to current master because there were too many merge conflicts for
   my liking otherwise.

Changes since v1:

 * Also trigger prune_shallow() when --unpack-unreachable=<approxidate> was
   passed to git repack.
 * No need to trigger prune_shallow() when git repack was called with -k.

Johannes Schindelin (3):
  repack: point out a bug handling stale shallow info
  shallow: offer to prune only non-existing entries
  repack -ad: prune the list of shallow commits

 builtin/prune.c          |  2 +-
 builtin/repack.c         |  6 ++++++
 commit.h                 |  2 +-
 shallow.c                | 22 +++++++++++++++++-----
 t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 7 deletions(-)


base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-9%2Fdscho%2Fshallow-and-fetch-prune-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-9/dscho/shallow-and-fetch-prune-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/9

Range-diff vs v2:

 1:  d2be40131 ! 1:  ed8559b91 repack: point out a bug handling stale shallow info
     @@ -48,4 +48,6 @@
      +		origin "+refs/heads/*:refs/remotes/origin/*"
      +'
      +
     - test_done
     + . "$TEST_DIRECTORY"/lib-httpd.sh
     + start_httpd
     + 
 -:  --------- > 2:  f085eb4f7 shallow: offer to prune only non-existing entries
 2:  c7ee6e008 ! 3:  1f9ff57d5 repack -ad: prune the list of shallow commits
     @@ -2,15 +2,19 @@
      
          repack -ad: prune the list of shallow commits
      
     -    While it is true that we never add unreachable commits into pack files
     -    intentionally (as `git repack`'s documentation states), we must not
     -    forget that a `git fetch --prune` (or even a `git fetch` when a ref was
     +    `git repack` can drop unreachable commits without further warning,
     +    making the corresponding entries in `.git/shallow` invalid, which causes
     +    serious problems when deepening the branches.
     +
     +    One scenario where unreachable commits are dropped by `git repack` is
     +    when a `git fetch --prune` (or even a `git fetch` when a ref was
          force-pushed in the meantime) can make a commit unreachable that was
          reachable before.
      
          Therefore it is not safe to assume that a `git repack -adlf` will keep
          unreachable commits alone (under the assumption that they had not been
     -    packed in the first place).
     +    packed in the first place, which is an assumption at least some of Git's
     +    code seems to make).
      
          This is particularly important to keep in mind when looking at the
          `.git/shallow` file: if any commits listed in that file become
     @@ -23,8 +27,16 @@
          To avoid this problem, let's prune the shallow list in `git repack` when
          the `-d` option is passed, unless `-A` is passed, too (which would force
          the now-unreachable objects to be turned into loose objects instead of
     -    being deleted). Additionally, e also need to take `--keep-reachable` and
     -    `--unpack-unreachable=<date>` into account.
     +    being deleted). Additionally, we also need to take `--keep-reachable`
     +    and `--unpack-unreachable=<date>` into account.
     +
     +    Note: an alternative solution discussed during the review of this patch
     +    was to teach `git fetch` to simply ignore entries in .git/shallow if the
     +    corresponding commits do not exist locally. A quick test, however,
     +    revealed that the .git/shallow file is written during a shallow *clone*,
     +    in which case the commits do not exist, either, but the "shallow" line
     +    *does* need to be sent. Therefore, this approach would be a lot more
     +    finicky than the approach presented by the this patch.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -32,15 +44,15 @@
      --- a/builtin/repack.c
      +++ b/builtin/repack.c
      @@
     - 		if (!quiet && isatty(2))
     + 		if (!po_args.quiet && isatty(2))
       			opts |= PRUNE_PACKED_VERBOSE;
       		prune_packed_objects(opts);
      +
      +		if (!keep_unreachable &&
      +		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
      +		     unpack_unreachable) &&
     -+		    is_repository_shallow())
     -+			prune_shallow(0);
     ++		    is_repository_shallow(the_repository))
     ++			prune_shallow(0, 1);
       	}
       
       	if (!no_update_server_info)

-- 
gitgitgadget
