Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F581F453
	for <e@80x24.org>; Tue, 19 Feb 2019 08:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBSICU (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 03:02:20 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:34115 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfBSICU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 03:02:20 -0500
Received: by mail-ua1-f53.google.com with SMTP id a42so6200783uad.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 00:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SgvtFc4W73EckcqJqvdlTVXEv+dKhdo1D0BZ+Yg0wc=;
        b=JxAZvRsGCPtbvObOQ7k52da3hRCNXp/xtom1T5tTsvNLWnx9avZJYGTst2bQk6W74N
         52bsskJq3oTjAq1JhN1ZZ1/i3aEcrTuJF4xFjaiPdCNdZEjhqulaCr/CjbUq5on5oK3y
         JqpdNmOBRS4cIeA36HAnA4KtNbkSHCxjnyZ4vKvePqbOZjFfZDcv72dR+AspqkgYG9Vu
         oEtOhPRhT9N+abwoAuLAhjWv0u93FuOs9xPHIUizMNAu2maeY/RoKIH5F09u1Bwc//UG
         d1n/VUQMWUQTZK1nKUwvlwFZikQaTgL5RgzA1h2MSQI57n+WprYLEgQm6HxuHKZJe5LR
         Xrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SgvtFc4W73EckcqJqvdlTVXEv+dKhdo1D0BZ+Yg0wc=;
        b=kqhCGT5O9gVdswyAr2Br3FEfA0Q+ttMlEWPt7SFGp8AGWPU31ollcHgNvQqPh2ZFM9
         fOs6v5rsCS/e9zKiVsv+bTK7HRFenYRqUXHVoJ+Wg2hqnW3XzCO6WdTfVIMCwqJBTmh7
         KAE+wdq+mcLABIQGKA5LprAjRq3USCcHTh3Rl7I817YYkpcpW3tBbUHwW/zhl3TA9690
         bO1QzGDKQh1qT3edP7MfAG743aUWKiJ/aBojuKok41waURb7+G4ew/Utmd+mQpecubDZ
         JxTZBN4jN4N3f83OE8AoIK8mX3e2nlYydd54QVQlb1SrOI4UtIbEqnPlk7Wrk+iPveYS
         rk4w==
X-Gm-Message-State: AHQUAua/wN+iicVmnmTtWYGp9/I7UzPnvu/YR5XUHN+V3lhvkYprcUel
        FO2p282/hlcJCcYbqUiQdNHtxKLpfDdFYZErjAY=
X-Google-Smtp-Source: AHgI3IaMvOysCRJucVKdzJ6VOD++KVlPKXy86QmmAZenZ6mH9QU22h2R1EHpbvMt4WOtTwlnFeOYIz1mOF4aZtxQXKQ=
X-Received: by 2002:ab0:4707:: with SMTP id h7mr14046749uac.46.1550563338403;
 Tue, 19 Feb 2019 00:02:18 -0800 (PST)
MIME-Version: 1.0
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com> <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
From:   Senol Yazici <sypsilon@googlemail.com>
Date:   Tue, 19 Feb 2019 09:02:43 +0100
Message-ID: <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, Johannes.Schindelin@gmx.de, jpyeron@pdinc.us
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

Thank you for the quick response and apologize my late reply (good
morning from Europe).

I understand that well "established" concepts might make it easier
grasping concepts.

My concerns towards using these particular expressions
(dictator/lieutenant/blessed) are nevertheless motivated.

1. Dictator
Concern: "Bad" connotation.

I agree, dictator is not military, but it is not "not military at
all", see https://www.merriam-webster.com/dictionary/dictator.
Except of case 1 a (and 2, which is not applicable in this context),
cases b and c are related to either "autocrat" or "fascist dictator".
Both of these historical "figures" majorities abused their military
power to "rule" in an oppresive way.
Further, "googling" dictator does not give Linus as a result in (at
least my) search (bubble).
It gives the well known bad examples of dictators usually having
abused or are abusing their powers in an oppressive/tyrannical way.

Suggestion for substitution: Principal or principal integrator.

2. Lieutenant (somehow I manage to misspell this word most of the times)
Concern: Strong relation to military.

I also agree here, lieutenant is not military, again see
https://www.merriam-webster.com/dictionary/principal.
The connotation here is also not as negative as it is with dictator.
However, googling lieutenant results in mostly military figures.

Suggestion for substitution: Assistant or assistant integrator.

3. Blessed repository
Concern: Rather exclusive than inclusive.

I agree, blessed is not a bad phrasing. But if one is not
attached/related to a religion in some way, one somehow feels left
out.
It is creating some troubles explaining this to the "curious young
mind" (i.e. children) without having to mention religion at some point
of the explanation.
Why should one need to go there in a discussion of how "big projects"
are dealt with?
Of course, one could say "it is another word for approved" and neglect
the origin of the word.
What would then be left as a motivation to use this word at all, and
not use approved?

The more I try to understand what "blessed" in a context of a
repository wants to tell me about it's current state, the less I am
understanding.

I think the state of the repository is something like "Approved by
principal integrator" or "Principal integrator (PI) approved", thus...

Suggestion for substitution: PI-Approved repository

Words have their weight.
In times where the entire world is accessible by the "click of a
finger" it is becoming more and more important to be inclusive.
Further, in a world where hundred of millions live in conditions ruled
by dictators or military regimes _I_ care more about acceptable than
"descriptive".

I am not sure if someone in a "warlike" situation will feel "included"
finding these expressions when it is about software development
projects!

Again thanks for your attention and participation in the discussion.

Best regards,
Senol Yazici


Senol

On Mon, 18 Feb 2019 at 19:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
> >> Taking a lesson from other Open Source projects, Jenkins has deprecated
> >> Master/Slave in favour of Controller/Agent. This seems not only more
> >> acceptable to some, but in my view more descriptive. The terms on the page
> >> above do not actually make any descriptive sense to a newbie. And confusion
> >> could ensue from the dictionary definitions:
> >>
> >> * Lieutenant: an aide or representative of another in the performance of
> >> duty : assistant (not what that repository is for)
> >> * Dictator: one holding complete autocratic control : a person with unlimited
> >> governmental power (not how the git team behaves)
> >> * Blessed: honored in worship : hallowed; of or enjoying happiness (although
> >> I can see the happiness part of this one)
> >
> > It probably would be worth submitting this as an issue to the
> > documentation project at
> > https://github.com/git/git-scm.com. Depending on the response from
> > the committers, I might be willing to take that on, but digging
> > deeper, I'm not sure the terms I proposed as sufficient.
>
> I personally do not feel these three words are so problematic to
> spend bandwidth discussing on here; it probably is partly because I
> am not a native speaker and am not too much disturbed by connotations
> they may make those who are more fluent with the language feel.
>
> The page describing various ways a project can be structured uses
> the kernel project as one of the examples, and over there, at least
> "lieutenant" is a well understood term to describe those who feed
> Linus (because Linus does not scale otherwise).  I do not know if
> Linus is called "dictator" there but I trust those who wrote that
> "distributed" page knew what the words commonly used in the example
> project they chose.  Deviating from the words they use would make
> the example harder to understand.
>
> For that matter, I do not know why borrowing vocabulary from any
> well understood area, be it military or religion, is a bad idea to
> begin with.  I personally have no issues with people who worship
> deity of their own (or none). That probably is also due to where I
> come from, where we have 8 million of them ;-)
>
> So, if the reason why some people feel "blessed" is a bad phrasing
> to use is because it came from a particilar religion and other
> religions have no such concept, I do not agree with such a feeling
> at all, as long as those who hear it all know what the speaker means
> by the word.  I would have more problems if we pick a word rarely
> used that nobody would understand.
>
> I _think_ that is what the distinction between "acceptable" vs "more
> descriptive" mentioned in the early part I quoted in this message
> talks about---I do not quite by "acceptable" part, but I care more
> about "more descriptive" part.
>
> Thansk.
>
>
>
