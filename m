Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE4C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 19:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjDGTeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDGTeH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 15:34:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3BC650
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 12:33:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so7727393wmb.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680896035; x=1683488035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtToXMoswwiIDbPzROAaUy1N7OAa0gaev2fa8p7+U8U=;
        b=Sls5uw/zUC1K5qRk6oTSUGCqcw785Xvzd02U3LLLUzvmXEYhW+HaquqtJLJSZijVSF
         Z8pYEpSfMdKT4JDfQjZWCtoI6zeLtqsGGzJXY88k5faN06hZhvLB2jWDKC6Rv8wAuxbv
         NesFIV9S0y9ci+IMLo8VJih+E15FfjUh81KQsmBAP02AU8XiHfEVf+0+CBzf+oip+XB3
         HCKC5GSD0fDneUKTaU8BExn6V5CKjVB5Enuxw+FngrV8N5dnDh48GJrnuP2v6gfbAkEJ
         ID0TWoflc4zmcvnm8nD+SxccKltNhsxtES4YXCoNFIIZnbTzLP4TeSrpb2PY9ybVI3so
         9veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896035; x=1683488035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtToXMoswwiIDbPzROAaUy1N7OAa0gaev2fa8p7+U8U=;
        b=6/RS6yul7iXt+ltZGSvy2trWsCMX4nzC0/4IiJvR5Ie1YKXyQ994x2Ps+yPvnkFxea
         niNtZtyfP10jmREP4E21YFHAE2SR6EHVo3he4fUIC2PBubXW8PT+5WPvPg8KgErqqjt+
         7mYSlexMaK1t1iqvw8IrjqwGlFs5YrUbmEvG9xxRzkvuAH6VByqzPnIKIM/yULsgap9V
         LbcwafJTBdhTgpcdQFC+dI9TYneF4Y8YiaxjbFrpuEKvV10X1LVz3Az2mZ8ojY1apk6q
         Esae/MO/BB+o8Q76spm7azsUcTiomvohYjPMdeskyxt3N6cGtQCzq312yNlGF4EePlEZ
         7LGQ==
X-Gm-Message-State: AAQBX9cdaPZnL56PT6NQBTi88TCLvIwY6M5DKRXyD6JMAcNQupggzFdE
        LC9ctHGyG8dbErYjAx/41drnt4ApP7k=
X-Google-Smtp-Source: AKy350bVzsVdHRC4OXF3ICy6xS11M7yGusITSuakrrYdO3jXf2+iRm6wtnPx7EKIPjnJefznbK7/pA==
X-Received: by 2002:a7b:cd0b:0:b0:3ed:b590:96e6 with SMTP id f11-20020a7bcd0b000000b003edb59096e6mr1918912wmj.4.1680896034784;
        Fri, 07 Apr 2023 12:33:54 -0700 (PDT)
Received: from penguin.lxd ([46.69.195.17])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c471200b003ef71d7d64asm9444493wmo.6.2023.04.07.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:33:54 -0700 (PDT)
From:   M Hickford <mirth.hickford@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, mirth.hickford@gmail.com
Subject: Re: [PATCH] e-mail workflow: Message-ID is spelled with ID in both capital letters
Date:   Fri,  7 Apr 2023 20:33:33 +0100
Message-Id: <20230407193333.1620-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.40.0.1.gb5238482cd
In-Reply-To: <xmqqsfhgnmqg.fsf@gitster.g>
References: <xmqqsfhgnmqg.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LGTM

Reviewed-by: mirth.hickford@gmail.com
