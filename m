Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30FB201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbdBUXQa (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:16:30 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34974 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbdBUXQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:16:28 -0500
Received: by mail-io0-f174.google.com with SMTP id j18so33073672ioe.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YR8se0/Pto0iyXw9uLBLvPQDL+IK4JZskTO5/KrF70k=;
        b=prSQNxjlIlnCTlWlBFjbEajJFDqHA/OhHcf7kgdi3MQgMnEDd8JdG2BYuhFUS1XLmK
         3dDungKEn7664VQxL+qerH+O/NmFmpFMJ9oHfIGfPGa+io2cvFiyxUzCyWs46suiMJ3a
         LvPwnzrFxs2NOm4rUdXinR0vMrKeBObIMYhcrMy0TFL5v9l2geSU3WcBNxIoFfOfWIdn
         kfoBkxiwQUDInKmYYoog74VXSEeYUeXVCrbrYfXBqcpomkUW4Z24gLUfWaOooTgbQs8Z
         puarLhsJq0ytkBpjnKbzqbPg2Z43lJIfsaKlsCoJ2U78K2qBjvdt0+9/FAT28/7qOge4
         Q4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YR8se0/Pto0iyXw9uLBLvPQDL+IK4JZskTO5/KrF70k=;
        b=LL9HEKyjqxb63LfSBg3lwgxz+9JcKftXhZG3hRoT7m/6rcFFkJouj3zTcAuPG+FzeP
         ObUUo69FBqMjicjSyxFmUk239T6w6d42wl6BNw28pe+1xC7IXIkTGlHheLX29uq/CLhT
         kDuGFA7Q1mjaky7lCMrIvYfAG+wPrxz7vaGoy63IrHfp3eLu27JqjQID48myD7xUldBy
         UG60gMiLvAgcRFqeIW3EJe6Bl+Edpq9imiy+E3k36HKyRgMLardxNvPlJXuzMMOBPHzF
         UvQ3KcyX61iVOuxuWMX3yFGEp9s7sGe9NcxDCe1qAV1dkbFp2hcAB+8nyG6IGVsv47xN
         gtUA==
X-Gm-Message-State: AMke39nRpKObL0O905bVJZ3rjN7P614wTlMHb+I86mvpMbQVXItJk4lBBaf1mKIRv4WbWXpMcv518UlzcwzmQyjV
X-Received: by 10.107.47.162 with SMTP id v34mr17141915iov.52.1487718987556;
 Tue, 21 Feb 2017 15:16:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 15:16:27 -0800 (PST)
In-Reply-To: <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net> <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net> <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net> <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
 <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 15:16:27 -0800
Message-ID: <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Jeff King <peff@peff.net>
Cc:     Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 3:00 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 21, 2017 at 10:19:38AM -0800, Stefan Beller wrote:
>
>> On Mon, Feb 20, 2017 at 11:06 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > We'll see if the submodule folks have any ideas on how to implement
>> > that.
>> >
>>
>> So from reading your discussion, the user expectation is to have
>> `git submodule {init, update --init, sync}`
>> to pay attention to url.<base>.insteadOf when setting up the
>> submodule.<name>.URL, such that the modified URL is used for the
>> initial clone of the submodule (and hence any subsequent usage within
>> the submodule).
>
> Yeah, that was what I was envisioning.
>
>> Two caveates:
>>
>> * After running `git submodule init`, you change url.<base>.insteadOf
>>   in the superproject. How do we need to word the documentation to
>>   have users expecting this change doesn't affect submodules?
>>   (See above Any vs. "Any except (initialized) submodules")
>
> Good question.
>
> I guess one answer is that this is the wrong approach entirely, and the
> right one is something like: submodules should understand that they are
> part of a superproject, and respect some whitelisted set of config from
> the superproject .git/config file.

This would break one of the core assumptions that submodules
are "independent" repos.

The way of action is a one way street:
* The superproject is aware of the submodule and when you invoke a
command on the superproject, you may mess around with the submodule,
e.g. update/remove it; absorb its git directory.
* The submodule is "just" a repository with weird .git link file and a
  respective core.worktree setup. Currently it doesn't know if it is
  guided by a superproject.


Though I do not know if this is actually a good assumption.
e.g. "[PATCH v2] git-prompt.sh: add submodule indicator"
https://public-inbox.org/git/1486075892-20676-2-git-send-email-email@benjaminfuchs.de/
really had trouble in the first version to nail down how to tell you are in
a submodule, but people want to know that.

>
> The second half is pretty easy to do (use git_config_from_file on the
> super-project's $GIT_DIR

There goes the "pretty easy"; currently there is no concept to find out
the existence of a super-project.

> /config, and pass a callback which filters the
> keys before passing them along to the real callback).
>
> I'm not sure about the first half (submodules know about their
> superproject), though.

Maybe we need to change that fundamental assumption.
So a more sophisticated way (thinking long term here) would be
to include the superprojects config file (with exceptions), and that
config file has more priority than e.g. the ~/.gitconfig file, but less
than the submodules own $GIT_DIR/config file.
Then a setting like the url rewriting would be "inherited" by the
submodule, with the option to overwrite the default as given by the
superproject.

>
>> * So with the point above the insteadOf config only applies to the
>>   init/sync process, (i.e. once in time, ideally).
>>   Is that confusing or actually simplifying the submodule workflow?
>
> Not sure. That's why I asked you. :)

I think that would be ok. With the idea of inheriting the superprojects
config, we allow for not storing the rewritten url, so the submodule
handling is less of a corner case here, and as another advantage the
rewriting rule is applied in real time, e.g. you can change the superprojects
rule after the fact and the submodule would automagically make use of it.

>
> One other caveat: I'm not sure if we do insteadOf recursively, but it
> may be surprising to the child "git clone" that we've already applied
> the insteadOf rewriting (especially if the rules are coming from
> ~/.gitconfig and may be applied twice).

When a rule is having effect twice the rule sounds broken. (the outcome
ought to be sufficiently different from the original?)

>
> -Peff

Thanks,
Stefan
