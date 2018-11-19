Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AA61F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbeKTHac (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:30:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37249 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbeKTHac (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:30:32 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so224553iti.2
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCSn6vBBZlWIXJc7wzTbJ9WQxxKlF4ILJ6HcHW09NWc=;
        b=o1hCNi2Lw6Gqdzc5/Z2+SarkmfI5B3AEXgQhTsTcnoCAXa2yfsLG4sHmJ6o/YiMTP1
         hzYn6HmJcw6wSwqNRWZq/sUSPu1Lu6vkXXA9XwhRnX7u7qhXcP6WkxKeEnELJcTkFaAx
         yRjse3J4ULQRqbkLwWChbTj7SrMas5fUXICV9NwwQBz7Am9Inj7NJQ3hPt9atstzx93c
         HzjyKZjXIUtGWg3rPW3TN8oFLynnhX+U+DDGR9f7KpIMO0gn0DB6786GzlTB6GgJyIEV
         E7yOSTOWAcTp6IEmVv/TAU7eDioDQZKgQf8P2A2fpfd4/XsbLqMP8ylDRl2js008A5mC
         nNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCSn6vBBZlWIXJc7wzTbJ9WQxxKlF4ILJ6HcHW09NWc=;
        b=qjB7wLWKseP0UDjnRNDYmAr6hpmd22OyrGAvyIkYuyOyjMEIx6+kXPLM/ngvOmwxVP
         jby/q8tZfEOjFI9W9V7N0h46bfSo1lTEZH96UDE6gWSExKv/ZHtYajs3m72GPw6mYrQW
         TjC7RZ2HxRyrMRKbVAShtiFpG6gAo/+oT4e45QfkkZA0D4U7JrSi/rrjHAuPiYxwD6hR
         oKr5eK37rH8d6Hv9srTq6GK06ngl66N5ajOTVDat1P+VWuZHw8YpngkENzFHHFOtwPjY
         6a0qSOQRmhV22JhpHh3XnE8MFyY39gec2FiLig4i2gcfkubFhjqu7c8bQehUVpZfFKHG
         1L+A==
X-Gm-Message-State: AGRZ1gI+xDWN+IiUm16qIFrH9vWDMoEul4l/nGMVhO1NWCTnKySmcFrI
        hmapdijINk774Ns5TisZJLFMSwNFSoJ0LLwH+lw=
X-Google-Smtp-Source: AJdET5e+qvA0nwF/1JU1yhLd0qwd0huYCIWLGNoexj4vKSOpGd8Twi1jeZT+PlPu/pAb2U6utBvvSDlACy2j3J+7HxM=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr21729977jah.130.1542661504333;
 Mon, 19 Nov 2018 13:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20180817161645.28249-1-pclouds@gmail.com> <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de> <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
 <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com> <20181119210323.GA31963@duynguyen.home>
In-Reply-To: <20181119210323.GA31963@duynguyen.home>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 22:04:37 +0100
Message-ID: <CACsJy8AYnkrYcgR0-WbP-+PnRS4nrx_On58MEbc82t2zD=6euA@mail.gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... and I "dear Ramsay" without CCing him.. sigh.. sorry for the noise.

On Mon, Nov 19, 2018 at 10:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> First of all, Ramsay, it would be great if you could test the below
> patch and see if it works on Cygwin. I assume since Cygwin shares the
> underlying filesystem, it will share the same "no trusting inode"
> issue with native builds (or it calculates inodes anyway using some
> other source?).
>
> Back to the APFS problem...
>
> On Mon, Nov 19, 2018 at 07:24:26PM +0100, Duy Nguyen wrote:
> > Could you send me the "index" file in  t/trash\
> > directory.t5601-clone/icasefs/bogus/.git/index ? Also the output of
> > "stat /path/to/icase/bogus/x"
> >
> > My only explanation is somehow the inode value we save is not the same
> > one on disk, which is weird and could even cause other problems. I'd
> > like to know why this happens before trying to fix anything.
>
> Thanks Carlo for the file and "stat" output. The problem is APFS has
> 64-bit inode (according to the Internet) while we store inodes as
> 32-bit, so it's truncated. Which means this comparison
>
>     sd_ino == st_ino
>
> is never true because sd_ino is truncated (0x2121063) while st_ino is
> not (0x202121063).
>
> Carlo, it would be great if you could test this patch also with
> APFS. It should fix problem. We will have to deal with the same
> truncated inode elsewhere to make sure we index refresh performance
> does not degrade on APFS. But that's a separate problem. Thank you for
> bringing this up.
>
> -- 8< --
> diff --git a/entry.c b/entry.c
> index 5d136c5d55..809d3e2ba7 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -404,13 +404,13 @@ static void mark_colliding_entries(const struct checkout *state,
>  {
>         int i, trust_ino = check_stat;
>
> -#if defined(GIT_WINDOWS_NATIVE)
> +#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
>         trust_ino = 0;
>  #endif
>
>         ce->ce_flags |= CE_MATCHED;
>
> -       for (i = 0; i < state->istate->cache_nr; i++) {
> +       for (i = 0; i < trust_ino && state->istate->cache_nr; i++) {
>                 struct cache_entry *dup = state->istate->cache[i];
>
>                 if (dup == ce)
> @@ -419,10 +419,24 @@ static void mark_colliding_entries(const struct checkout *state,
>                 if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
>                         continue;
>
> -               if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
> -                   (!trust_ino && !fspathcmp(ce->name, dup->name))) {
> +               if (dup->ce_stat_data.sd_ino == (unsigned int)st->st_ino) {
>                         dup->ce_flags |= CE_MATCHED;
> +                       return;
> +               }
> +       }
> +
> +       for (i = 0; i < state->istate->cache_nr; i++) {
> +               struct cache_entry *dup = state->istate->cache[i];
> +
> +               if (dup == ce)
>                         break;
> +
> +               if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
> +                       continue;
> +
> +               if (!fspathcmp(ce->name, dup->name)) {
> +                       dup->ce_flags |= CE_MATCHED;
> +                       return;
>                 }
>         }
>  }
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index f1a49e94f5..c28d51bd59 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -628,7 +628,7 @@ test_expect_success 'clone on case-insensitive fs' '
>         )
>  '
>
> -test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
> +test_expect_success !MINGW,CASE_INSENSITIVE_FS 'colliding file detection' '
>         grep X icasefs/warning &&
>         grep x icasefs/warning &&
>         test_i18ngrep "the following paths have collided" icasefs/warning
> -- 8< --



-- 
Duy
