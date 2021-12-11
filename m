Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3176C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 08:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhLKIjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 03:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhLKIjx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 03:39:53 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CED1C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 00:39:53 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y16so12880142ioc.8
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 00:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=my6vpCLL3hQKFgqfzyw+tZSdlciXtQU54fIdgPI7sWI=;
        b=FaNP0lQq7iMoSRmS2vUGKn1FIK7HH73KQeUANkBtVcdziR9fcjoEG8/7ux+5ARDWxA
         0xblbhTFwZsmubVQB6WVlZf0+mTXspm+yCZMq6sx3UP50E1WOPpiHK4RdQ1hNgU94j1H
         pJYdl4kbztZ8zREY1JuK6SwckalzeFwkpIQDABR7I3O81YSFNaFpCLfm/t0kC/EKderB
         vt8DA1jrrHJeC+rHKuybkatlSRTuCU7t67c95QsdyeHnKCO0A1ni9N8bqfVLF30g0aGU
         dOgc5isxsYJkwEF9tJNLLJ0y6p5v7xfJEp3wyQvpCVmPFMZxJqoTQaEn/0rIGVmryR3J
         SqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=my6vpCLL3hQKFgqfzyw+tZSdlciXtQU54fIdgPI7sWI=;
        b=dZ7ePXFrwahw24WOFJgD7Ps8ChsRUFbK6CabTwy+MEzM5Vz6sXJGerF1WLQ3midQVT
         z1CtAJPDDsOTwDOxxCSJf3uo4jrZTYIGUAyj3GgKRyAD93EuEyBhimrqff7xq4qiqLJo
         695zwIEWZFJVCsurU84WSHCPVHcUVvuyPUS2tJD1XZD19u+ByBgaFQWJx74xxTCVmpe0
         hoE4ssBBrwdfqkpDmML2n1vpWgyJeN13gno/AKUxIkCpsyg+kJ5ZsfotzvogmxxWcW+5
         zkh4ppEaY4XKb+3Ve8H1HTTFA4m2lvZvax0ifHWTrnzzE4pOzvc3KiZUu8qeg63+9K4/
         QIGA==
X-Gm-Message-State: AOAM5309Cs6hLUoFEwo4iPL+wIXAKbrNEQMZgPRNMpktF3OQ9cfQB3dO
        2NTqLSU3AjPTozVqdKrOKYZGmru3tzckZg==
X-Google-Smtp-Source: ABdhPJyExpTPg2JSqtTwaFLXn8pzYZKBPRjx+moVBw7BLKVRrzdJVQs5qiyXRgQ8cIuEqA3xaAtt8Q==
X-Received: by 2002:a05:6602:2f11:: with SMTP id q17mr26066669iow.75.1639211992594;
        Sat, 11 Dec 2021 00:39:52 -0800 (PST)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id d16sm3664410ila.51.2021.12.11.00.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 00:39:52 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <93deba56-1613-d468-8822-c0a9a1370bef@sunshineco.com>
Date:   Sat, 11 Dec 2021 03:39:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilvvluoa.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/21 9:52 PM, Junio C Hamano wrote:
> * es/doc-stdout-vs-stderr (2021-12-04) 1 commit
>    (merged to 'next' on 2021-12-07 at d6487c1256)
>   + CodingGuidelines: document which output goes to stdout vs. stderr
> 
>   Coding guideline document has been updated to clarify what goes to
>   standard error i nour system.

s/i nour/in our/


