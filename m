Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B59C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiFWPLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFWPLB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:11:01 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9E33E18
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:11:00 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o23-20020a4ad497000000b0041bd038b4dbso4062905oos.4
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t3z6kwjykFgrhEWVmHVojmZiJZFkZbCkeQN5RVljeiI=;
        b=UN33Bm4/T3UkS7HSxD00OappRtkQHl7Mp9AAkyofgZ68DZ4lfqsGbHREcj9kCpUM/l
         sWy6M4UjbFWXRAW/027xp9Jo5pEDxHGN/rk6JF7WKLAeNXG4XDEznlO2puaSQVvMmVbu
         550nRI9K6KKdRVlGLc0EFwHBthUVge7LvFXIq74i5enLT1ZWb+lqiuUtUIxJV285l7c/
         R5a7aNQfULKdzdjWMG0unbi0OqvbYpkxCKk98tWRgyyZn7K9x6GAiiyyXnmd8vAKp+sH
         b8azndf4v0b359GQ3DrxP3s0ufr5t1C1+6c1s/Re3IXNksTw6ouFcsijGGABs1cnrTzU
         UGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t3z6kwjykFgrhEWVmHVojmZiJZFkZbCkeQN5RVljeiI=;
        b=P5mpqr7DQy3qy3G1ty9jfgW1DOtZvrmaCbKO8vUlmWxLhWTj6UR+KA9bzHNB2HWa0E
         OuSgIguDru9QJNvMN5scv2x0trkAGfqozEXgDcyJSop8onyWE6xhKVLN83yAE4Lx2hZd
         rLGyqqApj5g8Vv1KFvZme1fGs2r2xawSCKO7WqWyWKyYxGZ2/ZUwl+UGN3bbwmiUcMnP
         aNLO535dKqC54DxwDANVzdVQ90vjWXPnPuu3mN1sObs625+avQ7X5/iMqmK5oYF30PWM
         xvY4t22GiWwjxvz+mn8z1BpYfaYe13R1NiojPqMVHMmJ03QHiDuzFwTnBBproMMtq9Bd
         0vGQ==
X-Gm-Message-State: AJIora91EBsUxAZDjhwzEF4zni+UeAMfBkT6BifRvZhSZg1JItjxYVjV
        17cXLPGmp/DEjvhI9dH2SrRm
X-Google-Smtp-Source: AGRyM1tSHlTDVDaMrG0FDhRJrtCHZcXjEdJahHwHws8bmbdiE9Sd9F+nzVGUsH8y3q76bzr5Mdng5Q==
X-Received: by 2002:a4a:84:0:b0:41b:8bf8:b8ac with SMTP id 126-20020a4a0084000000b0041b8bf8b8acmr3939558ooh.36.1655997060217;
        Thu, 23 Jun 2022 08:11:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id a16-20020a056870b21000b000f33624baa4sm12515607oam.18.2022.06.23.08.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:11:00 -0700 (PDT)
Message-ID: <c232ccf7-1f73-030c-b7f8-02bdef342ba4@github.com>
Date:   Thu, 23 Jun 2022 11:10:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 6/7] mv: use flags mode for update_mode
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-7-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220623114120.12768-7-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
> As suggested by Derrick [1],
> move the in-line definition of "enum update_mode" to the top
> of the file and make it use "flags" mode (each state is a different
> bit in the word).

nit: strange line-wrapping here.

> Change the flag assignments from '=' (single assignment) to '|='
> (additive). Also change flag evaluation from '==' to '&', etc.

Code looks good.

Thanks,
-Stolee
