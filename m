Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B51C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBMIiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBMIiB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 03:38:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7ED4C0A
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 00:38:00 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k14-20020a170902ce0e00b001992e19d3beso7002751plg.5
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 00:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYmJZ2igVcihyTv7GtLg+2rZY0h0syCIiDrjdqZ/wGU=;
        b=I8eedBvANUUthYXBZbcixdiPVjYpLctKYua0/byMWvPoPYAlrhX9PjReuq97I27XFD
         MfR4HoyIFbceDipKOoEyyswjR2SJi95RF1qBktvVXx6OiT2zp9+ljguKTt8+OxXcINo+
         BzF+HUmG5xmnuDmhd5M5OWoz4vHqUZTPqswMGUVHO+aatMqy9soac0tHFXADRa2vTNbC
         jemf9WX5Y5K0M3J9Z2nJ32gxrS3Rlf49UvJBidN4EmSRsAcjtjuFkbL6u+/kt9K3yVTG
         mGbh1QnRfKSl28FAIz9FhV/myldSddQ5F0cX8mKrqAsV0VEm+UH4pFndmKi7vRGL4vib
         swsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYmJZ2igVcihyTv7GtLg+2rZY0h0syCIiDrjdqZ/wGU=;
        b=sDIu0Jtz8WlbSuwpwHXuZL1JckqNX+Yqu2WqKEEQuyLcOlefWlJRj7dDmV+aPAWsqZ
         8b+zA2EmevR7Ku2ahajERmtRmyRBMPpEGQXutCbQ+MxmYslx8lf4VG6pu5Gxvbvtxz7b
         dhUYUqzKZaA7GYGR9hRc8TSKTeAslQaOATjFURm0+OnGXp7vICQVs1IOnZ32xr6BsKd1
         iuG2/P2Vrite3ktznHNtVFDmBwQ1j/2z77isCLPFiG9doQ0He44oN9geIND1PBB5ebDU
         RAo32gyJaVhKIQAdd7+Ur/8KRsqJf9CpqgbgUq1KnQZuYq/9Dktp32KQ0fjzr0uQO2su
         efdQ==
X-Gm-Message-State: AO0yUKW8Y+HxCPVF1o8WnBDFlkNRh5ndTWZQf9VB2o2LWVsKMt/pimay
        MyqypKdhT8y7riCsjJ2aUK/o8Ziey6rH9A==
X-Google-Smtp-Source: AK7set9L+P339s7G5tJokZe8CnEmIWnvO1C+PCG/o9LfMtKccV9MwQzinq4f2pDls7iYxzuQM2u/KGhieBR93w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:250:b0:233:d38d:dcfd with SMTP id
 fz16-20020a17090b025000b00233d38ddcfdmr1013029pjb.106.1676277480427; Mon, 13
 Feb 2023 00:38:00 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:37:58 +0800
In-Reply-To: <20230209000212.1892457-3-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-3-calvinwan@google.com>
Message-ID: <kl6lcz6earkp.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 2/6] submodule: strbuf variable rename
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Subject: [PATCH v8 2/6] submodule: strbuf variable rename

This should probably be "submodule: rename strbuf variable".
