Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56CE20A26
	for <e@80x24.org>; Mon, 25 Sep 2017 22:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934914AbdIYWmT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:42:19 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:46003 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934254AbdIYWmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:42:18 -0400
Received: by mail-qk0-f179.google.com with SMTP id r141so8349380qke.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IvGDpHIc6ZFfPJs1I6AeTh8bouI0bSEDeFRJ8L8UuGY=;
        b=ftjtZrAShZxr1oEchVTYVxEcw1mVjnfe0970NlRrAKEfVlhJ4WF4o3SXvmHPi4C0KU
         fq4mp8F/pJivLsw5DLA3F4K9YRzF0grng6Z5hjasOEbow5c/xdnxh7UT4fE+52Z5lmEW
         956ckIwWZpon2ScB5jvp+R/UnB8wuoivj5TUz5c2vJmuE0hzKJV1jnQPyZqedKGg+FTj
         hIDAvfYp8q/tnDMoEzyVhjVicu8VkFt/rE3TzdIoLj4UnWudeyh0ypC7c65FfZWQD+i4
         L9iSrud0B20LSmL1/AhkBuN+FkROwzFS7LjjHd/W84XR8obNt5ehwNenhv50iXfhrEj+
         rb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IvGDpHIc6ZFfPJs1I6AeTh8bouI0bSEDeFRJ8L8UuGY=;
        b=Nl6rikeUsz3PC+YEmAfgWfyoY9pkJTFT9EnCwbZvE66RMyJCAtIhqwS9kRu4C9RPtm
         8/pM5kHZba/SzdUdcucjO9Kegb17OE3ZRadikFKadFt/ikXmHdSdSVEZBMbuUtltvc0S
         UXG/aXOBpPh3v76KZHI5KC72MnFpuT1XspT53t4JOGBVrU7nDOZ5SacKtgs2tdcSSfSN
         gR/BrTXwP83CbZN4vor3vEmFF8IewMJafkYyI5U05g00j9Oh5z025LPcHw2V+N5xbUK6
         /ilfewTy4bAWzBRuMJtBayCxLwbir74pYcDav+KdgPljharIGRk507CPLPBFOq5rGaBS
         qeAg==
X-Gm-Message-State: AHPjjUhbWtpAawuUrCKt+5M8XOt1dgQNWaf+a/H+vcrDuDaTRiMY6QDD
        g+rZG7uLXizX735GCf1H+SsPYcoXjxtowtR2/duKyQ==
X-Google-Smtp-Source: AOwi7QAZB78IN5qmi8kOL2yiZmPgYJnlh7GjxoKtmBBe6BeApC0iEgsLfLI5yWZFZkA9FV/ZUWgvW4SLA4Vniq1aF6U=
X-Received: by 10.55.127.7 with SMTP id a7mr12941474qkd.45.1506379337915; Mon,
 25 Sep 2017 15:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 15:42:15 -0700 (PDT)
In-Reply-To: <20170925222229.GG27425@aiede.mtv.corp.google.com>
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com> <20170925191011.29863-1-sbeller@google.com>
 <20170925191726.GE35385@google.com> <CAGZ79kZZJe=EYh7wecAWneVKrWoBLrPoWuMWmC219vzWVzP6mA@mail.gmail.com>
 <20170925222229.GG27425@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 15:42:15 -0700
Message-ID: <CAGZ79kY4tAfYERj1V2AL+piqWe6nw0qA+AHqm5w6ch9WiL86pw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: consolidate submodule.<name>.update
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 3:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>> On Mon, Sep 25, 2017 at 12:17 PM, Brandon Williams <bmwill@google.com> wrote:
>>> On 09/25, Stefan Beller wrote:
>
>>>> Have one place to explain the effects of setting submodule.<name>.update
>>>> instead of two.
>>>>
>>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>>> ---
>>>>>> I disagree.  Actually, I think the git-config(1) blurb could just
>>>>>> point here, and that the text here ought to be clear about what
>>>>>> commands it affects and how an end user would use it.
>>>>>
>>>>> I tend to agree with the consolidation.
>>>>
>>>> Something like this?
>>>
>>> I like the consolidation, its easier to keep up to date when its only in
>>> one place.
>>
>> After thinking about it further, I'd like to withdraw this patch
>> for now.
>>
>> The reason is that this would also forward point to
>> git-submodule.txt, such that we'd still have 2 places
>> in which it is explained. The current situation with explaining
>> it in 3 places is not too bad as each place hints at their specific
>> circumstance:
>> git-submodule.txt explains the values to set itself.
>> gitmodules.txt explains what the possible fields in that file are,
>>   and regarding this field it points out it is ignored in the init call.
>> config.txt: actually describe the effects of the setting.
>>
>> I think we can keep it as-is for now.
>
> Sorry, I got lost.  Which state is as-is?

By as-is I refer to origin/pu.

> As a user, how do I find out what submodule.*.update is going to do
> and which commands will respect it?

The user would discover it via 'man git-config' I would assume, which
covers any config variable? It also directs to git-submodule which is
more detailed, but the text there is suitable for the casual reader.
(pu has origin/sb/doc-config-submodule-update)

> Maybe we should work on first wordsmithing the doc and then figuring
> out where it goes?  The current state of the doc with (?) three
> different texts,

such that each different text highlights each locations purpose.

> all wrong,

Care to spell out this bold claim?

Thanks,
Stefan
