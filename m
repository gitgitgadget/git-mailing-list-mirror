Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993B91F453
	for <e@80x24.org>; Thu, 25 Apr 2019 00:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfDYAzC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 20:55:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41119 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfDYAzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 20:55:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so21498167wrt.8
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yl5KOf1Nt1iMlDZO8D2PcbKKIi9Tl5M2OoQlLccXpkk=;
        b=sh5Z9PEcDg8cWYr8yV9td+hiuRiSAcF1/N2F0CqPw7UjQ09xoMmm1T/AubJ+D7qdzh
         ug6aexSI0GJEdHg0XhDdvGVUpyMt0y3i648d5FMZNDIai1nQgam6oCqma/6pTAHy7WK+
         8/FqKNMVXQ3Lfe0n6VIpoEG74xUcqKF90x+n09KtXFpWITUvUkxVndTV5lIJ4ZLF6N/2
         jTpjLUN39B56OlsArQo1Q1A5m1IcQoN2Evk3ZvouBHE4FbuHj2b3BIRbZNrJCHqAkdfy
         xZ/bCKxu2RzsUke5+fHmBTO7SmdI6Ci3GZ6qGJ75rr69ZSjT2bU61XrzBGVERV5Pn0Bx
         p8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yl5KOf1Nt1iMlDZO8D2PcbKKIi9Tl5M2OoQlLccXpkk=;
        b=j3BoCHlsDRFcJKrjopHylrd0gxmTxDrg76kyp34QmwwjS4LfxiRWzPvnZzh9kuiofl
         GXuuHRoWc8UOLGqoOKAKC+wHEcl60285yPWmviwIUtI5NIfY7RWMxJX00gwY7w2+EJXr
         NK9qzniRPEhlnGVarXTxGEH3ocdK9MD1EVboYEBlAxVwYFvPRHeEbrI73pXd+u/B211K
         brJnlxoXcjUzWB1LYzh/ho99Wh0gzGhNXXMR9HHypNdFXowmnjG10sxL7NlTC+dqN3+M
         jR6k+DAcbzXMrWzxSv1TksNmuTvvQ/7I0bN5xRGvXbPop4yjAASgcEOFMELbbilM1N22
         aiAw==
X-Gm-Message-State: APjAAAUIA049bddr0VPmEvvgDlPqK9HEZtsCMfdPhavOdYawAYqa9NmC
        N43V1cXOVxn9dXBo77iR2RU=
X-Google-Smtp-Source: APXvYqz9og3+sh5V8/Xlm+v9qkU8NHNV7HeBORjxFA6sOBgSAEIjJEXQRHVys5vJ9APQ7ASF1V279A==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr24413837wrj.66.1556153700015;
        Wed, 24 Apr 2019 17:55:00 -0700 (PDT)
Received: from x230 (ipb218f5b3.dynamic.kabel-deutschland.de. [178.24.245.179])
        by smtp.gmail.com with ESMTPSA id z14sm27931479wro.81.2019.04.24.17.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 17:54:59 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date:   Thu, 25 Apr 2019 02:54:48 +0200
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use
 with -G
Message-ID: <20190425005448.GA6466@x230>
References: <87o94vs9cp.fsf@evledraar.gmail.com>
 <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
 <87mukfrnp3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mukfrnp3.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 01:24:56AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Apr 25 2019, Eugeniu Rosca wrote:
