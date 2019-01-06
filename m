Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEF2211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 02:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAFCdS (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 21:33:18 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:33544 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAFCdS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 21:33:18 -0500
Received: by mail-it1-f170.google.com with SMTP id m8so4468733itk.0
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjKWzYBmH8Fpr516bMYOONpahHjXj6CLi7GqR4asqhY=;
        b=qbE45nTaaaR6QkT0vncAeza3nIDW/8y30n2WKolU/zzphTdgX16/mBGB5eZArP+Se7
         PvEhVCVEJpv568WQGOCZ1mg4rEb/KQcWTrCFqY6YeQ0Mk2z+C7mO2mMCmTXoqyDjFoGP
         mYWLOC75IVyk2YXhqPccNbdpZHU5SFqCqd5c75iFyIaFzKLLXNxY4B/pI1C/Iu2LKHnG
         wxupA+zY31Nnrj6wlvu/LDPumGQkNcGAjnl/NobIY6gG8IH5RCjLsfnYB04OpZxk5Fia
         Ntz4HGBqDNPaVR0Wts1nEZj+SZuI4GazHpFVlHv4hPlkBdoKx14YlPPhaJ28wQ1k7xCv
         XMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjKWzYBmH8Fpr516bMYOONpahHjXj6CLi7GqR4asqhY=;
        b=ohRw2tMYZE0sNyh7y4oOFyhf3vnx0GOD1zMuc3y3rUbw/gbwe+a8MgDr6LlCEBB9ux
         Yu5/Zh1BBhJbwX3zHpStt9UqbN1uu+ESJSydhS5SjdExCRiTFRn2xEIuePahjAOhk/dy
         /YNFmwkSsQ5rVd8ddzc3G94OYSeyqNfIozymjPim/ljnFtTqmQoDURjDvIdldq8Lksps
         KDxeTp7udv/MLLimZe8O1twuh1GEh5+fFliva3Ps5XRY5kwmi78ySRGRLaF+Q1kYTF0L
         i8yTBig4V5iOqniWKkSHRYEn7eTWNzytdayAQaKrFTUaU4nIUL9/RNmBBFfYLR8qy4Ma
         aHFQ==
X-Gm-Message-State: AA+aEWaITtyIBVxjeQdODwz9nLjZnGJK1wa47DPM/htfT7aKSHMBC857
        N+3RA3dALrfZqzfDpghlYYz7DFmGS/W4otLMytI=
X-Google-Smtp-Source: AFSGD/WcqyXzTiMof7/5lhLcq+N41SSsp6oYlnFQyjJekt3UZpP6dlwk4uwfc+1d5eZSwsL7wFYVaclL4jTOm4SveAQ=
X-Received: by 2002:a02:8943:: with SMTP id u3mr36929611jaj.92.1546741996870;
 Sat, 05 Jan 2019 18:33:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYBX+HrLxbga=VJgC5WjyeDZEznm2UCL+HF8A1YKVo3Trw@mail.gmail.com>
 <CACsJy8Da7+sNfxvTRz1DRn27TjvBXNAipKB=eumA6q+sVsVjcA@mail.gmail.com> <581076b0-95c5-9af9-dec5-5a9bccfe2634@gmail.com>
In-Reply-To: <581076b0-95c5-9af9-dec5-5a9bccfe2634@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 6 Jan 2019 09:32:50 +0700
Message-ID: <CACsJy8A9=sKjoM+3ZoA0-PnufC4MNvP9MPoM9r6FN3sxAcZvbA@mail.gmail.com>
Subject: Re: How DELTA objects values work and are calculated
To:     Farhan Khan <khanzf@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 6, 2019 at 5:32 AM Farhan Khan <khanzf@gmail.com> wrote:
> Hi Duy,
>
> Thanks for explaining the Delta objects.
>
> What does a OBJ_REF_DELTA object itself consist of?

from pack-format.txt

     (deltified representation)
     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
     20-byte base object name if OBJ_REF_DELTA or a negative relative
offset from the delta object's position in the pack if this
is an OBJ_OFS_DELTA object
     compressed delta data


> Do you have to uncompress it to parse its values?

The delta part is compressed, so yes. The "base object name" is not.

> How do you get its size?

Uncompress until the end the delta until the end. zlib stream has some
sort of "end-of-stream" marker so it knows when to stop.

> I read through resolve deltas which leads to threaded_second_pass, where
> you suggested to start, but I do not understand what is happening at a
> high level and get confused while reading the code.
>
>  From threaded_second_pass, execution goes into a for-loop that runs
> resolve_base(), which runs runs find_unresolved_deltas(). Is this
> finding the unresolved deltas of the current object (The current
> OBJ_REF_DELTA we are going through)? This then runs
> find_unresolved_deltas() and shortly afterwards
> find_unresolved_deltas_1(). It seems that find_unresolved_deltas_1() is
> applying deltas, but I am not certain.

Ah I forgot how "fun" these functions were :) The obvious way to
resolve an delta object is to resolve (recursively) its base object
first, then you apply delta on top and are done. However that implies
recursion, and also not really cache friendly. So what
find_unresolve_deltas_1() does is backward. It starts at a (already
resolved, e.g. non-delta) base object, then applies deltas for all
delta objects that immediately depend on it, then continue to resolve
delta objects depending on these children... The
find_*_delta_children() functions find these deltas, then
find_unresolve_deltas_1() will call resolve_delta() to do the real
work

- the delta type (OBJ_REF_.. or OBJ_OFS_...) is already known at this
point. I believe we know from the first pass
- the delta is uncompressed here, with get_data_from_pack()
- the base object is obtained via get_base_data(), which is recursive,
but since we go backwards from parent to child, base->data should be
already valid and get_base_data() becomes no-op

> I do not understand what is happening in any of these functions. There
> are some comments on builtin/index-pack.c:883-904
>
> Overall, I do not understand this entire process, what values to capture
> along the way, and how they are consumed. Please provide some guidance
> on how this process works.

An easier way to understand this is actually run it through a debugger
(in single thread mode). Create a small repo with a handful of deltas.
Use "git verify-pack -v" to see what object is delta and where... then
you have something to double check while you step through the code.

>
> Thank you!
> Farhan
-- 
Duy
