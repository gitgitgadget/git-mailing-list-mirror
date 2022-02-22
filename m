Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B45FC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiBVLoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVLoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:44:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C797139824
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:43:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gi6so8614022pjb.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJl4EwHSx7iPHKPHsFLW54Hk94l5NSKz7KVl7TjqYYA=;
        b=oIB+LcB2TfhUq4L5uLIY7l26vdSU1J0HREktrfQnoFSUsgNoiVjUm9Q09xTdviT9l9
         gikWTivCRHNj/qPwc2xL4WCQPy38dS4LlIxP5JnCTOjQ3yJfIP5UwnbsfAf2cdwpgim8
         GRJyRhOUPYbQQnKnNjzX+z33WiZJdJFr92CELdmRjk87YlEjv5Mz/R5uoHGZ5iTDrX12
         wVe43LeKa5WpwOlG+2e2jXgq1mX84tiPvTQFTGZBxxjPMTfA+KXpDJ9MGiwCDTq1am0+
         2wl9wTG9LCHPx+QI9lkgo2+MihfN7GKMtuJ2uqyubq652y8JtzIJQ2ua9Mnl5k196S7a
         eEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJl4EwHSx7iPHKPHsFLW54Hk94l5NSKz7KVl7TjqYYA=;
        b=whNEj+HkCAQzFBC4bHN2tzA0H12DbqdSbGjlx8AiYDfni11N4mQ8unnr8v+ZY7pO00
         43d3bbdKxk3Dc64dECkj7V/zNhXlqJH78Bcp3McIRREQkWTI2qbDbQrPG1JXk1UlceSi
         ep1FJzBTKzePSVDO6hDP75x5olrnGwXlqNTAox6dVU4E/HtSUFukP7OVoor6jJAi05nS
         oLpVJ/ltK6jMQbCTSzLEkmmgOXDB8JGOpfcumg427wVdVhcRC8IsT5vYX5bVbzkTr+ZA
         O39WuDBTjTv5qs0hvkupfMHw9RU8sPrCoVNb1e/ZNPBbSl4JWkA3bC7uiJXpDpJfYauf
         Qxig==
X-Gm-Message-State: AOAM531ed2YNXTV4u2LhGvd6cTJlJSv1fM5q0yoajWgTAB/+2XrU3jK6
        lfiU9NnhQBYtoP8mak22Sy6hxEQbW30obucFk6I=
X-Google-Smtp-Source: ABdhPJyH+orY67kglGw4coWfDn87MPe3dgQARlCkW3LzVyv8s30Tum9GDjSzS9z94+Y1uqqmMiw7Lg==
X-Received: by 2002:a17:903:2442:b0:14f:ee29:5ef4 with SMTP id l2-20020a170903244200b0014fee295ef4mr237919pls.134.1645530219192;
        Tue, 22 Feb 2022 03:43:39 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.196])
        by smtp.gmail.com with ESMTPSA id p14sm12372430pgs.46.2022.02.22.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:43:38 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 1/2] t0001: remove pipes
Date:   Tue, 22 Feb 2022 17:13:12 +0530
Message-Id: <20220222114313.14921-2-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222114313.14921-1-shivam828787@gmail.com>
References: <20220222114313.14921-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pipes doesn't care about error codes and ignore them thus we should not use them in tests.
As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0001-init.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 3235ab4d53..9a8f209648 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -489,11 +489,11 @@ test_expect_success 're-init from a linked worktree' '
 		git worktree add ../linked-worktree &&
 		mv .git/info/exclude expected-exclude &&
 		cp .git/config expected-config &&
-		find .git/worktrees -print | sort >expected &&
+		find .git/worktrees -print >tmp && sort tmp >expected &&
 		git -C ../linked-worktree init &&
 		test_cmp expected-exclude .git/info/exclude &&
 		test_cmp expected-config .git/config &&
-		find .git/worktrees -print | sort >actual &&
+		find .git/worktrees -print >tmp && sort tmp >actual &&
 		test_cmp expected actual
 	)
 '
-- 
2.25.1

