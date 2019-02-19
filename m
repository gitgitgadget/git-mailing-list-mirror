Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838E81F453
	for <e@80x24.org>; Tue, 19 Feb 2019 11:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBSLTz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 06:19:55 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38860 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfBSLTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 06:19:55 -0500
Received: by mail-ed1-f42.google.com with SMTP id h58so16380296edb.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0NVCo/xIEKVGrgov8sHwYrWMd6OTR00kfRAJaTzqwHM=;
        b=clAAwS8sBl3STcC8krXHt3QZj1Y9LBB5SBD034o4N2L/z73iNXVbJgWNWzwjHUvQcm
         GD+3GQiG6Nuew9Qd1ExeC2E/9a+aQP5XHrESFMR177cVhx4KhgLcH3G+3mVqSdlMyQFZ
         PaUh4B4XkYo4/CkKU1DfKc7kQ8hx68zVpnDZAvrXOmar2aWPKuT8dF7Hz8qLuF/U/05y
         5BEnFuqcZhjpY27Mb02RiW3VD2iyGs71p6+nPxQpnparQVkgwjmijqcr2zTXSFky0uU7
         7Vkm8UNg9dGkSEn0RMguago00NU+C2sJDuQyRD/qUL19YYNhGpTXwdVEESj2pLe8bEkm
         q5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0NVCo/xIEKVGrgov8sHwYrWMd6OTR00kfRAJaTzqwHM=;
        b=RIi/RH25iVVcuAs8yGcdbshXAYVOsRVbyy2dtB+RViM+qxnPg77tmtgo69kfRo2LQV
         1T7WtIyAYGDXvVgX6PZHZG74yLIwN8uXTn8cVC6MnikLF/xax2ybLVE/4MfUcOZ+OE67
         2PGvjki/VpSdSnA3LMtM9Mtt9/FTrna1qenuxhWISoeBDcG6OkA9bDUDf+j6Iv0LDGqL
         BB1XGCBoHwh5cd4q7GQBwsYwaGyIPqNDG3yobUFhn2CtmmwlMGBso0sKGpZm1ouPbMZ3
         A4wbX9myRBcd9o86065MZbtPldZOM1nHhAplAWF8Wfv831pKeoRqWPs/79HEZ/KIDmNH
         /9Ew==
X-Gm-Message-State: AHQUAuazMJtsxwGspdihmolpwaYkRsUSW7yC/yAZqlFts45sGepiZeI8
        5E2aMlOFu5fuehtx82ZynDM=
X-Google-Smtp-Source: AHgI3IYsBLiYN+G+SF5NQ6/hr4sSM3nuxYAKDirTKbo5wlmgCHcXdAwAiprFAXiS2ol+pbR3AYPkxw==
X-Received: by 2002:a50:cf01:: with SMTP id c1mr23006717edk.94.1550575192703;
        Tue, 19 Feb 2019 03:19:52 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u18sm3666583ejl.5.2019.02.19.03.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 03:19:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Senol Yazici <sypsilon@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, Johannes.Schindelin@gmx.de, jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status Notification (Failure))
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com> <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com> <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
Date:   Tue, 19 Feb 2019 12:19:51 +0100
Message-ID: <87o97858ko.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 19 2019, Senol Yazici wrote:

> Thank you for the quick response and apologize my late reply (good
> morning from Europe).
>
> I understand that well "established" concepts might make it easier
> grasping concepts.
>
> My concerns towards using these particular expressions
> (dictator/lieutenant/blessed) are nevertheless motivated.
>
> 1. Dictator
> Concern: "Bad" connotation.
>
> I agree, dictator is not military, but it is not "not military at
> all", see https://www.merriam-webster.com/dictionary/dictator.
> Except of case 1 a (and 2, which is not applicable in this context),
> cases b and c are related to either "autocrat" or "fascist dictator".
> Both of these historical "figures" majorities abused their military
> power to "rule" in an oppresive way.
> Further, "googling" dictator does not give Linus as a result in (at
> least my) search (bubble).
> It gives the well known bad examples of dictators usually having
> abused or are abusing their powers in an oppressive/tyrannical way.
>
> Suggestion for substitution: Principal or principal integrator.
>
> 2. Lieutenant (somehow I manage to misspell this word most of the times)
> Concern: Strong relation to military.
>
> I also agree here, lieutenant is not military, again see
> https://www.merriam-webster.com/dictionary/principal.
> The connotation here is also not as negative as it is with dictator.
> However, googling lieutenant results in mostly military figures.
>
> Suggestion for substitution: Assistant or assistant integrator.
>
> 3. Blessed repository
> Concern: Rather exclusive than inclusive.
>
> I agree, blessed is not a bad phrasing. But if one is not
> attached/related to a religion in some way, one somehow feels left
> out.
> It is creating some troubles explaining this to the "curious young
> mind" (i.e. children) without having to mention religion at some point
> of the explanation.
> Why should one need to go there in a discussion of how "big projects"
> are dealt with?
> Of course, one could say "it is another word for approved" and neglect
> the origin of the word.
> What would then be left as a motivation to use this word at all, and
> not use approved?
>
> The more I try to understand what "blessed" in a context of a
> repository wants to tell me about it's current state, the less I am
> understanding.
>
> I think the state of the repository is something like "Approved by
> principal integrator" or "Principal integrator (PI) approved", thus...
>
> Suggestion for substitution: PI-Approved repository
>
> Words have their weight.
> In times where the entire world is accessible by the "click of a
> finger" it is becoming more and more important to be inclusive.
> Further, in a world where hundred of millions live in conditions ruled
> by dictators or military regimes _I_ care more about acceptable than
> "descriptive".
>
> I am not sure if someone in a "warlike" situation will feel "included"
> finding these expressions when it is about software development
> projects!
>
> Again thanks for your attention and participation in the discussion.

Two things:

 1) Whatever anyone's abstract position on the wording of our
    documentation, either the one stored in git.git or at
    https://github.com/git/git-scm.com there's only so much a
    theoretical discussion like this can get us.

    If you're willing to pursue this further I think it's best if that's
    done in the form of patches to either repositories, either sent here
    on-list (see Documentation/SubmittingPatches) or as a PR to
    https://github.com/git/git-scm.com

 2) Any piece of software or technical tool is going to unavoidably need
    to use some amount of jargon, or words that are lifted from a more
    general vocabulary and intended to be understood in context.

    Thus, when we talk about e.g. "trees" in git, it's understood that
    we're talking about something in the context of this software
    project, trying to go by the first Google result of "tree" isn't
    going to get you anywhere.

I for one thing those git-scm docs could be changed to eliminate those
words for reasons entirely unrelated to them somehow being religious or
militaristic. Specifically:

 * "blessed" is introduced in quotes and used twice. I think it would be
   clearer to use "canonical" for what it's describing.

 * The docs already use "integration manager" and then introduce
   "dictator" as a synonym in the context of explaining the workflow of
   the kernel.

   They could instead use "main integrator" or something, since the
   point of the example is to explain how git can be used to manage
   distributed repositories that are integrated in a hierarchical
   manner.

   Making assumptions about how much power the "main integrator" has to
   approve/reject changes is irrelevant to that explanation.

   E.g. the kernel could also decide to make the "main integrator" some
   purely automated process that always approves changes from
   lieutenants and the hierarchical example would be just as true.
