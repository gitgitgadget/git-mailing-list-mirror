Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697111F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2Qhh (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:37:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46437 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2Qhh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:37:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so22848292qtm.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7XJN0ai2yOkMnsREME4oLNi/n1fQD8JvIBjPa50mr/4=;
        b=bxvK0FmCHHjHW6RRxaYRUQwQRd833Pvz2R+lJupEYkLs2KcObUHbp3JEDEqXQqbgZH
         pCl540RFkigODDMvzjlRG/1UbMsiuCTThzRzjXyiDQf4+Z8bolQCsiDXHNGYbwKmpl+I
         tArsmqkSfti9rJDLBIde2JmKoiyZg6/Gm5ZUYipBRf4rXyGhS/wViFoYpwwEDimxEgVY
         pbkjw6Evwq4qoyWxR1vcMhTxKnKEwHBH4pAg6IpQ4QiG3DTjs3ffHpKyhA2PtpK5Xh+T
         MjLwRuj2x9RmHvKjpo7YbBThSG70Wk5hO6DsiO2rP3OlURfkiLDvAFVPZ0JqnfzTnNqH
         m/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7XJN0ai2yOkMnsREME4oLNi/n1fQD8JvIBjPa50mr/4=;
        b=k31GktlpeT2yiZ8Jzok1zyES5Bf2/heL6JblYwbasdHoXL8oSDnKUvfoasMvEb4riX
         HlFzmI/bzd5eltkNzg7cJ4IC25STbAFHUTdi/+u43CUJkPxqurpnV0LUT+0IrsURtPBh
         f7lXwrazYMICPy+HMRetZH8RjpdMmxt/VvyZ2J7fLhEIYNwIk10oRHLOHn87K1H8lfJM
         i/OtdEEJ6FIHDw5qnHoT5zIOsfNcZQOeuW6ckbANePMT/qJUw8/lzDtcm8zPvOKZ95z4
         WRojFHCu98hhDM+IEkC+buSN3Kcp74TtlxZ6Bl2vafjoP9sngPl2Hhwghnixb4PeuhlI
         a+ZQ==
X-Gm-Message-State: AJcUukeXVCWmUo3fFmC3xSZQqC9efePf1gL5lmhglkfaC2Wi2ejLUZu2
        k7pFmUREBYSub+JRK1ryE4s=
X-Google-Smtp-Source: ALg8bN749P90RieOVIoBg97uIkfpkbSayHX1HV2UisNwYJjmtEoiZ8PJrNSSWjRzUOwGdFcRTqNe1A==
X-Received: by 2002:ac8:518d:: with SMTP id c13mr25875701qtn.254.1548779855384;
        Tue, 29 Jan 2019 08:37:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:788a:444c:e16b:27e? ([2001:4898:8010:2:61be:444c:e16b:27e])
        by smtp.gmail.com with ESMTPSA id u67sm79420052qki.22.2019.01.29.08.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 08:37:34 -0800 (PST)
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129155827.GC13764@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a5ca8985-f877-b250-d186-32bef40092f5@gmail.com>
Date:   Tue, 29 Jan 2019 11:37:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190129155827.GC13764@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2019 10:58 AM, SZEDER Gábor wrote:
> On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via GitGitGadget wrote:
>> +prove: all
>> +	$(MAKE) -C t/ prove
>> +
> 
> You don't need this 'prove' target in the "main" Makefile, because
> 'make test' will run the test suite using DEFAULT_TEST_TARGET anyway.

Thanks!

>> +coverage-prove: coverage-clean-results coverage-compile
>> +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>> +		DEFAULT_TEST_TARGET=prove -j1 prove
> 
> First I was wondering why do you need a dedicated 'coverage-prove'
> target, instead of letting DEFAULT_TEST_TARGET from the environment or
> from 'config.mak' do its thing.  But then I noticed in the hunk
> context, that, for some reason, the 'coverage-test' target hardcoded
> 'DEFAULT_TEST_TARGET=test -j1'.  Then I was wondering why would it
> want to do that, and stumbled upon commit c14cc77c11:
> 
>     coverage: set DEFAULT_TEST_TARGET to avoid using prove
>     
>     If the user sets DEFAULT_TEST_TARGET=prove in his config.mak, that
>     carries over into the coverage tests.  Which is really bad if he also
>     sets GIT_PROVE_OPTS=-j<..> as that completely breaks the coverage
>     runs.
>     
>     Instead of attempting to mess with the GIT_PROVE_OPTS, just force the
>     test target to 'test' so that we run under make, like we intended all
>     along.

Thanks for finding this!
 
> I'm afraid that this issue would badly affect 'coverage-prove' as well
> (I didn't try).  Or if doesn't (anymore?), then that should be
> mentioned in the commit message, and then perhaps it's time to remove
> that '-j1' from the 'coverage-test' target as well.

I'll fix this by forcing an update to GIT_PROVE_OPTS. It does limit our
ability to use GIT_PROVE_OPTS as a pass-through, but at least this new
target will have that assumption built in.

Thanks,
-Stolee
