Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB211FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 10:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbcLIKhs (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 05:37:48 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33010 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbcLIKhr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 05:37:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id 3so1979564pgd.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 02:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=gQgHZa173Ry36f4+lHBRecJzUVEtpF0MsOXYkJSr1KU=;
        b=QX0/q+ceuO7e/pCmaSHrad69iMyRj81GwQ9bB4uPTUaC9M5oDYa0A8k7CC3HvFO3hN
         QrKGPEd8aan0GIx954DA+1xgAhRah4fMJmJN+n2iV2K2cZHKmOF1ABJCOMQkjDgtg9Fb
         WRVjGpZxhLeAq7Eg2owksQkigOKgN/7BxU4UuKdV0+cAdwO2qZjwYAGtmhlyV14dzfJM
         bQwF0CKWtKRhtng7WdNWcNDZHUPVSN7t/o0cmhTSNIYs4a7JYrriBefG2ocP9Zvk2A5y
         hC/0PJK2d4ZcDuAkt/IwqVeMtmFVehTuiKEYQhgncYpHHBXPftE44EB8sJwk2e3RYC9X
         K15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=gQgHZa173Ry36f4+lHBRecJzUVEtpF0MsOXYkJSr1KU=;
        b=lnMXSBnKdlawh9ye6y47RvAF3kAzSokSIe/dg3rQc1mLPKpjLlEmD2Q48bvGXie3ur
         obpdJXQ5NFjox5bhybGNdeEgq/7VcwTMn1ZjSC1Q+8AT2EBHsI/JRH/cBvnvwKLUKV8Z
         9ExLitmCqOvKDkoMLpkNrsvl7L3PoPQCSmLi+2fYbEkJkaPf9z1c2lagBujfH+fUcLzO
         ZXtKld56Q6N3qfd20fq5pG8jAxlXrZzHYKMxRZr1LA7DdGnmRdoWuc6uPss4wz7yW/it
         x9fBzj5Oc7RwT4KXzW9bmar4tdnz3bnC2hVkYeRAbcRO9v0o1lD4gC9DrlcvgbKEyKsk
         ER/A==
X-Gm-Message-State: AKaTC00uCcWNAP5O84ABEBFdFoPl9yXmYQnXfsNC9q3LXXEmuKPR51NIyp/DjyfqHYDUZQ==
X-Received: by 10.99.43.8 with SMTP id r8mr142978971pgr.83.1481279866723;
        Fri, 09 Dec 2016 02:37:46 -0800 (PST)
Received: from android-fbb6869f23c6f304 (50-39-169-6.bvtn.or.frontiernet.net. [50.39.169.6])
        by smtp.gmail.com with ESMTPSA id s8sm56568105pfj.45.2016.12.09.02.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 02:37:46 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com> <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Any interest in 'git merge --continue' as a command
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 09 Dec 2016 02:37:42 -0800
To:     Jeff King <peff@peff.net>, Chris Packham <judge.packham@gmail.com>
CC:     GIT <git@vger.kernel.org>
Message-ID: <025427FB-D91F-48B4-B031-5AE1C7BAC779@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 9, 2016 1:11:27 AM PST, Jeff King <peff@peff.net> wrote:
>On Fri, Dec 09, 2016 at 08:57:58PM +1300, Chris Packham wrote:
>
>> I hit this at $dayjob recently.
>> 
>> A developer had got themselves into a confused state when needing to
>> resolve a merge conflict.
>> 
>> They knew about git rebase --continue (and git am and git
>cherry-pick)
>> but they were unsure how to "continue" a merge (it didn't help that
>> the advice saying to use 'git commit' was scrolling off the top of
>the
>> terminal). I know that using 'git commit' has been the standard way
>to
>> complete a merge but given other commands have a --continue should
>> merge have it as well?
>
>It seems like that would be in line with 35d2fffdb (Provide 'git merge
>--abort' as a synonym to 'git reset --merge', 2010-11-09), whose stated
>goal was providing consistency with other multi-command operations.
>
>I assume it would _just_ run a vanilla "git commit", and not try to do
>any trickery with updating the index (which could be disastrous).
>
>-Peff

This makes sense to me.

Thanks,
Jake


