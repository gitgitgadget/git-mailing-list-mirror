Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1C721841
	for <e@80x24.org>; Mon, 30 Apr 2018 09:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeD3Jek (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:34:40 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40013 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeD3Jej (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:34:39 -0400
Received: by mail-wm0-f48.google.com with SMTP id j5so13192310wme.5
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pj31xkeyuzYCyfeuRyHRpSM7GKxqd8WueYxIJi+FibE=;
        b=DZ4bFdz66K6rT3LmrVpPpj144EyaC0VRrNnK8M6l0XzM4HvAJLd6rMs/VXnbYkQ18Y
         AOBa9+iVWL6DUqJWHCMKuDcrEr7s/1r+7fC1erZ/i9eQtdex3Zt/6OwYDYg4KJzrDCo/
         jRnxaekg674H1QpvtpjkYjQ7tDnjm2xWGB+ty9LGTw6O0ouckLkT9NSSYsdVLM5Fcs06
         p7wF9GkYStFgAoHE0BQ0RxWJ8THEyfDnZUeidYq/ig6OJkKoaUDGufJh6mn6KT4FCnB6
         KVEhAJjwatpRM6IuQI2DU+/W9KmKw0BF33GI2Ipjlh30BIaB8cCRkFD6frK5ffa8RBzu
         Y6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pj31xkeyuzYCyfeuRyHRpSM7GKxqd8WueYxIJi+FibE=;
        b=fKVjnPf74ZvM+KSpNDlhNFP3epeWmcXogzAIuEYRXBnOiiHkqZnSmoDLNSm/PeNoK5
         pXVfKQNn0fASuqCIqDMjwUIfLrzD1uCICMDOC0kXvPeNytdrHXZ8VoFF7VNPM5RIKhor
         /4F40esW2f1lMDK/rpzlhMqykGme+0d4w/YGw9U8VqSNoVo8gnzOgK+iWJiIwLT7nvao
         2tqqSpRTxUOQq3iz7/RhnRdBi0eNoPEg+SOxQP1iSGzAdNuaBaw0EUA4MagQuAnkbc8C
         euFwM8KA59MvUC7N5c3y1HyT6JVCedEAlOChob9zvzSuRVqR3xx+CBFAEr+O7hF8aBWS
         P+9g==
X-Gm-Message-State: ALQs6tCYzL+K/OFJSCPYs8M5l4bF3c35KLTDvx47d1/2X9yqLUooyr1N
        8c2dKc6Mnxjjc8FIcsGJR4g005Kq
X-Google-Smtp-Source: AB8JxZoeDfhpLqVfXugBC15Mchcfy95Mcl88zCeu8TbUZa6jclTMZ5W3PUSg3i2cODwBP7LnYUvkZw==
X-Received: by 2002:a50:e60c:: with SMTP id y12-v6mr15634644edm.278.1525080878208;
        Mon, 30 Apr 2018 02:34:38 -0700 (PDT)
Received: from esm.hitronhub.home (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id w26-v6sm4104698edq.77.2018.04.30.02.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Apr 2018 02:34:37 -0700 (PDT)
From:   "=?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?=" 
        <eckhard.s.maass@googlemail.com>
X-Google-Original-From: =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Subject: [PATCH 0/1] Use the diff.rename configuration for git status
Date:   Mon, 30 Apr 2018 11:34:20 +0200
Message-Id: <20180430093421.27551-1-eckhard.s.maass@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have been irritated that the output of git status does not adhere to
the same diff settings than the other commands like git show. I think it
is more of an oversight and git status is also intended to show the same
kind of rename detection (without any more options passed a long the
command line) than other similar commands do. This patch should fix that
issue.

I am aware that this change would also change how the porcelain
variations of git status behave for rename detection. However, I could
not find any hints that the rename detection should be fixed. As the
default would not change (50% rename threshold), this still seems
reasonable to me.

As for documentation, I am unsure what and where to add: for me it seems
like git status should already behave that way, but it is a change and
so far none else seemed to have brought it up.

Greetings,
Eckhard

Eckhard S. Maaß (1):
  wt-status: use rename settings from init_diff_ui_defaults

 builtin/commit.c       |  2 +-
 t/t4001-diff-rename.sh | 12 ++++++++++++
 wt-status.c            |  4 ----
 3 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.17.0.252.gfe0a9eaf31

