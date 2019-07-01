Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DF51F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfGAOVI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:21:08 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45832 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGAOVI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:21:08 -0400
Received: by mail-ed1-f49.google.com with SMTP id a14so23811486edv.12
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7We74uxO2psLDBdc8BMSdfizZ860tbpamNJEFok1dME=;
        b=RpCKu9KTYF3s6/qzVyqixh9wkac5W1rZ8/N8oJ9baR6MUs+27zy+yOHDFElhoCiemA
         pDwGgh6OF0rFO647A/3yH1f/KQ5PGXzPNjZ48EUoYYhPTGvfEq5zt01ghXVo4DDuJ2Jk
         gsl2LlF5qGek7Fr1JOE06oDbeobeir6UaSzgkaz9JJ3rO6/vB2d1sBTzy4d8/DeJqVoR
         54X1NVbkHHCBiMXPN9e/NjPwa0ZjIl2ur/5YuRLGk9GqjvHI62sKQy1sFiov0EURNq9d
         A0jKP/ApdpeSKVVBthVlzraCtx7GwtArebovTU8w5xIQIvoSifItS4XocEbqIOBm2TmG
         KT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7We74uxO2psLDBdc8BMSdfizZ860tbpamNJEFok1dME=;
        b=WEpVGnjd0jr7DkZGjlL86WD6oBE9s0TDk5wDVbhOvT6PdgEOYMiAoThmqZwc2jdLEH
         rx7QNrNZsZX4TxCHs9LiIknmHnjDPAcpftEmM9gBPgY7mmTwy5+8J9PSNCHdo4nqXzzh
         ZEsw19VBsMEMofaRX40yPUwDHv4Z5zpiiO7OpcEBRTQjmBukt5LVmNcRq5tXElAa4cUe
         GRZqk3ab+22jp39mGPlhtLAVuhNnuBXccCOeXWivj9blsnLvcDXekSYts92GtPFT7KWm
         Vuvs+22E1rEdoBV7z87EKtspJCLDvc0HpgGn52VUNW830ZGY/Fb1rYE0DVgn8FOARTdB
         gE+w==
X-Gm-Message-State: APjAAAXzg+OyLiuF9j77MyLsnfEK0Qoihv1mq1OCHL3ekHJxLYblG8mq
        db0oAD3WnPIXOLfhEP9dn8mdzVQT
X-Google-Smtp-Source: APXvYqxQ6p1euFr4z6GaXDPbAXvAeEmpIUE+XYm6hbtIjeZQKMkmFpB1hjXuTv9t/BGUBXr30DLCoA==
X-Received: by 2002:a17:906:fcb3:: with SMTP id qw19mr23507064ejb.286.1561990866541;
        Mon, 01 Jul 2019 07:21:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm3645236edc.89.2019.07.01.07.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:21:06 -0700 (PDT)
Date:   Mon, 01 Jul 2019 07:21:06 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 14:21:04 GMT
Message-Id: <pull.281.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-prompt: improve cherry-pick/revert detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the detection of in-progress cherry-picks and reverts when the user
commits or resets a conflict resolution in the middle of a sequence of
picks/reverts.

Phillip Wood (1):
  git-prompt: improve cherry-pick/revert detection

 contrib/completion/git-prompt.sh | 37 ++++++++++++++++++++++++++++----
 t/t9903-bash-prompt.sh           | 20 +++++++++++++++--
 2 files changed, 51 insertions(+), 6 deletions(-)


base-commit: 8dca754b1e874719a732bc9ab7b0e14b21b1bc10
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-281%2Fphillipwood%2Fwip%2Fprompt-status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-281/phillipwood/wip/prompt-status-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/281
-- 
gitgitgadget
