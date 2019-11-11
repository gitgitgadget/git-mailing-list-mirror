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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5652D1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKQW5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 11:22:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKQW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 11:22:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so15271029wrf.9
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 08:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0xNk/3JKcRmSCwIpB/tjyWPurp8CSQCAgFYaDWufUpc=;
        b=oq9oE51f6Nz4PMKmqXxM+Djrv8BNDuY1jvFcnUmzNQD3ESJK7pYhsEWANSiKMXj3BX
         /KBpofKBbCDHYQ/xIOGUqNKTSOb375ZygK/wwez01Fx/6mSjgeNP0n1t0ui4Ujk8TsDw
         VMktzR0e792nU2pZed/9StxJ9vzlCqmgScCsdupM2BoALJWe98wq0eDLRJgD7SOCoQ6y
         UdYFDmt0Dtft8NdsBByIP0lKExzsfFRfFbDg6JjOqFwIS5JS+nTt8/pJwHWIYIqon+ZW
         dwyTjr6zzdotmqYhA1t/vUHj8WYZxex54+va4/KoVvei2aQrx/jjy+PYIv82x147Y7qN
         MMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0xNk/3JKcRmSCwIpB/tjyWPurp8CSQCAgFYaDWufUpc=;
        b=nie1Tv4tgMOUTPZlJD+Yt0BdDpLu4PJXM51QZl5414y85ooBjkgtPWEWxSTdeELL5n
         fLp0j1UEJFgDgH4uDVzD9z3rMETqtpzDjOTBZXfRzleKTRP68dnoFIMb5scqylQtdapG
         Gefo/jlQJOzvCqhN0Us7cr9G0Urdfj9Emx/wSSrqa0bSq5DZxj+zKPr3Sy7EDGOeTg0e
         rL8ylq1IbFxk94j4nekZvxDk/G/agTJxRR3wJnvXCe6+rbEo8NM5LE6/ExA3a3PdnbBB
         NNk2/AI5gDHMPuOjYX6SBQ9pH1MTVEOiCM0UL3/MPtbYtMILwtqt+LvxuDBQyTKKdaPM
         i8Hg==
X-Gm-Message-State: APjAAAUXRIzx9Fa7Jso2thB1oSc95OAGDXElxuvkLd3xdMm47mfEaaPM
        5wtH2Zh6Ng0Lm4TQl8fnI2I=
X-Google-Smtp-Source: APXvYqykDvK9hKU9JBz42IqLqLGWIelKY89oH2aVQ/E58HyQKHEVbXU2e0oqgWLu5yD9ewWGmmMJ/A==
X-Received: by 2002:a05:6000:103:: with SMTP id o3mr23374700wrx.80.1573489374932;
        Mon, 11 Nov 2019 08:22:54 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-25-36.as13285.net. [92.22.25.36])
        by smtp.gmail.com with ESMTPSA id q15sm17605090wmq.0.2019.11.11.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:22:54 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 9/9] sequencer: fallback to sane label in making rebase
 todo list
To:     Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573452046.git.congdanhqx@gmail.com>
 <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
 <20191111083940.GC17984@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6e38ad3e-8732-899a-293c-cddd5312fa88@gmail.com>
Date:   Mon, 11 Nov 2019 16:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111083940.GC17984@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Doan & Peff

On 11/11/2019 08:39, Jeff King wrote:
> On Mon, Nov 11, 2019 at 01:03:42PM +0700, Doan Tran Cong Danh wrote:
> 
>> In later stage of rebasing, we will make a ref in
>> refs/rewritten/<label>, this label is extracted from the subject of
>> current merge commit.
>>
>> If that subject has forbidden character for refname, git couldn't create
>> the rewritten ref. One such case is the merge commit subject has
>> a multibyte character encoded in ISO-2022-JP.
>>
>> Provide a sane fallback in order to help git-rebase works in such case
> 
> Good find. Not having worked much with this part of the sequencer code,
> I don't have a strong opinion on the fallback label. But it seems better
> than the current behavior would be.

There's been some discussion about sanitizing the subject recently 
[1,2]. It would be good to co-ordinate this effort with that one

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com
[2] 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1910251508100.46@tvgsbejvaqbjf.bet

> I suspect there may be other subtle problems, too, for filesystems that
> can't represent some part of the subject (e.g., I wonder if some of your
> ISO-2022-JP tests might already have trouble on HFS+, which excepts all
> paths to be UTF-8).
> 
>> @@ -4607,9 +4608,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>>   			if (isspace(*p1))
>>   				*(char *)p1 = '-';
>>   
>> +		hex_oid = oid_to_hex(&commit->object.oid);
>> +
>> +		if (check_refname_format(label.buf, REFNAME_ALLOW_ONELEVEL) < 0) {
>> +			strbuf_reset(&label);
>> +			strbuf_addf(&label, "label-%s", hex_oid);
>> +		}
>> +
>>   		strbuf_reset(&buf);
>> -		strbuf_addf(&buf, "%s -C %s",
>> -			    cmd_merge, oid_to_hex(&commit->object.oid));
>> +		strbuf_addf(&buf, "%s -C %s", cmd_merge, hex_oid);
> 
> A minor nit, but I think it's better here to just call oid_to_hex()
> twice, rather than assigning to the hex_oid variable. It's returning a
> pointer to a static buffer, so holding onto the pointers for too long is
> dangerous. What you have here is definitely OK, because nothing
> interesting happens in between, but seeing any assignment of the result
> of "oid_to_hex" makes auditing harder.
> 
> And it's not like it's that expensive, or that this is
> performance-critical code (and if it were, we'd do better to use
> oid_to_hex_r() directly into the strbuf anyway).
> 
> -Peff
> 
