Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075571F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 06:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbcJDGqz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:46:55 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35963 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbcJDGqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:46:54 -0400
Received: by mail-yw0-f194.google.com with SMTP id r132so3765591ywg.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BhhtLM1Cw5HbTY+GrGSRoOYxK5sMJTvITlTn5/DqGgI=;
        b=PeLzrn2zTOVlzpg545ScwIXrGHJ+S+DHvE/M8p/JJh2DMAFUEbMQp/iDOpXYqVk4hF
         0ZuGmDb8Q8LhOjMfPYYXg2T3ZYRCkMy3QSsHy/PaJ05o/TG3JVIbTzVVND88RzEFdPpP
         0NI2dJVwce09WAL32qFrDeGXOUBYpXgof4wrM1P0rbNpikg5kMPT5SqpVr+4Q8ugFPLZ
         QVKeJ1fwqgBAmEiWB7yVVIuvwqiGTm2a/+gLoc7+DbFEdM+PbTEr+sZitrGp16DJ76fp
         imkL206y+s21xS6BYDi7X7LYWZwh8P2ALwQKlODlocaYAN7yV/w+wl/e+t5JrPA02QQo
         6mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BhhtLM1Cw5HbTY+GrGSRoOYxK5sMJTvITlTn5/DqGgI=;
        b=S2JDoNQ9Jg0Bzj8eMgthyYf14LB5Z50YhfR0BxDOJF7B/YiA9cMm/AQW8bZ3dVGBVY
         fuub0Aih7z5Z1TwkXUtFCGdRcsN4JsqmMFLLV6LRlWZd1H1z7ZpwnzIvmpN0cvmnz36e
         ogcC8vhZ0nW7k+7qDTo7M7KaLOaA5T5FJu04zPD1SmeybGNHgdJy9J7LVneGltYwXR8S
         bbK9nX9Ey9azGKRuOZcGakH0rOlyWUpSTk0nBI1Eawwuyt2aCqk/le4+eGujRJIdjcUI
         KQbGIjhqA4RopHb04vurUQElg5NX8/sPMUnkltZ8gzoEnbR4herCm7Ro8RAiVp6O1sYB
         L9NA==
X-Gm-Message-State: AA6/9RmWW6VPLidDAnK7whhiwHZpWTZ5I7OWjbLrfXurbdQSaZsU8Xg9scof865iahJwPJhglPMN8jL1C0CtnQ==
X-Received: by 10.13.203.79 with SMTP id n76mr1370120ywd.122.1475563613309;
 Mon, 03 Oct 2016 23:46:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:46:32 -0700 (PDT)
In-Reply-To: <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:46:32 -0700
Message-ID: <CA+P7+xoR-14fmzrYU_sGoTRgcfP8fe5y-+kSkoM-2=E3Jb56FQ@mail.gmail.com>
Subject: Re: [PATCH 16/18] count-objects: report alternates via verbose mode
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

\On Mon, Oct 3, 2016 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> There's no way to get the list of alternates that git
> computes internally; our tests only infer it based on which
> objects are available. In addition to testing, knowing this
> list may be helpful for somebody debugging their alternates
> setup.
>
> Let's add it to the "count-objects -v" output. We could give
> it a separate flag, but there's not really any need.
> "count-objects -v" is already a debugging catch-all for the
> object database, its output is easily extensible to new data
> items, and printing the alternates is not expensive (we
> already had to find them to count the objects).
>

Makes sense. Unless there's a compelling reason you'd want to print
out these alternates *without* anything else from -v, but you can just
use grep like the test does so this seems fine to me.

Thanks,
Jake

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-count-objects.txt |  5 +++++
>  builtin/count-objects.c             | 10 ++++++++++
>  t/t5613-info-alternate.sh           | 10 ++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
> index 2ff3568..cb9b4d2 100644
> --- a/Documentation/git-count-objects.txt
> +++ b/Documentation/git-count-objects.txt
> @@ -38,6 +38,11 @@ objects nor valid packs
>  +
>  size-garbage: disk space consumed by garbage files, in KiB (unless -H is
>  specified)
> ++
> +alternate: absolute path of alternate object databases; may appear
> +multiple times, one line per path. Note that if the path contains
> +non-printable characters, it may be surrounded by double-quotes and
> +contain C-style backslashed escape sequences.
>
>  -H::
>  --human-readable::
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index ba92919..a700409 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -8,6 +8,7 @@
>  #include "dir.h"
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "quote.h"
>
>  static unsigned long garbage;
>  static off_t size_garbage;
> @@ -73,6 +74,14 @@ static int count_cruft(const char *basename, const char *path, void *data)
>         return 0;
>  }
>
> +static int print_alternate(struct alternate_object_database *alt, void *data)
> +{
> +       printf("alternate: ");
> +       quote_c_style(alt->path, NULL, stdout, 0);
> +       putchar('\n');
> +       return 0;
> +}
> +
>  static char const * const count_objects_usage[] = {
>         N_("git count-objects [-v] [-H | --human-readable]"),
>         NULL
> @@ -140,6 +149,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
>                 printf("prune-packable: %lu\n", packed_loose);
>                 printf("garbage: %lu\n", garbage);
>                 printf("size-garbage: %s\n", garbage_buf.buf);
> +               foreach_alt_odb(print_alternate, NULL);
>                 strbuf_release(&loose_buf);
>                 strbuf_release(&pack_buf);
>                 strbuf_release(&garbage_buf);
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index b393613..74f6770 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -39,6 +39,16 @@ test_expect_success 'preparing third repository' '
>         )
>  '
>
> +test_expect_success 'count-objects shows the alternates' '
> +       cat >expect <<-EOF &&
> +       alternate: $(pwd)/B/.git/objects
> +       alternate: $(pwd)/A/.git/objects
> +       EOF
> +       git -C C count-objects -v >actual &&
> +       grep ^alternate: actual >actual.alternates &&
> +       test_cmp expect actual.alternates
> +'
> +
>  # Note: These tests depend on the hard-coded value of 5 as "too deep". We start
>  # the depth at 0 and count links, not repositories, so in a chain like:
>  #
> --
> 2.10.0.618.g82cc264
>
