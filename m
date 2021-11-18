Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEF8C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E51B6115C
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbhKRHQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbhKRHOx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 02:14:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A65C06121D
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:11:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so7408226pjc.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XnaAypWAlzMKtw1Jfyy+8Rfl6DKg1PM7AoSHIurM8oY=;
        b=S99Lf4xXiTcDW4vd2oFipfyefGU6vm+mEpbqItxZ9DoZNmOEnv4v4Y9gdgUL5VHAhF
         WCw9PSgEUcy8nZGGZduDwtNhoMH7jkCxxtdmySoAx+WAxWkl64tcDFegC1Cu9EMkIz54
         OacJDy0y5c8kNRHXxKij8qj64m5yYAPmoj36F0mhzt1PFgpH6RnZXKlo8rKX9nzEyZKQ
         ShUgJ9DoNDG7J6ifz/ZXMaRaP7Ru9zKe219Q9XrPKfstxOoTUvW76NxVPbwvYkWxMbQ1
         hHdeFjol2eKyM+Oj38T4rQURHuHXKO5nM2Gr32/UFQgsHrfVoyndP8P7JHPIhdvUUmUq
         2/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XnaAypWAlzMKtw1Jfyy+8Rfl6DKg1PM7AoSHIurM8oY=;
        b=ZjZTENIasysc8ptobFvBENVE001IZ77cIbQ70qA+RTUdCAAs9lqH4hECb3drIAU7NW
         M7hVKvfntN1e1K8NyQijeXYMZU1D/9MDBMisSHloQKUwPrl8HEP3Qkv/ehA9E1yqapKX
         x8gid5cn9E1atLlq+YJXXm6AofnU23ZF7XJsjqjQeMaVo2yqPVFWNQoe4SubMTUBYH2w
         o1H/9NwH4L4rHBCnGkGfHCnavXecPJvKTLUEdAgbx2RcCC5i13Ntj+8u85g4pUdKMM+H
         B7/JVOyO9QG++7FOsqpDDESXcDYq9GfDudxQha8kpWVpR963CDRKut7FttxZdstepRSh
         6QOw==
X-Gm-Message-State: AOAM532ehqPPJjTB8RKi0i+bogPDKeZEQXdBjW3Ep9UAYqXUz2msbXqT
        g5SOjgeYEDOCV4ckM/M1fTp6YzdNcilpbQ==
X-Google-Smtp-Source: ABdhPJwY3VYT8bSigMWTcuXRc7dQ56taA+8OkiKao+F6G0nxDicO4pF4b+c/xMGboG4XSNUj0kylIw==
X-Received: by 2002:a17:90a:5917:: with SMTP id k23mr7809050pji.111.1637219487998;
        Wed, 17 Nov 2021 23:11:27 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id l4sm2011101pfc.121.2021.11.17.23.11.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:11:27 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 0/1] [PATCH] midx: fix a formatting issue in docs
Date:   Thu, 18 Nov 2021 15:11:13 +0800
Message-Id: <cover.1637218943.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
In-Reply-To: <20211115063318.14426-1-dyroneteng@gmail.com>
References: <20211115063318.14426-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 2 contains the changes from the advices from Derrick Stolee
and Taylor Blau:

    1. More introductions in commit message.
    2. Use asterisks instead of dashes in "multi-pack-index.txt".


Teng Long (1):
  midx: fix a formatting issue in "multi-pack-index.txt"

 Documentation/technical/multi-pack-index.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  a7dc1980a7 < -:  ---------- midx: fix a formatting issue in "multi-pack-index.txt"
-:  ---------- > 1:  9b910a44f4 midx: fix a formatting issue in "multi-pack-index.txt"
-- 
2.33.1.9.g5fbd2fc599.dirty

