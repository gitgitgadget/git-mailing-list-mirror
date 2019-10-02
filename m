Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95461F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 12:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfJBMJQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 08:09:16 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37232 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 08:09:16 -0400
Received: by mail-qk1-f180.google.com with SMTP id u184so14694891qkd.4
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F3saOuElTFL+/n4RgC17YCW26ALQ0xQOemKgjb7ToHY=;
        b=kRgUBFK4neMbb0aBpqJIJXv500IeBDhCajVO+2DXdCYwIgSC49Gi+DuKhQit+evqQb
         lDLxpJ+yxGQSg/yLY0mUQiqRDrQDvGfBBzF2NduIb2GrO4yQhexhpcwoKP1CIKuPwdzM
         lMv/x3Rpjk0ePCGchaEa/Sbup3k2DazvaKtHImwVfqVWtW5iYCmoJCK6EnW72xSTeiQg
         KV+m6/rMOEt+SWp0LbP18mVRSgxf4rCvKuNGmEbtwbS8C96ehcA13pIJNvlv965mpKrE
         Blpzk9l7tW9tVjELjvjUlwgMq9EoRmJmGg2u5SjNt8gTABYAxax+O9xMrOp5ngbXkdzw
         Ghag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F3saOuElTFL+/n4RgC17YCW26ALQ0xQOemKgjb7ToHY=;
        b=BEo7hACHRAfVjUxmak8n4eSvSJ7uKNCGq01dZm26D1Kq7KljC9DAHtoHvqWtef91u2
         PRzk3ubB8Z0K6Od1f7UvjHEMJ9YBOP3HaiCorJHVfggEzpNlt39zU2ojKjWJ9UyAHbGk
         4XQ0PWd6VPPUrl/azrYcFJ7+FdZqrCzOCB8Rh2F9/4XNWyOwhRU8ddVKPUr22dUDd7ht
         Ea2WMuoNaw3rH4Ex3b6LBJsOfD3jam319mD9pTg0RtB+1k9SmRc7XJkhJvHm5FUhldFS
         L1lPDunyJM1uqYsemzyV6o41E/Nh5uHpPOcxl8nkxxdScnCqtQjaNpZGGahKwfHTX4K2
         x/KQ==
X-Gm-Message-State: APjAAAUlk30h57Nbl9xIViRbwoIE7H/cDKuhaB4ZpfA5q22llLfoAzsU
        R54qZbZo5IDawvCejPTANrlr6b+5NUM=
X-Google-Smtp-Source: APXvYqy/fM/fBU5W2ST4waRATKjOpw093hG5M7Cv06iX7WKDL6Am4u1elU8T6XR4wdJRLnichr79ag==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr3322791qkl.434.1570018154725;
        Wed, 02 Oct 2019 05:09:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8034:1f9c:700f:499? ([2001:4898:a800:1010:316a:1f9c:700f:499])
        by smtp.gmail.com with ESMTPSA id c26sm14112091qtk.93.2019.10.02.05.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 05:09:14 -0700 (PDT)
Subject: Re: git-grep in sparse checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
 <f3101c8f-9709-5bcb-35f0-39ffaf8aa809@gmail.com>
 <xmqq36gbfz62.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48ebe9a4-23a8-8679-f380-195d7fc93d60@gmail.com>
Date:   Wed, 2 Oct 2019 08:09:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <xmqq36gbfz62.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/2019 2:18 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Is that the expected behavior? In a sparse-checkout, wouldn't you _want_
>> Git to report things outside the cone?
> 
> That should be optional, I would think.  When you declare "by
> default, this the subset of the project I am interested in", we
> should honor it, I would think.
> 
>> At minimum, I would expect a new option to have "git grep" go back to
>> the old behavior, so users who really want a tree-wide search can have
>> one.
> 
> Yeah, a bugfix to honor SKIP_WORKTREE bit, followed by a new feature
> to ignore it, would be pretty sensible way to go.

Thanks for everyone's responses here. I am satisfied with this direction.

-Stolee

