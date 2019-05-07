Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0481F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfEGP0b (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:26:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47093 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGP0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:26:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so19083355edb.13
        for <git@vger.kernel.org>; Tue, 07 May 2019 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Qpnfp8eT0B58BKsa83h7ZFqxFNYksuylL/nLor6UwFE=;
        b=nv//5oBpXYYzmgmSa8YeqVQf+aZ0JDIYP3F52T4GZcSXNqs9410FIW1dj0osPWImNm
         7MAdRHw9tQqx6PJG+gHH2skoQrSqado+38c1Sns+BlxN7M28B1cw4qnsvX57NK5p5j33
         JuqTQFQQIDRwN/Cp6UVeYIojN0PmvRzH9R020xHsQoU168Yjs9ZBjZig/+nlWsfThR69
         +xZjEI/3BEceXXh/V/LdmCNTzr3+HQp7+iQetsXVw591hwcNSOeqSpxpoM7kaQB4t6Aq
         XEmtteGusgBom2BsZgGlKPZTXAwUwAT1MIiMXo+ewqzR8RZRbIA35wf+ka3HtQjmYjQ5
         kDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Qpnfp8eT0B58BKsa83h7ZFqxFNYksuylL/nLor6UwFE=;
        b=if95ONHH+vxXvz/eJBjKIOym97s6RBNBy4RuPdrizB9z8ZQdfgz+qYgGeTJ8NfOy6o
         qQC9+kPDZ0qlQvx8Y2iPqlE1MWqLKWt6NQuFb6vCzkRQ4vK1hnW4HTuk0r6RuHFtowSi
         N6VIMDzRYxUqbt+Ql8vlzqFgUBtnq8DMsAeqCI1ZkjgHzzkzK6EC1eK19Xtre/V/BbLn
         NFAI9UpCxsiCHpE+XPuJS3HBttZC1rjSZJvTpEXCph+S7pk6gUkAyzBKfRN54CF9WS0i
         N7J4SPB4tSdPWXMz8qM8Qh1WF4ZbIfi9AyO+O5JoYpc6NV1OgFXK6GLKhhbokVInP0l1
         KYCw==
X-Gm-Message-State: APjAAAVzOWHpJ/WT7rEofvmqbLGiDxGDvb/XdcEQwvBZxRSQEP5trvGE
        g534XKTQro0Bb36H+2rGU5ZHNdeeJ98=
X-Google-Smtp-Source: APXvYqxuF9Xd/KeXecbJWo1ZgH1s8mjK5j1Egiebq9c3Me9lVgfH3MEig3H4kOc3uSDXCo1DmWLirQ==
X-Received: by 2002:a17:906:3fca:: with SMTP id k10mr25082374ejj.126.1557242788498;
        Tue, 07 May 2019 08:26:28 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id q24sm2242276ejr.44.2019.05.07.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 08:26:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Eckhard =?utf-8?Q?Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: Re: Merge commit diff results are confusing and inconsistent
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com> <20190503191231.GA5426@esm> <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com> <874l67i1ie.fsf@evledraar.gmail.com> <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
Date:   Tue, 07 May 2019 17:26:25 +0200
Message-ID: <87woj2guam.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 07 2019, Robert Dailey wrote:

> On Mon, May 6, 2019 at 6:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> Maybe an example helps, let's say you have two paint buckets, one with
>> red paint, one with yellow paint. You mix them. What happens?
>>
>>     (
>>         rm -rf /tmp/git &&
>>         git init /tmp/git &&
>>         cd /tmp/git &&
>>         git checkout -b red &&
>>
>>         echo red >color.txt &&
>>         git add color.txt &&
>>         git commit -m"red" &&
>>
>>         git checkout --orphan green &&
>>         git reset --hard &&
>>         echo green >color.txt &&
>>         git add color.txt &&
>>         git commit -m"green" &&
>>
>>         git merge --allow-unrelated-histories red;
>>         echo yellow >color.txt &&
>>         git add color.txt &&
>>         git commit -m"red + green =3D yellow"
>>     )
>>
>> I *think* what you're alluding to is trying to discover some sort of
>> change to whatever the default merge resolution would have been, which
>> in this case would be closer to:
>>
>>     (echo green && echo red) >color.txt
>>
>> But it's important to understand that the whole business of suggesting
>> how you should merge is just sugar that isn't in any way represented in
>> the object model that makes it into the repository.
>>
>> In that model we just had one branch with "color.txt" containing "red",
>> and another with "green". Then we merged the two together and that
>> commit merged two histories together, did something to yield an end
>> result, and now the "color.txt" file contains "yellow".
>>
>> But what single thing can you look at to describe how you ended up with
>> "yellow"? There isn't such a single thing, I just know that I have a
>> commit with two parents:
>>
>>     $ git cat-file -p HEAD
>>     tree 6318a50d67e6de533498a4a0c9f46360cff6908a
>>     parent 2332fc6b40c1cbf9f5daf809f09eb4defdd2ce30
>>     parent 1707f13d2d236d61ac7496962ecebc50ffff5be3
>>
>> And that if I diff against the 1st parent we went from green to yellow:
>>
>>     $ git diff HEAD^1..HEAD
>>     diff --git a/color.txt b/color.txt
>>     index a5b73ed..d1ed081 100644
>>     --- a/color.txt
>>     +++ b/color.txt
>>     @@ -1 +1 @@
>>     -green
>>     +yellow
>>
>> And the other from red to yellow:
>>
>>     $ git diff HEAD^2..HEAD
>>     diff --git a/color.txt b/color.txt
>>     index a9d1386..d1ed081 100644
>>     --- a/color.txt
>>     +++ b/color.txt
>>     @@ -1 +1 @@
>>     -red
>>     +yellow
>>
>> To the extent that we can show a single diff at all that's diff-tree's
>> --cc option:
>>
>>     $ git diff-tree --cc HEAD
>>     e89ef1f780d7c979c18cc0f03fd74c560466ef03
>>     diff --cc color.txt
>>     index a5b73ed,a9d1386..d1ed081
>>     --- a/color.txt
>>     +++ b/color.txt
>>     @@@ -1,1 -1,1 +1,1 @@@
>>     - green
>>      -red
>>     ++yellow
>>
>> Sometimes it makes things better, sometimes it's just more
>> confusing. It's what "git show" will use to render merge commits.

First, to update my example this is bette (I was being overly clever
with the unrelated histories):

    (
        rm -rf /tmp/git &&
        git init /tmp/git &&
        cd /tmp/git &&

	>color.txt &&
        git add color.txt &&
        git commit -m"base version" &&
        git tag base &&

        git checkout -b red base &&
        echo red >color.txt &&
        git add color.txt &&
        git commit -m"red" &&

        git checkout -b green base &&
        echo green >color.txt &&
        git add color.txt &&
        git commit -m"green" &&

        git checkout master &&
        git merge red green;
        echo yellow >color.txt &&
        git add color.txt &&
        echo hello >README.txt &&
        git add README.txt &&
        git commit -m"red + green =3D yellow"
    )


> Your example is very helpful. I understand what you're saying for
> conflicted lines. But the "whatever the default merge resolution would
> have been" doesn't exist, because there's no reality where line 1 in
> color.txt can be something "automatic" (i.e. deduced by git). The only
> reality for the merge commit is some hand-edited replacement to line
> 1. So there is no "diff what I see with some alternate reality".
>
> The majority use case I'm interested in is seeing net-positive changes
> that happen in merge commits. Normally I take for granted that merge
> commits have nothing meaningful in them (meaningful here defined as
> something unexpected for a merge commit). But what if someone makes a
> poor decision and does some crazy refactoring in 1 file and amends it
> into a merge commit? Let's also say that these changes are done to a
> file that wasn't modified in any parent (say a unrelated.txt next to
> your color.txt). Since neither parent cares about that file for the
> purposes of the merge, I am trying to make sense of a revision
> specification that can be used to see what they did to that file.

