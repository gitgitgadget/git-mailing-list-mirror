Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02EB1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfJXXZw (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:25:52 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46557 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfJXXZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:25:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id f2so391531pfk.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PmKepW+b9vVuJWwG9x8rfsPAKmfCnPjjJdX2sbvbrZ0=;
        b=Cgpr7h4R7pmcSIKWfIHdLm+FGgoNQ1v+cceHgdzaK+xcx8UN45g8L4vMh8dXTZz/mD
         yzBGHFPKE3ZvcgbTFPBS0LBLZ2wrImRTKSTjqjPRrHA6Q2+GTMCtbY2k13gWySPiqNEv
         +8raOac6G0PHH+KisUKo2E4/eBC4hv8aW030AAmutKc8hsn6gI8MugVcLz4PAzHQuFB4
         Pa21w32vgc4w2I5PkaXGRS73AM75OCEUtnLyL1ah8sdZjj1y15mA7vpM0G13ALfTkqS6
         WX9Z4SmSnO4XF7HGtddovkARmp9EzTYtx7Wj7+A9jnDGeaWKnFqYPG5bmCImifnTINQI
         wf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PmKepW+b9vVuJWwG9x8rfsPAKmfCnPjjJdX2sbvbrZ0=;
        b=CkC1fmOue1mipJSLyfVMSIftyezWJ4uhRXdxQfPNX7TnSU2yEmemquv6Df04TdoAnG
         5ZSeUsU6oOR9fjbv3UtejjxNNeLjiQrZ0bySZAxvKjzMQgIEcRg8mkT2z9F5+XgpfXKW
         YB10R5Q0/mmwpZVkjyzEWezf6seJbOsY03xb9uxbs5u0AfGxaDcNArZd9MS5y3yFjxGm
         QOCmAr+6nnh+WyhF0gCLSmOJTdv21txyT3DPJJ9mrWg4Al4vXICOu9pYxYN5n6lUCJJO
         wIosGBTN4Ll0DNWmMXfYM++yDq1nIipDygTVAyf8pgYhz1aIXZ94EXMVqsRIwivQGs8O
         wznw==
X-Gm-Message-State: APjAAAXnXoKm1+t7i2W+FHwEIRhYgR4/4UpX7AFoS9hk7DYsJuMje9pV
        T/jPQbBhaBMrr0BO96zu0sj2Fjfk+QMm194id6+h
X-Google-Smtp-Source: APXvYqz75a9faWD9ZgtScDiKrFqpRKoZX6gF+io7Cc2SGt3EE3vzkbWsFm5gCwZld1t1GsKcSyP1SGkqbhVBL3RAMnYB
X-Received: by 2002:a63:5406:: with SMTP id i6mr607196pgb.1.1571959550116;
 Thu, 24 Oct 2019 16:25:50 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:25:46 -0700
In-Reply-To: <20191018044721.GD17879@sigill.intra.peff.net>
Message-Id: <20191024232546.70565-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191018044721.GD17879@sigill.intra.peff.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH 04/23] remember commit/tag parse failures
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firstly, this patch is not about remembering, but about not setting
anything, so I think that the title should be something like:

  commit, tag: set parsed only if no parsing error

Incidentally, the check that you mentioned in PATCH 02 is probably no
longer necessary. The tests all pass even with the following diff:

diff --git a/commit.c b/commit.c
index e12e7998ad..086011d944 100644
--- a/commit.c
+++ b/commit.c
@@ -359,7 +359,7 @@ struct tree *repo_get_commit_tree(struct repository *r,
 struct object_id *get_commit_tree_oid(const struct commit *commit)
 {
        struct tree *tree = get_commit_tree(commit);
-       return tree ? &tree->object.oid : NULL;
+       return &tree->object.oid;
 }
