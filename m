Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE1DC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGMVD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGMVD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:03:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E842722
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:03:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b89f6463deso8403835ad.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689282206; x=1691874206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nakuzP+LV+N37E4XXfNSMK1ItlqaqCFlCxFzI7QIf3c=;
        b=ffQ2OpzmR2EEdAjWI3I0OQh+MiuYSgZImQMM0TK6/3/yCxxj0LMUlvVyJ8s3UC9Rl8
         Df6JLzlPAJw6EGvSphQKQeoRUUX1XiL9tP/fRTIoFcLlrs+i0CybiRGtGTzu1Mp0UsjN
         TvWf67tFp26oLBc5cU6woocbNMCla7RCHJvAbEo8LVXx9Xyv2dD5RbCu92y+la/uvYDN
         UvgvGfyDWId/zWc4KqHIkG5vPwxfQI0ApBbsF+kiO6+ePUlSHTdiK/OGN2z5REAq/DL6
         yTvJJlADS/fM+Ejw+0CJv9E5kw8MavaY7n9IYKUJ3iRuwyBYa5ukCSoSsL2UtjYOs5dn
         TzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689282206; x=1691874206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nakuzP+LV+N37E4XXfNSMK1ItlqaqCFlCxFzI7QIf3c=;
        b=VCMir990G7lBZKf4gbE+/0ZQ4FFz0dNc8wanvefXvhb1EKkFPb93/2zQ3HW6UXI/Kq
         dPtpKxM2olbxJ4dfJZHrKy/NP/8efjObvPxYsBF6dG8/GSKfaw9iDNeABjLl4UfkqTIr
         plVmSosuEEFpeBGrbZX8ZQIDl3rmKd+8k6ebEk+t2+8Lfjjmmui2LQkETUQsAXV74oBt
         vifzYOX91hem4cXZFUgNPwM7rWlHLX26qGVC2cUbyVueh4KmT9la2jcGqDyt9awmO4oR
         7FIk6wj1VhqdsmN6rnkYCqTuOUmvfRPjNZBsHVNP3tTOl43wicuwp/z5zqoS0j8Coyp3
         tNKA==
X-Gm-Message-State: ABy/qLYkL1oA9UTTh1Fy6qEmfMo8EVLG5D1QnbqFHzxcr1kapwgaPl5J
        QmZPQO8tq4BlbbDgbdcyHmL5ERAxgRU=
X-Google-Smtp-Source: APBJJlGC3b6dit4csNJgBNWR1q64eGivwZYFYui5ToXv4nPf9cmxxT4urI5JOXw1fgCkZ8WOmJoZmVt8LGg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:6b4b:b0:1b8:921e:e1a3 with SMTP id
 g11-20020a1709026b4b00b001b8921ee1a3mr8749plt.10.1689282206256; Thu, 13 Jul
 2023 14:03:26 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:03:24 -0700
In-Reply-To: <xmqqo7kn6k21.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
 <203ed19dd1b72a8085af05359d5a226b94fe2c7f.1688778359.git.gitgitgadget@gmail.com>
 <xmqqo7kn6k21.fsf@gitster.g>
Message-ID: <owly5y6nh6cj.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 2/5] SubmittingPatches: be more explicit
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>
> If you leave the body of the commit log message empty, can we
> at least have a bit more helpful title so that it is clear what we
> are being more explicit about?

Certainly. Will update in v2.

>>  [[base-branch]]
>> -=== Decide what to base your work on.
>> +=== Decide which branch to base your work on.
>
> Technically speaking, what the user needs to decide here is on top
> of what commit to base their work on.  There may not be a suitable
> branch anywhere.

Good point. Will add this in v2.

I think what threw me off originally was the internal section link name
"[[base-branch]]". I think that could be reworded to
"base-starting-point" or similar.

> But this series will be updating the section even more in the later
> steps, so let's read on.
>
>
>
>> @@ -317,8 +317,8 @@ Please make sure your patch does not add commented out debugging code,
>>  or include any extra files which do not relate to what your patch
>>  is trying to achieve. Make sure to review
>>  your patch after generating it, to ensure accuracy.  Before
>> -sending out, please make sure it cleanly applies to the base you
>> -have chosen in the "Decide what to base your work on" section,
>> +sending out, please make sure it cleanly applies to the branch you
>> +have chosen in the "Decide which branch to base your work on" section,
>>  and unless it targets the `master` branch (which is the default),
>>  mark your patches as such.
