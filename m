Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C03C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5551461039
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhJYWW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhJYWWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:22:55 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04FC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:20:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p142so17706159iod.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jo3sVVWWaqOgYOn+yfriGcFByMtyDSynJWVRe/AaeNE=;
        b=ZtEmG0t47Vjrv9s+4mSNvU8wYIEQ4trPjdFwW3EgHrqfCTQnue/QIoo+ddd1xik/5U
         uGDAbjA/aPZcooOJP3M9X24fYNjla9pL3KC17B/X88CapZC5YUaIuKci/yUnv8Wk6deF
         m8Gca0VlYD/QCkfpFaJglks/l+wql/6PpUt8n5vAyCAnzixANscZjvRGpYL/sSh1/Orc
         TbbLbOUaH+DAMKtoyOOwPWkR92S3ixBupnY38zhuFdcjn8Z8IpPUyYErxli/03M4ncDR
         mTxlf1d2nXDf/zLQncS6D2mdgkaDn4eeipguyeluTht7bC2Yh9TzpGfFDe9N98e5uZsD
         odwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jo3sVVWWaqOgYOn+yfriGcFByMtyDSynJWVRe/AaeNE=;
        b=GZ7nIYBz1Af5oYQDOhC7oVy4/yLgJerNFqccC3gUjh8Vw0ZkeHswhuosThFiW82oTy
         k19wgW4JEgCoOZNyOV8huMU5hrqNkwK8tO08hcZG0P3kGg1/3PqgaRIOBOq8KQndvHax
         kgVFpyt/TNCXgO+eYK8WE5GVJ64apSvve8MJ0pSOsdcM+NDxPJDMDTrdWmUZ4ryBwAKB
         nnLzwSIcHT9l8Bix4ZX9D4VJeFr46mBRWzXkm/AoY158DHLW0yAIDmhSjRZ7L5JiJOOa
         u7gYsPtkKTx5m2ULqm1BuygaQ518IFvKD9lCV/j3HfmgR6/XHrukuL1M6kA0PHR2cabL
         QphA==
X-Gm-Message-State: AOAM532aVsA1tRNRblH0hHT+QTx1dcpzYM9MRwjtBNOVkF044J3hon6y
        sqhGutuGYPlU2F3p12qA448NKmeIAMInF20imeg=
X-Google-Smtp-Source: ABdhPJxpOT3ADPYQBMjHPssShcrAxlm8NWPVyBAlFi95RxNjwU8bWP/p6O0vCTrIDJhGty07qNJeBqhe9qmlLSUlT+s=
X-Received: by 2002:a05:6602:2b10:: with SMTP id p16mr12530969iov.207.1635200430494;
 Mon, 25 Oct 2021 15:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
 <xmqqbl3zjl5y.fsf@gitster.g> <CAMmwyQpP0m6dTdC-L9abZqk9nJkcYy=j4_s0+EdGDr__pykeXQ@mail.gmail.com>
 <xmqqh7dri2m1.fsf@gitster.g> <CAMmwyQp7ChC7RZAZX4Y3UyAghOAmvHA7e3BBJonGYJNoSc+nFA@mail.gmail.com>
 <xmqqzgrjglma.fsf@gitster.g>
In-Reply-To: <xmqqzgrjglma.fsf@gitster.g>
From:   Robert Estelle <robertestelle@gmail.com>
Date:   Mon, 25 Oct 2021 15:20:04 -0700
Message-ID: <CAMmwyQqSJRgQ+-tFwYSSw2FU9TJ0TbjP-M_1rJSmo7bFpLW76w@mail.gmail.com>
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I considered dropping this patch entirely since this discussion was
going so far off the rails for a single-char fix, but I hate to leave
things hanging=E2=80=A6

> When you do not mean pattern matching and want exact matching, even
> if it is guaranteed that the data you pass through the codepath does
> not have pattern to cause the former, hence the distinction between
> [[ x =3D=3D y ]] and [ x =3D y ] does not make a difference, that is a
> mere happenstance, and use of [ x =3D y ] is the correct thing to do
> in such a case.

I think you've misread what's going on here, or might be
misremembering the shell quoting rules (which would surprise me!).

My assertion about their equivalence was syntactic: there's no
happenstance or reliance on codepaths whatsoever.
If you write:
  [[ "$x" =3D=3D "$y" ]]
then it doesn't matter what x and y contain. They're quoted: it's just
a literal string comparison of their values.
Their values can contain quotes, newlines, spaces, asterisks, emoji,
etc. and none of that gets any special interpretation.

Regardless, since they're functionally equivalent, I've pushed up a
change to do it the other way and will submit that shortly.

Best,
Robert

On Fri, Oct 8, 2021 at 4:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Robert Estelle <robertestelle@gmail.com> writes:
>
> > The choice between the two does not affect correctness, it's purely
> > stylistic here. It only would affect correctness for unquoted
> > arguments or extended comparison operators. Those *are* in use
> > elsewhere in this script and force the use of `[[` in those places.
> >
> > Keep in mind also that this is an autocomplete script. Although it's
> > sourced by both bash and zsh, it does not make sense to attempt to
> > make it work for bare POSIX sh.
>
> Nobody is trying to.  It is more for reducing the risk of people
> shooting their foot by cutting and pasting without thinking.
>
> When you do not mean pattern matching and want exact matching, even
> if it is guaranteed that the data you pass through the codepath does
> not have pattern to cause the former, hence the distinction between
> [[ x =3D=3D y ]] and [ x =3D y ] does not make a difference, that is a
> mere happenstance, and use of [ x =3D y ] is the correct thing to do
> in such a case.
