Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112B11F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfBPLhM (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45711 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so6280809pls.12
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3SvyWaYTRy7yCUVHH+16iSa4rqJLUlbR4JK+VNuUEk=;
        b=PH8O6C5AXwLfGCgySQS4BaGrDItxqLjjZ+N71FIHDC+Yot/xqXOUgUpFKI8mhABK52
         jAo/D3eL/iokFpMKRgzdB8OezcOy88omebm5Yk8RjGII9ZpyyBb7Z4lUUGXp1duA/DGB
         +lj9zAFMs6ATFKSNDncu9tq4R551fym+Jpt24eUcdloDo4gpPbeZKgS1Uee9veUVmSkX
         wlHkMUsy87rgsnVgLtoTZLkQbV0Tb8I0jH6qiwi4FhSQAh7Ebc6xYCno/cgrwzrHYbX8
         GWqHZx64CYMwI+jpLvRzFNJM9htczkLANHeokXj4lcJP8Txrc760+iCXymBvJDwIhJPs
         oXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3SvyWaYTRy7yCUVHH+16iSa4rqJLUlbR4JK+VNuUEk=;
        b=VbBnG5gwMLw5hGMBeC6TG1JLFCoNSS1aU3pgYHZSW2n/P9htU32xv7zrnRD9cPAEMo
         U5NMoYe4pESRnfjGab6YIeRuBhqHBIzXNl60c8xP+yd9AMlYjhQhkq0r3BldlaFts4HY
         lyPRo6NAu6q78zaYfX7wTeWtR59aeRN9X26ma99JgtaHGDczpY3trbdNrs+frUiaicqq
         gmU1fh+cWIzpWQpgq4uJTx2GJKgKS+ps3wAIxNXSPMRBxihaS4M5VkYp7KEOIDT/e2VC
         tcew9E8TdgNMj7UlHyw3cd0KQTbDPwK3Q2t0s77t2EtonVH6Ti6uYHorUJwrjY6hIIId
         0NHA==
X-Gm-Message-State: AHQUAub2m6klyUH2tlPuL+hQD2XLIEthqJI7K7GnRIN+xMPbP+oY1wc+
        7KqoHC5Vv/TArVy0XH5tFb7KUkUB
X-Google-Smtp-Source: AHgI3IavkliC4YGVGFEllCfh2mtPxcsA1LfiCqHoQ67n+l2ypfvcf9mRLhvo6EYmmwBVL5ilIiR6Jg==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr15429062plb.306.1550317030978;
        Sat, 16 Feb 2019 03:37:10 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f67sm10986571pff.29.2019.02.16.03.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 00/21] nd/diff-parseopt part 2
Date:   Sat, 16 Feb 2019 18:36:34 +0700
Message-Id: <20190216113655.25728-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 is the same as v2 except I will not delete the patches while it's
still sending, grr...

Nguyễn Thái Ngọc Duy (21):
  diff-parseopt: convert --patch-with-raw
  diff-parseopt: convert --numstat and --shortstat
  diff-parseopt: convert --dirstat and friends
  diff-parseopt: convert --check
  diff-parseopt: convert --summary
  diff-parseopt: convert --patch-with-stat
  diff-parseopt: convert --name-only
  diff-parseopt: convert --name-status
  diff-parseopt: convert -s|--no-patch
  diff-parseopt: convert --stat*
  diff-parseopt: convert --[no-]compact-summary
  diff-parseopt: convert --output-*
  diff-parseopt: convert -B|--break-rewrites
  diff-parseopt: convert -M|--find-renames
  diff-parseopt: convert -D|--irreversible-delete
  diff-parseopt: convert -C|--find-copies
  diff-parseopt: convert --find-copies-harder
  diff-parseopt: convert --no-renames|--[no--rename-empty
  diff-parseopt: convert --relative
  diff-parseopt: convert --[no-]minimal
  diff-parseopt: convert --ignore-some-changes

 Documentation/diff-options.txt |  20 ++
 diff.c                         | 510 +++++++++++++++++++--------------
 2 files changed, 319 insertions(+), 211 deletions(-)

-- 
2.21.0.rc0.328.g0e39304f8d

