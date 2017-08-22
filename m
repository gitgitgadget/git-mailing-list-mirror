Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0361F667
	for <e@80x24.org>; Tue, 22 Aug 2017 14:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933080AbdHVOuL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 10:50:11 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:37601 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbdHVOuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 10:50:09 -0400
Received: by mail-wr0-f179.google.com with SMTP id z91so125868098wrc.4
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hLmS9gtV9yLUykcx+zMoZ22sm9dKZnkgJLZ5ZTwb76s=;
        b=qc+y5knvN4sDvb5ceMQSEA/FFCfjA2xW6iIpyWuc83bQ8d0ifD8RZqVF0EX9loFcHg
         DBuO4JbuKBa0ljulP7OS94+fk6V10tfoPMq4HINoFLbtR4pDeKxTc3a5PO+rKcj+p5P+
         d9kCySiK8LUOJ+juPsmjwRf7ngg2xT813azzW/orCp9wErW8ckjRAIi/4srSye+m7HDy
         yI1wO4mLzs6ge2GupB+n+gZUndl6dq7uWtMkjLyEpCLGayJS50k6BIxr6KfoZtxtc5xr
         8z8RJI/orPJzb4TpMwBBBLbh8BsCNDUTUB84+LT+23iKlWiOW+FuxCfPid2DWGkZvqEF
         vSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hLmS9gtV9yLUykcx+zMoZ22sm9dKZnkgJLZ5ZTwb76s=;
        b=Md63rANKHaYBPEZi23zbVPoSnlbVxu81zHtVQV/haemGsfnejzAnIFkz2f4wEz0b76
         qjvrZH5e8IMCihyxLPv5o5SquUrqPF5V4AYGeTglDyma0/RSRQumjACu7c3+G2qvQx+f
         8D1m6vIExGQ9IAG/fwmLF20iiBFhNneT3QIUK2MHbI39k++1HHMVxAMEsEIajIibrjj+
         EnaViq19l14ac9kmsxp86U8P2diHumE1NvDn+h6MrzVIyYgBXLWeRDIa/ZJ0FhD/Y8GP
         nKHIRV9Ap26bvXJG9pf/+AT7MVa7MuuV0ESNN2+McxScrGrnVAAmlOY7GEMGXHF/sOtY
         b7og==
X-Gm-Message-State: AHYfb5j9jB2obttRlfXWgQpWbvvGuLJ9NuBJOpMbtIOe5kQAiRgwicVJ
        OtdMysVj0e12qQ7Djv4=
X-Received: by 10.28.127.210 with SMTP id a201mr259464wmd.91.1503413407733;
        Tue, 22 Aug 2017 07:50:07 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g26sm13816040wrb.21.2017.08.22.07.50.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 07:50:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pull: respect submodule update configuration
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170821182110.GA156514@google.com>
Date:   Tue, 22 Aug 2017 16:50:06 +0200
Cc:     Stefan Beller <sbeller@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D44F6340-9011-4D41-B103-4A61E7248806@gmail.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com> <20170818220431.22157-1-sbeller@google.com> <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com> <20170821162056.GB1618@book.hvoigt.net> <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com> <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com> <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com> <20170821182110.GA156514@google.com>
To:     Brandon Williams <bmwill@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Aug 2017, at 20:21, Brandon Williams <bmwill@google.com> wrote:
>=20
> On 08/21, Stefan Beller wrote:
>> On Mon, Aug 21, 2017 at 10:20 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>=20
>>>> On 21 Aug 2017, at 18:55, Stefan Beller <sbeller@google.com> wrote:
>>>>=20
>>>> On Mon, Aug 21, 2017 at 9:20 AM, Heiko Voigt <hvoigt@hvoigt.net> =
wrote:
>>>>=20
>>>>>> So I am a bit curious to learn which part of this change you =
dislike
>>>>>> and why.
>>>>>=20
>>>>> I am also curious. Isn't this the same strategy we are using in =
other
>>>>> places?
>>>>>=20
>>>>=20
>>>> I dislike it because the UX feels crude.  When reading the =
documentation,
>>>> it seems to me as if submodule.<name> can be one of the following
>>>>=20
>>>>   (none, checkout, rebase, merge, !<custom-command>)
>>>>=20
>>>> This is perfect for "submodule-update", whose primary goal is
>>>> to update submodules *somehow*. However other commands
>>>>=20
>>>>   git rebase --recurse
>>>>   git merge --recurse
>>>>   git checkout --recurse
>>>>=20
>>>> have a different primary mode of operation (note how their name
>>>> is one of the modes from the set above), so it may get confusing
>>>> for a user.
>>>>=20
>>>> 'none'  and '!<custom-command>' seem like they would be okay
>>>> for any of the commands above but then:
>>>>=20
>>>>   git config submodule.<name>.update "!..."
>>>>   git reset --hard --recurse
>>>>   git status
>>>>   # submodule is reported, because "!..." did not 'reset'.
>>>>=20
>>>> Anyway. That dislike is just a minor gut feeling about the UX/UI
>>>> being horrible. I wrote the patch to keep the conversation going,
>>>> and if it fixes Lars problem, let's take it for now.
>>>=20
>>> Well, I need just a way to disable certain Submodules completely.
>>> If you show me how "git config --local submodule.sub.active false"
>>> works then I don't need this patch.
>=20
> Yeah if you want to completely disable a submodule (as in not even =
check
> it out) then setting .active to false would do that.  But as stefan
> pointed out and IIRC 'submodule update --init' with no pathspec sets =
all
> submodules to be active.  Perhaps it should only init submodules who
> don't already have an explicit active flag set.

OK. I change my scripts to use ".active" and it seems to work nicely.

I noticed one oddity, though:

If I clone a repo using `git clone --recursive <url>` then the local
Git config of the repo gets the following entry:

[submodule]
	active =3D .

Is this intentional? Something in the git/git test harness seems to =
prevent
that. I was not able to write a test to replicate the issue.

Any idea?

Thanks,
Lars=
