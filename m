Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE22200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 17:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbcL0Rza (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 12:55:30 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33122 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbcL0Rz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 12:55:28 -0500
Received: by mail-qt0-f169.google.com with SMTP id p16so329914452qta.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 09:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SE3iv7ebQvQIPUVQzNlDmAcUV4UlbaRo/qE8d3pNa7A=;
        b=VqFBFEtAJblOXH6Tkcf/ULYfWKMgFEhcnBWUijOabrZTFmPrDJ6ih7sFYUSvQbJJzb
         lCzCY0wwJWXAlrZ8k6C9CnQ7E+KGVDmAP0ddHtQB5voqG2oeVRg1xqr5dRpEzPUJVhK7
         gL+G95Nr8yPQYsg7hdv9uDn5Jy7KOOm2ORrBGhXz1X2xBBpm8vPBgcM3Iz0TVUNcZUoV
         vYfz4VIf2t9jMJ77wMfiljm1fPFKcE8Rp3Y0wnBHvY7VyYZlHLzmvaMO4UzjNVuY64ad
         1QYw7vD+TcMnovK4rgNGr7SCbvIJVBTphjELZ6MQB0J6QZvH3mqyRQLj6d8MOtwaNr6C
         f3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SE3iv7ebQvQIPUVQzNlDmAcUV4UlbaRo/qE8d3pNa7A=;
        b=EISq1MnVwHvQ6m13UuP8j/MxSMewC66rrFjXRDa167aWrhVpohuz1JdK7Pk/koCKyH
         8TdWp20qnoML91sHKj0mff31CQav3akZ1Vg79vjiXhcipjtAIWgv14o3AGO/G2QDSkXE
         ABU71W6Ghxj1XR9UilxG5in+uN0XTet3I8GsBbqsrBUP3RuNmlq92cWZIK76CRDvyLHT
         /GaN6PlQWMZaxmXR3ZJUInL5fL4pBR72jaXMBYZ2hCqmhkZO5KPSTXoiNSfyfHia9/k5
         AmahFF6vKP8lV6RlYX8BAKTiqm/yH1BtH3wqQUW9povxwWh5OqbToJMTNZ55PHymEinM
         IjJA==
X-Gm-Message-State: AIkVDXJZbnfoyfZmEq/OKQ1vT/DVsrdnXvDGOeC+RsIslTBIfVN/JJupeADZcD+wzRDlLah1daORG8xL7CTrf278
X-Received: by 10.200.49.235 with SMTP id i40mr33238733qte.170.1482861327752;
 Tue, 27 Dec 2016 09:55:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 27 Dec 2016 09:55:27 -0800 (PST)
In-Reply-To: <xmqqr34uchuq.fsf@gitster.mtv.corp.google.com>
References: <20161220232012.15997-1-sbeller@google.com> <20161220232012.15997-4-sbeller@google.com>
 <xmqqr34uchuq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Dec 2016 09:55:27 -0800
Message-ID: <CAGZ79kbpq3WPk-sSoVh8s0FUanctEjHH92LfpoBGYV2WhfEV-w@mail.gmail.com>
Subject: Re: [PATCHv5 3/4] submodule: rename and add flags to ok_to_remove_submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <David.Turner@twosigma.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 26, 2016 at 4:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> As only 0 is understood as false, rename the function to invert the
>> meaning, i.e. the return code of 0 signals the removal of the submodule
>> is fine, and other values can be used to return a more precise answer
>> what went wrong.
>
> Makes sense to rename it as that will catch all the callers that
> depend on the old semantics and name.
>
>> -     if (start_command(&cp))
>> -             die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
>> +     if (start_command(&cp)) {
>> +             if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
>> +                     die(_("could not start 'git status in submodule '%s'"),
>> +                             path);
>> +             ret = -1;
>> +             goto out;
>> +     }
>
> This new codepath that does not die will not leak anything, as
> a failed start_command() should release its argv[] and env[].
>
>>       len = strbuf_read(&buf, cp.out, 1024);
>>       if (len > 2)
>> -             ok_to_remove = 0;
>> +             ret = 1;
>
> Not a new problem but is it obvious why the comparison of "len" is
> against "2"?  This may deserve a one-liner comment.
>
> Otherwise looks good to me.

I took the check "len > 2" from the other occurrence in submodule.c.
When thinking about it (and inspecting the man page for
porcelain status), I think just checking != 0 is sufficient.

So in a reroll I'll change that to just

    if (len)
        ...

I'll look at the other occurrences and see if we can reuse code
as well.

Thanks,
Stefan
