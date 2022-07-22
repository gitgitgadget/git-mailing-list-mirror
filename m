Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB81C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGVFPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVFPs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F32317D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l15so942751wro.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gN0tZ+ael5Qgw/uE37c3BdgOrXL44tqLZY6nsQFMh3w=;
        b=etn8rhLIowTO8pggvh44AmP6DBiPUv3bYuKQay2eKEZRUWLeeARSd1gpcW+iwkqSeg
         qQGki/0oeHzf7bKORoHZhwhZWT5G8F3dyWOp7aavKb2AS8acMCceUxI33MBuq2Q3knjy
         9TtsFV7vu1h6e6TzlErVjbPVpThCUpDIMnqEqOb75Odsa09rS1317B33NlEceg2Z+rB9
         JpN5SP/q9AAfL+57w1wPjT0KDE6YXfCFOwuBNbWqgDZ5/2phrHWeeAQKoDay9C7nbmZt
         e6+WgQpIbXSfxskDmarn/65aRBY/Hph+4qYBVpSOrVbdtMHzn20+eiSOuUapqfcl44kY
         Lfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gN0tZ+ael5Qgw/uE37c3BdgOrXL44tqLZY6nsQFMh3w=;
        b=rmE57TwkPMI4KZH0/qtQCILGklPPr2bV+4JD0/Ts5Fn26vF3913/E4hWQRiDw0ZIEq
         7hgBSRuMx+EMl3UtytCLrJuNSWSRXZCYb9w4wSiB1Gm6pBp4io/jljtMAOvWk6m8XHAX
         JlUp1YwWQROfX2TCUe53Yfjabv1Xrz15t/zSkhqh9iKE6piqOSDsI/+L8Jvf905amhUk
         IFTYESfl5uASai8Acydiascnj1ynYWzrjFEqrm0oflJsOJlQ43I9bXFEw5giC7lba0Mu
         rAR4Ne4dHko5Yrg3Ro0xbyylX9bMPVO5poiOefEcaxVmrwySQEF/hfLGAiOGG6VOFeO/
         f0pg==
X-Gm-Message-State: AJIora/3CWVTvYOKEML6C+ZKOXCjVOlkXH1QggpNrwV0CouhdJQRsaFg
        EpVmgkb89c1XF5Rr36QJxdKNtz+ZfPc=
X-Google-Smtp-Source: AGRyM1vxduFFEkGommBklcJXrceVSSDrLmHOt0NT7YXc6G61SHaFWTJgxJu9ti3BhbvGvFJN+p8wlQ==
X-Received: by 2002:a05:6000:49:b0:21d:78fe:34b2 with SMTP id k9-20020a056000004900b0021d78fe34b2mr1066687wrx.200.1658466945299;
        Thu, 21 Jul 2022 22:15:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q26-20020a056000137a00b0021e0147da47sm3486124wrz.96.2022.07.21.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:44 -0700 (PDT)
Message-Id: <bd36d16c8d93176bac12acaf90f654a0acb16cd6.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:36 +0000
Subject: [PATCH v4 1/7] merge-ort-wrappers: make printed message match the one
 from recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the index does not match HEAD, the merge strategies are responsible
to detect that condition and abort.  The merge-ort-wrappers had code to
implement this and meant to copy the error message from merge-recursive
but deviated in two ways, both due to the message in merge-recursive
being processed by another function that made additional changes:
  * It added an implicit "error: " prefix
  * It added an implicit trailing newline
We can get these things by making use of the error() function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort-wrappers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index ad041061695..748924a69ba 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -10,8 +10,8 @@ static int unclean(struct merge_options *opt, struct tree *head)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (head && repo_index_has_changes(opt->repo, head, &sb)) {
-		fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
-		    sb.buf);
+		error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
+		      sb.buf);
 		strbuf_release(&sb);
 		return -1;
 	}
-- 
gitgitgadget

