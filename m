Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE0C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbhLFJpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbhLFJpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 04:45:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C2C0613F8
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 01:41:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u17so13773063wrt.3
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 01:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=q5dN/5VQh2BAClBHFo35TRrVCHawBHWB2pVRXb6wpF1tyB9bid1N25iT/wZHq4Kxsu
         Yy5uydP2Ww8r19KBgHhiJVLq6V6VwGKzlLLpxlmwIrzNQ7nA32R45RhhSwaEYavIPO/e
         5LUOkiCyLfp9e/MwWVPFmvYSmL0Afw4unxiMH6ZxJYbZ3xUzrqLCuzvX8IWWIwsm1e9Q
         m+FJIusgloyGQBIW2hatsXSIXUiA5yo+VymM/jzeCoOnX24s1GwMZ1vUyOjrvA8Ezqb4
         7HSamTcH7pyJKS8IoN15/2933vh29btTX9eOTXuE9Bi/wiNtY/eBqRNbm76BeIf2XGDj
         HTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=cl4EtAMC1QdweXN2MJPMt/VHWC9dmigQCUhRo/UwwuSxsBXRnPvUaec7n2wByCvCbw
         Jpn/xcazDl3zWn99xUCFDTuN10N2OMHruuVHc5F91shkJWlQqBYKhjYyxhZ0i8Tzx+Ux
         Z6D6KBXxqoggjt3KF6IBu/A3UgBZMAHaQDz9vZ/qqES5sSYBr+nEXGMq1E831uV2K7qh
         ztFrqFO34tf8GtQ99Ie/2GILdYeK5ZdlLhJ4eD74hv0HuEO0aFVilWQ+62tsJ5CovEkH
         VVs7twlTVwM2SNOED0kX0goGDa+5qKBsjdngh4+5ZItbfkaTADDL4Gb5F5XmSweKBu8V
         Eacw==
X-Gm-Message-State: AOAM532+T6EgcJTpemHqQu+3MfikigRD9gfcycPCI1FiAa4SC3au/sxT
        NCYemlmYsmioe+AllvmjqR7vdEwwe8A=
X-Google-Smtp-Source: ABdhPJzC1/JPLC6GoHQaVxFpJa6DXcMNzb2bGwAtjmP4JvlWltjPb/17/Je2MdMbaNE4v8eAJ4WV/g==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr41788641wrs.237.1638783692194;
        Mon, 06 Dec 2021 01:41:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm10757447wrm.96.2021.12.06.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:41:31 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638783690.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
References: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
        <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 09:41:28 +0000
Subject: [PATCH v15 1/3] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= 
        <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?=
 <aleen42@vip.qq.com>

This commit has described how to use '--always' option in the command
'git-format-patch' to include patches for commits that emit no changes.

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..be797d7a28f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
+		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
@@ -192,6 +192,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--always::
+	Include patches for commits that do not introduce any change,
+	which are omitted by default.
+
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
-- 
gitgitgadget

