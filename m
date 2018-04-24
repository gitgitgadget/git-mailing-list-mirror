Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A041F424
	for <e@80x24.org>; Tue, 24 Apr 2018 16:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeDXQxu (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 12:53:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45112 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDXQxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 12:53:48 -0400
Received: by mail-qt0-f194.google.com with SMTP id b13-v6so22995236qtp.12
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gWrqAGZTJOV6Ncror6Yeu7vPVtG13fOZSzZjjioEjIQ=;
        b=pLCRGA5z6vPZiryGkO1DraNvL6/9O9o3E7PzaeV0lt7HWkGFXGiM2cuWapaLOYqIYz
         gYE9jyatADVftF+xhzposAh/hflpXEn7BKftch2UXB1bmPE90oT5EHYvZ4zoJ+UME6mQ
         W0r//Odb4lpY32xVcQ95a2QZkSP7NO/fOXFUcPg3o9UgPFQpibDsPQwmmUcQ3Ke9rio6
         Ww8HRVKTB91wdEqLC+5Wx5XlEPsisuxW45U2EkEWVOf0GOZ5kzE+QshQJrexuBJXDDc6
         6LBml9EwUG5q/KP29xGfdW/4MEsFGFeDBXfuEZCfySXDnd0qWWeHF/rDnYQb/9nZFumi
         m30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gWrqAGZTJOV6Ncror6Yeu7vPVtG13fOZSzZjjioEjIQ=;
        b=WBjYY3lGpqgRHTZ3/9X+Eu9hrbcq0g2fN9XLXjLoxpAtvLWJSkfgI3T5d431Q2ejSC
         pEPLPRXNsT2t11jH6zMravt1eDNqQG48/ssSOH1MNTxiuF5nRdG8SdMr9M0s+tk2BY+9
         Ta+OJjhK5c6bjVGEflhW55nzK8OyYGf8c0l33Is7uy2MAFqrPdFIZBlFyswRRW6ywjX7
         8PywYmGRuesEWpCJ8EIRKQSSM1HDb53pLh+98yohRgWDB/T1tSuYafpy2yrmqMuyI0gg
         3NHckDRhF72IyaIGC/2EjhugCyuCf7HzGhphC6LsgKj41VlhONP4pv2R4Jk/FTHQyUHF
         J4vA==
X-Gm-Message-State: ALQs6tD6eXN5mGac4Y5ji33vT9yZs000IReDbbTFbLyaywzYizf2OSoZ
        ULoUwU7smdoEsnUqRzQbs5Y=
X-Google-Smtp-Source: AIpwx4+Clp+M5IaSmDiVQFswb8KmpYFqbWzMskXtmxMoYJ99QzwxMj5FEg/vaYcCLqNP69TyO5jbyw==
X-Received: by 2002:ac8:3fd9:: with SMTP id v25-v6mr28303814qtk.54.1524588827833;
        Tue, 24 Apr 2018 09:53:47 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z185sm12268126qkz.65.2018.04.24.09.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 09:53:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
 <20180422120718.GA29956@esm> <0eea1726-d511-6818-aa29-add6c13900da@gmail.com>
 <20180423213228.GA20391@esm>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ccb85580-e0cc-f1e6-6667-ea89ac90106f@gmail.com>
Date:   Tue, 24 Apr 2018 12:53:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423213228.GA20391@esm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/23/2018 5:32 PM, Eckhard Maaß wrote:
> On Mon, Apr 23, 2018 at 09:15:09AM -0400, Ben Peart wrote:
>> In commit 2a2ac926547 when merge.renamelimit was added, it was decided to
>> have separate settings for merge and diff to give users the ability to
>> control that behavior.  In this particular case, it will default to the
>> value of diff.renamelimit when it isn't set.  That isn't consistent with the
>> other merge settings.
> 
> However, it seems like a desirable way to do it.

I'm just one opinion among many but I personally believe the cascading 
settings are complicated enough just with the various config files and 
command line options and which overwrite the others.  I'd rather not 
complicate them further by having settings inherited from one feature 
(diff) to another (merge).

There are currently ~15 merge specific config settings and only 
merge.renamelimit currently does this inheritance.  That said, at least 
one other person thought it was a good idea. :)

> 
> Maybe let me throw in some code for discussion (test and documentation
> is missing, mainly to form an idea what the change in options should
> be). I admit the patch below is concerned only with diff.renames, but
> whatever we come up with for merge should be reflected there, too,
> doesn't it >
> Greetings,
> Eckhard
> 
> -- >8 --
> 
>  From e8a88111f2aaf338a4c19e83251c7178f7152129 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
> Date: Sun, 22 Apr 2018 23:29:08 +0200
> Subject: [PATCH] diff: enhance diff.renames to be able to set rename score
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Eckhard S. Maaß <eckhard.s.maass@gmail.com>
> ---
>   diff.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 1289df4b1f..a3cedad5cf 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -30,6 +30,7 @@
>   #endif
>   
>   static int diff_detect_rename_default;
> +static int diff_rename_score_default;
>   static int diff_indent_heuristic = 1;
>   static int diff_rename_limit_default = 400;
>   static int diff_suppress_blank_empty;
> @@ -177,13 +178,33 @@ static int parse_submodule_params(struct diff_options *options, const char *valu
>   	return 0;
>   }
>   
> +int parse_rename_score(const char **cp_p);
> +
> +static int git_config_rename_score(const char *value)
> +{
> +	int parsed_rename_score = parse_rename_score(&value);
> +	if (parsed_rename_score == -1)
> +		return error("invalid argument to diff.renamescore: %s", value);
> +	diff_rename_score_default = parsed_rename_score;
> +	return 0;
> +}
> +
>   static int git_config_rename(const char *var, const char *value)
>   {
> -	if (!value)
> -		return DIFF_DETECT_RENAME;
> -	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
> -		return  DIFF_DETECT_COPY;
> -	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
> +	if (!value) {
> +		diff_detect_rename_default = DIFF_DETECT_RENAME;
> +		return 0;
> +	}
> +	if (skip_to_optional_arg(value, "copies", &value) || skip_to_optional_arg(value, "copy", &value)) {
> +		diff_detect_rename_default = DIFF_DETECT_COPY;
> +		return git_config_rename_score(value);
> +	}
> +	if (skip_to_optional_arg(value, "renames", &value) || skip_to_optional_arg(value, "rename", &value)) {
> +		diff_detect_rename_default = DIFF_DETECT_RENAME;
> +		return git_config_rename_score(value);
> +	}
> +	diff_detect_rename_default = git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
> +	return 0;
>   }
>   
>   long parse_algorithm_value(const char *value)
> @@ -307,8 +328,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>   		return 0;
>   	}
>   	if (!strcmp(var, "diff.renames")) {
> -		diff_detect_rename_default = git_config_rename(var, value);
> -		return 0;
> +		return git_config_rename(var, value);
>   	}
>   	if (!strcmp(var, "diff.autorefreshindex")) {
>   		diff_auto_refresh_index = git_config_bool(var, value);
> @@ -4116,6 +4136,7 @@ void diff_setup(struct diff_options *options)
>   	options->add_remove = diff_addremove;
>   	options->use_color = diff_use_color_default;
>   	options->detect_rename = diff_detect_rename_default;
> +	options->rename_score = diff_rename_score_default;
>   	options->xdl_opts |= diff_algorithm;
>   	if (diff_indent_heuristic)
>   		DIFF_XDL_SET(options, INDENT_HEURISTIC);
> 
