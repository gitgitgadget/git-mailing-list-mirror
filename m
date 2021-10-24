Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0752C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBEB60FDA
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhJXRLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJXRLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:11:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA78C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:08:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j10so1344101eds.12
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kpAgbEHRUBhq4ysxOu61A1Q9B/RVqJKne3USx3rXEI=;
        b=DfJnudMYcKdJ9J9+77kXu2xSde7LzXPpysoKDs2+rNfdUHz/VRyWAdSAOAZGzcJsSz
         1JaaevfaXYljEEcytncvrqzm++1BU6IfNc/JQ9Ha0Bm+LIQgdoWQqIRHNkF8cboGXRTG
         PAYXeWHQoEVtp4zDGLUtsUQw9yCA5i0iKvA6NEVRaXxZ+7nq73M0mYQUEMxPcjpmiAa9
         aiHLVN3Fa7jtTsOsChH+7DsjNftdJBdSlCpIVTnnMBiCVxcVtmadQJxA4hbxdX/u3V9p
         CZKH5cnG/CsmDrI9EL5swNX6nZOVEnH399NDjlwtzm0ZoXWjkS16BAX7Uo8t1mOCCQ6z
         jSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kpAgbEHRUBhq4ysxOu61A1Q9B/RVqJKne3USx3rXEI=;
        b=ALckVHJWuI2hGuOtF/SYrDigyW1eEpWLSIHX3HOjp2Tc/qeA/iFCm00OMT77dnOcF5
         QLY9PzAPYbAQENliUfHoaFn7cR3qY8PTn7aX4HVbVThlbcM2QgzZ0GZSPpOIHeV1PajZ
         MZOWgbHWUGHyRiviGeZbH7mJfKYdkNrOOMLjRTFR02c0mbf4dPR3xCD7fMI6Y6bLkF6q
         wA9RxKQsx0D9i6HMb2y0p4czydxwBqYSLkB56451tc9p/ghknpCZNI8f58JyeHfrOyDv
         59ktBqzH1l1FKy5plQSVgIJdbuy1lkrOfieNSLfd3Jp6Go6it77aD8QcCGMvYYtXgEKq
         z0qQ==
X-Gm-Message-State: AOAM530tASMmmzQwtbhhXv5dsDJG3CktBtr08Yk9dmGY7L4MKaq3AAH+
        eZPeUNeOt/X90ndGqyvWKmPfVJvYZjqq3A==
X-Google-Smtp-Source: ABdhPJzIac7vm2udmT9KwX2Vp4Z10ij5scYoxlv0OBd3ueZ98Omge06Q9NTCP5lQkQPxCzRdBZBhOg==
X-Received: by 2002:a05:6402:5c2:: with SMTP id n2mr18731731edx.239.1635095326723;
        Sun, 24 Oct 2021 10:08:46 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id v13sm6369378ejo.36.2021.10.24.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:08:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] doc-diff fixes on maint
Date:   Sun, 24 Oct 2021 19:08:19 +0200
Message-Id: <cover.1635093692.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two small patches to address some things I noticed when going through
the doc-diff between v2.33.0 and 9d530dc002 ("The fourteenth batch",
2021-10-18).

This is based on maint, since the original commits are already in
v2.33.1.

Martin Ågren (2):
  git.txt: fix typo
  git-bundle.txt: add missing words and punctuation

 Documentation/git-bundle.txt | 8 ++++----
 Documentation/git.txt        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.33.1.711.g9d530dc002

