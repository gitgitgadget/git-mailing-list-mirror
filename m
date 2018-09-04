Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14221F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIEC0x (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:26:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34397 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:26:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so2264363plo.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZWGIcSk0+8C8ujuJDMK2RA2Wd4iQAIwlZQBAfsxLNcg=;
        b=cUxtteqEupBf4NEBKteoXQMZMzSdOo7l6AfVyP+pQXepFBSO6E2Ic7mC4Xvu7Vvh/C
         Qerz0s6nxntdmy0vyGdGjPwtHjQDzFqnq95aqkvu9SCU1nKtY+HLBFb6l1/cn+udaANp
         eR64ZDtoTFPenxe4zSj/VNDwl6oV1hPrzI9rZwyJEfci68idiFJ4xogwSXnRugFkYd2Y
         0uYH5VW62q9pL872UBaLizNryO9mEc/CRu1GaPE5NaFTyXVmXDnI7CW1p7vgO2RXyXqv
         a5teu5F7m0Uv/REEG75JEf7cRstavsIoYDQpZH86A3QjpW+/5F53Q8+au2ThYV8QK4KY
         M+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZWGIcSk0+8C8ujuJDMK2RA2Wd4iQAIwlZQBAfsxLNcg=;
        b=rdSCqpy2um8ondw4AYEMUucnjpKAx/0oURGGnTlpItk8Vzd4UzoIOFiBaut/RrcLQz
         bJb6d2g5CGW4UHKKHLOk+jJr8mE+CK7IHQg5LEAegPn2wpw4eFH83OV3AAkL9VZYYGSS
         VtyszdZ7fHnYEEMylCbW+9EVBsR/d3ZSfqAuYFft8kBOgBboyB/13fVgJkrOtCJ62x0e
         L6qEBGFyRXMrU4+MDoBLuhdZaOUZ1e6fqPzF5hNew33IomiFZEEiYwyMM9VkDy/hIVV1
         UibUthFxtbAqrjfqjxikZBFwyHnmBY+ibl4Zc/Vj0/n+nzQlifoy5KZKs7U1ZDhVdeuY
         zkvA==
X-Gm-Message-State: APzg51AMrUALZXX1glJcO33aQ7MTMYxcXTyUCV52AGUTo49a6MHGaSqY
        LAlhEcvxFS/m2y1UDHjmEfiKWGLa
X-Google-Smtp-Source: ANB0VdbHkymPu5G1Axk/ZjsQTY5o/nZ4MxyZDSCwKGBu3G7sdpXeNEEvpYY6O9zsHF277I+N9GUG7w==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr34797943plb.99.1536098388575;
        Tue, 04 Sep 2018 14:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id x2-v6sm44760489pfi.166.2018.09.04.14.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:47 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:47 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:27 GMT
Message-Id: <pull.33.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/18] builtin rebase options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series completes the support for all rebase options in the
builtin rebase, e.g. --signoff, rerere-autoupdate, etc.

It is based on pk/rebase -in-c-3-acts.

Changes since v1:

 * Added the forgotten -k short option for --keep-empty (and verified that
   no other short options were forgotten).
 * The "Applied autostash" message is now translated (as was the original in
   the shell script version).

Pratik Karki (18):
  builtin rebase: allow selecting the rebase "backend"
  builtin rebase: support --signoff
  builtin rebase: support --rerere-autoupdate
  builtin rebase: support --committer-date-is-author-date
  builtin rebase: support `ignore-whitespace` option
  builtin rebase: support `ignore-date` option
  builtin rebase: support `keep-empty` option
  builtin rebase: support `--autosquash`
  builtin rebase: support `--gpg-sign` option
  builtin rebase: support `-C` and `--whitespace=<type>`
  builtin rebase: support `--autostash` option
  builtin rebase: support `--exec`
  builtin rebase: support `--allow-empty-message` option
  builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
  merge-base --fork-point: extract libified function
  builtin rebase: support `fork-point` option
  builtin rebase: add support for custom merge strategies
  builtin rebase: support --root

 builtin/merge-base.c |  81 +-------
 builtin/rebase.c     | 449 ++++++++++++++++++++++++++++++++++++++++++-
 commit.c             |  81 ++++++++
 commit.h             |   2 +
 4 files changed, 528 insertions(+), 85 deletions(-)


base-commit: e01f72be63e6cb58243124abb2491f9d5dbcdbef
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-33%2Fdscho%2Frebase-in-c-4-opts-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-33/dscho/rebase-in-c-4-opts-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/33

