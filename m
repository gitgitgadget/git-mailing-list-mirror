Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BCEC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EA360FE8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhHaSZE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 31 Aug 2021 14:25:04 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46682 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhHaSZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:25:03 -0400
Received: by mail-ed1-f50.google.com with SMTP id j13so22896266edv.13
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EgSymHEgANYRFVZzj1DbyOPmeI79USgqajsb+/5Z6EA=;
        b=ncNsiZpPZMDB43j438tq1RRoznT+q5RA9I3+RwCs1t8OEEj64ajX3Lk5TNDATP+Pko
         maqc0WtfzWpL1pJbfWB9guY5JBtXhPfOOSvrYUZ20d3/Y77rJrQm9g0KEVxpmF39SQ87
         7xlWesSIeqqaPoXKNFegbmh6TSZ1xtWAWX/U6jI2whIMEwegqXK45fVfv3swt1MGOUku
         YeErrkXQYQAQstJaxaNhYO0YBG/bHq2TuYV1a7eWrKnzM/z7Igw4DtHMF35TW06158c1
         KcvTmKmSHbzlian61ZoBCRjdlKxRTtIjexa4hs2NZDxEfsn5wS6jN3MsrMveOYBA0v2A
         GxAw==
X-Gm-Message-State: AOAM531K33VA4QRiRu7yFYi4N07g8mVlHaYCJbPj1YvdxkhuecTUW9+E
        33wKKQcS7dzshLqqo3rm56hT0maffWZsVW0KNNuPLzXn
X-Google-Smtp-Source: ABdhPJwqx8zR5+IshJ4oV2ZL5OQ+wz890cp9qOjCyigoFw/uutC1hjGQ9UecXbufQZ6bShA60eTW4isQmY0mpoLb8mI=
X-Received: by 2002:aa7:cb86:: with SMTP id r6mr30838425edt.181.1630434246622;
 Tue, 31 Aug 2021 11:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
 <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com> <CAPig+cQ1V-sSZzrBwDWZYFEFJY-W8s1aq4igfhg9vPBNdLJusA@mail.gmail.com>
 <xmqqpmtttr56.fsf@gitster.g>
In-Reply-To: <xmqqpmtttr56.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 14:23:55 -0400
Message-ID: <CAPig+cTaJ=xm=K5Y8yn8RiOFHBH-nzhRztYRz3kYsqsyJUTACg@mail.gmail.com>
Subject: Re: [PATCH] gc: remove trailing dot from "gc.log" line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jan Judas <snugar.i@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 2:18 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Tue, Aug 31, 2021 at 10:37 AM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >>                 warning(_("The last gc run reported the following. "
> >>                                "Please correct the root cause\n"
> >> -                              "and remove %s.\n"
> >> +                              "and remove %s\n"
> >
> > Even more bikeshedding:
> >
> >     Please correct the root cause and remove
> >     /path/to/repo/.git/gc.log
> >     to allow automatic cleanup to resume.
> >
> > or something.
>
> I also found the line break before "and remove" strange, but I think
> that is because the "Please" is not at the beginning of the
> paragraph, but is a second sentence.  Perhaps unfolding "and remove"
> would make the first line overly long?

Yep, you're right, and perhaps my "Even more bikeshedding" didn't
clearly indicate that I was bikeshedding more about combining the
"Please correct..." and "Automatic cleanup..." sentences into a single
sentence, both as a another way to deal with the punctuation issue
(thus allowing easy double-click) and to make the whole thing read a
bit better.
