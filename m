Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0DF1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYAYt (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:24:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeJYAYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:24:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so2623509pfn.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sazefXjjkJnh+EsI/ao/JsWaIv0d8MgFyPgRzHVTVaE=;
        b=EkDFC8QR5L9rOCNIcTZv/ho4FvMaIPpP+1VDYTtSy+NhNOaP22+q91WOPYeZtRN0Mu
         d0T24sPvZZfolHGoLdDyAcAib86LV/sz7TsmEO75B99RjLftZIgZXQzj+nAbYPLM1d0i
         LHcXon59gqt1hAU2kCkWTGMBn+910/vgshKxsgtNyq+9TUc/Tjqmp5aUPIufTA6jZYHg
         Vjiyd8Gjgcs9/pxtaR6pnKMOyfOksecFsDzFNVybkIRLsHySaAaKe8g4NHji/bfbkHCr
         SyiJnQDBPyLk+pleX94EWJVJ1ND/W0VahjjvrtiUjYAYLbyBMkGEeoain+RBdu3iVbqc
         daUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sazefXjjkJnh+EsI/ao/JsWaIv0d8MgFyPgRzHVTVaE=;
        b=L61+EDLep4LA4yIop/BPZu6E3+P/5kX3WZcuDIdJGOWjv1gLemG6zYstYOGbPYyOOP
         9mwou04uaxfrjRDa7rEDSLFIA9/VOQ8RJDS/rvF+/XYOR1+/6PnDKiPcJjLZgef1Gtyl
         jYNi+siffsqiAXnhrkUe/Yf2MvArEOjFEsA0AySNvD/lxjsn2U8eXchfCkoHTFoxA8tt
         mfn4Fkp+f81fH5UQe53dG/OSsuwVaD1gjcC0+26PmXyA4/49QSsAvLH2/usqywcUnURM
         680TcoGNJ7E3kbYR9mP4FKgO6Qd73uhRmilSfzoxrIGXmfUZxXWjMSvoVBLamGk8QKYj
         fxoA==
X-Gm-Message-State: AGRZ1gJVAPo0eM1avQQjfWoP01SewAAGGW/XbTm+Ziaxno4SQaoVyVVF
        OegSgjOK+rQPz6FXK8IjUlkKoABW
X-Google-Smtp-Source: AJdET5c5EbI31oQc4GAuQhLzAqKasbsf5EaGO4lfBj8Q+xAqw058192Khi34CB8O9N9qYF9+cmQNBA==
X-Received: by 2002:a62:b50a:: with SMTP id y10-v6mr3194171pfe.199.1540396570129;
        Wed, 24 Oct 2018 08:56:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o12-v6sm7796189pfh.20.2018.10.24.08.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:56:08 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:56:08 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 15:56:04 GMT
Message-Id: <pull.9.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v3.git.gitgitgadget@gmail.com>
References: <pull.9.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/3] repack -ad: fix after fetch --prune in a shallow repository
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

Changes since v3:

 * Made the regression test less confusing with regards to tags that might
   need to be dereferenced.
 * Introduced new global constants PRUNE_SHOW_ONLY and PRUNE_QUICK instead
   of extending the signature of prune_shallow() with Boolean parameters.
 * While at it, renamed the file-local constant from QUICK_PRUNE to QUICK.
 * Replaced the lookup_commit() && parse_commit() cadence (that wants to
   test for the existence of a commit) to has_object_file(), for ease of
   readability, and also to make it more obvious how to add a call to 
   is_promisor_object() if we ever figure out that that would be necessary.

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
 commit.h                 |  4 +++-
 shallow.c                | 23 +++++++++++++++++------
 t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 8 deletions(-)


base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-9%2Fdscho%2Fshallow-and-fetch-prune-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-9/dscho/shallow-and-fetch-prune-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/9

