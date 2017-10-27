Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 516701FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbdJ0R3O (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:29:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:48438 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbdJ0R3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:29:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id 15so6817566wrb.5
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVt0Cs/EkFQWvxLM0O1bpWsAwJBtTOrzGwZIB+IV6Fk=;
        b=fMw8qPtpXhGtSvbPmguZ4UeQiP9RC2/56dmUL2JCqE88mWHBjNym9dN+cUeAYApWc3
         7AsaaK4N/MGbMxx5s4BZd3DAZLlXpt1cA4i3viqIJgTX55epggv5I78uIw6MhdQVu+lI
         PJ7IQVkU4ixyXwWbpCHlMM5Bf9bM81OrekMdoP/IUasfjlljh9aG2wIQVufunR2mUzBc
         msFubcOZgAvQxAkmihLNWdqjpzhTXoeVCHGnzWlkAsaYthGWEffrnG/2B7F6T3acMn0u
         V3utVeKdNGYkadps+kNXMnaTfFTzJPR22N4dhA1X2MLQ5yfZXnIOW0KASR1Mo422p6al
         V3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVt0Cs/EkFQWvxLM0O1bpWsAwJBtTOrzGwZIB+IV6Fk=;
        b=Adfpu/oFkWAoVixKkrZcddzImn95ZX2tVUnC1Acz2HSy0wT+hve9qXYxmsNihvLHzl
         0Gu3/RbyNGTlrGkE2hseRd9gDuZ2w/peP/1lumejnZ1edRpU3CgTzVJFiaGMCfST8A6Q
         gIfw77KdbNronV1FRqgNhHFOIG7ItAg6Kmd2zeSe3GOQ4fRcYCEISjWXJFG+JnMkrg8m
         hdPgWo0gBpL+sjao/Slyz2ZDus0gl4qTA2Bafz8Uj0yroctl8E3AybDRnJEFjJ2u5f3G
         3MzPn9KN1GAqH/XEpAeAlZXOnxqiLr6yYR7/Rzi2PJLE5YUwnPZHrVww8rMToU/aZXQh
         5PeQ==
X-Gm-Message-State: AMCzsaVGvDlbS1BjRiKBQWBEGnplWATFj6wSE18TGcjxecQSopXP9rPb
        0b9+e7+8UQK/+2s3glXzx8GOSRJP
X-Google-Smtp-Source: ABhQp+SxiCJNky5a1HfDUd2E4mfNKYDl9uvlNkfhuZTHseUBnfrBsK+HMA424TAfzvTGlzAuab6WbA==
X-Received: by 10.223.186.71 with SMTP id t7mr1017827wrg.75.1509125351960;
        Fri, 27 Oct 2017 10:29:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id c37sm16705362wra.73.2017.10.27.10.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 10:29:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell function in C
Date:   Fri, 27 Oct 2017 19:28:45 +0200
Message-Id: <20171027172845.15437-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc2.5.g97dd00bb7
In-Reply-To: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> +static void free_terms(struct bisect_terms *terms)
> +{
> +       if (!terms->term_good)
> +               free((void *) terms->term_good);
> +       if (!terms->term_bad)
> +               free((void *) terms->term_bad);
> +}

These look like no-ops. Remove `!` for correctness, or `if (...)` for
simplicity, since `free()` can handle NULL.

You leave the pointers dangling, but you're ok for now since this is the
last thing that happens in `cmd_bisect__helper()`. Your later patches
add more users, but they're also ok, since they immediately assign new
values.

In case you (and others) find it useful, the below is a patch I've been
sitting on for a while as part of a series to plug various memory-leaks.
`FREE_AND_NULL_CONST()` would be useful in precisely these situations.

-- >8 --
Subject: git-compat-util: add FREE_AND_NULL_CONST() wrapper

Commit 481df65 ("git-compat-util: add a FREE_AND_NULL() wrapper around
free(ptr); ptr = NULL", 2017-06-15) added `FREE_AND_NULL()`. One
advantage of this macro is that it reduces risk of copy-paste errors and
reviewer-fatigue, especially when cleaning up more than just a single
pointer.

However, `FREE_AND_NULL()` can not be used with a const-pointer:

  struct foo { const char *bar; }
  ...
  FREE_AND_NULL(baz.bar);

This causes the compiler to barf as `free()` is called: "error: passing
argument 1 of ‘free’ discards ‘const’ qualifier from pointer target
type". A naive attempt to remedy this might look like this:

  FREE_AND_NULL((void *)baz.bar);

Now the assignment is problematic: "error: lvalue required as left
operand of assignment".

Add a `FREE_AND_NULL_CONST()` wrapper macro which acts as
`FREE_AND_NULL()`, except it casts to `(void *)` when freeing. As a
demonstration, use this in two existing code paths that were identified
by some grepping. Future patches will use it to clean up struct-fields:

  FREE_AND_NULL_CONST(baz.bar);

This macro is a slightly bigger hammer than `FREE_AND_NULL` and has a
slightly larger potential for misuse. Document that `FREE_AND_NULL`
should be preferred.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 argv-array.c      | 3 +--
 git-compat-util.h | 8 ++++++++
 submodule.c       | 3 +--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/argv-array.c b/argv-array.c
index 5d370fa33..433a5997a 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -59,8 +59,7 @@ void argv_array_pop(struct argv_array *array)
 {
 	if (!array->argc)
 		return;
-	free((char *)array->argv[array->argc - 1]);
-	array->argv[array->argc - 1] = NULL;
+	FREE_AND_NULL_CONST(array->argv[array->argc - 1]);
 	array->argc--;
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d58..ca3dcbc58 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -815,6 +815,14 @@ extern FILE *fopen_or_warn(const char *path, const char *mode);
  */
 #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
 
+/*
+ * FREE_AND_NULL_CONST(ptr) is like FREE_AND_NULL(ptr) except it casts
+ * to (void *) when calling free. This is useful when handling, e.g., a
+ * `const char *`, but it can also be misused. Prefer FREE_AND_NULL, and
+ * use this only when you need to and it is safe to do so.
+ */
+#define FREE_AND_NULL_CONST(p) do { free((void *)(p)); (p) = NULL; } while (0)
+
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
 
diff --git a/submodule.c b/submodule.c
index 63e7094e1..7759f9050 100644
--- a/submodule.c
+++ b/submodule.c
@@ -364,8 +364,7 @@ int parse_submodule_update_strategy(const char *value,
 {
 	enum submodule_update_type type;
 
-	free((void*)dst->command);
-	dst->command = NULL;
+	FREE_AND_NULL_CONST(dst->command);
 
 	type = parse_submodule_update_type(value);
 	if (type == SM_UPDATE_UNSPECIFIED)
-- 
2.15.0.rc2.5.g97dd00bb7

