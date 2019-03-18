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
	by dcvr.yhbt.net (Postfix) with ESMTP id B0EDB20248
	for <e@80x24.org>; Mon, 18 Mar 2019 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCRTHO (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 15:07:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCRTHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 15:07:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so18327463wre.10
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vk/OzqstJDTCynDLthBzCwQNDmlf+ZUJ/SFYvfvD4Ho=;
        b=LuuycifBT45Zy15zpLx2dWm57kea61XAWKUeyYbylniHNh5IvcpweWrRWtaUZENsgZ
         MiTpdcDCoOGq8EWLKHUPJekel9CUKtlRJqbGeZTSyDpRC3tjWYIBVCpurBPDE9Hdfp9E
         hqfK9dKh9BdfBmhWBArBH7uoVDHF8lyWtmFRgmR1Jc4I2sKS5k3F7aDyfxP5lKJDW93v
         s0szIpJMd94yZShCReDxr1EdZFQaxJcTVdmPLErYtWIj89s6hH46S1oI+EOD3GIDeZnr
         bd2zPw465PECd97wpK3PeKf870IqQAjFTVOn7q3rutqzj6e+E01hUOvJ5PZRoTwXGDlg
         nbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vk/OzqstJDTCynDLthBzCwQNDmlf+ZUJ/SFYvfvD4Ho=;
        b=IPgx65GEqagFjAo0h3DhJr1UPUI69JvZwPunWAlEqyNOZ5yhrGm2O6dGpu9sdxMxKB
         yTnEaQA6JkwnJ6+KZzWDxwMJHoJdd0RfMbUXwngxESBr4sNpcb8vhQ3dRHOC6Voce4NF
         IeP17RJvgTmhzcNqnVZ1Y3YiItXcyJ5s9sG2qOWOO1YPTzWT91hXWs/5/3qe1blKuagR
         4CvQQUqvNY22iTZgIEOtcfp4wYhEeRQfjRBvvMe4fj+HS5GN+vfXDd4Fx8HWigBVa/B/
         2G+fzYpUXKJIywNFnkEIb4qc/vWpohPPhw2X1cRAFGuoxbj9BLKaI47jyqnk5LKnULFa
         XUYg==
X-Gm-Message-State: APjAAAWcc+/O7/YUFOmeCIuieE/MTfOvpqNsuLuNiZBXS5vX45FUXcS0
        7Peg1+iEjlEMUKYRXijSF/f4a+83Uk8=
X-Google-Smtp-Source: APXvYqyOUEUQ3+520/lr+gRbI+flfSSH18D1HldPXVskJzubSaMmnwjlqPDS2233H896YiPxK6eOnQ==
X-Received: by 2002:adf:b64d:: with SMTP id i13mr13393440wre.292.1552936031707;
        Mon, 18 Mar 2019 12:07:11 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z6sm211603wml.40.2019.03.18.12.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 12:07:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com> <87multaaac.fsf@evledraar.gmail.com> <CABPp-BGijBpyV9n4VxNi3QCddO-_4B-E1TUTi8wiqjQmqpU+Nw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABPp-BGijBpyV9n4VxNi3QCddO-_4B-E1TUTi8wiqjQmqpU+Nw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 20:07:09 +0100
Message-ID: <87mulsdmsi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Elijah Newren wrote:

> On Sun, Mar 17, 2019 at 6:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Sun, Mar 17 2019, Denton Liu wrote:
>>
>> > diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
>> > index 72179d993c..10c7a2220c 100644
>> > --- a/Documentation/git-diff.txt
>> > +++ b/Documentation/git-diff.txt
>> > @@ -63,7 +63,11 @@ two blob objects, or changes between two files on d=
isk.
>> >
>> >  'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
>> >
>> > -     This is synonymous to the previous form.  If <commit> on
>> > +     This is synonymous to the previous form.  However,
>> > +     users should prefer the previous form over this form
>> > +     as this form may be more confusing due to the same
>> > +     notation having a logically conflicting meaning in
>> > +     linkgit:git-rev-list[1]-ish commands.  If <commit> on
>> >       one side is omitted, it will have the same effect as
>> >       using HEAD instead.
>>
>> I think we're better off just consistently recommending "A..B" instead
>> of "A B" and "fixing" any occurrence of the latter to the
>> former. I.e. not taking this patch & going in the other direction.
>>
>> As noted in the thread you linked we'll always need ".." when one side
>> is "HEAD" implicitly, and that's a really common case.
>
> By "really common" do you simply mean it is used by enough people that
> it should be supported, or are you trying to claim something about
> it's relative usage compared to "diff A B"?
>
>> So as confusing as the whole ".." v.s. "..." is in diff v.s. log I think
>> we're worse off with "A B", since we'll *still* need to document the
>> likes of "A.." and how that differs from log "A.." or "A...".
>>
>> So sometimes using the whitespace form for two revs and then the ".."
>> when we just have one side makes things more confusing, not less. The
>> reader will be left having to juggle more complexity in their head, not
>> less.
>
> Here I think you are implying that "A.." or "..A" is somehow on a
> similar magnitude of usage as "A B".  Is that accurate?  If that
> reflected real-world usage, I would be more inclined to agree with
> your course of action, but I can't fathom them having similar usage
> rates.  Personally, I don't think I've ever seen any user use "A.." or
> "..A" (well, except me), and only rarely even use "A..B"; with users I
> have worked with and supported and taught, I'd guess "diff A B" is
> used far more (at least an order of magnitude more) than any other
> form, and that only some of them and only occasionally want to use
> anything else, such as diffing against a merge base.
>
> This whole topic came up again, IMO, because for the occasional
> usecase of diffing against a merge-base, people's intuition leads them
> to '..' instead of '...', and we wanted to fix or help avoid that
> problem.  To me, your solution sounds like you want to instead embrace
> the confusion: force people to deal with it early and often so that
> they become trained on it and can articulate the differences between
> '..' and '...' for both diff and log.  Is that accurate, or am I
> misunderstanding/mis-stating your strategy?

Some of this thread's confusing, and on re-reading I see my reply hasn't
helped much.

To clarify. There's at least these things to consider:

1. What should the semantics of .. or ... be?
2. What semantics (regardless of syntax) should we recommend for common cas=
es?
3. Depending on #1 and #2, can we make our docs less confusing?

My opinion:

1. I'd ideally like to switch the semantics of ".." and "...". I don't
   think anyone argues that it would be a bad thing in theory if we'd
   started out that way, Whether it's worth switching now is another
   matter.

   Junio chimed in in <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>
   saying he's not for it, so I'm assuming it's out for now.

2. I agree that we should generally recommend what's now "..." instead
   of "..", whatever the syntax is to invoke that.

3. And now, coming to the point I was trying to make. Assuming we'd like
   to go for #2 as I noted, and switching them around as in #1 is a
   no-go, what syntax should we prefer for "X..Z", aka. "X Y"?

   I think to reduce doc confusion we'd be better of using ".."
   consistently over the whitespace form, since we're going to need to
   show diffs with HEAD on one side. Using either "@" or "HEAD" there is
   more verbose.

   So yeah, I guess I am in a narrow sense advocating for embracing the
   confusion. I'd rather not have it in the first place, but since we
   seem stuck with it let's at least stick with and recommend *one*
   syntax for that confusion, and pick the one we can consistently use
   for 100% of our examples.

Anecdotally I've seen ".." in all forms be *way* more common among
users, even though if you sat them down and explained to them what it
does v.s. "..." they'd usually say they wanted the latter.

I did some brief scraping of .bash_history on one of our big shared
servers just now that has a lot of users (100-200) using git for daily
development. I've got many pages of things like "@{u}..",
"<tag1>..<tag2>", "<rev>.. -- <path>" etc. against just a couple of uses
of "...". The "<rev1> <rev2>" form gets a bit of use, but maybe 1/2 of
"..".
