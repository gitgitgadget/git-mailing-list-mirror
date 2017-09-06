Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A56F1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbdIFVgC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 17:36:02 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33970 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbdIFVgB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 17:36:01 -0400
Received: by mail-yw0-f177.google.com with SMTP id r85so10372179ywg.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ktWihnyK+m5JEmkq1ULzs/GRuvHh8RcWDcg8WMeM1VM=;
        b=tX3jk+U6npEsEyOUegxksoyBwldThGaY5ZmR359QZaaaQ6CNvvG3jT6lLThJLcQc9w
         6cuOuvovRdPlC/2TZLr54o7gRAi8GX5/VQTzH6GuP8hes6GJz/I+3TAc50P+tlCL3+O+
         3whwYVUHjp7n6MwMTD0Sy1NxmwS0z0C85f3H3JO4wtkGa4jidEAlfT1MeH5u/zO2K/Sq
         jglqPIrBbEoUJ5udjU16l7ticFiWPrUgrym8XOUR+4vMPJYtV7qD6ZvKvV1ZGj2UGmwd
         5qT/8cB0friXd/CK6FAyRoDWQCTTpK1NaoYg7xoHGGeT0gwrRK7kXTqC73bz55NWICVE
         TxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ktWihnyK+m5JEmkq1ULzs/GRuvHh8RcWDcg8WMeM1VM=;
        b=Vzc/hfJnXRQG4lJtldE+d6jcTZBRiUd+Y24BLz4q+tFHP1n5eILNv7RpVK6zuYxDPK
         rIqgYP82EQvfoLsNVqmNWShA6sR4/0E61Dbj2U15WbTnzlNdkILN/Z9LuGLxInrNlztC
         jCu1b3AMeApgeLlaqyqdlyOfkj0dPTUflmn96OuymIaVb6FDSaqK/7UwzBkja0tkJuQO
         IGI6SoRuNcFv1eXEqPlb2i9TXc9g/eOf4ZwGc4z9R0YJX7mb9LtNdVU0iavjb5LQepBL
         Rp+KmLtkcR5m8ffry6DZX8iIsupGBEaK9at+qsoPmRNTmAPaoBol5RZeJ1Ct1/qHxvdT
         O7Lw==
X-Gm-Message-State: AHPjjUgr8gY7r21bsEqXJiPLGT5I5zCnuUrN7A+Ti/5lT7poB99VVRUa
        MsedI0CXhCqBothgBQXrWgFeBPc/Z0CfMEY=
X-Google-Smtp-Source: ADKCNb6A5NIVNWKZExk593hxuZOHdoXeZGyYNDrihndaGVZjyib1FMdsGUx7gkmT1xVBFVLBG+L2R04xPixds6+y3S8=
X-Received: by 10.37.160.66 with SMTP id x60mr458203ybh.305.1504733760592;
 Wed, 06 Sep 2017 14:36:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 14:36:00 -0700 (PDT)
In-Reply-To: <xmqqzia88qkj.fsf@gitster.mtv.corp.google.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com> <20170905230845.17108-1-sbeller@google.com>
 <xmqq8thsa901.fsf@gitster.mtv.corp.google.com> <xmqqzia88qkj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 14:36:00 -0700
Message-ID: <CAGZ79kaHHXdFMeEMfidWj7=FurR3L8VMysLrCLG3OyMtZPCgDQ@mail.gmail.com>
Subject: Re: [PATCH] parse-options: warn developers on negated options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 8:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>   This patch disallows all no- options, but we could be more open and a=
llow
>>>   --no-options that have the NO_NEG bit set.
>>
>> "--no-foo" that does not take "--foo" is perhaps OK so should not
>> trigger an error.
>>
>> A ("--no-foo", "--foo") pair is better spelled as ("--foo",
>> "--no-foo") pair whose default is "--foo", but making it an error is
>> probably a bit too much.
>>
>> Compared to that, ("--no-foo", "--no-no-foo") pair feels nonsense.
>
> Ahh, I was an idiot (call it vacation-induced-brain-disfunction).  I
> forgot about 0f1930c5 ("parse-options: allow positivation of options
> starting, with no-", 2012-02-25), which may have already made your
> new use of "--no-verify" in builtin/merge.c and existing one in
> commit.c OK long time ago.  A quick check to see how your version of
>
>         git merge --verify
>         git merge --no-verify
>
> behaves with respect to the commit-msg hook is veriy much
> appreciated, as my tree is in no shape to apply and try a patch
> while trying to absorb the patches sent to the list the past week.
>
> Thanks, and sorry for a possible false alarm.
>
>> Having said that, because the existing parse_options_check() is all
>> about catching the programming mistake (the end user cannot fix an
>> error from it by tweaking the command line option s/he gives to the
>> program), I do not think a conditional compilation like you added
>> mixes well.  Either make the whole thing, not just your new test,
>> conditional to -DDEVELOPER (which would make it possible for you to
>> build and ship a binary with broken options[] array to the end-users
>> that does not die in this function), which is undesirable, or add a
>> new test that catches a definite error unconditionally.
>
> This part still is valid.  If Ren=C3=A9's work 2 years ago is sufficient
> to address "--no-foo" thing, then there is nothing we need to add to
> this test, but if we later need to add new sanity check, we should
> add it without -DDEVELOPER, or we should make the whole thing inside
> it.

As far as the code is concerned it is only inside the -DDEVELOPER ?
The intent of this patch is to have a developers aid to remind them
that too many negations might be a sign of trouble.

Thanks,
Stefan

>
> Thanks.
