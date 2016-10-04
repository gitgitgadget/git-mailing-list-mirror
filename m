Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFD51F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 06:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbcJDGuw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:50:52 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35263 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbcJDGuv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:50:51 -0400
Received: by mail-yb0-f194.google.com with SMTP id y19so2017097ybi.2
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/vATMq+MRJvJEKam2lTDerZW9vZgm58d1YTEAzQniU=;
        b=WQaGiWMpS8VObZ59upT6l2ht700ru8XRw1Og1w4ermz8Ywvs3ffyZ3pcRF/YFlnaee
         Ps0x2KGfmisBhlydeEqyop/t+5pzNn1gJovVFOOHZjVAirL0/GrhJ55Da9Y0sdP3t1x7
         MxAYzV+QUgCLWsX63iOa+FdZDxTxe6oqXTgFkucVhpvxFWzprx0wfw+FArf9bm30A1nW
         9ZbSoMtlTyDDmMUPql0BkZdRea+RB7R4LqwIZ3eH5f/EW0YGRadKgdjFjFInYwBSvtMK
         Qf/pr2cl7ye3tky45BMcv27y80Stn4NYACd3pNRAYCLMVq/OmESVG4Us/DACRKKLIH2y
         2XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/vATMq+MRJvJEKam2lTDerZW9vZgm58d1YTEAzQniU=;
        b=MXQyh9Q6YYTLGbnMBJA1qusiI5A9zc5LOFxg+ISWCN2+B+JF+fNhSoWu66mmKEFr24
         rbsP8zJcmu3F3OyCbCMLllwxXoadV2o4ju+S/+mjb2Fs0JCajZpsHieM/JcD+/HB7roZ
         0nJBJqNxkx6xzs4lXIEnaODUKjrjrfoc8O5bZZeuIZpODsLOdyVWPeRYSzTJy2CILCoR
         FFLO4Wc0KqzHY99O0RxRxTgd5R6JQ/E8wOrZkjCgQa3VjwkjOCeXXdtsUbeaLSKs4pJ/
         OZIWy05cm4dVQ0xwbtCw2q2q9ClIEmCu/4Am+FXfl3wZwD+RQ1VfnDORc+zwnouxGnqx
         +ohw==
X-Gm-Message-State: AA6/9RngYnZKnBfneoV+22JmGPB4NvO63+AFGEclsmzNsjbtCyTjLR3VbU3VthDDkSMxIjgj4R1gPbbfjilGUg==
X-Received: by 10.37.192.208 with SMTP id c199mr1441161ybf.194.1475563851008;
 Mon, 03 Oct 2016 23:50:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:50:30 -0700 (PDT)
In-Reply-To: <20161003203622.7uz76ay5f7bqqpfm@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203622.7uz76ay5f7bqqpfm@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:50:30 -0700
Message-ID: <CA+P7+xr9ugWWcoyQ6dToFacwff8rGJhYJNxy+E5_iGjubONLPQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] sha1_file: always allow relative paths to alternates
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> We recursively expand alternates repositories, so that if A
> borrows from B which borrows from C, A can see all objects.
>
> For the root object database, we allow relative paths, so A
> can point to B as "../B/objects". However, we currently do
> not allow relative paths when recursing, so B must use an
> absolute path to reach C.
>
> That is an ancient protection from c2f493a (Transitively
> read alternatives, 2006-05-07) that tries to avoid adding
> the same alternate through two different paths. Since
> 5bdf0a8 (sha1_file: normalize alt_odb path before comparing
> and storing, 2011-09-07), we use a normalized absolute path
> for each alt_odb entry.
>
> This means that in most cases the protection is no longer
> necessary; we will detect the duplicate no matter how we got
> there (but see below).  And it's a good idea to get rid of
> it, as it creates an unnecessary complication when setting
> up recursive alternates (B has to know that A is going to
> borrow from it and make sure to use an absolute path).
>

I think this makes sense. We already normalize a path, and if the
normalization is too complicated, then we (now) fail nicely so we
should always have an absolute path to the store.

> Note that our normalization doesn't actually look at the
> filesystem, so it can still be fooled by crossing symbolic
> links. But that's also true of absolute paths, so it's not a
> good reason to disallow only relative paths (it's
> potentially a reason to switch to real_path(), but that's a
> separate and non-trivial change).

Hmm, ya using real_path would fix that but I definitely agree that's
not trivial and can be done in the future if we think it is or becomes
necessary.
