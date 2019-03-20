Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB6F20248
	for <e@80x24.org>; Wed, 20 Mar 2019 00:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCTAlX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 20:41:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53506 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCTAlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 20:41:22 -0400
Received: by mail-it1-f194.google.com with SMTP id w85so4851727itc.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dH/qGYKSpQtY2dA5/AT4FC2fPiN7oHm/0R5v0udeFeM=;
        b=je0YuKf34UIq39K03YLz8B+Kyl0XmdyrKs0s+DjS+kvJG3wmaGSJwkFD1xYlO/wzFg
         75g6rgQCWaJcUwQv5RT/y3dgxAS497AgYFAH5nPJFUjHhQeQxvYxjM1z6z0NEVOUSYRt
         wzXwUIqzSmC2oClQga4h80h2ON2TYf0yA50hWUS3EqOWzacZr0YvABGmbvay5p4KUDUm
         w8nubThjvQtIFBnDAr65kXLo2Zr2MCoEjaJFiieEPJd1NwsO+k24xSw/8bEcrl5+LfzB
         7c9JMUrHQ3xwITG8LNsaS0V/ojiY5fZ26AomCirapn01Hc7vHbdH9KnNqBMtPiyAHHSC
         Y8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dH/qGYKSpQtY2dA5/AT4FC2fPiN7oHm/0R5v0udeFeM=;
        b=d3dETvmREb68+at4qW8rN4CPPt01lt9Dd4rHaEVrJ4maGtVKyTVss/vlUOcumDwMe/
         iML/3pDirPRI2mCfSwggvA3CjhS5TgO0xJZuIXHTMnqwxxZdVw7yTJkBUY55h/ppCexF
         lSGD7C15VdorSpODobS8XVyly+GQnSg1MutRgNC45HJc00PMpiqWFbdbltwPw2btgYcl
         W6CFKFo2PGckCOhbBmY9DURowyS1DEm2v/dgs9ZT1wcsNvkyFs3v85quYuGv+D+dBTgm
         FIdd8oa8RfH6Nl3afT8UhmL7RuyNCdd0ztUv+mi8aoD9yFeSGHz7+dTvNGK+jlZFeyGV
         s7Pw==
X-Gm-Message-State: APjAAAWCSEeBVLIOnBnbZrWLQZC16np9cFmojF2Xf1JArwb6cyNGWAcb
        JSG7XZ4dmG3kY54q8scBvJR6hBVbZ7WpOhdUwvo=
X-Google-Smtp-Source: APXvYqy/k3tESCqHHsRCVBJvA8ma1s82nESbmndjMx/B3rrMUGlpRn9kCpT+2Sazy7lPQt26jlZJWzbdoojbVzeqv2U=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr3793454ita.10.1553042481333;
 Tue, 19 Mar 2019 17:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
 <20190319093910.20229-1-pclouds@gmail.com> <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 07:40:54 +0700
Message-ID: <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 7:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > If you have staged changes in path A and perform 'checkout
> > --merge' (which could result in conflicts in a totally unrelated path
> > B), changes in A will be gone. Which is unexpected. We are supposed
> > to keep all changes, or kick and scream otherwise.
> >
> > This is the result of how --merge is implemented, from the very first
> > day in 1be0659efc (checkout: merge local modifications while switching
> > branches., 2006-01-12):
> >
> > 1. a merge is done, unmerged entries are collected
> > 2. a hard switch to a new branch is done, then unmerged entries added
> >    back
> >
> > There is no trivial fix for this. Going with 3-way merge one file at a
> > time loses rename detection. Going with 3-way merge by trees requires
> > teaching the algorithm to pick up staged changes. And even if we detect
> > staged changes with --merge and abort for safety, an option to continue
> > --merge is very weird. Such an option would keep worktree changes, but
> > drop staged changes.
>
> I think "checkout -m <otherbranch>" with a dirty index should refuse
> to run; there is nothing to "continue" after such a failure, so I am
> not sure what you mean by "an option to continue" (iow, I do not see
> a need for such an option, and if that option makes the whole notion
> strange, we can just decide not to have it, can't we?).

We have --force to continue even when we have local changes, which
will be overwritten. I was thinking a similar option which gives us
permission to destroy staged changes.

Refusing to run fails the test suite though (I tried that even before
this patch), in t7201.10, "switch to another branch while carrying a
deletion", because of this line

    git rm two

--=20
Duy
