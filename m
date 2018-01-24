Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274FD1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932618AbeAXJac (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:30:32 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35760 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeAXJaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:30:30 -0500
Received: by mail-it0-f65.google.com with SMTP id e1so4458374ita.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPN1YJjplibaYATHXuMnsvSsOgXsDhyle0j8W5JqYWE=;
        b=e0qEwZEfDBLBPROTYGe+T+P65wXPj+zvjmTrmKixa4qiO1Mg2rcnJ4NhaofzVRK+QS
         iUIoeGotA0OQfELr76PcM+YbXe5nnkgeW/x+6RIP20l/ryHNp+phxe09QJrwyvZaA1s8
         ZHxd8/msBU9DvFA09DDMbBY/yTY/Gzv6cRhwtfujZGHfpMmbx4vdPrvtptQk3K5Qy5nW
         kYVZ2Ih7OWGx6BHAKkNW/vrKEA34R4o7R3yYSgh5jExBs28zy+JoA/tDSOTvMl5FbShR
         ngJYiPnSv5ftob2sG8xn7Z1yeZaomp6lhSlSEUJIIb3j/wmqbm10vgZ29grpPFOgPWcM
         LAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPN1YJjplibaYATHXuMnsvSsOgXsDhyle0j8W5JqYWE=;
        b=UxYP74clOrsEPlqgpcAIv9HaWNHcTk/CceDMv8mOlAiHCxhro1dvfC1yoL1OdaGOM8
         1yxJhgczUjvP9Mh/gD7csymqoveHAvrTQdIU3quXkqsGbe8yNKupYB6J+L/x0eGV386O
         R4TEZA2Z59mp+O67GSFI6wJC4x3TUuf1f9SSOpveDKmHnuYH550UgVMfQWpDtGlYl2zr
         lkMujxdvNX5egglw3msExoBu8lFlr6fvgEDh6da+Esskk0XNmgoeXoM+/pIU8DA2qLJf
         G88vTJ/LhCaZLfvlFc7QWvCHmdZyfhPs/+5bFBMvfSCxDHrjxDZ9q1hGmoOsFjkLYxzr
         cqEA==
X-Gm-Message-State: AKwxytftJ3347Z18VpGFujlgilnN23LzzgPoYyAG/BUH9cQADmM4XcmL
        dHb2CVRdEJQm31dG69KQ13olpg==
X-Google-Smtp-Source: AH8x224EcrOE+hV2OXY71BP4xsEIeOu+FnIzVPxpdfSGnGW7Z3nmTzTno5uaOW0k3i9HYdvXBQdFag==
X-Received: by 10.36.83.1 with SMTP id n1mr7768805itb.96.1516786230197;
        Wed, 24 Jan 2018 01:30:30 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id g187sm849098itb.29.2018.01.24.01.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:30:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:30:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/5] nd/fix-untracked-cache-invalidation updates
Date:   Wed, 24 Jan 2018 16:30:18 +0700
Message-Id: <20180124093023.9071-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180118095036.29422-1-pclouds@gmail.com>
References: <20180118095036.29422-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small update where the last two patches on 'pu' are merged
in one. The final content is exactly the same as on 'pu'.

Nguyễn Thái Ngọc Duy (3):
  dir.c: avoid stat() in valid_cached_dir()
  dir.c: fix missing dir invalidation in untracked code
  dir.c: stop ignoring opendir() error in open_cached_dir()

Ævar Arnfjörð Bjarmason (2):
  status: add a failing test showing a core.untrackedCache bug
  update-index doc: note a fixed bug in the untracked cache

 Documentation/git-update-index.txt | 16 +++++++
 dir.c                              | 31 +++++++++-----
 t/t7063-status-untracked-cache.sh  | 87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 10 deletions(-)

-- 
2.16.0.47.g3d9b0fac3a

