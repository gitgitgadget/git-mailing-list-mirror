Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D491F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfKFPqh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:46:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41450 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfKFPqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:46:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id o3so34177590qtj.8
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TrIjqhPE8i5w1uG+O5FYADpytUgmt7Re+s5pRlBgMu4=;
        b=EqGmkbb1ngF1Ckyk8/syn9vcCQqDxH3x4Nm1qlbw8M5LN1tLineCu4YZVxPiuoP84w
         abI3EhQBdQpRASO4xOziafDs/t1EQyrj106MNrDVIPqP815/c6A3KLyP9r4o0DlOVgJU
         oJz3Vd4uhuPQs/FaNMi/AQmoBn4GsJLDX6XlE2Ohm7ijPc4c4vrx1J+dFBeaFyzrKLUU
         ZcgpR8lIXjJLY80H7sVuOpL0wIAXiHWXjooFEye4yJiEUDauiQWVEu7HdqquocEOODbD
         ToKU2jnO0I9nlty2PlozmK/jGFDM4q8v5cXXXI8/Emw8YrX7Bae5r0rAaorHnNqI52GJ
         eamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TrIjqhPE8i5w1uG+O5FYADpytUgmt7Re+s5pRlBgMu4=;
        b=szlTmVgYvIYxjgjVEMRgHBeuDdWzVZv360xz0MHittXBTdSvYLc2goneJL147USy6q
         bUD7Qd1EwetszvekdiI3Y26k/aU1aCQtKpTl6xeCGqhU7t3zp4427Ci2txHZsN499Ka6
         j6X32AciG8uQf1HN588IoxlUrcRFnaPvPQnl7WVp5kCKqtGCTDiMVTkg8xwLtu9Zzbbo
         553s1TyWHBO712lJpkc3rx62Wfj0eQzDgIxkupEiUEw66n0dcGI6v+/V6lZUYlULhu71
         q7vvSPU6Ll0EaXeTF3NY96DvJP287/qEFvaDFsVpK3jRcK76+hYJCWDXCZRDEKxvBHqa
         we0g==
X-Gm-Message-State: APjAAAWwMgAtjvOPcufJ4KBh2hHnZEnA147fc4TkWNl9qGZCRqOZST7N
        tKNr2dMLvRse9I/iuFQ50GBFgf1lO2E=
X-Google-Smtp-Source: APXvYqxiQqFJcrpoWhmP4+Q5u8rpgLoowobRp3Q1x/TJ8Ggnq67Z0VKc3RVfkvSnrRwp8QeTxivwUQ==
X-Received: by 2002:aed:3222:: with SMTP id y31mr3005753qtd.369.1573055195483;
        Wed, 06 Nov 2019 07:46:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:f1db:9da1:1f4:31c6? ([2001:4898:a800:1010:a311:9da1:1f4:31c6])
        by smtp.gmail.com with ESMTPSA id a28sm11923214qkn.126.2019.11.06.07.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:46:34 -0800 (PST)
Subject: Re: [PATCH 0/1] fsmonitor: fix watchman integration
To:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.444.git.1572889841.gitgitgadget@gmail.com>
 <xmqqlfstvg09.fsf@gitster-ct.c.googlers.com>
 <BN6PR21MB0786856156CFB55E8812D51E91790@BN6PR21MB0786.namprd21.prod.outlook.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cca49c40-8abc-96c2-f79c-399f29ceae0d@gmail.com>
Date:   Wed, 6 Nov 2019 10:46:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <BN6PR21MB0786856156CFB55E8812D51E91790@BN6PR21MB0786.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/6/2019 10:32 AM, Kevin Willford wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>> Sent: Tuesday, November 5, 2019 8:30 PM
>>
>> "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> When running Git commands quickly -- such as in a shell script or the
>>> test suite -- the Git commands frequently complete and start again
>>> during the same second. The example fsmonitor hooks to integrate with
>>> Watchman truncate the nanosecond times to seconds. In principle, this
>>> is fine, as Watchman claims to use inclusive comparisons [1]. The
>>> result should only be an over-representation of the changed paths since
>> the last Git command.
>>> ...
>>
>> So, it doesn't seem to use "inclusive" and we need a workaround?
> 
> That is what is seems like.  I would like to dig into the watchman code
> to understand what is really going on.  They also document that "Using
> a timestamp is prone to race conditions in understanding the complete
> state of the file tree." Which could be the cause since the tests are
> running things in quick succession, i.e. change a file, run a git command.
> 
> Long term we should switch to using watchman's clock id which the
> documentation says does not have the race conditions. But the clock
> id is a string and would take more invasive changes to integrate that
> into the index where we are now simply using a uint64_t.

I should mention that I'm working on a patch series that will allow us
to use GIT_TEST_FSMONITOR pointing at Watchman in our CI builds. There
are several places where our fsmonitor integration does not work well
(such as when we delete submodules), but most of the remaining fixes
are small.

This timing issue fixes MOST of the problems we see when running the
test suite.

Thanks,
-Stolee

