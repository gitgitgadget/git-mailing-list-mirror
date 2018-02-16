Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324D31F404
	for <e@80x24.org>; Fri, 16 Feb 2018 20:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeBPUpb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 15:45:31 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41558 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbeBPUp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 15:45:29 -0500
Received: by mail-io0-f196.google.com with SMTP id e4so5405787iob.8
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 12:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Ug3LBKQpzDX7MGF3fTPcQGMJetk3C4wB19Ufh1YfHPI=;
        b=nQBTg87efT9CBpGV1i9aV4QDPgTaFNc1Xa4atfhOZfZIbL5f8nsfwNSKhT6YzygIxr
         0EFrLE0O1uKDwevL0mu9t8izbXVgQbWfZuSLJyFq2HM8/BGZw+oWslfvHvQ/YtCsuUqN
         Z/mKpnh5z2Phsu7Plrmca9Vbc1lWedLn13A9yBS44pxv2Evf2RkHSFNEly92ZEjptFsu
         RHaYNmLjp0PLhHDupOioZeReObuo/pXuLVArydnKsKJdX5Vw0+t35JN4Z49SoyIhsWaS
         arNpW7QowvmXBCz+n/NvQthEfhJA8u+nrEQZEVN5xQYAbWQle87IU3A1S+ooA5og/35s
         joMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Ug3LBKQpzDX7MGF3fTPcQGMJetk3C4wB19Ufh1YfHPI=;
        b=JMsKHv+OKJWJpweshS5CeF4Uu+qduDEK8s8fyuaJ/ulzXZARvgPQrPMdx4qY6ZPl3m
         z+pnT5yKO7AOFeRCloQCRjcfiM4tMDyhsvT96tG0jBR2FbE+BwYk+gjecVicbGumLXdO
         m6ZfkE7t20/Om7gE2IHfP/Tt6NOzdnV4X3lKuosBPU5yM1MT/q+YsrPfxaLyQKrnuXJv
         M48nlylAWicQBztNDDzdWLXIwuEJMPugQ6UfAEU55URxnrQQ9tuHq6zeQSYB1p5mSfRc
         rtZlfEDI03IxwSivJpfk/JshXLKW64MNavRQMUCWEPTvBTdY1YJSw3eBZxU4JCjm1kNK
         b90A==
X-Gm-Message-State: APf1xPAgdQhuBs8maXuzyZOa7jN9vC82IJT7IhAMlAuZUxZ1SojZUKkG
        ccvfv3RrsuhqKvM04UtrCJzUMg==
X-Google-Smtp-Source: AH8x227qb4Zm+ptZi/3IZqvqKpVtzEzMcZCCovl0j+ScKSlDXL+NmRhwWSzzHAU0lE5hxryKBnHJxQ==
X-Received: by 10.107.164.134 with SMTP id d6mr10032119ioj.176.1518813928450;
        Fri, 16 Feb 2018 12:45:28 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id z75sm2541844ita.3.2018.02.16.12.45.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Feb 2018 12:45:27 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Mike Nordell <tamlin.thefirst@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] fix minor git-worktree.txt botches
Date:   Fri, 16 Feb 2018 15:44:50 -0500
Message-Id: <20180216204452.2153-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.374.g7648891022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes a couple git-worktree.txt botches from
4e85333197 (worktree: make add <path> <branch> dwim, 2017-11-26).

Eric Sunshine (2):
  git-worktree.txt: fix missing ")" typo
  git-worktree.txt: fix indentation of example and text of 'add' command

 Documentation/git-worktree.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.16.1.374.g7648891022

