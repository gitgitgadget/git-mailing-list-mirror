Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB773C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87ABC63211
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhKOJPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhKOJPY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 04:15:24 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B8AC061746
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 01:12:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c4so14481546pfj.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 01:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5P4feqVojzULQKQA1XvOxra1r029hhLVyvfBjZg9jZU=;
        b=ViBeI1xAw5txM8sM0rR2QCYYz0NSCYXA50LvaPsAS1qocdubP2C6VasS3yTK0FPrzI
         937JZpWJQPlfdu0SwkYHH1p7gx8MqwSMvAr/4RYTJ5zTWTlWSSevNo26bHIffk9LHg3q
         /gxYLlMi82Vlb4RIW7zRerna2/dp2x7f9+A8xhAr6sHMaIFIKdtd31HS7lFkFOv5shMZ
         pntwfHYh4ANSDivXbo4iHE3jydpLTd1z4tc3l+LUxLko3CwB13EI0I0hGBVd8E7Mp8X/
         mC6waXhv/sMSBcvKqnUg9XczqPTkQC8CT7HFITHXYDQJLgiLe6RNBKp8DqnX9/bakQ6M
         UP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5P4feqVojzULQKQA1XvOxra1r029hhLVyvfBjZg9jZU=;
        b=NWQxe2iq3/flUvk6QzyaqMjuV9NryT7M1OQcm4Tv7XQxSyL4LgrBO8IuQYWrHBFkip
         Kq1p3QKc0BFSXbF9j5AkOlZ/sTZ7SBudgfRpGRmYQukVkvzGXRK3IWc92XCzz6KH5Vzi
         bCRxnyplmrpXltaZc7yMKR5vCVLuyfiLs9veXhdhalOXekuO1Sz7webotLqw7CcjL/r1
         KmmIKGjCEnBlN0ySgwpkp4oQrKOtGr9RmOP3OssS6Wq51b4Owr0nKIeds+iK7YVsHI2c
         C/JTddxTToJNu8ctx13fzpLV8OYpEL+Ho8UCXLUeqnDV/curR+DpDqNdAqWIKqh1auuh
         wuGw==
X-Gm-Message-State: AOAM532djogNsQhKeQsj3HX2n5vp/LAfCHJRkAbvLsTkfyj856XZLGX4
        WVmvpCkdAqwg5siua49sfN8=
X-Google-Smtp-Source: ABdhPJyTr7n0QEAmZ1hBk9c/kmrpBX5l4AeElRC+0Ny89DU0fRbvuQwUw0EvoFWzDJO1BIYyzC1vgQ==
X-Received: by 2002:a63:774d:: with SMTP id s74mr3956469pgc.310.1636967547611;
        Mon, 15 Nov 2021 01:12:27 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id pf15sm19461063pjb.40.2021.11.15.01.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 01:12:27 -0800 (PST)
Message-ID: <0bd032c1-f90b-1892-693c-518a01b3b671@gmail.com>
Date:   Mon, 15 Nov 2021 16:12:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: git pull bug report
Content-Language: en-US
To:     Erwin Villejo <erwinvillejo@gmail.com>
Cc:     git@vger.kernel.org
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com>
 <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/11/21 15.56, Erwin Villejo wrote:
> There is nothing to reconcile since the branches have not diverged:
> local is ahead of upstream. So I think it is a bug, no?

You have the situation like:

---o---a (your mainline)
    \
     b---c---d (remote mainline)

Your mainline only have one commit ahead of base point `o`, while the remote 
mainline have three commits ahead of `o` but unrelated. In this sense, your and 
remote mainline is divergent - you need to either merge or rebase.

Next time, keep your mainline pristine (don't commit any local changes on it, 
instead branch to the topic branch and commit there).

-- 
An old man doll... just what I always wanted! - Clara
