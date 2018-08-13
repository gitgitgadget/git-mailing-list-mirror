Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBF11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbeHNB04 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:26:56 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:37726 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:26:56 -0400
Received: by mail-ua1-f74.google.com with SMTP id w15-v6so8482290uao.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=32z+5Gf4NigpeeXG4FSsvbwtGxJvJJrmz+lbceP1Nt4=;
        b=PgYDAxmUNUjSTCwsNBY7w+rH4MD/CdGU1QvBHNLzIFxFOotKor/6OjotPk9eXAYIM0
         diUXv3pLO4KG3KdlBzUi/Y35HXzIevNJ6oK0Ckj8N+ss0m7ojJYhT2EhNC82NvWT9PCk
         MulwMrXxQQ5KhmM5pusjFpzIHsZVkz7wcPChLUxx9pREVOfEU59/qzHqeh39ZUaIJLdC
         ZO3NtJO30v+3n5fNSskC9cWGEll8wZVrMsQx1D5Fx7aMGbG+MHYZXrG4rExcBpU4N/4+
         JSd6gVzfxxdGPprU8ZPvVnw+AYb+nWUW4V56m+VL/ql9XmAFEKWxBhmgAOHHsJJWFXFi
         Q5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=32z+5Gf4NigpeeXG4FSsvbwtGxJvJJrmz+lbceP1Nt4=;
        b=IF5Pcofg9R7zLxPaVbN6ntehvSttD5oVg0lf7nW4hqfdIqmvd+ZZ/WfnL5oZYGVEQP
         CtK1GAFusHzVHFbYQtieB5slcWl7NrJ4eW6imLuUyHVdUo/cBaKPHhyGQ0USg5xu5ScE
         oiUBKSrDcJMJpwKx1C+VVymN3oaCsDwZ7j2QjUjgeHH81CgrIT0K4KoWMBL/5EGKwXSZ
         9ExgoRuJkz9WZb9khGJMdjfbtk4IEhtb70dHJeYYCRGkvLn0u4zxCoTn7j1qd9g6Tjzy
         Ke6qahmBMMVEzAZ8QgsdHVdKlNiWelXcq7ZPJP3WfsgkL7Areo/zlbAQ15XfYQVodUvx
         ZPaA==
X-Gm-Message-State: AOUpUlGmQdLy+ylKt/nmS0cU4oGYvD/5gPebUPy4rbJhQ/e7GLYMCanm
        IjrDGVbLsQytOekNIWoEQopWLyjNFfld
X-Google-Smtp-Source: AA+uWPyLVAmRjhG/DNXXlwmkD+IrstYWyUMgpk8ye1arZg1XdeV8Grwa0BuFrYRHBekW5C9P3tRpbM+2VDbW
X-Received: by 2002:a1f:43cd:: with SMTP id q196-v6mr11087301vka.39.1534200159822;
 Mon, 13 Aug 2018 15:42:39 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:28 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180813224235.154580-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 0/7] Resend of sb/submodule-update-in-c
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Brandon for pointing out to use repo_git_path instead of
manually constructing the path.

That is the only change in this resend.

Thanks,
Stefan

Stefan Beller (7):
  git-submodule.sh: align error reporting for update mode to use path
  git-submodule.sh: rename unused variables
  builtin/submodule--helper: factor out submodule updating
  builtin/submodule--helper: store update_clone information in a struct
  builtin/submodule--helper: factor out method to update a single
    submodule
  submodule--helper: replace connect-gitdir-workingtree by
    ensure-core-worktree
  submodule--helper: introduce new update-module-mode helper

 builtin/submodule--helper.c | 216 ++++++++++++++++++++++++++----------
 git-submodule.sh            |  29 +----
 2 files changed, 164 insertions(+), 81 deletions(-)

(I am not yet using format-patches internal range diff version,
but  the paste below is manually crafted; the patch numbers are off, as
the fix was done in the second to last patch)

./git-range-diff origin/sb/submodule-update-in-c...

1:  1c866b9831d ! 1:  7bb6249dea9 submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
    @@ -49,7 +49,7 @@
     +		const char *rel_path;
     +		struct strbuf sb = STRBUF_INIT;
     +
    -+		cfg_file = xstrfmt("%s/config", subrepo.gitdir);
    ++		cfg_file = repo_git_path(&subrepo, "config");
     +
     +		abs_path = absolute_pathdup(path);
     +		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
2:  5a3587e9c25 = 2:  23dc45cee2d submodule--helper: introduce new update-module-mode helper
