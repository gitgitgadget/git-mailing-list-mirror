Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB25121847
	for <e@80x24.org>; Wed,  2 May 2018 13:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeEBNFL (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 09:05:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54414 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeEBNFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 09:05:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id f6so22675790wmc.4
        for <git@vger.kernel.org>; Wed, 02 May 2018 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PcZRi/UJ8Fz0kVN9e6UB31po6A7vWDq9WbXLvqLCt+Q=;
        b=n+W9KUulhLP9RFBL7Bq3FE3Kb8WxFzZ721DNXGSCmzemcbO2typ9wQODEBuD9AiXda
         zo93Jxc0TVvNP+c7GEyya12e4XCUWYPuHuNAGneIDJY5Lqu8eUjRTpTmVi4QdYxRNq6m
         DVkaNrZbXacRljbncYSx/zbuxFLjFnYQPPKqMvcK5Jbt8Fjmzfi3ZgKp1ASLA37CEFN0
         1vX7w00gABoGaUy5Czax4n24zpUqvvzL9MUy7aqzJjxDG3u2ZycbdJAjPxofDXo47kax
         VV+iD6bGkiL84YkEwLzP80t40c9Mt1sZPY5CB1YPsL2mrYcrs5VXcKp/YUpvu96ZMFUv
         UD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=PcZRi/UJ8Fz0kVN9e6UB31po6A7vWDq9WbXLvqLCt+Q=;
        b=TG8fV4JYVY5ojX2/okI0MbAYG9gA9oI64Vfy/XkYJiT/WuHQw+es09r4eL2kRjUlRV
         q9IEEQ2aTfDy9wNpO0bIf00AenSyJlILomnzerKZWAeOoU+ykIVJEIfv0ITY9lVktKSY
         r5g2v/SGUde8PrhJJ2bShKTKv5S4t9Y6toR38+m13Z/F91KHVW6XZz2dfXpGMssMWslp
         cdD/vgEuzeMuQLgXVQaQHsYa9qy3LKvSmbfSUkn73K+eS18e66mPwW0l7S62ckhSneVj
         HV2m5lO/LtUPianRQcCAxAOz7YaWtOW8K+Y+64SQTCfIwkXlShHGYNpwXzPh/MpWLb05
         qyhg==
X-Gm-Message-State: ALQs6tBMbJoypducSD8jBQ696AU5dlD0HvRaqwnP8rDqnjGAQTLk+T4f
        gVU+xYZy5uqrhVJ2rS7aO6p2q0Zj
X-Google-Smtp-Source: AB8JxZqOp+LMm2zjrp6QcQe7jNFq6iI1N6/Yamo1DooRAwWv++L4ADxUhjWKH6fCH7iL5NrHGNqe0A==
X-Received: by 10.28.228.130 with SMTP id b124mr13322470wmh.100.1525266308689;
        Wed, 02 May 2018 06:05:08 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egn45.neoplus.adsl.tpnet.pl. [83.21.77.45])
        by smtp.gmail.com with ESMTPSA id g105-v6sm20155560wrd.45.2018.05.02.06.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 06:05:06 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 08/10] commit: add short-circuit to paint_down_to_common()
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-9-dstolee@microsoft.com>
        <864ljsgwx1.fsf@gmail.com>
        <3e3ae7e4-9efd-3046-c0c2-7b3bf12d0d81@gmail.com>
