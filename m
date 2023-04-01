Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623D9C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 09:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDAJFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 05:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDAJFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 05:05:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B51BF6A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 02:05:03 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5416698e889so460033487b3.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680339903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZhiA6RCe3vw7uS1RPuAbAL24KsApCZ7or4qtwWTx/Y=;
        b=Bo8DI846fMoRPeCDvLrsNjowVQyA78qZGJftm3Z+GYNID5h8rcOuQ+JSK9OsQYAYqr
         EnTMyo7jOsDU6Z0Utvb6/ZHOuYRgHcIy3tPxtEZXJJctonhOHX2OIIzcI7rqi6A0AvbI
         QzkSuZbwY5ImcNWYTrOjIIAHn7pE1oKb9lAmNVqa9lZ+RFOhtOk2el8f9Qtm5MsFxrsb
         XWt2iqsi5YmTu2WUIGoDvaECl0q2ymWQiBHeQtI7joTl+Dom35m64H+yyI02IQHNGLNC
         MU884V9d4PhfDssxmWcLkUOsZeJ9Jt7fTqCJ940WZqTllwm7Z1K/jwuJymr9DptbcLEs
         4JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680339903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZhiA6RCe3vw7uS1RPuAbAL24KsApCZ7or4qtwWTx/Y=;
        b=2rm/dDwYpkQvWQUhPgdhryx8F6jhjORBnBESg7XCjYd+vLMJJqZcnc8lsrGqSS/erv
         IpIhLFBdg5VopFX0t4LjujT7SCHc5I3j03gc67HT289UAnLVogJtXXJWyhRFLZJoJEBp
         dioLYiS7l+7uglSypRMPSYXPtiZPR08EIv/q+xMyTpaxcjst6TSlB+3hkBzJrGSS/HbE
         BHuV8B3Pb0VBM5F9Dik/c8k9C1lU5g8MC/yCSIrrCTMTn7PeS6WEVDxyVqcxkjVlBHID
         1p83oXlr/30aGsTwWecnurjlb4klK74xsz+LSCDVjBjRgbgoPxlkTGeDkVhMc9AsaEH0
         XXIA==
X-Gm-Message-State: AAQBX9fVgnsuv1gFrPd5UPaz9UU/d6NRkmA8YE3Afp6Glqmsu8rUItFW
        pf4qZn9xOiSjemNMQJXzvLcsdq0ZTU53A/iKqHE=
X-Google-Smtp-Source: AKy350Y/v+hZAvq/IIt0Gyuu7bKbc9/QV2OxQoG9Zbad9rvtt38sSCpn1wLhXNfX42VpjAj4c5oIenckewea7YGhmYw=
X-Received: by 2002:a81:b107:0:b0:540:62be:42b with SMTP id
 p7-20020a81b107000000b0054062be042bmr14327417ywh.6.1680339902745; Sat, 01 Apr
 2023 02:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <100814d1.2603.18735b059bb.Coremail.18994118902@163.com>
In-Reply-To: <100814d1.2603.18735b059bb.Coremail.18994118902@163.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Apr 2023 11:04:51 +0200
Message-ID: <CAP8UFD3Lns7pQQ-yNc5W8d2bfPBmJ0pcD52yCbkFOmymhWKw9Q@mail.gmail.com>
Subject: Re: [GSOC] [PROPOSAL v2] Draft of proposal for "Unify ref-filter
 formats with other pretty formats"
To:     Zhang Yi <18994118902@163.com>
Cc:     git@vger.kernel.org, hariom18599@gmail.com,
        karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 5:22=E2=80=AFAM Zhang Yi <18994118902@163.com> wrot=
e:
>
> I have changed my proposal according to the comments by Hariom Verma.
>
> Improvement vs v1:
> 1. Put more effort into related work and grasp a lot from them.
> 2. More details about timeline.
> 3. More details about my plan.
> 4. Some tiny changes in other content.
>
> Open to more guidances. Thanks for suggestions.

Thanks for improving your proposal based on our feedback!

[...]

> Aim to unify the different implementations to format output for different
> commands, we want to transform pretty into ref-filter formatting logic. A=
ccording
> to the present situation, I need to add more ref-filter atoms to replace
> pretty.

Could you explain a bit more what that means and why you need to do
that? (You might already do that in a different section below, but it
still feels a bit strange to see this last sentence without much
explanation.)

> ** Previous Work
>
>   - `git for-each-ref`, `git branch` and `git tag` formats into the
> ref-filter formats:
>
> done by Karthik Nayak (GSoC 2015)
>
>   -  `git cat-file` formats and the ref-filter formats:
>
> started by Olga Telezhnaya (Outreachy 2017-2018),
> continued by ZheNing Hu (GSoC 2021),
>     There are a lot of patches which are concluded in his final blog [1]
> but still not finished due to tricky performance issues
>
>   - ref-filter formats and pretty formats:
>
> started by Hariom Verma (GSoC 2020)
>     There are also a lot of patches which are concluded in his final blog=
 [2]
> continued a bit by Jaydeep Das (GSoC 2022)
>     Patch: gpg-interface: add function for converting trust level to stri=
ng [3]
> and continued by Nsengiyumva Wilberforce and his  work on the "signature"=
 atoms
> should be mostly over when the GSoC starts. (Outreachy 2022-2023)

Yeah except Wilberforce has actually been working outside of Outreachy
as he didn't satisfy the requirements for being accepted, but still
wanted to work on this.

