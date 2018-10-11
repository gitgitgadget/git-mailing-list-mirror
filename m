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
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F0B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 10:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeJKRf0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:35:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJKRf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:35:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id g15-v6so8984892wru.9
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9WYy1oHOv9QnSqKZhgDi2fuEDVuPUhRTq0i6UJxQZh8=;
        b=OiO1E+KBfKWHylIUvrHEGl6sin+Hjp3S4l4gs92ZtXlmYMuZuXSocvHmlMiwXDCnjH
         GEhFAOFWJa0SRRGW94nMtx6zbi+XFdCA66A3so8jywvwV1QD7U+xqolHnSRUEBZcDu1d
         KREVMhFYjPZyKUFDCf+967FsvglD5Rm8f5PF3mLXfqrp+YSsvIUd7zBiLqW7HgYXLOqK
         4b2UcOnUR1JnUbxhLmdWqW3eKuXMFUnHdS1S/X67uNidEYC10PvePE8uLQ5d0jLz+96W
         jT+UCWNAm9zHuG6j2KyLgn/dLCwu//OZ2rU0MJQ2go0dYVz861aj3cR7Z9uLj43scYz8
         0tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9WYy1oHOv9QnSqKZhgDi2fuEDVuPUhRTq0i6UJxQZh8=;
        b=h2RSu5ZttXtdWqclu/F+sAlvXvv86r70HapuGQUh+9jZmhhLg9G6ZycyGu8zZhi8+R
         lFScOynXZZJqXOv4Jfl/3rIOQE0JaymYtxSRTzJXkHmmGWSZswmGPKkghyov+PaSTEf9
         30W9YlKovEbuP7b+PU16MUoutP/OqjjNXYdNsQ8peLqC1aq0kwB33HXZMMXvQwa1tvSW
         dA82+Qsh/toqFD0DT28IghG46U+MBM3G8Otr6e2XqoUfylvw4UA5u1I5syKDmz7l846K
         dZnSOvDj2VRXsdURd4Tbw2x1nEqRmMKDDUQuEpOmNQZv9NUMD+Eg7v4Mbv03IR73CW3G
         1gpA==
X-Gm-Message-State: ABuFfoiWvNtyTFp2IdvQXkIuAX0UzqhcaW9W2dZeQPPCpHXRtUO5RCO9
        U4anc+qmMJpdjmwPke/mxHc=
X-Google-Smtp-Source: ACcGV63LonqOoYINpdkUNRo5n/tpoc1Nid4H++82vGE3PTPAAoVIVFKz9JreLYTevmn33UMKjsZJAA==
X-Received: by 2002:adf:d1ce:: with SMTP id m14-v6mr959678wri.138.1539252529387;
        Thu, 11 Oct 2018 03:08:49 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b128-v6sm14396029wmh.22.2018.10.11.03.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 03:08:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert & cherry-pick: run git gc --auto
References: <20181010193557.19052-1-avarab@gmail.com> <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net>
Date:   Thu, 11 Oct 2018 12:08:47 +0200
Message-ID: <87ftxceqxc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 11 2018, Phillip Wood wrote:

> Hi Ævar
>
> On 10/10/2018 20:35, Ævar Arnfjörð Bjarmason wrote:
>> Expand on the work started in 095c741edd ("commit: run git gc --auto
>> just before the post-commit hook", 2018-02-28) to run "gc --auto" in
>> more commands where new objects can be created.
>>
>> The notably missing commands are now "rebase" and "stash". Both are
>> being rewritten in C, so any use of "gc --auto" there can wait for
>> that.
>
> If cherry-pick, revert or 'rebase -i' edit the commit message then they
> fork 'git commit' so gc --auto will be run there anyway.

Yeah it seems I totally screwed up the testing for this patch, first it
doesn't even compile because I'm not including run-command.h, I *did*
fix that, but while wrangling a few things didn't commit that *sigh*.

And yeah, there's some invocations where we now run gc --auto twice,
i.e. if you do revert, but not revert --no-edit, and not on cherry-pick,
but on cherry-pick --edit.

So yeah, this really needs to be re-thought.

> I wonder if it would be better to call 'gc --auto' from sequencer.c at
> the end of a string of successful picks, that would cover cherry-pick,
> 'rebase -iu' and revert. With 'rebase -i' it might be nice to avoid
> calling 'gc --auto' until the very end, rather than every time we stop
> for an edit but that is probably more trouble than it is worth.

That seems a lot better indeed. I.e. running it from the sequencer. I do
wonder if there should be some smarts about running it in the middle of
a sequence, i.e. think of a case where we're rebasing 10k commits, which
is a gc need similar to what happens in the middle of "git svn
clone". So maybe something where we gc --auto in the sequencer for every
Nth commit, and at the end.

>
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> After reading the "Users are encouraged to run this task..." paragraph
>> in the git-gc manpage I was wondering if due to gc --auto all over the
>> place now (including recently in git-commit with a patch of mine) if
>> we shouldn't change that advice.
>>
>> I'm meaning to send some doc changes to git-gc.txt, but in the
>> meantime let's address this low-hanging fruit of running gc --auto
>> when we revert or cherry-pick commits, which can like git-commit
>> create a significant amount of loose objects.
>>
>>  builtin/revert.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 9a66720cfc..1b20902910 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -209,6 +209,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>>  	int res;
>> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
>>
>>  	if (isatty(0))
>>  		opts.edit = 1;
>> @@ -217,6 +218,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>>  	res = run_sequencer(argc, argv, &opts);
>>  	if (res < 0)
>>  		die(_("revert failed"));
>> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>>  	return res;
>>  }
>>
>> @@ -224,11 +226,13 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>>  	int res;
>> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
>>
>>  	opts.action = REPLAY_PICK;
>>  	sequencer_init_config(&opts);
>>  	res = run_sequencer(argc, argv, &opts);
>>  	if (res < 0)
>>  		die(_("cherry-pick failed"));
>> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>>  	return res;
>>  }
>>
