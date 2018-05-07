Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B6F200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeEGXfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:35:44 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34136 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbeEGXfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 19:35:42 -0400
Received: by mail-pg0-f44.google.com with SMTP id g20-v6so13650837pgv.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I7BPl2pBqllFv3fEBaGxRGjLb0WnFdrw9VXXAKegpf0=;
        b=Fwoq49OdSHaIUVm9TcEO52gw6S+ObwMZ3MDX3lSvyZ5UtbwNMKMW0y6wzDagHin2SV
         zrQJrCnwNzHyot7W7cTvE4GQ2RuyHiaYJZA7rpXhuS0AGqtc1astp/LrjV0TpHHQyCHI
         SapEFjDci/g16x6+du50oATHHXamG93rFi5xSrEC325lzRpjrhaeYkqkNv8O2fvY4+Uy
         ulDpOc+MtvMt890jWdW07x1oOtwf5XFk2FduA1Pla4we2zKl2vjK/dmSPfg4xvKM6Y+5
         Ks40/8I3ybZ3WlLha8NxoHx45nVvb13je4SJ+AFz+vNquyy/QGDZrWKKnz/ehSuxd4on
         sDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I7BPl2pBqllFv3fEBaGxRGjLb0WnFdrw9VXXAKegpf0=;
        b=FL3vW0aYVvFbO7MoSC5hZE3p1fhgGFiZd30EyoAxzbkXVT+/O/EL42PWe4OzRU1HWm
         TUnBC7VQBfS9lidA0sut+4ykzgVPHf8WxtXoiyJBPGHpU+RXPn14b4DBI+FEZP3zZmvs
         MiV4PIj/oAtm5f2VpI0bqEOGTeGt9tnknoCSC9CGyYwvBXYUCTMELrqtvYYuFFdQai8H
         M7sghhKk6xG46SyUZvqhfdUDPklgY2uftoWlChA47zAYjVB44Zrq/QhxHkjJrXdJPRJ1
         WvQ1CrW8+5C0+NswipGKyNYzDKc7vBydM0XQb7PEvLBDtPgB2HC9xVfjZtuhkmizl9vz
         dyEw==
X-Gm-Message-State: ALQs6tBEF3/l9hHmEnkVOF2aoWkXghhcYSu+pZNcLbL6JrXftP25pPRt
        NLMfxTTt8cYhkmVNAwRoYdHSyw==
X-Google-Smtp-Source: AB8JxZofBAfVzugHNzquxsU5aioDcdjvw7YMOAf5PqQhRSJQKeyIln2zgW+kVCE+bgmNqTxFGC3EhQ==
X-Received: by 2002:a63:b908:: with SMTP id z8-v6mr30878645pge.436.1525736141460;
        Mon, 07 May 2018 16:35:41 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e0dd:ed95:919f:45e6])
        by smtp.gmail.com with ESMTPSA id 206sm40858353pfy.51.2018.05.07.16.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 16:35:40 -0700 (PDT)
Date:   Mon, 7 May 2018 16:35:39 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 7/7] contrib/git-jump/git-jump: jump to match column
 in addition to line
Message-ID: <20180507233539.GA77370@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
 <326d07b48654ab2a64d09eb17d995a26d06bcdb1.1525488108.git.me@ttaylorr.com>
 <CAN0heSoiOd-oXj_0kJbc2qQCQAortCuXERpxF4Cro8pi4x1eBQ@mail.gmail.com>
 <87d0y8y84q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0y8y84q.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 08:03:01PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Sun, May 06 2018, Martin Ågren wrote:
>
> > On 5 May 2018 at 04:43, Taylor Blau <me@ttaylorr.com> wrote:
> >> Take advantage of 'git-grep(1)''s new option, '--column' in order to
> >> teach Peff's 'git-jump' script how to jump to the correct column for any
> >> given match.
> >>
> >> 'git-grep(1)''s output is in the correct format for Vim's jump list, so
> >> no additional cleanup is necessary.
> >
> >> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> >> index 4484bda410..7630e16854 100644
> >
> >>  # use the silver searcher for git jump grep
> >> -git config jump.grepCmd "ag --column"
> >> +git config jump.grepCmd "ag"
> >
> > I think this change originates from Ævar's comment that it "also makes
> > sense to update the example added in 007d06aa57 [...] which seems to
> > have added jump.grepCmd as a workaround for not having this" [1].
> >
> > Somehow though, this approach seems a bit backwards to me. I do believe
> > that your series reduces the reasons for using `jump.grepCmd`, but
> > regressing this example usage of `jump.grepCmd` seems a bit hostile. If
> > someone wants to use `ag`, wouldn't we want to hint that they will
> > probably want to use `--column`?
> >
> > Is there some other `ag --column --foo` that we can give, where `--foo`
> > is not yet in `git grep`? ;-)
> >
> > Martin
> >
> > [1] https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com/
>
> Yeah it doesn't make sense to drop --column here, FWIW what I had in
> mind was something closer to:

Thanks; I wasn't quite clear on what you had suggested in [1], so the
attached diff is very helpful.

> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> index 4484bda410..357f79371a 100644
> --- a/contrib/git-jump/README
> +++ b/contrib/git-jump/README
> @@ -25,6 +25,13 @@ git-jump will feed this to the editor:
>  foo.c:2: printf("hello word!\n");
>  -----------------------------------
>
> +Or, when running 'git jump grep' column numbers will also be emitted,
> +e.g. `git jump grep "hello"' would return:
> +
> +-----------------------------------
> +foo.c:2:10: printf("hello word!\n");
> +-----------------------------------
> +
>  Obviously this trivial case isn't that interesting; you could just open
>  `foo.c` yourself. But when you have many changes scattered across a
>  project, you can use the editor's support to "jump" from point to point.
>
> I.e. let's note what the output format is now like for 'grep', and no
> need to change the jump.grepCmd.

Applied (mostly) the above patch to my copy, and will attach as part of
v5.

> The above patch may be incorrect when it comes to the line numbe /
> column number / format, I just wrote that by hand.

Yes; the only thing that was wrong was the column number. The "w" is in
the 10th 1-indexed column, and 'git grep --column' uses 1-indexed
columns.

Thanks,
Taylor
