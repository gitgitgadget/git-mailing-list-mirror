Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED867C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhLGNmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbhLGNl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C01C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2263568wme.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jA2SVtXqn+u0233wQxvaNn9NKHl97Jzpp83rxUSYsyQ=;
        b=LqGJ71XqTo02c0bqVf8zoPPT3ndo8ckFPpk8FEScPm+k9Il/gYq0h35VX+PYbmhgxH
         /LdrV9RBRnWnd+RMi25xqGaj+5uXsKILKOKyXqKhUFQjOIaUhhJfzHzFRp/Z0Du0Tzo3
         4V1D+QTJnlYOIyM4Cag4wspDFPOYlikhvq89AXOyuU8IEfCbL3v73/TRMML5s34J4JAF
         hE94A7SfAnXg1scJUsGNAHKjA/SIHNq9w9+8vree65Ohv2YEtZY3NoduSxtvixiUyvm4
         f28odKB1vRVQJTyDXvnE11VJWWD0BVL0GpGyEYdACx4nBtGYwx6ruF0aYM1DB/PmfExk
         +fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jA2SVtXqn+u0233wQxvaNn9NKHl97Jzpp83rxUSYsyQ=;
        b=rS/vnHe68SA7C2B+vu8xXcMsNt1qtLuyJh+qBr4JEY+4cXeJ6m7bsVYHjU+gJyEYpD
         Xu/0zy0xsYUs97Exa6X5sDt6PG/VjvmZ0kTBFJ/LgWRLZeDcKdrvdbc3o9ZLvVQdr5d5
         xf1ffxBba6RKOKUQl8DYGW43LUfoU8oZNeqS3BU3KAw5ydSjGR1JBju86skWBANSTEPU
         1U1cqd19L/n1aE7JbBRHQ16YhrU+v2vrpaq/nlsKVvWnHZ6hfRwJWF/HmE0qOLaJu0LZ
         t92vxvtZflNCDK2pshrxRd2vmtC+YwPFApHBRvauUpNzSbU0f5N86cjorCmp3XA3bwAO
         fdvA==
X-Gm-Message-State: AOAM532XiJJiiiNfSWfCWPInvVH40JaorSnq4XlE3cis6Gtb+n5t1VSE
        UQXwBEFbKp1XI81NtBCMx9s8dS+003E=
X-Google-Smtp-Source: ABdhPJxBrzc6R2aDKgkZmOArckeKJRbR4wVYjBg1AFINlx607VPqZkeXpIfOLfwlOm9C/urQiWZS2Q==
X-Received: by 2002:a1c:9d03:: with SMTP id g3mr6875670wme.143.1638884304841;
        Tue, 07 Dec 2021 05:38:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm3144554wmq.11.2021.12.07.05.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:24 -0800 (PST)
Message-Id: <67d22211ac4b1b62b2c3f76893765255a59ade8a.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:16 +0000
Subject: [PATCH v4 4/8] refs: update comment.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

REF_IS_PRUNING is right below this comment, so it clearly does not belong in
this comment. This was apparently introduced in commit 5ac95fee (Nov 5, 2017
"refs: tidy up and adjust visibility of the `ref_update` flags").

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b14f30d48f..37329b98cca 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -16,8 +16,7 @@
  * This backend uses the following flags in `ref_update::flags` for
  * internal bookkeeping purposes. Their numerical values must not
  * conflict with REF_NO_DEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
- * REF_HAVE_OLD, or REF_IS_PRUNING, which are also stored in
- * `ref_update::flags`.
+ * or REF_HAVE_OLD, which are also stored in `ref_update::flags`.
  */
 
 /*
-- 
gitgitgadget

