Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97ABE1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPXas (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:30:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35653 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJPXas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:30:48 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so32716553itp.0
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NL9ifrUdKr2RlLxWZqIoTXU7zLuHBp7NH6TnMlFbdk=;
        b=oFwEhm1GHw8MxYFi3AnuDhiVXXGvzgoWDzzPxsUlw9osgEQ+0mFG5BgatLwWn9dUKk
         BNke1fvnUEK44uCIuWXW3FU9FtSfLVvZi7E5HFnjAoQrQQ+CzgHkeOXA4J8pED7tTbxN
         Fy1fBKMfM0QW8l0BmB7ymBeUsC2T9Ri4d/eg20oit6WfO3nxOhXGP7ZNThymg82Fccz5
         CS+kZqIvLZpX5uw5FuylQvDS7xmgX+7wWvCLJxiitm6vwRvmYWumw871BxQyp2QqOcHG
         riRTazJRW36dDIGa9uWQXqtg1zRevIpFb60F9jOvd9fUSV8qCosQwI1ZqPd3mkjfGrXp
         zPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NL9ifrUdKr2RlLxWZqIoTXU7zLuHBp7NH6TnMlFbdk=;
        b=I+zrShnKY2UE35dZluGZs233BGUu3RhFPaihvCpp0MX92OeP+LLj5f+smgFZQF6VUf
         zcKKk0r3KFKphWMnjPGbvOEuH1wiebqat3yciXyCIaF2lyEi4og/NKeCZnWK4FSbifMH
         q4UP/rC5xYaYKyPETzCzqfzj1y9enScT459TjQ+qarLMytoKe6eYPZXfZmLiI1RD+F8a
         5IgC9ZUl16I7P9rvWIYbQ8rqK1Wd/muR/6XyoiOeKorYZQcM5nUE3Xe070gb1Yt20wpw
         SBuoxA6nZEzys+dGfo5elJaRXJ+/uGjRcMthab74m9ChV+l3+Xx2ux+DRv3mwwYLEBJE
         hGbg==
X-Gm-Message-State: ABuFfoghLc6klk0F+A+drrabEVzGdJJTOndEFTKuk2QBA7hGA2eD+6oJ
        2FVqF5tdgyOVnrzDGri3zuhScs6qQ6aXtv7Zzc5ZAw==
X-Google-Smtp-Source: ACcGV61e3J4kMZJE6pm8LP49dpRItiKbU3HzLKxZiveHmgSMht20a4sWvWe0N8drbtXVQGaq8RJplor0CQRmx0mabt8=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr16371425itg.70.1539704387331;
 Tue, 16 Oct 2018 08:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 17:39:21 +0200
Message-ID: <CACsJy8DV2XKy5hAVz9r7f-kGnwmGPfN2JHRG_9UPmpSopd0rtw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Base SHA-256 implementation
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 4:21 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This series provides an actual SHA-256 implementation and wires it up,
> along with some housekeeping patches to make it suitable for testing.
>
> New in this version is a patch which reverts the change to limit hashcmp
> to 20 bytes.  I've taken care to permit the compiler to inline as much
> as possible for efficiency, but it would be helpful to see what the
> performance impact of these changes is on real-life workflows, or with
> MSVC and other non-GCC and non-clang compilers.  The resulting change is
> uglier and more duplicative than I wanted, but oh, well.
>
> I didn't attempt to pull in the full complement of code from libtomcrypt
> to try to show the changes made, since that would have involved
> importing a significant quantity of code in order to make things work.
>
> I realize the increase to GIT_MAX_HEXSZ will result in an increase in
> memory usage, but we're going to need to do it at some point, and the
> sooner the code is in the codebase, the sooner people can play around
> with it and test it.
>
> This piece should be the final piece of preparatory work required for a
> fully functioning SHA-256-only Git.  Additional work should be able to
> come into the testsuite and codebase without needing to build on work in
> any series after this one.

Thanks again for keeping working on this. I'm still sick and can't
really do a deep review. With that in mind, the patches look good.
-- 
Duy
