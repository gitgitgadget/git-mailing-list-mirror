Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59ED1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbeKFEZJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:25:09 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:55412 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbeKFEZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:25:09 -0500
Received: by mail-it1-f170.google.com with SMTP id b7-v6so14295420itd.5
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xB4Rd0pyPgzysjnGQjjuUQ+fWKS7h1wd8kyvAURTH9Q=;
        b=BtpdxdND7WC0y1U9AclFnvpKw3oJTacbMp7INpU2pUKOYlyAPzK72et2KAt+g0Ug0J
         YLP/t7t8wfe4NUuqCF+qGPCLyOw7PMhtOliHv9Vyk8Dcve4Acbi2ZxB43t7gEm19NuIC
         dasnXsnSB83RopCd1kH/J3nmoFWGLFf0wt9Z4u+18raKLlHYobIjQdTyR5wdNjz2jG6O
         dR6PN5MuiMzMfvCFYSUA+l6ZNWFCQubXA4Pqs1ylstInoE7peNBwjnOdkTaq02SbFu6j
         GGCl0rfsOiyw2KzGoQlwX+Vmn5SEQ0wvBZFXVyg+sorjRwAZckwC5wg8ZhHNJrvUMurz
         XbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xB4Rd0pyPgzysjnGQjjuUQ+fWKS7h1wd8kyvAURTH9Q=;
        b=DWCbcRWPdM8+4WO+jPYEQ+kYkrIx9ZWAb0p56VNtzELtHvZLf+SsnsxZrMkxA8Gy8x
         rsevk+8l43RKO0KoXCNO9s41nRLV+NBN3qpk6IyQIcHerL1cRMmAWvXn0rjy5URRniBC
         RUuS3zKbh3i81G5f71/Rp5Ft5czoTwGS4vTUrjKBoHAzBxLMymD6KjA/tDP495vh0QYt
         7cufdd/vlQeU6gZA6dFZBU3xbOkiOxja+jSVb1s55aNapkoC//vrcBOrXiZKrxiiB9wR
         yzsJZfuVFnXzf3fFvOFEUPHGJpIozGBhPLnPOjel+M2kiZ5IImSA4duRlVM2d/kiRlOd
         1XQw==
X-Gm-Message-State: AGRZ1gLCBe9bHVNLiY1cjT7PXWG5JX5aFJ20+0haUKF4eUeOAe6nC7F3
        fH6/SkMRyYtUzxk06mQhk1mNIrgkB+mywnBTGgCXdg==
X-Google-Smtp-Source: AJdET5eJ5mkq4DPT7aNURoPD7Pobv8y7ZM609OKH6BxL25GM1yHg5u7d5z6Drat5JU0z1l16B3aCPBrZN1Hx3/SwP0I=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr20898251jaa.30.1541444645338;
 Mon, 05 Nov 2018 11:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20181105010032.GN731755@genre.crustytoothpaste.net>
In-Reply-To: <20181105010032.GN731755@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 20:03:39 +0100
Message-ID: <CACsJy8B+WAyjrthKs9nr=kLpx7f8k_Dug4rRdYDoBR+mmLHCuQ@mail.gmail.com>
Subject: Re: Design of multiple hash support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 2:02 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I'm currently working on getting Git to support multiple hash algorithms
> in the same binary (SHA-1 and SHA-256).  In order to have a fully
> functional binary, we'll need to have some way of indicating to certain
> commands (such as init and show-index) that they should assume a certain
> hash algorithm.
>
> There are basically two approaches I can take.  The first is to provide
> each command that needs to learn about this with its own --hash
> argument.  So we'd have:
>
>   git init --hash=sha256
>   git show-index --hash=sha256 <some-file
>
> The other alternative is that we provide a global option to git, which
> is parsed by all programs, like so:
>
>   git --hash=sha256 init
>   git --hash=sha256 show-index <some-file
>

I suppose this is about the "no repository/standalone" mode, because

 - it's hard to pass global arguments down to builtin commands (we
often have to rely on global variables which are on the way out)

 - global options confuse new people and also harder to reorder (if
you forget it, you have to alt-b all the way back to near the
beginning of the command line and add it there, instead of near the
end)

 - there aren't that many standalone commands

I'm leaning towards "git foo --hash=".

> There's also the question of what we want to call the option.  The
> obvious name is --hash, which is intuitive and straightforward.
> However, the transition plan names the config option
> extensions.objectFormat, so --object-format is also a possibility.  If
> we ever decide to support, say, zstd compression instead of zlib, we
> could leverage the same option (say, --object-format=sha256:zstd) and
> avoid the need for an additional option.  This might be planning for a
> future that never occurs, though.

--object-format is less vague than --hash. The downside is it's longer
(more to type) but I'm counting on git-completion.bash and the guess
that people rarely need to use this option.
-- 
Duy
