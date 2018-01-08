Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0D61FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 13:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbeAHNnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 08:43:49 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46766 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933086AbeAHNns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 08:43:48 -0500
Received: by mail-qk0-f195.google.com with SMTP id l12so13775720qke.13
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 05:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=toXIXwClBFfCGslbtMNy+QTIsqjI7azhbb4pq9JMIaY=;
        b=NmR9A3c/lUQ8vxTLSdv0CHkHcNtPIkIh4xS26WX5VQiiUpj3bQ4GFvrZf+GgX6ygFr
         UiOoiBN0cx9cnNu4YWlZ4c1OMrwlheWqIWYd42eioXQVzI2MVyOTL9rhQamsMQ+B+MZG
         MIXcAz/C/1RLMvT53ZIq+yV7ZMQeZWAAAUJVKqlJrVRgayip58fzmm5YAhgn5KRYmWYJ
         bTVAZ4UqkdapywfRILB9p4Jrlf7TrRQwOAzeuXNuALbW3v31fxMdLAKQ7T2KBgKAvoMN
         d3i9ZSLkWxFDvG1croU/OZS3+HJCW8xz0ER+Uo8ht+Addiy2VN9acX3lxWj79fgU1y47
         73Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=toXIXwClBFfCGslbtMNy+QTIsqjI7azhbb4pq9JMIaY=;
        b=LNEn2DKkJDBnHRR9lCVdQhcoJVLZy8nAbWS36lugZqIo6ek0xgLwrfaY7apNrrPK+P
         Of//ENmmGz5V54myM1sBeagCV0g8HiuTlQuxYwlHP13ZhdKKHIP3Gkl8QIWawFt1iyly
         lzqhRVERoFO6bLXa3Z1rmspIfWd195EfSqLb1HKhDrbvL7G6SnFy7BaZ1LCvFOv1ELSo
         27hTIjDgfX45+SPuOAqrNIYxN0T/KGA8got2f25lgwc+W9HWGXU71uD/tcaf1n8G+Hh1
         f893k5xZx7y9dgq7e4m9pCm/olnWEA2UV+bAwu+iNi7ncicuapKV9mMDIRphk2uwsfJs
         KQJA==
X-Gm-Message-State: AKwxytdTMulEOVZaSyPRATood6nfwhD6hJT4O9F5/8ODSqu4Tct8XddC
        0yFVtjdyheW+JK6RR173pp8=
X-Google-Smtp-Source: ACJfBouddjt7wszy2E2EBT2pKyfc6ElY9eSBArAS8TRV8oHbyTQQpXZxgyruSwnijmtoWiiDlQGfWA==
X-Received: by 10.55.22.29 with SMTP id g29mr13697311qkh.26.1515419027767;
        Mon, 08 Jan 2018 05:43:47 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 138sm7654561qkl.45.2018.01.08.05.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 05:43:47 -0800 (PST)
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, jrnieder@gmail.com
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
 <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <20180108102029.GA21232@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d00ba196-715d-4613-530c-ef7f7c4562f4@gmail.com>
Date:   Mon, 8 Jan 2018 08:43:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180108102029.GA21232@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2018 5:20 AM, Jeff King wrote:
> On Sun, Jan 07, 2018 at 07:08:54PM -0500, Derrick Stolee wrote:
>
>>> (Not a critique of this, just a (stupid) question)
>>>
>>> What's the practical use-case for this feature? Since it doesn't help
>>> with --abbrev=40 the speedup is all in the part that ensures we don't
>>> show an ambiguous SHA-1.
>> The point of including the --abbrev=40 is to point out that object lookups
>> do not get slower with the MIDX feature. Using these "git log" options is a
>> good way to balance object lookups and abbreviations with object parsing and
>> diff machinery. And while the public data shape I shared did not show a
>> difference, our private testing of the Windows repository did show a
>> valuable improvement when isolating to object lookups and ignoring
>> abbreviation calculations.
> Just to make sure I'm parsing this correctly: normal lookups do get faster
> when you have a single index, given the right setup?
>
> I'm curious what that setup looked like. Is it just tons and tons of
> packs? Is it ones where the packs do not follow the mru patterns very
> well?

The way I repacked the Linux repo creates an artificially good set of 
packs for the MRU cache. When the packfiles are partitioned instead by 
the time the objects were pushed to a remote, the MRU cache performs 
poorly. Improving these object lookups are a primary reason for the MIDX 
feature, and almost all commands improve because of it. 'git log' is 
just the simplest to use for demonstration.

> I think it's worth thinking a bit about, because...
>
>>> If something cares about both throughput and e.g. is saving the
>>> abbreviated SHA-1s isn't it better off picking some arbitrary size
>>> (e.g. --abbrev=20), after all the default abbreviation is going to show
>>> something as small as possible, which may soon become ambigous after the
>>> next commit.
>> Unfortunately, with the way the abbreviation algorithms work, using
>> --abbrev=20 will have similar performance problems because you still need to
>> inspect all packfiles to ensure there isn't a collision in the first 20 hex
>> characters.
> ...if what we primarily care about speeding up is abbreviations, is it
> crazy to consider disabling the disambiguation step entirely?
>
> The results of find_unique_abbrev are already a bit of a probability
> game. They're guaranteed at the moment of generation, but as more
> objects are added, ambiguities may be introduced. Likewise, what's
> unambiguous for you may not be for somebody else you're communicating
> with, if they have their own clone.
>
> Since we now scale the default abbreviation with the size of the repo,
> that gives us a bounded and pretty reasonable probability that we won't
> hit a collision at all[1].
>
> I.e., what if we did something like this:
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..04c661ba85 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -600,6 +600,15 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>   	if (len == GIT_SHA1_HEXSZ || !len)
>   		return GIT_SHA1_HEXSZ;
>   
> +	/*
> +	 * A default length of 10 implies a repository big enough that it's
> +	 * getting expensive to double check the ambiguity of each object,
> +	 * and the chance that any particular object of interest has a
> +	 * collision is low.
> +	 */
> +	if (len >= 10)
> +		return len;
> +
>   	mad.init_len = len;
>   	mad.cur_len = len;
>   	mad.hex = hex;
>
> If I repack my linux.git with "--max-pack-size=64m", I get 67 packs. The
> patch above drops "git log --oneline --raw" on the resulting repo from
> ~150s to ~30s.
>
> With a single pack, it goes from ~33s ~29s. Less impressive, but there's
> still some benefit.
>
> There may be other reasons to want MIDX or something like it, but I just
> wonder if we can do this much simpler thing to cover the abbreviation
> case. I guess the question is whether somebody is going to be annoyed in
> the off chance that they hit a collision.

No only are users going to be annoyed when they hit collisions after 
copy-pasting an abbreviated hash, there are also a large number of tools 
that people build that use abbreviated hashes (either for presenting to 
users or because they didn't turn off abbreviations).

Abbreviations cause performance issues in other commands, too (like 
'fetch'!), so whatever short-circuit you put in, it would need to be 
global. A flag on one builtin would not suffice.

> -Peff
>
> [1] I'd have to check the numbers, but IIRC we've set the scaling so
>      that the chance of having a _single_ collision in the repository is
>      less than 50%, and rounding to the conservative side (since each hex
>      char gives us 4 bits). And indeed, "git log --oneline --raw" on
>      linux.git does not seem to have any collisions at its default of 12
>      characters, at least in my clone.
>
>      We could also consider switching core.disambiguate to "commit",
>      which makes even a collision less likely to annoy the user.


