Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F761F453
	for <e@80x24.org>; Mon,  1 Oct 2018 07:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeJAN5m (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 09:57:42 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:32922 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeJAN5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 09:57:41 -0400
Received: by mail-oi1-f177.google.com with SMTP id a203-v6so10363334oib.0
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=channable.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftQYI7/oxjPkeVhwkvw7Wsa+JjACeo69q4wPof1Bw6E=;
        b=S5/85oaHawyQ/uDEpCRQ+liPi0Ydh7/Pg3qWzufshnkTbIkrZwBVOz3rYc3DRgPuv6
         9Sx+jCMj1S0mUtWPf0VnBZj3liHh8VDypKo+AdQTgWgz1ZOVGJquz5zHlO44wOs35+Bp
         3Hx8ICpxIWx0poD0whu8mae2Plgt43q0O9tDDvGO5NZLz5fTuXocBSAzhnbVaqFzdlgo
         yqFPMXMb/NOMw3qCwnAGSQnIbnbd/Dxqx0AqmFWHJSbosGzYHaayeerL6Rr+Y9nrSJiB
         HZStupOMMI2yQvXGxKS5Lr4Ww9S/txG2TRAd0lXhjgjjsJ5xxrV7w/baGNdskXXQwd7U
         pHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftQYI7/oxjPkeVhwkvw7Wsa+JjACeo69q4wPof1Bw6E=;
        b=p4jvEszNsRh9WKiw6teIvH5TESvxAcrRSjNTU7DYqCQ4aI9AZIJPrI9tsZJWO/leWg
         ZBt8TCgj5e1Y/Rj7gpVu3pxlRmQ47WgWOiLsZyyGRgn46AJhnAHuOZqoKyW2DPtIZJj3
         zPRBBSgSb8Ay3eDmzO9ZuMPRcDEBnKOEKtxvHteyryd1sBzo/D1gRt2jVvJXCgTdK8YC
         eE4CQO56823v/973oJIY11erf/jgo3XAyWHNdUlVSG1Ws6SjRMllF0no8l1ZTIdKp8py
         tcFaYhBidPF2HyrloTmEQRMRgLv+BMMXcweqoTDtTW8B5PoX2rQS+1r5CEL33cCgkKUl
         /CkQ==
X-Gm-Message-State: ABuFfoh1iKcAsmJgzSaZRsQtYs3H+I64V5p0ZcHb+dsGT6pPpsIi4624
        rYlnnytCuf8FDhDOMO7KIr+6yv4OmfvbMlWlo3uMBQLjZsc=
X-Google-Smtp-Source: ACcGV6396FRWr5Z0BELwTycfaX+XnQoyzl1/84k56dr4g+PhDeNoLxHCayscYba+4+j8JQBeDsBSEfmau9z8jcuavnE=
X-Received: by 2002:aca:f341:: with SMTP id r62-v6mr4226249oih.230.1538378481683;
 Mon, 01 Oct 2018 00:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAqqbi=5Dc2yisSG5r71NGvwS7bfQh_aRpxiTbtFm-XHDqjYUw@mail.gmail.com>
 <20180927204017.GB2253@hank.intra.tgummerer.com>
In-Reply-To: <20180927204017.GB2253@hank.intra.tgummerer.com>
From:   Ruud van Asseldonk <ruud@channable.com>
Date:   Mon, 1 Oct 2018 09:21:05 +0200
Message-ID: <CAAqqbikodPjFBN3eVqNai7MuYCEYPAKC=-8qXopXLwJHhmENLw@mail.gmail.com>
Subject: Re: Null pointer dereference in rerere.c
To:     t.gummerer@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I do believe this bug may actually be fixed in master, by 93406a282f
> ("rerere: fix crash with files rerere can't handle", 2018-08-05).  Do
> you by any chance remember if you committed a file that contained
> conflict markers during the rebase at some point?

I might have, but I am not 100% sure.

> The problem I found at the time looked the same as your backtrace
> above in any case.

Thanks for checking. I will keep the core dump and report back if it
ever happens again.
