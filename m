Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCDC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiCBO1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiCBO1W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:27:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA35C6201
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:26:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso1568672pjb.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PT3StT4+qspzjrQ6eGfC0aDsaf8rlNBI4Mxg66g0rFo=;
        b=iJHH6AcjaWd2pZN8FONri4KI2yEDs7jiuOSqG8OEAtGjT2H1bXILLvwWcDeu1vAjIW
         n5CC75PtXcTTitFQKjSBQ+nSmG84mBSxiI4h+hglKqrmF7Rp6HzOkjgvElhzTAg3KhcR
         QM00TE+7Pp/cWID3G5GKr+xj3DbTsbhYeq2kJ31B3mZv5NLJgl6pcr4v+nhZebMOyDeP
         r2QCTXfcM37Gxfql7cl5KQxD6Fxbc5PKmEfWBU1/8eAN17awDP9RVUkjA1LrYr2cgFu3
         2zHZI2qcn1DjGcFcdGaDns6ePpHIsEabOf92NiYwEcWFeDKkxvutAaof7LYP+EKAyzpa
         oayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PT3StT4+qspzjrQ6eGfC0aDsaf8rlNBI4Mxg66g0rFo=;
        b=xDm62XKrsDeKEPv3tEGgRzbLW+P43DRbZKQdtsfGvNa3cxtB41izQqa/E2vpysLzet
         SNQmxYNs48N3prbdtRPf1WgVYmGxF3gLbQsLyyLfiZImfnw+hozC7Th+tXOVIghb27WZ
         uPN/ZiIMdjyQ7eiRDI0USuHaNPfM4QtfM/zwGZeW+Ls36jv8WdWkb0R+8LTDkyTyQsqV
         Kj46DH/qgoXSVsLQPJqubpi65E6a7MNp34gEEq64bRzrcBigg1NEwl6jew2u5p0UkW+C
         +ePPJj3BA+DpVmfF6AEn/ZgTsSCKvLMEZs1jefs3lvz2ash+HeTp+lIlIm2lbYS1pd8p
         RL9g==
X-Gm-Message-State: AOAM531U6hUNwR+ujPmWq2sFXQyAL+gweDC8JV29YEMRhZzy6Lr9ZVCN
        WUn0AU9gnQqcVRbVqOKaANsc5CjHT7COUg==
X-Google-Smtp-Source: ABdhPJzCapdgOxHsM9OETH9ka77CdpkrJP0ZEFITKzx9ghyKiaXlkH+qOW0GE5TzXMbVetz/0Uq1uQ==
X-Received: by 2002:a17:902:bd01:b0:151:806c:4176 with SMTP id p1-20020a170902bd0100b00151806c4176mr9167584pls.144.1646231198499;
        Wed, 02 Mar 2022 06:26:38 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id k21-20020a056a00169500b004f65bbfca3asm2349218pfc.57.2022.03.02.06.26.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:26:38 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCHv3] userdiff: add builtin driver for kotlin language
Date:   Wed,  2 Mar 2022 19:56:07 +0530
Message-Id: <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Johannes for the review.

This patch hopefully fixes the problems you mentioned:

- Hexadecimals, binary and numbers with `_` are considered a single
  token
	Pre                    Post
    0xFF_EC_DE_5E          0xFF_E1_DE_5E
	0b100_000              0b100_100
	100_000                200_000

  Even though a single character is changed in each of the above
  numbers, the diffs would be produced as if they were single tokens


- More tests added for "proper" multicharacter operators.
  
  Earlier regex would consider a++!=++b as 3 different tokens(a, ++!=++, b)
  This patch matches the tokens properly into (a, ++, !=, ++, b)

