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
	by dcvr.yhbt.net (Postfix) with ESMTP id 003421F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfHFQcM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:32:12 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33182 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbfHFQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:32:11 -0400
Received: by mail-wm1-f51.google.com with SMTP id p77so29859wme.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ylBvHJzPwUsgaqQRBrFvUEB/ODbgXqQgiH4PDe3+a0Y=;
        b=hGRNfgraVlu+mEW+70z+gM+WLAG1Sazov3NJDTkL9COPTX4FEmcHHLArRCbNLjm+2r
         W4acDpQ3oK8yjDjzB5q/u+eqx9XCVl848fu4NXdBU+cTJoy2rexceN4L68lTn06F2Qza
         Bc64G/KQ83ZQNeBlqtmdHv8Xj78Xc5K8d7DeP7372KKUN414+7/osVCULFcHtHHXcr1S
         wOEowmcqDMa1J3u8Wb2N/mXHUhQw3ermeuJzhmbUhKR7VCmzgiilMqepHQhYfNOv12i5
         H02FubZYAUsdHRxC5+/+q1pE5sbTG6CLEKPMpx9lfzOrRwbp4tQoyrNJ5frjKPz6rBaH
         NHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ylBvHJzPwUsgaqQRBrFvUEB/ODbgXqQgiH4PDe3+a0Y=;
        b=ZsM6nuvPU2EHyUQJY8w66JCEv7uUlwbsZtJIqy64IPbHJJYnZfvdw8N7ddC/npgBul
         GqWhCRPH2kDHCg5Ubm3COkLkaAMdnVdG0kHMRCT0ujrS7PX7pgULA7Ql7H7D3OHn3Tjx
         /jwrjn2CU6Xb61uv0WXW+VycyA7msKyTS8mUr7+T50Z8D+o5lYkyj/9/2I7VhqksWyj4
         TwiGNnOPzcOyiKB4XpW+qL0Cu1B6DJJda/1MDNGmG5FQbqfdSnO3vKVzoE0qo4kKTtGw
         zzyT0wH/UGHeoP3ge+41fJ+SnrUTnI6orOQiZg+Czgt9azXG4gHQJJrTLmcVggHjVgqi
         h+aA==
X-Gm-Message-State: APjAAAVTN6fYU/CrIJ/ZstQr7wrE1QxcBQVwGUXaZgby7nfx7hvlw19p
        hKk9C4jmLS2oJSyNuSu56h4=
X-Google-Smtp-Source: APXvYqwwT6ux1MSPlI6WvOiwqAl6zwSTUpYWHfHlq0dFQOr27QPlx+SeQQN2MxQXFkcJANKdfDND9A==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr5267010wmk.147.1565109129899;
        Tue, 06 Aug 2019 09:32:09 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-23-226.as13285.net. [92.22.23.226])
        by smtp.gmail.com with ESMTPSA id a8sm76992877wma.31.2019.08.06.09.32.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 09:32:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: amend warnings with no changes staged
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lukas Gross <lukasgross@u.northwestern.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
 <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
 <20190806021618.GC61803@google.com>
 <xmqqtvavko1h.fsf@gitster-ct.c.googlers.com>
 <20190806030026.GA8864@google.com>
 <xmqqpnljkm3d.fsf@gitster-ct.c.googlers.com>
 <xmqqh86vkl0j.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b12f58f6-663a-bd0f-5854-d7ff0b83848b@gmail.com>
Date:   Tue, 6 Aug 2019 17:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh86vkl0j.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08/2019 04:53, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>>>> Some non-judgemental descriptive output like
>>>>>
>>>>> 	$ git commit --amend --no-edit
>>>>> 	No changes.
>>>>> 	$
>>>>>
>>>>> would address this case, without bothering people who are doing it
>>>>> intentionally.  So I think there's room for a simple improvement here.
>>>>
>>>> I do that to refresh the committer timestamp.
>>>
>>> I do, too.  The proposal is, paraphrasing,
>>>
>>> 	$ git commit --amend --no-edit
>>> 	Ah, I see that you want me to refresh the committer timestamp.
>>> 	Done, as requested.
>>> 	$
>>
>> Ah, OK then.  I somehow misread "No changes." as an error message.
> 
> Well, on second thought, I think "fatal: no changes" that exits with
> non-zero, with "--force" as an escape hatch for those who want to
> refresh the committer timestamp, would probably be more in line with
> the expectation Lukas had when this thread was started, and I further
> suspect that it might be a bit more end-user friendly.

I agree that this would be the must user friendly way of doing it. I 
think refreshing the timestamp is probably a niche use of '--amend' (out 
of interest what the the motivation for doing that?) although it does 
seem to popular with the other contributors to this thread. We could 
always have a transition period with an opt-in config variable. I find 
the current behavior quite annoying when I've forgotten to stage 
anything as there is no indication the the commit's content is 
unchanged. I've been using a wrapper script that errors out if there are 
no new changes staged with --amend --no-edit and found it very helpful 
(as is a proper --reword option rather than having to give --amend --only)

Best Wishes

Phillip

> 
> It is a backward incompatible behaviour, but I suspect that if I
> were inventing "commit --amend" today, unlike 8588452c ("git-commit
> --amend: allow empty commit.", 2006-03-04), I probably would design
> it that way.  After all, failing and stopping is always a safer
> option than going ahead with or without a report.
> 
> I am not sure which one between "go ahead anyway but report" and
> "fail by default but allow forcing" I would prefer more.  At least
> not yet.  But I won't rule the latter out at this point.
> 
> Thanks.
> 
