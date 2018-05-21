Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72E01F51C
	for <e@80x24.org>; Mon, 21 May 2018 00:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeEUAZF (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 20:25:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36405 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeEUAZE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 20:25:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id n10-v6so23638534wmc.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1c+X9Lzp/bj2wTDE+Kwd7JYyEcGSoWbq4KI6O6GTRfo=;
        b=KMiju0GfxguRo2LaHgmRWKIo++CqlZ25r+2pMTwTkiadP3qRevRLA7bcECdoSIgXi6
         Ua3yoXHA1YK45pFZj7ASSw2myPbREka/ysmLlHzsE0yEI6ZdY8WRzqJPO6bRzDpzE4l9
         B6aGRkegLHzl1ev4ydaBJ7lIj4eW2r+eZFHrLu+MtLCZBObwjLXe6QTRoVk/1yWvn6Tl
         2hnzBM+0zqEJScAmPhECj/OTMxdl4vcivvzFUbjIN9WOBLIgFQyAJhFs++MRaVVJcbrC
         TKZxowNl8pZv94JstWcJ4S4qEcZ0nzIhKALNbyhhgN3JyHLhcZtQdG9Dlfq7LePGwnAn
         F/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1c+X9Lzp/bj2wTDE+Kwd7JYyEcGSoWbq4KI6O6GTRfo=;
        b=KtHi4D1gbdaRFNqPaUq1+knb8cE4SakPhYNFOeYG82xrAHZVzuPvjEyK6mVRrlLo/h
         maOUwMGxLceE/49wa1UZNap7/ymudN7qj5udDS5fZiQAaYZ/raie6r8ogjGs814lxyNp
         /UCcyoZfImoH4b6XsI6ntnVAMQDvr6xg0Y1CHU+N8/o6CwSDdAbOVgf7z9rldB+Er3Wo
         xt3wyZNTlve7juwo513ii0lKnUYBJMqmBNQvbi0DgTDIwMyuM2FWWUdUOjNebCJTx1GO
         DD0Bq65PFtb1QjPm2mLlctU5L2Wxhtzn/O91uzhZecy7ZHZRppMGWrIDMoLEymZAJeXO
         PdeA==
X-Gm-Message-State: ALKqPwdaN4sFZGYhN6TowUpFK2OJpE1LnfzHY+9zClvDLNNKprWLwaNX
        w2U7yUADbiF3PWQ0eSWGqPY=
X-Google-Smtp-Source: AB8JxZo236e5c6UeBycJL29WK9e8ibyTfZIYJs/OgRD/7FZ8dLwa4L+s52Fa1YFcLx7/K4tln617vw==
X-Received: by 2002:a1c:1047:: with SMTP id 68-v6mr9181947wmq.132.1526862303033;
        Sun, 20 May 2018 17:25:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h10-v6sm20115773wrf.83.2018.05.20.17.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 17:25:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re*: [PATCH v4 3/4] string-list: provide `string_list_appendf()`
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
        <cover.1526810549.git.martin.agren@gmail.com>
        <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
        <CA+P7+xqPnuuQpp5e7fduLgaSd+JrTn95w=Da7q=iCXUgo0QHFA@mail.gmail.com>
        <xmqqvabh3mim.fsf_-_@gitster-ct.c.googlers.com>
Date:   Mon, 21 May 2018 09:25:01 +0900
In-Reply-To: <xmqqvabh3mim.fsf_-_@gitster-ct.c.googlers.com> (Junio
        C. Hamano's message of "Mon, 21 May 2018 09:01:05 +0900")
Message-ID: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I have a feeling that argv_array might be a better fit for the
> purpose of keeping track of to_free[] strings in the context of this
> series.  Moving away from string_list would allow us to sidestep the
> storage ownership issues the API has, and we do not need the .util
> thing string_list gives us (which is one distinct advantage string_list
> has over argv_array, if the application needs that feature).
>
> We would need to make _pushf() and friends return "const char *" if
> we go that route to make the resulting API more useful, though.

... and redoing the 4/4 patch using argv_array_pushf() makes the
result look like this, which does not look too bad.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack_trees_options: keep track of owned messages with argv_array

Instead of the string_list API, which is overly flexible and require
callers to be careful about memory ownership issues, use the
argv_array API that always takes ownership to redo the earlier
commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 16 ++++++----------
 unpack-trees.h |  4 ++--
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 86046b987a..b28f0c6e9d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "argv-array.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
@@ -103,11 +104,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char **msgs = opts->msgs;
 	const char *msg;
 
-	/*
-	 * As we add strings using `...appendf()`, this does not matter,
-	 * but when we clear the string list, we want them to be freed.
-	 */
-	opts->msgs_to_free.strdup_strings = 1;
+	argv_array_init(&opts->msgs_to_free);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -125,7 +122,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
+		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
@@ -146,7 +143,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =
-		string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
+		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -164,7 +161,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
-		string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
+		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
@@ -189,8 +186,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
-	string_list_clear(&opts->msgs_to_free, 0);
-	memset(opts->msgs, 0, sizeof(opts->msgs));
+	argv_array_clear(&opts->msgs_to_free);
 }
 
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
diff --git a/unpack-trees.h b/unpack-trees.h
index 5a84123a40..c2b434c606 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -2,7 +2,7 @@
 #define UNPACK_TREES_H
 
 #include "tree-walk.h"
-#include "string-list.h"
+#include "argv-array.h"
 
 #define MAX_UNPACK_TREES 8
 
@@ -62,7 +62,7 @@ struct unpack_trees_options {
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
-	struct string_list msgs_to_free;
+	struct argv_array msgs_to_free;
 	/*
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
-- 
2.17.0-582-gccdcbd54c4

