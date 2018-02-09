Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC861F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeBIUdH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:33:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38333 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeBIUc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:58 -0500
Received: by mail-wm0-f65.google.com with SMTP id 141so18409026wme.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aCvfy4yLzEwOf5smv8oQD36d5HPRmDxP2NJcqdG7iHw=;
        b=BWuFy+3mkWH7aA5sn3CxY5uWEL6Rz7dzRvCPaKqS931yGTSwktA4ud7qlrVg/I/nWV
         ux9OjdAm12vBk0xFOpM9f0yYmr2B8NR8dP0Zn1X2GaNR9vfwssYQ1vwKX1UOcU69r4E2
         P70Vb7HEWa0AkpDk8tixGW1p+NS7Gkw/1StbPWSgklWgTaYNMrhR1zpl8NtbctQnK8xF
         JOQwa54gySaEScili1qu004QHgQNoJc8/rSiKyF38OsOya33MCoAxNqkR4ge1yht/9m2
         xehQu1nEvPpBRdTwpfBX0mi5VC3JmX+JpR+29ufCf4KwjznJfJ50ANBVgjn7NKDH4pRv
         QvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aCvfy4yLzEwOf5smv8oQD36d5HPRmDxP2NJcqdG7iHw=;
        b=ex777aUVmLHH+9/JWuDTRhh5WImzjiSt3s0L+QcPeasG0cYFK/SUIRknZJh80dto51
         Fc46ws+PpDDfUoDgQTYX2dB+nFeteb/0/DzlQmWQCRS6pBteadDw/U7W+Np7u/bhCFYm
         ejrwdum5W12344/Nx/QKH2NhJtQKGU7hGKfCskb3r2kyFiFEbZdw+5xZwvgar2OdcQLk
         Y2VC06Va39J4ByBKDMW8NrYyrLn/NLqJqhiYxoAWHQnMnYv3ioCX2NjW6JbZ+yf68Ojo
         ng8Emdl00wqnViERcm73Cpzf5U+3R+GL41yWmaeC42cWuQIrItDPElRBZSCfh9yk0L6M
         FeEA==
X-Gm-Message-State: APf1xPCO8JAzmAJO7GP9L+OleQjCAYeEP2il98p/0s7l2d5tTI9wNMjR
        +12ftldCeuX5eb6XwWFRpSbEbIoI
X-Google-Smtp-Source: AH8x226FhhpVjIZYOiueucu+PtEMLriYAQuoCRQ4OeXwdGte3UN0MJKY4ehvPaIzFVbgv5NXaBsEOw==
X-Received: by 10.28.179.9 with SMTP id c9mr2686973wmf.99.1518208376303;
        Fri, 09 Feb 2018 12:32:56 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/17] git fetch doc: add a new section to explain the ins & outs of pruning
Date:   Fri,  9 Feb 2018 20:32:11 +0000
Message-Id: <20180209203216.11560-13-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
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
index b153aefa68..e94bcfb8c3 100644
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
+These remote-tracking references can be deleted as a one-off with
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
+remember to run that, set `fetch.prune` globally, or
+`remote.<name>.prune` per-remote in the config. See
+linkgit:git-config[1].
+
+Here's where things get tricky and more specific. The pruning feature
+doesn't actually care about branches, instead it'll prune local <->
+remote-references as a function of the refspec of the remote (see
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

