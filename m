Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32926ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiIAQIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiIAQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:08:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D589109A
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:08:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c2so17512183plo.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Hwiu0uTGDkwurms739DkQd0eRyAmQZ7MkkklSJHrnfI=;
        b=JfFg44dIqxP+dABRwxIV56PwGm79Ns4ZIt869I5LBXQZkKabrD+xchW1IgEv10amKU
         uITrl8YvzDI5QEHyh5OQTaUD5sj8ajoTqCM2RCCT+N35RStuTMraK8MeQh6Y1xNsLIHy
         /HCITtt4erof/f50wuB9spgv0otoPHAHW94HFW+nxpzJ9A10RqAdJvdeJzgWFa5lpkxA
         paM8Wq95VJRok3YrhRFr2OTsAfWuDZo8/Fcwr0dbjNSOzWdjh91DVchFq3GMnX9Dk/by
         9hTZw41gDSEnS1EQlRWQ3JUzgHK9dILRdnDMFa5aDCDmTSxtxyrjOC7ekhDoy7fGpqnE
         M81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Hwiu0uTGDkwurms739DkQd0eRyAmQZ7MkkklSJHrnfI=;
        b=nC/oSx0TRD4TSuoNBmhued8KDeEUdXyZ51VsJiwl8zgTdmlVL7fUimBGyEdljjnnYZ
         4qDp6pSqL6MkDpDFXgc4yjlacnVEv9Jm+ilnh+b813K1wIvqcp6Mixl9HRIhOhol+Wn6
         L0G4lET4iTNU36Itj/61df0k4QnGfngkCfCiwN739bAItWOteSwssr0A2jyBqYWtc75W
         peW7lB4quuaiy1SdHpgCGswZHDuse3ynssSsDjbHE9TlrNr4dZTADFn+hUa5UJpTWC5l
         V4SIa0VKgId/9ax1dAXJk4BXfyTtut6Ituy8mXa5Q2tgyU7zfYdOxVWN/nFizuOMMDnr
         Vz/g==
X-Gm-Message-State: ACgBeo0w3bVkB25lzWGNHwIiEwXcH2U+sjd400PJzEPA+PdWe6plYiAM
        RqbEvUGg284/DMcmbUxytzuax8pl9TE2
X-Google-Smtp-Source: AA6agR5wuHIJeZIl5UPBnB/eznY8+x79UK8aMefi6E/ldI4i9KaSwEnolXMPH8/+qeyjYpQNgOa+zw==
X-Received: by 2002:a17:902:c945:b0:16e:d24d:1b27 with SMTP id i5-20020a170902c94500b0016ed24d1b27mr32143526pla.51.1662048512236;
        Thu, 01 Sep 2022 09:08:32 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id bc13-20020a656d8d000000b00421841943dfsm5369359pgb.12.2022.09.01.09.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:08:31 -0700 (PDT)
Message-ID: <552dc600-9a6e-988c-a4ff-18a6eb45e121@github.com>
Date:   Thu, 1 Sep 2022 09:08:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 4/8] scalar: implement the `help` subcommand
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        Johannes Schindelin <johasc@microsoft.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
 <220831.8635dc9wzx.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220831.8635dc9wzx.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 31 2022, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johasc@microsoft.com>
>>
>> It is merely handing off to `git help scalar`.
>>
>> Signed-off-by: Johannes Schindelin <johasc@microsoft.com>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  scalar.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/scalar.c b/scalar.c
>> index 642d16124eb..675d7a6b0a9 100644
>> --- a/scalar.c
>> +++ b/scalar.c
>> @@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
>>  	return res;
>>  }
>>  
>> +static int cmd_help(int argc, const char **argv)
>> +{
>> +	struct option options[] = {
>> +		OPT_END(),
>> +	};
>> +	const char * const usage[] = {
>> +		N_("scalar help"),
> 
> 
> This should not have N_(), as it's a literal command.

Thanks, will fix. 

> 
>> +		NULL
>> +	};
>> +
>> +	argc = parse_options(argc, argv, NULL, options,
>> +			     usage, 0);
>> +
>> +	if (argc != 0)
> 
> If we're re-rolling anyway we usually just do "if (argc)". We don't need
> to worry about argc < 0 (despite the signed type, which is a historical
> C wart).

Normally I'd agree, but in this case there's a readability benefit to
explicitly comparing 'argc' to 0. 'scalar help' expects exactly zero
positional arguments, and showing the '!= 0' makes that expectation clearer
(likewise, 'scalar delete' checks that 'argc != 1' because it expects
exactly one positional arg). 

> 
>> +		usage_with_options(usage, options);
>> +
>> +	return run_git("help", "scalar", NULL);
> 
> Performance isn't sensitive here, but have you tried just calling
> cmd_help() instead with the appropriate arguments? It would avoid
> spawning another command..

As a matter of design preference, I'd rather avoid invoking builtins via
their 'cmd_*()' entrypoint. Doing so in 'scalar.c' would also introduce some
function name conflicts. While that's an overcomeable problem, precedent
across Git doesn't appear to indicate one approach is better than the other,
so I'm happy with things as they are. 
