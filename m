Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1C91F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756792AbeAUADo (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:44 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33044 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeAUADj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:39 -0500
Received: by mail-wr0-f196.google.com with SMTP id p6so4840834wrd.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9a+xR48CLwWWdUXXjVidyHKelZq7aRXwohmcNxo4CtU=;
        b=ITTt/LOwMMXKgWx+KytsF0Mz/7K357gfFnQ6yvM8ht1Ys71NOcjwOmqgS4eEccoede
         ruCHuPvn609NzKShFwND6SIWVz7iCd+hLHJ1UfwxgCXnPjy4n/DnAfMRnG6scXljAfwV
         mJK3QFemyfH6yjukozZ7zlZBCCA8Bq1ysy/JRRYNydcmmTqG5o91l3sJeHum3SZo9G4v
         Q20kT86a8ihd1AMiD7jdFzZdC5OLBLxwKOLEfYEnBTSAZhX91pDoNDAQ2v7r3702va35
         NdPIIVHBL5RfikZbQmFrRrocEAshNrJZD6JAWZr4V6bLOOa/jhD+ZnjvYPCEU+G3oFIL
         QAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9a+xR48CLwWWdUXXjVidyHKelZq7aRXwohmcNxo4CtU=;
        b=bSF5uh3kwUkGVCsChn2Qh9tkx+lkT4TjnRwpQgQLi9iy6792b2h4YPR2GcDR1yDFfv
         8KQoJ9d7DjB6xdHUKajlrqTC9zZQoHTsd53+hwXwg0C7GF+shrFKCtV7xnmF00q6+6dC
         QKr/xkl2eXavfJEuhR+VVqhnKTMeV0zaiae/phAftSrhtvyt1p6t9NOTfJ0QTgAALoD5
         UHAhiv3ptVk8uAf8vzuG3rgSooFdVRZr8rRqbdp9yhYKMb10f0l94jypeCuecOQLYS4m
         IDQSGbQ1oND7iRtSGZRA7uQSRePlv37o9RTtgtWh0FP85cHQnxS/Vcta1bmPz23Ec7iE
         oRnw==
X-Gm-Message-State: AKwxytcU+Y4HXy/loUaAwkVtQiQe9i7czw0iWhcxmOcAJ+yxsygQKANh
        nM1Y3Mip/NkWhG6om1usu61ZV8uO
X-Google-Smtp-Source: AH8x224Ua8gc2dWCcyfVvs65nmSKI+rIhmP04BuoZ67SwfthX7b5Vlfv1oVWbdNRKF2QU/S0wUU5FQ==
X-Received: by 10.223.153.52 with SMTP id x49mr2551391wrb.195.1516493016750;
        Sat, 20 Jan 2018 16:03:36 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:35 -0800 (PST)
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
Subject: [PATCH v2 06/12] git fetch doc: add a new section to explain the ins & outs of pruning
Date:   Sun, 21 Jan 2018 00:02:58 +0000
Message-Id: <20180121000304.32323-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
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

