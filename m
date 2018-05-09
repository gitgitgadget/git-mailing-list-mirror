Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3C31F42E
	for <e@80x24.org>; Wed,  9 May 2018 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbeEIRzN (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:55:13 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:43668 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeEIRzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:55:12 -0400
Received: by mail-yw0-f173.google.com with SMTP id r202-v6so10960551ywg.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EoUvbYW/i8iMmGX0MKSCLNIlkY8d/Px+B40nWiwbYnQ=;
        b=sHGj7KzQt1Zg0T+vDXeQ61/Y5iufiIwC1Nm4w3MgrTrZ32QxGmlrpxWCIao3HUV3JK
         2Uzjq1GB8KUGdFSvQYLlcDIwpv8rOmbYDTPZy9K4t7u6r+no2El/Zm8Onhcw+q2mGKEG
         CndAAn0zBaBA1FBplwONOSGTqSFL8Mt6ZI/nH7pppYiZPjzorFx/4QWGzG8zj/b6Vt9u
         IDtHB0ILq4nc2AV8tAch7lHZ4SgQsgg58QEPclF/3/ZrbPo1FRLYVDu/CWxLlm5DkwNM
         +DK1R8GTajF1tL3Q1k3pq0D1eVXlI9fNbBegHToG9suC+RgI67pv7NvwR9xVlofMq/H0
         7iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EoUvbYW/i8iMmGX0MKSCLNIlkY8d/Px+B40nWiwbYnQ=;
        b=loSDK0OrTlqZSuk3S4t4yfcNuciDdPKGh6+D47NScNue/34/YgG/vO7nvNIoL3C9dz
         RxXqkxtYMRvOlZio0j957krh+wBlY/zgsoiUdCf2FtiD5vWogRfnU2TNknEQKxiTq/K8
         OsPrTT/54eiCfFxoAuLvRMRVzI9MebjD/FfTIs12Oe37MudOriL/MfcjPeJRTJR4AZcc
         KRmfmmcGjThXFmIVfMfu2FrGIE5pMcnk0XULhY7/jsQysxX3vx0MI6O5eqHibyy1R7Wx
         /frsyLM6mgOK+33FEOj9W7vNlV15mvfbYUsT5SG2J+JXZHkC8yV/c4cbSvpsXxRrL8xD
         OZJQ==
X-Gm-Message-State: ALQs6tD8XUF2n7+a62+rbIc1VRQqFQAfA9Q5n6z9fuQAkbiJgWD0mnO6
        QzHi8u4Wibbk8y6l4oZBTkNcQXo2YoRHRQeSbIJYSw==
X-Google-Smtp-Source: AB8JxZqGMoQwEFhjMOPNBo/rnWGtolxD9iyIjSvUNNS9jsEr9ZbImIQZEYeROisDDt/eu87L28n5lz3BxPPW8M9IRsI=
X-Received: by 2002:a81:b205:: with SMTP id q5-v6mr5130265ywh.414.1525888511828;
 Wed, 09 May 2018 10:55:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 10:55:11 -0700 (PDT)
In-Reply-To: <20180509174830.GJ10348@aiede.svl.corp.google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
 <CAGZ79kZx=wHKc=2WLz-8pQWv1VhRq+pKVV9=Shq3gEMdkX-Q=A@mail.gmail.com> <20180509174830.GJ10348@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 10:55:11 -0700
Message-ID: <CAGZ79kYwdTriaoev5EYvoSVA+ZummdKm3rjY261KucptjhytUQ@mail.gmail.com>
Subject: Re: Implementing reftable in Git
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 10:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> * We *might* be able to use reftables in negotiation later
>>   ("client: Last I fetched, you said your latest transaction
>>   number was '5' with the hash over all refs to be <sha1>;
>>   server: ok, here are the refs and the pack, you're welcome").
>
> Do you mean that reftable's reflog layout makes this easier?
>
> It's not clear to me why this wouldn't work with the current
> reflogs.

Because of D/F conflicts we may not know all remote refs
(and their ref logs), such that "the hash over all refs" on the remote
is error prone to compute. Without transaction numbers it is also
cumbersome for the server to remember the state.
We could try it based on the current refs, but I'd think
it is not easy to do, whereas reftables bring some subtle
advantages that allow for such easier negotiation.

>
> [...]
>> On Wed, May 9, 2018 at 7:33 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>
>>> During the last Git Merge conference last March Stefan talked about
>>> reftable. In Alex Vandiver's notes [1] it is asked that people
>>> announce it on the list when they start working on it,
>>
>> Mostly because many parties want to see it implemnented
>> and were not sure when they could start implementing it.
>
> And to coordinate / help each other!

Yes. Usually open source contributions are so sparse, that
just doing it and then sending it to the mailing list does not
produce contention or conflict (double work), but this seemed
like a race condition waiting to happen. ;)

>> With that said, please implement it in a way that it can not just be used as
>> a refs backend, but can easily be re-used to write ref advertisements
>> onto the wire?
>
> Can you spell this out a little more for me?  At first glance it's not
> obvious to me how knowing about this potential use would affect the
> initial code.

Yeah me neither. I just want to make Christian aware of the potential
use cases, that come afterwards, so it can influence his design decisions
for the implementation.