To clarify, by "doesn't exist" I mean in the sense of the underlying
object model. I.e. it's conceivable to think of an SCM that would store
what it thought was the merge resolution, followed by a diff from the
user on top.

You could even emulate that in git by having a policy of committing the
unsolved merge resolution followed by the "real" solution, but that's
not how anyone uses it.

That doesn't mean you can't get what you want, notice how in my updated
example I've sneakily put a new README.txt into the merge commit. Now
after that merge let's see what merge-tree would do given the two
un-merged tips (conflict):

    $ git merge-tree base HEAD^1 HEAD^2
    changed in both
      base   100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 color.txt
      our    100644 a9d1386a1d99728de010ad4044fb984886b57f33 color.txt
      their  100644 a5b73ed2e94dafd12d02ab7b3ba3506cf8e642a2 color.txt
    @@ -1 +1,5 @@
    +<<<<<<< .our
     red
    +=3D=3D=3D=3D=3D=3D=3D
    +green
    +>>>>>>> .their

v.s. what diff-tree --cc reports:

    $ git diff-tree --cc HEAD
    b6e4d986d8850a2465fd5e648c670865bba59c05
    diff --cc README.txt
    index 0000000,0000000..ce01362
    new file mode 100644
    --- /dev/null
    +++ b/README.txt
    @@@ -1,0 -1,0 +1,1 @@@
    ++hello
    diff --cc color.txt
    index a9d1386,a5b73ed..d1ed081
    --- a/color.txt
    +++ b/color.txt
    @@@ -1,1 -1,1 +1,1 @@@
    - red
     -green
    ++yellow

