Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E08B1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 12:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIFRHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 13:07:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50613 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIFRHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 13:07:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so11274809wmc.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=El3/eTlBnVbN4ypZgClG6n1OjBXl9gQRU/FR+++k8kg=;
        b=fKz8poL4upWqzx25SVc4FZcRrkr4FTge8z/p8Z3j6sCkanTbJ8SC6i2afNLop8lVXm
         yzMHHVgbVWTaMiqdLPqAQ36e6qNYccjqMKgrfNJUUAWY4QkKWuD0/f+ozvpfQsXnL+IN
         JRvW3Q3ND17WmG4Gp66nHRLpF5j02EjizB86dVqCf7+S8Zg4zRdsuiXpW8VcP2Ss7MEP
         fVH9f+hzho1GlIlT6xOymGPCGum3M/+zAX+YiASiVhvMGYiChhfFZSJZ0vgfGF9xtlXG
         q8w4jmet/NNujRr1aChYymezoRItzP4XVwtwiAvqxkWALRnPxPW8AS5JooBvnvUXUdkx
         Kakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=El3/eTlBnVbN4ypZgClG6n1OjBXl9gQRU/FR+++k8kg=;
        b=IAuUhZOzY9FE4TvFFttKTWnZoUjSkd6MqGb+EXH519sCQaCEdNijETRS0qP8ywN8dT
         KiMfWalHdLp8sMqdZoww4bWw1j60hvb/E2UMDmyE7NqHRpP+tqmMx0D9FKe+dEANeC7c
         hZ1MIIQoSss73Q1f1l7DhaCtzvOCiu2FWGz/O/sRzrYIkiPQxoyeyz9fTnLCAxy27vGl
         Zc4WagagtQuMULSGPSyL3/oiyxHY/lI4cTX3bURSwLtY4WtA8cPFBCw5rFv6IBWA1D3Y
         wq7r2LRI4N0SVJ7YQUut6wEFyR0j0EmhGjC+2pVn6M6nqWU7QY6ZQ+8znosfur1Mvk/P
         ImXg==
X-Gm-Message-State: APzg51BczcG3QrdsQ34HtvKtBYFnG56A3a549qaDZCw8BQKF3F8mIdYE
        RP/pYGdfZsZYQw8UoIWeV4E=
X-Google-Smtp-Source: ANB0VdYrh1GelRreyF1hYYhP2Nynkoh4pwYmktYTG0xfNa5AUrxReM1yRr4M0X63noKCngK84py4MA==
X-Received: by 2002:a1c:ac04:: with SMTP id v4-v6mr2153572wme.51.1536237106703;
        Thu, 06 Sep 2018 05:31:46 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id o15-v6sm4171855wru.23.2018.09.06.05.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 05:31:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <87lgc77wc7.fsf@evledraar.gmail.com> <CAGZ79kae4k=uLx-oX5emxas4KrqObzQhzgir0coOSBzzpO8APw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79kae4k=uLx-oX5emxas4KrqObzQhzgir0coOSBzzpO8APw@mail.gmail.com>
Date:   Thu, 06 Sep 2018 14:31:44 +0200
Message-ID: <87tvn2remn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 25 2018, Stefan Beller wrote:

