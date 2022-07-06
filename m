Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9DC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 17:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiGFRpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiGFRov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 13:44:51 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2362C113
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 10:44:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id i5-20020a170902c94500b0016a644a6008so8728977pla.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A1NGksgHfP7ibCvxLFXtnxMhqCwJVmXYlQlmrYNZhvc=;
        b=TpFN61IUn6j+0mSa2+VN2Czd9HLcQ1eXMrKBSwohO1zjdJQ+U6zr4NiHcqfnVYAK87
         pID+CJfpnQPQkWZ4zY+Y27kpVbO8sweijvdpdXuIhJlJoOLWXKo6/4MfKyzvE8Bs/ao/
         pYtYAcdd53MVi20F5swnDKdqE1Qdgc5Vct0zvhGoi7AppXQHklLBsv3poFT6rwiuVE5l
         OIKXQHC+4Mf4cScb8oUsMH1btBICXIjKR4YNttju4fhtJ3iMixP3kuY6DdEXdAm2VDAq
         dieX1A2B7JDUhwfYzUdn8ztUytCdE+XTREJBFv0RRiUoJYntHyuP1p+fmhR1bk19Nb+t
         ED4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A1NGksgHfP7ibCvxLFXtnxMhqCwJVmXYlQlmrYNZhvc=;
        b=jJLMZZe0D/MdJQha/A/j+OFhFfLNPRPEetKjby7asXDB/PB3qVkroOlxvIes2DnYXz
         Ak/s1tNFPeqI0LGqO3NDh7zF/r7fh+hA5jkIhrz7kHjX2FQ5TAHkoRioCVoc/KneLL0q
         3+khWZKcf+HZJK37vE6/PcZA+VOgdeFLJO/PZJGBYd/5kkpqFGmXZ7TtKqr4cCJ7FuoT
         v+K3Fp2FmDy+GXp5Jm3epXN4VSMq8jN2DQcobr1g9Ofj2J6FsY0FWlNDe+LJtJVq5t7D
         78CKrJmALTd0I0dLU/0XndtmHl0h3/hRA02ok+2xAXKriXDwQTtN2M4YAyLOBfRSvrcb
         qdMA==
X-Gm-Message-State: AJIora9jTEtbRbC2pM9huuveYuIuuRFmJl63/cLhQmKJyJnxHo0ingBz
        pRLIT78y9H0u0l7SaKnnDqEVU46P9jC49A==
X-Google-Smtp-Source: AGRyM1s57HTiMT72tTRpijYKq/+lC9g+FuAtbDat5rKkVCQxYmj8x5SzzWZV1PWlsXYKOBNUxRnmvlQ/p2l1zA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP
 id c18-20020a056a000ad200b004f12734a3d9mr48049034pfl.61.1657129460611; Wed,
 06 Jul 2022 10:44:20 -0700 (PDT)
Date:   Wed, 06 Jul 2022 10:44:11 -0700
In-Reply-To: <Yr4ka485NzadFTto@nand.local>
Message-Id: <kl6llet6rv9w.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com> <ee9619f6ec0608f399fc924cfe9254df5e7bc431.1656612839.git.gitgitgadget@gmail.com>
 <Yr4ka485NzadFTto@nand.local>
Subject: Re: [PATCH v6 1/5] Documentation/git-config.txt: add SCOPES section
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi! Thanks so much for lending your attention to this version again, I
really appreciate this wording feedback in particular, because the
Review Club reviewers and I agonized a lot over the wording and couldn't
come up with great alternatives to what I wrote in the patch, and your
suggestions are super helpful.

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 30, 2022 at 06:13:55PM +0000, Glen Choo via GitGitGadget wrote:
>> From: Glen Choo <chooglen@google.com>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 9376e39aef2..f93d437b898 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -297,8 +297,8 @@ The default is to use a pager.
>>  FILES
>>  -----
>>
>> -If not set explicitly with `--file`, there are four files where
>> -'git config' will search for configuration options:
>> +By default, 'git config' will read configuration options from multiple
>> +files:
>>
>>  $(prefix)/etc/gitconfig::
>>  	System-wide configuration file.
>> @@ -322,27 +322,63 @@ $GIT_DIR/config.worktree::
>>  	This is optional and is only searched when
>>  	`extensions.worktreeConfig` is present in $GIT_DIR/config.
>>
>> -If no further options are given, all reading options will read all of these
>> -files that are available. If the global or the system-wide configuration
>> -file are not available they will be ignored. If the repository configuration
>> -file is not available or readable, 'git config' will exit with a non-zero
>> -error code. However, in neither case will an error message be issued.
>> +You may also provide additional configuration parameters when running any
>> +git command by using the `-c` option. See linkgit:git[1] for details.
>> +
>> +Options will be read from all of these files that are available. If the
>> +global or the system-wide configuration file are not available they will be
>> +ignored. If the repository configuration file is not available or readable,
>> +'git config' will exit with a non-zero error code. However, in neither case
>> +will an error message be issued.
>
> Nit: the last sentence is a little awkwardly worded. Perhaps just:
> "Note that neither case produces an error message".

