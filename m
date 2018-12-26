Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF2D211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 04:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeLZEdW (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 23:33:22 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37404 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeLZEdW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 23:33:22 -0500
Received: by mail-ed1-f53.google.com with SMTP id h15so12469144edb.4
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 20:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4sN+LzlzX9QXSlkd+jxQBswraNmfewCFtYS1I0I7zOY=;
        b=p5dxyOJb1a8OE4FCdMfe3343naE5MWUsPoi+Ibn4gCHaoe737OIyU4fufTbUsB7y+A
         Bm8Z1ZeRPi3a24wmA963RHV9ve7V3QOFCn3aGIhO1XD7X6epjYObFzpiMv2rtJHHJyVv
         G41vRm6gMAsOmtsJ/ekfhaMWV6KSwraucbldf5b00RdpK4TCO6Fg+NKtYPe737lGbyfr
         61+lsIHuAETGNkqmA3h5aYJOxYtMUkgsZohE3MOtbEniAgB9GTvfCVTCaJ2qPx6I2Ee0
         +OMMDNxWzQ7eM8PQU2s5hfItm7ZEQb+CH9nPlVjv4fg8X+7Shr+MssHM7YuzpAs6DvwK
         lE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4sN+LzlzX9QXSlkd+jxQBswraNmfewCFtYS1I0I7zOY=;
        b=fg0MUQVFaSfBgT5OEdQ6YW2yqGY3CbDNcT8Oov1C6inZL9WbSXn9XT7jqmoY06nZ32
         Jyf4AAE/jUH0tNPeD8dQrkQKTu0967YmJ0Mgy9wfkgZ+jVLKWshfZxvMA/qwRGILleWv
         MVPjgmPNxXsY+TBIQzHvA5Ftx1ikz95qYvdXtt8V3X3LWb7JMfPvbayscL/7YFyEFlV/
         z71Ne1k5LrT6Jms7QWNdm1xk5Cv+1mROfxjN2q/lAEfZhGDiTZS1kzGlnGZR+J9PdbSh
         NCcG0otAkhTNB+MmRZGLnmp7KXQmIxL4uUON567HywiSA1ZgJv++Xj5hHSK9MuimqH7K
         MdHg==
X-Gm-Message-State: AA+aEWb2aSw99+ooLjvVW6AzLes+rApssKcRcGrv6LqK+nCBJnZCtbBs
        KXtjqEXdy8rYVRHA/8DcQOEX5jrWsZsMLIV+JVM=
X-Google-Smtp-Source: AFSGD/WX7aWcvo8yidWozdDBryvt+wqFoKnWBTzxuMjHuOq0KYkrBqFLkiHPkEKoVfIRZmzOvOV1LDgf4qf80Cp/Sjc=
X-Received: by 2002:a50:8f86:: with SMTP id y6mr14808590edy.131.1545798800716;
 Tue, 25 Dec 2018 20:33:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
 <CAP8UFD1ErRo7NQmCrAJLaELzV-1rKowyPsNCi3ecTqGN1qWxKQ@mail.gmail.com> <CAFW+GMB4KW34qaOWNwShWM_ERSJtnvp86V_mFAse1biO=T-srw@mail.gmail.com>
In-Reply-To: <CAFW+GMB4KW34qaOWNwShWM_ERSJtnvp86V_mFAse1biO=T-srw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Dec 2018 05:33:09 +0100
Message-ID: <CAP8UFD2A1tX9qPZXr8ibPhy0B1zc5OtsWzP_XHoRJJF6hmkxRQ@mail.gmail.com>
Subject: Re: Parsing trailers
To:     William Chargin <wchargin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William,

On Mon, Dec 24, 2018 at 7:52 PM William Chargin <wchargin@gmail.com> wrote:
>
> Hi Christian: thanks for your reply.
>
> > Changing the default separator as shown above, should make it easier
> > to parse the result.
>
> But this actually also changes which lines are considered trailers,
> right?

Yes.

> If the commit message ends with
>
>     Signed-off-by: one
>     Signed-off-by| two
>
> and the user=E2=80=99s `trailer.separators` is set to `:`, then the corre=
ct
> result should be only `Signed-off-by: one`. But when adding `|` as a
> separator, we also see `Signed-off-by: two` in the result.

Yeah, but you can perhaps check that the input doesn't contain '|'
before doing the above. If it does contain '|' then you can probably
find another char that it doesn't contain and use that char instead of
'|'.

Another solution would be to develop a trailer.outputseparator config
option, which should not be very difficult.

Best,
Christian.
