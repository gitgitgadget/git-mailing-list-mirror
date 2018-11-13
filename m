Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681631F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbeKNFwr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56139 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbeKNFwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id i73-v6so7928984wmd.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nmdYKj5JRhefeg7ptWM/GYUDy2k/RGB+OV75nbO2PE=;
        b=q1uukqAy7qqNLe0mA2uroGHFCxoQA6S9Fuoe6nXEvuu3ZQopVuZpB3Sn7HucDsspNp
         JXoKHryB/cdDSHgx9N2W7ZoqnVSmIIQwcprBk6gn9zo3YcDOfwEiVpfhw+Vk/d84zzWG
         aQHYbJm9VIuWtxmUcFuew1wU5CposbIR5GR1v8yHb4fik7VLG17+91q1MOj88orpZOqV
         JzEOJock8CHAMYbHJOuvfGwJjKGuu3VpAje4HX2pIl0a+qhUKcZujABrMbQ0oF2MyqCw
         pzTsovpTF3LQ3MTDZmrZ+zQosUNAD0k1u2CaBcVyiymu6Dm19Ea6sVD8Jy9Jcb+9N9PY
         sHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nmdYKj5JRhefeg7ptWM/GYUDy2k/RGB+OV75nbO2PE=;
        b=adz7Wpx/xhhUq5WUsgZ3GI4Kr0v9eMXeOUm44OLj7qsdCCy2G94lcAGf/hjiVHRe0u
         s5XuWQXOPyPb35VqL2vTK9OED4GvqL3MUOff6iUpHMtwMZlMuWhop4IC+QzSXPl2nVSf
         GSYzKJeu0hq6w8/a0FAnWw0mTeTD3mqE+XxindAJRMlBzTT2Pos8JzVGrQ15IU0dsIJf
         +8Sk93JQGp+IF+ov0cP+0Scum39OJ36R5eIGVyKs/4k1Ujkf337n1YfkMlxrBnn85g+z
         zUtIsIQM21MS6C2+DK2oszGsVsvfQPOIQhsJWdGlkQb4Mopj8p5rRGmijU6nE4EEIBev
         Wz9w==
X-Gm-Message-State: AGRZ1gIy6JdyNu13uphRvKBN+g00Z3w7ywXfiW/AXxkVTNjGtRI14z1/
        i8YSXGNdJ+0tbsEga+4Cy9tCyMCdXE4=
X-Google-Smtp-Source: AJdET5eZ3NFZ5aGkYmN5RGf0D09BlmfNM+zctLgomSXsUMhp9DQi7pHfNBseDlB1ZYxFigBf09IeEA==
X-Received: by 2002:a1c:6a01:: with SMTP id f1-v6mr4256560wmc.85.1542138786026;
        Tue, 13 Nov 2018 11:53:06 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:53:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/7] push doc: document the DWYM behavior pushing to unqualified <dst>
Date:   Tue, 13 Nov 2018 19:52:45 +0000
Message-Id: <20181113195245.14296-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
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
 Documentation/git-push.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a5fc54aeab..6a8a0d958b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -73,6 +73,26 @@ be omitted--such a push will update a ref that `<src>` normally updates
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
@@ -591,6 +611,9 @@ the ones in the examples below) can be configured as the default for
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
2.19.1.1182.g4ecb1133ce

