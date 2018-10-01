Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479101F453
	for <e@80x24.org>; Mon,  1 Oct 2018 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJAXGU (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 19:06:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37365 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJAXGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 19:06:20 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so9928973iob.4
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRIsJyD0NwXxKhMf+O5WmDU/Owjn5nFsi5qcTezZLDM=;
        b=g0bCNDeTRmDJy48e1TWiWbnDtGoyxshF35xJHjN1HFgtLa+fhwB6DB+oDTLHiL9/pP
         TF5VzDNmZUQ8a8sRQ50afPgmt/q+/DmuveXpxydQJw0pDX/sofYCDuiBzY8y+PWJ3IWO
         mbnnoiWvBjFkvw5SY1EY9JVp9sEfJRs1g8OC4xXYH923wOiMCTg5BgLQkvZNBbwgJ8m9
         ks581ZI+qAehYdjoyFSE6FMP8fURMmZba+RA/tIvDZmS05DJAK3jY0TCbJYLfiD9geW6
         6r4Ys2rrq7Sz5mY1Rh9JizVc9qBO4k+h4xy20/q/6ZKqDLKY6jXcA921aRx8ChllcOGY
         nIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRIsJyD0NwXxKhMf+O5WmDU/Owjn5nFsi5qcTezZLDM=;
        b=T1SYqMDAJY7J9FmBUipeZTpMx4PPKuNfB4RNfd/WlU1e1Wv01PWjnjyLI4GdSw4z57
         TRjObKA7FUPRHCLEeExhF4tHVpHkKlraIvJtT+GsExUMcFvoCX5sx5lH70X8kSEClC8B
         0yCiEfPriyHKHi6EaZU4sQu7mg7Ews1rEoHyOiENPvqaXIFELVbdy4vrU1PJz/t4V0qt
         uTj+6L1C6a6bvcieSddPe1xl7OkXHxseAp1Xgogkt0OJXl1iawirCxPp86a5EpBYq2Bk
         K3Sd+LMMtP3MPtXyK14zSYceAsxmJOJwCqwunMM+Qua2vFzIPdJ2laPW3bZC3zMvW1Y4
         5NGg==
X-Gm-Message-State: ABuFfojutNkkpKInHcLLHOyCgkf0chdWh8qEfGHmiuFOSVr273MiV429
        VEOPgp6X6/hjElwwVP7RFwlx4YpexZb2mgf4xnM=
X-Google-Smtp-Source: ACcGV62vxjSCOhSUB+0jDMzWQsMhVArkfGLXprPV2ClXV4tuGKRnDKyChd24sy7lAzsQ+ZzLcnLlpYNZcGHq1NSjHLQ=
X-Received: by 2002:a6b:6f0f:: with SMTP id k15-v6mr6093958ioc.236.1538411263569;
 Mon, 01 Oct 2018 09:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com> <20181001134556.33232-7-peartben@gmail.com>
In-Reply-To: <20181001134556.33232-7-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Oct 2018 18:27:17 +0200
Message-ID: <CACsJy8B9dd-N=w13XP2FuHRfqK2tmzuNx0WN-ZhuchssG6RUdg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] ieot: add Index Entry Offset Table (IEOT) extension
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
> @@ -1888,6 +1890,23 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>         return ondisk_size + entries * per_entry;
>  }
>
> +struct index_entry_offset
> +{
> +       /* starting byte offset into index file, count of index entries in this block */
> +       int offset, nr;

uint32_t?

> +};
> +
> +struct index_entry_offset_table
> +{
> +       int nr;
> +       struct index_entry_offset entries[0];

Use FLEX_ARRAY. Some compilers are not happy with an array of zero
items if I remember correctly.

> @@ -2523,6 +2551,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>         struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>         int drop_cache_tree = istate->drop_cache_tree;
>         off_t offset;
> +       int ieot_work = 1;
> +       struct index_entry_offset_table *ieot = NULL;
> +       int nr;

There are a bunch of stuff going on in this function, maybe rename
this to nr_threads or nr_blocks to be less generic.

>
>         for (i = removed = extended = 0; i < entries; i++) {
>                 if (cache[i]->ce_flags & CE_REMOVE)
> @@ -2556,7 +2587,38 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>         if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>                 return -1;
>
> +#ifndef NO_PTHREADS
> +       if ((nr = git_config_get_index_threads()) != 1) {

Maybe keep this assignment out of "if".

> +               int ieot_blocks, cpus;
> +
> +               /*
> +                * ensure default number of ieot blocks maps evenly to the
> +                * default number of threads that will process them
> +                */
> +               if (!nr) {
> +                       ieot_blocks = istate->cache_nr / THREAD_COST;
> +                       cpus = online_cpus();
> +                       if (ieot_blocks > cpus - 1)
> +                               ieot_blocks = cpus - 1;

The " - 1" here is for extension thread, yes? Probably worth a comment.

> +               } else {
> +                       ieot_blocks = nr;
> +               }
> +
> +               /*
> +                * no reason to write out the IEOT extension if we don't
> +                * have enough blocks to utilize multi-threading
> +                */
> +               if (ieot_blocks > 1) {
> +                       ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
> +                               + (ieot_blocks * sizeof(struct index_entry_offset)));

Use FLEX_ALLOC_MEM() after you declare ..._table with FLEX_ARRAY.

This ieot needs to be freed also and should be before any "return -1"
in this function.

> +                       ieot->nr = 0;
> +                       ieot_work = DIV_ROUND_UP(entries, ieot_blocks);

Perhaps a better name for ioet_work? This looks like the number of
cache entries per block.

> +               }
> +       }
> +#endif
> +
>         offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> +       nr = 0;

Eh.. repurpose nr to count cache entries now? It's kinda hard to follow.

>         previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
>
>         for (i = 0; i < entries; i++) {
> @@ -2578,11 +2640,31 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>
>                         drop_cache_tree = 1;
>                 }
> +               if (ieot && i && (i % ieot_work == 0)) {
> +                       ieot->entries[ieot->nr].nr = nr;
> +                       ieot->entries[ieot->nr].offset = offset;
> +                       ieot->nr++;
> +                       /*
> +                        * If we have a V4 index, set the first byte to an invalid
> +                        * character to ensure there is nothing common with the previous
> +                        * entry
> +                        */
> +                       if (previous_name)
> +                               previous_name->buf[0] = 0;
> +                       nr = 0;
> +                       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;

This only works correctly if the ce_write_entry() from the last
iteration has flushed everything to out to newfd. Maybe it does, but
it's error prone to rely on that in my opinion. Maybe we need an
explicit ce_write_flush() here to make sure.

> +               }
>                 if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
>                         err = -1;
>
>                 if (err)
>                         break;
> +               nr++;
> +       }
> +       if (ieot && nr) {
> +               ieot->entries[ieot->nr].nr = nr;
> +               ieot->entries[ieot->nr].offset = offset;
> +               ieot->nr++;
>         }
>         strbuf_release(&previous_name_buf);
>
> @@ -2593,6 +2675,26 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>         offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
>         the_hash_algo->init_fn(&eoie_c);
>
> +       /*
> +        * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
> +        * can minimze the number of extensions we have to scan through to

s/minimze/minimize/

> +        * find it during load.  Write it out regardless of the
> +        * strip_extensions parameter as we need it when loading the shared
> +        * index.
> +        */
> +#ifndef NO_PTHREADS
> +       if (ieot) {
> +               struct strbuf sb = STRBUF_INIT;
> +
> +               write_ieot_extension(&sb, ieot);
> +               err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
> +                       || ce_write(&c, newfd, sb.buf, sb.len) < 0;
> +               strbuf_release(&sb);
> +               if (err)
> +                       return -1;
> +       }
> +#endif
> +
>         if (!strip_extensions && istate->split_index) {
>                 struct strbuf sb = STRBUF_INIT;
>
> @@ -3176,3 +3278,74 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
>         the_hash_algo->final_fn(hash, eoie_context);
>         strbuf_add(sb, hash, the_hash_algo->rawsz);
>  }
> +
> +#ifndef NO_PTHREADS
> +#define IEOT_VERSION   (1)
> +
> +static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
> +{
> +       const char *index = NULL;
> +       uint32_t extsize, ext_version;
> +       struct index_entry_offset_table *ieot;
> +       int i, nr;
> +
> +       /* find the IEOT extension */
> +       if (!offset)
> +              return NULL;
> +       while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
> +              extsize = get_be32(mmap + offset + 4);
> +              if (CACHE_EXT((mmap + offset)) == CACHE_EXT_INDEXENTRYOFFSETTABLE) {
> +                      index = mmap + offset + 4 + 4;
> +                      break;
> +              }
> +              offset += 8;
> +              offset += extsize;
> +       }

