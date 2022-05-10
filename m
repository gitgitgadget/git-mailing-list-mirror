Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8298C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiEJXcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiEJXcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB691D5008
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so661875wrb.2
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l0GBE4Bw8UswNS7OaBN/M3WB04xhQh/eMswefjKAN3Q=;
        b=RcoFBsjXHu3184Ey/ta1anWP2lTqRDAth8usd1/aFamobcjHx5WhJDdh89rTp2J4gH
         dPg3zrNL6ps1ekysH2aMyjR5pZzeo+8oIA0EO4oxE05bh/1Y1j/Q78pgEAUUyPmnLAgu
         0PIA/MM1kB40Ts+FU/QOzVHxU91fKt8UHnocS3oyvF67Hn60yRb5aoQRaf5KrT4pkR/5
         vFyL2CDASlj9HJtEVv1EvVd1yodVNCMh+FJEinA2fortAM1f5znQMXM9AC/LcLTxex7V
         9Cgu3iUrFHNCiL/agmZ8zwtlV6JZNlg7gpUtCchujqPbRpuJWWKVJ64ZQEtRyu9tLZt0
         bJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l0GBE4Bw8UswNS7OaBN/M3WB04xhQh/eMswefjKAN3Q=;
        b=KFUq/Ie+NKmePHApWJleXfPKR9ltKsurWZTOvXXIufTKK0NMQBrWYvjdl1/sSaV5P0
         Vet37CDmhGaswB6LekSRkn1v7SkJHVFkNKGixhugdhe5/CBDzPa2MebB//RWtLwSjtuc
         afLzmA+wsJrUVzQF6yKhy0DbnFMj/MZPJenPpFEIaAds+LN+bUqkymm6eixGjN56tYES
         cGNre9G3eWlp+h7+CQBkkcTJf52Wj0msgrJ+372YvpivX46ClwjhlM6uNQ5bjLz7SzWF
         j6LU8qreHT+OB3ToW8cJJ4dTFdW8sZas0IECD+C88nU1PzzM4vmcHlTvTK1cfIcaQwpT
         UzZA==
X-Gm-Message-State: AOAM5303E9rE87HX8nDTo4zmXQZd6a49tjjhzSaaN1MFWAaL2vCOvYgy
        YDBTt2v1GwywVvXkTfReeeh4QI8ifhY=
X-Google-Smtp-Source: ABdhPJxcdoO24eN0swUPXjshvUUrvDDGsNVeTbTDXSN9477fHvsUy4Oq+yoL+KHENR7wg2Bp0zk5OQ==
X-Received: by 2002:a5d:60c3:0:b0:20c:4fa3:c63e with SMTP id x3-20020a5d60c3000000b0020c4fa3c63emr20637864wrt.191.1652225559130;
        Tue, 10 May 2022 16:32:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d6aca000000b0020c5253d925sm135078wrw.113.2022.05.10.16.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:38 -0700 (PDT)
Message-Id: <6f00fca92671f23391ca92bfb529b8222a6e8406.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:29 +0000
Subject: [PATCH v3 3/6] sparse-index: expose 'is_sparse_index_allowed()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Expose 'is_sparse_index_allowed()' publicly so that it may be used by
callers outside of 'sparse-index.c'. While no such callers exist yet, it
will be used in a subsequent commit.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 2 +-
 sparse-index.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8636af72de5..ffbab7d35f1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -118,7 +118,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-static int is_sparse_index_allowed(struct index_state *istate, int flags)
+int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
 	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
diff --git a/sparse-index.h b/sparse-index.h
index 633d4fb7e31..f57c65d972f 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -3,6 +3,7 @@
 
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
+int is_sparse_index_allowed(struct index_state *istate, int flags);
 int convert_to_sparse(struct index_state *istate, int flags);
 void ensure_correct_sparsity(struct index_state *istate);
 void clear_skip_worktree_from_present_files(struct index_state *istate);
-- 
gitgitgadget

