Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA64207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 22:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbdFWWt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 18:49:57 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35636 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdFWWt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 18:49:56 -0400
Received: by mail-pg0-f47.google.com with SMTP id 132so26474711pgb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nb8+fG5aDnDqob2fPj5abvScrBtAUsmz3VeK2YsK+eY=;
        b=WvCjdRhiSTxZQFW0JLBL3MzVHxktpcI2Jd5JdBIXTNImeWiURxpDpvsluSXQCxsoMz
         IN+BgioTYaLnhc39RUaOm4/OPNr/wiqf9d9ecrRGWlIv59g3dSdHG/bfHhKMWGOHaT4w
         qvj1phdp+xs6DZEGfahm0st92scWBSlItAIOvnLE00HAgyGixIQFa2HRCF+I8JcPf+S2
         QETYiml6evmGbvomKABrP6+Ex4sZorGKBEf8wr27bfTZUKqAPIKcVcHwwTEwPER2dqA9
         v7J8a68UbwQkALi7pOjQXQxSv6RvkShUqKg6PFnAuM60zVh2DGrTELUuWBHlcGh89TVX
         iHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nb8+fG5aDnDqob2fPj5abvScrBtAUsmz3VeK2YsK+eY=;
        b=tTR/2Al5HvgQawKOBNSQ7HDreY3HPvfea+DAsuRpc9AcnaGvED0w1AMnVBFrNEEmXZ
         F5NenLgC8V4Pk7AhKc0mTEVb82lU49mX/oTuwAQuntJzysSAWTsD6S3eNmHPTRrJixs9
         pDH/4CKnevkOh89HW6qiachAFdo6slCBpoaSze56dZDM82Uwl+96d7IialnmnaIdbVoN
         dBuAdYHgSIpC291H9jqAKllPQSHEih+Xx2wt9La6MelMRQ19diJyc3CrtBSJt+KTUYaR
         ysggs3NdpEeaea3Vkfm7AxOAN9szwanoCsPqYM+3fJS2yHncHHpNsUeBCMJXk9+sj6fg
         2e7g==
X-Gm-Message-State: AKS2vOxX/qYTRNpAYrmnj30ynTFE3C1DskWYgGYexH+TMjJlr4TzS2mn
        NhJptV/UFkucjN1Zr9z9VUWndCH1CpzvtD2ktA==
X-Received: by 10.98.49.2 with SMTP id x2mr10406660pfx.48.1498258195395; Fri,
 23 Jun 2017 15:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 15:49:54 -0700 (PDT)
In-Reply-To: <xmqqo9tebaco.fsf@gitster.mtv.corp.google.com>
References: <20170623191302.16053-1-sbeller@google.com> <20170623191302.16053-3-sbeller@google.com>
 <xmqqo9tebaco.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 15:49:54 -0700
Message-ID: <CAGZ79ka+va5bRNQL3x3fvn+738iAfJXJfD2PKpt2hmGEg09mTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] builtin/fetch: parse recurse-submodules-default at
 default options parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 3:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -1333,10 +1336,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>               deepen = 1;
>>
>>       if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
>> -             if (recurse_submodules_default) {
>> -                     int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
>> -                     set_config_fetch_recurse_submodules(arg);
>> -             }
>> +             if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)
>> +                     set_config_fetch_recurse_submodules(recurse_submodules_default);
>
> This is not a new thing, and it may not even be a problem, but I
> have to wonder why this needs to be done conditionally.  "The
> command line did not explicitly say --no-recurse-submodules, so we
> would set what came from --recurse-submodule-default if and only if
> that is given---otherwise we leave it as a compiled-in default" is
> what the code before or after this patch tells me.  But if we drop
> the "if (default is not DEFAULT)", the resulting code becomes "The
> command line did not explicitly say --no-recurse-submodules, so we
> would set whatever is the default (which may not have been given
> from the command line, but came built-in to the binary)".  Aren't
> they saying the same thing?

I assumed so as well, yes. But the test suite pointed out there
is another subtlety going on, which I have not dug into, yet.

>
> It's not like there is a configuration knob that further interferes
> the interaction between these two.  I am puzzled.

As far as I suspect, the original author considered
evaluating the additional config too expensive.

    gitmodules_config(); // <- this specifically?
    git_config(submodule_config, NULL);

And that is why we only react if any switch is
given to recurse. Before be254a0ea9 (Add the
'fetch.recurseSubmodules' config setting, 2010-11-11)
we would not load the config unless the user
asked for submodule action.

Then with the config switch we *had* to load the config
(both .gitmodules as well as .git/config), so at that commit
it would have made sense to inline this into the regular config
and command line argument parsing.
