Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239A91F404
	for <e@80x24.org>; Tue, 10 Apr 2018 22:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeDJWJd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:09:33 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:46433 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeDJWJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:09:32 -0400
Received: by mail-pf0-f179.google.com with SMTP id h69so9390843pfe.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZvunY9kMZGGno54t6QfISQOmHQn18zaFieojGYuMm3M=;
        b=Ukdkoyn51U15ec99jG71zhSHRKcYBZ3QL93Zm3nQhZKBScpzYy9MsYrJndW+XEOdEP
         tTfmf/epG55nMJJVP6y0fK61+f55bKSre3Zv4OyPO61QuVZVY59YpZwqsrZV/LwoOcU9
         CletEaCcCoU5Y3ZvgT50JMh/HT0+y2CsBOVGFUlvXSz25d73hI9FdThlo/NYLph8CrDu
         PnMu05FoHQ9C9UkLAo8GcdcYF+QhkJ8DVhWaJl1FtrEDO88CFeqkiYMpINnAJdHeEjXL
         7BmB2ZT9lNG9xuGgYbPzMTXolgfXWOA+nd4c78JXoidv5QgOTAoDyv7dREthNQxsUTW+
         MJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZvunY9kMZGGno54t6QfISQOmHQn18zaFieojGYuMm3M=;
        b=ZRe60Stng+8azVl0Y4nD+avjg0a1Ly9gO6d+jKjA6q9ODaJqQK3LLhXzrN6LOItTHe
         /jDD9aR3bk5kIV+6GYqPo5jL9mDD09d03OP+J8LgdBEdlfk6Tg36Wiutfi0YZsdxRAzU
         8tSvqOpfoy/0DWjbiS/bBUuiqk/7sh9mS7mliS6Ep5IYHZTXHk7PgkFg2oG1mRhLCRc9
         dDAE9ANPAjV+3jz6UtMQ8xbPWBGr2aO7IyxTcgMXo2vvo5bf2ncO7X7FgBV04C0Xff+m
         /uaV13VUSMW15fLZgNk3AVD72dB6SCNFVTDTmsKlH4cv+jtyQ75wHCPRDWcAjQdrAGhw
         vg9A==
X-Gm-Message-State: ALQs6tAFc1xEiWYliBrP8ZKm/dplURDsKJuNbjc7zPzJPRpMO2t+0xU3
        uST5VhnltHqONtYgxacR53SYzGuAYrSn+anNmmw=
X-Google-Smtp-Source: AIpwx4/DkRZM3Ezi4sAE1bg9dwLB8cxKeojomDmCO8lzxp9qNOI7yd0ikXaWnGfuZX199IQce4th/2sYVJEviboKwJI=
X-Received: by 10.98.226.24 with SMTP id a24mr1749795pfi.223.1523398171942;
 Tue, 10 Apr 2018 15:09:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 15:09:31 -0700 (PDT)
In-Reply-To: <20180410210408.13788-2-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com> <20180410210408.13788-2-benpeart@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 11 Apr 2018 00:09:31 +0200
Message-ID: <CAN0heSpKzG93OcAAAoHQxURVGsHFWz6j494C+3bezHLTOovQHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fsexcludes: add a programmatic way to exclude
 files from git's working directory traversal logic
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 23:04, Ben Peart <Ben.Peart@microsoft.com> wrote:
> The File System Excludes module is a new programmatic way to exclude files and
> folders from git's traversal of the working directory.  fsexcludes_init() should
> be called with a string buffer that contains a NUL separated list of path names
> of the files and/or directories that should be included.  Any path not listed
> will be excluded. The paths should be relative to the root of the working
> directory and be separated by a single NUL.
>
> The excludes logic in dir.c has been updated to honor the results of
> fsexcludes_is_excluded_from().  If fsexcludes does not exclude the file, the
> normal excludes logic is also checked as it could further reduce the set of
> files that should be included.

Here you mention a change in dir.c...

>  Makefile     |   1 +
>  fsexcludes.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  fsexcludes.h |  27 +++++++
>  3 files changed, 238 insertions(+)

... but this patch does not seem to touch dir.c at all.

> +static int check_fsexcludes_hashmap(struct hashmap *map, const char *pattern, int patternlen)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       struct fsexcludes fse;
> +       char *slash;
> +
> +       /* Check straight mapping */
> +       strbuf_reset(&sb);

You could drop this strbuf_reset(). Or did you intend to use a static
struct strbuf?

> +       /*
> +        * Check to see if it matches a directory or any path
> +        * underneath it.  In other words, 'a/b/foo.txt' will match
> +        * '/', 'a/', and 'a/b/'.
> +        */
> +       slash = strchr(sb.buf, '/');
> +       while (slash) {
> +               fse.pattern = sb.buf;
> +               fse.patternlen = slash - sb.buf + 1;
> +               hashmap_entry_init(&fse, fsexcludeshash(fse.pattern, fse.patternlen));
> +               if (hashmap_get(map, &fse, NULL)) {
> +                       strbuf_release(&sb);
> +                       return 0;
> +               }
> +               slash = strchr(slash + 1, '/');
> +       }

Maybe a for-loop would make this slightly more obvious:

for (slash = strchr(sb.buf, '/'); slash; slash = strchr(slash + 1, '/'))

On second thought, maybe not.

> +       entry = buf = fsexcludes_data->buf;
> +       len = fsexcludes_data->len;
> +       for (i = 0; i < len; i++) {
> +               if (buf[i] == '\0') {
> +                       fsexcludes_hashmap_add(map, entry, buf + i - entry);
> +                       entry = buf + i + 1;
> +               }
> +       }
> +}

Very minor: I would have found "buf - entry + i" clearer here and later,
but I'm sure you'll find someone of the opposing opinion (e.g.,
yourself). ;-)

> +static int check_directory_hashmap(struct hashmap *map, const char *pathname, int pathlen)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       struct fsexcludes fse;
> +
> +       /* Check for directory */
> +       strbuf_reset(&sb);

Same comment as above about this spurious reset.

> +       if (hashmap_get(map, &fse, NULL)) {
> +               strbuf_release(&sb);
> +               return 0;
> +       }
> +
> +       strbuf_release(&sb);
> +       return 1;
> +}
> +
> +/*
> + * Return 1 for exclude, 0 for include and -1 for undecided.
> + */
> +int fsexcludes_is_excluded_from(struct index_state *istate,
> +       const char *pathname, int pathlen, int dtype)
> +{

Will we at some point regret not being able to "return negative on
error"? I guess that would be "-2" or "negative other than -1".

> +void fsexcludes_init(struct strbuf *sb) {
> +       fsexcludes_initialized = 1;
> +       fsexcludes_data = *sb;
> +}

Grabbing the strbuf's members looks a bit odd. Is this
performance-sensitive enough that you do not want to make a copy? If a
caller releases its strbuf, which would normally be a good thing to do,
we may be in big trouble later. (Not only may .buf be stale, .len may
indicate we actually have something to read.)

I can understand that you do not want to pass a pointer+len, and that it
is not enough to pass sb.buf, since the string may contain nuls.

Maybe detach the original strbuf? That way, if a caller releases its
buffer, that is a no-op. A caller which goes on to use its buffer should
fail quickly and obviously. Right now, an incorrect caller would
probably fail more subtly and less reproducibly.

In any case, maybe document this in the .h-file?

Martin
