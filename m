Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC451F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeGRPyC (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:02 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34443 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id k19-v6so2367069pfi.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=VPTzO6wo4f3XbtG/ZAw7ZOGVtRL8tan71HC0Ymj4qKs=;
        b=VAZC37MAL2rhvrn1EbfpcVvcdC+kU7ex61GRnTwxIGLyitG7ySQ55I8SIOzK93Iwc5
         hyMOdwT0eHAb4lM3OiUc/1jLk6BItueYz/BK9m/w0cQaeMIajy+Wf2BooWB2E6bGc2CW
         FGI+jCtsBa0JhjcAnosFNn8jdtmgLtCbg/YXXoD1sUPnYgleTSuOhmnGBkxD3/fcKtn2
         Vc8RLufbuqu4ZcC4ANIyC7V9VqxeprLyEnKg+qHmZ/N/cO/UYV4ts8Xn32qDhuyS98Ln
         xAR86bZ3tbZu1Yvxk8jiraj0U799bf+1QnKbEl/mOQ4Xq8XZg1YVpsR/6uF1Y0tP4FIe
         bFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=VPTzO6wo4f3XbtG/ZAw7ZOGVtRL8tan71HC0Ymj4qKs=;
        b=fOPXPyuizuxivpWGURcYyPJSCLMKqPT08GKTbdVYwzasFy66sgKgtIbGmk1eAa0ri4
         2yP6sb1cdCXV/1rbRHN3ThPXwR33FIH7jG2EEioo1xssOG0vPEqcMC0Q+964DtPlZ22c
         T+2/GiFRE+Ubsq7HZVGtpdW8uxspQK7lurEat/XOa4EhvAS/rODXpqW0Gr7QFuZQzn/J
         nnQ/aYNBC8dU/hzfxeWNej7XDPorGELhyOsehVoAFHsD38AzbTqDIKkg7xulgwi7i0pT
         H9S7LanglcMdOPiy2BePjTH50xYqm+LXGs6rrmt0kx7P5CTBoAtkRjLadBTADL/nA/d6
         SMUA==
X-Gm-Message-State: AOUpUlEkX+S77p5hoFxMCeYEBHcgS7+GM7GpbXGpY5oCBIBr9PbEkDAr
        xoLkpRSgUk6TrZcreG8Nf4ABcQ==
X-Google-Smtp-Source: AAOMgpeoJB2SeYXY/nkyO6sac0NTkBFexw92wngg0admSXKuGojXfhGl3+vCzu1vosyhU0gLgUJIuQ==
X-Received: by 2002:a63:fa48:: with SMTP id g8-v6mr6238103pgk.224.1531926939602;
        Wed, 18 Jul 2018 08:15:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id a62-v6sm10830613pfc.14.2018.07.18.08.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:38 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:38 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:26 GMT
Message-Id: <5e90d36f8482e03df842d483bfe6f237f0247166.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/8] commit-graph: update design document
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As it exists right now, the commit-graph feature may provide
inconsistent results when combined with commit grafts, replace objects,
and shallow clones. Update the design document to discuss why these
interactions are difficult to reconcile and how we will avoid errors by
preventing updates to and reads from the commit-graph file when these
other features exist.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index c664acbd7..18948f11a 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -112,12 +112,24 @@ Design Details
 - The file format includes parameters for the object ID hash function,
   so a future change of hash algorithm does not require a change in format.
 
+- Commit grafts and replace objects can change the shape of the commit
+  history. These can also be enabled/disabled on the fly using
+  `--no-replace-objects`. This leads to difficultly storing both possible
+  interpretations of a commit id, especially when computing generation
+  numbers. The commit-graph will not be read or written when
+  replace-objects or grafts are present.
+
+- Shallow clones create grafts of commits by dropping their parents. This
+  leads the commit-graph to think those commits have generation number 1.
+  If and when those commits are made unshallow, those generation numbers
+  become invalid. Since shallow clones are intended to restrict the commit
+  history to a very small set of commits, the commit-graph feature is less
+  helpful for these clones, anyway. The commit-graph will not be read or
+  written when shallow commits are present.
+
 Future Work
 -----------
 
-- The commit graph feature currently does not honor commit grafts. This can
-  be remedied by duplicating or refactoring the current graft logic.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-ordered
-- 
gitgitgadget

