Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10041F406
	for <e@80x24.org>; Sun, 13 May 2018 02:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEMCYW (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:24:22 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36840 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeEMCYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 22:24:21 -0400
Received: by mail-ua0-f193.google.com with SMTP id b25-v6so6129699uak.3
        for <git@vger.kernel.org>; Sat, 12 May 2018 19:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OLS7UF8b/+GDjrrPTOkEYv+uBTsa5GmpL/4wigcwFvs=;
        b=b+HkPFu/ZWARdpb0IKpCkpqc+C7HR2pQ2B5g/OYxJXlAG2Oso9PtaAxpEH3lX1SRzI
         nW45s76Ewdv7ge71JjW0h4S9C4XR91qyr7NG9DDQQRiMycjBpngUZH0cqmJL/6ZUUP52
         /UyxTbU2sUzvM41qSSovWZPcs2mSg6mKkenDVf5bzAeShe+LEA7oOgaUf6S+K9UDuGgZ
         rYVq7X+U+QMncVyIkG1R9Epjw6GzyUnfea5i0gXmckoWKvdUZbIx0B4wud+9kHNsGqyU
         u272dUTXWxNvXFOEZTHq8zPJwsJj6dkQhtaSIJxbJOAntjmmtJ9ac8c9OS63y7RoT3yL
         BtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OLS7UF8b/+GDjrrPTOkEYv+uBTsa5GmpL/4wigcwFvs=;
        b=dnYEAh2DSpXorEMRomLs1gN0xKOsUXnSSNGkCVbkMeFEmdjWH5ncaJvlnGLH3Rbf4P
         zfwH9yAvMGJw4qbz3ZQQ8STTp1CH///xqGmNzX1gLC5qvsPezQMGL8JbYHGccm+VqudJ
         ALD59tndQ1brjZ4xpXsSbFqt+yUGqHjbwYne2j7xm20Eb0Z5aNmPB1JlpxETK50Q6Vc4
         OIGetvhJy0OXV2e7SellV1z6q3N9s64qRV9+XNe5i4QyPYkEjKuo8g/BVcrrnjr0irus
         1i8ra9g0psN2jLXklt+LxMj/rsUYIIRxxk5DbzGMKs9lNZ5be4eysFOdQ3nBomAGwzzN
         BPpQ==
X-Gm-Message-State: ALKqPwdj/GjN/si4QgxS0IutLSbbwsj0a9uevNRiKaRP7NMgvqfdPXV2
        rLKiBinsMSymqbJB05ljutvf44o=
X-Google-Smtp-Source: AB8JxZrqdTpKagdMTSHV6auxVLj5fm6ev9x4WUBSv9R3D2XuJOD+STDUf1J8NIuBp0Izq7MU/n0emA==
X-Received: by 2002:ab0:d88:: with SMTP id i8-v6mr7153057uak.67.1526178260007;
        Sat, 12 May 2018 19:24:20 -0700 (PDT)
Received: from localhost.localdomain (ip177-101-15-186.ct.co.cr. [186.15.101.177])
        by smtp.gmail.com with ESMTPSA id o24-v6sm1541308vki.33.2018.05.12.19.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 May 2018 19:24:19 -0700 (PDT)
From:   Dannier Castro L <danniercl@gmail.com>
To:     git@vger.kernel.org
Cc:     Dannier Castro L <danniercl@gmail.com>, gitster@pobox.com,
        Matthieu.Moy@imag.fr, jrnieder@gmail.com, bmwill@google.com
Subject: [PATCH 3/3] doc: update doc for strict usage of -- checkout
Date:   Sat, 12 May 2018 20:23:34 -0600
Message-Id: <1526178214-30956-3-git-send-email-danniercl@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flag '--' must always be before any file path when <checkout>
command is used.

The main documentation about the usage of <checkout> command is
updated to include the strict usage of the flag '--' so that the
user can specify file names over branch names.

Signed-off-by: Dannier Castro L <danniercl@gmail.com>:
---
 Documentation/git-checkout.txt | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca5fc9c..8360a98 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,9 +12,9 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [<tree-ish>] [--] <pathspec>...
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] -- <paths>...
+'git checkout' [<tree-ish>] -- <pathspec>...
+'git checkout' (-p|--patch) [<tree-ish>] [-- <paths>...]
 
 DESCRIPTION
 -----------
@@ -79,7 +79,7 @@ be used to detach HEAD at the tip of the branch (`git checkout
 +
 Omitting <branch> detaches HEAD at the tip of the current branch.
 
-'git checkout' [<tree-ish>] [--] <pathspec>...::
+'git checkout' [<tree-ish>] -- <pathspec>...::
 
 	Overwrite paths in the working tree by replacing with the
 	contents in the index or in the <tree-ish> (most often a
@@ -95,7 +95,7 @@ specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
+'git checkout' (-p|--patch) [<tree-ish>] [-- <pathspec>...]::
 	This is similar to the "check out paths to the working tree
 	from either the index or from a tree-ish" mode described
 	above, but lets you use the interactive interface to show
@@ -453,7 +453,7 @@ mistake, and gets it back from the index.
 $ git checkout master             <1>
 $ git checkout master~2 Makefile  <2>
 $ rm -f hello.c
-$ git checkout hello.c            <3>
+$ git checkout -- hello.c         <3>
 ------------
 +
 <1> switch branch
@@ -471,14 +471,6 @@ Note the quotes around `*.c`.  The file `hello.c` will also be
 checked out, even though it is no longer in the working tree,
 because the file globbing is used to match entries in the index
 (not in the working tree by the shell).
-+
-If you have an unfortunate branch that is named `hello.c`, this
-step would be confused as an instruction to switch to that branch.
-You should instead write:
-+
-------------
-$ git checkout -- hello.c
-------------
 
 . After working in the wrong branch, switching to the correct
 branch would be done using:
-- 
2.7.4

