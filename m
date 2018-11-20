Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B4E1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKUAAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 19:00:04 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:45119 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKUAAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 19:00:04 -0500
Received: by mail-qk1-f182.google.com with SMTP id d135so2733666qkc.12
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 05:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kVswhMtUn7LM8bk82FWLKLIe/yHkO/2nq7tvm6IZJcw=;
        b=m6Rai78n9driP8ZxvJvJgd2wZwFqKnYsg0O7X1KFkmD9VfItY175fwOHMBHmrtExYx
         pvXtn3yh7OJKJosp6EatapA3ZUWvz2f8I7jDvYq3pM2Z20A7whzlQ+9bj49XK8Y+8nqr
         vaWsHbP6byg0PikFkJwoczZ4vMJVcNalIWKp8G57ay8TV3dmoOM4FYH4X8P3DrQT/9ub
         qlJLpnG+3r3bFtFjVWP4eiJz6khUbIXpclkiGurZ/fcrERHRx0xA31ZSPHvNRTbG+qA8
         dwsEi6v1KOYqTnWPYRNnH7MrCttSGpB7VOf46Wo+ku3MTdn0eTu96DrOyKVbVq2gK5Xa
         h8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kVswhMtUn7LM8bk82FWLKLIe/yHkO/2nq7tvm6IZJcw=;
        b=aV6L4WTFq2wbnACw+1pmdElL27/Gch5mw5gmoONA6sv0dS5cwyN+059UxgljWOYhTi
         OFKvsdxXjXOJQHdBOxeMGvZ7VtBRm5voDO5HYA1fHs2yZE+nF33b3uCXLxb0zdUvKPJf
         wBipfsocCGWl1x83h9ApKTlK3mv4jscTTzoTbtsdKu3dgURaFg4yEXNyRx6iGetXjAkw
         rG2YRVJBfKedAenIcr9lG7jxOuphgW98rPfcYtuOXEtrNorbanDzE/+EHdY3Ulgyn9EU
         mu2QFzyRsAP568WSMgJNZ7Qn+C9BFVHnwP8vOIEq000+ospuGk4NbE5q4zOxkG4z4Dds
         R2Lw==
X-Gm-Message-State: AA+aEWbIcdxHG5Bsmd1GB0Noum2Gwa4ZMSKe1dJLBYpaqWqLxEgwLlO5
        Mcloz1n3Dx52b0tm4Aq0wuU=
X-Google-Smtp-Source: AFSGD/VvjnPIcAT0ZeIcaIREHKjSAq+qR3POmghRILK4v/ye9qTyRNztL2EIeS1A1y40XO2lcg5odg==
X-Received: by 2002:a37:5cc6:: with SMTP id q189mr1771989qkb.235.1542720653519;
        Tue, 20 Nov 2018 05:30:53 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a68sm24810072qkj.63.2018.11.20.05.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:30:52 -0800 (PST)
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com> <20181120061544.GF144753@google.com>
 <87sgzwyu94.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
Date:   Tue, 20 Nov 2018 08:30:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sgzwyu94.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2018 4:26 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 20 2018, Jonathan Nieder wrote:
> 
> Just commenting here on the end-state of this since it's easier than
> each patch at a time:
> 
> First, do we still need to be doing %.4s instead of just %s? It would be
> easier for translators / to understand what's going on if it were just
> %s. I.e. "this is the extension name" v.s. "this is the first 4 bytes of
> whatever it is...".
> 
>>   			return error("index uses %.4s extension, which we do not understand",
>>   				     ext);
> 
> Missing _(). Not the fault of this series, but something to fix while
> we're at it.
> 
> Also not the fault of this series, the "is this upper case" test is
> unportable, but this is probably the tip of the iceberg for git not
> working on EBCDIC systems.
> 
> This message should say something like "Index uses the mandatory %s
> extension" to clarify and distinguish it from the below. We don't
> understand the upper-case one either, but the important distinction is
> that one is mandatory, and the other can be dropped. The two messages
> should make this clear.
> 
> Also, having advice() for that case is even more valuable since we have
> a hard error at this point. So something like:
> 
>      "This is likely due to the index having been written by a future
>      version of Git. All-lowercase index extensions are mandatory, as
>      opposed to optional all-uppercase ones which we'll drop with a
>      warning if we see them".
> 

I agree that we should have different messages for mandatory and 
optional extensions.  I don't think we should try and educate the end 
user on the implementation detail that git makes lower cases mandatory 
and upper case optional (ie drop the 'All-lowercase..." part).  They 
will never see the lower vs upper case difference and can't do anything 
about it anyway.

>>   		trace_printf("ignoring %.4s extension\n", ext);
>> +		if (advice_unknown_index_extension) {
>> +			warning(_("ignoring optional %.4s index extension"), ext);
> 
> Should start with upper-case. Good that it says "optional".
> 
>> +			advise(_("This is likely due to the file having been written by a newer\n"
>> +				 "version of Git than is reading it. You can upgrade Git to\n"
>> +				 "take advantage of performance improvements from the updated\n"
>> +				 "file format.\n"
> 
> Let's not promise performance improvements with this extension in a
> future version. We have no idea what the extension is, yeah right now
> it's going to be true for the extension that prompted this patch series,
> but may not be in the future. So just something like this for the last
> sentence:
> 
>      You can try upgrading Git to use this new index format.

Agree - not all are guaranteed to be perf related.

> 
>> +				 "\n"
>> +				 "Run \"%s\"\n"
>> +				 "to suppress this message."),
>> +			       "git config advice.unknownIndexExtension false");
> 
> Somewhat of an aside, but if I grep:
> 
>      git grep -C10 'git config advice\..*false' -- '*.[ch]'
> 
> There's a few existing examples of this, but the majority of advice()
> messages don't say in the message how you can turn these off. Do we
> think this a message users would especially like to turn off? I have the
> opposite impression, it's a one-off in most cases, although not in the
> case where an editor has an embedded git.
> 
> I think it would make sense to add this sort of thing to the advice()
> API, i.e.:
> 
>      advice_with_config_hint(_("<message>"), "unknownIndexExtension");
> 
> Which would then know how to consistently print this advice about how to
> turn off the warning.
> 

I like this.  I personally never knew you could turn of the "spent xxx 
seconds finding untracked files" advice until I worked on this patch 
series. This would help make that feature more discoverable.
