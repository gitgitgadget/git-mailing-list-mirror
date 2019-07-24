Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFE21F462
	for <e@80x24.org>; Wed, 24 Jul 2019 20:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfGXUeI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 16:34:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40072 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfGXT1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 15:27:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so46636095qtn.7
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hILylbnGVoxZCd5OSbCq2bZZbvK5Zfo9WAhGttVOydw=;
        b=O14pPBFbuVmtrPDNkJyKQ9K3CKhJWcJlPGYOnC7/EtDTib4/AMy9Y0Vd+7sa8K0Xrs
         P2dc7GdpVSSR46wuMECtWKbLwJnUFdXzI/LJpg1YPmNbSsF6XmgcPrH4tMH0Xyo/uzLI
         ZGZQN3K0A5nSz3LoUHEy0JXdBWp1kTEto9d2pnSnt4CwbzeC+StVph/zGDXwL92X+1SR
         vgbbsFcoAkYzchDkWSf2PZjcGPa71piE91UCfC2bCOh0mKo253Tqh0me8LTTQmJOfsqF
         Ufo0pG+9qWR0BHE9VIZbzaDW68Agf63gZxxfQoA9qpTmvNsUZHBZ/UH4/HIbt8WS9BVl
         FEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hILylbnGVoxZCd5OSbCq2bZZbvK5Zfo9WAhGttVOydw=;
        b=DYd4LilS/Po3DnsLvuzV7Lad9ny04coHTcgSal7ncY9/dtpis1S25vtc6hwpx4WYSL
         eCyn+GR1F1VpvAE1hf9ETtj+4mXPoRIGrsbrB7YBPxczqiNM/NxBGvtQo93kT2QXbZVd
         /FDKvNx47kWxRn1gqekuBnJTtsartsYhh8yM66MJNbVYnuJj78aZulMMFdvKGQ+LojsD
         xhPCVTduejvqwmc/6R7LZJZ/Zx2yn5+BuJZpLJ8DNMc3cDh70aOQ2y9IDGlp8zn3gdlF
         P3c85acm9P5swPNlsD9a67s1HXRJC2ZwMdLgxESpTcJq+/qSSDagC+dMqDZzozpoeKPT
         3KPQ==
X-Gm-Message-State: APjAAAW7XoBK3KMCR773zctUOWXghNLV1NwWUMJJ9o2rmNlcrmW2j+bX
        pQjNc7i3/c9GVdHU2bjkaF0=
X-Google-Smtp-Source: APXvYqwqe9j3eXLgLaG3CE9mse0LyJyJ1fS/H5lphsL9UPfzPXkeEniZMvofonquJ6CSZinb8gAEvQ==
X-Received: by 2002:a0c:d91b:: with SMTP id p27mr59507192qvj.236.1563996430590;
        Wed, 24 Jul 2019 12:27:10 -0700 (PDT)