Range-diff vs v3:

 1:  ed8559b91 ! 1:  d9720bd25 repack: point out a bug handling stale shallow info
     @@ -29,7 +29,7 @@
      +	test_commit -C shallow-server C &&
      +	test_commit -C shallow-server E &&
      +	test_commit -C shallow-server D &&
     -+	d="$(git -C shallow-server rev-parse --verify D)" &&
     ++	d="$(git -C shallow-server rev-parse --verify D^0)" &&
      +	git -C shallow-server checkout master &&
      +
      +	git clone --depth=1 --no-tags --no-single-branch \
     @@ -43,7 +43,7 @@
      +	test_must_fail git -C shallow-client rev-parse --verify $d^0 &&
      +	! grep $d shallow-client/.git/shallow &&
      +
     -+	git -C shallow-server branch branch-orig D^0 &&
     ++	git -C shallow-server branch branch-orig $d &&
      +	git -C shallow-client fetch --prune --depth=2 \
      +		origin "+refs/heads/*:refs/remotes/origin/*"
      +'
 2:  f085eb4f7 ! 2:  18308c13e shallow: offer to prune only non-existing entries
     @@ -12,6 +12,10 @@
      
          Let's support that use case.
      
     +    Rather than extending the signature of `prune_shallow()` to accept
     +    another Boolean, let's turn it into a bit field and declare constants,
     +    for readability.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/prune.c b/builtin/prune.c
     @@ -22,7 +26,7 @@
       
       	if (is_repository_shallow(the_repository))
      -		prune_shallow(show_only);
     -+		prune_shallow(show_only, 0);
     ++		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
       
       	return 0;
       }
     @@ -35,7 +39,9 @@
       					   int *ref_status);
       extern int delayed_reachability_test(struct shallow_info *si, int c);
      -extern void prune_shallow(int show_only);
     -+extern void prune_shallow(int show_only, int quick_prune);
     ++#define PRUNE_SHOW_ONLY 1
     ++#define PRUNE_QUICK 2
     ++extern void prune_shallow(unsigned options);
       extern struct trace_key trace_shallow;
       
       extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
     @@ -47,7 +53,7 @@
       
       #define SEEN_ONLY 1
       #define VERBOSE   2
     -+#define QUICK_PRUNE 4
     ++#define QUICK 4
       
       struct write_shallow_data {
       	struct strbuf *out;
     @@ -56,9 +62,8 @@
       	if (graft->nr_parent != -1)
       		return 0;
      -	if (data->flags & SEEN_ONLY) {
     -+	if (data->flags & QUICK_PRUNE) {
     -+		struct commit *c = lookup_commit(the_repository, &graft->oid);
     -+		if (!c || parse_commit(c))
     ++	if (data->flags & QUICK) {
     ++		if (!has_object_file(&graft->oid))
      +			return 0;
      +	} else if (data->flags & SEEN_ONLY) {
       		struct commit *c = lookup_commit(the_repository, &graft->oid);
     @@ -74,18 +79,19 @@
      + * commits that do not exist (any longer).
        */
      -void prune_shallow(int show_only)
     -+void prune_shallow(int show_only, int quick_prune)
     ++void prune_shallow(unsigned options)
       {
       	struct lock_file shallow_lock = LOCK_INIT;
       	struct strbuf sb = STRBUF_INIT;
      +	unsigned flags = SEEN_ONLY;
       	int fd;
       
     -+	if (quick_prune)
     -+		flags |= QUICK_PRUNE;
     -+
     - 	if (show_only) {
     +-	if (show_only) {
      -		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
     ++	if (options & PRUNE_QUICK)
     ++		flags |= QUICK;
     ++
     ++	if (options & PRUNE_SHOW_ONLY) {
      +		flags |= VERBOSE;
      +		write_shallow_commits_1(&sb, 0, NULL, flags);
       		strbuf_release(&sb);
 3:  1f9ff57d5 ! 3:  2858bc886 repack -ad: prune the list of shallow commits
     @@ -52,7 +52,7 @@
      +		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
      +		     unpack_unreachable) &&
      +		    is_repository_shallow(the_repository))
     -+			prune_shallow(0, 1);
     ++			prune_shallow(PRUNE_QUICK);
       	}
       
       	if (!no_update_server_info)

-- 
gitgitgadget
