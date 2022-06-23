Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2BC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiFWPIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFWPIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:08:52 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38D27FE0
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:08:52 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so27006155fac.13
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zRSF0q4Lh6HyM/TWDIRgkSPqE8Cr0bjKFi9QXBTJNQg=;
        b=i4blSl2OxCKCTYBxfg2qIY9mdB4EIebhPlBDM9/RzMy6LGGmW60ET0W9JDbQ+splix
         90Cu688rKu6Q9hNRq+ff5buFAwMrl+W1e95D7R9NzPQ/gEjIyZUdIh02XlJM3ryX0etL
         vikpAFTyKUlMo37CYJr1gdqlYvqJ8ESL59ArjHRoRFCJdHyobOSPjiUClNsBrhncGTrx
         XFFdKHMdxFKkLhgeMw1s+lp1gTEKxsjBHigONKZmgqrLDB3N/M1RRxav2H7U36uAZp2k
         Yl2Ydjkq0N9z1fKLvE7k0oslpvR9iTC6vt00UP0zftK4/hhLf0ZVltfF5cNccbrdALM6
         j5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zRSF0q4Lh6HyM/TWDIRgkSPqE8Cr0bjKFi9QXBTJNQg=;
        b=6OifIPWVjT8MPePbHQTA91WM460zz29dzZ63/VZV94NtP+AJmJsa6ZwQuMqdtH/2L6
         A7cYAyckIoYA44LN8AiIJpG3M0jhoq8g4N724IzwmmhfhoG4056108nGV3xqZQ8XKb+F
         1EJunTkyPAhLk6oAjO+H3HLc6HM61NuDoRyuO/CXUpdDJ+9hZMQNQEKX8IL6+w9ZLKf4
         QeBKxRDsBCwqkF1PK0s6RO1SolbYlUy6FIfYPvbe+CqBKySJND8ldphzenOdNyTaiAuB
         4/ret+LvGqjxzEMpdHg1y8W4qWi66XkM2wLRbqyPluI5L++tndkGEAt4ur9zolcGI+GV
         ZXKA==
X-Gm-Message-State: AJIora+z/3LcBRpX4QvT9IGkAM2yCW28337wL03x2kPwQYhjSQDfa/MX
        vJhxopFPC98U+NH/6qqS2UI6
X-Google-Smtp-Source: AGRyM1s1kpTWqGYIVpjXd+ixAxmG6Lv8Gyhyb1SVkiOY0RDvbm2xUhSNCKrI7A8904WNnv7YiM4FWw==
X-Received: by 2002:a05:6870:1601:b0:101:5e61:d8ee with SMTP id b1-20020a056870160100b001015e61d8eemr2903129oae.244.1655996931568;
        Thu, 23 Jun 2022 08:08:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id x12-20020a9d588c000000b0060c0fc441bbsm12702690otg.36.2022.06.23.08.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:08:51 -0700 (PDT)
Message-ID: <3e84bdc5-31e7-a7aa-8404-228424810f35@github.com>
Date:   Thu, 23 Jun 2022 11:08:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/7] mv: update sparsity after moving from out-of-cone
 to in-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-3-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220623114120.12768-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
> Originally, "git mv" a sparse file from out-of-cone to
> in-cone does not update the moved file's sparsity (remove its
> SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
> not checked out in the working tree.
> 
> Update the behavior so that:
> 1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
>    corresponding cache entry.
> 2. The moved cache entry is checked out in the working tree to reflect
>    the updated sparsity.

Since this is a behavior change, can we test it? It would be good
to verify that the new path exists in the worktree after 'git mv'
succeeds.
 
Thanks,
-Stolee
