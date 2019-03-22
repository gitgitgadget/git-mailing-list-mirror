Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325A520248
	for <e@80x24.org>; Fri, 22 Mar 2019 18:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfCVS1d (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 14:27:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfCVS1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 14:27:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so2833221ljd.12
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9rmVMhhihQ7Xl1EMu+EXiDCnKpfWYRxS6JFRMwYzaw=;
        b=DErOMCLM/hPEcnASbkViadg8Ol7u2sFuOpGk+DcyBZzIjFq5MKnu/XZddbK/DYNHHx
         7fYOE7vvq4GfQMly2eiCE7T+FqAWHhop2yzk3Cim0+Wqi9mKrpDH/Jn6Mut75zjGWxho
         Bg+Q4vD9PA08eO+t19p7/71MdecJoCRYRenWd7A3roeybPN/Vi0GLzs1L3VPIPT1NpWC
         JR93dfb6T4LhrZ2Eeh25+QmeLvDXCkuME4ogK+ZKAYJvVpchRtmh237gUV1bnlFtHE9p
         Kbx9W0dAAnuadmuYio9zY5mYrJI7Cm9wgoYjFpkXjFdXUoVoZYSdnrg3eS313pDAffIO
         Gi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9rmVMhhihQ7Xl1EMu+EXiDCnKpfWYRxS6JFRMwYzaw=;
        b=IXqA3M1HAn6vrMta+SYdaes/5rzg44H7Y+hAReqB/zk9WihOS7G3G8cy0ZTprwy+a9
         u3yvSuPd9Cr1fOwl9dWzdPkCIY6W4sv28Z9MZBbMGSDX64Cnp2Y7rG0cJ1YV/tfwz4+O
         zvGnEnQY0W3cFzfktIW7Tho5G8eifeT4HRUAA1oAOB33p7zDf20K5e7eA7k3Q9zo5W+1
         LyuAlq0LaA2F08awTKM40gwQZNr1GJwocs6vVGeCGd7wq3oZTG/jlHj7RWqyw/f6/OWt
         2mb+ZUZeScLaGXPPzV64odTH2H+TVNtvBqdNNRMAiSB/9ZG2aUGmz8NqCQqL4o8aXFgn
         f4Rg==
X-Gm-Message-State: APjAAAVdzWDhjXyfH3Yqff5oiUkQBp19q+erd3J2BU+tDU/3SrmWip5Z
        ytQjJt5HCi0AUFpu1HQTCsHDKJC5A2mGmvT0aug=
X-Google-Smtp-Source: APXvYqzJR3wtVBn5xSYeQge31CJl04ndOyiXiW1hkQcj1GYpt1IK0bC+T2Dfa7CBDbLyuNjDUZjgjfUmwiCAUhtk3hw=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr1221556ljg.103.1553279250720;
 Fri, 22 Mar 2019 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
 <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> <871s31vjo7.fsf@javad.com>
 <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
 <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com> <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
 <87pnqklr8a.fsf@javad.com> <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
 <878sx8lpqw.fsf@javad.com> <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com>
 <87k1gsh1zs.fsf@javad.com> <xmqqy357r6im.fsf@gitster-ct.c.googlers.com> <8736nfc4t9.fsf@javad.com>
In-Reply-To: <8736nfc4t9.fsf@javad.com>
From:   "C.J. Jameson" <cjcjameson@gmail.com>
Date:   Fri, 22 Mar 2019 11:27:19 -0700
Message-ID: <CALm+SV+mD0oKfQqZBDUixyB6ckHLchj83=0mh7wxuhC5G6kfgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you everyone for the comments!

Confirming Sergey's summary: at this point, I think my only residual
opinion is that requiring `-m 1` or `--mainline 1` is a little cryptic
for someone who's just cherry-picking a single commit, which happens
to be a merge commit. `--no-forbid-merges` would be the thorough way
of accommodating it, but it's even more verbose and you'd still need
to discover it...

I'd be fine abandon this -- thanks again!

C.J.

On Fri, Mar 22, 2019 at 8:22 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Sergey Organov <sorganov@gmail.com> writes:
> >
> >>> With it reverted, "[alias] cp = cherry-pick -m1" can be used to train
> >>> the user to blindly pick a range that has a merge without thinking,
> >>> which is what I meant by "ship has already sailed".
> >>
> >> Did you mean "With it *not* reverted" here?
> >
> > Thanks for a correction.  Yes, if we do not revert it, then that
> > would allow people to follow a bad workflow we do not want to
> > recommend (and I think that is what Elijah does not want to do), and
> > that is why I said the ship has already sailed.
>
> I still don't think it makes sense to revert the patch (that fixed a
> real-life issue) on the sole ground that, as a side-effect, it has
> provided an opportunity that could potentially be abused, specifically
> by defining a random alias, and then shooting oneself in the foot with
> it. And even then no irreversible damage actually happens.
>
> Moreover, if somebody actually wants to "follow a bad workflow", he
> still needs to ask for it explicitly, either by providing '-m 1', or by
> defining and using an alias, so let him do it please, maybe he even does
> know what he is doing, after all.
>
> >
> >> Those who don't like such alias are still free not to define or use it.
> >
> > That's not the point.  Those who do want to be careful can learn to
> > use a new option --forbid-stupid-things, but why should they?
>
> Sure thing, who said they should? Fortunately, that's exactly the
> current state, no need to invent and specify any --forbid-stupid-things
> option, and even if we pretend the option is already there and is
> active by default, still no need to revert anything.
>
> > They should be forbidden from doing stupid things by default, which is
> > the point of this exchange.
>
> I already agreed before to assume this, and it seems that we now all
> agree this safety should be preserved, as there are those who actually
> care. However, as merges are already forbidden right now with all the
> current defaults, I fail to see how it could justify reverting of
> already applied patch.
>
> To me, the actual question here is: what's the option that overrides
> that default? The current answer is: "-m 1", that admittedly is not very
> nice, but has not been introduced by any of the recent patches, so is
> not solvable by reverting any of them.
>
> To summarize, as it looks to me, it's mostly the current way of allowing
> merges, that cryptically reads as "-m 1", that makes the OP unhappy.
> This was already the case before the "allow '-m 1' for non-merge
> commits" patch, so reverting it won't solve the problem in any suitable
> way.
>
> Due to all the above, may we please finally let alone the already
> applied patch and focus on finding (or denying) actual solution to the
> original issue of this thread?
>
> If so, I'm still on the ground of providing new, say,
> "--no-forbid-merges" option, if anything. I'm with Duy Nguyen that the
> way suggested by RFC, making value optional for yet another short
> option, is to be avoided at all costs.
>
> -- Sergey
