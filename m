Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24891F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJ3CNP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:13:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37020 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ3CNO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:13:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so10176062qto.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MzeeKrGSSJX1Ye+hJM5tG+3Z+BHv4RfYBFgLyl3EsDU=;
        b=dW+JR9SyoAyqYUR+WGY6m4/I/AFRSRZ24mwwodBfSHFWyUSVJTACFxXBl8wVsgckxi
         A4njZRs4PGSsCVjrTpiEF/ioQjb5qJzPeTttNDqyGLeLN0tcEDymPDPB5N4nCbWaFsLU
         Tvn094eZa5aTUUM4DUtIHsQutJi0HPdXUhnKb7/caV6uKVNza3GzoK7Fnfj+RadfA3Pv
         rJQzY+DNZllG4LoVGF4EV+E2GWGF4lZGMpXYCH/asaNJHQFk5/7rO6e6Lw5WeFlUk2aN
         HFWuFj857vzgvc1XRrBaU/IRw0g97R+f2gNTxkHr+HnLohvHKyO6KkKRb3r3fgbBIvHT
         nsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzeeKrGSSJX1Ye+hJM5tG+3Z+BHv4RfYBFgLyl3EsDU=;
        b=J5Vcl0CEADppupxHQ1OaHsqd9vd21DaWcgioyGI8ong8J0LIJIJmD182BjceRiF89R
         znNSZ3vbB1STcB+oi5dux1spBmknWcD6rBrQLtEFw/y73M/DQAsHJP15cAseZJEcGGcQ
         Yl3CH7vdBWHwEDR6NpDQFGZPyPNGUf7EfvQ8WgSZVPWxG0skE5RfOYN2qpUz+lUzpdYD
         H/j0sSmsBJ7ld/6EE2AeDJ1VfiJ6Wf9wmn1gIRm2YAzhYf+mDK9W5QV7XyJdfFmEyR+O
         LzYg5u+p7NDtOiNn0EP3z1IqpLY1sV+fV60I1k2FdTY7Fkh2/roRrd1QMh+PtQRYl9nZ
         MR1A==
X-Gm-Message-State: AGRZ1gJAMcmInvdo/UeV0qiSoPRvf2N9LXvhqIKulTW3+7/rwdSomf7C
        tmkqA9AFfhyftS7599io/z8=
X-Google-Smtp-Source: AJdET5eXv/b35rf5ytKikYJNlXiAGceDzSLWQX+3AHn+s6GLYGwK/LTpbVK1/tL/w5dg37iEKY4/uQ==
X-Received: by 2002:a0c:d232:: with SMTP id m47mr12817724qvh.43.1540833821422;
        Mon, 29 Oct 2018 10:23:41 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b2-v6sm5196223qkd.89.2018.10.29.10.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:23:40 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] read-cache.c: remove #ifdef NO_PTHREADS
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-9-pclouds@gmail.com>
 <20181029143033.GF17668@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <61d354e9-dd40-14a8-29dc-d989dd5631af@gmail.com>
Date:   Mon, 29 Oct 2018 13:23:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029143033.GF17668@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/29/2018 10:30 AM, Jeff King wrote:
> On Sat, Oct 27, 2018 at 07:30:06PM +0200, Nguyễn Thái Ngọc Duy wrote:
> 
>> -#ifndef NO_PTHREADS
>> -	nr_threads = git_config_get_index_threads();
>> +	if (HAVE_THREADS) {
>> +		nr_threads = git_config_get_index_threads();
>>   
>> -	/* TODO: does creating more threads than cores help? */
>> -	if (!nr_threads) {
>> -		nr_threads = istate->cache_nr / THREAD_COST;
>> -		cpus = online_cpus();
>> -		if (nr_threads > cpus)
>> -			nr_threads = cpus;
>> +		/* TODO: does creating more threads than cores help? */
>> +		if (!nr_threads) {
>> +			nr_threads = istate->cache_nr / THREAD_COST;
>> +			cpus = online_cpus();
>> +			if (nr_threads > cpus)
>> +				nr_threads = cpus;
>> +		}
>> +	} else {
>> +		nr_threads = 1;
>>   	}
> 
> I'd have thought we could just rely on online_cpus() returning 1 here to
> avoid having to ask "do we even have thread support?". But I guess that
> TODO comment implies that we might one day two 2 threads on a single
> CPU.
> 
> -Peff
> 

And here is the patch I created when testing out the idea of removing 
NO_PTHREADS.  It doesn't require any 'HAVE_THREADS' tests.



diff --git a/read-cache.c b/read-cache.c
index 1df5c16dbc..1f088799fc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1920,19 +1920,15 @@ struct index_entry_offset_table
         struct index_entry_offset entries[FLEX_ARRAY];
  };

