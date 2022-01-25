Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E69C4332F
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 11:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380697AbiAYLIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 06:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiAYLGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 06:06:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C0C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 03:06:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i82so580844wma.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V08i0DYE5pSEiQcygJQZJcESCFU9/aQlinFW2AVW7J8=;
        b=XrybncVuUG6iIU4Lsr3J143HY5Pw+yKtTioyC8ksS7KNrjXWmV+4FOnPgtz12hNpB+
         URhTBFibJ29b87Q7I5VtSYqr7FfvHOcFlHwyBPHHRthN75mA3wqMtXQcq29lR+LZlCYl
         2+o8m9CXLlMlTOeQFI7dp8rYcc8XztnteVETNJXDrFRqYVb8v3iU1/Lf4KfmHQ8KoY0/
         VoarUaSUPt2z1Noh5W/fTMl/iJOtibXB0+Nlcpiperr0LBpFOR8Qjxxv+M/GeFs52owv
         GUvKpYQYOEoIABOK6pVCSQuehGgH9D6D8Dm6Ap7EHlOcv15SwRcHhzOZ2Ja8ZedTU6m9
         Nb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V08i0DYE5pSEiQcygJQZJcESCFU9/aQlinFW2AVW7J8=;
        b=z2p5xY4CuQH/7padWwV0grUGLzkWrCE4XmRWM0qjFk4r7BO1E727AKROcD0vBDCL7W
         vlDD4oIsV0LDbpBQa0QTlJCtxx8D3PQ6YVrgKRUdBid0zfNOHPvpCDl3JJNWNhKEhM/y
         TU9vn8OiKQnyZe+cUhUW9gvKRfhy6GB/v+PyFg3Zpi+ltxMzafVhuAnkRuhfyH/qi5/a
         QSM/we3zMwx5ifdAVQradB90kA1rOtCeuVwbGuRrPT2BPYW2l2fXrNd80qg/eizzxfF/
         XO6pFYasE0sME+6ffFsxYdTobqTmSgdc6UBbS2xzENyKiOhJLUc42GaLwqLDoe6QQwHT
         63/Q==
X-Gm-Message-State: AOAM533uda6DFuyV7xoeXcmtvIz1MWdGH3EEAJTEy+9X7S5dc2JYRa3P
        LfaMdYGmEJD7SzRROaZ3+tA=
X-Google-Smtp-Source: ABdhPJywRHxoTvOGCULmo6C0IabISLOzFu60DVcEpH9xQrjQBOK0y/NcnGeaziz9mk0RrcWWimQk0Q==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr2465780wmo.82.1643108780999;
        Tue, 25 Jan 2022 03:06:20 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id t4sm16536836wro.71.2022.01.25.03.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 03:06:20 -0800 (PST)
Message-ID: <36966d92-1460-699a-007d-da2a7da6c088@gmail.com>
Date:   Tue, 25 Jan 2022 11:06:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 07/14] create_autostash(): remove unneeded parameter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
 <341fe183c18ee28b459ba26f2c8c369d9367c328.1638975482.git.gitgitgadget@gmail.com>
 <xmqqpmq5r3j9.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpmq5r3j9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2021 19:17, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The default_reflog parameter of create_autostash() is passed to
>> reset_head(). However as creating a stash does not involve updating
>> any refs the parameter is not used by reset_head(). Removing the
>> parameter from create_autostash() simplifies the callers.
> 
> It does make the callers of create_autostash() easier to reason
> about, but ...
> 
>> @@ -4132,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
>>   		write_file(path, "%s", oid_to_hex(&oid));
>>   		printf(_("Created autostash: %s\n"), buf.buf);
>>   		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
>> -			       default_reflog_action) < 0)
>> +			       "") < 0)
> 
> ... makes the reader wonder what the empty string is doing here.
> The fact that reset_head() does not care about the last parameter
> when not given oid or switch_to_branch parameters feels like too
> much implementation detail to expect the callers to know about.
> 
> Unless it is documented in reset.[ch] before the beginning of the
> "int reset_head(...)" definition/declaration, that is.

I've moved this patch down the series so it looks like
-			       default_reflog_action) < 0)
+			       NULL) < 0)

which should be clearer

Best Wishes

Phillip

> 
>>   			die(_("could not reset --hard"));
>>   
>>   		if (discard_index(r->index) < 0 ||
>> diff --git a/sequencer.h b/sequencer.h
>> index 05a7d2ba6b3..da64473636b 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -197,8 +197,7 @@ void commit_post_rewrite(struct repository *r,
>>   			 const struct commit *current_head,
>>   			 const struct object_id *new_head);
>>   
>> -void create_autostash(struct repository *r, const char *path,
>> -		      const char *default_reflog_action);
>> +void create_autostash(struct repository *r, const char *path);
>>   int save_autostash(const char *path);
>>   int apply_autostash(const char *path);
>>   int apply_autostash_oid(const char *stash_oid);

