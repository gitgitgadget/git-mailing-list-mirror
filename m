Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1701E20282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbdFNSzY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:55:24 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35687 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdFNSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:55:23 -0400
Received: by mail-pg0-f45.google.com with SMTP id k71so4024896pgd.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wb4VQaC3qSal5ePn9umfcD/YSi39Q1XNB9i3ayExRkw=;
        b=uY1kwlQ5JEhHRXbQeYFbjIqJ+7Owfax+Gr89rxhzu2J9pxAplSBW6UdD/9coYBLK2x
         mlDaCronB+BqAnwiiWchj6YRke2790PS/PQVZz9g0NPIWXqvaLnUz9NhVNqnchpGy0BP
         mznFv8i3fVkkxLbi6Zz/pzLJDclKdxavo19BxNnssW7b90xwHJT0Zw6NdYcfVd+i596e
         x41wF/Tqz+CSfVWR08g8ZRx/PXd+Zbmmy5lkb8eiSuqoutU15itxYTdBi2st9SOXRxf3
         QyCvl5md7tWI7ll24MmdZDNOmPNcHOT0Pjc+WBGZvN6gM7ErQINVroe96B8ge5TWgauS
         B2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wb4VQaC3qSal5ePn9umfcD/YSi39Q1XNB9i3ayExRkw=;
        b=oJy7PQ1E9EkH2dL51QpTKr3NUH57Ieqi8K1+gR68xbUg5PYeXdwFS0HOh5SaIVO5CG
         fIO6qaooyBxvWScidlpJIAcmt20HXd4jy4TqAykrD82WPQKoNYrph6OWP/PRhoOTjXfD
         Hbw1ch0BX4/WDDAGYO49G+JbBuZ5ejexpNH9/0wlw7ZNyuXtYSePxB64LvuUqa6tO1Nf
         0BwIBbSpYxCLZKdJ+VRmlkECLRt/DoGlFQd+lEH3+VAXIZ4ubQuMjgdlBkY/qFJuxHZl
         BlaURthv9Sq+s9y5KrFGLqTlLw3160X38bP0FftI7vBNgoZgZTFJY+VPh3LfSGqRFJUo
         BaRw==
X-Gm-Message-State: AKS2vOwZ61/PBc6VajbGRYyiNu12Hx/tfhAxrlOHP776pu2qTLrsI1lV
        JNms55VbQI+DPybr8JUuKQ1aFZ3jq1hXkMs=
X-Received: by 10.101.76.201 with SMTP id n9mr1449276pgt.40.1497466512526;
 Wed, 14 Jun 2017 11:55:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Wed, 14 Jun 2017 11:55:12 -0700 (PDT)
In-Reply-To: <20170613155158.2454d9c7@twelve2.svl.corp.google.com>
References: <CAGZ79kbq3XiP8W_01FV133aMjZP9_GvpEg86N=XC2rTy24ZZGQ@mail.gmail.com>
 <20170601002429.3470-1-sbeller@google.com> <20170613155158.2454d9c7@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Jun 2017 11:55:12 -0700
Message-ID: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
Subject: Re: [PATCH] diff.c: color moved lines differently
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 3:51 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Wed, 31 May 2017 17:24:29 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> When a patch consists mostly of moving blocks of code around, it can
>> be quite tedious to ensure that the blocks are moved verbatim, and not
>> undesirably modified in the move. To that end, color blocks that are
>> moved within the same patch differently. For example (OM, del, add,
>> and NM are different colors):
>
> [snip]
>
> Junio asks "are we happy with these changes" [1] and my answer is, in
> general, yes - this seems like a very useful feature to have, and I'm OK
> with the current design.
>
> I do feel a bit of unease at how the emitted strings are collected
> without many guarantees as to their contents (e.g. whether they are full
> lines or even whether they originate from the text of a file), but this
> is already true for the existing code. The potential danger is that we
> are now relying more on the format of these strings, but we don't plan
> to do anything other than to color them, so this seems fine.

I will add comments into the code for that.

>
> I would also prefer if there was only one coloring method, to ease
> testing, but I can tolerate the current multiplicity of options.

I *think* by now everyone involved in the discussion agrees that we
want Zebra + optional aggressive dimming (inside blocks as well as
at bounds that are not adjacent to other blocks, i.e. anything
non-adjacent to a different block)