Received: from [10.0.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e18sm16652179qkm.49.2019.07.24.12.27.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:27:09 -0700 (PDT)
Subject: Re: [PATCH 3/5] repo-settings: parse core.untrackedCache
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.git.gitgitgadget@gmail.com>
 <47ae3e7d4d765a00d14e8892db88a8936d56591b.1563818059.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1907231656580.21907@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d7de6f0-f7cb-ba6b-85e9-fc466944ed6b@gmail.com>
Date:   Wed, 24 Jul 2019 15:27:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907231656580.21907@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/23/2019 11:04 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The core.untrackedCache config setting is slightly complicated,
>> so clarify its use and centralize its parsing into the repo
>> settings.
>>
>> The default value is "keep" (returned as -1), which persists the
>> untracked cache if it exists.
>>
>> If the value is set as "false" (returned as 0), then remove the
>> untracked cache if it exists.
>>
>> If the value is set as "true" (returned as 1), then write the
>> untracked cache and persist it.
>>
>> Instead of relying on magic values of -1, 0, and 1, split these
>> options into bitflags CORE_UNTRACKED_CACHE_KEEP and
>> CORE_UNTRACKED_CACHE_WRITE. This allows the use of "-1" as a
>> default value. After parsing the config options, if the value is
>> unset we can initialize it to CORE_UNTRACKED_CACHE_KEEP.
> 
> Nice!
> 
>> [...]
>> diff --git a/read-cache.c b/read-cache.c
>> index ee1aaa8917..e67e6f6e3e 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1846,18 +1846,17 @@ static void check_ce_order(struct index_state *istate)
>>
>>  static void tweak_untracked_cache(struct index_state *istate)
>>  {
>> -	switch (git_config_get_untracked_cache()) {
>> -	case -1: /* keep: do nothing */
>> -		break;
>> -	case 0: /* false */
>> +	struct repository *r = the_repository;
>> +
>> +	prepare_repo_settings(r);
>> +
>> +	if (!(r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_KEEP)) {
>>  		remove_untracked_cache(istate);
>> -		break;
>> -	case 1: /* true */
>> -		add_untracked_cache(istate);
>> -		break;
>> -	default: /* unknown value: do nothing */
>> -		break;
>> +		return;
>>  	}
>> +
>> +	if (r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_WRITE)
>> +		add_untracked_cache(istate);
> 
> This changes the flow in a subtle way: in the
> `CORE_UNTRACKED_CACHE_WRITE` case, we used to _not_ remove the untracked
> cache, but now we do.
> 
> I _think_ what you would want to do is replace the `!(..._KEEP)`
> condition by `..._REMOVE`.

I believe the code as written is correct, but confusing. The value is not an enum, but instead a bitflag. When the config setting is given as "true", then both _KEEP and _WRITE are set, so the flow is identical.

However, you already suggested switching to an enum, in which case using _REMOVE would be clearer.

> 
>>  }
>>
>>  static void tweak_split_index(struct index_state *istate)
>> diff --git a/repo-settings.c b/repo-settings.c
>> index f328602fd7..807c5a29d6 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -30,6 +30,20 @@ static int git_repo_config(const char *key, const char *value, void *cb)
>>  		rs->index_version = git_config_int(key, value);
>>  		return 0;
>>  	}
>> +	if (!strcmp(key, "core.untrackedcache")) {
>> +		int bool_value = git_parse_maybe_bool(value);
>> +		if (bool_value == 0)
>> +			rs->core_untracked_cache = 0;
>> +		else if (bool_value == 1)
>> +			rs->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP |
>> +						   CORE_UNTRACKED_CACHE_WRITE;
>> +		else if (!strcasecmp(value, "keep"))
>> +			rs->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
>> +		else
>> +			error(_("unknown core.untrackedCache value '%s'; "
>> +				"using 'keep' default value"), value);
>> +		return 0;
>> +	}
>>
>>  	return 1;
>>  }
>> @@ -46,6 +60,13 @@ void prepare_repo_settings(struct repository *r)
>>  	r->settings->gc_write_commit_graph = -1;
>>  	r->settings->pack_use_sparse = -1;
>>  	r->settings->index_version = -1;
>> +	r->settings->core_untracked_cache = -1;
> 
> At this point at the latest, I am starting to wonder whether it would
> not make more sense to use `memset(..., -1, sizeof(struct
> repo_settings)` instead.
> 
>>
>>  	repo_config(r, git_repo_config, r->settings);
>> +
>> +	/* Hack for test programs like test-dump-untracked-cache */
>> +	if (ignore_untracked_cache_config)
>> +		r->settings->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
>> +	else
>> +		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACHE_KEEP);
>>  }
>> diff --git a/repo-settings.h b/repo-settings.h
>> index 1151c2193a..bac9b87d49 100644
>> --- a/repo-settings.h
>> +++ b/repo-settings.h
>> @@ -1,11 +1,15 @@
>>  #ifndef REPO_SETTINGS_H
>>  #define REPO_SETTINGS_H
>>
>> +#define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
>> +#define CORE_UNTRACKED_CACHE_KEEP (1 << 1)
> 
> I think it would read even nicer as an enum. In any case, using `1<<1`
> suggests that this is a bit field, but I don't think that is what we
> actually want here. Instead, what `core_untracked_cache` seems to be (at
> least from my point of view) is a mode, where any two modes are mutually
> exclusive.
> 
> For example, what is the difference between `(_KEEP | _WRITE)` and
> `(_WRITE)` supposed to be? That the latter writes a fresh untracked
> cache without looking at the previous one? That's not how the existing
> code behaves, though...

Yes, there is no reason to have _WRITE without also _KEEP. An enum is better. Thanks!

> 
> Ciao,
> Dscho
> 
>> +
>>  struct repo_settings {
>>  	int core_commit_graph;
>>  	int gc_write_commit_graph;
>>  	int pack_use_sparse;
>>  	int index_version;
>> +	int core_untracked_cache;
>>  };
>>
>>  struct repository;
>> --
>> gitgitgadget
>>
>>
