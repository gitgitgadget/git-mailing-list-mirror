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
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E751F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLSeB (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:34:01 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38784 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKLSeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:34:01 -0500
Received: by mail-wr1-f54.google.com with SMTP id i12so12769410wro.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dRZnmWA/OTHc5w6+rT+CVxkaMQdL6JCwuIzdwSdoj1E=;
        b=VSb8Dt1OLa4oZHAcUCjWzpWtxKfzMd2lrrhyatD0cavD35vH0vorgNGYYw+7v8ctNR
         qFbkR8ueMxFsXLXjgPirjhCLEM6gTFqT/LYOvmjdqRzpL4i+ZGA8PcYHHExQ7N/1ufzs
         SlGfT2hV0X1s2GPCDQa/4tKwo5CgEqY2zG+6ZVIWvzOu/xyKfn1MWSh3pmYOGvED2/fQ
         2xW5ijSl5sS3RHF3BSJdovjGLEH+2yK5RyV08bqdceyhDMOX3Ztxn25lCCpE46QtWHAD
         XNGLH6TKfcrT03c7+PD7jpo8kElO4/RALMePE4KlTaDM9PUdmw8rPU1UsvF5whvjdFW8
         SXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dRZnmWA/OTHc5w6+rT+CVxkaMQdL6JCwuIzdwSdoj1E=;
        b=aRRPm/EdlW6hKrutE2w3g92BADPROeWq6dkZWVjtAgDpDs5F4gtyYyWUYEjIXOPmd2
         1Vr2sNi+aXwn7MmU3qfEC12qTH5fhS8iGnIHUjItZKhVXcFdNdeEMsvifezYTHbH3ASe
         oy0z6Kn61GVhRKsl2VqL+NFvx9AOAMUu9e2Q8PvhMkhSfPagaH8xzhCFL+or43RQWkEF
         +sjL41xX8Y4zbOuuRkLCuHt5PREa5Lwv4/M8wBtRdrB0fY2GAyWpW/EcbmAkCtx3eR95
         kcFcaNNii1x5flAMjZsR3GxgCfu4cEVSFGHYtftwtf6Y1oC1Ww1JCMSW1ePWR9hvUZsE
         qk1w==
X-Gm-Message-State: APjAAAU5QtvNSr2UM4iSqPJ8eyg4GjnSVJqYIEWLejSUBX7X6eeCGoYz
        UN8f8oBiST+UZe9Tlo49pJ6BHOBtENRqGCRrD4Kt+Q==
X-Google-Smtp-Source: APXvYqy62qf68y9O1wOrRPnug9TLrYmP6Rl4c/Kmmt/rIMyxDgR7ioeuRjFGGDbsn87Di2xuAzhCeciLooiX+4BoBYs=
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr25371426wrj.168.1573583639748;
 Tue, 12 Nov 2019 10:33:59 -0800 (PST)
MIME-Version: 1.0
References: <CAE7Eq9jJzftkP9JWFpstS96SiCd+jO_adSQ-HruyYYNi3gWe7w@mail.gmail.com>
 <20191111042149.GE6379@sigill.intra.peff.net> <20191111140956.GJ4348@szeder.dev>
In-Reply-To: <20191111140956.GJ4348@szeder.dev>
From:   Sebastiaan Dammann <triadsebas@gmail.com>
Date:   Tue, 12 Nov 2019 19:33:49 +0100
Message-ID: <CAE7Eq9hEiVf1rMNdWx55_nQsz2gVv0N+s1KckK1evtmruqcHyA@mail.gmail.com>
Subject: Re: git name-rev looks at refs/notes, refs/svn/map: stack overflow
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there anything I can do to help? I have real-life (though
proprietary) repositories to test the fix on.

On Mon, 11 Nov 2019 at 15:09, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>
> On Sun, Nov 10, 2019 at 11:21:49PM -0500, Jeff King wrote:
> > On Sat, Nov 09, 2019 at 12:31:31PM +0100, Sebastiaan Dammann wrote:
>
> > All of that's obviously a workaround, though. The real issue is the
> > stack exhaustion.
> >
> > > I hope to hear your view on this. Is this an (confirmed) issue with
> > > git? Are there beside the workaround I mentioned, any other
> > > workarounds?
> >
> > Yes, this is well known. It's covered in the test suite (unfortunately
> > still failing, of course) since 31625b34c0 (t6120: test describe and
> > name-rev with deep repos, 2017-09-07).
> >
> > There was a proposed fix recently in:
> >
> >   https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail.c=
om/
> >
> > but it doesn't seem to have been picked up. I'm not sure what the
> > current status is.
>
> It's getting along, being polished, clarified and fine-tuned ever so
> slowly.
>
> E.g. it turned out that the performance penalty from eliminating the
> recursion is basically entirely caused by using a 'commit-list' to
> store interesting parents (the overhead of a malloc() on each insert
> and a free() on each pop).  Switching to a LIFO 'prio-queue' doesn't
> cause any measurable slowdown.
>
