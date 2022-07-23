Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A833CCA47C
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiGWBx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiGWBxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF876EB7
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v5so3709766wmj.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gN0tZ+ael5Qgw/uE37c3BdgOrXL44tqLZY6nsQFMh3w=;
        b=qyi3OMDuXfz+J7xH5/E0HWEw9G0MztvJpdtAMDYKja6UTWjm9RkS/xBxYKyY6UMuKj
         e7p441xT1TCd4CfXk1i8r2qRE/SJiQb6AKEYWxrbWinImTi+mMAxiTBBKjd7ayZbuTbj
         rKkXwc9ayhul24Dco7i+rRTIPeEIWMtdkIKXpz4H/jCfnYinwvBWtYQ9jCMtk26Augq3
         ln57g9QskOpV5466IBhk+4TcOpcXE4iNuIf5wRxRbM40ECCaz8Rxj8rqOKjYzotqV0EY
         RAj5AE30yvh13zOpRYq3jtAw0o99fZzh/vDdr2648JBQQjxMbHedw+VYdOrGG+IzWLRb
         MBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gN0tZ+ael5Qgw/uE37c3BdgOrXL44tqLZY6nsQFMh3w=;
        b=mjkR5vtb4sTN0u6WqQwPdqARikMAn+vKCWck07yT+GM3Q6F88V9PnQ/+yRyZbliVaX
         TaX3Aj8GGw5KN7dg6G3zgsQJlje7LTf/1sBCauwrvlsV8aK517ayNb3El9H2o9/KFClg
         UPLNw7zffEQ+Z7300rA1uiQz2eBd9nW07VsEMzOemfKrKDFywcBHss4kStS09vp5Y7s/
         C8fQM2usm4yI0Kq29C7qZKWNXIvfljwthjVrj9ROQ2FvJLSClt6mSHcnVsPZ6zyDLWaV
         KFZT/YjhIslfFUaK1VejNHI+HGBUzF7p8uLSNzm14lJNIlU+cSZrdFH/+XDxeLJPeVte
         CCgA==
X-Gm-Message-State: AJIora+yZk4kqrTc3DRaErp8DUG6WnnHB9HgU8cGKXsPf/+X2q0tc6+6
        YAenBavCadfAHs9zpkSEY66XWJEax0A=
X-Google-Smtp-Source: AGRyM1u0KtVcdR1+GQjWfCvsjbg8Ing5w0sTxzPLzezcT8DK6TZNku7lu16ijkIouCAARER6RmF85g==
X-Received: by 2002:a05:600c:364f:b0:3a3:20ea:b85d with SMTP id y15-20020a05600c364f00b003a320eab85dmr13847448wmq.125.1658541200979;
        Fri, 22 Jul 2022 18:53:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7-20020adfe6c7000000b0021e4f595590sm5991190wrm.28.2022.07.22.18.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:20 -0700 (PDT)
Message-Id: <bd36d16c8d93176bac12acaf90f654a0acb16cd6.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:11 +0000
Subject: [PATCH v5 1/8] merge-ort-wrappers: make printed message match the one
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

