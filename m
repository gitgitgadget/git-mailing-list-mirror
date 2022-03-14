Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2F4C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbiCNQ05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbiCNQ0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:26:55 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C02AE9
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:25:44 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so20954267ooh.8
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EPzxX+AkHaaQhvnlZpdGlqOBS5Ly4McUecPfkz+ppDw=;
        b=LEwCZh0xW3LmyxepIOR0kUJBb6QEjgTfDeri7X6gIGZI8uTPNdQ+BN6QbIda0YyF5a
         dHdTpSCr4k8/anjtVg5ObXKMvd+lw1QbW2qhC57qF5QZeY6FXxy4qyOo5K4vmVWagXrT
         J8aLorU/Cu6YduVaFBsi5mZvdT+2FHPRmO9kqLyYEVWxpQOI3iYVWdCijBmTbhah/c4e
         7A+MVQ67BMm0t8pO00I5HIDwSXECUdLaQE6UcE5VZ8Wv1wnkGK86DR07UgFi5eoIsJQd
         4MPxIpdynhuoARJwFBOfppUX+fswMpzls23ziJPq78qCWXxEzH07UjsOFOxAPRT33uaX
         kbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EPzxX+AkHaaQhvnlZpdGlqOBS5Ly4McUecPfkz+ppDw=;
        b=odPYhYWAeCUnT/Q3gYxtAN+Ln4XQgYg2qV263+OTCd6Eai73yTnqj6EYqhIFXMLAzx
         FXUa+h9mmfRKDniohcJ3x9G93QuuI+lvvQs2f0OUYPp2bDnJGi4qGoGNz6GqK3tp7ENX
         jLXPzc/Ygn7C4xR8LxBzjYbQr1c/u/DekwtJH57ErR3LqjvEQIVyLo8M0Q8w36251BOA
         ghpTst5rVQhDz8T9ddX07o6WutNlhQa0OG6CqCDIaFqXgOf8sS/DXKyMB4XOjMfJmuAr
         2svQpxtsJJVzmIYYeg2e2AfX6GkqnTBS0sMvfwvU3U4/USo9NJK+emztqmHjeR733WH7
         hBEg==
X-Gm-Message-State: AOAM530R2sJebUNQB+45tGqLCgXK3SNmmjgYr2C+BLw/35ITUYxVUrI1
        Hys/3CJSrt+fMgtSrHF7SOLu
X-Google-Smtp-Source: ABdhPJzROqgCySNTFEM8yD5KEPrnWetMzGl3jWonKai02UrbXrk4y0rh8DQkR62JZLRlzM4fr7Nu3w==
X-Received: by 2002:a05:6870:32c9:b0:da:fd0e:25a1 with SMTP id r9-20020a05687032c900b000dafd0e25a1mr32709oac.26.1647275142926;
        Mon, 14 Mar 2022 09:25:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q11-20020aca5c0b000000b002ecaf985db8sm3904240oib.14.2022.03.14.09.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 09:25:42 -0700 (PDT)
Message-ID: <e38ebbfd-3ce4-6900-97e4-74b987c08b7d@github.com>
Date:   Mon, 14 Mar 2022 12:25:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq4k41vdwe.fsf@gitster.g>
 <20220314154638.59046-1-chakrabortyabhradeep79@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220314154638.59046-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2022 11:46 AM, Abhradeep Chakraborty wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Why can't you specify what should NOT come before "fetch" in your
>> use of this helper?
> 
> Below is the event triggered for non-exact OID rename -
> 
> 	git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
> 
> Derrick told me to not depend on other flags like
> `-c fetch.negotiationAlgorithm` etc. as they might be changed or omitted
> and as it makes sense to me also. That's why I didn't specify those things.

This reason is something that could be mentioned in the commit message
to motivate the change to the helper.

>> I wonder if it was more like this that the original wanted to grep for:
>>
>> 	grep '"event":"child_start".*\["git","pack-objects",.*\]'
> 
> I don't know about other cases, but in my case, atleast I really wanted
> it.
> 
> So, In this scenerio, should I stick with `test_subcommand_inexact` or I
> have to see other helper functions (or make my own) for it?

As I mentioned earlier, it seems that

	test_subcommand_inexact ! git fetch

would actually work for your needs without changing the helper. We will see
whether or not the helper needs to be updated in a way that that line would
not work anymore.

Thanks,
-Stolee