> On Fri, May 25, 2018 at 5:28 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Thu, May 17 2018, Junio C Hamano wrote:
>>
>>> * sb/submodule-move-nested (2018-03-29) 6 commits
>>>   (merged to 'next' on 2018-04-25 at 86b177433a)
>>>  + submodule: fixup nested submodules after moving the submodule
>>>  + submodule-config: remove submodule_from_cache
>>>  + submodule-config: add repository argument to submodule_from_{name, path}
>>>  + submodule-config: allow submodule_free to handle arbitrary repositories
>>>  + grep: remove "repo" arg from non-supporting funcs
>>>  + submodule.h: drop declaration of connect_work_tree_and_git_dir
>>>
>>>  Moving a submodule that itself has submodule in it with "git mv"
>>>  forgot to make necessary adjustment to the nested sub-submodules;
>>>  now the codepath learned to recurse into the submodules.
>>
>> I didn't spot this earlier because I don't test this a lot, but I've
>> bisected the following breakage down to da62f786d2 ("submodule: fixup
>> nested submodules after moving the submodule", 2018-03-28) (and manually
>> confirmed by reverting). On Linux both Debian & CentOS I get tests 3 and
>> 4 failing with:
>>
>>      GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t7411-submodule-config.sh
>>
>> -v -x output follows:
>>
>> expecting success:
>>         mkdir submodule &&
>>         (cd submodule &&
>>                 git init &&
>>                 echo a >a &&
>>                 git add . &&
>>                 git commit -ma
>>         ) &&
>>         mkdir super &&
>>         (cd super &&
>>                 git init &&
>>                 git submodule add ../submodule &&
>>                 git submodule add ../submodule a &&
>>                 git commit -m "add as submodule and as a" &&
>>                 git mv a b &&
>>                 git commit -m "move a to b"
>>         )
>
> when you add a test_pause here and dump the
> state of the setup, then it can be observed that when the fsmonitor is active
> the last commit is different; without fsmonitor the moved gitlink and the change
> to the .gitmodules file is part of the commit, i.e.
>
> $ git -C super show
>         commit d3d90b70a01bd17d026f75a803c8b65f5903a7c0 (HEAD -> master)
>         Author: A U Thor <author@example.com>
>         Date:   Fri May 25 19:21:58 2018 +0000
>
>             move a to b
>
>         diff --git a/.gitmodules b/.gitmodules
>         index 3f4d474..6149210 100644
>         --- a/.gitmodules
>         +++ b/.gitmodules
>         @@ -2,5 +2,5 @@
>           path = submodule
>           url = ../submodule
>          [submodule "a"]
>         - path = a
>         + path = b
>           url = ../submodule
>         diff --git a/a b/b
>         similarity index 100%
>         rename from a
>         rename to b
> When running with the fsmonitor:
>
> $ git -C super show
>         commit 57022a92acf46f303498c045440ec099cbc35a2d (HEAD -> master)
>         Author: A U Thor <author@example.com>
>         Date:   Fri May 25 19:22:52 2018 +0000
>
>             move a to b
>
>         diff --git a/a b/b
>         similarity index 100%
>         rename from a
>         rename to b
> $ git -C super diff
>         diff --git a/.gitmodules b/.gitmodules
>         index 3f4d474..6149210 100644
>         --- a/.gitmodules
>         +++ b/.gitmodules
>         @@ -2,5 +2,5 @@
>           path = submodule
>           url = ../submodule
>          [submodule "a"]
>         - path = a
>         + path = b
>           url = ../submodule
>
> This hints at a problem with git commit;
>
> I tried adding test_tick, to unconfuse the fsmonitor, but that doesn't help,
> digging further, the problem is in the git mv command, which fails to
> add the change in
> .gitmodules to the index.
>
> Adding the verbose flag to stage_updated_gitmodules() that is called by
> git-mv very late in the game, such that
>
> void stage_updated_gitmodules(struct index_state *istate)
> {
>     trace_printf("staging .gitmodules files");
>     if (add_file_to_index(istate, GITMODULES_FILE, ADD_CACHE_VERBOSE))
>         die(_("staging updated .gitmodules failed"));
> }
>
> We would get a message if the .gitmodules file is staged correctly, as
> add_file_to_index() that calls add_to_index that would print
>
>     if (verbose && !was_same)
>         printf("add '%s'\n", path);
>
> I could not see that message, so I suspect, that there is something
> racy.
>
> Will debug further.

I spotted this again after testing the split index (see
https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/) and
was testing the fsmonitor test mode as well.

So gentle *poke*: Did you get anywhere with debugging this? It's still
failing on "master" now.
