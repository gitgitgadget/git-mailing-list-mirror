Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F091F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdKJNAA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:00:00 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:50154 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbdKJM77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 07:59:59 -0500
Received: by mail-qt0-f170.google.com with SMTP id p44so1214778qtj.6
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 04:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zd1kj9C6ge2c9/XgrnGM9ExE+CXmjEVil8X0bOAYPxI=;
        b=Vd04RVCf8J0FsQSczfiw0XV9/MrgaORg+AgoUS+BfIysoJmdIixLfBlpDMieQ8ARaw
         VWQBzzcqxInvuxEUMUpS8tb1LVvg1TFjiCDGuFLOrbEwmP/MTikWBxru/+tHJfae1dTk
         e8TcDncuWWLqX8ChV94DRCOJjJ8YAVbgwU4fXz8EN01wR+icictnOi4QfX+1eNYvzOZe
         b3aRS/sJxY5A4PQ0H2GePTkkL6RYweVWRU/RzI6eWqqs7SdJs0HY7TL0f9ZRFgsj41Kj
         wuLoAmVwQzLZ37qqtd4b0W8Vrf20kjXxWNA6veb0QaURG42gmAjN/rdrXSEVbEva6wVh
         gjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zd1kj9C6ge2c9/XgrnGM9ExE+CXmjEVil8X0bOAYPxI=;
        b=R8jYOWtnCjjTUt3p/kulSIb2dEptGLkTa5zbIjcWWt8EbB/NN+6pzyyWREiKMwDa4V
         8inC3a+MXUdW0i5TviXJvbpKG6IGD28j9mjtXB/kMUxFpgpxdVu6x4jLZ5FGweT4gCUN
         HKMMDqBuR5KOlToE4AM+mkJYw+eiQw7sP/lMlvKyWTqmAOUZ27x3iF9VmFhjN0idkzej
         DX8yXPhP9nqmjsxobMWDQxYLeCghoEWUT58FrwntTZ04FM/ORLSsS4IfPNRJc9hmY/qI
         tWZpfueYn8TI7pnKjDxk5yevZ6R5325qlSsHsDUZ9E+wNYj0SYaTD5fwkcHu9bn9brU/
         X61g==
X-Gm-Message-State: AJaThX5ail4p+WiN2I+n7K6KB3ggC6YRIi78YX5uDIIBMyg2FXxJiIJj
        dNrHy4eWCn55jtinf/CXWhzo+cmL
X-Google-Smtp-Source: AGs4zMbvgpnM/EZj6JL5rS7DH5qLWc3hH4ZSSQExJyHara8xAE/+IyrdRIqg+jetv6SV2cPSwMgITQ==
X-Received: by 10.237.39.155 with SMTP id a27mr438708qtd.136.1510318798225;
        Fri, 10 Nov 2017 04:59:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id t16sm6282864qtt.92.2017.11.10.04.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 04:59:56 -0800 (PST)
Subject: Re: cherry-pick very slow on big repository
To:     Peter Krefting <peter@softwolves.pp.se>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
 <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net>
 <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com>
Date:   Fri, 10 Nov 2017 07:59:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2017 7:37 AM, Peter Krefting wrote:
> Jeff King:
>
>> Can you get a backtrace? I'd do something like:
>
> Seems that it spends most time in diffcore_count_changes(), that is 
> where it hits whenever I hit Ctrl+C (various line numbers 199-207 in 
> diffcore-delta.c; this is on the v2.15.0 tag).
>
> (gdb) bt
> #0  diffcore_count_changes (src=src@entry=0x55555db99970,
>     dst=dst@entry=0x55555d6a4810,
>     src_count_p=src_count_p@entry=0x55555db99998,
>     dst_count_p=dst_count_p@entry=0x55555d6a4838,
>     src_copied=src_copied@entry=0x7fffffffd3e0,
>     literal_added=literal_added@entry=0x7fffffffd3f0)
>     at diffcore-delta.c:203
> #1  0x00005555556dee1a in estimate_similarity (minimum_score=30000,
>     dst=0x55555d6a4810, src=0x55555db99970) at diffcore-rename.c:193
> #2  diffcore_rename (options=options@entry=0x7fffffffd4f0)
>     at diffcore-rename.c:560
> #3  0x0000555555623d83 in diffcore_std (
>     options=options@entry=0x7fffffffd4f0) at diff.c:5846
> ...

Git is spending time detecting renames, which implies you probably 
renamed a folder or added and deleted a large number of files. This 
rename detection is quadratic (# adds times # deletes).

You can remove this rename detection by running your cherry-pick with 
`git -c diff.renameLimit=1 cherry-pick ...`

See https://git-scm.com/docs/diff-config#diff-config-diffrenameLimit

Thanks,
-Stolee