Date:   Wed, 02 May 2018 15:05:02 +0200
In-Reply-To: <3e3ae7e4-9efd-3046-c0c2-7b3bf12d0d81@gmail.com> (Derrick
        Stolee's message of "Tue, 1 May 2018 07:47:01 -0400")
Message-ID: <86a7ti1a4h.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 4/30/2018 6:19 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
[...]
>>> @@ -831,6 +834,13 @@ static struct commit_list *paint_down_to_common(st=
ruct commit *one, int n, struc
>>>   		struct commit_list *parents;
>>>   		int flags;
>>>   +		if (commit->generation > last_gen)
>>> +			BUG("bad generation skip");
>>> +		last_gen =3D commit->generation;
>> Shouldn't we provide more information about where the problem is to the
>> user, to make it easier to debug the repository / commit-graph data?
>>
>> Good to have this sanity check here.
>
> This BUG() _should_ only be seen by developers who add callers which
> do not load commits from the commit-graph file. There is a chance that
> there are cases not covered by this patch and the added tests,
> though. Hopefully we catch them all by dogfooding the feature before
> turning it on by default.
>
> I can add the following to help debug these bad situations:
>
> +			BUG("bad generation skip %d > %d at %s",
> +			    commit->generation, last_gen,
> +			    oid_to_hex(&commit->object.oid));

On one hand, after thiking about this a bit, I agree that this BUG() is
more about catching the errors in Git code, rather than in repository.

On the other hand, the more detailed information could help determining
what the problems is (e.g. that "at <hex>" is at HEAD).

Hopefully we won't see which is which, as it would mean bugs in Git ;))

[...]
>>> @@ -946,7 +956,7 @@ static int remove_redundant(struct commit **array, =
int cnt)
>>>   			filled_index[filled] =3D j;
>>>   			work[filled++] =3D array[j];
>>>   		}
>>> -		common =3D paint_down_to_common(array[i], filled, work);
>>> +		common =3D paint_down_to_common(array[i], filled, work, 0);
>>
>> Here we are interested not only if "one"/array[i] is reachable from
>> "twos"/work, but also if "twos" is reachable from "one".  Simple cutoff
>> only works in one way, though I wonder if we couldn't use cutoff being
>> minimum generation number of "one" and "twos" together.
>>
>> But that may be left for a separate commit (after checking that the
>> above is correct).
>>
>> Not as simple and obvious as paint_down_to_common() used in
>> in_merge_bases_any(), so it is all right.
>
> Thanks for reporting this. Since we are only concerned about
> reachability in this method, it is a good candidate to use
> min_generation. It is also subtle enough that we should leave it as a
> separate commit.

Thanks for checking this, and for the followup.

>                  Also, we can measure performance improvements
> separately, as I will mention in my commit message (but I'll copy it
> here):
>
> =C2=A0=C2=A0=C2=A0 For a copy of the Linux repository, we measured the fo=
llowing
> =C2=A0=C2=A0=C2=A0 performance improvements:
>
> =C2=A0=C2=A0=C2=A0 git merge-base v3.3 v4.5
>
> =C2=A0=C2=A0=C2=A0 Before: 234 ms
> =C2=A0=C2=A0=C2=A0=C2=A0 After: 208 ms
> =C2=A0=C2=A0=C2=A0=C2=A0 Rel %: -11%
>
> =C2=A0=C2=A0=C2=A0 git merge-base v4.3 v4.5
>
> =C2=A0=C2=A0=C2=A0 Before: 102 ms
> =C2=A0=C2=A0=C2=A0=C2=A0 After:=C2=A0 83 ms
> =C2=A0=C2=A0=C2=A0=C2=A0 Rel %: -19%
>
> =C2=A0=C2=A0=C2=A0 The experiments above were chosen to demonstrate that =
we are
> =C2=A0=C2=A0=C2=A0 improving the filtering of the merge-base set. In the =
first
> =C2=A0=C2=A0=C2=A0 example, more time is spent walking the history to fin=
d the
> =C2=A0=C2=A0=C2=A0 set of merge bases before the remove_redundant() call.=
 The
> =C2=A0=C2=A0=C2=A0 starting commits are closer together in the second exa=
mple,
> =C2=A0=C2=A0=C2=A0 therefore more time is spent in remove_redundant(). Th=
e relative
> =C2=A0=C2=A0=C2=A0 change in performance differs as expected.

Nice.

I was not expecting as much performance improvements as we got for
--contains tests because remove_redundant() is a final step in longer
process, dominated by man calculations.  Still, nothing to sneeze about.

Best regards,
--=20
Jakub Nar=C4=99bski

