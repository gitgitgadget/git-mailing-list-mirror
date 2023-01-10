Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A7CC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjAJNPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbjAJNP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DDC58D0C
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs20so11701342wrb.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyUgHjw8gfloEMDd5GGwhkVmyVlOEUAhR1Crsh4GblQ=;
        b=iATCtiJt3uyKbWhe9Y1qFRJY5Uif0/W266noLZ4gNy1nLgsO3ShhoKDzeJOY5s8qLu
         CIOC1IfCzxeVGRWYmePStaebomG3RAO0HDL7SljI8KbHRrvu35jI3lHAWDVaiHauYqDt
         fw7ixZqZqwrrqXmk1otw0PtJ9Lxpk7H5o9/iJRobrBGV8WF4RWyn7MvWO2Rxw8BGz21+
         3NshTirJPRI+SP5xfWpwvlFjyiJmI3bpgDiA6cD+6f2FEJtvC7cnSDRqRBfyOCxqnanj
         u+ryFXlqZL+kFr8tO1FBxjXzTlsHBKmduRhUDi1509b7cp0S3UJeYfcWRJihdrGEozAp
         mDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyUgHjw8gfloEMDd5GGwhkVmyVlOEUAhR1Crsh4GblQ=;
        b=1jZNyn0abk9R8NwBZL+cTFGXE5Kl6yu5ipkFIzZPBVoyId3loXSGZrWag7IonsDGrl
         R0vzJv7hcHgWUqvreof2zkhzayDyK2ncY7lAIRHIylo/UFTxx+7jJRGRsNNEYtmq1pZW
         DXSk9+x7dw/7ysfraJ4tMnIOSRCxoXGc68Ps0WciOUAsWOE6d1xbgbKJaAJlbHmymdJG
         e9hvQbqHD7pvTGYl2aouEjMnIdEv/mAdwwKFX4hzkb67H1LtSS9w/nha3eYqrC8izAhz
         //M5ocXr9NvmkdGILlw9eVBkRwehEAk/ifoRNt4E/hOygv/npMcA/hzG4VIOecnmt0ak
         xqBw==
X-Gm-Message-State: AFqh2koqob+fFw3ar/mSYFoRZyQGA+kwXB98iKnKDxebzj1cnNBJ6u7x
        b6h3Bmpkf/ogLD43xvYI+0Ja5koO4qw=
X-Google-Smtp-Source: AMrXdXukS1C9jm9CQS8XaNDRkkAV9O1DM6Xh/TUetp3lebZb9VODCywBcwIOOLyMo75aS73nAr8kdw==
X-Received: by 2002:adf:ec43:0:b0:280:cc12:2827 with SMTP id w3-20020adfec43000000b00280cc122827mr33684713wrn.21.1673356524024;
        Tue, 10 Jan 2023 05:15:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bx11-20020a5d5b0b000000b002366f9bd717sm13788596wrb.45.2023.01.10.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:15:23 -0800 (PST)
Message-Id: <74b2d5a9144e4893311d9acfb0b5e8268da6f0f0.1673356522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Jan 2023 13:15:17 +0000
Subject: [PATCH v2 1/5] git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Commit 67ac1e1d57 (cherry-pick/revert: add support for
-X/--strategy-option, 2010-12-10) added an example to the documentation
of 'git cherry-pick'. This example mentions how to abort a failed
cherry-pick and retry with an additional merge strategy option.

The command used in the example to abort the cherry-pick is 'git reset
--merge ORIG_HEAD', but cherry-pick does not write 'ORIG_HEAD' before
starting its operation. So this command would checkout a commit
unrelated to what was at HEAD when the user invoked cherry-pick.

Use 'git cherry-pick --abort' instead.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-cherry-pick.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1e8ac9df602..fdcad3d2006 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -219,7 +219,7 @@ again, this time exercising more care about matching up context lines.
 ------------
 $ git cherry-pick topic^             <1>
 $ git diff                           <2>
-$ git reset --merge ORIG_HEAD        <3>
+$ git cherry-pick --abort            <3>
 $ git cherry-pick -Xpatience topic^  <4>
 ------------
 <1> apply the change that would be shown by `git show topic^`.
-- 
gitgitgadget

