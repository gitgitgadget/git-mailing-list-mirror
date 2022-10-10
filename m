Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35BC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 07:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiJJHuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiJJHuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 03:50:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C200610A4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 00:48:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so2784734wma.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0ebk2jtT+t0Pcnz5SHnj39LoLCSKvsKw/eRmmQF9rys=;
        b=OsVAWPXjhs1tOxgfH/ZtW/Xou/d0tLyb6zPANq/ai2e3IT4etNMDegDq+4EKzBVtyB
         Y/VOlqPFtAu4e/zE0+I6m5yHkDeS+mVl3pQpT7I0lhh3l3c0sDfFIzriXNLpFBjRg3IA
         H3rd8yLdLodOqR73nXdTxhi+shEyTmwRrtJUef1gJHN+9+yWgIw9zl4+eVjXkkFiCRZL
         gBbvPYJhEH04S0xUohfDS44H+U57mTOIP3nexx+nFsx8EjwYEzlDom2w1PlsU/cdbkXC
         Sv9g7e1HZW1ZB6iYlhyZ6EuEZlqnClPohH4JwPpePVOSMnZRe6Bvw0GqgmEzbV/WfmqK
         qOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ebk2jtT+t0Pcnz5SHnj39LoLCSKvsKw/eRmmQF9rys=;
        b=cq12oRKgQV19iSi4AyKmNeIwJ8WDE4QNuvSLKsKUnPi3/vTJ3K1FYEAJn6g4lPVciD
         E4WsjnC3MwvMZ0NmWGb991j1RBNSMUl9UatOR7HoCSTbyefdWBESkDsdyKlvR7bq7f4h
         PUC6+ccjMD+n35FZv5Or6xIJgPFOWoTH4ZRlP9lmxo7Zv0XDdzZtfivMxIG2cnC4VA0l
         2VtDLLjWTyG9gnGZBPAXZKmSe4e9vAjlLNmaRvPQmjRP5lYXU2cUkhzHjdvjY/pzG+vq
         JqvK5mOtwvDTWaHSi9AXqM5GL1e+h5/lUBgaWJfXz5f7U/p2IijM0hzbvFaL0ZW7yXFb
         Kfag==
X-Gm-Message-State: ACrzQf0HsFLtSBunhWjNwIURtsL9dOxF2QYq+5HyofaUyY1jcF/wa8Mr
        Cs3XgeaaNiV2l/Zy02ZBXaQuPrQvBG4=
X-Google-Smtp-Source: AMsMyM7l16Ha4KPRIIyBS6d9OVbX2cbPVjI69MjpaydWG+QrWgu7Ia6aBwU3+zTih8OUHP0CBgNMzg==
X-Received: by 2002:a05:600c:4e44:b0:3b4:bed2:4f5e with SMTP id e4-20020a05600c4e4400b003b4bed24f5emr19242732wmq.193.1665388138154;
        Mon, 10 Oct 2022 00:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020adfe0c4000000b0022cdf2179b2sm8335408wri.68.2022.10.10.00.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 00:48:57 -0700 (PDT)
Message-Id: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
From:   "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 07:48:54 +0000
Subject: [PATCH 0/2] ci(main): upgrade actions/checkout to v3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Oscar Dominguez <dominguez.celada@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Description
===========

Upgrades actions/checkout to v3 in .github/workflows/main.yml

Oscar Dominguez (2):
  ci(main): upgrade actions/checkout to v3
  ci(main): linux32 uses actions/checkout@v2

 .github/workflows/main.yml | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)


base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1354%2Foscard0m%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1354/oscard0m/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1354
-- 
gitgitgadget
