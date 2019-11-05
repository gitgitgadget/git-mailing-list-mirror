Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5401F454
	for <e@80x24.org>; Tue,  5 Nov 2019 16:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfKEQF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 11:05:59 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38494 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390047AbfKEQF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 11:05:58 -0500
Received: by mail-wr1-f53.google.com with SMTP id j15so1390063wrw.5
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c+C9mZRnOOxEuzpRmrjYstKoenMU3ank2vxnpjQoZKc=;
        b=O6tInoA98xS0VLYfu2lfVOw6lHGS7cyAVxrCZOXdMooB9U0IzZjPE05Dmt7GlRLG/8
         kpbLxlRBWqGx9wWMN8Q+wGHPyDGBLz7Ixj2Dp3BH9kgIblY9+TNpmGR0/BjTzW4/2xnE
         UUzTOyqwIOCy0gZEOT510z3jbcSIUjqGR0UObJLf0fsqsVBCqvurZ3EaV//ytelDM8tV
         TZ9R7D2VDvNKN6FjKx0h9nMvpaInsnaqdXJRFf6wyghxofkDg45a1ZcZXIlki0jXxibx
         2d2Ak3qvXinv8AHcrcg7GxvsCiWZN58Tq7H6lsNdGLV9R3YcGGmKGeGDxI4tjahV1IqR
         T1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+C9mZRnOOxEuzpRmrjYstKoenMU3ank2vxnpjQoZKc=;
        b=c86c4jFJzA5svN7UJKjKM9IcfFpCxgUkHw35j16B1efqo7LZ1m0UKxtqNGERry0mg9
         cE//gSpJtO2d24W6sWxehWOIitsIN2dE0ftO/3YbpmiiNRkEpvg//k0/j3ACn/KdbWvw
         aXSe0vLFwDQvXwB++OJst4UHRABTvc72IMboHv5ikrkXQBe/85/MvjBhGYucWJ8rRa69
         Vm3pQE/IrR7HPME9fNWjAROarASD33WgEHYsn0zWcR4/c50q4vDU3h6BFdmbYiDPVGuM
         xEXHEFUGCUVLWVz3cZeScjnxgtMzDS2VhQ0huj8utMZOvXgdvOWw9y3jwsJ/MPzyadRT
         mFUw==
X-Gm-Message-State: APjAAAU9J+uBN/LzQ/VtkxMemweLdphOeYmxOczBJjwphzEyl2vfHzha
        4qEYr9GPvx/VIm+4rKhwLI46jM4s
X-Google-Smtp-Source: APXvYqwPAIvo7TMPuMWwcLhESkiV6+ikTjDc4nCmaYFQ7AQvgrslCkMtHGECMcr87AoKQSNV7Ge0qg==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr28723323wrs.343.1572969956138;
        Tue, 05 Nov 2019 08:05:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm19151644wma.43.2019.11.05.08.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:05:55 -0800 (PST)
Message-Id: <pull.450.git.1572969955.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 16:05:54 +0000
Subject: [PATCH 0/1] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Ryenus, for reporting this problem.

Derrick Stolee (1):
  commit-graph: use start_delayed_progress()

 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-450%2Fderrickstolee%2Fcommit-graph-progress-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-450/derrickstolee/commit-graph-progress-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/450
-- 
gitgitgadget
