Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4720C1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfBVJDy (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:03:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40602 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBVJDx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:03:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15so1194846wmi.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+uez40vx1Nea3WgtjlS8pvtNUSKnfMCkK2kOs3YbcqE=;
        b=RNzVBy1hGTH5k+dmZtA6+Vs3SQkdGwJoe6sLboFZJfqao/91siXTJTaFBw++WLWJMx
         dHPwKmgb96wbI0+lSgI3dJtNMMYstcDI06u1w6y+dImzqShZZzW+UAucRUBd+mrf57yh
         2D6W9AnO7mh25IxQHzry0fXHzNhCdG39pF/dEe0RKkz0/4tNzcxttpdMPfphr5epRUe5
         Ra3tYJ2bcW2BeuH1ON5fxkTRfL9xUHE7lr4nBiFbxmtBsRHBP0FajWxPOZA0Q/aRc5Bv
         GZoRSjLJ7guenq8tz6emMBhJh0ImUyGPbWIBhweVWCV8SZCbEwleJPGB9jJHJ2cWFAmk
         p6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+uez40vx1Nea3WgtjlS8pvtNUSKnfMCkK2kOs3YbcqE=;
        b=BeGrRSsUf7X4ySlqFMHJ0kRs/UKsfjyoAxskM4cjrXhak/lnndSmoVNj5Wgj/yttZc
         rwIwVRomT61Zw3tfzvJ1/McUACSDO+7Tke1/F3qcq8WmiISC2Z1OllyhMU4E2QpU4nvN
         ZrML3qCXUpPs4a6biOSAP8ThYzYeI0pWq8a9CtDqwa5mhkDeCkspmOx08NUv3R2iv1zK
         mAsQp7KOXGftcX/cbAq40h3K23QKXW6GqyGIPzcP7IyOw/j+An8USI24VmWgFQUG8gyZ
         +4Qyj0JWB5o78L8Gi/hjHIFynczLG9FjshlP8dLcpt1OdZ8geeX7AF7DRzgMCNZyFQLn
         4q+w==
X-Gm-Message-State: AHQUAuaUmg05+CDYGChfOeftK5yt6QXsJajlAOJcBHiVVeMZO7lXhv0r
        IdD7nfXxzmIJb71yDogYWQrrU/X2
X-Google-Smtp-Source: AHgI3Ia5VXC97hBnAbGJmIT4BgO9wRkax5QB1xFsUCuPrEQ/sKnTGENWKhM7mDdQ7Uls5DscoHbqsg==
X-Received: by 2002:a1c:be09:: with SMTP id o9mr1708492wmf.3.1550826231927;
        Fri, 22 Feb 2019 01:03:51 -0800 (PST)
Received: from [192.168.1.3] ([31.223.156.163])
        by smtp.gmail.com with ESMTPSA id h9sm1425259wrv.11.2019.02.22.01.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 01:03:51 -0800 (PST)
Subject: Re: [PATCH v5 01/10] diff: export diffstat interface
To:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Daniel Ferreira <bnmvco@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
 <pull.103.v5.git.gitgitgadget@gmail.com>
 <d839f0c082ece5298647f8dfbfd0566d59c58172.1550662887.git.gitgitgadget@gmail.com>
 <xmqq4l8xuiy9.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <0f6b3dc7-eccf-3352-22a8-97ef052a6ada@gmail.com>
Date:   Fri, 22 Feb 2019 10:03:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq4l8xuiy9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

Thank you for suggestions and for taking time to look at
this patch series.

On 21-Feb-19 6:53 PM, Junio C Hamano wrote:
> "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> @@ -6001,12 +5985,7 @@ void diff_flush(struct diff_options *options)
>>   	    dirstat_by_line) {
>>   		struct diffstat_t diffstat;
>>   
>> -		memset(&diffstat, 0, sizeof(struct diffstat_t));
>> -		for (i = 0; i < q->nr; i++) {
>> -			struct diff_filepair *p = q->queue[i];
>> -			if (check_pair_status(p))
>> -				diff_flush_stat(p, options, &diffstat);
>> -		}
>> +		compute_diffstat(options, &diffstat);
>>   		if (output_format & DIFF_FORMAT_NUMSTAT)
>>   			show_numstat(&diffstat, options);
>>   		if (output_format & DIFF_FORMAT_DIFFSTAT)
> In the post-context of this hunk there are series of "if we are
> showing this kind of diffstat, pass &diffstat to a helper that shows
> it" calls, and this piece of code itself is guarded by "if we are
> showing any of these kinds of diffstat, enter this block".  So a
> helper function that computes necessary data in &diffstat upfront
> does make sense and makes the code readable quite a lot.
>
> But...
>
>
>> +void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat)
>> +{
>> +	int i;
>> +	struct diff_queue_struct *q = &diff_queued_diff;
> ... as a reusable helper, it would make a saner API if you did not
> to hardcode the dependency to the singleton diff_queued_diff
> (i.e. instead, pass a pointer to struct diff_queue_struct as a
> parameter---the caller has it as 'q' at the callsite).
>
> Other than that, makes sense to me; thanks.
>
> Here is a meta question, which is mostly meant to those who use
> gitgitgadget@.  The person who wanted to send this copy of the patch
> this time (i.e. Slavica, not Daniel) is not shown anywhere on the
> header of the e-mail, so the response to the message will not go to
> Slavica at all, even though it probably is visible by monitoring
> where gitgitgadget@ delivers (i.e. the PR comments).
>
> Is that desirable as a reviewee?  I manually added Slavica's address
> taken from the S-o-b: line to this response just in case, but if it
> is not desirable, I'll stop doing so.


Since gitgitgadget puts reviewer's e-mails in PR comments and send
e-mails (to me) as well, you don't need to add manually my address.

But thanks for thinking about this and doing it just in case
I don't get e-mails.


>
> Thanks.
>
