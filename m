Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF2C1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbeCXHnU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:43:20 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36160 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeCXHnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:20 -0400
Received: by mail-it0-f43.google.com with SMTP id c1-v6so5247574itj.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVtTje5pT8xpkLXp9ObjJch5uTKelcqXX0WqmfRbxNY=;
        b=RtI+xPQy5fBuiHbb80xwWtimHAQweJoVyvMdkG2Cu0Dn6A/Yukx4mGoPVLVTsqr3TJ
         xiROv8Hd4GvDqLl/o5dpT2jONkdom+ODOLSb/mhGC+dTCHhtid53YFp/2lDkZcJoKZtK
         6/CU2Sa4UriX4noLaOL6kAKHtEvdDyjdgJem2gMVEWFE9fsyFpxLIKJZGjstRBvKDaVa
         ikR6jN/Qv26SIooaj49HB9OJAr5+6x8i66pNi1nXNiWP/hdiOwIsNR+zh1Ck70WKV1ut
         afPyZR6ANHKArLGiD9du0k1GludWCvBwE/9kVIc8IP7hsxcOCHP4oxYxOv8RkTQJ7Tbg
         hyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVtTje5pT8xpkLXp9ObjJch5uTKelcqXX0WqmfRbxNY=;
        b=da1wLzY7yc8SFk6j/7510Vk/pt7TTWQn7fH6GV21NIXyaDc9fpuhy+HBZlrjpYvdmV
         sOgwzfD0zI6LFWbgFFhUJBBh5ozq5DjpeCFqlxZLs1I+Ub7t4rbmUOwoQMGxR37vuBu4
         VtTJDNzr67hSO5eK59kmbQSf0lpsLi8SfiRv6ndlKdIJNn20Y01B1TKVVqlxSyfvUwnr
         6S6jTluee/VCLDkTILvURvgMB1vkt5M6AHoq5G27VnHdz0E/YXt4zqB1LmUZwnV6M7ts
         qIo0t7h/I5iq/0N2zlYZvZjgQSRd3+wplXYHbKQmY2ibhThTkwhHiVPQaf6xP694KVtV
         slBA==
X-Gm-Message-State: AElRT7FO/yA5cCFKgSg73c0Gai/g3EJzdqz2yoe4Z0lgUsodDBVi9SfS
        ZfSl5Zj81RnmSsw95QH4q1M9uY+0EJlFg6HXZY8=
X-Google-Smtp-Source: AG47ELt6JMBQZWAXYh0NW9frgkuOZ2X1gjE8wZUu6kXfucChh+Lr/K+ud9s01Y98Jz8Lia8qSRd4eNWGqWjgWVja7oI=
X-Received: by 2002:a24:c00b:: with SMTP id u11-v6mr13438766itf.21.1521877399069;
 Sat, 24 Mar 2018 00:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 00:43:18 -0700 (PDT)
In-Reply-To: <ef8552ba-edb0-ea10-29fd-32152adbc992@gmail.com>
References: <2564070.6kGkNsz7Qa@andromeda> <ef8552ba-edb0-ea10-29fd-32152adbc992@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 08:43:18 +0100
Message-ID: <CAP8UFD0eU150p2puqdgkYQuZpZ8Yzxo9wMw2PAVUrwy+8zUZ2g@mail.gmail.com>
Subject: Re: [RFC][GSoC] Project proposal: convert interactive rebase to C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Mar 22, 2018 at 11:03 PM, Alban Gruin <alban.gruin@gmail.com> wrote=
:
> Hi,
>
> here is my second draft of my proposal. As last time, any feedback is
> welcome :)
>
> I did not write my phone number and address here for obvious reasons,
> but they will be in the =E2=80=9Cabout me=E2=80=9D section of the final p=
roposal.
>
> Apart from that, do you think there is something to add?

Please take a look at the comments that have been made on other's
proposal. Many proposals could be improved in the same way and it is a
bit annoying for us to repeat the same things many times.

[...]

> The goal of this project is to rewrite git-rebase--interactive in C
> as it has been discussed on the git mailing list[1], for multiple
> reasons :

In general when the project or some issues related to the project have
already been worked on or discussed on the mailing list, it is a good
thing to summarize those discussions and link to them in your
proposal. It shows that you want to take the time to gather existing
information, to understand that information and to take it into
account in your proposal, and it can also make your proposal easier to
read and understand.

More specifically your proposal has some links which is nice, but I
think it would be better if it summarized a bit more what the links
contain.

[...]

> Weeks 1 & 2 -- May 14, 2018 - May 27, 2018
> /From May 14 to 18, I have exams at the university, so I won=E2=80=99t be=
 able
> to work full time./
>
> I would search for edge cases not covered by current tests and write
> some if needed.
>
> Week 3 -- May 28, 2018 - June 3, 2018
> At the same time, I would refactor --preserve-merges in its own
> shell script (as described in Dscho=E2=80=99s email[1]), if it has
> not been deprecated or moved in the meantime.

Here for example it is better if we could get a better idea about how
you plan to do it without having to read Dscho's email.

> This operation is not
> really tricky by itself, as --preserve-merges is about only 50 lines
> of code into git_rebase__interactive().
>
> Weeks 4 to 7 -- May 4, 2018 - July 1, 2018
> Then, I would start to incrementally rewrite
> git-rebase--interactive.sh functions in C, and move them
> git-rebase--helper.c (as in commits 0cce4a2756[2] (rebase -i
> -x: add exec commands via the rebase--helper) and b903674b35[3]
> (bisect--helper: `is_expected_rev` & `check_expected_revs` shell
> function in C)).

I know what you mean but I would still appreciate if you could summarize it=
.

> There is a lot of functions into git-rebase--interactive.sh to
> rewrite. Most of them are small, and some of them are even wrappers
> for a single command (eg. is_merge_commit()), so they shouldn=E2=80=99t b=
e
> really problematic.
>
> A couple of them are quite long (eg. pick_one()), and will probably
> be even longer once rewritten in C due to the low-level nature of the
> language. They also tend to depend a lot on other smaller functions.
>
> The plan here would be to start rewriting the smaller functions when
> applicable (ie. they=E2=80=99re not a simple command wrapper) before
> working on the biggest of them.
>
> Week 8 -- July 2, 2018 - July 8, 2018
> When all majors functions from git-rebase--interactive.sh have been
> rewritten in C, I would retire the script in favor of a builtin.
>
> Weeks 9 & 10 -- July 9, 2018 - July 22, 2018
> I plan to spend theses two weeks to improve the code coverage where
> needed.
>
> Weeks 11 & 12 -- July 23, 2018 - August 5, 2018
> In the last two weeks, I would polish the code where needed, in order
> to improve its performance or to make it more readable.

We like to have big improvements be split into batches of patches,
also called patch series, and polishing of the first batches happening
as soon as possible so that they can be ready to be merged soon. The
patch series that are sent to the mailing list often need a number of
round of reviews and improvements which can take a long time, so it is
better if this process starts as soon as possible.

Thanks.
