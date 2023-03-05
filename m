Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275FDC678D5
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 01:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCEBiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCEBiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 20:38:04 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA547A90
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 17:38:00 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-172afa7bee2so7588255fac.6
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 17:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnEHLq6BxLO334ku18dukYV3AHMSIs1aL2v7OfZ/HHM=;
        b=NtFcczzz1b/Ai4Qsi9HV1/Ux9L3ySR2FglN87FPU4yvnPXwbSQMXY4tUti3N+317Ws
         vqvCwn93luUwYLdG11zqHFklCH+ZjbIWf5ahm6cUsIAO3IkCltdQMFe8P9cPZYJt9yRg
         Vwqlm7MKDqkunSfCe3yBx8TyqV+d4OYB78kFnqJAhxyix21wFLHG0nDzGTaXoBgfSRyw
         MVg+QhAHr0JgC3dg5MfFzrzh7J+oBmELUGnQ342MQZE7H2DOKJrpZhJVGLyuWO5a2wks
         jK9Ob4kJvFzm7vrnRQfpZkF7sdBUJMlmR1Ww826LWLnZV9HFohfLXRgn0vmQzzMskRRu
         MSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnEHLq6BxLO334ku18dukYV3AHMSIs1aL2v7OfZ/HHM=;
        b=5U7rSf1XFPiTrQBqAnA2ZdKRutyiBDIkfsS+fLopYpgoKoCgkb5LQI1WXskef+sK4A
         WX8HCz4BmUXzLV/MdX7fwa3l7AS7WbGiJ17MrtWbIRSNdCX2hotk0PsCkm4ilh98PjZy
         2wyRXQILi+urQMplQoGQ4JkYtlavEUBb9kGUoUrLJBgjrivd65jl7neEyuq0xA7u82Xa
         ULfo/fAkTwhuqWN6bJC20NL0MAQL3u8On9SK/+jHkEMP2sZoATV43wVxVSbLLGwAhhQd
         cm9+rM1Vb7fv62OSBXiNlu3jmRhefzCTyIFHLcvBKMAEVv+j8oC0Dlh0uZnR4/cSFnwg
         Y3kA==
X-Gm-Message-State: AO0yUKUWmwbAdyDDWQwzB4+hWAmRWaY/oLxkJGMRXptk4PnEtwRzlG/P
        3BMX0MLP/pbn6yjcSlrKhjafSsmszbs=
X-Google-Smtp-Source: AK7set9mnvRJSByrNqBSb88j76UaOXAjyIhkDeLIYn6bKLIDe10L5SywCrY7FeN8B0zO7MMcTKDeHg==
X-Received: by 2002:a05:6870:9728:b0:176:2458:56c3 with SMTP id n40-20020a056870972800b00176245856c3mr4320024oaq.6.1677980279888;
        Sat, 04 Mar 2023 17:37:59 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dw48-20020a056870773000b001765b2f6c53sm2566124oab.9.2023.03.04.17.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 17:37:59 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] doc: rev-list: simple cleanups
Date:   Sat,  4 Mar 2023 19:37:56 -0600
Message-Id: <20230305013758.344573-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some simple cleanups to the asciidoc format of
Documentation/rev-list-options.txt prompted by [1].

[1] https://lore.kernel.org/git/CAMP44s3Kqyrdavp1OiozNbA7k4EHCj0KiQq4d2Dyg_KZSEAUuQ@mail.gmail.com/

Felipe Contreras (2):
  doc: rev-list: simplify escaping
  doc: rev-list: simplify literals

 Documentation/rev-list-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2

