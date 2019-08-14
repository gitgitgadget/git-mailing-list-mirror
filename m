Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B351F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfHNIsh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 04:48:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42278 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHNIsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 04:48:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id j7so35806544ota.9
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J8Y1cTxoYw9HJHSDpH6GeeQM7nAVIOat85lmjOyji78=;
        b=JMJjnto/h4vxov6l8bFYheFlaIrTTf/P7hLycjxHBQocFZL1ebDQ9aTnpcZj4blmDv
         qo9VHjyLxVHQXlVofnQA/ZykLQQljWWJGVFMVvTixaKdL7GsQNxpXst5XWNFv910DLNB
         Pp8KNyPNgjmteZtCgjxXpCM/xxkTS+CMm8HncF6/BoVBtMyVQWAWfvLlBBZ8hQDWHJxU
         N7mAZRWD6izKgL974GwOEHhrWDvdAc6mxs8Z8M5SojrUvSWBN23pmi5yTas15zA8WDlr
         Mdts8sVk5qCtVhHjmFeuU7/rmBqC90HaK1iZxsLMWhvVfq78zS2CJU7GtzU8FM7+e4LQ
         1x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J8Y1cTxoYw9HJHSDpH6GeeQM7nAVIOat85lmjOyji78=;
        b=U3k/ITInLSgj428e8+P2E9cGe+QgJpDiuCLkk59YYsYsydCM3IHy5WruGr/JQyUBZS
         BhK6UWpkxyOqmIgOuLXtID6KbmH4KRlSkImSXj2YtnGgk0DVPAZ4qgh1g1v3pqSR2lKz
         V44BK7DErhz238zV1IkOp9GMUoxxHKIl8ek0pBCIpKEpZLJn9/1n4IyFiiHDUfnV79uu
         WjLqh5cdpkL5EMbGBhrtgJCD0ZNz2IVVTVrbDNGH0BI1JTF3AzTqrRTvbLQCR3Xjmobb
         EkmKO5g29qNTDmeAoZ0X4FwJiibLwx/v939MIx6pVobVk5CppIZStqWam7JJSuf7mSjs
         Slmw==
X-Gm-Message-State: APjAAAVNZhhYoM8b6/15L0xN8ZDlPdKZr5LwpzroTadBbTV2y5qyRfKS
        1hJsbDtBz3cf5qwq4JNPgkTceYm7ZD824ypDFstjwATZyI0=
X-Google-Smtp-Source: APXvYqzbklT6zWOAu7SUNJePntDfbZFL+GBnWL1V6TvPYaspVQjpF+lHXJ5QxytKi4MczbDipBf4C0N2JDp1Gw2iUtw=
X-Received: by 2002:a9d:4004:: with SMTP id m4mr6661294ote.146.1565772516400;
 Wed, 14 Aug 2019 01:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACi-FhDeAZecXSM36zroty6kpf2BCWLS=0R+dUwuB96LqFKuTA@mail.gmail.com>
 <20190730065949.GB4901@sigill.intra.peff.net>
In-Reply-To: <20190730065949.GB4901@sigill.intra.peff.net>
From:   Ibrahim El Rhezzali <ibrahim.elrhezzali@gmail.com>
Date:   Wed, 14 Aug 2019 10:48:11 +0200
Message-ID: <CACi-FhBktzoOLJMkQdWLVc1-+qJ_YuVMBy3KYbw96h9Y=hFDBQ@mail.gmail.com>
Subject: Re: [RFC] Improved git signing interface
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much Jeff for looking into the proposal and for
pointing out the previous threads on the subject.

I understand your concern on 'emerging technologies' and new tools.
But to clarify, the current work and patches do not include any new
tools, and is merely a cleaning of the signing config and interface
that would make it easier in the future to add compatibility for any
signing tool.

The current changes maintain full backward compatibility and all
existing tests pass. I will hopefully be submitting the patches in the
coming days.

Thank you again for checking the proposal.

 -Ibrahim

On Tue, Jul 30, 2019 at 8:59 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jul 22, 2019 at 04:16:15PM +0200, Ibrahim El Rhezzali wrote:
>
> > I have been selected by the Linux Foundation to work on a summer
> > project. I would like to abstract the git signing interface and add
> > support for signatures using decentralized identifiers (DID).
> > Decentralized identifiers are an emerging standard [0] that allows
> > individuals to control their own digital identities, and is often
> > called self-sovereign identity (SSI). The SSIMeetup is a good place to
> > learn more about SSI [1] and DIDs [2].
> >
> > The project=E2=80=99s current goal is to abstract the current GPG inter=
face
> > into a more =E2=80=98generic=E2=80=99 API that supports the existing Op=
enPGP and X.509
> > functionality while creating the ability to write additional signature
> > drivers.
>
> Neat. I'm always wary of supporting "emerging standards", because
> sometimes they turn out not to emerge and you are left with historical
> cruft. :) But if your changes to Git are mostly around making the
> signing config more generic, I think that is something people are
> interested in (signify has come up as a possibility before).
>
> You might find this discussion interesting (that patch and the
> sub-thread):
>
>  https://public-inbox.org/git/20180409204129.43537-9-mastahyeti@gmail.com=
/
>
> One of the points I think people didn't like was how Git would detect
> signatures embedded in objects (i.e., is matching PEM-like lines enough,
> or what would other signing systems want?).
>
> That patch was later dropped in favor of the work from Henning Schild:
>
>   https://public-inbox.org/git/cover.1531208187.git.henning.schild@siemen=
s.com/
>
> which is much more geared at just adding gpgsm support. There were
> various discussions about how it could eventually be extended to new
> formats. I skimmed over the documentation from your branch and it looks
> like a pretty sane layout, with backwards compatibility.
>
> > I have implemented a prototype that works and passes all tests, and in
> > the coming weeks I plan to submit a series of patches for your review.
> > I first need to clean up the Git history to make it easy to follow. I
> > will also ensure that people using the current approach to GPG signing
> > can use the proposed approach with only minor changes. The flag
> > =E2=80=9C--gpg-sign=E2=80=9D would evolve to =E2=80=9C---sign=E2=80=9D,=
 though I would like to
> > preserve an alias to the old flag if possible.
>
> Yes, this must not be "minor changes" but "no changes" to be accepted.
> It's OK to deprecate things, but old options cannot immediately stop
> working. From this email and looking at your config patches, it looks
> like that's the route you plan to take. Good.
>
> I look forward to seeing the cleaned-up patches. :)
>
> -Peff



--=20
Ibrahim EL RHEZZALI
T=C3=A9l. +212 6 72 55 71 71
