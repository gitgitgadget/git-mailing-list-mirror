Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB591F667
	for <e@80x24.org>; Tue, 22 Aug 2017 18:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdHVSKz (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 14:10:55 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36536 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdHVSKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 14:10:54 -0400
Received: by mail-yw0-f175.google.com with SMTP id y64so28081222ywf.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ygo6OWjoiqoWG8F3UJa1/AVP3UmCFa+S7d1pVprzLFY=;
        b=CsPC00q4SeP/TDLHSzYP0ECF5HXHvukujB2gfrLBiP/BKuz/ZLo28csysKNG0cFhr9
         ALQQR0qz8ZOyZEgno268G6vOTzbAZcXvKWOwpAkqnqS9LL/tLJXnoLLxwi/OVvei9vtn
         5HgF/GAOb3J22zyEJECf49AsAUmsCMEVKmFS5kLTf7uT3EVugHyOv6usTCtNbW1SIQUM
         uNRL1U05Og3q8N80fBN+2meBNrWet0tY1liUjbs0z9ethKxcamq8JW9+8ewZSU39sI9n
         oRhkEwEM+OLS4lhV1/4HkTQtQd9qw9nkv/8GEsx8g1C9lFnHeb04o1RdNYraxeYgLXCJ
         NTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ygo6OWjoiqoWG8F3UJa1/AVP3UmCFa+S7d1pVprzLFY=;
        b=mYiyU1tKyfVINTdyg+8bAg0RB2uijqp9pv883Vmf2BalfQH81tNka9lLG8fU8MW5+S
         Mt0ShB2ycxQCI10Uo5zh5cIx1W2io3HqGAO41FQqUckAAAtp3UAinsZFQvmOkoC0mxCP
         aXoqWbX2+1ToOC4NLFsz74f8dmOMblKxs2fJXV9Nx+yMfhKgQOt40EEEDKKr3Ouj/ay4
         FOOy/3uoaGDmQAd+D4SBRUIiMyiAQhGDanBkx15aNgeGImvbrgwguS1bsdqS7iZM+2Xf
         bMnUCDheilZcUppCfOyu+gDnpKhC3BRfbTCt4/gAbboLIRuROGDu5E1fswVHlyPhp1W4
         3sZg==
X-Gm-Message-State: AHYfb5j95hcySqfwbISDSJpXYZ5DS7j5GT+aXdfwFS7tsNdBYgxtmX5m
        +PmWLTuzcwypSDPthwoaCpJcZpPCSg3P
X-Received: by 10.37.51.7 with SMTP id z7mr1369381ybz.145.1503425453563; Tue,
 22 Aug 2017 11:10:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 11:10:52 -0700 (PDT)
In-Reply-To: <20170822153311.GA5697@book.hvoigt.net>
References: <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com> <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com> <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com> <20170821160514.GA1618@book.hvoigt.net>
 <CAGZ79kZvcY8hawq1qGfFLm1Ukb-wn8j0e_hN8gF5jrEY20o7YA@mail.gmail.com> <20170822153311.GA5697@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 11:10:52 -0700
Message-ID: <CAGZ79kbwJN_XVcAbkyVJTax9F2NR4EO8XjR3U9EH8MLqbAb90Q@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 8:33 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Mon, Aug 21, 2017 at 09:42:54AM -0700, Stefan Beller wrote:
>> On Mon, Aug 21, 2017 at 9:05 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > On Fri, Aug 18, 2017 at 11:51:13PM -0700, Junio C Hamano wrote:
>> >> As long as we are talking about idealized future world (well, at
>> >> least an idea of somebody's "ideal", not necessarily shared by
>> >> everybody), I wonder if there is even any need to have commits in
>> >> submodules in such a world.  To realize such a "monorepo" world, you
>> >> might be better off allowing a gitlink in the superproject to
>> >> directly point at a tree object in a submodule repository (making
>> >> them physically a single repository is an optional implementation
>> >> detail I choose to ignore in this discussion).
>> >
>> > IMO this is one step to far. One main use of submodules are shared
>> > repositories that are used by many superprojects. The reason you want to
>> > have commits in the submodule are so that you can push them
>> > independently and all other users can pick up the changes. You could get
>> > by by Using the superproject commits for the submodule once you push or
>> > something but those do not necessarily make sense in the context of the
>> > submodule.
>> >
>> > So I think it is important that there are commits in the submodule so
>> > its history makes sense independently for others.
>> >
>> > Or how would you push out the history in the submodule in your idea?
>> > Maybe I am missing something? What would be your use case with gitlinks
>> > pointing to trees?
>>
>> Well there are still commits, but in the superproject the UX feels more
>> as if the submodules were special trees.
>
> Ah ok then I misunderstood. So they only feel like trees.
>
>> So if you want to interact with
>> the submodule specifically, you could do things like
>>
>>     git add /path/inside/sub
>>     # works seamlessly from the superproject tree
>
> Would that mean that we need to loosen/keep the requirement loose for a
> name from .gitmodules? I am asking because of my series for on-demand
> fetch of renamed submodules. For the full functionality I would require
> a name.
>
> Would that be in a scenario where the user would then e.g. push the
> submodule into the superproject?
>
> Ah wait I misunderstood again. You mean a file in an existing
> submodule right? Not adding submodule from a repository a user moved
> there?

Assuming the submodule is at  /path in this example, the effect of
that command could be achieved today via

    git -C /path add inside/sub

(i.e. for git-add we "just" detect that there is a submodule boundary
and run the git-add inside the submodule)

>
>>     git commit --submodule-commit-only
>>     # When the flag is not give, you may get an editor
>>     # asking for two commit messages, (sub+super)
>
> Or maybe something like
>
>     git commit --submodule path/to/submodule

Yes. In todays UX, you do

    git -C path/to/submodule commit

for the command that you proposed. For a plain
git-commit in the superproject, we could envision
this sequence of todays commands:

    git -C submodule commit
    git add submodule
    git commit

>
> so the user can specify which submodule she wants. I first wrote it
> without the switch but but that collides with listing files which should
> be added. IMO this shorter option is also more intuitive to understand
> what it does (for this case).
>
>>     git fetch --submodule
>>     # When the flag is not given, we'd fetch superproject and
>>     # on-demand
>
> Yes like above we should add the path to the submodule right?

yes.

>
>>     # You feel the superproject is in the way?
>>     git worktree add --for-submodule <path/to/sub> ...
>>     # The new submodule worktree puts the
>>     # submodule only UX first. so it feels like its own
>>     # repository, no need for specific flags.
>
> I am not sure I understand this one. What would that do? Put a worktree
> for submodule path/to/sub to ...?

Yes, and at "..." you would have the UX of the submodule being
its own repository, no interaction with the superproject.

>
> Overall I like the direction of these ideas.
>
> Cheers Heiko
