Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE55C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiF2NF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiF2NFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 09:05:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB223056A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:05:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z16so7063251qkj.7
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WPBgTaffHo7NKpTKV+e1bJcrL57qmkB1pwoAi8Sp3+o=;
        b=BSU6rpQZEFzpnZbnqUkDbJ/aRm0GUSx57w1UfUrmK2oBBdPO1RaLelaOR0VJpaxzOi
         LJ+9XcsPciiY7iMfy7Tf7WcDl4Pz2biKmZzmHVx6IAXKWqrQ7fV49SgiuA+9Rb0UrsrG
         llKFAcZzUOpj2zaGwUxWZK5wI+pkAK3z3kW6M7OdoO2eOHX9TSweKPd/ucom9wFF6W1Q
         vI3zFcwaUWMHeOFGOzKcDIDP3S71mWf9ll/gurjIIVSDbiqj14TWLscEJwxVe7QapgTS
         mcZwXNyIMWjXdoVtIu/Q6tKMkT1ajHPUkcMNnJyZa6pZb0yFO/Pv8XOYCfKA/FZ42176
         FpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WPBgTaffHo7NKpTKV+e1bJcrL57qmkB1pwoAi8Sp3+o=;
        b=3mVrkZP8vANlssWFo4hfCtWHBMqrUj8F6l5jdJVzdha3PuWGz1kbfHojCTPd4yihvr
         vcNNivDeUJxY32tOJpWDu3X2+tKplyrT+sRZrFsYUhfZI8OpfhGTNHoXmfiVukvbOTAo
         s6nmPA86tc4r75ZuVPjs9fxTExyIirvuLqlIzH65tkdGZoazSF1kHjwefcdY9gDkTccK
         3SWr7svzl797AVFo6ceEZEMDRqDysFiGF7FUZ7VDl5MABekOJcwK4g86QQHsqg+uXdM5
         ILjf/GF1UJf1jwjKnA9NLKO/phCijrjQCSZEG8pAy3R7uDkE0e8To3+N+Ur8Rpip/mOX
         plhg==
X-Gm-Message-State: AJIora8XMLuUaTTw00bAyElP6I+fGxlGouNymTX/QI5SPTvZZD/90iVZ
        daQOyad+GLOR2O4aeoLNMJrQ
X-Google-Smtp-Source: AGRyM1uBCIWIcmjGbQ34GWDzUTVgg9XPYJIeefQacHXAV9TG+vSSoBefqk6+Mkpzb+uBgGhBHEWnBQ==
X-Received: by 2002:a05:620a:4048:b0:6af:ce0:cda8 with SMTP id i8-20020a05620a404800b006af0ce0cda8mr1876202qko.698.1656507945665;
        Wed, 29 Jun 2022 06:05:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85ac8000000b00304e70585f9sm11586184qtd.72.2022.06.29.06.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:05:45 -0700 (PDT)
Message-ID: <f2af844e-fc6c-94fd-7cce-0451f57c6576@github.com>
Date:   Wed, 29 Jun 2022 09:05:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
 <xmqq7d50ij6f.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d50ij6f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 5:15 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
...
> It would be nice to also have a test that makes sure that other
> people will be prevented from checking out a branch whose tips may
> be updated at the end.

Patch 3 adds the tests that 'git branch -f' cannot update these refs,
but I could add 'git checkout' tests, too. They both run the same
branch_checked_out() helper, but they are doing different things once
they have "access" to the branch.

Thanks,
-Stolee
