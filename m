Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5941F859
	for <e@80x24.org>; Sat, 20 Aug 2016 00:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbcHTADA (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 20:03:00 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36553 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755680AbcHTAC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 20:02:59 -0400
Received: by mail-io0-f182.google.com with SMTP id b62so62964630iod.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MxntPh6Zu8NiWo850UGky+Y4Lv62cmGf3nqJx61+3/k=;
        b=gJfLyXRZu5023G2usLYMIeSsZ9L9+PH2kzDtdAp9KDoLR91MKaKC1mN2Iko1ZNx/ps
         wAyG+ktaHoH5kDxJUfFb+mExFL9jaTJM+3KNZz+8AIocLLT/7SucUZ0gB+2NlpyMI+hW
         m2lzybTU0iyNfJRw5Oz3rDKoBNklx+uV24x2jFJ9uEZCWTHnStbHTJcliG2TV6JJCJ/f
         EId0+m/kqsurPzcTwMRkjRPK1my1cBBfXEIfYXvndQhW5XY+mdat/UTe/dPAFtplgd3O
         zLko/14EtrwDZsiguCVEl134GAD6cEOWW5BDId4GcLldOUXiACxU6gC9LVBd3VKUfrMg
         G/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MxntPh6Zu8NiWo850UGky+Y4Lv62cmGf3nqJx61+3/k=;
        b=UDL88+q+EOMzFrLoE0YBmUXKp/+CXUwVK6N9fNnhhHZNUFRtPwMMimmVF1mLcI2RfH
         YHf6ri9pBRqJxfF0lzXSEYyHwUBy3zlqwRNBqhoXGWZnSFqOHeBz0mYdc2dZ/Q09wN0Z
         19DWB1D7bmDKYzHwZy291CgMLV2mqFyNiTXrqDHUf6tGfIIk9fah4IF9m43F6YlXJxoA
         /MaLzy26WTW/0G0gtPw7URj3qTgoplViPj0/NGEdmGoHUmXpYSE9oq+pIkBK3Msl6BdI
         beFLAZWdr3YoGzh2dEDDxenuTr5dwUoXQR9c74teS3O55zH/EIlmPSXvIIfZb1o9p9ra
         qoAw==
X-Gm-Message-State: AEkooutUYw5aYKRf9UiLVYAVmiiBgbvvA3gIEgXvJw1iy8ByHR7oL4KB6VlCKKQeE0j/HUdz/PL3eMguxCJt1EEi
X-Received: by 10.107.178.129 with SMTP id b123mr12921534iof.83.1471651378038;
 Fri, 19 Aug 2016 17:02:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 19 Aug 2016 17:02:56 -0700 (PDT)
In-Reply-To: <20160819233432.15188-1-jacob.e.keller@intel.com>
References: <20160819233432.15188-1-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Aug 2016 17:02:56 -0700
Message-ID: <CAGZ79kZqkHO58kUvP772jfTUgyYXxYuDkgGB1sOTYYQ6nLCP4A@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] submodule show inline diff
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 4:34 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> More suggestions from Junio and a few changes to support submodule name
> lookup. Hopefully we're getting close to the goal!
>
> interdiff between v8 and current:
> diff --git c/builtin/rev-list.c w/builtin/rev-list.c
> index 21cde8dd6b31..8479f6ed28aa 100644
> --- c/builtin/rev-list.c
> +++ w/builtin/rev-list.c
> @@ -129,29 +129,29 @@ static void show_commit(struct commit *commit, void *data)
>                         graph_show_commit_msg(revs->graph, stdout, &buf);
>
>                         /*
> -                       * Add a newline after the commit message.
> -                       *
> -                       * Usually, this newline produces a blank
> -                       * padding line between entries, in which case
> -                       * we need to add graph padding on this line.
> -                       *
> -                       * However, the commit message may not end in a
> -                       * newline.  In this case the newline simply
> -                       * ends the last line of the commit message,
> -                       * and we don't need any graph output.  (This
> -                       * always happens with CMIT_FMT_ONELINE, and it
> -                       * happens with CMIT_FMT_USERFORMAT when the
> -                       * format doesn't explicitly end in a newline.)
> -                       */
> +                        * Add a newline after the commit message.
> +                        *
> +                        * Usually, this newline produces a blank
> +                        * padding line between entries, in which case
> +                        * we need to add graph padding on this line.
> +                        *
> +                        * However, the commit message may not end in a
> +                        * newline.  In this case the newline simply
> +                        * ends the last line of the commit message,
> +                        * and we don't need any graph output.  (This
> +                        * always happens with CMIT_FMT_ONELINE, and it
> +                        * happens with CMIT_FMT_USERFORMAT when the
> +                        * format doesn't explicitly end in a newline.)
> +                        */
>                         if (buf.len && buf.buf[buf.len - 1] == '\n')
>                                 graph_show_padding(revs->graph);
>                         putchar('\n');
>                 } else {
>                         /*
> -                               * If the message buffer is empty, just show
> -                               * the rest of the graph output for this
> -                               * commit.
> -                               */
> +                        * If the message buffer is empty, just show
> +                        * the rest of the graph output for this
> +                        * commit.
> +                        */
>                         if (graph_show_remainder(revs->graph))
>                                 putchar('\n');
>                         if (revs->commit_format == CMIT_FMT_ONELINE)
> diff --git c/cache.h w/cache.h
> index da9f0be67d7b..70428e92d7ed 100644
> --- c/cache.h
> +++ w/cache.h
> @@ -953,24 +953,39 @@ static inline void oidclr(struct object_id *oid)
>  #define EMPTY_TREE_SHA1_BIN_LITERAL \
>          "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
>          "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
> -#define EMPTY_TREE_SHA1_BIN \
> -        ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
> +extern const struct object_id empty_tree_oid;
> +#define EMPTY_TREE_SHA1_BIN (empty_tree_oid.hash)
>
>  #define EMPTY_BLOB_SHA1_HEX \
>         "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
>  #define EMPTY_BLOB_SHA1_BIN_LITERAL \
>         "\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
>         "\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
> -#define EMPTY_BLOB_SHA1_BIN \
> -       ((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
> +extern const struct object_id empty_blob_oid;
> +#define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
>
> -extern const struct object_id empty_tree_oid;
>
>  static inline int is_empty_blob_sha1(const unsigned char *sha1)
>  {
>         return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
>  }
>
> +static inline int is_empty_blob_oid(const struct object_id *oid)
> +{
> +       return !hashcmp(oid->hash, EMPTY_BLOB_SHA1_BIN);
> +}
> +
> +static inline int is_empty_tree_sha1(const unsigned char *sha1)
> +{
> +       return !hashcmp(sha1, EMPTY_TREE_SHA1_BIN);
> +}
> +
> +static inline int is_empty_tree_oid(const struct object_id *oid)
> +{
> +       return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
> +}
> +
> +
>  int git_mkstemp(char *path, size_t n, const char *template);
>
>  /* set default permissions by passing mode arguments to open(2) */
> diff --git c/diff.h w/diff.h
> index 192c0eedd0ff..ec76a90522ea 100644
> --- c/diff.h
> +++ w/diff.h
> @@ -112,7 +112,7 @@ enum diff_words_type {
>  enum diff_submodule_format {
>         DIFF_SUBMODULE_SHORT = 0,
>         DIFF_SUBMODULE_LOG,
> -       DIFF_SUBMODULE_INLINE_DIFF,
> +       DIFF_SUBMODULE_INLINE_DIFF
>  };
>
>  struct diff_options {
> diff --git c/path.c w/path.c
> index 188abfebbafe..081a22c1163c 100644
> --- c/path.c
> +++ w/path.c
> @@ -6,6 +6,7 @@
>  #include "string-list.h"
>  #include "dir.h"
>  #include "worktree.h"
> +#include "submodule-config.h"
>
>  static int get_st_mode_bits(const char *path, int *mode)
>  {
> @@ -474,6 +475,7 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
>         const char *git_dir;
>         struct strbuf git_submodule_common_dir = STRBUF_INIT;
>         struct strbuf git_submodule_dir = STRBUF_INIT;
> +       const struct submodule *submodule_config;
>
>         strbuf_addstr(buf, path);
>         strbuf_complete(buf, '/');
> @@ -486,7 +488,16 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
>         }
>         if (!is_git_directory(buf->buf)) {
>                 strbuf_reset(buf);
> -               strbuf_git_path(buf, "%s/%s", "modules", path);
> +               /*
> +                * Lookup the submodule name from the config. If that fails
> +                * fall back to assuming the path is the name.
> +                */
> +               submodule_config = submodule_from_path(null_sha1, path);

In case you need to reroll: I'd got with just "sub" as the name for
the config object
(that seems to be used all the time and is shorter)


> +               if (submodule_config)
> +                       strbuf_git_path(buf, "%s/%s", "modules",
> +                                       submodule_config->name);
> +               else

I do not think we want to assume the path as the name for the fallback, though.

If `submodule_config == NULL` then
a) the path/name doesn't exist in the given version.
    (If null_sha1 is given, HEAD + working tree is assumed, whereas
    you could also check for a specific commit of the superproject
    with another sha1)

b) or the submodule config cache was not initialized
   (missing call to gitmodules_config())

c) There is no c) [at least I never came across another reason for a
NULL return here]

Using the path as the fallback is errorprone (e.g. to b. in the future
and then you get the wrong submodule repository which is shaded by
assuming the path and it is hard to debug later or write forward looking
tests for that now)

Thanks,
Stefan
