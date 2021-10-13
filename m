Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF71C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A443E60E09
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 12:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhJMMZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhJMMZb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 08:25:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C83C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 05:23:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w14so1690566pll.2
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51srrcpPUQH38WZu8EuvqIxhUPqctgYThbvGtUk5oQc=;
        b=j6YOIYSd4dNNABLd0m7nafMNFPeQqqp+i/zvGK/yYK05peBxnKs+88Fmmu6h6wioyE
         3qM4hpxDk4t8YgZwqXJsJApixR+Tv5+zkU4ypGK5BHN7H94jHgm/YaeR8sd12ZTmTpBB
         ThAUpcHEDfRF0CxfKq/5OiTRjzOGKW+066qle/cuFEnFGm9nqdiQN3sRL6azJ06dgtWx
         VyZO9SNcCxZCtBwD5HGbvzJxdzkD0+wFH6nmR6TQw8hLDeZWrgrt7owWcbtxUge2sHOi
         B4jFuMaOspZ662sfV7UJ842QNkSXf98JQGj2SO5nFBwTZqz+9VDGfp7tm9Mdk/B42Bck
         Q7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51srrcpPUQH38WZu8EuvqIxhUPqctgYThbvGtUk5oQc=;
        b=kGC2drroe9+dSbPyViNH9dlmNf2AzFf62SZ/RJfyNxqrFLR0AlXjtsryVuwCMA9JuM
         8w7KR9iM0mcLMDI3qWEy/a0xbIrzzZOc64z06L1j7c0Dv+8JYpIHtgELkv0ZaHhKvjnW
         4WNETRKnHPNuXKv/NgiPpSkUb+m5AmYoTMwPplhOtd5CQydnspB9dVzlJs1qfD4VW2NA
         XBF1uA+A3gZGTlLD5RB3tn1IGhvifpc8rxUQGFuW/Kl6+sTw2WNXk3ARIKUAiU2Fw3fU
         KtkWJYzBOnfbKZJMqFPet0wunalKIQFoiVoKlQjQAYW5+Kj6D48dOI/+OjdZcAAHytx8
         wFhA==
X-Gm-Message-State: AOAM533Y3ALQcAhruBbtIxBZMIeMaeg+Bxv00nnEyu9Lq6u3AHv5WTTw
        7TDyvyaxOjObAW1S9Smp62QUIAKivH4=
X-Google-Smtp-Source: ABdhPJwWeYFn8kJdbr/XRhce+XqFXP7Kb07R9qKggk2ck0sLxIQ00SEeTb3ulVflM5Xk8BsZ0urScg==
X-Received: by 2002:a17:90a:688c:: with SMTP id a12mr13054328pjd.227.1634127807355;
        Wed, 13 Oct 2021 05:23:27 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-30.three.co.id. [116.206.28.30])
        by smtp.gmail.com with ESMTPSA id c64sm8729490pga.40.2021.10.13.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:23:27 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: specify base point when generating MyFirstContribution patchset
Date:   Wed, 13 Oct 2021 19:22:35 +0700
Message-Id: <20211013122234.448845-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some reviewers need to know the base point of patchset a contributor
being worked on. Mention how to answer that.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/MyFirstContribution.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index b20bc8e914..081fb71327 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -937,6 +937,13 @@ but want reviewers to look at what they have so far. You can add this flag with
 Check and make sure that your patches and cover letter template exist in the
 directory you specified - you're nearly ready to send out your review!
 
+Some reviewers (notably testers) would like to know at what point your patchset
+are based on (in particular to apply the patchset). In such cases, you can
+mention the base point when preparing your email (see below section), or by
+passing `--base=$(git merge-base master psuh)` to `format-patch`. If no base
+point is specified, the patchset is assumed to be applied on top of current
+tip of `master` branch.
+
 [[cover-letter]]
 === Preparing Email
 

base-commit: 106298f7f9cca4158a980de149ef217751e1f943
-- 
An old man doll... just what I always wanted! - Clara

