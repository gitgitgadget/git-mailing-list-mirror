Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F4C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiB0T6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiB0T5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:57:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EE33A1B
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n14so12319556wrq.7
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6766akpyO/bv1XaJriTIe1tvYGqjphFS3cL/dXlqmDw=;
        b=hcZDVMAiYFQ9L2wQokcpc71iK/yLltclv/AkV7TxCDqT77XMh/Ut9BOX+ZCr+c4iKy
         FetOtaKgNRpv3TN47P7pAlJwJXiarTcrbulvmuEFRZ+cchlf5MOadRO1KUvCMxPZOiuW
         7GtE08NsIFM7GxyRvP/zAsQoyguYJBcqm4y4J6CjcWK/adeMnZvJXaY6a0vyKNDg5XYx
         WYkQ7Ppc5VSVhpAoVZW3m+xJueANWlrf+JKrboR0liUI/wDuei0xxyPr6e4X+1c2BA9s
         x+tGtYULPk1IseMx0D2eaoX+RHF4+67iJ14oQXJxr2b4F63khSV+Udd6mU9XpaAXylBs
         ISfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6766akpyO/bv1XaJriTIe1tvYGqjphFS3cL/dXlqmDw=;
        b=AV/nxeB2gOt9H2s7/2pS4BVuItXeljZLbnxxLZQWizr8HA58KYdIPcW4chLs9SyzxE
         3tqidtEKt/EWypKTB57XdbZWXm736WmkkfKd6lU3Ckd1DyHwJLGnroDpL1IysL8Ef8u9
         lAGowc1cZa4Crp4mE095+ZS/9Er043Fe/VeORYeFQUb9z0yDtr8TB0tc7w/qtKIKyA8D
         kOvUk4KvVIiTld9XdjxB1ysY7k9mHlcJqa0kgNK2+8pKYPh86mB7wVZFhQKgpwAv2jWu
         vgc7KR7RkPsBvwR8GDTIgUq1I1zpTNxZjdS8H7sr+SJOq/wB7lt3k6hM+qrOzo/+v/oL
         OIfg==
X-Gm-Message-State: AOAM5309DzZB8LotZn7iZFpbF8BPYztxqPevFHp/iAwbBLy8xTPWGlqB
        Wrg4lhvncb90fSXdpWUaApBTm/98Nak=
X-Google-Smtp-Source: ABdhPJzTJxH6+XBOG8LI9yMLCrqbDp7jYccaYn0snVl+AW6wpr1faFGZxTNNWUW0kQOfi7fL0p/GtQ==
X-Received: by 2002:adf:a4c6:0:b0:1ed:a13c:9634 with SMTP id h6-20020adfa4c6000000b001eda13c9634mr13550727wrb.414.1645991836607;
        Sun, 27 Feb 2022 11:57:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm10952270wmq.29.2022.02.27.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:57:16 -0800 (PST)
Message-Id: <06e51dc50937dc08c11e30b096c231a3d785f24c.1645991832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
        <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 19:57:12 +0000
Subject: [PATCH v2 4/4] git-prompt: put upstream comments together
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

Commit 6d158cba28 (bash completion: Support "divergence from upstream"
messages in __git_ps1, 2010-06-17) introduced support for indicating
divergence from upstream in the PS1 prompt. The comments at the top of
git-prompt.sh that were introduced with that commit are several
paragraphs long. Over the years, other comments have been inserted in
between the paragraphs relating to divergence from upstream.

This commit puts the comments relating to divergence from upstream back
together.

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 2772f990888..87b2b916c03 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -66,6 +66,11 @@
 #     git           always compare HEAD to @{upstream}
 #     svn           always compare HEAD to your SVN upstream
 #
+# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
+# find one, or @{upstream} otherwise.  Once you have set
+# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
+# setting the bash.showUpstream config variable.
+#
 # You can change the separator between the branch name and the above
 # state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
 # is SP.
@@ -79,11 +84,6 @@
 # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
 # by setting GIT_PS1_OMITSPARSESTATE.
 #
-# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
-# find one, or @{upstream} otherwise.  Once you have set
-# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
-# setting the bash.showUpstream config variable.
-#
 # If you would like to see more information about the identity of
 # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
 # to one of these values:
-- 
gitgitgadget
