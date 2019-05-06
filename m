Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934401F45F
	for <e@80x24.org>; Mon,  6 May 2019 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEFTTG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 15:19:06 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:47024 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFTTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 15:19:06 -0400
Received: by mail-oi1-f202.google.com with SMTP id h186so4755195oia.13
        for <git@vger.kernel.org>; Mon, 06 May 2019 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ln9fHQ147E3Ly7K6/Svv5T7x7y91lPUVHOsq3ZDPVEQ=;
        b=VTcy2KCi0/4sPn7dFxE5mR++vEAjFTL2zLpVxC8X5cp4+qJl7J5hZqzZXa0cxVLlTD
         2Ltm2Mwsj4XktfTgkmDzkC1gZLMpVLCok+OricBJBlf9DCPZs8R5i+ds1pIC4eW8azmU
         zdlgtiGsO0XsIbzB0A04F/aSP0FIP34WPx/DttBW5rhmaPNbxZH3AyoX1QJ0irZuElI6
         F9bC5VGKiVkywXMD7SdqXqsFryzSWBitWSHnXsEujQb04g3lnFpwUJTKVOwWlh1jvYSl
         ABLdR6LV6Lbw8aL662tJc/G5l0pXc21c3UUAWiw6V89KkgEfW+fpZ8JQOybaxBLmyoNF
         FFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ln9fHQ147E3Ly7K6/Svv5T7x7y91lPUVHOsq3ZDPVEQ=;
        b=LDI6pz+/2LYaYlwIx0JKZcBHd1Tzg1DVpTgXckmIqRmf0+sOncg4U9bKZrGT/PAMzD
         QrqXsOCaM91nYz/PmftCbrFfIIluF3TBHJOwmI0h020jXXalOr02ceOyvFAYsdcVRsUZ
         Zv084yMShau51RPT0jNCjKFCUbn1xwUucH0HGH6KR60VdQpI+iCHd3NAqS5QkMZwZr9t
         Wpj7aoyYsTLOP7CIF1PgElXVX1wHhaZOiy2zc5VjtO83cv3Nu3xrAaQUMImJ3FAbIHTR
         3OsSiiWeQH2d5KR0naRHyNpwj7w+CEyWP7l3FULf2YhmT8e64OviNEXjN/c9OXcsBHiQ
         8cFw==
X-Gm-Message-State: APjAAAXvoXf59BD29j3t5h+wOYgUcTN9bSb0Tpk5ZSI7BpdVnqt1bi4T
        MaGJduUxd9wJGWBAc0O+CUfu5ViFHgEgnXaHGdfD
X-Google-Smtp-Source: APXvYqxdXZNnbB3DRKKT03GmbCjpzO7reFDO7PgTqQ2HI4IuL03q+aqF1Wv3nIBr7t3EA6+XZ0y9UtQgy6uUEVBOP7Wa
X-Received: by 2002:a9d:d63:: with SMTP id 90mr19166156oti.333.1557170345571;
 Mon, 06 May 2019 12:19:05 -0700 (PDT)
Date:   Mon,  6 May 2019 12:19:01 -0700
In-Reply-To: <CAP8UFD1EwUbjSx3+q=9T8KgDz=vv5UH9ObV2z-8VRaQejera7w@mail.gmail.com>
Message-Id: <20190506191901.212221-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAP8UFD1EwUbjSx3+q=9T8KgDz=vv5UH9ObV2z-8VRaQejera7w@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: jt/fetch-cdn-offload (was What's cooking in git.git (Apr 2019,
 #04; Mon, 22))
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There has been no answer to my comments in:
> 
> https://public-inbox.org/git/CAP8UFD3SWNu=btPxV2vV=neYrofbgKPzz_WLvsJbv6bKjRoCpQ@mail.gmail.com/
> 
> especially the part related to the "-o avoid-cdn=badcdn.example.com"
> example that Jonathan Nieder gave.

It seems to me that if you use a server option to blacklist, you can
also use a server option to whitelist. But I don't think this is the
main issue, as you state below.

> > If this version is good with everyone, then this is the final version.
> 
> It is not good for me as I think the "-o
> avoid-cdn=badcdn.example.com", or even "-o usecdn=goodcdn.example.com"
> options, (that has been the only thing suggested to work around
> problems with CDNs that people cannot use or don't want to use,) will
> likely end up to be some other kind of promisor remote but not quite a
> real promisor remote.

I think that the resemblance between promisor remotes and the targets of
"packfile-uri" (CDNs) is not that deep. Even if we have a sufficiently
smart remote helper that does not require Git-specific logic in the
service hosting the remote, promisor remotes operate on the blob level
(maybe tree at most) and does not require much coordination with the
server that you originally fetched from; for example, a server can just
as easily serve "blob:limit=43" as it does "blob:limit=42" without
coordinating with the promisor remote.

But this is not the same with the CDNs. CDNs operate on the packfile
level - we do not want to send individual objects. And the coordination
between the CDN and the server that you originally fetched from has to
be greater - due to the numbers of objects in packfiles, the server will
need to know what is served by the CDN on a higher level (e.g. things
like "everything in refs/heads/* after <date>"), and if we want to even
slightly shift what the CDN serves and what the server serves, both need
to know.

(Also, I'm not convinced that a sufficiently smart remote helper can be
built that can turn a generic CDN into a performant promisor remote that
we want - in particular, if partial clones with "tree:0" filter become
more popular, servers might need to be able to send trees with various
filters: the tree alone, the tree with all its subtrees recursively
(maybe with a maximum depth), and the tree with all its subtrees and
blobs recursively.)

> In a more general way I don't understand why I was repeatedly asked
> (especially by Jonathen Nieder, you and Junio) to dump ODB remotes in
> favor of promisor remotes because promisor remotes would be more
> unified, and now you develop something that is not unified with
> promisor remote, though it could very well be.

I don't remember saying this (although perhaps I did), but ODB remotes
are similar to promisor remotes in that they both operate on the object
level. As for CDNs, they operate on the packfile level, so unification
with promisor remote is not so easy. (And there is the sufficiently
smart remote helper issue.)
