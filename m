Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460DC77B77
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 17:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDOR3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDOR3j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 13:29:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9CE30D7
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:29:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so2011641fa.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681579775; x=1684171775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ML/hpT8Mm4zBCZWPjoz6mJm0Gkavzl76VG0I9oqRFg0=;
        b=XGZWBMbOXXVoPBdur0de59q+qI2hOz4tlRWvv+siQbX0/x+cVtp1gMZiRfoZJ6VIkj
         KztCsDrq9PyREJk7uVW4Oche35suS+a09o8ZUfu+X1fglEh5j+5Px5cMuvWF+xixzCrj
         oI4V1lEB1vWulqYnn2wNAtYlsxmnOcoyf80V9tcAf4pgrWoXmEXyEMLUL+nF1wQyOhEI
         pyYcEms0VYPOd4Off53YMEbuNF2mZu4H5W/hPkdPa7C02PVj48YwwJjqxt6f+ZoAH9nt
         xDtO1kDHyTFGl72Mh2Sas1e+Y3A//GJO9nYv6vwlbMq7k66u4v7lnIoHn9cfhhQgp94t
         lzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681579775; x=1684171775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML/hpT8Mm4zBCZWPjoz6mJm0Gkavzl76VG0I9oqRFg0=;
        b=f6GVSY/RaIivQY3J4kpvxMWbs2nTTpJ/8G/IS9OELxDq7eCBN7cUohPz/lS0XdMQey
         LIsCq4k7m8+4LNf1YHDDURiDc/VXGj0A3Lb0c311Rm0VjYkUVuCfk4PbTey8xZcixkA6
         kNtI6s0L0rm5h/+fQiqxsCUSJfsjUN9GqzZTGoaIgbgCdMDH9UEAd/QH/hKZVmDXAAPv
         pwInAb/oP5C/FudmMpryswjFGAiqY6dgzjlANzn231MP5VmGAuFkhPl0vaz0bNdf8yW6
         On/zPnxLM0jnIhpxtT/l+VYYScYdLL/G5ci2ZIYU6oXTMiFm/EsQbtV52P3MhkRvpf5e
         ynFg==
X-Gm-Message-State: AAQBX9dvBhu3bNK856XDycfpU1mhwf/3Bh0Djsq87b7oc9pwkTYzCHta
        dn08gV0Dd8Md6CBpe/0DrQijxmBHOZM=
X-Google-Smtp-Source: AKy350bEc7MMs42VLkq4lfaAuft+jRYSTTG/WxcuQVzJoCiG5YMikvX2nHrPlIIXbdOqG18O5y8Axg==
X-Received: by 2002:a05:6512:411:b0:4ec:82d8:ade1 with SMTP id u17-20020a056512041100b004ec82d8ade1mr672067lfk.53.1681579775061;
        Sat, 15 Apr 2023 10:29:35 -0700 (PDT)
Received: from localhost.localdomain (81-235-255-74-no600.tbcn.telia.com. [81.235.255.74])
        by smtp.gmail.com with ESMTPSA id x2-20020a19f602000000b004d40e22c1eesm1357056lfe.252.2023.04.15.10.29.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:29:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] gittutorial: drop early mention of origin
Date:   Sat, 15 Apr 2023 19:29:10 +0200
Message-ID: <36a8ede4c83ff6d88c9d49bd64f1546262934c55.1681579244.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.40.0.406.g2798986c60
In-Reply-To: <cover.1681579244.git.martin.agren@gmail.com>
References: <cover.1681579244.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't have an origin at this point in the tutorial, so "Your branch
is up to date" won't actually show up in the output of `git status`.

This line was introduced in 8942821ec0 ("gittutorial: fix output of 'git
status'", 2014-11-13) in what looks like a mistake -- that commit mostly
just wanted to remove leading '#' characters.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gittutorial.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 0e0b863105..33dd5a2cba 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -109,7 +109,6 @@ summary of the situation with 'git status':
 $ git status
 On branch master
 Changes to be committed:
-Your branch is up to date with 'origin/master'.
   (use "git restore --staged <file>..." to unstage)
 
 	modified:   file1
-- 
2.40.0.406.g2798986c60

