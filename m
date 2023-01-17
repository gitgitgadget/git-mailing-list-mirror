Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA2DC63797
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbjAQKg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 05:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjAQKgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 05:36:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D020055
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:32:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g10so21848009wmo.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N86R8x7tY/jVkXj4il9Y0qauIyFiObIhfQ6ZH6WJC3o=;
        b=QfPJAHZx63xXCH6QLdrOxbSeeq5fp8Vp4nyHgfcb/NH9P0e6evv0OQ7thaDbz98ma0
         Bn5DD/gBrLi1hZLnTRKVFjvP0G5zFZSo/DKOpBUmGVZ5vuRPhclKkSdga+2orKJY3iVu
         6CVGkfkvTuh742gyqHZChNQjFLwoUuGryo61lxVUnvFCM4QMqlZEp9xLfRqoMG54B1ee
         3BUER26NgVMHS0QDhdaAXrWHxc3/TLBRpnieMays87p/bgNIk+pmt2aAdCJGfdleeGuV
         tqHyONxDyGDUNvVkFC24OFM9TeP/RsO3RMKwWoKS5GChmkgTQxsqoHJx0q+ynb75aSgA
         2ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N86R8x7tY/jVkXj4il9Y0qauIyFiObIhfQ6ZH6WJC3o=;
        b=Uq6bLo8EpiP5fp0G5YgtmUAJ/Ivd+DnFIJf4UZ8SMjwWqcMRRvCBern+vIp6eGg3Zb
         TuxPi387TiS+7yp6/Z4kH9EKgQ6P02PjJLlTPHeliCB2VufN/LrbPVkv1Bdgv0bysAtC
         /n33bFkY3HSU/b7t1c/bbIgLq2GLEo0nlWPu0g+RX82d4PBZCxqTz31psjGoGBPsp3Sg
         Zg7LjY+a6sbfQcU4KXiWCSrXJbEYARa0hvXfJlDSGFuyzx4RcKlAadW/r1CWSopvqBGK
         MSrayQLUYZwzQ6CZsNzwmuOc2XQtYvmB+qzj+zZUE53rkb56DA6DupzYw1b1l3FA/PyO
         UGXQ==
X-Gm-Message-State: AFqh2kpASb/JXkj6pHQnFQksa62aSPQWkqYADZriLAMZU4Fv2ldQ0DM2
        /aLdSxZreRo9eT8BaxToMAUkIzgxA0o=
X-Google-Smtp-Source: AMrXdXsHn8SMwFp1v7PiRLsc7W1BH1yOP9Q1QMQxdKMsquvl3LqusPjDm0FNrgxOh/DIEiG/2XfTzg==
X-Received: by 2002:a7b:c4ca:0:b0:3da:17f5:57b9 with SMTP id g10-20020a7bc4ca000000b003da17f557b9mr2768018wmk.5.1673951563944;
        Tue, 17 Jan 2023 02:32:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b003daf672a616sm7922160wme.22.2023.01.17.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:32:43 -0800 (PST)
Message-Id: <214a2b662e3f8d6826a916b88cd3162e2d110e0a.1673951562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 10:32:40 +0000
Subject: [PATCH 1/2] receive-pack: fix funny ref error messsage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When the user deletes the remote one level branch through
"git push origin -d refs/foo", remote will return an error:
"refusing to create funny ref 'refs/foo' remotely", here we
are not creating "refs/foo" instead wants to delete it, so a
better error description here would be: "refusing to update
funny ref 'refs/foo' remotely".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 t/t5516-fetch-push.sh  | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af303630..13ff9fae3ba 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
-		rp_error("refusing to create funny ref '%s' remotely", name);
+		rp_error("refusing to update funny ref '%s' remotely", name);
 		ret = "funny refname";
 		goto out;
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 98a27a2948b..f37861efc40 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -401,6 +401,11 @@ test_expect_success 'push with ambiguity' '
 
 '
 
+test_expect_success 'push with onelevel ref' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo HEAD:refs/onelevel
+'
+
 test_expect_success 'push with colon-less refspec (1)' '
 
 	mk_test testrepo heads/frotz tags/frotz &&
-- 
gitgitgadget

