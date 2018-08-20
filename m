Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F281F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeHTVbD (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:31:03 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:45731 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHTVbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:31:03 -0400
Received: by mail-pl0-f52.google.com with SMTP id j8-v6so7490560pll.12
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QftRPNxQbGQ+WXmHRPMIxL3r3sHGmNxIkOPO7Ts8kqU=;
        b=PCjfMHng+C8M5XcXQICMyDp7/tc5A/NaVtexC81MADLKbEttBcn+/WKLepyGWWJU4y
         gIN74l1xUEGP7pXy1BUZNWtYffjTjz7u0IM4w6zLkqtEhd5u9wUSJ5lu1p9ucjDdebCO
         Oc98hnlX0NY5kAMFvatOrTrCrfVA65bh7DFvVsh5QRFLohjq9KrM05NpYDo2KpssjLei
         hg1esJT0juSXgCQbdV5k/pnGxU4cm+TyRb1nsp25Bk+t5sBKp+bNl59shq0Ocbz0CiVU
         gllygS2g5tWy8abKMHdoAEGmFQT5OR1itD7zXFGW9IRAPk5XZQSHOx36hGE1HGtzK/Pr
         Qm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QftRPNxQbGQ+WXmHRPMIxL3r3sHGmNxIkOPO7Ts8kqU=;
        b=ncXGuUSUb6KL37ynU554jN9UWYT9GG5nMcp9xtbRmHuzD4LNNVRHc4XoSx7ziPlw/G
         lry7N+dqWERPAQz8D0xZRA/OM4+urOpXUMusR4oYad65+qfE4phGYb3dT1xjfEtAdhiY
         xVRryh/yoGBqkOy11DHfo0VpzmB+rk5dy3xcQxPB1og7QG3jobBn9Sav+56hp0/mfGTD
         r0Yrqw6yObEsXmxsuDLS96cGFVcN4rUnKXEAdC5GE1r8GjLRT3HOR+U378ILS0s2phw/
         nS7uye7bIFe6P0er5LpmToQXaWgDZ0Rk94RKBUcbEDRLq5EX8HK79E1n9MLIIwwGFmrI
         VfHg==
X-Gm-Message-State: AOUpUlE7GIK2eh/QES+7v35+6I/caNUEVjf0N1fhCN8HBqKBEq0NxhXs
        mZKRAzu55ldegaXALbzPT2fTqPDl
X-Google-Smtp-Source: AA+uWPysmTr/hUXpMMHs5GNKfnIYpWSe6xOHi5TxuD4/KGrA3TwNREBlb+Xff3ikVSynlsfMpPWSrw==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr46406723pld.134.1534788861950;
        Mon, 20 Aug 2018 11:14:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b885:8a8f:31f:ed4e? ([2001:4898:e008:1:41c2:8a8f:31f:ed4e])
        by smtp.gmail.com with ESMTPSA id d75-v6sm15998218pfd.49.2018.08.20.11.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:14:21 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
 <20180818065953.GE241538@aiede.svl.corp.google.com>
 <xmqqlg91aqzh.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <800850d1-1880-2a8a-f5d5-7d0593787142@gmail.com>
Date:   Mon, 20 Aug 2018 14:14:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqlg91aqzh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2018 1:26 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Usually, I refrain from merging larger topics in 'next' down to
>>> 'master' when we get close to -rc0, but I am wondering if it is
>>> better to merge all of them to 'master', even the ones on the larger
>>> and possibly undercooked side, expecting that we collectively spend
>>> effort on hunting and fixing bugs in them during the pre-release
>>> freeze period.  If we were to go that route, I'd want everybody's
>>> buy-in and I'll promise to ignore any shiny new toys that appear on
>>> list that are not regression fixes to topics merged to 'master'
>>> since the end of the previous cycle to make sure people are not
>>> distracted.
>> Based on what I see in 'next' (midx, range-diff, etc), I quite like
>> this idea.
> The comment above was about the ones that was marked as "Will merge
> to 'master'" that are in 'next', not the ones marked as "Will cook
> in 'next'", like the midx ones.
>
> I am not worried about range-diff, as I do not think it came close
> enough to the core-ish code to break other things; the potential
> damage is fairly isolated and the worst would be that we'd realize
> that we shipped with a new command that was buggy after the release,
> which is not the end of the world.  'midx' and 'reachable' are quite
> different stories, as bugs in them would in the worst case lead to
> an immediate and unrecoverable repository corruption.
>
> So I am still on the fence, even though I am leaning toward merging
> them down to 'master'.

I'm happy to wait until 2.19 is cut for ds/multi-pack-index to merge 
down. I sent a new series today [1] that improves the series and 
corrects some bugs I found while making the full Git test suite work 
when writing a multi-pack-index on every repack. Nothing was 
"unrecoverable repository corruption," but I understand the concern 
there. Making the safest decision is probably the best decision.

I'm happy to contribute to a "pre-2.19 bug bash" after you merge things 
into master.

Thanks,

-Stolee

[1] 
https://public-inbox.org/git/20180820165124.152146-1-dstolee@microsoft.com/T/#u

     [PATCH 0/9] multi-pack-index cleanups

