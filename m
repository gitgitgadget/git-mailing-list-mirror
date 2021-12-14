Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39928C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhLNLs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhLNLsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77763C0617A1
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so31953435wrw.4
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=eim8Y6qiA18pYhLHwfQn3lVUcDx5a9AmkdPdE0Bnjh0yZIjtgc8ErGEQMeIfSNNcuY
         50aKvkEB3ZuGU55D8tqaS7SnCBqo9ktjobpHrVP1EmwoAyc/oA0xvL0YMgNnYRsnrdF4
         XqpJbjoxbwI2z86S7hFt/awdSCB2e9AWKAt+DpS36xp3EaCc0benWkfFlOMFmLH8MRN8
         IEVXcsPxRDOGJwpiUx26nwpXJNYqXGFql3HqkAfU3fh2qDGGirz35LY/OhQgXUyfmBAD
         fD7xjMt8eY2/h8E0LdOPikpC4Lb5oYky/XndJcn7cWivk+nfUFFzUnZkbiAz1nnXdUSF
         GF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=FzdtriX9jR38t2dSvt1ApWH+opJ/aW4A4/3P9dRq7oPmMzu6USRSqNdWgCYcdAeAqP
         0H+ZH6tP0pJDu7bVNR7iLtR+PG/IdF47onOuoM1z7Pwb5mN0F6i3EWuUVEjUxtvZagGL
         Rvgb4pH5+o0jjnIo1dgrEe8WQgCp1dPLl7zmHsh6BWv7Ua+JrbWikNByxLh73Ls5D8Gm
         Dw7WDMzYfwtq+oNaUntQYCc8UmsdV7FKwNCjHe4cqBM7VUXw/0DmdGEd830dfRHndG6B
         cg8+Orb7VKjaSTGCgho5NKhFZ1glr7Q/b9Q2AHTCxIYm7waSpCVOHHVCWUUjd/BoGT/c
         N6ww==
X-Gm-Message-State: AOAM531GI2HAfa6VVFEkyzvfaEL2EjCF8dG1DjeGa5YVYaQ53z+nL/eD
        uqxjmFG8AjA4yxDJ7890ma/wFnUBE2Q=
X-Google-Smtp-Source: ABdhPJz8mhI1+Tx4qDQtHoikkBrtzm3dlgC1yFoyR2Prz44OpWfbKSfCIZbIut5tQF6DzZqOwDwK7Q==
X-Received: by 2002:a05:6000:1809:: with SMTP id m9mr5147579wrh.678.1639482485010;
        Tue, 14 Dec 2021 03:48:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm1947179wmq.6.2021.12.14.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:04 -0800 (PST)
Message-Id: <d2ce1bfef9f3f10ba681b72f9be6579bfc8a9491.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:55 +0000
Subject: [PATCH v4 10/11] reftable: handle null refnames in
 reftable_ref_record_equal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8536bd03aa9..8bbcbff1e69 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1154,9 +1154,11 @@ int reftable_ref_record_equal(struct reftable_ref_record *a,
 			      struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
-	if (!(0 == strcmp(a->refname, b->refname) &&
-	      a->update_index == b->update_index &&
-	      a->value_type == b->value_type))
+	if (!null_streq(a->refname, b->refname))
+		return 0;
+
+	if (a->update_index != b->update_index ||
+	    a->value_type != b->value_type)
 		return 0;
 
 	switch (a->value_type) {
-- 
gitgitgadget

