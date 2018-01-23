Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A851F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeAWWOE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41806 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeAWWOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:14:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id f71so4764884wmf.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9a+xR48CLwWWdUXXjVidyHKelZq7aRXwohmcNxo4CtU=;
        b=dm4U45GkHzt5wCmqIDDfPhjdVlzvmgaqOdYxwob/Ndj4iBk2RaRw1ghsVgaYo1TxO8
         b2OzMLyX53CLcLO8t3CLnPBdGntJ2FR9+f9ZgW3OtPITartIToa6JDX3aasdCBIgjusV
         ZO9Snt7U6/THVSz2yXX0HlxAumkpiDJjrjKaiEc/We+gHJSDWUfAZdMUCNpFpOmTK5St
         scoAKjVnjAOTBiKmi7k2o4PXPugGaVEkN4X2H1g/pTS5mU/L8njAk/hpLwzcdm+LycxW
         ZfzLrT5bAf49W2h/dlp+omxlRoV0e/ahA5ww9sFgVDMliuF9ldchbE45+KoMsFA6FQMM
         2RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9a+xR48CLwWWdUXXjVidyHKelZq7aRXwohmcNxo4CtU=;
        b=ZLBSh8yK1BZtNjfB1dRWQG9+3E6vkYBZCRM/Noj0zbi/vFgralLeYxqsfR8XyKd0ha
         ljl/Fd1EttPuXniuorEpKXfQRIS3hHrZnVzKr3pjJtMqUwBm8xRgvJZ9CFVIQCJO5oVL
         q6Fv1f5mei+2Crwx/f9d6IoR98oUPnxrC58QXr5cd5DU/17kQQ3l1SnLsVBKA/Fva35b
         BQJWmgA2QUoDx7sZXm6qDi6stAXCXUGubJ8cuv7T5XMwYjluncxAawk8XsZ5fzyiA/Ji
         Nf+zCSB1PBt2GDqMUClPn/7F7Z/TtyUXBPg/Qz50E2NOYfRlq2QhFL6dlKZz8PGafIzq
         MRlQ==
X-Gm-Message-State: AKwxyteU2FCb3nCMFuRS99xxaqkksYxjtJOV6sRVMbsBwfU6nQ/voGZG
        vqDQlXi1UVjqjAfjKgT/AZ5x8wGG
X-Google-Smtp-Source: AH8x2276boaJGfFnOoExHYK2AQls+SlM62FYh6yIOEN0VRqoN/m6X42YbHdEqvBM8Br/5sLLKAFWVg==
X-Received: by 10.80.165.21 with SMTP id y21mr21997544edb.148.1516745639395;
        Tue, 23 Jan 2018 14:13:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/11] git fetch doc: add a new section to explain the ins & outs of pruning
Date:   Tue, 23 Jan 2018 22:13:22 +0000
Message-Id: <20180123221326.28495-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new section to canonically explain how remote reference pruning
works, and how users should be careful about using it in conjunction
with tag refspecs in particular.

A subsequent commit will update the git-remote documentation to refer
to this section, and details the motivation for writing this in the
first place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fetch.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index b153aefa68..18fac0da2e 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -99,6 +99,55 @@ The latter use of the `remote.<repository>.fetch` values can be
 overridden by giving the `--refmap=<refspec>` parameter(s) on the
 command line.
 
+PRUNING
+-------
+
+Git has a default disposition of keeping data unless it's explicitly
+thrown away; this extends to holding onto local references to branches
+on remotes that have themselves deleted those branches.
+
+If left to accumulate, these stale references might make performance
+worse on big and busy repos that have a lot of branch churn, and
+e.g. make the output of commands like `git branch -a --contains
+<commit>` needlessly verbose, as well as impacting anything else
+that'll work with the complete set of known references.
+
+These remote tracking references can be deleted as a one-off with
+either of:
+
+------------------------------------------------
+# While fetching
+$ git fetch --prune <name>
+
+# Only prune, don't fetch
+$ git remote prune <name>
+------------------------------------------------
+
+To prune references as part of your normal workflow without needing to
+remember to run that set `fetch.prune` globally, or
+`remote.<name>.prune` per-remote in the config. See
+linkgit:git-config[1].
+
+Here's where things get tricky and more specific. The pruning feature
+doesn't actually care about branches, instead it'll prune local <->
+remote references as a function of the refspec of the remote (see
+`<refspec>` and <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> above).
+
+Therefore if the refspec for the remote includes
+e.g. `refs/tags/*:refs/tags/*`, or you manually run e.g. `git fetch
+--prune <name> "refs/tags/*:refs/tags/*"` it won't be stale remote
+tracking branches that are deleted, but any local tag that doesn't
+exist on the remote.
+
+This might not be what you expect, i.e. you want to prune remote
+`<name>`, but also explicitly fetch tags from it, so when you fetch
+from it you delete all your local tags, most of which may not have
+come from the `<name>` remote in the first place.
+
+So be careful when using this with a refspec like
+`refs/tags/*:refs/tags/*`, or any other refspec which might map
+references from multiple remotes to the same local namespace.
+
 OUTPUT
 ------
 
-- 
2.15.1.424.g9478a66081