Maybe refactor this loop. I think I've seen this in at least two
places now. Probably three?

> +       if (!index)
> +              return NULL;
> +
> +       /* validate the version is IEOT_VERSION */
> +       ext_version = get_be32(index);
> +       if (ext_version != IEOT_VERSION)
> +              return NULL;

Report the error (e.g. "unsupported version" or something)

> +       index += sizeof(uint32_t);
> +
> +       /* extension size - version bytes / bytes per entry */
> +       nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));

Do we need to check if "(extsize - version) % sizeof(entry) == 0"?

> +       if (!nr)
> +              return NULL;
> +       ieot = xmalloc(sizeof(struct index_entry_offset_table)
> +              + (nr * sizeof(struct index_entry_offset)));
> +       ieot->nr = nr;
> +       for (i = 0; i < nr; i++) {
> +              ieot->entries[i].offset = get_be32(index);
> +              index += sizeof(uint32_t);
> +              ieot->entries[i].nr = get_be32(index);
> +              index += sizeof(uint32_t);
> +       }
> +
> +       return ieot;
> +}
> +
> +static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot)
> +{
> +       uint32_t buffer;
> +       int i;
> +
> +       /* version */
> +       put_be32(&buffer, IEOT_VERSION);
> +       strbuf_add(sb, &buffer, sizeof(uint32_t));
> +
> +       /* ieot */
> +       for (i = 0; i < ieot->nr; i++) {
> +
> +              /* offset */
> +              put_be32(&buffer, ieot->entries[i].offset);
> +              strbuf_add(sb, &buffer, sizeof(uint32_t));
> +
> +              /* count */
> +              put_be32(&buffer, ieot->entries[i].nr);
> +              strbuf_add(sb, &buffer, sizeof(uint32_t));
> +       }
> +}
> +#endif
> --
> 2.18.0.windows.1
>


-- 
Duy
