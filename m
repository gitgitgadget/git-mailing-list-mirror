Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B4CC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 05:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLHFJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLHFJV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 00:09:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400EAC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 21:05:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d9so1922069wrw.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 21:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=O434bcTDQXN/Ufqig54cBObpSHmEONfR7Q+ZyXno/7Df0iSRCWdEGoK3dBBFiqKswJ
         aZ3R0Kkci7LJ7vxN3FciYs7TYPjJ9QEpFfMkKoLxripfzuTs8ShyVKbISHp8YSeMCd56
         PI+KrXItncfWelzOK57vQitYbippEMdLZGG7O7KNzdhtNoKVpwpPYtSNN/GIwFRZhYjH
         MMt9p9s9dpDE8pHV6YlbMyMbFIqZg+z3Gwl68rgl6gKRpd8VhRim3Bigkfz7mX0lrhLC
         zDoWz163IrOegtEwZRBmj6Bfcw8BHqMJoSl9nQ1KpK34UYS+Er8XT8O36AsxCTzjd+JM
         Ez0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=Oi3zZc31bpBd60MRKWtvMdGcGirHa0y0Bq3YYA7iISIlvRujwXs7lG0hlhTVEQuiOV
         AukdP/kqnV0udt7E79XTQqnKhxvgzqtR2BMi+bvjWNQYGCjbvYeZdn2SVeG79J5cZY5g
         PL1+bM1qGiAs9DYlxvePshhSXb8mR5aWMZKBJO4Ugr8Sl2NNlnUVhw1LWVnAidgaR7nQ
         xCQKqj0SJt6aix7sDoNKRgbnsF58CeGZU+H8bu3C2jlCNpChXPlT8Mr6kuruvss3zsRi
         7oPIuxkDcVQA02b7h1lBFg29sImj0gV+geFDe5qefAfTXnEBDdlnZpA8U9DjB9TCSHu8
         EM9w==
X-Gm-Message-State: AOAM531kuAD/OEFjR+qjlqD4xF8M+ghgbtNfhwVp6kKcndvxabWcPD3W
        k4Cod5+Erg/8e05WTJBnSPp4mtSLULQ=
X-Google-Smtp-Source: ABdhPJxfxhidm+WSWpc+H5UPj4LNex0YTaNdsi53EZ6sYvqaZlTkvZ1f7rKGhZLQM7k6T0Q4y7qCIg==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr54708567wrv.427.1638939948729;
        Tue, 07 Dec 2021 21:05:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm5151250wmq.11.2021.12.07.21.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:05:48 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638939946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
References: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
        <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 05:05:44 +0000
Subject: [PATCH v18 1/3] doc: git-format-patch: describe the option --always
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

