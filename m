Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BCC1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 01:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeCTBRO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 21:17:14 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41151 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCTBRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 21:17:10 -0400
Received: by mail-qt0-f169.google.com with SMTP id j4so20095160qth.8
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+DSke6HjWWw2lZnUvoyP+9dCu0UQdQnucHSRU5CtE+4=;
        b=sAvKgxczgySgUUvaiyk9kV4vIzHTRWIeUt+R8ndiJ5Wa2WhXlic7IvRmQ4fp1ilyVb
         neJDnqGSdmuJo94gp1Ggt4tr34v7soByWCKYSTDsdcfpMXBge6+ueHl8mN/AdCPttJkt
         ND27bRetg0J2Q6UQ9l2e72LQUKE/sDRlp3+W6HrQSWQOy3zUcPoAWA+0cnEtMLEXD/1/
         h3B55E9F56+ecqyx57i+GkZrEroNMZJwL3K8IhiPHUZL2/FTQxNYSN6GIfxVqQLj6Dsq
         +P6dk6wDqOMWI5u5lowaU7wmkHIghwskJcAntgMV9h/o/JEnnpkzNxCcF/hy2huCO8vq
         Cklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+DSke6HjWWw2lZnUvoyP+9dCu0UQdQnucHSRU5CtE+4=;
        b=XxUvpl4hqKv+CfxKMIgPCRYXbQlVik4RqXADaW/uiFImE+pIwIBCUMtTev9Nh5xPZw
         Of/UKJTERRpxz1mo/fHA23UjC6ut3N8lv07kBHYkH8mboJXCW/FTKHvayEiGC8IyBPga
         U8Wg7ov/QyxyFwiyJj1TPexHaJRIxs1J9YE/n8xdjrcFz4NTq0Fy0e0vQU7sBZP7nHXo
         7Pd9jOBgj5VNGt9KIghIfL/hgF9jotBD+Kpxm4ni1Pa4wj0fuyyEqaV7fqt+yCeS6J8h
         V1thHZYs9vuGceGcVx/Tf1Qr5VR5pRQ6etuCMfPgIqXHlaeGzFQspsFl2izahBitdStI
         2QFw==
X-Gm-Message-State: AElRT7ERcNjWpjA7iyg3XEYac6CINRCowHu09zZ22w67FAArwcR9OKYM
        LF7OzsN8FVKrHv+ycfd06T4=
X-Google-Smtp-Source: AG47ELvTjIhnQJLNq52X200llTTynvg+TwkbuQuRsHuxz+19+Aa5KLah4A2tQ79VfJB3duQL1Wr8rQ==
X-Received: by 10.200.26.69 with SMTP id q5mr20696373qtk.174.1521508628997;
        Mon, 19 Mar 2018 18:17:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id x49sm393866qth.62.2018.03.19.18.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 18:17:06 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <878tasdpqo.fsf@evledraar.gmail.com>
 <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
 <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjmVgiWsqo8rQWwP9+mEq0tLinc8xoUM=8XdMP3VTBwJxw@mail.gmail.com>
 <20180316200639.GA1845@sigill.intra.peff.net>
 <20180316201908.GA12281@sigill.intra.peff.net>
 <b6ca5f0a-d2c3-2487-ee09-9cf93377d1c1@gmail.com>
Message-ID: <7886ffc3-74e8-6f86-1eb4-321d7b5aa799@gmail.com>
Date:   Mon, 19 Mar 2018 21:17:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b6ca5f0a-d2c3-2487-ee09-9cf93377d1c1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2018 8:55 AM, Derrick Stolee wrote:
>
> Thanks for this! Fixing this performance problem is very important to 
> me, as we will use the "--stdin-packs" mechanism in the GVFS scenario 
> (we will walk all commits in the prefetch packs full of commits and 
> trees instead of relying on refs). This speedup is very valuable!
>
> Thanks,
> -Stolee

Also, for those interested in this series, I plan to do a rebase onto 
2.17.0, when available, as my re-roll. I pushed my responses to the 
current feedback at the GitHub PR for the series [1].

If you are planning to provide more feedback to the series, then please 
let me know and I'll delay my re-roll so you have a chance to review.

Thanks,
-Stolee

[1] https://github.com/derrickstolee/git/pull/2
