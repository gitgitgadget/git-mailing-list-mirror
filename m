Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCC71F42D
	for <e@80x24.org>; Fri, 27 Apr 2018 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934920AbeD0OdB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 10:33:01 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33323 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934823AbeD0Oc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 10:32:58 -0400
Received: by mail-ua0-f196.google.com with SMTP id i2so1295160uah.0
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=825VnsUsfJNkfVklIUU0eSRLgOKQyggwSPaKrwHYg88=;
        b=QOXupqLCRkwi6O02LyVTHMo50v/hUIUdQ0+PwRAUCl7zLfexmem3jmUEakMWqasiNO
         DxAQqY8VuZnWZZ2kHYiAp66ZOO3Nx7nqCSbOD57Xjic2tbOiMB2+bpw0aRsM/++ahYUF
         A1Jh6M5e6NNW591uFcDujS27B2/tH6iESjCxC4xsM77YHjOyuYTMQy3akSs06qOqmsNt
         5qu1F3DmnZxxpssZYwQMWoe4zgQe2rc4hybOxB5QKFu3nNctyzgZyqF5qeXJsVOaVcmg
         XMgZoAvBaTuG3kVG8xdx4t4q1XIrED1K2d3/TWH5rgYO1MNAI24sXNjYzXOY2O1ccOAL
         ZT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=825VnsUsfJNkfVklIUU0eSRLgOKQyggwSPaKrwHYg88=;
        b=OPK5ehEbkJPGQ//392WjX/QrpZJMooMrP2F7vXvBNmMjnz7gReI3465Jig+YizZQSb
         +XN3oSV+KU7MKGCBvjMYdNedjCvg4aP/5VWVqN39WuHe4ONvDxtt6HJFhmFk5fQU87Ql
         cWTdWkec9GjXoaAwV4Iw2E/8r9/GzO+E32F02TNW7xNvt8wjOOy6ywNLQjdWeDEFlmiE
         6c2uXnWwg1Gc2F/eWEYGjYgRfdFeBDXo/o5u2KjibP8cdl86ePwYL6xXB2Khc5er+YI4
         Vo6v5uUO89Vmz7vIpaKzdIqGCgd1sNhZrY2LhBGspKpww/mJj4qdooT3qUuNKcbYVDf4
         TLYg==
X-Gm-Message-State: ALQs6tDRXgJI+nKSYTG9SbRXgxTQqsm/k02BGD7X+dnaldORV1J9F/Me
        xjwX0EKZHASjdfW9zL1kaDqqD1P0cC2NGjySpEg=
X-Google-Smtp-Source: AB8JxZp4E+7sCoD5FASkABA7vtoLIpen98t7q6jK2T1epuv5AgTtS3kYuD7N4IDox+dILFsStLictZXbDS9es35g4/4=
X-Received: by 10.176.90.48 with SMTP id l45mr1675504uad.79.1524839577239;
 Fri, 27 Apr 2018 07:32:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 27 Apr 2018 07:32:56 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804270918430.72@tvgsbejvaqbjf.bet>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
 <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com> <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
 <CABPp-BERgc9EZ=hw4CepgXptO283mW3O30_pHrj4jtz3QSCFjQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804270918430.72@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Apr 2018 07:32:56 -0700
Message-ID: <CABPp-BEoY3bLQVNzfcxKqfXktdpfq0m7yaExM0f3-Ad+Mi0GBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dsco,

On Fri, Apr 27, 2018 at 12:23 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
<snip>
>
> Guys, you argued long and hard that one config setting (diff.renames)
> should magically imply another one (merge.renames), on the basis that they
> essentially do the same.

I apologize for any frustration; I've probably caused a good deal of
it by repeatedly catching or noticing things after one review and then
bringing them up later.  I just didn't catch it all at first.

Your restatement of the basis of the argument doesn't match my
rationale, though.  My reasoning was that (1) the configuration
options exist to allow the user to specify how much of a performance
cost they're willing to pay, (2) the two options are separate because
some users might want to configure one more loosely or tightly than
the other, but (3) many users will want to just specify once how much
they are willing to pay without being forced to repeat themselves for
different parts of git (diff, merge, possible future commands).

I'll add to my former basis by stating that I think the diffstat at
the end of the merge should be controlled by these variables, even if
that's not implemented as part of Ben's series.  And both of those
configuration options clearly feed into whether that diffstat should
be doing rename or copy or no detection.  While they could be kept
separate options, forcing us to somehow decide which one overrides
which, I think it's much more natural if we already have merge.renames
inheriting from and overriding diff.renames.

> And now you are suggesting that they *cannot* be essentially the same? Are
> you agreeing on such a violation of the Law of Least Surprise?
>
> Please, make up your mind. Inheriting merge.renames from diff.renames is
> "magic" enough to be puzzling. Introducing that auto-demoting is just
> simply creating a bad user experience. Please don't.

From my view, resolve and octopus merges auto-demote diff.renames and
merge.renames to false.  In fact, they optimize the work involved in
that demotion by not even checking the value.  I think demoting "copy"
to "true" in the recursive merge machinery is no more surprising than
that is.  You can find more details to this argument in the portion of
my email that you responded to but snipped out.

But to add to that argument, if auto-demotion is a violation of the
Law of Least Surprise, as you claim, then naming this option
merge.renames is also a violation of the Law of Least Surprise.  You
would instead need to rename it to something like
merge.recursive.renames.  (And then when a new merge strategy comes
along that also does renames, we'll need to add a merge.ort.renames.)

> It is fine, of course, to admit at this stage that the whole magic idea of
> letting merge.renames inherit from diff.renames was only half thought
> through (we're in reviewing stage right now for the purpose of weighing
> alternative approaches and trying to come up with the best solution after
> all) and that we should go with Ben's original approach, which has the
> rather huge and dramatic advantage of being very, very clear and easy to
> understand to the user. We could even document that (and why) the 'copy'
> value in merge.renames is not allowed for the time being.

It was only half thought through, yes, at least by me.  But the more I
think through it, the more I like the inheritance personally.  I see
no problem with the demotion and think the inheritance has the
advantage of being easier to understand, because I see your proposal
as causing questions like:
  - "Why does merge.renameLimit inherit from diff.renameLimit but
merge.renames doesn't from diff.renames?"
  - "Why can't I just specify in one place that I {am, am not} willing
to pay for {full, both copy and} rename detection wherever it makes
sense?"
  - "How do I control the detection for the diffstat at the end of the merge?"


Hope that helps,
Elijah
