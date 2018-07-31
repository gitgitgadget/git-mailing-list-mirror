Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80D7208E9
	for <e@80x24.org>; Tue, 31 Jul 2018 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeGaRlG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:41:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44764 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeGaRlG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:41:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so17217213wrt.11
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HK1jjBtl8m/wgwe2c5UJZTo5UPrVf7y6Bcy9GsTNrbw=;
        b=HjV0ZEvIHOjC3644D0djknKW3PQKjufGgEuIPEBlFPdwb5X5b+szCbtwrLHTH9b4KS
         +ATk4tRt/oHYZRNQfmbihHfTMDFFn2wecm2dVKgebmeZIch6NkiqC+ExI2CNy9c4Kb9l
         NxeQPfjbFYnCdqgs2Xe4dxUL3pS03Fbh09XtC+JCtGl40ngE5fAGl4afORwjPZIF4Ne2
         81qnVOtawowyuGNjhAsmwp0dlB7soljm6sVHstYER5ljeriDZb8SPjaGBgXwlVpSzV9R
         QOpRJwtIOnBNfxTIRlEGMOrvnASMHwyhblao194ib2jPQrN7oqj3GKbHiP1i+IOWCjsd
         UddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HK1jjBtl8m/wgwe2c5UJZTo5UPrVf7y6Bcy9GsTNrbw=;
        b=Kzu/uYOAupBzUjXx6XoTjqOcjOWU2+lsTYR3tU1kB9PWli2xXZ2Bs7whyg9sWOT+Tn
         58W16pvA2ua/3JByuRRVJ27nHREHOkhaS3Mcg9UC3Fc67Ot457XGk6CG917CE/p20+Ai
         LhuBtfzgrtQlcvUiXIjZDAKIHO+Pf3SuJPtaDRT8jumGGlvPg0NcEkRIEhRssuXjuHwz
         0Nd7GYCky7WBrwiEOP2P4Figg+5dYhvOpYT8O6QQ0K/EFj4hqA/KU5trI5kKoUSYBd9J
         9TwxCTWJ7baMzheRxvRNy7bspprsrvF5E22AZ+tqEIzDDYHWUulei2i8ZfXDxYpoT9po
         e1Ew==
X-Gm-Message-State: AOUpUlGJxXTniEBidUCxfluCG7Ie6wCt5+5Pdngs6dWp05Gj/gqlXAzg
        +iCp0e9p6Q38gXVfKdn2A7o=
X-Google-Smtp-Source: AAOMgpfLqfDMPNtIyLjLoQvksZ2mUgNX9vApTHNR8jAykSRizEbohMwcC64D0/S3aYRUxAazIqXb0Q==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr11670360wre.29.1533052806774;
        Tue, 31 Jul 2018 09:00:06 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.gmail.com with ESMTPSA id m207-v6sm2876274wma.31.2018.07.31.09.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 09:00:05 -0700 (PDT)
Subject: Re: [GSoC][PATCH v4] fixup! rebase -i: rewrite write_basic_state() in
 C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20180730182516.32644-1-szeder.dev@gmail.com>
 <20180731121115.12296-1-alban.gruin@gmail.com>
 <xmqqy3drctu4.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ad8fe398-6e7b-b50f-df96-35ac06049020@gmail.com>
Date:   Tue, 31 Jul 2018 17:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3drctu4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 31/07/2018 à 17:23, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> As pointed out by SZEDER Gábor, git-rebase.sh wrote to to 'quiet' with
>> an `echo`:
>>
>>     echo "$GIT_QUIET" > "$state_dir/quiet"
>>
>> This mean that even if $GIT_QUIET is empty, a newline is written to
>> quiet.  The rewrite of write_basic_state() changed this behaviour, which
>> could lead to problems.  This patch changes the rewritten version to
>> behave like the shell version.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>> Hi Junio, could you apply this patch on top of ag/rebase-i-in-c, please?
> 
> Hmph, from reading your other message
> 
>   https://public-inbox.org/git/dce8c99b-51e9-4ed1-8ae4-28049cb6e7ec@gmail.com/
> 
> I got an impression that a rerolled version is coming anyway.  Is
> this fix so urgent that it needs tobe squashed in in the meantime
> and cannot wait?
> 

I wanted to reroll it first, but the only changes would have been this
fix and Ramsay’s patch.  I was advised to send a fixup! patch instead.

I can send a reroll if you want, but it won’t have any more changes.

Cheers,
Alban


>>
>>  sequencer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index d257903db0..0d41e82953 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2332,7 +2332,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>>  	if (quiet)
>>  		write_file(rebase_path_quiet(), "%s\n", quiet);
>>  	else
>> -		write_file(rebase_path_quiet(), "");
>> +		write_file(rebase_path_quiet(), "\n");
>>  
>>  	if (opts->verbose)
>>  		write_file(rebase_path_verbose(), "");