Good suggestion. I didn't change this sentence, but I agree that it's
worth improving.

>> -All writing options will per default write to the repository specific
>> +By default, options are only written to the repository specific
>>  configuration file. Note that this also affects options like `--replace-all`
>
> Should we mention that this is the same as the "local" scope below?

Also a good idea.

>>  and `--unset`. *'git config' will only ever change one file at a time*.
>>
>> -You can override these rules using the `--global`, `--system`,
>> -`--local`, `--worktree`, and `--file` command-line options; see
>> -<<OPTIONS>> above.
>> +You can change the way options are read/written by specifying the path to a
>> +file (`--file`), or by specifying a configuration scope (`--system`,
>> +`--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
>
> I think this paragraph could be slightly more descriptive about what
> `--file` does while still linking out to <<OPTIONS>> above for more
> detailed information. In the pre-image, we say:
>
>     If not set explicitly with `--file`, there are four files will `git
>     config will search`.
>
> So I wonder if something more descriptive in this section might be:
>
>     You can limit which configuration sources are read to or written
>     from by specifying the path of a file with the `--file` option, or
>     by specifying a scope with `--system`, `--global`, `--local`, or
>     `--worktree`. For more, see <<OPTIONS>> above.
>
> I don't think that's so different form what you wrote, but I think it's
> a little clearer particularly what `--file` does (instead of "change the
> way options are read/written" it "limit[s] which configuration sources
> are read to or written from").

I think this is _much_ clearer, actually. Thanks!

>> +
>> +SCOPES
>> +------
>> +
>> +Each configuration source falls within a configuration scope. The scopes
>> +are:
>> +
>> +system::
>> +	$(prefix)/etc/gitconfig
>> +
>> +global::
>> +	$XDG_CONFIG_HOME/git/config
>> ++
>> +~/.gitconfig
>> +
>> +local::
>> +	$GIT_DIR/config
>> +
>> +worktree::
>> +	$GIT_DIR/config.worktree
>> +
>> +command::
>> +	environment variables
>> ++
>> +the `-c` option
>> +
>> +With the exception of 'command', each scope corresponds to a command line
>> +option - `--system`, `--global`, `--local`, `--worktree`.
>
> I think a colon after "option" is more appropriate than a single "-"
> dash character, but this is definitely a trivial matter that I have no
> strong opinion on.
>
> One thing that this reminds me of (which I don't think is worth taking
> up here, but perhaps in a future series, or as #leftoverbits) would be
> promoting these scopes behind a single option. Back in the day, you
> could ask for values out of `git config` by specifying their type with
> `--int`, `--bool`, or similar. In e3e042b185 (Merge branch
> 'tb/config-type', 2018-05-08), we changed to
> `--type=<int|bool|color|etc>`, which unified things and made it clearer
> which options were grouped together by a single concept.
>
> I think a similar change would make sense here, that is to replace
> `--system`, `--global` (and so on) with `--scope=system`,
> `--scope=global`, etc.
>
> But that's not material to this series, and just something to think
> about for later on if you end up thinking it's a good idea.

This sounds like a great idea, actually. I agree that `--scope` is
probably a lot easier to reason about than having N scope flags, and
that this probably belongs in a future series.

>> +
>> +When reading options, specifying a scope will only read options from the
>> +files within that scope. When writing options, specifying a scope will write
>> +to the files within that scope (instead of the repository specific
>> +configuration file). See <<OPTIONS>> above for a complete description.
>>
>> +Most configuration options are respected regardless of the scope it is
>> +defined in, but some options are only respected in certain scopes. See the
>> +option's documentation for the full details.
>
> I assume "the option's" is referring to whichever configuration variable
> we're talking about. So it may be clearer to say "See the *respective*
> option's documentation for more information" or similar.

Good idea. Thanks again!

>
> Thanks,
> Taylor
