Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE9B201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 00:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbdBVAbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 19:31:43 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33138 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753628AbdBVAbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 19:31:41 -0500
Received: by mail-lf0-f42.google.com with SMTP id l12so34951161lfe.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=13DPRqcLutO6fBfirS2fGnWp0ersx8LFxopNh5XiZAk=;
        b=EYSp0kydkkjYprHqey7Qtj3ygQppRYPANPcrnE6+VQ4JM0c8WFea4aK4dm1qz5UTij
         znHJojv3gjsmmCZOqaOSc9vBUOcuT9HKXb9cmJZNNd9jrfhpBGdsAT5jTNUZqvhUw2oN
         cYU2o11f88wvbY1KVAhfZ04sjT6I617hUE303gC9E5XnLhKiJkVZU4dF0k5CVVn9kdso
         p6dGE+xTXqDcp3HCl9e3mC2HeEs6WraCAH0omvnk7T+81ytDwufXaKmQGoyiwuoc99G/
         bzL6yePy6GWG5YJLJ5E6pzwNwUd7nDZbiUZcXCfvnKL817wX3rOsTnnrrTV+g8UTZwON
         1dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=13DPRqcLutO6fBfirS2fGnWp0ersx8LFxopNh5XiZAk=;
        b=mAzUb5anoFYapLe+iL3c2kLO+GafujlqJUHQ/oWg2ZcOq+WLijP/1lOaSUo836h6G/
         a2T+rBOSB4TiOclbxE7KXwoIXnVTRKnZvpffIPYjMIzNwyQZFx7J/iSLXq0A9dOP1Hih
         qhOhK1BtXx/8DSmunnjxV/2LWTKxmvDnUVJnqJAjKML5525Zf5Ec4MCJvwyzwFSWOXvU
         Ip9bqtKknFC37gX0jvW389yDc62D35zDwItyq8MZgOMKbVDcSt6CfK07Amjmgwfudbx4
         oaoEnyJ7kd73XvxWI/0IrCoxKT7qy44ZFnzrE+Zusl9K3svLA9XQx5S7mM794eWqWHDF
         E09A==
X-Gm-Message-State: AMke39k/nF01qBk3vpQV2qKD15hpsTBYQNxD32eUrRKopVR/lgmjRQc5F61QGp8lGcEA9toizTNyG7A/V5mrCA==
X-Received: by 10.46.32.193 with SMTP id g62mr5408023lji.119.1487723499647;
 Tue, 21 Feb 2017 16:31:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 21 Feb 2017 16:31:19 -0800 (PST)
In-Reply-To: <CAGZ79kbVr5uqwJmzXJxUn0bpe=d_pgnW3_pYW-q0W0iO0KSRtw@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-13-sbeller@google.com> <CA+P7+xrwxb9G3QVOascSZqnBa_vGEx95nv0jN9USmBqB5Q_Mzw@mail.gmail.com>
 <CAGZ79kahCN2dd9=CzqXJWSJKrkOfvd3HeQ-NORhyP=6B=KCrqg@mail.gmail.com>
 <CA+P7+xq3XF2=erRLiNjOUq9H66Sa5VCxNBzTF=RAycPYrPRFJg@mail.gmail.com> <CAGZ79kbVr5uqwJmzXJxUn0bpe=d_pgnW3_pYW-q0W0iO0KSRtw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 21 Feb 2017 16:31:19 -0800
Message-ID: <CA+P7+xqCvjErBgdUOp3kDKfWo5U60J1X8Af71rRFbDFsT0ODbg@mail.gmail.com>
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the operation
 for submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 3:44 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Feb 21, 2017 at 3:35 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Feb 21, 2017 at 2:16 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Fri, Feb 17, 2017 at 10:42 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>> On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
