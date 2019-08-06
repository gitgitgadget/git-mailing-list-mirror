Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D571F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfHFRjt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:39:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbfHFRjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:39:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so38154561plp.2
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdFFnx5JPvU6KcQlQclfe3lDh4RhaNXhCV4LZq2F2Xk=;
        b=UYCTKeNvBUHIgkAGgHcMqWG/YcX99xabq8s445V6EBUr96VKdT5vgb5YNx7Cczk9K5
         jwbBAB4BRM2LYxknYA0jQ1gcO3fB/Cp5OVsrZokSeI5WOO/yBjaP7sx8VLXeT6ns6OvV
         NyRWdAd6KeSRf6hrgMogSwD39t4Dq/1gMO6pvArFih5YjMYVSuE7qlbtMlkWJghga7LB
         l8VQV4QfeX6MxaEkocoFsHA1aUuY0BPU/okO+ZObQmcj87wZ5llMht+mCrTxGQMOzl93
         aQKedbu3hFHqVNAOHNdA/IjeiHGErIwRPX7djqr0ZOvaJ2ZVRULQgH3DPU7OEwE6crl8
         HwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdFFnx5JPvU6KcQlQclfe3lDh4RhaNXhCV4LZq2F2Xk=;
        b=WMVEkVxTZ5UI9v242A7LIW13CX53/MveNLFY8mZVfKMlZF3zU1e8O+n9YuYJON7YcR
         4EPXFPdpHSaaywRdIXy+HWJ8e+PE+zh1BHDTdOV4x0M48oP7H4qtKhDboP8Dgxu5hOtB
         10yT7K0ookJcyBAua0+bX+h0EWA2GF/Yg6D429aSAiItRCxCm2iDorxDOVWfVhtoyCye
         64v5+WmYcPHsaxtyCEXMWjL06MG28VJWx45FJz6GKaAbAAmJkAxBGqfOwS+RL6612udt
         4HmUsOyIVLwbw2EP/KFBH5d+8gtbU6XI5IF7b2uPM/wp2FazNGQZsrRDy+HbYEUquFNo
         pvAg==
X-Gm-Message-State: APjAAAXeL/SFMazTbsIZE5GYCrbbL1E85YlaRC2rpFQE1CmL+cTPS24z
        BG7ir/8U2/wNPxAH14dGw9k=
X-Google-Smtp-Source: APXvYqwR9wczzhr7xEO9pdR0sVZjy1YDnRElAXPjNv2IA2ELe0dwqPRKWSLEIlXpyTABpNqT2LLb2g==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr4178264plr.159.1565113187995;
        Tue, 06 Aug 2019 10:39:47 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.39.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:39:47 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 0/6] rebase -i: support more options
Date:   Tue,  6 Aug 2019 23:06:32 +0530
Message-Id: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous versions of this patch series were sent here[1]. This patch
accounts for all the suggestions mentioned there and also introduces a flag
--ignore-date (also aliased --author-date-is-committer-date).

Caveat:

        The flag --ignore-date (of rebase -am) silently overrides the
        --committer-date-is-author-date flag. This behaviour is not actually
        documented. I've made rebase -i to replicate this behaviour anyway.

Thanks
Rohit

[1]: https://public-inbox.org/git/20190712185015.20585-1-rohit.ashiwal265@gmail.com/

Rohit Ashiwal (6):
  rebase -i: add --ignore-whitespace flag
  sequencer: add NULL checks under read_author_script
  rebase -i: support --committer-date-is-author-date
  sequencer: rename amend_author to author_to_rename
  rebase -i: support --ignore-date
  rebase: add --author-date-is-committer-date

 Documentation/git-rebase.txt            |  23 +++--
 builtin/rebase.c                        |  59 +++++++++---
 sequencer.c                             | 114 ++++++++++++++++++++++--
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 100 +++++++++++++++++++++
 6 files changed, 271 insertions(+), 29 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

-- 
2.21.0

