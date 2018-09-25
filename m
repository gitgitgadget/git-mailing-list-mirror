Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152C21F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeIZEkz (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:40:55 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41704 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeIZEkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:40:55 -0400
Received: by mail-ed1-f53.google.com with SMTP id f38-v6so172929edd.8
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cRd41phCVqwWwec2D4r3S5/ybwN9F2sIfqMxD3nA0K4=;
        b=GRJFtoehk88Ikke8pMNnZjMgy1lZ5X/va6BL0guNtaznfJrfTHnoDSKlLn2qcgDzqM
         4vS6kpZMv1OsnsLboIUQtMNRoWowlYjKoXVAuuYhw/9AxLmemOy2f2ylMgv3mv1qevem
         697KKLN1XrD4P5Stq8tKj0CYmAk6GEXA37MFi7gDBAzcNY5aRgD8JhmINkJG7fHQrRw1
         2tzT9N7bjabddh/gKEHaa/JZclbj5Z+IkBSfv054n5oGIikg8GfXgx2WtxgLSJLQL+Jj
         EcfnNbB7NZtQOAso15sfpz99hCQsC6xvzFJ9y1h6L9Ql/qeiD8IG45aMdlEuPPjg/5xi
         +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRd41phCVqwWwec2D4r3S5/ybwN9F2sIfqMxD3nA0K4=;
        b=fnMh2gd/n3ebGuC9IwVV/BcJrKanIzCC4t7sMbOZmkzi+/rf5iBhAtgRiIHwKCDbXI
         fMkgoNeLBoJsURVCB7e/Q5A9xxSv3YIUVwzmjEV64R/ICRxfuirj7qv8emykj6B490sc
         vkO2h686AHYexlmSZ5BoFrbdv93yMLYS4hrn0jWV/NTVEDvxruQXQlxcBXxJHdp87kBf
         o+aXS7h6MIf20SuPJdUGxTPj+REoOAjDq2lDwmog9OQTekkpuli5XBj5RnUZvOvYo7Q7
         +sHhjQWkudlECM6R/fm9NnfyEnpnYHjjVcvzs/D7FbAknjeQhdjrVJ5kNfZC2yzUcjA+
         gkhQ==
X-Gm-Message-State: ABuFfoj+YovuWc+p32U1M7lS8xwOzFifnEkLjcfMSQmn+2cNlPf0tCjr
        3I4INNfTEteXv6QU5VDNgAt/UQXX
X-Google-Smtp-Source: ACcGV62B71xTkQViPp4XJVSQbnfROJQpRhpybZzCgX2iAjWhk97v73Lbe4m9tA71XBwkfSgda0Ii0Q==
X-Received: by 2002:a50:9ac5:: with SMTP id p63-v6mr5058114edb.112.1537914669487;
        Tue, 25 Sep 2018 15:31:09 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id h8-v6sm8236491edi.68.2018.09.25.15.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:31:08 -0700 (PDT)
Subject: Re: [GSoC][PATCH v8 18/20] stash: convert `stash--helper.c` into
 `stash.c`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
 <82f5af08c6475765fac27e30f716a48039d56404.1535665109.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1809031640490.71@tvgsbejvaqbjf.bet>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <4de1b725-8687-590a-f93f-e80843e5bf8f@gmail.com>
Date:   Wed, 26 Sep 2018 01:31:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1809031640490.71@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>>   
>> @@ -1443,9 +1448,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
>>   		OPT_END()
>>   	};
>>   
>> -	argc = parse_options(argc, argv, prefix, options,
>> -			     git_stash_helper_push_usage,
>> -			     0);
>> +	if (argc)
>> +		argc = parse_options(argc, argv, prefix, options,
>> +				     git_stash_push_usage,
>> +				     0);
> 
> Is this `if (argc)` guard necessary?

Yes because without it, there would be a seg fault when
calling `git stash`. Why?

After spawning `git stash`, in `push_stash()`: `argc` would be
0 (and `argv` would be `NULL`).

`parse_options()` calls `parse_options_start()` which does the following:

	ctx->argc = ctx->total = argc - 1;
	ctx->argv = argv + 1;

So, `ctx->argc` would be `-1`. After we are back to `parse_options()`,
`parse_options_step()` would be called. In `parse_options_step()`:

	for (; ctx->argc; ctx->argc--, ctx->argv++)

Which is an infinite loop, because `ctx->argc` is already -1.

This check is also done for `git notes list` (function `list()`
inside `builtin/notes.c`). Now, that I relook at it, it seems to me
that this is a bug. Probably a better solution would be to check at the 
beginning of `parse_options()` and return early if `argc` is less then one.

>> @@ -1536,7 +1544,44 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>>   		return !!push_stash(argc, argv, prefix);
>>   	else if (!strcmp(argv[0], "save"))
>>   		return !!save_stash(argc, argv, prefix);
>> +	else if (*argv[0] != '-')
>> +		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>> +			      git_stash_usage, options);
>> +
>> +	if (strcmp(argv[0], "-p")) {
>> +		while (++i < argc && strcmp(argv[i], "--")) {
>> +			/*
>> +			 * `akpqu` is a string which contains all short options,
>> +			 * except `-m` which is verified separately.
>> +			 */
>> +			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
>> +			    strchr("akpqu", argv[i][1]))
> 
> I *think* this is missing the `n`.

I guess that by `n` you are referring to the short option of
`--no-keep-index`, which is missing because it was also omitted
in `stash.sh`. I am not sure whether it is worth adding it. In
case `stash` will learn any other option starting with `n`, this
might create confusion amongst users.

Best regards,
Paul
