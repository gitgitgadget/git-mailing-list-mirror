Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E92C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiKJQGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiKJQGI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:06:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955862B276
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:06:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p12so1745628plq.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EbbApUpHWyAvGujvJnTqaSdeV1yy/fWzYqMGNWEwpZc=;
        b=QICT5GGyJUEbEGydB+SoNKs9xGdZ0RXcUn545B3HhDB1x1PGBQ/ZbOhGSXVlVdE+G/
         j6FbldPaMx3cZKz+t7tI/OY/pThEZC2GNj6lFXLr897zqwkZskjrW+s+xnMm8LfLwrbE
         wPFIIOuRoCOUjMG9gDQLkDWuLcGGVYjfV8C41UCjLAxJiLvODlclSy8GsgRZiAA4KEQi
         NqcWR+4mS8j6SxT4RR7aVk3LQuFfAwjdwqDumXJNMRLYlb2b08p0pODEZb/a8kIxAsxg
         lGnwFrg9etlDMEKw9yG71tmrhPHkWoGEmt7TpAJvmeE5G95ufJKnwqSsCVRngkNTbqmP
         2VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbbApUpHWyAvGujvJnTqaSdeV1yy/fWzYqMGNWEwpZc=;
        b=EbCzkfOnZwMKhTNY10g/XTg4MMuKWqoB59p/iGz03Fdgm6M1kfK1pjWpOw3yQm/2E1
         oV2yiGofnQEyC6MS3uhTx4oLDjhv+unAB3EB/i7lih/Lhn4BjR5PE+mkzesgJoTXOAzJ
         lrSFz00+GKUPdpiQBHeTNV785RPLRgCMgkPZTbE+y4mP0JL/WIbauu5PWRMYra37tTJO
         uYz0w83PqzSWhCWhkM4jknjxhicak9SCjtQVmCsaAc6DY8gjAM2P+eoU9IDEbSYyfUNK
         gZSjS6rIBKD4XVihYEL68nx92WfLcDd4H0u137SNGInQxcv5+nFKZW6ogi1nbitkAgsp
         vokg==
X-Gm-Message-State: ACrzQf2TyeoC9APXSs6owvVSLr78wvGsyzoEHaIs2pNxZYPcmab+Mcby
        CRUrkQ5y4KVMhJj6iYXkKa1T89FjQBU6lw==
X-Google-Smtp-Source: AMsMyM68Yx9xGzKOeQIYp0EuN2FYwgFl74R/TrhoxB5aI91sq/641ZhR+bdAtxGSV0UJsZaRjlQkPQ==
X-Received: by 2002:a17:90a:3cc6:b0:211:bed2:8926 with SMTP id k6-20020a17090a3cc600b00211bed28926mr1390875pjd.106.1668096366739;
        Thu, 10 Nov 2022 08:06:06 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.47])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b001837463f654sm11453842plg.251.2022.11.10.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:06:06 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] repository-version.txt: partialClone casing change
Date:   Thu, 10 Nov 2022 21:35:56 +0530
Message-Id: <20221110160556.29557-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remotes are considered "promisor" if extensions.partialClone and some
other configuration variables are set. The casing for this in
Documentation/technical/repository-version.txt is not proper and may
cause confusion. This change corrects this casing.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/technical/repository-version.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 7844ef30ff..8ef664b0b9 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -82,9 +82,9 @@ When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
 
-==== `partialclone`
+==== `partialClone`
 
-When the config key `extensions.partialclone` is set, it indicates
+When the config key `extensions.partialClone` is set, it indicates
 that the repo was created with a partial clone (or later performed
 a partial fetch) and that the remote may have omitted sending
 certain unwanted objects.  Such a remote is called a "promisor remote"
-- 
2.25.1

