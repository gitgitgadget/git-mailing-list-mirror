Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36701207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 06:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbcJDGGF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:06:05 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36380 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbcJDGGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:06:04 -0400
Received: by mail-yb0-f195.google.com with SMTP id 184so1651477yby.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qvl6pUA3orlf6trYoXeKNa40pwurho9+2spNiW1tWSw=;
        b=DUODh2ghgjI580GCjbBEEm87YcAfHH4mCgsAiQuwHMbzAsJQtKFq9eW8WEKBcq0RPZ
         Hr3leylAJZPAzXWAMLBcqZjg5E2I78XCj9wWVtq2Mn8ft5xM5teJOJ56zr0EUhg22mfs
         oOiQL4PcmmCCLZrOuip4GTfxxXgSAJszDwfGAG2b+wUHzYSDZbOQf9YT4cpFlYiQdXu8
         IlBxL8Cv4dXJwyzm6n6A/Chm8IjHenrzDK2BGy6zDZnxdtvJrnU1WRzSrFjeb7CbFGcg
         arKsFn+5I/O38Tdwxj9V/Pr7BFVNoip9eFUhrhJp2jr+8mTRBy/rEDeaygmlxAxu6LzL
         hMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qvl6pUA3orlf6trYoXeKNa40pwurho9+2spNiW1tWSw=;
        b=FFLUnEWI5/GFkNB7LRM4Db6+vbi47uqVE3JBbz8h8mjbfEQbokwHdCBLjuVrpyiT1V
         qRxO9M65XNAv/eOmt+mUjuxwH2det9pTzwN12riCwHjV/Lw10T2lg4042jFQ8oA+rt3J
         tueLWxrngmTgYUR6OHzdSoKsLKaW8WwKqFvFep0pPBR7l2eCYpgTZcuk98zoF/M0PeN7
         u6F8e5ZloZCGyJmpHq3lsNA0UyUfqPSKZokU7ot4gaW7p0TdJPjp0iPobs3epUuIGA3U
         kc2WGeBs5NzJCGeCjb3CFgB9XdAMTuLS5P2RXjAPG4UCjJJrmTqDsJxf9gwsjKO/bD99
         MgBQ==
X-Gm-Message-State: AA6/9RnM1j1NwHpMreAXGJkdwz+fnFtLXNhns1pEj+90wr0vkXuHOe6/B5j5VV95iQMSQbPGjpJCmXjym9319Q==
X-Received: by 10.37.118.137 with SMTP id r131mr1337499ybc.57.1475561163326;
 Mon, 03 Oct 2016 23:06:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:05:42 -0700 (PDT)
In-Reply-To: <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:05:42 -0700
Message-ID: <CA+P7+xrUOnDebwZnfu-xv-GuTJka4-eNUAfBudQf5ZhnkczU6w@mail.gmail.com>
Subject: Re: [PATCH 08/18] link_alt_odb_entry: refactor string handling
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> The string handling in link_alt_odb_entry() is mostly an
> artifact of the original version, which took the path as a
> ptr/len combo, and did not have a NUL-terminated string
> until we created one in the alternate_object_database
> struct.  But since 5bdf0a8 (sha1_file: normalize alt_odb
> path before comparing and storing, 2011-09-07), the first
> thing we do is put the path into a strbuf, which gives us
> some easy opportunities for cleanup.
>
> In particular:
>
>   - we call strlen(pathbuf.buf), which is silly; we can look
>     at pathbuf.len.

Right. This makes obvious sense.

>
>   - even though we have a strbuf, we don't maintain its
>     "len" field when chomping extra slashes from the
>     end, and instead keep a separate "pfxlen" variable. We
>     can fix this and then drop "pfxlen" entirely.
>

Makes sense.

>   - we don't check whether the path is usable until after we
>     allocate the new struct, making extra cleanup work for
>     ourselves. Since we have a NUL-terminated string, we can
>     bump the "is it usable" checks higher in the function.
>     While we're at it, we can move that logic to its own
>     helper, which makes the flow of link_alt_odb_entry()
>     easier to follow.
>

