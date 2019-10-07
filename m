Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3152B1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfJGRUe (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:20:34 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34521 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfJGRUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:20:34 -0400
Received: by mail-vs1-f65.google.com with SMTP id d3so9456273vsr.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5FGraoB1xwAV4GVW1GR8fLaDywLVqvBUj70pHO/p0AM=;
        b=JFbeUYuL0YHy+5Ou8gYkaqpKklZ7rR240OMzlXTgPCKieP3/vr3QkOUCqghxmAARnW
         EzqJ1muJeUado1WrkZ7zmALpdh5Z20EsP/QZoMYb5pxvdTKWmmu+WO/f16qWWmunAymS
         wdTOSvF/89xuaZ1viTkkQGB73f1Yk48dRaeIdgClqEtlGGzRW5v5S7/xv/M7g0W6fuLa
         FIuvWHzpCCDvIb8fgbnLqe+CT+Siai/QQbOXgzVKHQYX1ikDWf9UTfNq+nYSvd5HkKfy
         ux4MixsWA3/wMeOQBdAYEbww0/mSwC42R1NdG/lPPKqO8nWe2b/EGVAQ9F+JzN3DfWqj
         yZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5FGraoB1xwAV4GVW1GR8fLaDywLVqvBUj70pHO/p0AM=;
        b=NEKN4cv+ZHdUJnJeVqaI2gqVcKpTeoaB375PYz9B59SxFhNZrnJ9Zzj9ZxEDo3UQzs
         DNz6vrs0zvj3cwEUHgRwRb7UYGMiKtfcYsQxD0jalebUh0qeaMOvN4Yy8njIkrLK4Nu3
         dChG6q30Z8Y2tJL7K/6UUazPr4NbbOtXIt8/JrtvNrOcpEb/Y6LMm7uGklN8EGz8KqYR
         9SfS8hUGu6ryNyWmHDapKXgvAn3oozaiTxoDy/dsjTOnqXn8zlzAB+Lp98pSsSXSjQ0q
         laqsCAjntxhXMy03BgB6hoivvsEpRjQfG0xkxF+YkP0OkLXDX9RLWCqzI8hrBYMhLujg
         oroQ==
X-Gm-Message-State: APjAAAVgc8xZuwacJ4aaVTcODWAqnjZZcowmMtFSahqkoh9+qiLnxRxv
        ScGlxxx+Vpxkgfh9fxVzjJWLCFNXvgEUeqPcyC0=
X-Google-Smtp-Source: APXvYqxN3fl8HxgaZ7+sQB0/3l1e1AHBYL0sfwuwM5baew8/RnhRaglH88qidwFcaYvACGqgNAkUo7PTm5z+T61EHMk=
X-Received: by 2002:a67:1bc2:: with SMTP id b185mr16478434vsb.116.1570468831852;
 Mon, 07 Oct 2019 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <ee1f00fd-715c-5ecd-bc29-5e5a2de2d0f9@mail.ru> <20191007164310.GA11529@szeder.dev>
 <7b9c0b0b-2a1c-d4d3-13ba-f020ff15d5ad@mail.ru>
In-Reply-To: <7b9c0b0b-2a1c-d4d3-13ba-f020ff15d5ad@mail.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Oct 2019 10:20:20 -0700
Message-ID: <CABPp-BFPrweNZ=ubT+8EE9xPyNjzEuUXKvESmXDb3Mhh37dAVA@mail.gmail.com>
Subject: Re: log -m output
To:     Semyon Kirnosenko <kirnosenko@mail.ru>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 10:05 AM Semyon Kirnosenko <kirnosenko@mail.ru> wrot=
e:
>
> On 2019-10-07 20:43, SZEDER G=C3=A1bor wrote:
> > On Mon, Oct 07, 2019 at 07:14:25PM +0400, Semyon Kirnosenko wrote:
> >> I have a question about log command.
> >> Probably I'm just missing something but anyway.
> >> I can illustrate the question on the repository of Git.
> >> Let's look at revision 1ed91937
> >> It is a merge based on pair of revisions a9572072 and 294c695d.
> >> According to blame these parent revisions have different content for
> >> delta.h file.
> >
> > I'm not sure what you mean by this statement; what blame command did
> > you run?
> >
> >> But when I get log with -m flag for merge revision, I can't see that
> >> file in the list of changed files.
> >> Why?
> >
> > The contents of 'delta.h' is identical in both parents of that merge:
> >
> >    $ git diff a9572072 294c695d delta.h
> >    $
> >    # no difference
> >
> > So 'git log -m' does the right thing by not showing 'delta.h'.
> >
> > .
> >
>
> But blame shows different results:
>
> git blame a9572072 delta.h
> git blame 294c695d delta.h

blame does not at all claim those two revisions have different
versions of delta.h:

$ diff -u <(git blame a9572072 delta.h) <(git blame 294c695d delta.h)
--- /dev/fd/63    2019-10-07 10:16:43.092356078 -0700
+++ /dev/fd/62    2019-10-07 10:16:43.092356078 -0700
@@ -9,8 +9,8 @@
 a310d434946 (Nicolas Pitre  2005-05-19 10:27:14 -0400  9)
 void *delta_buf, unsigned long delta_size,
 a310d434946 (Nicolas Pitre  2005-05-19 10:27:14 -0400 10)
 unsigned long *dst_size);
 d1af002dc60 (Nicolas Pitre  2005-05-20 16:59:17 -0400 11)
-dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 12) /* the
smallest possible delta size is 4 bytes */
-dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 13) #define
DELTA_SIZE_MIN    4
+c7a45bd20e4 (Junio C Hamano 2005-12-12 16:42:38 -0800 12) /* the
smallest possible delta size is 4 bytes */
+c7a45bd20e4 (Junio C Hamano 2005-12-12 16:42:38 -0800 13) #define
DELTA_SIZE_MIN    4
 dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 14)
 dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 15) /*
 dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 16)  * This
must be called twice on the delta data buffer, first to get t

It does say that _how_ those two arrived at the *same* version of the
file differed, but if you compare the portions of the differing lines
corresponding to the actual file contents you see that they are the
same...just as SZEDER pointed out.
