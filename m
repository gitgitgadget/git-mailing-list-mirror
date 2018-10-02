Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0775D1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJBXSj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 19:18:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40386 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJBXSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 19:18:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so1526624qkd.7
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ecrXy6pPqwNvqzMZRLxt0Gyw1XP1YJMa5nj/NgIf6dI=;
        b=MpVaCmqdQ6j+ORFnoQus0wHmYA75sB/ncPmj7j4zkTamR/5ImrJHbBLQzddQ5dUHCs
         niti4gsQPO4fU1PlSpJ+lT/FQ7XlXHQvvrD3evqlwEVwyQHXLFtbDDjJq6FgtGkcSi/Q
         P3cIuozVN4O5RZKp+J7haXLAK82Wmwq1qL8CWiRLXSz8M/Q3cGhGqmXvLjn5Kuqr55Zl
         OZP+5M4pf/u2Q0ejxS5E0J53W3VIhqwgd5i1tTdZBWlubcRFBBAiXuQ+3IXcawNhxOp/
         pNyTbt/Ju6KndsAx5cPxkjQNYs73NAqAJW+Ilr+4rE6pY+NT6I8I50ztEChMkaiLXgWa
         PkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecrXy6pPqwNvqzMZRLxt0Gyw1XP1YJMa5nj/NgIf6dI=;
        b=n3/PhMVkuiGousOixxbLe693ZrPqDE5nZ4BgwtLedB65mbn2Hacy/h+NVuIxbONrO1
         eMM9mQi0VKs6n4+d4Jo1PbW5UzHs8X4wWG5RsgAmZQHJkwG314YHA1mzk5I+xazp+MRq
         /zCwWrgOEPc852QeQaDRZ+igZVvTpcfHnAcQyAVIEOXGPLjJbyteXQXJfBku7dACL86j
         V/5WD5nOInNk1Kvn8RKpPb1P8YdxoF24pBJxcsdOXQH47+YF+DY4HNDv950YuXJc5cPd
         14ZsjioTNWCXvgdIf8++e0qQVfdH5KIPGNBT5ZPjKhKjAopkKgRL18eYFhBCTTZaVMQ6
         osBw==
X-Gm-Message-State: ABuFfoh3URvY1Ta7XlbHLa26ayzzfrNp9u9ChlZ9GgnCLLHOA22jvTV7
        SWzg1VGxsP4WETUV3YP6Xhqdd7s91og=
X-Google-Smtp-Source: ACcGV63jCkSOcIogBsV5hBxnPiYb4/AQ7q4E3Yp/hf88YBXxVbRl9kDgoTluZvF0yRXNYOn4Enss5Q==
X-Received: by 2002:a37:29e4:: with SMTP id p97-v6mr11963366qkp.331.1538498064684;
        Tue, 02 Oct 2018 09:34:24 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z31-v6sm5976111qtz.70.2018.10.02.09.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:34:23 -0700 (PDT)
Subject: Re: [PATCH v7 6/7] ieot: add Index Entry Offset Table (IEOT)
 extension
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
 <20181001134556.33232-7-peartben@gmail.com>
 <CACsJy8B9dd-N=w13XP2FuHRfqK2tmzuNx0WN-ZhuchssG6RUdg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <351b9746-6c2e-a658-3f51-71c1f4cbc3ac@gmail.com>