Range-diff vs v1:

  1:  22a65191f8 !  1:  7f751c6ce1 builtin rebase: allow selecting the rebase "backend"
     @@ -19,6 +19,7 @@
          tests for this via `git pull --rebase=preserve`).
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  2:  cb9129890b !  2:  1e2ce4b34e builtin rebase: support --signoff
     @@ -7,6 +7,7 @@
          handling is left to the rebase backends.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  3:  99ff1fc128 !  3:  a301ef6bbd builtin rebase: support --rerere-autoupdate
     @@ -7,6 +7,7 @@
          `git-legacy-rebase.sh`.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  4:  cb6596ea93 !  4:  8f67a3969d builtin rebase: support --committer-date-is-author-date
     @@ -6,6 +6,7 @@
          `git_am_opt` variable that is handled by the `git-rebase--am` backend.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  5:  bf3279c2d5 !  5:  f04394a500 builtin rebase: support `ignore-whitespace` option
     @@ -7,6 +7,7 @@
          `--am` backend.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  6:  804e1969c2 !  6:  83bb277509 builtin rebase: support `ignore-date` option
     @@ -6,6 +6,7 @@
          to easily change the dates of the rebased commits.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  7:  fcf2243476 !  7:  a8f12bf01f builtin rebase: support `keep-empty` option
     @@ -12,6 +12,7 @@
          already be chosen during the `parse_options()` call.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
     @@ -60,7 +61,7 @@
       			 &options.allow_rerere_autoupdate,
       			 N_("allow rerere to update index  with resolved "
       			    "conflict")),
     -+		OPT_BOOL(0, "keep-empty", &options.keep_empty,
     ++		OPT_BOOL('k', "keep-empty", &options.keep_empty,
      +			 N_("preserve empty commits during rebase")),
       		OPT_END(),
       	};
  8:  b4ecffc8f1 !  8:  1b6851e5e1 builtin rebase: support `--autosquash`
     @@ -12,6 +12,7 @@
          falls back to) git_default_config().
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
     @@ -46,7 +47,7 @@
       
      @@
       			    "conflict")),
     - 		OPT_BOOL(0, "keep-empty", &options.keep_empty,
     + 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
       			 N_("preserve empty commits during rebase")),
      +		OPT_BOOL(0, "autosquash", &options.autosquash,
      +			 N_("move commits that begin with "
  9:  e2a26f10e5 !  9:  b8055fb258 builtin rebase: support `--gpg-sign` option
     @@ -6,6 +6,7 @@
          to GPG-sign commits.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 10:  a1f3245250 ! 10:  98908573ce builtin rebase: support `-C` and `--whitespace=<type>`
     @@ -8,6 +8,7 @@
          shell script version does so, too.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 11:  7b3c0dbbd9 ! 11:  5e5e5cb758 builtin rebase: support `--autostash` option
     @@ -11,6 +11,7 @@
          builtin.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
     @@ -57,7 +58,7 @@
      +	stash_apply.no_stderr = stash_apply.no_stdout =
      +		stash_apply.no_stdin = 1;
      +	if (!run_command(&stash_apply))
     -+		printf("Applied autostash.\n");
     ++		printf(_("Applied autostash.\n"));
      +	else {
      +		struct argv_array args = ARGV_ARRAY_INIT;
      +		int res = 0;
 12:  6f6b3d9339 ! 12:  01e5cb3e91 builtin rebase: support `--exec`
     @@ -14,6 +14,7 @@
          The `--exec` option requires `--interactive` machinery.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 13:  fa643c4b3f ! 13:  1c723ad592 builtin rebase: support `--allow-empty-message` option
     @@ -14,6 +14,7 @@
          `git rebase`, therefore the builtin rebase does the same.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 14:  00d7ccd356 ! 14:  1bebcde41c builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
     @@ -6,6 +6,7 @@
          rebase, too.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 15:  1cf16f416e ! 15:  05652bccfe merge-base --fork-point: extract libified function
     @@ -12,6 +12,7 @@
          process definitely did not traverse any commits before exiting.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/merge-base.c b/builtin/merge-base.c
      --- a/builtin/merge-base.c
 16:  78ffb7aaff ! 16:  25f6771947 builtin rebase: support `fork-point` option
     @@ -6,6 +6,7 @@
          This is converted as-is from `git-legacy-rebase.sh`.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 17:  693b662542 ! 17:  10dc87d4ff builtin rebase: add support for custom merge strategies
     @@ -9,6 +9,7 @@
          This commit adds that support to the builtin rebase.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 18:  95679ccf0b ! 18:  f155141023 builtin rebase: support --root
     @@ -9,6 +9,7 @@
          the fact that we do not have to write an empty tree in C.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c

-- 
gitgitgadget