-#ifndef NO_PTHREADS
  static struct index_entry_offset_table *read_ieot_extension(const char 
*mmap, size_t mmap_size, size_t offset
);
  static void write_ieot_extension(struct strbuf *sb, struct 
index_entry_offset_table *ieot);
-#endif

  static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
  static void write_eoie_extension(struct strbuf *sb, git_hash_ctx 
*eoie_context, size_t offset);

  struct load_index_extensions
  {
-#ifndef NO_PTHREADS
         pthread_t pthread;
-#endif
         struct index_state *istate;
         const char *mmap;
         size_t mmap_size;
@@ -2010,8 +2006,6 @@ static unsigned long load_all_cache_entries(struct 
index_state *istate,
         return consumed;
  }

-#ifndef NO_PTHREADS
-
  /*
   * Mostly randomly chosen maximum thread counts: we
   * cap the parallelism to online_cpus() threads, and we want
@@ -2122,7 +2116,6 @@ static unsigned long 
load_cache_entries_threaded(struct index_state *istate, con


         return consumed;
  }
-#endif

  /* remember to discard_cache() before reading a different cache! */
  int do_read_index(struct index_state *istate, const char *path, int 
must_exist)
@@ -2135,10 +2128,8 @@ int do_read_index(struct index_state *istate, 
const char *path, int must_exist)

         size_t mmap_size;
         struct load_index_extensions p;
         size_t extension_offset = 0;
-#ifndef NO_PTHREADS
         int nr_threads, cpus;
         struct index_entry_offset_table *ieot = NULL;
-#endif

         if (istate->initialized)
                 return istate->cache_nr;
@@ -2181,16 +2172,12 @@ int do_read_index(struct index_state *istate, 
const char *path, int must_exist
)

         src_offset = sizeof(*hdr);

-#ifndef NO_PTHREADS
         nr_threads = git_config_get_index_threads();
-
-       /* TODO: does creating more threads than cores help? */
-       if (!nr_threads) {
+       if (!nr_threads)
                 nr_threads = istate->cache_nr / THREAD_COST;
-               cpus = online_cpus();
-               if (nr_threads > cpus)
-                       nr_threads = cpus;
-       }
+       cpus = online_cpus();
+       if (nr_threads > cpus)
+               nr_threads = cpus;

         if (nr_threads > 1) {
                 extension_offset = read_eoie_extension(mmap, mmap_size);
@@ -2219,22 +2206,16 @@ int do_read_index(struct index_state *istate, 
const char *path, int must_exist
)
         } else {
                 src_offset += load_all_cache_entries(istate, mmap, 
mmap_size, src_offset);
         }
-#else
-       src_offset += load_all_cache_entries(istate, mmap, mmap_size, 
src_offset);
-#endif

         istate->timestamp.sec = st.st_mtime;
         istate->timestamp.nsec = ST_MTIME_NSEC(st);

         /* if we created a thread, join it otherwise load the 
extensions on the primary thread */
-#ifndef NO_PTHREADS
         if (extension_offset) {
                 int ret = pthread_join(p.pthread, NULL);
                 if (ret)
                         die(_("unable to join load_index_extensions 
thread: %s"), strerror(ret));
-       }
-#endif
-       if (!extension_offset) {
+       } else {
                 p.src_offset = src_offset;
                 load_index_extensions(&p);
         }
@@ -2756,7 +2737,6 @@ static int do_write_index(struct index_state 
*istate, struct tempfile *tempfile,

         if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
                 return -1;

-#ifndef NO_PTHREADS
         nr_threads = git_config_get_index_threads();
         if (nr_threads != 1) {
                 int ieot_blocks, cpus;
@@ -2787,7 +2767,6 @@ static int do_write_index(struct index_state 
*istate, struct tempfile *tempfile,

                         ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
                 }
         }
-#endif

         offset = lseek(newfd, 0, SEEK_CUR);
         if (offset < 0) {
@@ -2871,7 +2850,6 @@ static int do_write_index(struct index_state 
*istate, struct tempfile *tempfile,

          * strip_extensions parameter as we need it when loading the shared
          * index.
          */
-#ifndef NO_PTHREADS
         if (ieot) {
                 struct strbuf sb = STRBUF_INIT;

@@ -2883,7 +2861,6 @@ static int do_write_index(struct index_state 
*istate, struct tempfile *tempfile,

                 if (err)
                         return -1;
         }
-#endif

         if (!strip_extensions && istate->split_index) {
                 struct strbuf sb = STRBUF_INIT;
@@ -3469,7 +3446,6 @@ static void write_eoie_extension(struct strbuf 
*sb, git_hash_ctx *eoie_context,

         strbuf_add(sb, hash, the_hash_algo->rawsz);
  }

-#ifndef NO_PTHREADS
  #define IEOT_VERSION   (1)

  static struct index_entry_offset_table *read_ieot_extension(const char 
*mmap, size_t mmap_size, size_t offset
)
@@ -3542,4 +3518,3 @@ static void write_ieot_extension(struct strbuf 
*sb, struct index_entry_offset_ta

                strbuf_add(sb, &buffer, sizeof(uint32_t));
         }
  }
-#endif
