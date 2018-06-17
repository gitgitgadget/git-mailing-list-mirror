Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E361F403
	for <e@80x24.org>; Sun, 17 Jun 2018 07:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeFQHDA (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 03:03:00 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37489 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbeFQHDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 03:03:00 -0400
Received: by mail-ua0-f193.google.com with SMTP id l14-v6so5472340uao.4
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=65gqG8K8mSHGDbMtQ46q/6E07Naz7g813ABSPkichhg=;
        b=SUhQEWvnkTNQVA6/6w3tE9H+4HRBFyhBZVgeZpqD2nFO/tEe+vkwUaKsUkav1aloGl
         nkgglVYU6p04sNhc5x49Z/VSlU1fwzbPY5fAZe6SHQNWUMGKKrZQ+dFH8XkIkJSnuXzW
         Ki2ZtrWz0QVPqojyYUTbRih89412Ujyf6RG3E6usQ/GrjiIZULwdu6sw732jghgooW8p
         r3u9MdKT2Zwlwgs7RSYn0yoJhUDjemLF8kwwp1cI2/oAUpGTkHiQnKb4Ps22IZLow+gJ
         YyaKX/ILXCIVS4lAJpxkv08695ZcI2V9AaPq/NRT0YQfMdg5aRg86ZzlubTWfj2pRTN0
         L4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=65gqG8K8mSHGDbMtQ46q/6E07Naz7g813ABSPkichhg=;
        b=lbbxJnyDjLLAa0hwGoV15DdoZkc8RlYoP9L0sOAJVu982R9TNdMnqLRhoB3Xox2d7B
         yYcbMEi2PKUTyeHh+2f4NZcAfiJWDkiuxpMafoycMWeqEbIvrKEFzvwBhv69kjeasTnx
         YMLDxPMCokDMPoo+cyF+xnU8M6GobcJgR3i1Sv+aA+tF3YlGlq/BYSMtutZZOMgyLY7C
         f8pghDpATjXApDeNluGvBNDQAP8qOaGHIvAAW/CNGtpXJYK4r2NZN4IOzEy8wNGtrAnH
         dS/x2HfoUBdqh3YyR34AtRYzOveqCuKlwYKeyw2avV0ySzZ9gyXJY3/EFuATxZvOufjl
         n/qg==
X-Gm-Message-State: APt69E3d7/MP34IkvMhhkuMIDXfDMVMeAXWlCrC5Yv+YlaHyRMXnGAb1
        3lK7y8WAicJjo2AYXsQOax+ReQTtxUxqtRoqnY4=
X-Google-Smtp-Source: ADUXVKLXD07sloYtLSwqvHNKjyw+GGgrQgSxrWB8QTHb/XLSBsObpAbHOYqaYrbzTKaenSkayb1CrGOLn/QBGgLxrNY=
X-Received: by 2002:a9f:3091:: with SMTP id j17-v6mr5057098uab.23.1529218979135;
 Sun, 17 Jun 2018 00:02:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 00:02:58
 -0700 (PDT)
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 17 Jun 2018 00:02:58 -0700
Message-ID: <CABPp-BG1n4u78JScxrnUc1gecXFjKbwLWMxKKs+ZO17DdH3zvg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Kill the_index part 1, expose it
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 10:41 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> This is the beginning of the end of the_index. The problem with
> the_index is it lets library code anywhere access it freely. This is
> not good because from high level you may not realize that the_index is
> being used while you don't want to touch index at all, or you want to
> use a different index instead.
>
> This is a long series, 86 patches [1], so I'm going to split and
> submit it in 15-20 patches at a time. The first two parts are trivial
> though and could be safely fast tracked if needed.

You post this small little patch about unpack-trees.c, mentioning you
don't know if it's even correct, and bait me into reviewing it and
then spring on me that it's actually nearly 100 patches that need
review...   Very sneaky.  ;-)

> This is the first part, which kills the use of index compat macros
> outside builtin/ and expose the_index in all library code. Later on we
> will ban the_index from one file each time until it's gone for good.
>
> "struct index_state *" will be passed from builtin/ through the call
> chain to the function that needs it. In some cases, "struct
> repository *" will be passed instead when the whole operation spans
> more than just the index.  By the end, the_index becomes part of
> "index compat macros" and cannot be used outside builtin/
>
> Part one is mechanical conversion with the help of coccinelle. The
> only real patches are the first and the last one.

Thanks for the nice division.  I read through all 15 patches, though I
looked at the first and the last a bit closer.  I'm not familiar with
coccinelle yet, but it at least looked relatively straightforward;
would be good to have someone else double check that patch.  Other
than that, the changes look good to me.

Thanks for working on this!
