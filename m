Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A69A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 10:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfA3Kby (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 05:31:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46403 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfA3Kby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 05:31:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so20197993ljh.13
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8ox4X6Kk0enKCc/A9AHBpc7VBPunmE88lXBu9cwNXs=;
        b=JVnSjHhxVc+X6mVom2KkzEZOyuFuAd09vFfNjnU+IfIl+8D/zhAyWvSBQY/QQmrZz+
         92MOxhmRzAh7n7woyIDTUPGjomVC6BghVgaRoZzwyKDRa+6ENAHUX7ylD4tvFrXlGfGR
         9XCSIbm/WUCjNWZehf6zg/1z56z/cribPR36FelAalSawsbLvmGW1K/GJ8psYH25WyNe
         pLz8NTHW/zJsSd1l+jcK9+dWLN2TTgJIctXJC0DV1AHmRY5rKTgPwqWXTTSTJCvgklUI
         B5a+b/QexzZsaBOBL17g6c0RURxbJxxpAKYjCRI6cPgwbIhyZUoRGMDs9q6mR4UoLBRB
         VzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8ox4X6Kk0enKCc/A9AHBpc7VBPunmE88lXBu9cwNXs=;
        b=UR6xttvK3EtEBmWGE1qTtf2jvjFrGDZ5CnMdkrT9YXC+o4Ds7EWvUfzjmPbgYPPIjl
         +2idPkeURVfzr9uruZ2o/ty/q52IYk80ZMD6uwHMzm3UEooGaRlce82Z7PaueTRzRuB0
         ukEFCUvQqEhTtraBzmqZdbTn9qJPvcmoYwB15THqtYXf7isTAK/ovwlTJATAEWp30Uzh
         27ydny6PI532a8tEUZpFgZoE0TG9jd2af4dXOhfcr/5T2sqxUUXpcKQNaM4WqrnEOAzA
         O6uRVPIm+Lz5/CJHygMilxJ9yjdUA4dLjxcZKT/VtXxYb4EmzIzDbGULhLOGyEmDoONQ
         jIdw==
X-Gm-Message-State: AJcUuke0e/Ae5ajWdZ1LXQDKa1tYMHSnzQNrujLGbwZWJeofdldZdMJn
        Q/dsymH9bZnUfMEBTy/qeaH6gNtdQIOvfarjdMpx7Ka/
X-Google-Smtp-Source: ALg8bN6UAnnJ3i8uKCBO2U9WPO3B2/C6M/Ah+zEuQ8FANPGlRsWe2oZITH57sEOm/0Rcc5fLiNenSWFSBE7rt+WzSWQ=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr23932628ljb.104.1548844312173;
 Wed, 30 Jan 2019 02:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20190129051859.12830-1-koraktor@gmail.com> <20190129051859.12830-2-koraktor@gmail.com>
 <20190129131151.GB22211@sigill.intra.peff.net> <CAPig+cRUCmaiYqKG6ON==g1sFph-hz6nK5fTYc-9w2JaNFmdLA@mail.gmail.com>
 <20190129223529.GB1895@sigill.intra.peff.net>
In-Reply-To: <20190129223529.GB1895@sigill.intra.peff.net>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Wed, 30 Jan 2019 11:31:15 +0100
Message-ID: <CA+xP2Sa9mSaBaYgY4LiAwaqX_YN75NV0qA=sTy0D6X1q=SjQeg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Setup working tree in describe
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Di., 29. Jan. 2019 um 23:35 Uhr schrieb Jeff King <peff@peff.net>:
>
> On Tue, Jan 29, 2019 at 03:53:40PM -0500, Eric Sunshine wrote:
>
> > > > The implementation of --broken uses diff-index which calls
> > > > setup_work_tree() itself.
> > >
> > > If I hadn't just read the rest of the thread, I'd probably wonder why we
> > > are talking about --broken at all. Maybe:
> > >
> > >   The --broken option similarly needs a working tree. But because the
> > >   current implementation calls an external diff-index to do the work,
> > >   we don't have to bother setting up the working tree in the
> > >   git-describe process.
> >
> > This rewrite left me slightly in the dark since I had to infer that
> > git-diff-index calls setup_work_tree() itself. Perhaps:
> >
> >     ...an external diff-index to do the work, which itself calls
> >     setup_work_tree(), we don't have to bother...
> >
> > But that's minor.
>
> Yeah, my reasoning was that we handed off to diff-index, so if it
> doesn't work, then it has its own bug. ;) But I agree it is probably
> better to just be explicit.

Thanks for that valuable feedback.
Is there some trailer like "Co-authored-commit-message-by:"? ;)

>
> -Peff