> 
> > Hi Ævar,
> >
> > Thanks for the amazingly fast reply and for the useful feature (yay!).
> >
> > On Wed, Apr 24, 2019 at 05:37:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Wed, Apr 24 2019, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> > Add the ability for the -G<regex> pickaxe to search only through added
> >> > or removed lines in the diff, or even through an arbitrary amount of
> >> > context lines when combined with -U<n>.
> >> >
> >> > This has been requested[1][2] a few times in the past, and isn't
> >> > currently possible. Instead users need to do -G<regex> and then write
> >> > their own post-parsing script to see if the <regex> matched added or
> >> > removed lines, or both. There was no way to match the adjacent context
> >> > lines other than running and grepping the equivalent of a "log -p -U<n>".
> >> >
> >> > 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com/
> >> > 2. https://public-inbox.org/git/20190424102609.GA19697@vmlxhi-102.adit-jv.com/
> >>
> >> I see now once I actually read Eugeniu Rosca's E-Mail upthread instead
> >> of just knee-jerk sending out patches that this doesn't actually solve
> >> his particular problem fully.
> >>
> >> I.e. if you want some AND/OR matching support this --pickaxe-raw-diff
> >> won't give you that, but it *does* make it much easier to script up such
> >> an option. Run it twice with -G"\+<regex>" and -G"-<regex>", "sort |
> >> uniq -c" the commit list, and see which things occur once or twice.
> >>
> >> Of course that doesn't give you more complex nested and/or cases, but if
> >> git-log grew support for that like git-grep has the -G option could use
> >> that, although at that point we'd probably want to spend effort on
> >> making the underlying machinery smarter to avoid duplicate work.
> >
> > Purely from user's standpoint, I feel more comfortable with `git grep`
> > and `git log --grep` particularly b/c they support '--all-match' [2],
> > allowing more flexible multi-line searches. Based on your feedback, it
> > looks to me that `git log -G/-S` did not have a chance to develop their
> > features to the same level.
> >
> >>
> >> Furthermore, and quoting Eugeniu upthread:
> >>
> >>     In the context of [1], I would like to find all Linux commits which
> >>     replaced:
> >>     	'devm_request_threaded_irq(* IRQF_SHARED *)'
> >>     by:
> >>     	'devm_request_threaded_irq(* IRQF_ONESHOT *)'
> >>
> >> Such AND/OR machinery would give you what you wanted *most* of the time,
> >> but it would also find removed/added pairs that were "unrelated" as well
> >> as "related". Solving *that* problem is more complex, but something the
> >> diff machinery could in principle expose.
> >
> > I expect some false positives, since git is agnostic on the language
> > used to write the versioned files (the latter sounds like a research
> > topic to me - I hope there is somebody willing to experiment with that
> > in future).
> 
> I was thinking of something where the added/removed could be filtered to
> cases that occur in the same diff hunk.
> 
> >>
> >> But the "-G<regex> --pickaxe-raw-diff" feature I have as-is is very
> >> useful,
> >
> > I agree. I am a bit bothered by the fact that
> > `git log --oneline -Ux -G<regex> --pickaxe-raw-diff` outputs the
> > contents/patch of a commit. My expectation is that we have the
> > `log -p` knob for that?
> 
> This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
> general. See e.g. "git log -U1".

Oops. Since I use `-U<n>` mostly with `git show`, I missed the
implication. You are right. Then, my question is how users are
going to (quote from commit description):

> >> > [..] search [..] through an arbitrary amount of
> >> > context lines when combined with -U<n>.

and achieve a `git log --oneline` report, given that -U<n> unfolds
the commits?

FTR, based on my quick experiments, --pickaxe-raw-diff does process
several lines of context by default (it appears to default to -U3).

> 
> >> I've had at least two people off-list ask me about a problem
> >> that would be solved by it just in the last 1/2 year (unrelated to them
> >> having seen the WIP patch I sent last October).
> >>
> >> It's more general than Junio's suggested --pickaxe-ignore-{add,del}
> >
> > As a user, I would be happier to freely grep in the raw commit contents
> > rather than learning a dozen of new options which provide small subsets
> > of the same functionality. So, I personally vote for the approach taken
> > by --pickaxe-raw-diff. This would also reduce the complexity of my
> > current git aliases and/or allow dropping some of them altogether.
> >
> > Quite off topic, but I also needed to come up with a solution to get
> > the C functions modified/touched by a git commit [3]. It is my
> > understanding that --pickaxe-raw-diff can't help here and I still have
> > to rely on parsing the output of `git log -p`?
> 
> Yeah, it doesn't help with that. When it runs we haven't generated the
> context line or the "@@" line yet, that's later. You can breakpoint on
> xdl_format_hunk_hdr and diffgrep_consume to see it in action.
> 
> It's a waste of CPU to generate that for all possible hunks, most of
> which we won't show at all.
> 
> But it's of course possible to do so by running the full diff machinery
> over every commit and matching on the result, the current pickaxe is
> just taking shortcuts and not doing that.
> 
> >> options[1], but those could be implemented in terms of this underlying
> >> code if anyone cared to have those as aliases. You'd just take the
> >> -G<regex> and prefix the <regex> with "^\+" or "^-" as appropriate and
> >> turn on the DIFF_PICKAXE_G_RAW_DIFF flag.
> >>
> >> 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com/
> >
> > Thanks!
> >
> > [2] https://gitster.livejournal.com/30195.html
> > [3] https://stackoverflow.com/questions/50707171/how-to-get-all-c-functions-modified-by-a-git-commit
