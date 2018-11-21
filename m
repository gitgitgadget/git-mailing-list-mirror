Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28871F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 11:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeKUWG0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 17:06:26 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46506 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUWGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 17:06:25 -0500
Received: by mail-yw1-f65.google.com with SMTP id t13so2072694ywe.13
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xtd4aumJMs3N+FytedEg50dUcxVR0qRl/MkDXI1OHV0=;
        b=GEYCCinD2nOqeBKffi2TlO7It53Fs6L9SlVVSEov0C1enjdeOqKg2K3TvznfsCYV+M
         B6eBbxJ9NQ/ySJh38QAvlVNz08wDfHRpEu3Gw/smGEdguMubvHj6QiDspwMb8Pec67Cj
         RpXr0rJlEXMTIGkfXaXdETeAkKpBlm5Apwhg2BLtFn13pdkgFCCM0GCyg50OjK8iEfj9
         /WYGZhBy0zImHsP+cXdJxx7O3L04JN8sIJYMx69PsQgQdDd4RppQx695kkmPe1hXHZ7f
         GfmT7VdYMpSKrD+dbAxp8pO1mKp99X7A89WHOfunu4ZUKLL66tCjKc2CMEzly0n0gx2+
         q1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xtd4aumJMs3N+FytedEg50dUcxVR0qRl/MkDXI1OHV0=;
        b=nINjGRuLMumqT0/Y05QEZDEA8IQDScUmB8s3UAJj+gtSNvZZuAr5XkUIHUF2rpTXxi
         KcixVJi+n9rxjPchrnNlcUaHjlCYrfspYnbTLiYhvOjG1xnNkcW66pykvEjVE+oXraY2
         q22SELLk1Q8NTH2muXdhzI6KP+yCUYoAPyE4fnOtmCWw3+hLmw/cBqkM5Ta1PHUuLMeD
         z+wrEhDdFiNxqQrpRDmjqIDHTWQ1g1raxp8PjlqUnmfbBDGboUyWVV2DnLFs37YPGnX9
         VM7PPGT8zn1Mhuh9gVRRrq3hfO+o6tXxb+hzTRkuAPHO92pOhoD0ZRHlfLSFhCswfgzl
         Ihvw==
X-Gm-Message-State: AGRZ1gKjVC67BEeIvkJwJ/c7h1xHAVIG1I44xEck5zBqg86qbggmtT/T
        gZr/I9GTkTu+Fo/PBhaqJAg=
X-Google-Smtp-Source: AJdET5c4jMO08UdYfu7uh9nKqlFXRT3B8D2GSO3BbY5qeEn9Kjb8FhdzdPmHZE/ruNsc80qZ1V2UgQ==
X-Received: by 2002:a81:d008:: with SMTP id v8mr5823591ywi.464.1542799942780;
        Wed, 21 Nov 2018 03:32:22 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id g81-v6sm6115701ywa.100.2018.11.21.03.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:32:21 -0800 (PST)
Subject: Re: [PATCH 1/2] commit-graph: rename 'num_extra_edges' variable to
 'num_large_edges'
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <20181121012344.26711-1-szeder.dev@gmail.com>
 <20181121012532.26878-1-szeder.dev@gmail.com>
 <xmqqwop785wh.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
Date:   Wed, 21 Nov 2018 06:32:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqwop785wh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2018 10:29 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> I rename these variables to 'num_large_edges', because the commit
>> graph file format speaks about the 'Large Edge List' chunk.
>>
>> However, I do find that the term 'extra' makes much more sense
>>
>> Would it make sense to do the rename in the other direction?
> I tend to agree that "large edge" is a misnomer.

I agree with you both. "Extra" is better.

Thanks,

-Stolee

