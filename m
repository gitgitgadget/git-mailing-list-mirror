Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6541F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfA2Qfp (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:35:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45985 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfA2Qfo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:35:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so11850316qka.12
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wLd0z+LV8R/6l/z5tcb0p29tCP5IP6OPhZVUSNOZJyo=;
        b=BgSHpBdOLSPWzxlIgcO9hYr5+RM3Vv6vq4ELOJLSTvfHyQDO061fXUAWNYjGV+S0NP
         I8LAW7bfsiJRfPs019o0B9sPVxu4QET/tWCl8yofiKSx11OSD4LXYY08BPr2eq3t6Efs
         5UhgNKMLtscuPQfMtL1SZmYpLexb6zp22fojOnPgh9Bk6rI18QkuN6eOBOMQ0XOug/4z
         Ft7sK/C+AeJOmm5WlIADUwUYtHytt+tzhPW/91A0zv2jTJ0z7z8+w8o8svQ7g0raheTX
         njTk3BwNFbK/me4+utAnTfb0ZCPHzbyNpYFFgyUGHpnL/EzJWVY0UfeHZIkhTMrefzlD
         CN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wLd0z+LV8R/6l/z5tcb0p29tCP5IP6OPhZVUSNOZJyo=;
        b=rVoY/2q7hDISrVMbtI3PtG868TyX8GcxJdpqq+ZTvWwKfuuBH/E/S+ZU/cy5es9EKi
         h2eXGuJYjaSlHKxislsxyZDgnM8+VBdqTFBG2QYkwfw8phj7zQ1/AySi28BWOoMa3tgP
         PZeDbm/1pCWBR765XckdNfslX1nl96A0U+kT2FIOj0JjwebeIno2hu1GFaeYZetFHbv0
         +xGeDXj8jKvCAyv4f9cC3s1oyEpAhmi339wZcoVMMoYFvkwqSOwuzloNegDkFLON6Zb0
         cRcJH1PLX42tZk7IqcHzoRK5YBKko7IMto2CMCeGH2UXWnmxk8+ScTTr00NIzfyNBleO
         xyqA==
X-Gm-Message-State: AJcUukcor5L9tl8P2G92w7P6zyh0iXkVFNjkptyfbYc7ZvSejnyRZnuC
        ptoue/nzwpyrAR86OlCr5Lc=
X-Google-Smtp-Source: ALg8bN5SoHjJbmaGd/TDc4J43wlarb1UbcyOvZ9nA2bSqcDnkSHOsgowAtMvszpe/E2umzEp8Fxi4w==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr24160674qkh.249.1548779743202;
        Tue, 29 Jan 2019 08:35:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:788a:444c:e16b:27e? ([2001:4898:8010:2:61be:444c:e16b:27e])
        by smtp.gmail.com with ESMTPSA id q63sm65913027qke.44.2019.01.29.08.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 08:35:41 -0800 (PST)
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129160030.GA7083@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bb17112d-2869-741f-de13-3971a995032e@gmail.com>
Date:   Tue, 29 Jan 2019 11:35:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190129160030.GA7083@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2019 11:00 AM, Jeff King wrote:
> On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When running the test suite for code coverage using
>> 'make coverage-test', a single test failure stops the
>> test suite from completing. This leads to significant
>> undercounting of covered blocks.
>>
>> Add two new targets to the Makefile:
>>
>> * 'prove' runs the test suite using 'prove'.
>>
>> * 'coverage-prove' compiles the source using the
>>   coverage flags, then runs the test suite using
>>   'prove'.
>>
>> These targets are modeled after the 'test' and
>> 'coverage-test' targets.
> 
> I think these are reasonable to have (and I personally much prefer
> "prove" to the raw "make test" output anyway).
> 
> For people who don't have "prove" available, I think they could just do
> "make -k test" to make sure the full suite runs. Should we perhaps be
> doing that automatically in the sub-make run by coverage-test?

I wanted to avoid changing the existing behavior, if I could. But, if
we can reasonably assume that anyone running 'make coverage-test' wants
to run the full suite even with failures, then that's fine by me.

I see from the make docs that '-k' will still result in an error code
at the end of the command, so no automation would result in an incorrect
response to a failed test. Am I correct?

>> @@ -3077,6 +3080,10 @@ coverage-test: coverage-clean-results coverage-compile
>>  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>>  		DEFAULT_TEST_TARGET=test -j1 test
>>  
>> +coverage-prove: coverage-clean-results coverage-compile
>> +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>> +		DEFAULT_TEST_TARGET=prove -j1 prove
>> +
> 
> You probably don't need to override DEFAULT_TEST_TARGET here, since the
> "prove" target doesn't look at it. Likewise, "-j1" probably does nothing
> here, since prove itself is a single target.

As Szeder mentioned, I can probably just drop the 'prove' target and use
DEFAULT_TEST_TARGET instead. Or do we think anyone will want to use
'make prove' from root?

> I'm not sure why we want to enforce -j1 for these targets, but if it's
> important to do so for the prove case, as well, you'd need to add it to
> GIT_PROVE_OPTS.

The '-j1' is necessary because the coverage data is collected in a way that
is not thread-safe. Our compile options also force single-threaded behavior.

I'll specifically override GIT_PROVE_OPTS here to force -j1, but also send
-j1 to the 'make' command, too.

Thanks,
-Stolee
