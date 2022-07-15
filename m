Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EFFC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiGOCZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:25:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B474122B39
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:25:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p81so2949182iod.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jwDV73jsvmF+tqJ4aal08kPDPY79HY4z/rCEjxvC2os=;
        b=UgPw9isy7EH9QzDAWOjkjclQqjfncRTxVqeZaYfdeXffp/xxKP1g/QGgtO52bQX6vX
         h4oRWiefjkPmrTAXoKEZ3Fq+9BMcl7C8hUzZTF04DOGZxHqIkte3Deh99wJ0cQEsWLvc
         QJ5NBp/igryc8DqLWhujGbdF/c0tFM+kFKHnbgK7qVZtvvQsJDkX82zrMuTHwx1T2v+o
         oAbYu5N3KMUoBokCLwxTimIuNxXlQlkkCv+H/vSX2n6dKK/qzAFnI2TFsQVGCC5Cvyv7
         9alJH21zEk3cYammfNn+IqYjZUtXkyoMEfNIuA0b4ya/n5DV0iUuuATkq+JZg7eQLARd
         wZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jwDV73jsvmF+tqJ4aal08kPDPY79HY4z/rCEjxvC2os=;
        b=dp4R2XJMVWeU06psWxAijVqvhBsXXtbFnU9q7aqB1gETFMhcQWs2AJNRL/b7jd2+5x
         QcZd+/152NgaZnaXgKfuF3lzTOnYmbVDqAKH7dZY5LAmhMmjGHzavBiEGfulv7i2OoC9
         YjT31/qTJAfp00dYYhMxCXvbG0qCM77Wu1CeN5S5UXtzF6Nv0/q7q28nVyjl+fCkCtj6
         XA+JwOEC5HRijtuFO50S+5sq6Zen/enWVAF242TXeMnXgmSZ9nc6YC+AFNnbp1qVX3vs
         Zi0wFHv3DHhWb98V2jiIiiQ0IVdmLtH68GOawMKd33vw/XZbKeJelL2UJpsh10NNjw6o
         jVOQ==
X-Gm-Message-State: AJIora/pLb5rkUbnxsK087dT+/9i4E/HWZRtib4n3IO+2x5pVqdjA6NU
        V2auEs0qZGLiEkpKwVWXXuNt
X-Google-Smtp-Source: AGRyM1v2BhfLH11Bnm0nvf5PGLU38vO7LonUb8z4wecinhDrr8UbRPpvfm9YR6f50cJDvIu+8/wQmA==
X-Received: by 2002:a02:ad05:0:b0:33f:6c88:b061 with SMTP id s5-20020a02ad05000000b0033f6c88b061mr6622892jan.172.1657851948134;
        Thu, 14 Jul 2022 19:25:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a446:d79d:69be:6b29? ([2600:1700:e72:80a0:a446:d79d:69be:6b29])
        by smtp.gmail.com with ESMTPSA id f19-20020a022413000000b00339ceeec5edsm1440843jaa.12.2022.07.14.19.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 19:25:47 -0700 (PDT)
Message-ID: <52d432b9-acda-16dc-2536-9b6c66279836@github.com>
Date:   Thu, 14 Jul 2022 22:25:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <220713.86wncg3hnj.gmgdl@evledraar.gmail.com> <xmqqedyoabqp.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedyoabqp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2022 6:28 PM, Junio C Hamano wrote:
> If we can rephrase without using these invented words, we should do
> so, especially when the result becomes even easier to read than the
> original that used "whitelist".  I've shown a few examples in my
> other messages in this thread.

Based on those examples, I agree that the best thing to do is to
rephrase to avoid the term altogether. This avoids confusion when
the reader does not know the term, as well as sometimes being more
consistent with the phrasing in the same document.

Thanks,
-Stolee
