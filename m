Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE8C207D6
	for <e@80x24.org>; Sat, 29 Apr 2017 10:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166588AbdD2KrT (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 06:47:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32860 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162723AbdD2KrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 06:47:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so9384791wrc.0
        for <git@vger.kernel.org>; Sat, 29 Apr 2017 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xarg-org.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=RK5vCSqvnjetgGaHhRxNXpw1z7tytZD9uWcFL63y8XM=;
        b=kUOgSB36w9hJo3fe5sF8/985lGlViUFO3jaMoZdvixR1ff2PR3BDB+ko9oBiATmSvV
         9aQqR9oaQLOiHHutASWgSGGxQbiNQTtZZsjN/pg3ZOLx6u4mTsUZ+k1rd5M0Xpfjy4W1
         nh7bVMCBg3RMyh4C+onH9Hmpwdc35lgb0tkwm71IFwWlwKz7Ncfc8qkxu0bFuFBKpgGH
         w6+cGfBNcUialnYhXdsjjpvGhdOxoxpuLGHCwKD/NhddMVO9voK5B/QOWlsIi6AV1nyo
         oXEyoKYuIe5Bgw9zIcVxQcuL2anBdeHflz9gKTY1UH/Dgc5ZkExHJwZTV20m1pRK/BwZ
         3uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=RK5vCSqvnjetgGaHhRxNXpw1z7tytZD9uWcFL63y8XM=;
        b=q2ebs6SD2wluB77A8jQXuf7xPZtc+F9b6LkT1vuKt2OGO7TieNH0sLS9GR0DPvdRAT
         GWncWe09qTar6wDonzPmREVxefkwaoQyHLXgozIrI4Frm0FgHUD8la8FEAA+MTljQxeM
         8eFI7/iIQ0eV9RbuigbWA2U4q6SoX56JRiL8scQLHZl5F20zZTWXcc18Xg+BdVqRmYqE
         QuzT+Rvwp6rkIeGySxDmU54gemTe4tcq9nOQMTL0ZmNKV0CJqQ/FD6eazDxtMpGrnaPx
         24QFqb1z8fBsRoE1qkQYQiQO4iTb3ng6CpNLHH8BPaUU5qv/TXRJb5RdFe0gPmOIWbyJ
         7f3A==
X-Gm-Message-State: AN3rC/5e0sXjWSEjGDm/J46WxHPA1AhWQu1qykqdU2QEmqndm+SkVkCN
        lWndoRfebsHz4gWUwbs=
X-Received: by 10.223.130.104 with SMTP id 95mr10443110wrb.150.1493462835731;
        Sat, 29 Apr 2017 03:47:15 -0700 (PDT)
Received: from ghostship.local (HSI-KBW-134-3-57-106.hsi14.kabel-badenwuerttemberg.de. [134.3.57.106])
        by smtp.gmail.com with ESMTPSA id y16sm10426923wry.46.2017.04.29.03.47.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Apr 2017 03:47:15 -0700 (PDT)
To:     git@vger.kernel.org
From:   Robert Eisele <robert@xarg.org>
Subject: Bug: Git rename does not work if folder naming was changed from lower
 to upper case on OSX
Message-ID: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
Date:   Sat, 29 Apr 2017 12:47:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

after having committed folders with lower case naming, I decided to 
rename them to upper-case names. Expecting git to detect them as 
renamings, it started a new parallel hierarchy with new files, which I 
had to add/commit.

It was a kinda strange behavior, which I fixed by rename the folder to 
something completely different, commit and rename the folder again to 
the desired value.

Is this an actual desired behavior or is it a bug?

Robert

