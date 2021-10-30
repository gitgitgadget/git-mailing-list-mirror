Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF5EC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715F160296
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhJ3Uca (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 16:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJ3Uc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 16:32:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155BBC061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:29:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o14so21996874wra.12
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=klUfO+jmdXjhJPX6tdw0dcGfELO+JREevXrdgOeOyG0=;
        b=Bvi+iKXZaI/oOL+QVfXrKaH+7cC36bW0lXFhyqrcVNMZZfTCdet21HbJo5PEFMO15r
         T+x7FywwKpUpclwaBeSe1ucQ2C6XbgvcP+gARxQKwSJySaCognEfnbjS3SAwRppYIbfQ
         TwSA/8MS6xwO8prO6ShQpa858Uajv0JKnomimfuj5khoKxEQyG43dGDHweB4u3yxN9Ad
         v111+CRbvwG3+AYPpk/mPuSw5WKWsYyaCjQ+Od6f5kQK9aRw0160BazYkixLU1KkTRne
         3oyPFEYxaq/ksgod0ROABqHYaetQXGuqO5fvr3VZhWhSe9p7edACY5mDTKIH0GJonGp9
         9pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=klUfO+jmdXjhJPX6tdw0dcGfELO+JREevXrdgOeOyG0=;
        b=WKHruoPjrLZ8jJIUOjHcqNhAX18lSEi2dMIrFf2uD5qxrMPrq3bwrarv47goJqNF/O
         ATHI9ghnFE53ofR6r9VABMbPnOcVgNQdHKsxD47RDAVoMsXGck6ZNYjY/QCIgWeYYVgu
         pnwygLXgPZB1r/yG2MCbrP0CGMVHzVdE5CJfDeVRfvG793NlODhUb5u3lF03sl1bNzTN
         sZFqfBLw1k2CG+cvsosjrSwxqMcTHxUAwTzulAYGNJ7W7i+EQLynr3Sop+SrMbqWl97e
         N9RpxgFzpcwCdrLSgSoWYM5gABhRNxW4WHqVFpmKb1MOH4vSYGhkB9oPXljCA6oAN4lS
         ZTCQ==
X-Gm-Message-State: AOAM531p7scAR6NktVh7sGBdk8Qp2djGxpZzNm0QJozlhF21VqmwnG0b
        wSD7TsMSh14E8d3Q5Gn/9oqXBtxIpig=
X-Google-Smtp-Source: ABdhPJwVmM6jLepg6lsBQtADOQc1AhtFJQOLnYqttmMxN63/aZJ35uHbMsSPEzCbgyPCOEteuJx3Hw==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr25289901wro.267.1635625797103;
        Sat, 30 Oct 2021 13:29:57 -0700 (PDT)
Received: from [10.8.0.130] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id t12sm8665190wmq.44.2021.10.30.13.29.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 13:29:56 -0700 (PDT)
Message-ID: <1c47d47e-f0bc-fa94-b099-4f96d85bf47e@gmail.com>
Date:   Sat, 30 Oct 2021 22:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: Replace setitimer(2) by timer_settime(2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

POSIX deprecated settimer(2) in favor of timer_settime(2).  Their 
interface is almost identical, but that the new syscalls use nanosecond 
precision (struct timespec), while the old one uses microsecond 
precision (struct timeval).

I'm goind to put a more prominent [[deprecated]] notice in the SYNOPSIS 
of the manual page.

I noticed you are using setitimer(2), so you may want to consider 
replacing it by timer_settime(2).

Cheers,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