Date:   Tue, 2 Oct 2018 12:34:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8B9dd-N=w13XP2FuHRfqK2tmzuNx0WN-ZhuchssG6RUdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/2018 12:27 PM, Duy Nguyen wrote:
> On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
>> @@ -1888,6 +1890,23 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>>          return ondisk_size + entries * per_entry;
>>   }
>>
>> +struct index_entry_offset
>> +{
>> +       /* starting byte offset into index file, count of index entries in this block */
>> +       int offset, nr;
> 
> uint32_t?
> 
>> +};
>> +
>> +struct index_entry_offset_table
>> +{
>> +       int nr;
>> +       struct index_entry_offset entries[0];
> 
> Use FLEX_ARRAY. Some compilers are not happy with an array of zero
> items if I remember correctly.
> 

Thanks for the warning, I'll update that.

>> @@ -2523,6 +2551,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>          struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>>          int drop_cache_tree = istate->drop_cache_tree;
>>          off_t offset;
>> +       int ieot_work = 1;
>> +       struct index_entry_offset_table *ieot = NULL;
>> +       int nr;
> 
> There are a bunch of stuff going on in this function, maybe rename
> this to nr_threads or nr_blocks to be less generic.
> 

I can add a nr_threads variable to make this more obvious.

>>
>>          for (i = removed = extended = 0; i < entries; i++) {
>>                  if (cache[i]->ce_flags & CE_REMOVE)
>> @@ -2556,7 +2587,38 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>          if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>>                  return -1;
>>
>> +#ifndef NO_PTHREADS
>> +       if ((nr = git_config_get_index_threads()) != 1) {
> 
> Maybe keep this assignment out of "if".
> 
>> +               int ieot_blocks, cpus;
>> +
>> +               /*
>> +                * ensure default number of ieot blocks maps evenly to the
>> +                * default number of threads that will process them
>> +                */
>> +               if (!nr) {
>> +                       ieot_blocks = istate->cache_nr / THREAD_COST;
>> +                       cpus = online_cpus();
>> +                       if (ieot_blocks > cpus - 1)
>> +                               ieot_blocks = cpus - 1;
> 
> The " - 1" here is for extension thread, yes? Probably worth a comment.
> 
>> +               } else {
>> +                       ieot_blocks = nr;
>> +               }
>> +
>> +               /*
>> +                * no reason to write out the IEOT extension if we don't
>> +                * have enough blocks to utilize multi-threading
>> +                */
>> +               if (ieot_blocks > 1) {
>> +                       ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
>> +                               + (ieot_blocks * sizeof(struct index_entry_offset)));
> 
> Use FLEX_ALLOC_MEM() after you declare ..._table with FLEX_ARRAY.
> 

FLEX_ALLOC_MEM() is focused on variable length "char" data.  All uses of 
FLEX_ARRAY with non char data did the allocation themselves to avoid the 
unnecessary memcpy() that comes with FLEX_ALLOC_MEM.

> This ieot needs to be freed also and should be before any "return -1"
> in this function.
> 

Good catch. Will do.

>> +                       ieot->nr = 0;
>> +                       ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
> 
> Perhaps a better name for ioet_work? This looks like the number of
> cache entries per block.
> 
>> +               }
>> +       }
>> +#endif
>> +
>>          offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
>> +       nr = 0;
> 
> Eh.. repurpose nr to count cache entries now? It's kinda hard to follow.
> 
>>          previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
>>
>>          for (i = 0; i < entries; i++) {
>> @@ -2578,11 +2640,31 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>
>>                          drop_cache_tree = 1;
>>                  }
>> +               if (ieot && i && (i % ieot_work == 0)) {
>> +                       ieot->entries[ieot->nr].nr = nr;
>> +                       ieot->entries[ieot->nr].offset = offset;
>> +                       ieot->nr++;
>> +                       /*
>> +                        * If we have a V4 index, set the first byte to an invalid
>> +                        * character to ensure there is nothing common with the previous
>> +                        * entry
>> +                        */
>> +                       if (previous_name)
>> +                               previous_name->buf[0] = 0;
>> +                       nr = 0;
>> +                       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> 
> This only works correctly if the ce_write_entry() from the last
> iteration has flushed everything to out to newfd. Maybe it does, but
> it's error prone to rely on that in my opinion. Maybe we need an
> explicit ce_write_flush() here to make sure.
> 

This logic already takes any unflushed data into account - the offset is 
what has been flushed to disk (lseek) plus the amount still in the 
buffer (write_buffer_len) waiting to be flushed.  I don't see any need 
to force an additional flush and adding one could have a negative impact 
on performance.

>> +               }
>>                  if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
>>                          err = -1;
>>
>>                  if (err)
>>                          break;
>> +               nr++;
>> +       }
>> +       if (ieot && nr) {
>> +               ieot->entries[ieot->nr].nr = nr;
>> +               ieot->entries[ieot->nr].offset = offset;
>> +               ieot->nr++;
>>          }
>>          strbuf_release(&previous_name_buf);
>>
>> @@ -2593,6 +2675,26 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>          offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
>>          the_hash_algo->init_fn(&eoie_c);
>>
>> +       /*
>> +        * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
>> +        * can minimze the number of extensions we have to scan through to
> 
> s/minimze/minimize/
> 
>> +        * find it during load.  Write it out regardless of the
>> +        * strip_extensions parameter as we need it when loading the shared
>> +        * index.
>> +        */
>> +#ifndef NO_PTHREADS
>> +       if (ieot) {
>> +               struct strbuf sb = STRBUF_INIT;
>> +
>> +               write_ieot_extension(&sb, ieot);
>> +               err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
>> +                       || ce_write(&c, newfd, sb.buf, sb.len) < 0;
>> +               strbuf_release(&sb);
>> +               if (err)
>> +                       return -1;
>> +       }
>> +#endif
>> +
>>          if (!strip_extensions && istate->split_index) {
>>                  struct strbuf sb = STRBUF_INIT;
>>
>> @@ -3176,3 +3278,74 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
>>          the_hash_algo->final_fn(hash, eoie_context);
>>          strbuf_add(sb, hash, the_hash_algo->rawsz);
>>   }
>> +
>> +#ifndef NO_PTHREADS
>> +#define IEOT_VERSION   (1)
>> +
>> +static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
>> +{
>> +       const char *index = NULL;
>> +       uint32_t extsize, ext_version;
>> +       struct index_entry_offset_table *ieot;
>> +       int i, nr;
>> +
>> +       /* find the IEOT extension */
>> +       if (!offset)
>> +              return NULL;
>> +       while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
>> +              extsize = get_be32(mmap + offset + 4);
>> +              if (CACHE_EXT((mmap + offset)) == CACHE_EXT_INDEXENTRYOFFSETTABLE) {
>> +                      index = mmap + offset + 4 + 4;
>> +                      break;
>> +              }
>> +              offset += 8;
>> +              offset += extsize;
>> +       }
> 
> Maybe refactor this loop. I think I've seen this in at least two
> places now. Probably three?
> 
>> +       if (!index)
>> +              return NULL;
>> +
>> +       /* validate the version is IEOT_VERSION */
>> +       ext_version = get_be32(index);
>> +       if (ext_version != IEOT_VERSION)
>> +              return NULL;
> 
> Report the error (e.g. "unsupported version" or something)
> 

