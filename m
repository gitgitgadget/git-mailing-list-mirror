Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF923201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 14:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdKLOWA (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 09:22:00 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:54766 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdKLOV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 09:21:59 -0500
Received: by mail-io0-f181.google.com with SMTP id w127so598780iow.11
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZE9pDWP/oTZjWQIdhxDW9jM0b08LpNRUQfsIqvTv7oA=;
        b=Ki0O8Nm3S6iayWJ6wA0x7EquXt49CBfRO6X9KIBYyH7X6uyvK+/Pefv4dZkwMwbm2w
         pBMwBf8BjiHT50tKawSsylr/E8z6ZNU8GmwqWaGKHa1MGryNXG69g3hYYRf2ZZ7kSqWB
         V+8gzfUGxuHCk3VW32IsKfDYB52LVMsSCUyRWAU6bNNnUXussLajpsW3VFLb1nsLyGtb
         svwVfGNcZ7eu6ZZ+4S+YHawryOatVnfEva9j0lNm+Rta6MErqisFbujOPyZruurGDbrc
         90GblgsU0hZ75bZlOkNJnexuRD5jPBaUGe9+JTN9Tus/t+4+NCcGI0iS2niYInOUU5iv
         fEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZE9pDWP/oTZjWQIdhxDW9jM0b08LpNRUQfsIqvTv7oA=;
        b=afgXAQB+BT86kdUhmMDMyX/mVSTVMfU8L7LclDmijnuTsa1Gmma24scYqSQoO/AxNo
         svenFDuLJm7Txsu3L94MkONXP2zPbo3oUVCmJkBYlLvgtoRMwxcDu1yImv5JuzAaPpiq
         JySsHwRe+P9u4xNlYvn0kfdDw/MWw0V5XbwoY0VLfu2RXeyvPeJ/ThO6j4gGYq1nWpX+
         QOUDtSsaepFhabgsbinuqiZuwjElUDAcyw2j1jblDlnP9+SVU16sC+S3QsDYsP6jBX/V
         xMo3ygTn4R6ucCXfNnhQclJT7BaFzE44nXMM5AOkLjHEZEfSZRMlK/BRJzWme/88U3R9
         mXug==
X-Gm-Message-State: AJaThX47Ih18T4iKZKEti8kManogGp3AyrUfrFnNhxy1JF6K27z8k4Ks
        UouDUuP6Y+LkGxW6wRt3vX4wobWF9jRq2LFTVLk=
X-Google-Smtp-Source: AGs4zMbGVhkmYz1Yx5KpKYb3Aye8FIbsaiffoWXg4dxczjw1mLaFdRqbCZOXqqGCWAfELlULltUQy+cRSbcrsaa+Vp8=
X-Received: by 10.107.111.14 with SMTP id k14mr6283678ioc.282.1510496518548;
 Sun, 12 Nov 2017 06:21:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 12 Nov 2017 06:21:57 -0800 (PST)
In-Reply-To: <xmqqvaigclv0.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
 <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
 <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com> <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
 <xmqqvaigclv0.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 12 Nov 2017 15:21:57 +0100
Message-ID: <CAP8UFD3DzdTf6-yZVwMvc1=nP+ejrinjvE8wAPhdaHoOQOmpGw@mail.gmail.com>
Subject: Re: should "git bisect" support "git bisect next?"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 2:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Theodore Ts'o <tytso@mit.edu> writes:
>
>> On Sat, Nov 11, 2017 at 11:38:23PM +0900, Junio C Hamano wrote:
>>>
>>> Thanks for saving me time to explain why 'next' is still a very
>>> important command but the end users do not actually need to be
>>> strongly aware of it, because most commands automatically invokes it
>>> as their final step due to the importance of what it does ;-)
>>
>> This reminds me; is there a way to suppress it because I'm about to
>> give a large set of good and bit commits (perhaps because I'm
>> replaying part of a git biset log, minus one or two lines that are
>> suspected of being bogus thanks to flaky reproduction), and so there's
>> no point having git bisect figure the "next" commit to try until I'm
>> done giving it a list of good/bad commits?
>
> It is surprising that I've never heard of this idea, but I think
> that it is an excellent one.
>
> When the user knows what bad and good commits in what sequence will
> be fed to the command (i.e. replaying a saved output of "git bisect
> log"), ideally we would want to "plug" the auto-next processing, and
> just mark good and bad in refs/bisect/* without doing anything other
> than creating these refs, and then run a "next" before giving the
> control back to present the final working tree to be tested by the
> user.  That would save the cost of intermediate checkouts but also
> the cost of extra merge-base computation that is done to catch the
> case where the user gave a good commit that is an ancestor of a bad
> commit by mistake.

Yeah I agree that it might be something interesting for the user to do.
But in this case the sequence in which you give the good and the bad
commits is not important.
Only the last bad commit and the set of good commits that were given
are important.

If you can get that and pass it to 'git bisect start' then you will
avoid all the intermediate computation and actually start from the
state you want.

> I think that the output of "git bisect log" was designed to be just
> an executable shell script that the user can edit (the edit is
> mostly designed to make it possible: "I know I screwed up in this
> step, so I change its 'bad' to 'good' and remove the remaining
> lines") and just execute it.  Which makes the simplest approach that
> would first come to my mind not work very well, unfortunately.
>
>         The "simplest approach" would teach the "--no-autonext"
>         option to "git bisect good" and "git bisect bad" and skip
>         the call to bisect_auto_next in bisect_state when it is
>         given.  Then update the output from "git bisect log" to add
>         that option to all good/bad commands, and then add an
>         explicit "git bisect next" at the end.  This won't work well
>         because it is likely that with the "remove the remaining
>         lines" step, it is likely that the user would remove the
>         final "bisect next".
>
> A workable alternative approach is to teach "git bisect replay" to
> be more intelligent.  Right now, I do not think it does anything
> more than what happens by an execution of the input file with a
> shell, but "replay" should be able to read a single step ahead in
> the command sequence while doing its step-by-step execution, and
> when it notices that it is about to run "bisect good" or "bisect
> bad", and if the command to be run after that is also one of these
> two, it can decide to skip the auto-next processing in the current
> step.  It shouldn't need any new "--no-auto-next" option (I am not
> saying that adding the option is bad--in fact, I think it is a good
> addition for expert users; I am just saying that the approach to
> make "replay" smarter does not require it).

To automate that one could start with a dirty oneliner like this:

git bisect start $(git bisect log | perl -ne '$b = $1 if m/# bad:
\[(.*)\]/; push @g, $1 if m/# good: \[(.*)\]/; END { print $b . " ".
join(" ", @g) . "\n"; }')

So yeah we could add an option to "git replay" that would do that.
