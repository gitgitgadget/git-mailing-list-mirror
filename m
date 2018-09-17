Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C4D1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeIQUWp (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 16:22:45 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:42605 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbeIQUWp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 16:22:45 -0400
Received: by mail-qt0-f182.google.com with SMTP id z8-v6so15503220qto.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4pJ+GXX7j3XZBcchV+J7+kHBLhSpdxkfyYPPKFO/Fto=;
        b=Csoi6mRgk+Ttl15Y+P46cFf+SAiT8mx230f39VrQa1VC3qJDOYqJBNZJgyRhXfFpIc
         en0Atsf5p20UMnQ6nbDHZB4xPX5yPvBCgPI+TARgScJOa7GgfaG1rZFJmVS/6dAztcLu
         LZyUIz2YvqbKCDx+C9taPAe0rOv0whW2Wj7gXp31yPUZ6amyTefYEhmUaF7kMSpbLmaN
         ioIQMnsWM96/c2XSiqza7dXlNpdv1LhWWiQ/mrc6gSc7XZj0Yt3+NqylUApEjgod5p1c
         +teO5l2fuBbHxbCooRF8QQw/HNkX/jlg7+Asgm3xXGZZU3FECBeeZgdyrploxGy4rjOD
         HobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4pJ+GXX7j3XZBcchV+J7+kHBLhSpdxkfyYPPKFO/Fto=;
        b=GZqGVimSrsc5QQEhFa1lV4PqlUkb843Gjc36AsFz2eYEmvVlfrySCo96XSPpGe/JFg
         TD0Bp6uhubG91niWKJnu1LnKUTi+Wb9EKxQyCRVIInDPBmbcBFsW3NwXNu6f33yT4vXS
         QAUSIJ4NA4+8AlMMejqHvCTkDGXMZt2UGZ4sFPYtFzCUdfTIgRy92wnrYmEg4Zlo4+Fm
         C4/fEMc8Fj8DGxhSW1IKu6eK3ABEIji47XxK5WEULg9YMfgA1DObdSkJTVKGlm51ZGoj
         PaqgtUZP0fnEdrWW45a9Wk8EeMmdgnhpSz7IBolQHo8Xk0eaCgDCUGhoe1pUW9o+Jqlx
         cmnA==
X-Gm-Message-State: APzg51BxhhN9HlON9HesWuEN42NYIr1roCfqlAM0zodQQ4SfvZiEAaiD
        cx7u90ChkNs5AQFWMVOMYgE=
X-Google-Smtp-Source: ANB0VdbXl0+/Oya361U/wedIULIXwoXFTua3cEw3wPMIKDt+G0ZMX06ETqa1pjB+y/CXYPlHx8t5Vg==
X-Received: by 2002:ad4:4089:: with SMTP id l9-v6mr18136818qvp.160.1537196102627;
        Mon, 17 Sep 2018 07:55:02 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p57-v6sm11556299qtj.42.2018.09.17.07.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:55:01 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
 <20180912161832.55324-2-benpeart@microsoft.com>
 <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f7250999-71a3-0113-2858-e66bad283db3@gmail.com>
Date:   Mon, 17 Sep 2018 10:54:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/2018 6:02 AM, Duy Nguyen wrote:

>>          default:
>>                  if (*ext < 'A' || 'Z' < *ext)
>>                          return error("index uses %.4s extension, which we do not understand",
>> @@ -1889,6 +1893,11 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>>          return ondisk_size + entries * per_entry;
>>   }
>>
>> +#ifndef NO_PTHREADS
>> +static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
>> +#endif
> 
> Keep functions unconditionally built as much as possible. I don't see
> why this read_eoie_extension() must be built only on multithread
> platforms.
> 

This is conditional to avoid generating a warning on single threaded 
platforms where the function is currently unused.  That seemed like a 
better choice than calling it and ignoring it on single threaded 
platforms just to avoid a compiler warning.

>> +static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset);
>> +
>>   /* remember to discard_cache() before reading a different cache! */
>>   int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>   {
>> @@ -2198,11 +2207,15 @@ static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
>>          return 0;
>>   }
>>
>> -static int write_index_ext_header(git_hash_ctx *context, int fd,
>> -                                 unsigned int ext, unsigned int sz)
>> +static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoie_context,
>> +                                 int fd, unsigned int ext, unsigned int sz)
>>   {
>>          ext = htonl(ext);
>>          sz = htonl(sz);
>> +       if (eoie_context) {
>> +               the_hash_algo->update_fn(eoie_context, &ext, 4);
>> +               the_hash_algo->update_fn(eoie_context, &sz, 4);
>> +       }
>>          return ((ce_write(context, fd, &ext, 4) < 0) ||
>>                  (ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
>>   }
>> @@ -2445,7 +2458,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>   {
>>          uint64_t start = getnanotime();
>>          int newfd = tempfile->fd;
>> -       git_hash_ctx c;
>> +       git_hash_ctx c, eoie_c;
>>          struct cache_header hdr;
>>          int i, err = 0, removed, extended, hdr_version;
>>          struct cache_entry **cache = istate->cache;
>> @@ -2454,6 +2467,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>          struct ondisk_cache_entry_extended ondisk;
>>          struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>>          int drop_cache_tree = istate->drop_cache_tree;
>> +       unsigned long offset;
>>
>>          for (i = removed = extended = 0; i < entries; i++) {
>>                  if (cache[i]->ce_flags & CE_REMOVE)
>> @@ -2520,11 +2534,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>                  return err;
>>
>>          /* Write extension data here */
>> +       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
>> +       the_hash_algo->init_fn(&eoie_c);
> 
> Don't write (or even calculate to write it) unless it's needed. Which
> means only do this when parallel reading is enabled and the index size
> large enough, or when a test variable is set so you can force writing
> this extension.

I made the logic always write the extension based on the earlier 
discussion [1] where it was suggested this should have been part of the 
original index format for extensions from the beginning.  This helps 
ensure it is available for current and future uses we haven't even 
discovered yet.

[1] 
https://public-inbox.org/git/xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com/


>> +
>> +static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset)
> 
> We normally just put function implementations before it's used to
> avoid static forward declaration. Any special reason why it's not done
> here?
> 

This was done to promote readability of the (already large) read-cache.c 
file.  I first considered moving the EOIE read/write functions into a 
separate file entirely but they need access to information only 
available within read-cache.c so I compromised and moved them to the end 
of the file instead.

>> +{
>> +       uint32_t buffer;
>> +       unsigned char hash[GIT_MAX_RAWSZ];
>> +
>> +       /* offset */
>> +       put_be32(&buffer, offset);
>> +       strbuf_add(sb, &buffer, sizeof(uint32_t));
>> +
>> +       /* hash */
>> +       the_hash_algo->final_fn(hash, eoie_context);
>> +       strbuf_add(sb, hash, the_hash_algo->rawsz);
>> +}
>> diff --git a/t/README b/t/README
>> index 9028b47d92..d8754dd23a 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -319,6 +319,11 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>>   path where deltas larger than this limit require extra memory
>>   allocation for bookkeeping.
>>
>> +GIT_TEST_DISABLE_EOIE=<boolean> disables writing the EOIE extension.
>> +This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
> 
> I have a feeling that you won't have problems if you don't write eoie
> extension by default in the first place. Then this could be switched
> to GIT_TEST_ENABLE_EOIE instead. We may still have problem if both
> eoie and split index are forced on when running through the test
> suite, but that should be an easy fix.
> 
>> +as they currently hard code SHA values for the index which are no longer
>> +valid due to the addition of the EOIE extension.
>> +
>>   Naming Tests
>>   ------------
>>
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index 39133bcbc8..f613dd72e3 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -7,6 +7,7 @@ test_description='split index mode tests'
>>   # We need total control of index splitting here
>>   sane_unset GIT_TEST_SPLIT_INDEX
>>   sane_unset GIT_FSMONITOR_TEST
>> +export GIT_TEST_DISABLE_EOIE=true
>>
>>   test_expect_success 'enable split index' '
>>          git config splitIndex.maxPercentChange 100 &&
>> --
>> 2.18.0.windows.1
>>
> 
> 