There's no reason we couldn't learn some mode where we walk the history
and report differences like that, but note that the "what would I get if
I merged" plumbing in git is still rather bad/incomplete in some areas,
and also changes between versions of Git.

E.g. Elijah Newren has been working on better rename detection recently,
if you ran some version of that merge-tree (or however it's exposed, I'm
not very familiar with this area) you'd get a "danger Will Robinson,
manually munged merge!", even though it was a straightforward resolution
of the suggested merge, and git's merge heuristics had just changed
between versions.

> Even ignoring that issue, the more concerning observation of mine is
> that `diff @^!` produces any output at all. If you exclude both
> parents, why do I see a diff for parent 2 (I see the complete diff of
> the branch that was merged in)?

I'm not sure, but I think this has to do with "diff" only taking two
endpoints, see its manpage. It's curious that when I feed just the first
two in manually I get the same as when it's passed to git-diff directly:

    $ git diff -p @^!
    diff --git a/README.txt b/README.txt
    new file mode 100644
    index 0000000..ce01362
    --- /dev/null
    +++ b/README.txt
    @@ -0,0 +1 @@
    +hello
    diff --git a/color.txt b/color.txt
    index a9d1386..d1ed081 100644
    --- a/color.txt
    +++ b/color.txt
    @@ -1 +1 @@
    -red
    +yellow
    $ git diff -p $(git rev-parse '@^!' | head -n 2)
    diff --git a/README.txt b/README.txt
    new file mode 100644
    index 0000000..ce01362
    --- /dev/null
    +++ b/README.txt
    @@ -0,0 +1 @@
    +hello
    diff --git a/color.txt b/color.txt
    index a9d1386..d1ed081 100644
    --- a/color.txt
    +++ b/color.txt
    @@ -1 +1 @@
    -red
    +yellow

But feeding all three into it gives output similar to --cc:

    $ git diff -p $(git rev-parse '@^!')
    diff --cc README.txt
    index 0000000,0000000..ce01362
    new file mode 100644
    --- /dev/null
    +++ b/README.txt
    @@@ -1,0 -1,0 +1,1 @@@
    ++hello
    diff --cc color.txt
    index a9d1386,a5b73ed..d1ed081
    --- a/color.txt
    +++ b/color.txt
    @@@ -1,1 -1,1 +1,1 @@@
    - red
     -green
    ++yellow

I don't know. I spent a while looking into this a while ago and then
paged it out of my brain :)

To reply to your downthread follow-up. The --cc mode won't work on all
commits due to what it's doing, but works on e.g. the merge commit
produced by my sample history.

> Again, thank you for your example, you definitely made things very
> clear for me. I see where the confusion is. And I think --cc is a good
> way to get more context. At this point I'm just concerned about the
> @^! behavior with merge commits & diff.
