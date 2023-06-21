Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CCCEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 18:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjFUSUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUSUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 14:20:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5A1FC0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 11:20:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686c74183cso3855672b3a.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687371604; x=1689963604;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VJVvxv8Oftxk22V9FxNoC3YG/TNjw5WKkmX0EcvW+0=;
        b=RjBAG8kfmwyntZwOzKa8z7cqrVLJzH/hS5JXvhdz0bj/H7j1j7wL4TN8bXRlVTE/xA
         PFVNJoVX095ylwKfPtEEoucYIpkgXqdKt16sPYy5FnulD2TzmsvwmaxKsVunaOtvBNqq
         5s6buqqlYs8XduP1k62X6jA42F7qhd17p0rkV730iyFTY2RkBodNcX20bIp6wb8j0hTv
         uc1upLiYWukz7lLRDc5n8nMLgZoXJws0miMZ0nfP3uG2dhgde2LOnPT2Hwm/viOrZx3k
         Y2aURtTpolYYESrVZ/6T6uWzZJDfP0gTqLmfUfx0TlWDXNf6EIZLj3e09gO4/AcdsfBb
         vYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371604; x=1689963604;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VJVvxv8Oftxk22V9FxNoC3YG/TNjw5WKkmX0EcvW+0=;
        b=lB+Z4DgrOH4GdPE549pH6LhN4G++BLsueWymNEU2XmJsy5cvLETb0rSE0ztIk6XV8w
         ZcthGgCnPju8Nzxyu1LSiS+FFXV/oESd3g0p0CQkii58b2AlFJGwBtggN7TB9qCwD4Dy
         F5wDfBn6i/4ANpXzTERP25L+ervb1fPmayQMj5w5wxvvv/XIdzdbYu7PNMjMWKw0mir3
         ftXfqaxYucRrwpMs1iFFFuNfi+5F1T1F/PGM+QjNsGHiCkyAdcUFL2Vik22iiE1FOAK8
         AggeJd0omQBrTaKLMH6OUGP6B7XXnpvyOj5nDqazKSM/Xs1IJryyJGqNnrdci3iYvUIS
         Io5w==
X-Gm-Message-State: AC+VfDz/5QciDmg8CRkfqnJH+jBZG0OaOemPRz5TT0Len/m38kjJr1yz
        3FxNvrNCEkDHhpbdUtZc6D0TJGGtlMQGCQ==
X-Google-Smtp-Source: ACHHUZ5xQcznS3xuFEO5Jk6OA33g8Et+HZ50oTCuCqbKAb8QwAaw/kmRXY660DQ5CE2JqUw6v2JDKw==
X-Received: by 2002:a05:6a00:2292:b0:668:731b:517e with SMTP id f18-20020a056a00229200b00668731b517emr14094054pfe.24.1687371603566;
        Wed, 21 Jun 2023 11:20:03 -0700 (PDT)
Received: from five231003 ([49.37.158.127])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78d12000000b0064f2bbe2d2dsm3200140pfe.24.2023.06.21.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:20:03 -0700 (PDT)
Date:   Wed, 21 Jun 2023 23:49:58 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZJM_TjBtJVYVD5P5@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 4 post is here

	Week 4: https://five-sh.github.io/2023/06/21/week4

Feel free to suggest any changes or comment on or off list.

Thanks
