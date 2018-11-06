Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18151F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeKGFnc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:43:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32942 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeKGFnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 00:43:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so4170966qtp.0
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BKTzK8dAfr0tebNzFhIev8PtXgMVI7d4ANKRtbgJ8xM=;
        b=YuRsCuLlx+7gwyrlpoeJ5nNXePT2OQ5Q4z+xE4idpGBEtLb8LzSS5vdpjiDIupvtUE
         F5NObb1qmy5yTLRy0LkbhFwjs1YcSF9Wobz3jrPytrJojOVhzZIMvxtprkdRawroRdHv
         tzYceiQuCKSEK8Bb2Li/6MnpT/zMZWxSV/sI6m8D7Ihx0Q3iz+hbM16EedyxcTbyWVmT
         KPqGnNVxbjPJ1xhRVUP93zn0Mfi9z4Cfy4MwzkiSil83/wq5VC0PXmP0X4nmN9/4VqE7
         z0ad9hS/GIW8zry+4+ECAJuek486F4nPKKmylggPzBTrqRGnO9RnQmSgIt6nR424Bpym
         oqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BKTzK8dAfr0tebNzFhIev8PtXgMVI7d4ANKRtbgJ8xM=;
        b=thUV1GBnQJEqb3CXM8J+uv47+PaPlXcEiXedoEH6p8C1R2dpt4507EoNyFkjNt6WI0
         y4guvZKXGNv/N4DCNxfM0wS63SULgIRP8yPcGijomEM/X029eZViGylHHFTocx7Ki1hq
         lcn5Ughzbaz0L5oz4yxAruC5wKy2WQP6zEU5ihsAPDCoPfUiLJ4fBIKLN/LvxHdtB3mk
         b6F/1eVu8/me0MR/jQVAI9Xb5dOZ2Cw5wbf/Nd4mDWm9rdeeN14Qgcwn7vkGMLQr5ora
         JUGPrJfG3oagtcqu99cdZBw/PHMwu/pfmreOgtXK13hVR1ab8mqRvTooTEppf/nqC3fe
         1OMw==
X-Gm-Message-State: AGRZ1gKHI5354Z1JOzAP0vhLj/QuMMgzZzMcGRPbj5iHKNdGUPpjwNMZ
        Hc6BYVhLzcWAs6yfVwYxyh4=
X-Google-Smtp-Source: AJdET5dqCFEYVhL1kjN/jd/IKo6QOatVEuArxJaRPXVTQJaLerpzv9RZeXVbN2YrM4uAxsq5hxj9zA==
X-Received: by 2002:ac8:30ac:: with SMTP id v41mr26488480qta.51.1541535395351;
        Tue, 06 Nov 2018 12:16:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9183:6eb:3bc0:1bbd? ([2001:4898:8010:0:7ab9:6eb:3bc0:1bbd])
        by smtp.gmail.com with ESMTPSA id g46-v6sm28598965qta.79.2018.11.06.12.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 12:16:34 -0800 (PST)
Subject: Re: [PATCH 0/1] send-pack: set core.warnAmbiguousRefs=false
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.68.git.gitgitgadget@gmail.com>
 <20181106194442.GB8902@sigill.intra.peff.net>
 <20181106195131.GA5289@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f2ff23be-9f26-6296-f7a4-b95f9f2ec1f6@gmail.com>
Date:   Tue, 6 Nov 2018 15:16:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181106195131.GA5289@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/6/2018 2:51 PM, Jeff King wrote:
> On Tue, Nov 06, 2018 at 02:44:42PM -0500, Jeff King wrote:
>
>>> The fix for this is simple: set core.warnAmbiguousRefs to false for this
>>> specific call of git pack-objects coming from git send-pack. We don't want
>>> to default it to false for all calls to git pack-objects, as it is valid to
>>> pass ref names instead of object ids. This helps regain these seconds during
>>> a push.
>> I don't think you actually care about the ambiguity check between refs
>> here; you just care about avoiding the ref check when we've seen (and
>> are mostly expecting) a 40-hex sha1. We have a more specific flag for
>> that: warn_on_object_refname_ambiguity.
>>
>> And I think it would be OK to enable that all the time for pack-objects,
>> which is plumbing that does typically expect object names. See prior art
>> in 25fba78d36 (cat-file: disable object/refname ambiguity check for
>> batch mode, 2013-07-12) and 4c30d50402 (rev-list: disable object/refname
>> ambiguity check with --stdin, 2014-03-12).
> I'd probably do it here:
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e50c6cd1ff..d370638a5d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3104,6 +3104,7 @@ static void get_object_list(int ac, const char **av)

Scoping the change into get_object_list does make sense. I was doing it 
a level higher, which is not worth it. I'll reproduce your change here.

>   	struct rev_info revs;
>   	char line[1000];
>   	int flags = 0;
> +	int save_warning;
>   
>   	repo_init_revisions(the_repository, &revs, NULL);
>   	save_commit_buffer = 0;
> @@ -3112,6 +3113,9 @@ static void get_object_list(int ac, const char **av)
>   	/* make sure shallows are read */
>   	is_repository_shallow(the_repository);
>   
> +	save_warning = warn_on_object_refname_ambiguity;
> +	warn_on_object_refname_ambiguity = 0;
> +
>   	while (fgets(line, sizeof(line), stdin) != NULL) {
>   		int len = strlen(line);
>   		if (len && line[len - 1] == '\n')
> @@ -3138,6 +3142,8 @@ static void get_object_list(int ac, const char **av)
>   			die(_("bad revision '%s'"), line);
>   	}
>   
> +	warn_on_object_refname_ambiguity = save_warning;
> +
>   	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
>   		return;
>   
>
> But I'll leave it to you to wrap that up in a patch, since you probably
> should re-check your timings (which it would be interesting to include
> in the commit message, if you have reproducible timings).

The timings change a lot depending on the disk cache and the remote 
refs, which is unfortunate, but I have measured a three-second improvement.

Thanks,
-Stolee
