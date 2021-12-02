Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD181C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348257AbhLBRkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348208AbhLBRkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:40:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB9CC061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:36:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso2896360wms.3
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ItUp8M/atyI9K4rx4P6QdD53E0D10J9MuhiA1jbk01M=;
        b=pcXPXBDZpDMJDCBuD+tCENz2qtrU1YsANd4f4DfUfK73KLyNNr11ywrdBt4oR+E33u
         EOjNEHZmNKzyiEpH1Ep2u64d8mAyPVnVg9sVMlMldtivzUMb1CvYC0xrQrjJ0qfzJXRq
         hNlod22IMRlW61C+Z+E/vyS3xqwZgxiJtplleEd50S7cnCkFVK+HkHLXX4daoZag3Wjx
         EyOvgnhHjDAh/3kxyU4hf+MoYb963nnMC10dmY5dtqVTHQg500nwUAjGwQJoNe6RVRh9
         eLls661b01m9wJ2NjleNPik7Lp6SaSQz5mVJuYQFd8BUHRAmz0NFdUItmvfXFebdnGpg
         Gy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ItUp8M/atyI9K4rx4P6QdD53E0D10J9MuhiA1jbk01M=;
        b=lW+XtpzIR4RqVmzmW7AD2m2UVqILg5lj5oIGxz+nxt+AwUS7VTFzbCzU8TXSWNbfog
         VOq52Rjcgg7FHTJuHxTJ6cqvchX2avWVbJg21JiXu3SgSowO056D9XzS/bZ8cNDUpKUa
         tRNkBUves6KxIKPdamsFO6FShk1SJVGtUOHpyrDqIuRbD6AUaIAu+nX0tkVoThLlc79G
         dwsuIsbRoenONJx6FVgeDqEHARiMUX2OvoVF2SdujvaTEzIaf+ZfbbRhfnzPN03XNcsw
         dGxkc9IUUhUJ6dF5LTW8uXYichDHHkzVcBZh4zOxfCg7c63ss5a3oowCtzrebZ4Jhxvv
         ELfg==
X-Gm-Message-State: AOAM531KNy4VcMCsRb4mg8L38x/1Yxn3Biht+RVs1ZnxS8vTbRRv7mWd
        tN9GFGGHv/2jlcTgMxuuV97a/p+G4sg=
X-Google-Smtp-Source: ABdhPJxCxnz0bBoeW5PcBVcWuVcigmp0yY3EYi4RDyINZ4Xw49s/gUeblkUzoEwyjGAtiYOaCfi4Jw==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr8006852wml.33.1638466597216;
        Thu, 02 Dec 2021 09:36:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm364497wrs.56.2021.12.02.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:36:36 -0800 (PST)
Message-Id: <46a8e13a5e6d04b2265b3bd4f06e81408e63fe98.1638466593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
References: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 17:36:31 +0000
Subject: [PATCH v3 3/5] t1405: check for_each_reflog_ent_reverse() more
 thoroughly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If we are checking for a certain ordering, we should check that there are two
entries. Do this by mirroring the preceding test.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a600bedf2cd..76b15458409 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep recreate-main &&
 	tail -n1 actual | grep one
 '
 
-- 
gitgitgadget

