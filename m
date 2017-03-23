Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9585020958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935064AbdCWPiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:38:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34597 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932453AbdCWPis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:38:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so17310323wmg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWZK7tLbXZFWghm5YGQc/n2EUlOCRNdeLbnkuk2f5jM=;
        b=eRhms/V2gYN91LsMR3ADDe3k2deNai08p/3LEIy3F5q3Dn6XsvWutcLLuL7Zd9hVjD
         pYFbcYN50X4ApvhF1BgNuYu3bw6Qb5ziu+3/Lkn5WBjFm7x9Ly/I+hX3JonrOibS2pMK
         N3TiD8eCgmYbhRO60y8Zz//1665f/TOb21XNWMBl1XMfK3eKXXk0YDhHXoaecraaALUV
         UCDEayNzV9Hn7ikPUry4dvTNc/CjSsssBRQiTSqj3Are5gfum+MYT/TlVkgeYcfSfqi9
         s5txqFJ+PvkVEnAaLjDmplnzhLz9mnu38MqW6tH2KEgcvMC5D5Fsgke0d7DjjmRxu1zR
         Tyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWZK7tLbXZFWghm5YGQc/n2EUlOCRNdeLbnkuk2f5jM=;
        b=N9JODU/0TG42i42WpkE9dBIhckmpiXsh/VJovui2qnb3pBaR5IlqXQC5N5w6whzPg2
         VD3YWJ/xsFnsnB9/cd8C2F9VXMh6vWmJ42O+Ufy8GPmysXcIkbgI55Qq6U6MzWV3ZMcB
         lMM9Xf//BgFYaQZZlc5Ge9OWf35QvwDAAC7dxicXhjIOxjRW2qdLROuFBtM5CL1N1mWE
         9c93TUZmSMQF2RoJWegE84dIaVPEKYSs2GYR2bi5OUOhdfpsralMWuFFYIPnHXHaTOEe
         YFAnWsmrOoq60lecCE3wk8D6itwj/EO1/OCZdh4QSCigyFpULD3TvroTIo+O3OqIGsK+
         oz+w==
X-Gm-Message-State: AFeK/H0j1gLCSfIPpHUh6wJCzuSFIvH4mgUzqh8zkfj+5CxFhMb2/CnV/yGXCVFgQKZdow==
X-Received: by 10.28.199.129 with SMTP id x123mr14252687wmf.7.1490283526117;
        Thu, 23 Mar 2017 08:38:46 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id b13sm4793766wmf.6.2017.03.23.08.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:38:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] completion: updates to ctags symbol names
Date:   Thu, 23 Mar 2017 16:38:36 +0100
Message-Id: <20170323153839.24283-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series 

  - speeds up the completion of ctags symbol names by using some of
    the trick from the refs completion speedup series, and

  - offers symbol names for 'git log -S', '-G' and '-L:', which I find
    really convenient when digging history.

It should go on top of 'sg/completion-refs-speedup'.


SZEDER Gábor (3):
  completion: put matching ctags symbol names directly into COMPREPLY
  completion: extract completing ctags symbol names into helper function
  completion: offer ctags symbol names for 'git log -S', '-G' and '-L:'

 contrib/completion/git-completion.bash | 72 +++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 6 deletions(-)

-- 
2.12.1.498.gded7ead47

