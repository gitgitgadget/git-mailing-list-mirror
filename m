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
	by dcvr.yhbt.net (Postfix) with ESMTP id 233321F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfGAMpa (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:45:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33188 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGAMp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:45:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id h24so11412743qto.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l9cN1OknLr/c1RxnEDeGf7yp1432Dh6Cphb4OZNtCeQ=;
        b=I4mfZP5cFXAhmjHmghp6FWr3buwhvEuoLcBPtaNCio/5OomVydYg10wd1oNL/gsKzl
         RBy49WtYnu+Ci1LQ40NcohFLvbiccRt/uwnikscZ2WHFbSudv9aiJdz/k1c2ZO+HPpsw
         AYU4BocJw43QnKWPlEa0WFmOBuJMdWO4yvM8RAZAc1hg8ge+rO95rCBT+cndeJLnrYqB
         gDRKqam2bvVG0PCLBUme2l6Tfb18WAhy70WyOvDsAVuNx+bF0cdIp49PU9X5EzcpPCpi
         +DyLP00COqZIdqigGBBbR7PXjOwejwgyFG1xnY9irEqgeuzAnBUg8zYgeDw8cqeJ1XZB
         k2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9cN1OknLr/c1RxnEDeGf7yp1432Dh6Cphb4OZNtCeQ=;
        b=aB1oi65wMe9QnEmmj5V+J32T+d3+E50/GUjZqEAoQ3Xo0nEx5nvvITQW8e5fVIreB5
         ou2G/Fmr5p7JqrhUjpGxX+YEXVXuzCxHZq5An4zhaimu9cusEdPXzRcQJMYGFE1LMwJW
         qdOo+bHhVmhKHGBVwsXHpV043wEEb74IAyX8mpfl5pK/BXmXYzB4VOMdV1fiIdeF6KIS
         +ZrluFo0HYj1xDSLd3hmFcvJICVwZtXgslUrD0BVHyJMzKzs579ja397hTK01WKjKFRB
         Uc1AOaYPdEshjFjkGs+xIIinwZunkOpN1jrlYfbOZDCcmLP/e06l6tOANWFC6EqYrQYf
         G9XQ==
X-Gm-Message-State: APjAAAW5KVbLhBB1Ln1WcITq+IN+EsrAQ7TNQTg6OOn/RK+BbCY7dXGO
        W8E/pEMtoQmGF8GufyolL3ndtt92FcY=
X-Google-Smtp-Source: APXvYqzmm0Icuxwf5oHWI3JbuPNXcjf2Y+0oQth947BT9zUkgZJGsZu/Bu6m7NFbiIkAkp5l09zARw==
X-Received: by 2002:ac8:1c65:: with SMTP id j34mr19855655qtk.323.1561985128999;
        Mon, 01 Jul 2019 05:45:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id q3sm4826373qkq.133.2019.07.01.05.45.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:45:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate
 setting
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.254.git.gitgitgadget@gmail.com>
 <pull.254.v2.git.gitgitgadget@gmail.com>
 <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
 <xmqq8stl8k09.fsf@gitster-ct.c.googlers.com>
 <e684ad41-ca93-bad5-cf39-9dcf578a04ae@gmail.com>
 <CAPUEspg8neAfmKUV3U2DWPnDHOawcbGMNNm_n1MCD7KtLNymLQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6cf903a0-03d8-2c18-639e-a89b953eceab@gmail.com>
Date:   Mon, 1 Jul 2019 08:45:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspg8neAfmKUV3U2DWPnDHOawcbGMNNm_n1MCD7KtLNymLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/2019 2:35 PM, Carlo Arenas wrote:
> On Fri, Jun 28, 2019 at 6:44 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/28/2019 5:42 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>> Use of "signed char" would be OK, but this is a singleton instance
>>> per repository, so I am not sure how much it matters to save a few
>>> words here by not using the most natural "int" type.
>>
>> I'll use 'int' in v2.
> 
> FWIW, this broke the build in (at least) Linux AArch64, unless the following
> is applied on top of ds/early-access

Thanks, Carlo, for reporting this. I'm glad we have someone running early
builds on platforms with these special cases!

I'm working on rerolling to use int.

-Stolee

