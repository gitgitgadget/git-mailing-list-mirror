Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F050DC433FE
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiC1UuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346474AbiC1Usv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF91BDEC0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:47:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r64so9111109wmr.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V6s9NStrkqkgMSFUdgt4KZhO1dvDgJUvO+ONs1+3xwo=;
        b=DFxZ4u5bKbwcpmeyAsFr4VeTVcRM92d0huwsDPFlZ5U+9XDPkLAS2GeYHpNwbnB1Ul
         3CfM3kf6Q50QQDR+P0TrbOqNBTn5RuMq91RY3PuJq7m6wC3wzhgByvp4yTtxnE7Ip8jl
         1xMcMtcmiMVbcJ5fg0t87a0/A9G58eEjXe112Y5siYWVfPYfjL7Ukhfg9KYwIgVLDTdC
         WBb4KJnq+Qrj2wzdryNydAbLq95yxrefx4rrDUtRCJrXp/nmzdkMYEtDGKw9bDJp2o1f
         W7e8MN8JsJiIHA+XEW4RxhOnW6d7/RPVv1kQMGXBkcgH1Fo4VE9EaNh0rgKFyj5Oup21
         hfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V6s9NStrkqkgMSFUdgt4KZhO1dvDgJUvO+ONs1+3xwo=;
        b=WagRS0BolJa9QK9/YCskDFKDpVnXmY2fWKvWBF6TTNl6oRywUnHUo/iYy5jndNanxb
         YP+AtewI+e8tYIn0z47ZarYZde3jEL1LMWPZHwUpRb53q1GsHLtScjEWGZpA8Y+Ayo+q
         AZQ5EPa7avcxrpDd2Q/Xpn7EAx+Wfcec+8cbD+7KEil92QqIPw/lRQRfA1S+woEa8Rvq
         3DIPPJy+Xqumi2/uzU/8mF3JlBLqThTQhnggEEY2Oy203n3FX390v3JCU7BpDiXqcvuJ
         WEDFNJADnvi4jw7iDhIdHYoAFU01RDVZgpZD5rMOrc4S1P8gQjUUy8bKRv0cmqnXsgTD
         /mjA==
X-Gm-Message-State: AOAM532Gg5j9esABo7rTY+DkuAEfC3tJ53JYgngbHNs5+V7He6bbk2v4
        dsNeFRQPEC5Hen6z4Q6dg/DkF1NcESA=
X-Google-Smtp-Source: ABdhPJzNpYJTR0+AzNtMD6ipf/jE3CNxkubpon0Xwuv5FTqE2LDO2qT5Bzt5Pp34k3tHPk4hcdZimg==
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id b17-20020a05600c4e1100b0038cbd19e72cmr1497572wmq.174.1648500429154;
        Mon, 28 Mar 2022 13:47:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm13175623wrv.79.2022.03.28.13.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:47:08 -0700 (PDT)
Message-Id: <1df005a4ef1e387c7f7f5486a7a8800b9cd204a8.1648500426.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1188.v2.git.1648500426.gitgitgadget@gmail.com>
References: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
        <pull.1188.v2.git.1648500426.gitgitgadget@gmail.com>
From:   "Des Preston via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 20:47:06 +0000
Subject: [PATCH v2 2/2] worktree: accept multiple paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Des Preston <despreston@gmail.com>,
        Des Preston <despreston@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Des Preston <despreston@gmail.com>

Update the worktree usage to show that the repair command can take
multiple paths.

Signed-off-by: Des Preston <despreston@gmail.com>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8682ff4c417..498975c1fd9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,7 +22,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree remove [<options>] <worktree>"),
-	N_("git worktree repair [<path>]"),
+	N_("git worktree repair [<path>...]"),
 	N_("git worktree unlock <path>"),
 	NULL
 };
-- 
gitgitgadget
