Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 16:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhLGQZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbhLGQY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 11:24:58 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE8C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 08:21:28 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id r26so28651404oiw.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2DixYLvjKltuqJIBGBgFl9/fod2yft8jDUHJIernreE=;
        b=Jiem9JmMm9yPeMAGAGKdAr3fn616VuQ7RS+DP5799CoTIK0YZoTiAgd4m0xl/3WRx5
         bRQz868bMU1IIy5l99Y9ZVy38YYxv0ngoATQMAHNw4Q+3d4/l8S/8FwuFpTMlgVWuMsh
         KKFgHJAR7o6X6BqeixqbpDCIosK7ouJz3Zs0qo3Zv80MkZccy957CuHsvAsNkrnCb06O
         lipIOg9XJdTLT26ubhVSwD/B9a65DgOUOO2/Ac58pSNQw2arnDlHMrGgiN6Ih9nRoQa4
         BO7R6WKC90d6B18zEcDC+aoI2t+oZMCXok3HaTTqz1vSqFJUfoEVwh9nsU47otr/bsZq
         g5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2DixYLvjKltuqJIBGBgFl9/fod2yft8jDUHJIernreE=;
        b=6Defuw/6DUIdROMTkPbsilPRlNrXPKTE+Wkju3xh+IfymiWuM4vYltQ1tXnBjTaULn
         paNTBUF86ltSyHjDeHHeHdvmuH38MFhLPHnceBUWsfznkXkhiwT5XTyowJUAERiF8VjB
         GHxEmsbidnVD/tZRPrHGnKMt7gO34U/QRL3TnN8dXKW61Vd4uxM25nAa1iB5LGhzhlli
         mIdfXaNHvCMDbUdnRc8FQuHBSAF6iszO9BHW2oQhl1e9ne50KBWcvvmBEB6GmBDU0Ogt
         GTHG9Rn7uB0JyiqMdJBVMLlpvYU2nf4MalSSGoSY6QyZ4Q5jxqzKRvaUkhrV5eYCeY7f
         4ufQ==
X-Gm-Message-State: AOAM532YAoXITxOT12Ko9IXwbdbqTjW1gOgEB3dSOKiAPvE5mzUij+Q2
        x0nS7HlTFjyR5anLLAqBwaj0uVYSTHE=
X-Google-Smtp-Source: ABdhPJw9Yu1wwgah73W5iDYRz6mHQ8Iqf892+Mohp08m3XSpVbuLmQaIgftngM7pfkTZAT+wYkSXEA==
X-Received: by 2002:a05:6808:1784:: with SMTP id bg4mr6068749oib.70.1638894087867;
        Tue, 07 Dec 2021 08:21:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id e14sm37596oow.3.2021.12.07.08.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:21:27 -0800 (PST)
Message-ID: <ef487c98-820c-010e-e3c9-39d60633b30f@gmail.com>
Date:   Tue, 7 Dec 2021 11:21:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbl1xqheu.fsf@gitster.g> <xmqqilw1b4ry.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqilw1b4ry.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/6/2021 8:08 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> FYI, here is how the topics listed in the report are categorized
>> (output from the 'cook -w' script I mentioned in the main report).
> 
> The output from the same command to summarize the current draft of
> the next issue of the "What's cooking" report looks like this.  As
> promised, unless a problem is found in it, a topic in 'next' will
> graduate almost automatically to 'master' after spending a week
> there, so by the end of this week we'll have ~40 topics graduating
> to 'master'.

Wow!!!

> Please pay extra attention to the list of topics slated for 'next'
> (with and without the '?') to stop topics that are not quite ready
> to go in to 'next' by mistake.
> 
> Thanks.

I found this output to be a particularly interesting way to get an
overview of everything going on. It almost looks appropriate for
being a "table of contents" for the main report. Have you thought
about adding it near the top of that report?

Thanks,
-Stolee