Also makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> And you can probably guess now how I found the issue in the last patch
> where pathbuf.len is totally bogus after calling normalize_path_copy. :)
>
>  sha1_file.c | 83 +++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 38 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 68571bd..f396823 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -234,6 +234,36 @@ char *sha1_pack_index_name(const unsigned char *sha1)
>  struct alternate_object_database *alt_odb_list;
>  static struct alternate_object_database **alt_odb_tail;
>
> +/*
> + * Return non-zero iff the path is usable as an alternate object database.
> + */
> +static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
> +{
> +       struct alternate_object_database *alt;
> +
> +       /* Detect cases where alternate disappeared */
> +       if (!is_directory(path->buf)) {
> +               error("object directory %s does not exist; "
> +                     "check .git/objects/info/alternates.",
> +                     path->buf);
> +               return 0;
> +       }
> +
> +       /*
> +        * Prevent the common mistake of listing the same
> +        * thing twice, or object directory itself.
> +        */
> +       for (alt = alt_odb_list; alt; alt = alt->next) {
> +               if (path->len == alt->name - alt->base - 1 &&
> +                   !memcmp(path->buf, alt->base, path->len))
> +                       return 0;
> +       }
> +       if (!fspathcmp(path->buf, normalized_objdir))
> +               return 0;
> +
> +       return 1;
> +}
> +

This definitely makes reading the following function much easier,
though the diff is a bit funky. I think the end result is much
clearer.

Thanks,
Jake

>  /*
>   * Prepare alternate object database registry.
>   *
> @@ -253,8 +283,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
>         int depth, const char *normalized_objdir)
>  {
>         struct alternate_object_database *ent;
> -       struct alternate_object_database *alt;
> -       size_t pfxlen, entlen;
> +       size_t entlen;
>         struct strbuf pathbuf = STRBUF_INIT;
>
>         if (!is_absolute_path(entry) && relative_base) {
> @@ -270,47 +299,26 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
>                 return -1;
>         }
>
> -       pfxlen = strlen(pathbuf.buf);
> -
>         /*
>          * The trailing slash after the directory name is given by
>          * this function at the end. Remove duplicates.
>          */
> -       while (pfxlen && pathbuf.buf[pfxlen-1] == '/')
> -               pfxlen -= 1;
> -
> -       entlen = st_add(pfxlen, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
> -       ent = xmalloc(st_add(sizeof(*ent), entlen));
> -       memcpy(ent->base, pathbuf.buf, pfxlen);
> -       strbuf_release(&pathbuf);
> -
> -       ent->name = ent->base + pfxlen + 1;
> -       ent->base[pfxlen + 3] = '/';
> -       ent->base[pfxlen] = ent->base[entlen-1] = 0;
> +       while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
> +               strbuf_setlen(&pathbuf, pathbuf.len - 1);
>
> -       /* Detect cases where alternate disappeared */
> -       if (!is_directory(ent->base)) {
> -               error("object directory %s does not exist; "
> -                     "check .git/objects/info/alternates.",
> -                     ent->base);
> -               free(ent);
> +       if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
> +               strbuf_release(&pathbuf);
>                 return -1;
>         }
>
> -       /* Prevent the common mistake of listing the same
> -        * thing twice, or object directory itself.
> -        */
> -       for (alt = alt_odb_list; alt; alt = alt->next) {
> -               if (pfxlen == alt->name - alt->base - 1 &&
> -                   !memcmp(ent->base, alt->base, pfxlen)) {
> -                       free(ent);
> -                       return -1;
> -               }
> -       }
> -       if (!fspathcmp(ent->base, normalized_objdir)) {
> -               free(ent);
> -               return -1;
> -       }
> +       entlen = st_add(pathbuf.len, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
> +       ent = xmalloc(st_add(sizeof(*ent), entlen));
> +       memcpy(ent->base, pathbuf.buf, pathbuf.len);
> +
> +       ent->name = ent->base + pathbuf.len + 1;
> +       ent->base[pathbuf.len] = '/';
> +       ent->base[pathbuf.len + 3] = '/';
> +       ent->base[entlen-1] = 0;
>
>         /* add the alternate entry */
>         *alt_odb_tail = ent;
> @@ -318,10 +326,9 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
>         ent->next = NULL;
>
>         /* recursively add alternates */
> -       read_info_alternates(ent->base, depth + 1);
> -
> -       ent->base[pfxlen] = '/';
> +       read_info_alternates(pathbuf.buf, depth + 1);
>
> +       strbuf_release(&pathbuf);
>         return 0;
>  }
>
> --
> 2.10.0.618.g82cc264
>
