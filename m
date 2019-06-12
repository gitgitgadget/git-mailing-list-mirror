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
	by dcvr.yhbt.net (Postfix) with ESMTP id 082531F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFLS5q (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:57:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFLS5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:57:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so7608568wmg.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EfMjnbQmcVS4+LnjWFXarrKDmgY1ojIb+zVMwccCipg=;
        b=sC+7XADFRza0jT3tn1m5dAZTGlaQK8LujxmvDlOWy7/F/rQJzB2zX9n/E7qd0ofjc7
         kpcEbqtvgZtv11u4IQvSCiYgsRUAgOr+SAeuMbNzBpc9RmmT4lW/Vgj64HqZn/NmotTs
         z1IrG2dLrgPinrTu7IWjoIrpTag/4irYT2FJ9eO2wyZ/cTAo2fhn82QombNR3diXBpKB
         G8RUBs8eqSTZEQa3zpCQmH++VlWUZkhJ7EDZa8oGKgRpetX8qknSkHITSzLr0fgXFuwp
         xOVHA6+j+2LT5/5Q7mqYHDQZJwE0jhk43L9sZ++aY13478h6yvTiK8CMEoItCVnP3tzV
         OsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EfMjnbQmcVS4+LnjWFXarrKDmgY1ojIb+zVMwccCipg=;
        b=Nvvwc3AtpF8G5kXMykm6Z/kVQsRJDDbEwy7tiqzXLFtTUxnk7HG1ycdmw+aqroZI22
         gv7y4S4jamE+0m18ivyNZnggliZ7mHnuXFkNikckvKFgkJiNKmG8MQv2jXMh+RjRFJl9
         hglzyY2mkjUJu1em2qADe1X3m9buodSssm2uhJk0KfHuc1itNsQQGHku9VTAq8qyENT7
         H52bkfWclRciD7xmwu7NQ8ZShEb+OVz7fHDcCd+4F4Gb6eItoHZvFeL8qT5Dnq2+XfXr
         Je98s/fPXVaaNqo7WMswA5tB7YBRpIsxbtMMk2yAqnJzN855wA9v5VoharoKLIGp+7OP
         EQMw==
X-Gm-Message-State: APjAAAUniIlopgESu1rMOcXNyKYbZ1GZw622n0poUMfdz6FcuUXcg+BZ
        migNaND5yNu6kY100QT9+60=
X-Google-Smtp-Source: APXvYqy36QA/uWb83E46r3vKiVZM/RioiK+0OWMC1RHECCeBTE2OXyibDXiHhPfvmSZN5qKStvmekg==
X-Received: by 2002:a1c:c583:: with SMTP id v125mr440339wmf.158.1560365863588;
        Wed, 12 Jun 2019 11:57:43 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id f10sm776406wrg.24.2019.06.12.11.57.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:57:43 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 2/3] cherry-pick/revert: add --skip option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org,
        newren@gmail.com, t.gummerer@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-3-rohit.ashiwal265@gmail.com>
 <6d3c1c1e-6140-dd8c-c37f-8c625b04ddc9@gmail.com>
 <xmqqsgseisgu.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5226cbc4-3dad-2fc8-b0b7-767119e40c64@gmail.com>
Date:   Wed, 12 Jun 2019 19:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgseisgu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06/2019 19:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Thanks for the new version, this is looking pretty good now, just a
>> few comments below
> 
> I agree that this step is looking pretty good now.
> 
> I didn't check closely, but when 1/3 undergoes necessary polishing,
> it may have repercussions on this step, though (I did see that the
> change in 3/3 would have overlaps with what was touched by 1/3 that
> needs to be done differently).
> 
> Thanks for guiding Rohit's series forward.
> 
>> This is only slightly different from reset_for_rollback() if you
>> decide to keep a separate code path for skip vs abort then I'd be
>> tempted to combine the two like this.
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index ecf4be7e15..b187b4222e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2740,11 +2740,13 @@ static int reset_merge(void) {
>>   static int reset_for_rollback(const struct object_id *oid)
>>   {
>>          const char *argv[4];    /* reset --merge <arg> + NULL */
>> +       size_t i = 0;
> 
> That size_t is, eh, "unusual".  For an index into a small local
> array of known size, just sticking to bog-standard-and-boring 'int'
> would make it less distracting for future readers of the code.

Yes size_t is overkill here, it tends to be my default "array index" 
type but there's no need for it here.

> Or even better, perhaps use argv-array, so that you do not have to
> worry about sizing the local array sufficiently large in the first
> place.

That would be a much better way of doing it, I was so focussed on the 
existing code I didn't think of that.

Best Wishes

Phillip

> 
>> +       argv[i++] = "reset";
>> +       argv[i++] = "--merge";
>> +       if (oid)
>> +               argv[i++] = oid_to_hex(oid);
>> +       argv[i] = NULL;
>>          return run_command_v_opt(argv, RUN_GIT_CMD);
>>   }
> 
