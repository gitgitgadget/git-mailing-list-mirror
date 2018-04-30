Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CF221841
	for <e@80x24.org>; Mon, 30 Apr 2018 09:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeD3JcM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:32:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35440 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeD3JcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:32:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id i14-v6so4223777wre.2
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWcm8tZl4XbPUlMs/e3/6geq1p72LwApqQT/kutTcoA=;
        b=sTQLPPHP/fO7RhgBKKYhuIXPQizQDN7uJIFbFnaiX+Zs82EAGxM1jJumjSuQ0xcH6R
         XYhvR5PGhoymvuHl7ZfYUcraZ1dpRs86f0JZ0OlXf9btkEzQ3Pcm1eGtmWPpfW+UxTzr
         J5BMy8IPZnzG1NrAA5dV5C/lFzxtjI8rTovYngrhOAjue0NEuVMMb/8Zr93FYKtoUWf1
         VemzhTEJMf7OzyXS1Sy6Cq6AvqSaGnt8TtlwDujLwFK8o/topTF3tB0UmiJRnBmFbJjM
         YzmJAZdnjt2LAA11e0Rle4lIEDi5vKHZugjvvMA2dSo+IdsIrJJIMKXc7zQ6J3b7IY3p
         5DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWcm8tZl4XbPUlMs/e3/6geq1p72LwApqQT/kutTcoA=;
        b=i0wD7gxPtR08JBdDvGcO6iyT32gLa8Li75jT4hC6iZ+8PAc2Ww4KEA5AnDOII3CtVf
         +OX9SSA8F7+znUJLGwxsKAPASPw9YvjR6a9zfuDaE15aAwni8S0bN8NklkG6PLypUrTy
         vPC5Pj+C514Ni7VOVuxOCaliNqN7RDorKDeFzZ7b12wGEPSkOXF6xaSyw+rS5zWuqVne
         1LVFPvSs0FW7FpgWqqQxd6sFifoRC8vVdCQg9jAS1hzxulSGLzmBD5pNS/kamptJFhPW
         m+TSQNwUWezQ7a90Q9nRpHya1bsIllGK2mqi+gLYg5LNCdWH1dNyLH+eQrLN+1PKSr76
         COoA==
X-Gm-Message-State: ALQs6tArvCjQTMJi3w078Cb2YYGvn3Fi8n60e1WrbUHi2e5WsME6kmQS
        AgNaJyk/WSniSrXMx9mXe18=
X-Google-Smtp-Source: AB8JxZoYB6tIYbe4dsESZrkgemGsWHOmPsWoHm03B4vhb9cxPfoau9p+QaEqZHZxWA7RktUhZbS34w==
X-Received: by 2002:adf:aa04:: with SMTP id p4-v6mr7606504wrd.226.1525080729656;
        Mon, 30 Apr 2018 02:32:09 -0700 (PDT)
Received: from localhost.localdomain (x590cef10.dyn.telefonica.de. [89.12.239.16])
        by smtp.gmail.com with ESMTPSA id a79sm7602981wme.48.2018.04.30.02.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Apr 2018 02:32:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] coccinelle: avoid wrong transformation suggestions from commit.cocci
Date:   Mon, 30 Apr 2018 11:31:53 +0200
Message-Id: <20180430093153.13040-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.551.g86756ed296
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The semantic patch 'contrib/coccinelle/commit.cocci' added in
2e27bd7731 (treewide: replace maybe_tree with accessor methods,
2018-04-06) is supposed to "ensure that all references to the
'maybe_tree' member of struct commit are either mutations or accesses
through get_commit_tree()".  So get_commit_tree() clearly must be able
to directly access the 'maybe_tree' member, and 'commit.cocci' has a
bit of a roundabout workaround to ensure that get_commit_tree()'s
direct access in its return statement is not transformed: after all
references to 'maybe_tree' have been transformed to a call to
get_commit_tree(), including the reference in get_commit_tree()
itself, the last rule transforms back a 'return get_commit_tree()'
statement, back then found only in get_commit_tree() itself, to a
direct access.

Unfortunately, already the very next commit shows that this workaround
is insufficient: 7b8a21dba1 (commit-graph: lazy-load trees for
commits, 2018-04-06) extends get_commit_tree() with a condition
directly accessing the 'maybe_tree' member, and Coccinelle with
'commit.cocci' promptly detects it and suggests a transformation to
avoid it.  This transformation is clearly wrong, because calling
get_commit_tree() to access 'maybe_tree' _in_ get_commit_tree() would
obviously lead to recursion.  Furthermore, the same commit added
another, more specialized getter function get_commit_tree_in_graph(),
whose legitimate direct access to 'maybe_tree' triggers a similar
wrong transformation suggestion.

Exclude both of these getter functions from the general rule in
'commit.cocci' that matches their direct accesses to 'maybe_tree'.
Also exclude load_tree_for_commit(), which, as static helper funcion
of get_commit_tree_in_graph(), has legitimate direct access to
'maybe_tree' as well.

The last rule transforming back 'return get_commit_tree()' statements
to direct accesses thus became unnecessary, remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/coccinelle/commit.cocci | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index ac38525941..a7e9215ffc 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -10,11 +10,15 @@ expression c;
 - c->maybe_tree->object.oid.hash
 + get_commit_tree_oid(c)->hash
 
+// These excluded functions must access c->maybe_tree direcly.
 @@
+identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph|load_tree_for_commit)$";
 expression c;
 @@
+  f(...) {...
 - c->maybe_tree
 + get_commit_tree(c)
+  ...}
 
 @@
 expression c;
@@ -22,9 +26,3 @@ expression s;
 @@
 - get_commit_tree(c) = s
 + c->maybe_tree = s
-
-@@
-expression c;
-@@
-- return get_commit_tree(c);
-+ return c->maybe_tree;
-- 
2.17.0.551.g86756ed296

