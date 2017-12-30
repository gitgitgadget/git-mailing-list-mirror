Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25E71F428
	for <e@80x24.org>; Sat, 30 Dec 2017 23:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdL3XBF (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 18:01:05 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:39750 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdL3XBE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 18:01:04 -0500
Received: by mail-it0-f53.google.com with SMTP id 68so34668419ite.4
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 15:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RkDsVlS9DZUShmIkbt5UXXZY17pp+RtdN8myyFVu45Y=;
        b=OuUL3mEnjVPTWDoTej6wEqyXopeEL2VZzuUTY3T/RrniYbSJ2PlgxsX42afd+SnARd
         3mn1naDmrHxD+5cLopfPuYGzV7WqwS+czud0eoABPhdb0G8z7Ok+iDqXqcXZ7vSAxzSU
         tcsx2VQzYTMRkZOh2BQBMgOEA13zGCpXScierBHbXYsTuPzJNj10ijOu253vL9/lpm/E
         qTa6JWd1z4XDnWTsMOXAZbrCdjA1Lm+nUc8RdS5A33gaS8zRjp14TeE5SFJXfL/TiaWX
         bbjKhzssqB1tQnI6iJb951qqN5+LduY4BZuWLmae0U8BaNY//XPEVxwsxW6PehUWUMV2
         KMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RkDsVlS9DZUShmIkbt5UXXZY17pp+RtdN8myyFVu45Y=;
        b=rFUXrf38ry+Bnt0fqzgnie74DoZH0YGg2SNfVjF/sdffzh3uGxc/oA6nqZg3Nr5FKG
         df3ouLTr4dqnTZBhK30oCF/tl5b/ZNof0CoZVnBtUNzCs+SsFOhd0+3K1Gs4E93bkYPz
         L7UwC6oyGc5nl63d2VRhlne1/uXDKR5gBzT+nxPBVEWpauUUuzw7MdVwBn2+Lh3riOxM
         bcrohtw1oLbR4IK6RCONGxnQSvoEB6IkqV6RG3zd/cc/ck7nhbAlvrK/SWU7eE/l1qnp
         XQaOa5ctEMnw5fUmtdeHXbsiv15zQcq8+jZeigSoXDhZl3UWpCiwA53BjTBfOwqXjZiP
         t5yw==
X-Gm-Message-State: AKGB3mJQ7MwJjLa7GRRkUqobN5anze+chIzAaB2STYdvzv45zSEeOa9a
        VPBW5IsXNeHaklF/0ATxIkxlgZxjIk8UtjxM4HM=
X-Google-Smtp-Source: ACJfBouxMe6YB6Q2JIndUqzRzofHGEiEH8KMxKKMmOCybiJXYMc/dWe9yh7zvKCcml4GpQhTyElz/k1JGiGLxknbBRQ=
X-Received: by 10.36.124.197 with SMTP id a188mr50652791itd.63.1514674863233;
 Sat, 30 Dec 2017 15:01:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 30 Dec 2017 15:01:02 -0800 (PST)
In-Reply-To: <20171230181557.GA30351@sigill.intra.peff.net>
References: <87zi616vgf.fsf@evledraar.gmail.com> <20171229225121.13805-1-avarab@gmail.com>
 <20171229231631.GS3693@zaya.teonanacatl.net> <20171230015533.GA27130@sigill.intra.peff.net>
 <87tvw875vh.fsf@evledraar.gmail.com> <20171230144505.GA29252@sigill.intra.peff.net>
 <87po6w6yul.fsf@evledraar.gmail.com> <20171230181557.GA30351@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 31 Dec 2017 00:01:02 +0100
Message-ID: <CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Zefram <zefram@fysh.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 30, 2017 at 7:15 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Dec 30, 2017 at 04:04:50PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I do like the idea of using "show", though. We know the point is to sh=
ow
>> > the output to the user, so we don't mind at all if the behavior or
>> > output of show changes in future versions (unless we consider the fina=
l
>> > output of bisect to be machine-readable, but I certainly don't).

I think that the first line that gives the sha1 of the first bad
commit (XXX is the first bad commit) should be machine-readable,
because there have been people writing scripts on top of git bisect.
Below that I am ok if it is more fancy, especially because it looks
like it already used some coloring.

>> Not knowing the internal APIs for that well, is this basically a matter
>> of copy/pasting (or factoring out into a function), some of this:
>>
>>     git grep -W cmd_show -- builtin/log.c
>>
>> I.e. boilerplate + calling cmd_log_walk() to yield a result similar to
>> e22278c0a0 ("bisect: display first bad commit without forking a new
>> process", 2009-05-28).
>>
>> Or is it preferred to just fake up argc/argv and call cmd_show()
>> directly? I haven't seen many examples of that in the codebase:
>>
>>     git grep -W '(return|=3D)\s*cmd.*argc' -- '*.c'
>>
>> But I don't see why it wouldn't work, the cmd_show() doesn't call exit()
>> itself, and we're right about to call exit anyway when our current
>> diff-tree invocation is called.
>
> Hmm, I just assumed we were actually calling diff-tree. But looking at
> that code in bisect, it literally is calling log_tree_commit(), which is
> the same thing that git-show is doing.

Nice. This means that we should be able to make small changes to move
from a diff-tree like output to a show like output.

> So yet another option is to just set up our options similarly:
>
> diff --git a/bisect.c b/bisect.c
> index 0fca17c02b..1eadecd42a 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -893,9 +893,11 @@ static void show_diff_tree(const char *prefix, struc=
t commit *commit)
>
>         /* diff-tree init */
>         init_revisions(&opt, prefix);
> -       git_config(git_diff_basic_config, NULL); /* no "diff" UI options =
*/
> +       git_config(git_diff_ui_config, NULL);
>         opt.abbrev =3D 0;
>         opt.diff =3D 1;
> +       opt.combine_merges =3D 1;
> +       opt.dense_combined_merges =3D 1;
>
>         /* This is what "--pretty" does */
>         opt.verbose_header =3D 1;

I am ok with that kind of changes.

> Though I do kind of like the idea of just delegating to git-show.
> There's no real need for us to have our own logic.

I don't think there is a lot of logic in the above. We are mostly just
setting parameters before calling setup_revisions() and
log_tree_commit().

If we think that the above is too much "logic", then we should
probably try to refactor the revision walking interface to make it
simpler, so that not as much "logic" is needed to call it. If this
succeeds, then this could help simplify a lot of things throughout the
code base.

> I think calling cmd_show() from bisect.c is supposed to be forbidden
> (library code shouldn't call up to builtin code). I was going to suggest
> just using run_command() to call git-show. After all, we do this only
> once at the very end of the bisection (which is pretty heavy-weight, as
> it surely has forked a lot of processes to do the actual testing).
>
> But that would be directly undoing Christian's e22278c0a0 (bisect:
> display first bad commit without forking a new process, 2009-05-28). I'm
> of the opinion that would be OK, but maybe Christian has input. :)

In general I am against adding forks that are not necessary and not
specially useful, as they don't perform well on some platforms or some
machines (like big servers where new processes tend to be allocated to
a different CPU).

I know that in this case it happens only once after usually a lot of
processing and forking, but I don't think it gives a good example and
goes in the right direction.

Yes, it looks ugly to have 10 or 20 lines of code to just set
parameters for setup_revisions() and log_tree_commit(), and yes I
don't like the revision walking interface, but I think this is a
different problem that we should take care of separately.

Thanks for working on this.
