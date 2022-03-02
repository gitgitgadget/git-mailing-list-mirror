Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5880CC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 06:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiCBGqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCBGqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 01:46:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA060DA8
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 22:45:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id s11so1017928pfu.13
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ECR5xpOkuk02vyD3VGU9Vs7VxvyvcM0NpwCOLmwnrpk=;
        b=iy9I6+Og24CsTWB8uTI/rlOoKvXdTEO240fcRmesw652Fe79fUFstV8yGmAiP5qs67
         nMyU4K9lTnFLL3olRyJGNnJrNYUzvlOewkVa6jhxu31wQwfJpa0ZMB/4xVTEpsdpqhSf
         /jdS2qWTxyCIqHu+wkbDakmQjTh+zA/CcS/KhvxypxXa1v2HPJjlwQb5dJp5YhewbPnK
         3dT49ickyVsZAAWbEpZSNY+t3uo42R0Q2kFVZie/i0nHudVa8S83YWeYd07FDLUJS/+f
         gU2NV5/cAsGDaVzoUVAkaTQ4nx7mpH7+J18GTJaFwoc2566EGfQoapxPHqGg2mmxOQQe
         WVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECR5xpOkuk02vyD3VGU9Vs7VxvyvcM0NpwCOLmwnrpk=;
        b=r/g0dSZDcII/P8cSr6V3IuDkKOMDh21U1J6JyT85R6paRfcKaHmSeV73IjTpOG8RN9
         yuGRW0c1N2AJ3RbahqeurPqB+wES1Hi6HEwFMF8ZQT+lGgRfjDOvOVRekMwRv+DEQErQ
         KatFrM2OonM5jP2T/YzTqHjLZwZVuNc2E8S2k563QVcnl9aiYmCcSLitk2BLA+NPcM65
         p5zeizceNK+W5T3R5ZZ9V6S6KWq+9RmIUoQwJA6CZTGDj94f3j01+0Ql8ZuYyy9EXTxG
         ZdoQh6Lk/hyQzyX/QI8gHThEFCJvQ65VreQfEvVr5Sd8cXprc+7tt5+SVE904ZANSHvp
         yBJQ==
X-Gm-Message-State: AOAM531ZaG3246jIUJVMZMIeoYJmBoIQRFEzyG70gtgW2X+I+slusX6L
        TFeDx2NtS1Ft1//8Rb/1gHkqil2Gvs0zvQ==
X-Google-Smtp-Source: ABdhPJxhJJX7mlUkNw6BNuFB/N3hoeAlalw/VQ8ekfJKhSHeqLuR9469yerhsyQuSzGqdEPyDqGBfQ==
X-Received: by 2002:aa7:88d1:0:b0:4f3:6132:42e1 with SMTP id k17-20020aa788d1000000b004f3613242e1mr31472692pff.67.1646203519616;
        Tue, 01 Mar 2022 22:45:19 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id nk11-20020a17090b194b00b001beed2f1046sm1790165pjb.28.2022.03.01.22.45.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:45:19 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCHv2] userdiff: add builtin driver for kotlin language 
Date:   Wed,  2 Mar 2022 12:15:03 +0530
Message-Id: <20220302064504.2651079-1-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.
Yes. As Johannes pointed out, the word_regex was very loose and did not
properly tokenise the code.

I have fixed(and added tests) for the following things in this patch:

+= or -= is not split into + = or - =
-a or +a is split into 2 tokens(for each)

Since kotlin supports `_` in between digits to improve readability,
therefore numbers like `100_000` are single tokens and not broken up
by the regex in this patch.

Kotlin also does not support octal literals, and so the regex does not
attempt to find it.

