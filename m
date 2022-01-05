Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D281C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbiAEUCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiAEUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24AC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h23so510913wrc.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JIocY6VcxAOywLFzw0OnVpMN7lpFCNvRMkP6pq4asjc=;
        b=Qd8sGl5XzC+Mi3kQ+eR0WT7wwgFYp+2YQhBHLRvFOC1ob+KmT4PhdrDXUX2kycYmPD
         3oUAMkAVHLBf0NmT5wfWWG2ZzMWCynC81Z1hXM1qkaA0A91g6ugjPNaiFx75vf4L4hiv
         dOfrbUPbZ7m47zhJKkq7pE5QA+Dc2JpgYn+gejnp16Rs9CenqPGEMA2+AK0ZbtP9z1ex
         +Ke2zH1w4Dql2rtl+Fyr0cxhAEbJtUHQ7zKrLMF1AD9bB1bLy3FWzZFS9EdM4Ig1M0QY
         5naN9kVMUluM7sacce6kR/iZpWUTuK7zWC9R33RwIn9O+cxxPrQ7aXaSLQqdY3XKoAow
         dtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JIocY6VcxAOywLFzw0OnVpMN7lpFCNvRMkP6pq4asjc=;
        b=5/E2j2nzbLvsFM2k/agwjztQFpQJ74SMYFkrbfy1/Oot6avwcfvkc3XEZ7GcSOf8dK
         t6r3BbqYU2cVbry0AS98jUCP13ajdeFjmk0ywpcJOGzvxXvvd+WoXnm8rIVahtoG9ueW
         1A+iqB9SDya6yZRP4HXSfEkbh0R7VsoNC3cxFCI6AMb1oTt94/11IGZK15F689wGfqUC
         HzkgqEQXYzf/9hcTlIi3hnE/rbKPe8SYUoyVjTl+QpWY4VPCm+rWza4svIp/wOOor9LO
         JKiWcYDmmXoKxngVdb9eGP/yLPri+VJJEaxyO2wqmLaZhoLsUiAvWl+HYt46nLzjif1q
         2P1g==
X-Gm-Message-State: AOAM531PGTxnCEZ9/VW7rORdiLKeBfaBJquwYxzPMNpNrOPzSVz/l0tF
        G7Y+D1WmakzFMGjX7JGr/LRfHzrW7nU=
X-Google-Smtp-Source: ABdhPJzq5i8JuvLBAeOtKpTsQxU8VgBy5cx39Ef2Wy1XFDnzrH763SK3ESmfAf7tDuceDVydxTtdZw==
X-Received: by 2002:a5d:6312:: with SMTP id i18mr46642937wru.475.1641412951303;
        Wed, 05 Jan 2022 12:02:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm981085wmj.26.2022.01.05.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:30 -0800 (PST)
Message-Id: <08f5471aeaa9c14a340f5876a161144da0a34dc9.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:20 +0000
Subject: [PATCH v5 07/11] i18n: factorize "no directory given for --foo"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 git.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 7edafd8ecff..edda922ce6d 100644
--- a/git.c
+++ b/git.c
@@ -185,7 +185,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --git-dir\n" ));
+				fprintf(stderr, _("no directory given for '%s' option\n" ), "--git-dir");
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -213,7 +213,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --work-tree\n" ));
+				fprintf(stderr, _("no directory given for '%s' option\n" ), "--work-tree");
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -297,7 +297,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for -C\n" ));
+				fprintf(stderr, _("no directory given for '%s' option\n" ), "-C");
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
-- 
gitgitgadget

