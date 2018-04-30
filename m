Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E36821845
	for <e@80x24.org>; Mon, 30 Apr 2018 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeD3Ju6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:50:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33641 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeD3Ju5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:50:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id o4-v6so7440672wrm.0
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWx/KS850dPV08a9TShJYYPuLnBDgmnBxRkWCk9LsD4=;
        b=BDGst8vkZRI2qhRitK4yTIWFGzvKE7iTyo2F+Zwt3EFfkpZTcb2UmVxOE9MohZp9k5
         6CYxVOFM/q77ZKhMJZqb7sNsg1GYY3C0uV1BVWwzJ9CQNan213d7Pgv9cv0IDEpmHFPH
         Jwa+M7xauHzE2w1Y0mao2AzFoLXGMAUk6oBzhFlk/ME5rDo8oEpkW1qINk7pRgAYOFFi
         MMyTAq4+hDzZSh7Tl7pJl6HlP7Z4BSatlW5fhra0JHImAFcQDTSQpj9XRIiRAjcgNzKt
         4B9s90a8qP/W8uN/oPR78uGDj1AxVBIRMgvyzDGKlgW9HrNcjfSK6r1YcNO8QVCkija7
         zhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWx/KS850dPV08a9TShJYYPuLnBDgmnBxRkWCk9LsD4=;
        b=CV4Nd8+uLkgFyDps4tyFqLjCv3IKdWWYuM3zHLxozQAgr6AE2Kr0T4rmgF20QmxOaZ
         aUzv5821llbHlaWvqh8NYwMwD9jk4zsuBCRQs191t5VrJrJy0a5tXjSHEOQs1Ijl/qJq
         FvGK//V6werhejaC1m4XpLpOwok7lZ5lnEnmgwJJPrwMzFzqkVNs5BgKlFq5d0y7Za4c
         JcJON7sIYR70A+YSfwSB6KTaQ80cWJ5yz89q12ieJ5GWvlxRWWZsym6TGT1wgBL4Nyk4
         13Bf2/39lr5/DUjRpxiHqSE21ViaXgLVtZIoes4C3WMyod2LUb3ooCMw4SZn3G3hDbhR
         W8RA==
X-Gm-Message-State: ALQs6tC/eUGK8Srs3ADD5z0MrMPyA1cX2hxJJA9Hneohnfo5LaOwQFul
        BcRx7xpPcyVP+7MG7AsvcJPklMNk
X-Google-Smtp-Source: AB8JxZpaOOFi2xWLklllssPqKesmvRevFKZrPopP28CumWc6wVinwfpKxdmtsEb92lFcg9iBTCY5dA==
X-Received: by 2002:adf:9287:: with SMTP id 7-v6mr7932587wrn.67.1525081855477;
        Mon, 30 Apr 2018 02:50:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 42-v6sm13178687wrx.24.2018.04.30.02.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 02:50:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] subtree: move out of contrib
Date:   Mon, 30 Apr 2018 09:50:40 +0000
Message-Id: <20180430095044.28492-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think at this point git-subtree is widely used enough to move out of
contrib/, maybe others disagree, but patches are always better for
discussion that patch-less ML posts.

Ævar Arnfjörð Bjarmason (4):
  git-subtree: move from contrib/subtree/
  subtree: remove support for git version <1.7
  subtree: fix a test failure under GETTEXT_POISON
  i18n: translate the git-subtree command

 .gitignore                                    |   1 +
 Documentation/git-submodule.txt               |   2 +-
 .../subtree => Documentation}/git-subtree.txt |   3 +
 Makefile                                      |   1 +
 contrib/subtree/.gitignore                    |   7 -
 contrib/subtree/COPYING                       | 339 ------------------
 contrib/subtree/INSTALL                       |  28 --
 contrib/subtree/Makefile                      |  97 -----
 contrib/subtree/README                        |   8 -
 contrib/subtree/t/Makefile                    |  86 -----
 contrib/subtree/todo                          |  48 ---
 .../subtree/git-subtree.sh => git-subtree.sh  | 109 +++---
 {contrib/subtree/t => t}/t7900-subtree.sh     |  21 +-
 13 files changed, 78 insertions(+), 672 deletions(-)
 rename {contrib/subtree => Documentation}/git-subtree.txt (99%)
 delete mode 100644 contrib/subtree/.gitignore
 delete mode 100644 contrib/subtree/COPYING
 delete mode 100644 contrib/subtree/INSTALL
 delete mode 100644 contrib/subtree/Makefile
 delete mode 100644 contrib/subtree/README
 delete mode 100644 contrib/subtree/t/Makefile
 delete mode 100644 contrib/subtree/todo
 rename contrib/subtree/git-subtree.sh => git-subtree.sh (84%)
 rename {contrib/subtree/t => t}/t7900-subtree.sh (99%)

-- 
2.17.0.290.gded63e768a

