Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A38220248
	for <e@80x24.org>; Tue,  9 Apr 2019 07:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDIHnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 03:43:37 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:55609 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 03:43:37 -0400
Received: by mail-wm1-f52.google.com with SMTP id o25so2184560wmf.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nWJiNwJI7lopQqaDdHhLilojCPqQz5SBmPtjIyju0BI=;
        b=Ky6sk6Cx6S+KeIQlXi7ZotRSo141FvSr4tkzl1b4Qm/0P/4FmSNJk/Ej3Ruo+p8V8i
         Lcb380upcEK4yVjQ7ZUmFykZ7deO/s5RS5Q9SHYeqqTFtPRLpu8QlsOwG3bmj9mlg6Kv
         cbjY6FM4zblMlFUrHZA0F9XNQywOmVv0Vr4JLneNue0UqWJFR/G3ypr4vZyPy2a+BdNS
         ig9x7tltfyxMxD18SIuugbC3DI/zRcTtEptPPLbmZ9Sh6/mX0aqlIZh36n8PTjKji0Xc
         oPhhcgTyfx0wL6l8BtiEE6P6JMMwfokPj3yxWAnAA+xSU9XSzQpQ1GRVSiu3EYqOE7Ho
         4MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=nWJiNwJI7lopQqaDdHhLilojCPqQz5SBmPtjIyju0BI=;
        b=YFdsFWiA+8UArst56ppPBHPwDMlPScvDV2V/DpIP0AE6YZfdX379QOsoh1/IzLcM9b
         +oqDm9DWe2oNIap5EokdahXzJ9bbmp1cgAu9738nKP0MYPeBnhhiZceo69T422Jv90Gl
         2hSRxw/yV0dRvqTuCJV9iVrhaJomDZ2cUng2kxqXjycBVfhqkGj2F4quuQm+Qwg58YHW
         osTaNOQIPMkRNc2fnguEchdlX3Qjl9nZA6L7GdizVe0euElUnEQ4TIM4xpOclCZ1/cTJ
         fhavPtT6xyPIdJUCrWjRrkbg5nOPSv9oDuCq2JYr/Cli5QAntQvPrxKi9tMdKEsrxs26
         SNKA==
X-Gm-Message-State: APjAAAUZl79dnYBmSoWJjAdIj8VQEUseSAUK48ZrNag0G30LSabVBbXP
        1liqnZJDi8QezsS0CL2GKS3Yi+LoCD8=
X-Google-Smtp-Source: APXvYqzCMzCk3dakdtTCcnUkIGqkx4akzs+X+d1ReK3XryyBD/nFOCPmFU3PxkI64SI9ZR/XKzze4w==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr20206198wma.25.1554795815180;
        Tue, 09 Apr 2019 00:43:35 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egs74.neoplus.adsl.tpnet.pl. [83.21.82.74])
        by smtp.gmail.com with ESMTPSA id y17sm37479648wrh.60.2019.04.09.00.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 00:43:34 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: "commit --author=..." does not work if global email and name is not set
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
        <8636mvng8n.fsf@gmail.com>
        <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
        <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com>
        <86y34kn4c8.fsf@gmail.com>
        <CAA01CspJAPnBFsQsXP4Dpweeg6oBVj==TB0aEnK5o1Et5zS30Q@mail.gmail.com>
Date:   Tue, 09 Apr 2019 09:43:29 +0200
In-Reply-To: <CAA01CspJAPnBFsQsXP4Dpweeg6oBVj==TB0aEnK5o1Et5zS30Q@mail.gmail.com>
        (Piotr Krukowiecki's message of "Mon, 8 Apr 2019 13:55:25 +0200")
Message-ID: <86tvf7mxni.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> On Mon, Apr 8, 2019 at 1:06 PM Jakub Narebski <jnareb@gmail.com> wrote:
>> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>>>> On Sat, Apr 6, 2019 at 8:25 PM Jakub Narebski <jnareb@gmail.com> wrote:
>>>>>
>>>>> Better though is to focus on what you want, namely to prevent acciden=
tal
>>>>> commits without specified author, instead of how you want to achieve =
it,
>>>>> i.e. using --author to provide both author and committer identity (the
>>>>> XY problem).  On that machine with "automatic test account" set up
>>>>> pre-commit or commit-msg hook that fails if the GIT_AUTHOR_IDENT
>>>>> environment variable is not the "automatic test account".
>>>
>>> I'm not sure if I follow you. I want to be able to make both "real
>>> user" and "automatic test account user" commits from that machine. I
>>> want to make sure that:
>>> - automatic commits (scripts) use their own account
>>> - real person making commit uses their own account
>>>
>>> IMO the only way this can be achieved is by not having any default
>>> account setup, so that both the scripts and the real users need to
>>> specify it "by hand".
>>
>> If a real person making commits uses their own account (just on that
>> machine), he or she can set up `user.name` and `user.email` settings in
>> the per-user Git configuration file
>
> There is one common "test" (Windows) account which is used both by
> automatic test scripts and by real people who log into that machine,
> so this is not possible.

Well, if it is not possible to make it multi-account machine, where
everybody logins with their own account...

>> If however one is doing commits from the "automatic test user" account,
>> then the `pre-commit` or `commit-msg` hook configured for that specific
>> repository for that automatic account would be run, which can detect
>> that the commit was not done with
>>
>>   $ git commit --author=3D"My Name <me@my.email.com>"
>>
>> The additional advantage is that you can examine committer data to
>> detect such cases of committing out of automatic account.
>
> Do you mean following?
>
> 1. set default user (user.name, user.email) to "automatic test user"
> on that machine
> 2. set commit hook to prevent commits with "automatic test user" AUTHOR
> 3. scripts will set AUTHOR (--author) to for example "script X" or
> "automatic script user" - different than the default user

Or, if possible, you could simply check if `git commit` was called from
a login shell / interactive shell, rather than from a script.  This
would make all scripts work automatically without any changes.

Alternatively scripts could set some special environment variable that
would be checked by the commit hook.

> 4. real users will set AUTHOR to their own identity (--author=3Dme)
>
> I suppose that would work. Looks much more complicated than simply
> setting "--author" (or "--user") though...

however, it is one-time configuration.

Yet another solution would be for each user to create his or her own
clone of repository (sharing repository data using `git clone
--reference`), and set up their identities in per-repository
configuration.  Though that requires them to use the correct
directory...

Best,
--
Jakub Nar=C4=99bski
