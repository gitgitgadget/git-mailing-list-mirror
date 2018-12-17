Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547B81F405
	for <e@80x24.org>; Mon, 17 Dec 2018 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeLQUne (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 15:43:34 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:51650 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeLQUne (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 15:43:34 -0500
Received: by mail-it1-f182.google.com with SMTP id w18so590222ite.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IgvYvGGu2tIaRpR3mUukh2zgLUCrPqH4/tFO139NKLw=;
        b=SV+9lfU1fCRBxvdpk53yhc0L3gVJS6FG5ZP3Now0ueuR3XCkkMWoLO9GUlJ4ELh+C6
         tdzc/Gnkpfz2D/0TxuqHkdsOG5jsqifpNd4AX34irgAq0mWsQAoFWA12Lk9Lwz4nrQyR
         UJxtUWfqzZIY75SP7grK3ZBFKnCO32aQ3ZpdJ0T6yz/w6UlKi20cI9MxDjkxRPXdBgiR
         +HyZxIZYxNhJ+iVyJyb4aT8hGVZzfCclLQ7ymh2zlxA+rlos2Xx1eqEqetHha/cNiDi3
         R9u1v+MnymgS4BZPq6dOVV2VfJOUQY2pf2G2NhIR17ZJzOqAgVofmHTBW6FkkKs+xuIf
         5tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IgvYvGGu2tIaRpR3mUukh2zgLUCrPqH4/tFO139NKLw=;
        b=uj9Cga6z7m81IIJNqR6sSyEmDNlQl4Zy8d2fD6T2PnvvlLE2fxTWgBZ+rX4zPfONAX
         FO79RiZjOuPU1/Btla4eZok0G6P7JlFT3LoVlmjwVV3Alok1ZspC8XZn2rGMwkrBm1HS
         tVKMiouDO67mSLdEnwpVKowvtiRS8NkI7DRzz0K9HoFkQrHEip2Ul7bUw25gYlPMt0KL
         Le2FFxhHdk2qH67dlUcxDC31sHS82fyGw4j2y4eRxUSLqiCNh0ftVSBmKZXt6gIM0AoY
         +5xlifITZ70Ca6hYcfl3XyqKUIvFOl4MCRqjiNEPbpZh10Nmd5JglfMGIxU+HU5AKiZ5
         UYHA==
X-Gm-Message-State: AA+aEWZWRwc23yluxLBO4pGje9+1yYE8+Qbtugj1T029b0DWWfkg3lpU
        uKMsDinUVLPf62Pr1rb2rBSB7n/TOWqjv+NBPSg=
X-Google-Smtp-Source: AFSGD/Vjua7YeKaacOwiCSAQr602jkwuguc3HtzepwwDMLx7hhcAZOBHY4Bt+esh1Rw0mntAMHfiyqoycyiQNeqnZDA=
X-Received: by 2002:a05:660c:a50:: with SMTP id j16mr552715itl.52.1545079412209;
 Mon, 17 Dec 2018 12:43:32 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
 <CAGyf7-EZaiVBnoBfRJXAK7KdaXzPaDFVocUrB8LQNU_Hi16u7g@mail.gmail.com>
In-Reply-To: <CAGyf7-EZaiVBnoBfRJXAK7KdaXzPaDFVocUrB8LQNU_Hi16u7g@mail.gmail.com>
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Mon, 17 Dec 2018 12:43:31 -0800
Message-ID: <CABXAcUyiJOcZwjSyvCKJC0vKDRbSP21sY_Fa7-WfmQHsczYbzQ@mail.gmail.com>
Subject: Re: Git blame performance on files with a lot of history
To:     bturner@atlassian.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

did hOn Fri, Dec 14, 2018 at 11:10 AM Bryan Turner
<bturner@atlassian.com> wrote:
>
> After you converted the repository from CVS to Git, did you run a manual =
repack?
>
> The process of converting a repository from another SCM often results
> in poor delta chain selections which result in a repository that's
> unnecessarily large on disk, and/or performs quite slowly.
>

Yep I did a repack, using 'git repack -A -d --pack-kept-objects'. On
NFS it'd be even
worse, because of all the small objects Git would have to go through.

> Something like `git repack -Adf --depth=3D50 --window=3D200` discards the
> existing delta chains and chooses new ones, and may result in
> significantly improved performance. A smaller depth, like --depth=3D20,
> might result in even more performance improvement, but may also make
> the repository larger on disk; you'll need to find the balance that
> works for you.
>

I re-ran with 'git repack -Adf --depth=3D20 --window=3D200' and that did
help quite a bit:
  > time git blame master --  important/file.C > /tmp/foo
  Blaming lines: 100% (33179/33179), done.
  git blame master -- important/file.C > /tmp/foo 50.70s user 0.55s
system 99% cpu 51.298 total

That's roughly a 3x improvement, great. I just need another 10x one
and we'll be in business :) Based on
experiments with the Bloom filter, maybe that'll help enough to get
our users on board.

Cheers,

Cl=C3=A9ment
