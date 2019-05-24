Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFF81F462
	for <e@80x24.org>; Fri, 24 May 2019 12:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391214AbfEXMje (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:39:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37212 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390781AbfEXMjd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:39:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so14194607edw.4
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LQcpK0XInpJB/z+7GQt5L3nOig42b7e7WNPpoKIm5Zo=;
        b=gsInTgIymsjGdol+N+ps6cz3UbSwMhMjiGlUWQ6mYkqCUCf4h6HkAX2Ge6KkFTsH62
         26hFnlYl3HfKQjDY/TjJGxXGwBHESCDRbe/l9ul970YrTLiR/BXEcazs/Ioe7fn4bGLD
         HVCG2UJxnNwxHN/P+5Z3+gMt6PsgwYO/pPYgzYbiu+NxFRl+n9tfUxwTL8HF1MeJiCM5
         50pdeHEdvQg17V3fcteynp+e85th1zhaRkLtmKIejqpbXIwOrQUesHR6DIIZgt32IpyC
         eYyyuVXWz6+HwBabDoRi4s0Cr9a/V/xkXfwBYfYnwNfqgTFY944d1ecoE+Gv3pw6CuUi
         SS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LQcpK0XInpJB/z+7GQt5L3nOig42b7e7WNPpoKIm5Zo=;
        b=nBHw0U9gCThxkFI+XrvMuGN25XrJHLaZ3Nv9fKeuYBIUSK2dvypGQSLcJMfTsf4eL6
         XVOPtXMHLoWKqAiTV8+SphUddcH5ZtYQeR+hEiLpUorHrhAw4ltNd1ds7Gdg3vct6vTa
         DXww/iiqKHW+hWX0XCl0wdQOZAp1upGvKe+sVvr9D33AziPzv8pt937ZI+Va4LzpiVrL
         xvPB90aJtf+M64/znrueX2e46ZUiHOUmWX5oUcw7yG2dl9NHBDsIW3smVC0T6YxTylfd
         8+FuX6CvE1/9KUOBKiJ9d66UvG8shaMmJy9Wp2Ruh10MYX87MA36OGKFAnm/5IFLds9K
         k3qg==
X-Gm-Message-State: APjAAAVBhWqasBr82CmZ/t/Wil+QWRBNvaGMsjfvm7ZeFCutNxmC3VSp
        GL4QWVyVswfczhPAmSERE4FPcK/5xrEBxl/oNGw=
X-Google-Smtp-Source: APXvYqwtHR/YNVLZ/cAuJN/9CXE/56QGozwPEgNc8XH3ld0GFjR3FGvNodqHMohfbwYaLgqUuBUc16RusudwDY9OVCg=
X-Received: by 2002:a50:94ed:: with SMTP id t42mr105180723eda.288.1558701572069;
 Fri, 24 May 2019 05:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190524120318.4851-1-chriscool@tuxfamily.org> <87ef4of3g6.fsf@evledraar.gmail.com>
In-Reply-To: <87ef4of3g6.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 24 May 2019 14:39:19 +0200
Message-ID: <CAP8UFD2HJ2D9Sndud5Wu7Vyz9Jj-mVkpE4oowd3VaXoV3nugcw@mail.gmail.com>
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 2:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, May 24 2019, Christian Couder wrote:
>
> > If someone wants to use as a filter a sparse file that is in the
> > repository, something like "--filter=3Dsparse:oid=3D<ref>:<path>"
> > already works.
> >
> > So 'sparse:path' is only interesting if the sparse file is not in
> > the repository. In this case though the current implementation has
> > a big security issue, as it makes it possible to ask the server to
> > read any file, like for example /etc/password, and to explore the
> > filesystem, as well as individual lines of files.
>
> Removing this is a good idea.
>
> Just to clarify, what was the attack surface in practice? We pass this
> to add_excludes_from_file_to_list(), are there cases where it'll spew
> out parse errors/warnings that allow you to extract content from such a
> file?

Peff provided an example script in:

https://public-inbox.org/git/20181108050755.GA32158@sigill.intra.peff.net/

> Or does it amount to a DoS vector by pointing to some huge (binary?)
> file on-disk, or a security issue where you could via the error or
> timings discover whether the file exists or not, something else?
>
> I wonder if server operators need to be paranoid about the DoS from the
> issue with <oid>:<path> noted int/perf/p0100-globbing.sh which this is
> presumably vulnerable to, i.e. someone with repository write access
> uploading pathological patterns. That might be particularly annoying for
> e.g. GitHub where the fork network's object storage is shared.

In general servers should limit the git processes they launch, but
yeah it might be interesting to look at that too.
