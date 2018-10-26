Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD82A1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 23:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeJ0HrB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:47:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38053 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0HrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:47:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id b14-v6so2810113wmj.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5SYLTwt3ilyMFBfk5d3JP7vP3ggm5zAmyJ5IivU50A=;
        b=FvjZdjEknp0q9VYUzDqVGOOdiNXvP1yR+qiFZlsC+bTl+QgK3NrIYT9IpmlqWiewCG
         tPkYBENOjFUIuh4o+i01QnJVnvcBq2Nq0bQ81ZRY4h9bzMSkW3Y16vkg9TopNm+aRGAU
         1q9XEtvpSU3FpI4w4ezuYNYLYSHxbl/9Ab63og0gdAOSIMGlrIV8Ntx/3WfryCqlth/T
         +X42VMEA87XFXieXMZDgMMAkPcqACYTD7YsjXpAWK/5K8PUHkUB988Go6PI+iBjYQGgj
         SYwGCQVGhtEejpruBKdUlAuefPEN/qWXqy9WCA6Y8wf22KO2H4nowNE1iBKjUc3FE8+U
         fXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5SYLTwt3ilyMFBfk5d3JP7vP3ggm5zAmyJ5IivU50A=;
        b=trnnCuuBi65UMwHlFxjMOZ1A7Jo0Z/prujRUSdPQLzN3R0/F0gp6jaep3JVWGsJmQH
         wx/ivnLOq0SVNellVvK9ROTigno3mmbn/vXbL2PssflQx5oWtwhxZ52gPhOWTncuxNGF
         kIy1a/XvYftz60VbDZw1H6cYS8IeCsGBCRDqqRfxgFhRLgsC8Z8+SHiSkRzn0YjA0/Xp
         l97mAVSO2+4PACKMX/kAmza2g0jfEJfi3aBB+LEzpgi4bdRRGRFZAqNr5ZGsXbZ5r/U8
         Oh5H0mXemNsEzXQoOONeo41GWtGPI+M3DCs11ypQSVCGvWLA6aDQNCwm+dG9CNyZukfX
         hl3g==
X-Gm-Message-State: AGRZ1gJp3OxQIh4Fr0aE1E29lAOPfp/khZyfYlgAsApmzpxeRXxZqmZg
        gxh1LTJGqmtJ3BzlrE7yHTaRzOTuWAU=
X-Google-Smtp-Source: AJdET5fqhbjpXiHbzGROwkeZcanSKOc+96NYV5ihICfzphrlyGFmqFwBk/c28Hz3l6vKnljs1f9TEA==
X-Received: by 2002:a1c:4c14:: with SMTP id z20-v6mr6570669wmf.89.1540595282654;
        Fri, 26 Oct 2018 16:08:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:08:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/8] push doc: document the DWYM behavior pushing to unqualified <dst>
Date:   Fri, 26 Oct 2018 23:07:41 +0000
Message-Id: <20181026230741.23321-9-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the DWYM behavior that kicks in when pushing to an
unqualified <dst> reference.

This behavior was added in f88395ac23 ("Renaming push.", 2005-08-03)
and f8aae12034 ("push: allow unqualified dest refspecs to DWIM",
2008-04-23), and somewhat documented in bb9fca80ce ("git-push: Update
description of refspecs and add examples", 2007-06-09), but has never
been fully documented.

The closest we got to having documented it was the description in the
commit message for f8aae12034, which I've borrowed from in writing
this documentation.

Let's also refer to this new documentation from the existing
documentation we had (added in bb9fca80ce).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-push.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a5fc54aeab..fb95c2e395 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -73,6 +73,30 @@ be omitted--such a push will update a ref that `<src>` normally updates
 without any `<refspec>` on the command line.  Otherwise, missing
 `:<dst>` means to update the same ref as the `<src>`.
 +
+If <dst> doesn't start with `refs/` (e.g. `refs/heads/master`) we will
+try to infer where in `refs/*` on the destination <repository> it
+belongs based on the the type of <src> being pushed and whether <dst>
+is ambiguous.
++
+--
+* If <dst> unambiguously refers to a ref on the <repository> remote,
+  then push to that ref.
+
+* If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
+  then prepend that to <dst>.
+
+* If <src> starts with refs/remotes/ check if that reference refers to
+  a commit or tag, then refs/heads/ or refs/tags/ to <dst> as
+  appropriate.
+
+* Other ambiguity resolutions might be added in the future, but for
+  now any other cases will error out with an error indicating what we
+  tried, and depending on the `advice.pushUnqualifiedRefname`
+  configuration (see linkgit:git-config[1]) suggest what refs/
+  namespace you may have wanted to push to.
+
+--
++
 The object referenced by <src> is used to update the <dst> reference
 on the remote side. Whether this is allowed depends on where in
 `refs/*` the <dst> reference lives as described in detail below, in
@@ -591,6 +615,9 @@ the ones in the examples below) can be configured as the default for
 	`refs/remotes/satellite/master`) in the `mothership` repository;
 	do the same for `dev` and `satellite/dev`.
 +
+See the section describing `<refspec>...` above for a discussion of
+the matching semantics.
++
 This is to emulate `git fetch` run on the `mothership` using `git
 push` that is run in the opposite direction in order to integrate
 the work done on `satellite`, and is often necessary when you can
-- 
2.19.1.759.g500967bb5e

