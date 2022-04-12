Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B2C433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 23:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiDLXaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiDLXaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 19:30:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEEDDD95F
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 15:30:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w19so295006lfu.11
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzbPe3d5cE0m3yn+nAS6zCYpfksa7mKm7f8jSpnV2Gs=;
        b=muwZ017oV6UIwsa8Pq9d1OVSdP8Y1kMDSwOTpnh0fuwLT4n48Ik7Hv8g48/X5aEd2r
         b6E4NGv9PpF1Y2vN1hVl02gySjfRzxQCWA4TVqTvnDAGs8U1dY7oLzMJjQpgxS2fqLrQ
         k/I+04Leiq/7pWp4UyshSjUrqmyKUQE5QqDLZuFNukxX4pqlBkr8jKDJwIXCMpQGxUQt
         tpCzTaOAVvl7qe9ygg11q8yWJTtv1xYl8DQ+aiYIrVVkeR1YImlSYMbjwe8chd3VWKFI
         fcWFU1YNX76fRRrD9qP69csEyd/HmgCjMD+3nHVay+kUXB9Y/bq9TAMrYUo0L2NAVkrQ
         6CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzbPe3d5cE0m3yn+nAS6zCYpfksa7mKm7f8jSpnV2Gs=;
        b=TxopV3gI3CMxqgYfQa8kkgJO8EWb0uarTSaQyemAUDcMWPNk600PfuR4ecOztxARFn
         JVz+eNIDad0uThu4bq5wjBy2G2VSHdu3E4y16UiNKWQPHhCN1dFFfGOldgZxWes/dtxo
         FTwaff8TWuBHyeIex9k81XGD7k3C9zvUzwhpUN8d1MoLPKz4v+WbgGi3auzQxZNwt612
         W+j8tdw0eDDF23cmf+lF+Y91zSTjSfh1as2y3wW3bcdCzkFE4uvduiwOqaWOCE3pClAi
         EHipJH/ZlX1pjOTtPqAjheVaQgqmHP2297TqGs/O3JvIY2uydK7zCEANKHpNZ4jFU8lQ
         bHdg==
X-Gm-Message-State: AOAM5333yd/t9xNZCvNtLzHkJhfaXO+PuYwR4i2Gjmksc7et3l98XaKR
        VLortsHM4esDqP+cN3LfIw+YgPB5IS/XQxX7
X-Google-Smtp-Source: ABdhPJw6jiThTRH3Y1zKWSgztmc6/VGVmcD1GtqFfec1ZY2CBi/IIzagxiekaCQC1b9c11RQryh0qg==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr31211937wri.39.1649795172014;
        Tue, 12 Apr 2022 13:26:12 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm29491705wrw.91.2022.04.12.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:26:11 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     git@vger.kernel.org
Cc:     Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        derrickstolee@github.com, guillaume.cogoni@gmail.com
Subject: [PATCH 0/1] documentation: guide of best practices for GIT developer
Date:   Tue, 12 Apr 2022 22:25:56 +0200
Message-Id: <20220412202557.32101-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This patch has for purpose to introduce a file where GIT developers can share
their own best practices, tools or workflows to the community in order to
help the GIT developer.

The discussion about this idea begin in this thread:
Message-Id: <20220407204001.112287-2-cogoni.guillaume@gmail.com>

Derrick Stolee and I agreed that is can be a good idea.
And, I think, it can help a newcomer, but not necessarily people with a
lot of experience on various projects. But, we can give it a try and
see where it goes.

PS:
I do not believe it is a good idea to give detailed tutorials because there
are a lot on the internet. However, give the reader pros, cons and curiosity
to test those tools, practice or workflow can be really good.

It's better if the tools are open source and free, but it is not mandatory.

Sincerly,

Cogoni Guillaume

COGONI Guillaume (1):
  documentation: guide of best practices for GIT developer

 Documentation/Makefile         |  1 +
 Documentation/WorkingOnGit.txt | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/WorkingOnGit.txt


base-commit: ab1f2765f78e75ee51dface57e1071b3b7f42b09
-- 
2.25.1

