Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B681F404
	for <e@80x24.org>; Fri, 31 Aug 2018 19:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeHaXrJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 19:47:09 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33557 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaXrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 19:47:09 -0400
Received: by mail-ua1-f68.google.com with SMTP id i4-v6so9043137uak.0
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqr2TKnr/mEMhu1ekPPrKsJUpx02afVjr78X7Nov/DE=;
        b=Q+o7B1KoEfa7D8vdDha8xveYVOPbw0Oyu4prW2F60Hn4uPsJ3pMwaylqJSQwd0m+4m
         xxqq10HQjvCdgN3Z/EkCU0BBuHZRXljcCTc8ElokjP7dU8UoSgCDwHm5LFiqQp7iu9Uh
         gIJlsszOni27P14USvEV10Yt1p5rMdKSiipHDzO6HFKK38dUZEML256T4sL6RDW7JE/r
         LH1oUTMV2gfxLrZV/Bv71Wpd8nLeyPsaAMScgrL9aOyK1BpusixmSEpd3i6qztj/qyGU
         Js26AekgmxW5up5Ufj/EhsyOMR5mdLJ+8qjyzjnTmcUUgqKBCXqwC2rd+vn7GQfKaK8s
         8N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqr2TKnr/mEMhu1ekPPrKsJUpx02afVjr78X7Nov/DE=;
        b=j8dZoxg/cYMRtLyecASUx2eNWzAK4KoJipai/Q1E3vM69dOQW0NUXviMl4uQRkrcNl
         FhvV+w8QL3edsz8cNmDhBPm6lCKhvhmoe+9Bbi+O5Wd/rZV0G7JzBHhK7n35WGIkpVoP
         opCw4U/IyK5HzrxuSB/skrEzjAdyOIcsDP9sAqUzBrcSho9cAIkDWZnEPd1/aH9DMSPn
         Wul1E5eZNtthPtuv911kSKirGUnv72dKwlqS4Iz6QDtBA4xvLb+j21FGjGMVrbWvhC36
         XtsKC/fqM+h33XYsfusrex/DL6RMCghcOVvVQv14sM6smdx3u+Jb3nMeU3pBzV3lGUP/
         1sbA==
X-Gm-Message-State: APzg51Aldclj0RzIkleEJ9wT5PohIIWEUc7b4/+3t60/cnEtPTvco9lq
        EL03WwbH8Xa914PpaCkyKtce/92bS9H3KtqLhUE=
X-Google-Smtp-Source: ANB0VdYrDYXd0fNC/SbgfZdwmqIwIw3PwKGh1UXe58xs/J1JlT2hgeKzXkrtFDy8suua5iSafFaKdmsPgvkGWx4ZezU=
X-Received: by 2002:ab0:5339:: with SMTP id x54-v6mr9949907uax.187.1535744291161;
 Fri, 31 Aug 2018 12:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
 <87in3ueiks.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
 <CABPp-BENB=mqfFU4FGb2OS9VDV=9VdT71HhFLZwtyxD8MpdTMQ@mail.gmail.com>
 <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com> <CABPp-BH8-1YQ49aaM-dXkT9ukKO92MF-FZ2kLwd=KHe4TVbjqQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808311158540.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808311158540.71@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Aug 2018 12:37:59 -0700
Message-ID: <CABPp-BEJ-JPa8g8G1ELsjqf3EDxe+aCBdwERBi5hr5ukrDjJJg@mail.gmail.com>
Subject: Re: A rebase regression in Git 2.18.0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        corrmage@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Aug 31, 2018 at 3:12 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 30 Aug 2018, Elijah Newren wrote:
> > On Tue, Aug 28, 2018 at 9:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > Elijah Newren <newren@gmail.com> writes:
...
> > > I'd say this is the only practical solution, before you deprecate
> > > the "pipe format-patch output to am -3" style of "git rebase" (and
> > > optionally replace with something else).
> >
> > I posted a patch a while back to add an --am flag to "git rebase",
> > make "--am" be implied by options which are still am-specific
> > (--whitespace, --committer-date-is-author-date, and -C), and change
> > --merge to be the default.
>
> Didn't you also post a patch to fold --merge into the --interactive
> backend? What's your current state of thinking about this?

Yes.  I updated it once or twice, but it had conflicts with the GSoC
projects each time, so I decided to just hold off on it a bit longer.
I'm still planning to resubmit this once the GSoC projects merge down.

> As to switching from --am as the default: I still think that --am has
> serious speed advantages over --merge (or for that matter, --interactive).
> I have no numbers to back that up, though, and I am currently really busy
> with working on the CI, so I won't be able to measure these numbers,
> either...

Yep, we talked about this before and you mentioned that the rewrite in
C should bring some performance improvements, and we agreed that
merge-recursive is probably the next issue performance-wise.  I think
it's at least worth measuring what the approximate performance
differences are with the rewrite of rebase in C, and posting an RFC
with that info.  If the answer comes back that we need to do more
optimization before we switch the default, that's fine.

> Also please note: I converted the `am` backend to pure C (it is waiting at
> https://github.com/gitgitgadget/git/pull/24, to be submitted after the
> v2.19.0 RC period). Switching to `--merge` as the default would force me
> to convert that backend, too ;-)

Not if git-rebase--merge is deleted and --merge is implemented on top
of the interactive backend as an implicitly_interactive case.  In
fact, that's probably the simplest way to "convert" that backend to C.
Anyway, since I plan to submit that change first, we should be good.

> > I'll post it as an RFC again after the various rebase-rewrite series
> > have settled and merged down...along with my other rebase cleanups
> > that I was waiting on to avoid conflicts with GSoC stuff.
>
> Thanks for waiting! Please note that I am interested, yet I will be on
> vacation for a couple of weeks in September. Don't let that stop you,
> though!

Enjoy your vacation!

> > > The whole point of "am -3" is to do _better_ than just "patch" with
> > > minimum amount of information available on the pre- and post- image
> > > blobs, without knowing the remainder of the tree that the patch did
> > > not touch.  It is not surprising that the heuristics that look at
> > > the unchanging part of the tree to infer renames that may or may not
> > > exist guesses incorrectly, either with false positive or negative.
> > > In the context of "rebase", we always have all the trees that are
> > > involved.  We should be able to do better than "am -3".
>
> Right. I think that Elijah's right, and --merge is that "do better"
> solution.

Cool, good to see others seem to agree on the direction I'd like to
see things move.
