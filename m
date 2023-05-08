Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF28C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjEHVfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjEHVfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:35:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB39038
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:35:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6434e65d808so5370649b3a.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683581711; x=1686173711;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7Tsru6d70Ag1kt0RdMfAIqRM4sbBr+5/0Dz8vf/JNY=;
        b=FFqv9WSxLXR1Rk/X0KxZf30phiAf2mBiGYlyTkmH8xSj45u32gD3qHYG+RL55tI3IZ
         tNuSrsiZ2BNVAWwz1SiGhoLCaOaaN9qx1pQOYpHAxbBAjbtpkCYMkLR8UbaNXA0qVqXJ
         GxPCS3aDCtcg4fdfqMfSAlsjr1UUUiTH0s32vsHd30N0ftltaF42Kk04BamCjT3eNWwl
         c4Y08px8HHLUvtwrA537nKStubTFgE+CXMARgps01+WEmrpPfWM8AsatmTxwv49xUiae
         SDdfEg+XyhF+/PSlwVh+oCSI/TPLCoYhZybPfsjjIV//a3T4OlQHDseS0esiSlq5sRQm
         D+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581711; x=1686173711;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x7Tsru6d70Ag1kt0RdMfAIqRM4sbBr+5/0Dz8vf/JNY=;
        b=RRjkDkrJzViZUQ89RF2i7TPWklzunVmlJGUBNoSgQd6MuGYjj1b6PZLh1PCNTWU+px
         V0mW49+82S9iQ9BKQEz68haGqPU3BAS+nsN1B1+HauTEqQCnHNrgtSU6FsFB3VRQOdew
         yfY3GwnwoUNOdWEatu/Ts2ADJtvghQn0p+HIfw8AREmcu1hRm7BKFyJuznn1sBu1Z0ar
         hY5VH1F/LTPN/eMQcxqvGpJeeil64XAYgux95RFwGNP++YLpR4Kbk6WHF7vFntnSh0zA
         xMhIfoELP44AdKpwXNCaI2ZbU86GSUAfj+FiC7PD9kPqrecw26aNsUQv0ItkbZJspOL5
         wryA==
X-Gm-Message-State: AC+VfDzSAo8BfQ5ssO1wAaqpe6FLroHm6iP7GO+WYQerAG0jRri1G8uZ
        VXb+tKD/grnx2c6Uh4oByT4=
X-Google-Smtp-Source: ACHHUZ6kURTX2dH0bdOQUfFRbFd7ncM8MXbL5BnSzOFj15wCrFxM9sk6INR9TIfH9zjuDYAKpcMO4Q==
X-Received: by 2002:a05:6a00:1507:b0:647:3de:c0ff with SMTP id q7-20020a056a00150700b0064703dec0ffmr70192pfu.30.1683581710643;
        Mon, 08 May 2023 14:35:10 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q18-20020a62ae12000000b005e0699464e3sm361565pff.206.2023.05.08.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:35:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/11] doc: trailer: fix grammar
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <12d4850a9ab8659c40fcb6470caf8f98d7f6e486.1683566870.git.gitgitgadget@gmail.com>
        <xmqqpm7aoclp.fsf@gitster.g> <owlypm7amxdn.fsf@fine.c.googlers.com>
Date:   Mon, 08 May 2023 14:35:09 -0700
In-Reply-To: <owlypm7amxdn.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Mon, 08 May 2023 12:33:24 -0700")
Message-ID: <xmqqa5yemrqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> which cannot stand on its own as an independent clause. The correct
> version would be
>
>     Help parse or add 'trailers' lines

You're indeed correct.  Thanks.
