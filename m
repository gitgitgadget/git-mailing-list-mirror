Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B681F597
	for <e@80x24.org>; Thu,  2 Aug 2018 12:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHBOEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 10:04:08 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:48806 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbeHBOEI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 10:04:08 -0400
Received: by mail-ua0-f201.google.com with SMTP id f5-v6so689318ual.15
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Rv6I9PnAAw3jzhli04QbXyjQWA8aydDHmvurBoEQwEc=;
        b=f0QKlVBKTJ5d8NwLz+0giX/GCmmkjW7sKniMCpAv0vOgijKZLxTCcfhqjOWtq0h4lx
         Rcu/OqIe7CY23bIJRN1gSl9TpXZUZg+hpgds5mWqS2/JPiOD9/PTECH+kR/YMcgbFURZ
         rApXjfuBLT4EFc35HJb02WuCZIpC8pHlm82A16xDZz7TMDCIjsi5R1l8UVE8sK56WDwJ
         v2LIFl3ZHJDiSDjdMjEZy+I9+mM1eXe4rBjgjgnHPb61I3D4aJ69GXICxD/K0NDAgyyY
         d+1YvjRnF22JM2BKgLeeHMTuhpUbeL3QygW8kOONKAICjtA11/+ruI35LQS4qNx8WdZV
         ARow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Rv6I9PnAAw3jzhli04QbXyjQWA8aydDHmvurBoEQwEc=;
        b=P3VqjYXi0tbvMDJwpQEuLIWxJasZR6f2e4mORJHcwWI1DJo0Hn6ofTHwYg+IltWKRg
         pzU1SYrw2AngDsAPw/ylh0gGmmfEXUadGIZVof5RftX4eLlfhDwgGEKkHNx/SXBymxt/
         DcVTgC1caHBC0I+Bd8rw57uTQkMGdDW2Hp1C2cCMguABqpRm6dAD1+AFbYUXPv8B4CBR
         LITKMvhIOLhFhkfzQvD5YgPqwpQhzefOQbUEGtu5oOGlE0RtjAoZG+8HlfTFu/kW2sB0
         rki+Bb+duZE1Zm7Y/tHrI6A9cA4nPxPt+ojgzwXV0Y5T0k9srpAKGV+61VQPHQHX1rE5
         czYw==
X-Gm-Message-State: AOUpUlEua6o7HWhq5tRfS7n1DaIFnQg5plsa3gyH6z5gun14GLxR5pEd
        HHbSKZDLvoUOwSFvOOy2xpKG1eEVg6o=
X-Google-Smtp-Source: AAOMgpe4vgTG2Rw40kkNn1RVM0t+1SCe+75yIx5H61cPbg/g2b3yCVgVKgvxcMLRp3O4y5TzbcpLwktDHY0=
X-Received: by 2002:a1f:b3c3:: with SMTP id c186-v6mr1098907vkf.7.1533211993123;
 Thu, 02 Aug 2018 05:13:13 -0700 (PDT)
Date:   Thu,  2 Aug 2018 14:13:06 +0200
Message-Id: <20180802121308.17371-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/2 v4] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address Eric Sunshine's comments.

Han-Wen Nienhuys (2):
  config: document git config getter return value.
  sideband: highlight keywords in remote sideband output

 Documentation/config.txt            |   9 +++
 config.h                            |  10 ++-
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 119 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  47 +++++++++++
 6 files changed, 176 insertions(+), 11 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

--
2.18.0.597.ga71716f1ad-goog
