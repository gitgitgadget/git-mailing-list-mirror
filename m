Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1911F404
	for <e@80x24.org>; Fri,  2 Feb 2018 16:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeBBQBw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 11:01:52 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33654 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBBQBu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 11:01:50 -0500
Received: by mail-wr0-f194.google.com with SMTP id s5so23033450wra.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs0BqK2hYjR2/ngtPfA74GdwvzDz13HUgq/xfTRLpdk=;
        b=XpZ/jc9oRnY3rdAjTnve+AHcZm+fGFPZwxNRauzU6we6NL0XWXrui868LeDa1x4YgK
         VAOJP+JukTeb7raclVMnVg8+7bSF4/RWcKo8K6UdpDm5ATfDMxi2Aa6AW7aHCWVMBS/q
         2yy0tv5OpRILHGU5CfaG7x37tdDiRe+dQDLMJ4JC3dcU825Y4zQkeGg8Q3yQiE4qLQfd
         1E/RPzanvpspV2g6iy13rvtcAgZXQTb9B3suvO1aElQz8Y8wFoYtDH4CRkFOWcuDsv3X
         rKX1COYKCFbFBDeps+lZEY15zAb3hVo4xZQfX9FjUUPztssjciPjBCMhiG8+wPz5+bSY
         VrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs0BqK2hYjR2/ngtPfA74GdwvzDz13HUgq/xfTRLpdk=;
        b=hg8ckO/So7La+ykFK58CA+YS42AYXBLW2QL/kz7S0f2FDGKFjOOMGaNFdOqBPKYo30
         P9cGY8scMVdmeoVwR9zRLD28To1JPX2MMRPZuTkc/dXm6azQgTZPSFkG/zfG9f45wfPf
         xUxY9ci1i1/JdcfFqmQ5gX1tL3PHTbezv/ZImGUq6ZEUQ6s8yoPL5jnRVsE+kosnDGpK
         J6pT4xLKMeU/pctz+/0MByXvjYDLMQRK8CDByGhqkSXahcuDWfVCEynh1rylCG22Sgcp
         VpJd0blCYHXFLBM5MlLYAZvbEhUYGhxly4yyOp89ErTV+AbBGpSS/PUQy1XjdkKRFaBy
         O5Vg==
X-Gm-Message-State: AKwxytdJFh6FOMgWkrgDctBIsvKhN9RfDaIPVDiSj2B1tVjNT+kq4xKs
        FuPC8IbwpEBRSA2RhvGYD1o=
X-Google-Smtp-Source: AH8x227w5GpQbswk894uls2h2130gTCZxjz2iNbLxrDSDbRgks0Lzg2Nh3Bk8sODPbh4rFGbPctpeQ==
X-Received: by 10.223.139.131 with SMTP id o3mr5471962wra.279.1517587309530;
        Fri, 02 Feb 2018 08:01:49 -0800 (PST)
Received: from localhost.localdomain (x4db2a0d5.dyn.telefonica.de. [77.178.160.213])
        by smtp.gmail.com with ESMTPSA id j31sm4029931wra.97.2018.02.02.08.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Feb 2018 08:01:48 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 10/14] commit-graph: add core.commitgraph setting
Date:   Fri,  2 Feb 2018 17:01:32 +0100
Message-Id: <20180202160132.31550-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-11-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-11-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The commit graph feature is controlled by the new core.commitgraph config
> setting. This defaults to 0, so the feature is opt-in.
> 
> The intention of core.commitgraph is that a user can always stop checking
> for or parsing commit graph files if core.commitgraph=0.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt | 3 +++
>  cache.h                  | 1 +
>  config.c                 | 5 +++++
>  environment.c            | 1 +
>  4 files changed, 10 insertions(+)

Please squash this in to keep the completion script up to date.


  -- >8 --

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c..53880f627 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2419,6 +2419,7 @@ _git_config ()
 		core.bigFileThreshold
 		core.checkStat
 		core.commentChar
+		core.commitGraph
 		core.compression
 		core.createObject
 		core.deltaBaseCacheLimit

