Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4CC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 08:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386834AbiDUIsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386835AbiDUIsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 04:48:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81EC13DC0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:45:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so5601603wrh.11
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TD13NQS6+Y+JRX+kh11qVSLNZc6Yz6gonk9dewPUx0=;
        b=fqEmnLK9MjaDlAMR/hYzc5Mh6YOx1XPmaAsiwITgthGFzhNo4ECz4MaAtVROgM1Vm/
         gYsaKYQLXPq2ru7p0t6BSRTxtDPxb7IKOPzNRxYme/SdSBqWM3tiWGE/LppHcZo0FDfO
         AUvixGKPkmA4y0QwPD3119JXLAiTIKbpTwl4fVffN8bXRX296TgxsKqmldFLGwdma7Vo
         i1ECOMd+NimCWipqleW1L2aiMAa+PdQthOUpxfDPZSIh9PqMrggXIqs0K3fatgq7iOAG
         JknwO4UE2mW0AdbnX1UoEeQ/TZkIe1WhLAvRH0U4JUmoJI7giNiI+TvAI3XrNRIsbBQB
         8J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TD13NQS6+Y+JRX+kh11qVSLNZc6Yz6gonk9dewPUx0=;
        b=4O3Dw+89r+hYfBNUU+Afz3NBe5v9qCmr7yu726rhzAGyINO05Cvd0sAWcWPIY0DUfj
         q+BvyOpoqy8UHf+5tVyFXncIEYtlQAOeVgKDcaCy8NAABizpgv6I2ZEee+O384x9rmQL
         xwl4w7sV499/rohAaVb7+xZ3eD3uwPETGeBNQplEM1gpd7yQJaR/7LDOJknTSUAX+YIY
         TWTbSD/P9T0hV7su7eTWLyF43rXKwQf2WmSRn1dqly5Y1SY4Yq751zll7vilGUHODKz2
         aHTJ0BBeuM3HCGsKF0dTdbHEG9fgBlHmNapNZHKbS/bCOVXOGoO2ij2jCm018vamYbh+
         yOPA==
X-Gm-Message-State: AOAM531g3fcXJ7TrqFTVnutuf1LHB5CQsux5fxGhbBh0PC3ZI5ZkWdNd
        hxbqZhCqIRJpRJx2PAlQMuc=
X-Google-Smtp-Source: ABdhPJzbBdE0ZWWgp3LYddb/PbH28xc4Fe0llEq2YDjsH8vmcsPknJwOr+HZXBMByvQf6eC1BDQpKw==
X-Received: by 2002:a5d:588d:0:b0:20a:9d79:8994 with SMTP id n13-20020a5d588d000000b0020a9d798994mr12296440wrf.38.1650530721240;
        Thu, 21 Apr 2022 01:45:21 -0700 (PDT)
Received: from desmoniak.univ-lyon1.fr (wifi-ext-0204.univ-lyon1.fr. [134.214.214.205])
        by smtp.gmail.com with ESMTPSA id r17-20020a0560001b9100b00207afaa8987sm2084444wru.27.2022.04.21.01.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:45:19 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr,
        shaoxuan.yuan02@gmail.com
Subject: [PATCH v4 0/1] Documentation/ToolsForGit.txt: Tools for developing Git
Date:   Thu, 21 Apr 2022 10:45:14 +0200
Message-Id: <20220421084515.21236-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqq35i7o3dk.fsf@gitster.g>
References: <xmqq35i7o3dk.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thanks for your review Junio C Hamano.

COGONI Guillaume (1):
  Documentation/ToolsForGit.txt: Tools for developing Git

 Documentation/CodingGuidelines | 16 +++--------
 Documentation/Makefile         |  1 +
 Documentation/ToolsForGit.txt  | 51 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ToolsForGit.txt

Interdiff against v3:
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 509cd89aa2..4c756be517 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -43,7 +43,10 @@ the overall style of existing code. Modifications to existing
 code is expected to match the style the surrounding code already
 uses (even if it doesn't match the overall style of existing code).
 
-But if you must have a list of rules, here they are.
+But if you must have a list of rules, here are some language
+specific ones. Note that Documentation/ToolsForGit.txt document
+has a collection of tips to help you use some external tools
+to conform to these guidelines.
 
 For shell scripts specifically (not exhaustive):
 
@@ -722,10 +725,3 @@ Writing Documentation:
  inline substituted text+ instead of `monospaced literal text`, and with
  the former, the part that should not get substituted must be
  quoted/escaped.
-
-
-Documentation/ToolsForGit.txt:
-
- This document collects tips, scripts, and configuration files to help
- contributors working with the Git codebase use their favorite tools while
- following the Git coding style.
-- 
2.25.1

