Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EC21F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeKMF10 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 00:27:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41934 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeKMF10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 00:27:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id c25-v6so8358664edt.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 11:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nQswtT3cEV26ndXm2+QKC0MVvDguluD5ChyRoK2ta7I=;
        b=o9JDUKwTScXB8PMIgD4vMjg3/i6VOdHmujVwxbAtAiMAPFf4wvOYzhW5fNigGrBGoL
         2NULLFdkLr0M1aJQZgY28GKiz9KQZhoy/McNvPZZcCFtlcJNQ3RDYOC95gftVek3022d
         fmPjfyTs7dd8L+PxayIA9S/INExGYvZgbNu0T4KlfJYHKYl7glCgIf7tLQidztIBN+Kh
         bFfkyOgPdQwcfsfu1Tpupy83rqfCms2eju4FIkAV0/ixtjI4D9a1H/2hB0WtGD3qOJGl
         emUzG+CTmRWDJKYMo4MsO36jw6Wkau9+bdXYxvqKeGvrYZxUEfhJ0+n88/Ct8qVqY88U
         6kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=nQswtT3cEV26ndXm2+QKC0MVvDguluD5ChyRoK2ta7I=;
        b=uS4VnDRdnL2sdWqbp6f8cxXUCe/ujeCZkucIedVDtgf6Bmi90NCxj+Wd6P6Vy89ML+
         flvlBQVO9v6VvZo/04K2VwaGaJspfNyPFKnvxePqwT4rMKngI3eATQkteItWQPDaRZvf
         K6/uafH8rSMbaNNw7zH4xOUkZQ8kV+OkjX1+aj06Y/vMTxyBTmUi6Hpv2prfGf8IuUig
         i8nYDFuYADBbVw9ai3VLN9gdhSrcOrnl+L2AQH5+l+BvhngRF0Beu1+6de3eM/NfyXsf
         DYYFkPU5XKSjXu7Gigv5EMBnHeC041xSSeHLkPpVa7Sc1FiAjQc4Mzd4WfRESNwbs2Am
         s+VA==
X-Gm-Message-State: AGRZ1gL8og19Wn+hRm6jTN7aOT2gDKm7G66OU8HfUfW/yLn3vXtYO15G
        FrMpjLBr6/M0u7CRj98ZOYNEsWIv
X-Google-Smtp-Source: AJdET5dcv1REoVd4xHA1vPigZG485KTZreBQ0Vwoh7n9weHBvYUMRCmxE54+KEfVwsOjr/+lC3xQ9Q==
X-Received: by 2002:a50:97f3:: with SMTP id f48mr2225485edb.271.1542051166362;
        Mon, 12 Nov 2018 11:32:46 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b42-v6sm4924958edd.81.2018.11.12.11.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:32:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 9/9] fetch-pack: drop custom loose object cache
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145558.GI7400@sigill.intra.peff.net> <a08d8e20-ecb5-3135-f294-56dec1730b5f@web.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <a08d8e20-ecb5-3135-f294-56dec1730b5f@web.de>
Date:   Mon, 12 Nov 2018 20:32:43 +0100
Message-ID: <87efbq2isk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, René Scharfe wrote:

> Am 12.11.2018 um 15:55 schrieb Jeff King:
>> Commit 024aa4696c (fetch-pack.c: use oidset to check existence of loose
>> object, 2018-03-14) added a cache to avoid calling stat() for a bunch of
>> loose objects we don't have.
>>
>> Now that OBJECT_INFO_QUICK handles this caching itself, we can drop the
>> custom solution.
>>
>> Note that this might perform slightly differently, as the original code
>> stopped calling readdir() when we saw more loose objects than there were
>> refs. So:
>>
>>   1. The old code might have spent work on readdir() to fill the cache,
>>      but then decided there were too many loose objects, wasting that
>>      effort.
>>
>>   2. The new code might spend a lot of time on readdir() if you have a
>>      lot of loose objects, even though there are very few objects to
>>      ask about.
>
> Plus the old code used an oidset while the new one uses an oid_array.
>
>> In practice it probably won't matter either way; see the previous commit
>> for some discussion of the tradeoff.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  fetch-pack.c | 39 ++-------------------------------------
>>  1 file changed, 2 insertions(+), 37 deletions(-)
>>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index b3ed7121bc..25a88f4eb2 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -636,23 +636,6 @@ struct loose_object_iter {
>>  	struct ref *refs;
>>  };
>>
>> -/*
>> - *  If the number of refs is not larger than the number of loose objects,
>> - *  this function stops inserting.
>> - */
>> -static int add_loose_objects_to_set(const struct object_id *oid,
>> -				    const char *path,
>> -				    void *data)
>> -{
>> -	struct loose_object_iter *iter = data;
>> -	oidset_insert(iter->loose_object_set, oid);
>> -	if (iter->refs == NULL)
>> -		return 1;
>> -
>> -	iter->refs = iter->refs->next;
>> -	return 0;
>> -}
>> -
>>  /*
>>   * Mark recent commits available locally and reachable from a local ref as
>>   * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
>> @@ -670,30 +653,14 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>>  	struct ref *ref;
>>  	int old_save_commit_buffer = save_commit_buffer;
>>  	timestamp_t cutoff = 0;
>> -	struct oidset loose_oid_set = OIDSET_INIT;
>> -	int use_oidset = 0;
>> -	struct loose_object_iter iter = {&loose_oid_set, *refs};
>> -
>> -	/* Enumerate all loose objects or know refs are not so many. */
>> -	use_oidset = !for_each_loose_object(add_loose_objects_to_set,
>> -					    &iter, 0);
>>
>>  	save_commit_buffer = 0;
>>
>>  	for (ref = *refs; ref; ref = ref->next) {
>>  		struct object *o;
>> -		unsigned int flags = OBJECT_INFO_QUICK;
>>
>> -		if (use_oidset &&
>> -		    !oidset_contains(&loose_oid_set, &ref->old_oid)) {
>> -			/*
>> -			 * I know this does not exist in the loose form,
>> -			 * so check if it exists in a non-loose form.
>> -			 */
>> -			flags |= OBJECT_INFO_IGNORE_LOOSE;
>
> This removes the only user of OBJECT_INFO_IGNORE_LOOSE.  #leftoverbits

With this series applied there's still a use of it left in
oid_object_info_extended()