>     Patch: ref-filter: add new atom "signature" atom [4]
>
> ps: There seems no conclusion articles of Karthik Nayak's and Olga Telezh=
nava's
> works.

Karthik's blog posts might have disappeared for some reason. I have
Cc-ed him and he might tell us.

Olga's blog posts seem to still be available on
https://medium.com/@olyatelezhnaya. Medium seems to require signing in
these days though.

> ** What is left
>
> Since the work of "signature" atoms will be finished by Nsengiyumva Wilbe=
rforce,
> There may be some other atoms left for ref-filter formats and pretty form=
ats.
> But I still need to check.
>
> If there is no work left for for ref-filter formats and pretty formats, t=
hen

s/for for/for/

> there may be another command which has a different format implement with

Maybe: s/implement/implemented/

> ref-filter.

I am not sure what your last sentence here means. If a command already
uses ref-filter formats, then there is no more work to do as that's
the end state we would like.

> ** Steps
>
> In my mind, there are 4 steps logically:
> 1. Check and find a pretty atom which has no substitute in ref-filter.
>    This step is to decide the whole direction of the next work.

So you might want to take a look at this step soon. It might not be
difficult to find out, as the implemented atoms are described in the
docs.

They are called "field names" in the git for-each-ref documentation
(Documentation/git-for-each-ref.txt) and "placeholders" in the pretty
formats documentation (Documentation/pretty-formats.txt).

>    Christian Couder informed me that I can do things like the following:
>    - making sure that all the atoms in the pretty formats have similar
>    atoms implemented in the ref-filter formats
>    - find a way to convert any string containing pretty format atoms to
>    a string containing only ref-filter format atoms
>    - find a way to plug-in the ref-filter code into the pretty code, so
>    that callers of the pretty code would not need to be changed much.

Yeah I suggested these as possible steps to split the work, hoping
that you would dig a bit more what they meant, and how you could
perform them.

> 2. Add reasonable test scripts and maybe documents in advance.
>    In my opinion, making a draft of test scripts and documents in advance=
 can
>    help me have a deep understanding of the behavior that I need to code.=
 I learn
>    this development mode from book. And I have really met problems rising=
 from
>    the misunderstanding of needed behavior which will result in a lot of =
reworks.

I agree that it's a good approach when developing new features. Here
the features and associated high level tests and documentation already
exist. We "just" want to replace the internal implementation of the
pretty formats using the ref-filter formats. So the approach could be
a bit different.

> 3. Change code.
>    Inspired by Hariom Verma's proposal, I can  start by first looking at =
what
>    actually needed to be replaced (for example by studying the PRETTY FOR=
MATS
>    section in 'man git-log', what which verbs you can use in the ref-filt=
er
>    ('man git-for-each-ref') to achieve the same thing.

Yeah and this shouldn't take a lot of time. I think Hariom already
wrote a correspondence table between the different "verbs" (also
called "atoms", "placeholders" or "field names") in the pretty and
ref-filter formats.

> Then I can research how
>    one format is implemented in 'pretty.c', and see how a similar thing u=
sing
>    the ref-filter is implemented in 'ref-filter.c'.

What will you learn from that and how will it help you for the next steps?

You call this section "Change code" but it looks like it's only about
researching things.

> 4. Recheck documents and run test scripts.
>    Necessary step to check the behavior of code.

We ask for tests and documentation to be part of the patches that are
sent, so writing documentation and tests and running tests should be
part of each coding step.

> * Benefits to Community
>
> I'm willing to stay around after the project. By that time, I will be in =
my
> second year without classes. And my tutor has an open mind about my reque=
st to
> involve in an open source project by now. Considering the subjective and
> objective conditions, I think there is a high possibility that I will sta=
y
> around.
>
> Particularly, I wish to be a co-mentor if I have the ability. There may b=
e some
> difficulties. But what I learn from my finite experience is that you shou=
ld not
> refuse something positive just because of the difficulties in the mind. A
> fresh new job may be difficult, but it can show me the possibilities of t=
he
> world, which means changing my mind.

Great!

[...]

> * Microproject
>
> t9700: modernize test scripts [5]
>
> The microproject patches have been merged. The merge info is as below:
>
> commit 8760a2b3c63478e8766b7ff45d798bd1be47f52d
> Merge: a2d2b5229e 509d3f5103
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Tue Feb 28 16:38:47 2023 -0800
>
>     Merge branch 'zy/t9700-style'
>
>     Test style fixes.
>
>     * zy/t9700-style:
>       t9700: modernize test scripts

Thanks for your work on that!

> * Plan

It's difficult to understand how this section is different from the
"Steps" section above. Maybe these two sections could be merged.

> ** Timeline and deliverables
>
> The official GSOC code time start from 05-29 to 08-28, which is 13 weeks.
> The period from 06-05 to 06~30 is near the end of the semester. There are=
 many
> classes for me. So I guess I may be not productive during this period.

Thanks for telling us about this in advance!

> I think it is a bit time-limited if I follow the official timeline. It se=
ems
> necessary to do some work in advance.

[...]

> 2. Write draft of documents and test scripts.
>  Period:
>   05-29 ~ 06-02
>   week 1
>  Tasks:
>   Based on the preparatory work, write drafts of doc and test.
>  Deliverables:
>   Drafts of documents and test scripts

See what I said above about the fact that a big part of this project
might not be about developing new features.

[...]

Best,
Christian.