Sure.  I'll add reporting here and in the error check below.

>> +       index += sizeof(uint32_t);
>> +
>> +       /* extension size - version bytes / bytes per entry */
>> +       nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
> 
> Do we need to check if "(extsize - version) % sizeof(entry) == 0"?
> 
>> +       if (!nr)
>> +              return NULL;
>> +       ieot = xmalloc(sizeof(struct index_entry_offset_table)
>> +              + (nr * sizeof(struct index_entry_offset)));
>> +       ieot->nr = nr;
>> +       for (i = 0; i < nr; i++) {
>> +              ieot->entries[i].offset = get_be32(index);
>> +              index += sizeof(uint32_t);
>> +              ieot->entries[i].nr = get_be32(index);
>> +              index += sizeof(uint32_t);
>> +       }
>> +
>> +       return ieot;
>> +}
>> +
>> +static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot)
>> +{
>> +       uint32_t buffer;
>> +       int i;
>> +
>> +       /* version */
>> +       put_be32(&buffer, IEOT_VERSION);
>> +       strbuf_add(sb, &buffer, sizeof(uint32_t));
>> +
>> +       /* ieot */
>> +       for (i = 0; i < ieot->nr; i++) {
>> +
>> +              /* offset */
>> +              put_be32(&buffer, ieot->entries[i].offset);
>> +              strbuf_add(sb, &buffer, sizeof(uint32_t));
>> +
>> +              /* count */
>> +              put_be32(&buffer, ieot->entries[i].nr);
>> +              strbuf_add(sb, &buffer, sizeof(uint32_t));
>> +       }
>> +}
>> +#endif
>> --
>> 2.18.0.windows.1
>>
> 
> 
