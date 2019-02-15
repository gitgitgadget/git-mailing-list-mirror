Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1A91F453
	for <e@80x24.org>; Fri, 15 Feb 2019 16:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfBOQJv (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 11:09:51 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39376 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbfBOQJr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 11:09:47 -0500
Received: by mail-vs1-f65.google.com with SMTP id e16so6090441vsq.6
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ptpj9b/pap4ORHRBMfWLoU7qhQ3wbYdHC8HaEM2yPA=;
        b=PO8VTdbv6T67sVp8lg2qZdN2O56beU+2HFuA0d3il101bfvK/hbzfiisUEQljDmvLp
         vbNUlOuxeXjT7UBmIoicO3HVDLeye9pAzchFCYOCGmBeEjUScgyU62M9yqtCcR8DnBBC
         Zzs8J5OrsC7QK9uuU4dejgqEpwSLfBp0rzvLNALxX0GytbMno0+qGMuFMEkkpInqiZzf
         MqmGc31ZdZMUTaCW++9Ue/zQlsE6+TbKiz3XoMaKGwuNsXHDzLxLK6UXxzK74VCdyrAV
         HdrzJPUv3ZqJKlb+I4uOPvxaJ8iiuMgg9eaUDgpQzfHPZGjzXVr9lJ2kRNOkg/ceYOvy
         fqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ptpj9b/pap4ORHRBMfWLoU7qhQ3wbYdHC8HaEM2yPA=;
        b=AWzeuDrsijdVwQwz5qkK0Df7AZdwHGNBWznBHhn+mCaRfW6bda4l+iVHNNR67YpqZ2
         Mm+p+UxMIMlyPkwITCwmC3XcYJQf1FDPosrVO9cTRoRXlTmABJZ+s0ldGi9+ydpoN5Zm
         UNZ98A+4WSGzXYjpX/M6vAUqVlUppKgHQwElfL3JjlxU5uN3sj5w59M/8wxHJDeTFjfT
         QzQUo/Aa6h+pKjw4isPOhtxdyUe4XDpeHKo5FMydqw/otqPaIMgQ7tkkZaHcIXEgS0VO
         mJ1eGYvnVEj58cJ2RAkY/tQDgCfdQftVUI34606HYQfdgNTcHrVNfm0tJETpp0+U5FpN
         xJ+w==
X-Gm-Message-State: AHQUAuZ1MookmsLP3wzQsJBuH4pUBIFfRo50/aUfOnvZeUOTlo2QJEWL
        vcjSZLaoefg+jCYKEIzmh05sBmuUR3yaUOCpsZo=
X-Google-Smtp-Source: AHgI3IbrlRR8Nx+cb/13T2fezNnP5vEE8RnBSi1vOfB42Ef9+PWcSo9hWb0k7ChhzH3bY2ICMKSCunIp/QSQ68oHd80=
X-Received: by 2002:a67:e908:: with SMTP id c8mr5266939vso.116.1550246985831;
 Fri, 15 Feb 2019 08:09:45 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
 <20190215064013.s7yfkmfvfmwfmepc@vireshk-i7>
In-Reply-To: <20190215064013.s7yfkmfvfmwfmepc@vireshk-i7>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Feb 2019 08:09:33 -0800
Message-ID: <CABPp-BFpj8DBxgsqe9Rqnzb4vx5fPqNc+sUj8LzrFMj2bacoBQ@mail.gmail.com>
Subject: Re: [Bug report] git diff stat shows unrelated diff
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Viresh,

On Thu, Feb 14, 2019 at 10:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-02-19, 13:23, Elijah Newren wrote:
> > I think you're getting tripped up by double-dot vs triple-dot with
> > diff being different than log:
> >
> > `git diff D..E` means the same thing as `git diff D E`, i.e. diff the
> > two commits D and E.
>
> Right, so both the branches have at least until rc2 (though
> pm/linux-next had until rc6), why will the diff D..E show the diff
> between rc1 and rc2 ?

I don't think it does; it includes the diff between rc2 and rc6.
First, `git diff D..E` will show you roughly the same thing as if you
have two clones of linux, one with D checked out, one with E checked
out, and then you run 'diff -ru linux-copy1/ linux-copy2/'.

But let's go back to your example, you had

Branch A: commit 55538fbc79e9
Branch B: commit a4f342b9607d
Branch C: commit 7c139d3f0f99
Branch pm/linux-next: unspecified, but I'll guess commit a06639e89e4

Now, using git describe on each of those commits in order shows us
where in history they are:

A: v5.0-rc2-2-g55538fbc79e9
B: v5.0-rc1-2-ga4f342b9607d
C: v5.0-rc2-5-g7c139d3f0f99
D: v5.0-rc6-84-ga06639e89e47

Now, you said you ran
   git diff -M --stat pm/linux-next..7c139d3f0f99
and that it included the diff between rc1 and rc2.  I think you
actually saw pieces of the diff from rc2 to rc6 and assumed it was the
diff from rc1 to rc2.  Besides the fact that pm/linux-next is based on
rc6 and 7c139d3f0f99 is based on rc2, here's another way to verify
that:

$ git diff --name-only v5.0-rc1 v5.0-rc2 | sort > early
$ git diff --name-only v5.0-rc2 v5.0-rc6 | sort > late
$ comm -23 early late > early-only
$ comm -13 early late > late-only
$ wc -l *-only
  407 early-only
 1149 late-only
 1556 total

So, here "early-only" is a list of files that changed between rc1 and
rc2 that did not change between rc2 and rc6.  "late-only" is a list of
files that did not change between rc1 and rc2, but did change between
rc2 and rc6.  No, let's compare that to your diff:

$ git diff --name-only a06639e89e4..7c139d3f0f99 | sort > changes
$ comm -12 changes early-only | wc -l
6
$ comm -12 changes late-only | wc -l
1148

So, the files listed in your diff only included 6 files that were
unique to early-only, and included 1148 files that were unique to
late-only.  So, your diff looks an awful lot like the diff between rc2
and rc6, and not much at all like the diff between rc1 and rc2.

> > `git diff D...E` means the same thing as `git diff $(git merge-base D E) E`
>
> I get exactly the same result with both .. and ... in this particular
> case and that's why I wonder if everything is okay or not.

With `git diff D..E` it doesn't matter much which order you put D and
E in, other than flipping '-' lines for '+' lines.  With `git diff
D...E` it makes a huge difference.  Compare:

$ git diff --shortstat 7c139d3f0f99..a06639e89e4
 1466 files changed, 15417 insertions(+), 7313 deletions(-)
$ git diff --shortstat a06639e89e4..7c139d3f0f99
 1466 files changed, 7313 insertions(+), 15417 deletions(-)

So, as I said, swapping with double-dot only changes '-' and '+'
lines.  In contrast:

$ git diff --shortstat 7c139d3f0f99...a06639e89e4
 1463 files changed, 15401 insertions(+), 7165 deletions(-)
$ git diff --shortstat a06639e89e4...7c139d3f0f99
 4 files changed, 148 insertions(+), 16 deletions(-)

You get a really small diff in one direction, but huge in the other.
The reason for this is that commit C (7c139d3f0f99) is really close to
the merge base, but pm/linux-next (a06639e89e4) is really far from it
-- it includes rc6.

> The problem in this case is:
> - PM tree had rc1,2,3,4,5,6 merged earlier into it.
> - Then I got merged one of my branches which was based of rc1 into
>   pm/linux-next.
> - And now I am trying to send pull request for another branch which is
>   a merge of the earlier branch (which got merged, based of rc1) and
>   second branch that has more stuff over rc2.
> - The most recent merge commit common between my branch and
>   pm/linux-next becomes the earlier branch which was based of rc1.
> - Now I expect ... to return the diff between rc1 and rc2 as it will
>   diff against the most recent merge.
> - But I expected ... to not include rc1..rc2 diff.
>
> > There are some people for whom this state of affairs makes sense.  I
> > am not one of them, and I suspect you aren't either.  The arguments
> > made by those who feel this makes sense seem reasonable to me in the
> > moment when they present them, but I have never been able to remember
> > these arguments longer than briefly.  It just doesn't stick with me.
> > The only thing I seem to be able to retain is the following:  "git
> > diff D..E is totally useless and should be an error because (1) it
> > doesn't do what I expect and (2) for folks that want the behavior
> > currently gotten with that syntax can instead just use a space instead
> > of a double dot."
>
> Okay but git request-pull uses .. and not ... and that's where I saw
> the issue in the first place.

I haven't used request-pull myself and I'm not familiar with the code,
so I don't know if you might have just passed it the wrong arguments
or if it has a bug.  I'll have to leave it to someone else to comment
on that (though they may need to know what arguments you passed to
that command).


Hope that helps,
Elijah