>>>>> +       if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
>>>>
>>>> Here, and in other cases where we use
>>>> is_active_submodule_with_strategy(), why do we only ever check
>>>> SM_UPDATE_UNSPECIFIED? It seems really weird that we're only going to
>>>> check submodules who's strategy is unspecified, when that defaults to
>>>> checkout if I recall correctly? Shouldn't we check both? This applies
>>>> to pretty much everywhere that you call this function that I noticed,
>>>> which is why I removed the context.
>>>
>>> I am torn between this.
>>>
>>> submodule.<name>.update = {rebase, merge, checkout, none !command}
>>> is currently documented in GIT-CONFIG(1) as
>>>
>>>        submodule.<name>.update
>>>            The default update procedure for a submodule. This variable is
>>>            populated by git submodule init from the gitmodules(5) file. See
>>>            description of update command in git-submodule(1).
>>>
>>> and in GIT-SUBMODULE(1) as
>>>
>>>        update
>>>            [...] can be done in several ways
>>>            depending on command line options and the value of
>>>            submodule.<name>.update configuration variable. Supported update
>>>            procedures are:
>>>
>>>            checkout
>>>                [...] or no option is given, and
>>>                submodule.<name>.update is unset, or if it is set to checkout.
>>>
>>> So the "update" config clearly only applies to the "submodule update"
>>> command, right?
>>>
>>> Well no, "checkout --recurse-submodules" is very similar
>>> to running "submodule update", except with a bit more checks, so you could
>>> think that such an option applies to checkout as well. (and eventually
>>> rebase/merge etc. are supported as well.)
>>>
>>> So initially I assumed both "unspecified" as well as "checkout"
>>> are good matches to support in the first round.
>>>
>>> Then I flip flopped to think that we should not interfere with these
>>> settings at all (The checkout command does checkout and checkout only;
>>> no implicit rebase/merge ever in the future, because that would be
>>> confusing). So ignoring that option seemed like the way to go.
>>
>> Hmm. So it's a bit complicated.
>>
>>>
>>> But ignoring that option is also not the right approach.
>>> What if you have set it to "none" and really *expect* Git to not touch
>>> that submodule?
>>
>> Or set it to "rebase" and suddenly git-checkout is ignoring you and
>> just checking things out anyways.
>>
>>>
>>> So I dunno. Maybe it is a documentation issue, we need to spell out
>>> in the man page for checkout that --recurse-submodules is
>>> following one of these models. Now which is the best default model here?
>>
>> Personally, I would go with that the config option sets the general
>> strategy used by the submodule whenever its updated, regardless of
>> how.
>>
>> So, for example, setting it to none, means that recurse-submoduls will
>> ignore it when checking out. Setting it to rebase, or merge, and the
>> checkout will try to do those things?
>
> That is generally a sound idea when it comes to git-checkout.
>
> What about other future things like git-revert?
> (Ok I already brought up this example too many times; it should have
> a revert-submodules as well switch, which is neither of the current strategies,
> so we'd have to invent a new strategy and make that the default for
> revert. That strategy would make no sense in any other command though)
>

This is where things get tricky, IMHO. The problem is that the
strategy now wants to encompass more things.

> What about "git-rebase --recurse-submodules"?
> Should git-rebase merge the submodules when it is configured to "merge"
> Or just "checkout" (the possibly non-fast-forward-y old sha1) ?
>
> The only sane option IMO is "rebase" as well in the submodules, rewriting
> the submodule pointers in the rebased commits in the superproject.
>

I'm not even really sure what rebase should do here at all. I assume
by this you mean "what would a git-rebase that also rebased submodules
do"

Ofcourse the sane answer might be something like "uhh you have to
decide that for yourself manually" I think this is a really complex
problem to solve, and in this case I do not think rebase should even
rely on the strategy. a "recurse-submodules rebase" would do something
like:

rebase parent as normal, but if a commit changes the submodule, then
it needs to re-create that submodule change using its own rebase
inside  the submodule based on the (new) parent from the parent
projects history change, and then commit that as the committed change?

But I don't even know if that really makes sense in all cases either.

I think you could check strategy, and then have rebase go "uhhh here's
what I found, you fix this manually"?

That's quite complicated.

>>
>> Or, if that's not really feasible, have the checkout go "hey.. you
>> asked me to recurse, but uhhh these submodules don't allow me to do
>> checkout, so I'm gonna fail"? I think that's the best approach for
>> now.
>
> So you'd propose to generally use the submodule.<name>.update
> strategies with aggressive error-out but also keeping in mind
> that the strategies might grow by a lot in the future (well only revert
> comes to mind here).
>
> ok, let's do that then.
>

I think that's the safest option. If we add a new strategy, each
command can decide what it should do for that strategy, and we can
decide that in the future. I'm not sure what users expect, but I think
if we start by erroring out on things we can't support, and then if we
decide we can later ,it's not a backwards compatibility hurdle. Where
as if we decide "this works now" but later discover that it cannot,
then,... we have to figure out a lot more backwards compat issues.

> Thanks,
> Stefan
