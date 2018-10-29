Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEEF1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeJ3BzO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:55:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42539 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ3BzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:55:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id z20-v6so10075891qti.9
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUZMsuWhmPnJ4uHU+TR0/ObIOWZd724nM7UbJXTYC2c=;
        b=D7B7Xcki+m+Kewm5i3Moi5L3QYTqEgTj99E+j32u6Q+kuUgSdhx6ACzNiEmdKwlQ+h
         nZAt0QQWItH7odlX+Wap6CoO0/r6pE1cELjLFGfB18NizgDsx8Y+EBBDNA2k+kxh9LpO
         ZsJ2QkBedfV1gBz0ZSfFG4xb1sl0ZhR0U3YaN9hOfwvF6G71bRex57QkNWPCQdPbLsBG
         kfSPpcuLR4Xigo2Zkg09rez/Ijv6WTeH3liw+WKYnW8DMdLxOlcRqT1BpXXDX3b9Sj7l
         iHZu1AcgfSmh2xDmvX9pab1weMM/0b35v2UiDqTF20bt41UrL9d+nGDmBgtLB9TKNSCP
         yfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUZMsuWhmPnJ4uHU+TR0/ObIOWZd724nM7UbJXTYC2c=;
        b=r+z6sHhlSL3vbLCSaA8zErvcl3QrFLmCIeJalHAi7yQON8Usnk+wBfoE/kDzEn1rQM
         mNqTG3lnP7ZkPOmdct10kW7xF51fClgbhLrUxZdRYmUFJYpadiXoyvHHcRur90YBEHP/
         4PTDMRPi4TdZN2xDzbwl/OrPq27NZyd1cwfgx13FBFPMievER7ZTidfpJvU36ZPueoSC
         l7mSLkNo4mv5nGUY0x5BNdIXuAQRWzVUX1tON0+z6H8nYIT5yXL4WBciAXekBshdXSXQ
         UGsXKwbgOrhQmaI5pWShRSCMgNxNstVb5FVI+Mw089sdGlMCbwlrpsLqmUfVNOIqMrHM
         6+jg==
X-Gm-Message-State: AGRZ1gJzxcQrBqymT6qnoa4cvn1SixjmikNzIxzDKqnwclFwD8XpoGBx
        E7yCYzUQutgphDO/1Aqe6Lo=
X-Google-Smtp-Source: AJdET5f5OgtQ/wJ1PvaiabFI88yy5bzdlsKdJxZdyAnjCnZpKQXEzN/7jNtx+K/jTQDFTrSBCnU33A==
X-Received: by 2002:aed:3882:: with SMTP id k2-v6mr13054352qte.345.1540832744878;
        Mon, 29 Oct 2018 10:05:44 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y15-v6sm10350941qtn.34.2018.10.29.10.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:05:44 -0700 (PDT)
Subject: Re: [PATCH 09/10] read-cache.c: remove #ifdef NO_PTHREADS
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-10-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9e489011-36b9-a8b3-838d-de1a097f4854@gmail.com>
Date:   Mon, 29 Oct 2018 13:05:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181027071003.1347-10-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/27/2018 3:10 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   read-cache.c | 49 ++++++++++++++++++-------------------------------
>   1 file changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index d57958233e..ba870bc3fd 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1920,19 +1920,15 @@ struct index_entry_offset_table
>   	struct index_entry_offset entries[FLEX_ARRAY];
>   };
>   
> -#ifndef NO_PTHREADS
>   static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
>   static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
> -#endif
>   
>   static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
>   static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
>   
>   struct load_index_extensions
>   {
> -#ifndef NO_PTHREADS
>   	pthread_t pthread;
> -#endif
>   	struct index_state *istate;
>   	const char *mmap;
>   	size_t mmap_size;
> @@ -2010,8 +2006,6 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
>   	return consumed;
>   }
>   
> -#ifndef NO_PTHREADS
> -
>   /*
>    * Mostly randomly chosen maximum thread counts: we
>    * cap the parallelism to online_cpus() threads, and we want
> @@ -2122,7 +2116,6 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
>   
>   	return consumed;
>   }
> -#endif
>   
>   /* remember to discard_cache() before reading a different cache! */
>   int do_read_index(struct index_state *istate, const char *path, int must_exist)
> @@ -2135,10 +2128,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	size_t mmap_size;
>   	struct load_index_extensions p;
>   	size_t extension_offset = 0;
> -#ifndef NO_PTHREADS
>   	int nr_threads, cpus;
>   	struct index_entry_offset_table *ieot = NULL;
> -#endif
>   
>   	if (istate->initialized)
>   		return istate->cache_nr;
> @@ -2181,15 +2172,18 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   
>   	src_offset = sizeof(*hdr);
>   
> -#ifndef NO_PTHREADS
> -	nr_threads = git_config_get_index_threads();
> +	if (HAVE_THREADS) {

In this case, nr_threads is already capped to online_cpus() below so 
this HAVE_THREADS test isn't needed.

> +		nr_threads = git_config_get_index_threads();
>   
> -	/* TODO: does creating more threads than cores help? */
> -	if (!nr_threads) {
> -		nr_threads = istate->cache_nr / THREAD_COST;
> -		cpus = online_cpus();
> -		if (nr_threads > cpus)
> -			nr_threads = cpus;
> +		/* TODO: does creating more threads than cores help? */
> +		if (!nr_threads) {
> +			nr_threads = istate->cache_nr / THREAD_COST;
> +			cpus = online_cpus();
> +			if (nr_threads > cpus)
> +				nr_threads = cpus;
> +		}
> +	} else {
> +		nr_threads = 1;
>   	}
>   
>   	if (nr_threads > 1) {
> @@ -2219,21 +2213,16 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	} else {
>   		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
>   	}
> -#else
> -	src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
> -#endif
>   
>   	istate->timestamp.sec = st.st_mtime;
>   	istate->timestamp.nsec = ST_MTIME_NSEC(st);
>   
>   	/* if we created a thread, join it otherwise load the extensions on the primary thread */
> -#ifndef NO_PTHREADS
> -	if (extension_offset) {
> +	if (HAVE_THREADS && extension_offset) {

Here extension_offset won't be set if there wasn't a thread created so 
the HAVE_THREADS test is not needed.

>   		int ret = pthread_join(p.pthread, NULL);
>   		if (ret)
>   			die(_("unable to join load_index_extensions thread: %s"), strerror(ret));
>   	}
> -#endif
>   	if (!extension_offset) {
>   		p.src_offset = src_offset;
>   		load_index_extensions(&p);
> @@ -2756,8 +2745,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>   		return -1;
>   
> -#ifndef NO_PTHREADS
> -	nr_threads = git_config_get_index_threads();
> +	if (HAVE_THREADS)

This shouldn't be needed either.  My assumption was that if someone 
explicitly asked for multiple threads we're better off failing than 
silently ignoring their request.  The default/automatic setting will 
detect the number of cpus and behave correctly.

> +		nr_threads = git_config_get_index_threads();
> +	else
> +		nr_threads = 1;
> +
>   	if (nr_threads != 1) {
>   		int ieot_blocks, cpus;
>   
> @@ -2787,7 +2779,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   			ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
>   		}
>   	}
> -#endif
>   
>   	offset = lseek(newfd, 0, SEEK_CUR);
>   	if (offset < 0) {
> @@ -2871,8 +2862,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	 * strip_extensions parameter as we need it when loading the shared
>   	 * index.
>   	 */
> -#ifndef NO_PTHREADS
> -	if (ieot) {
> +	if (HAVE_THREADS && ieot) {

Again, this one isn't needed.  If there is only 1 thread, we don't read 
the eoie or the ieot (see the code just above this) so the ieot test is 
sufficient.

>   		struct strbuf sb = STRBUF_INIT;
>   
>   		write_ieot_extension(&sb, ieot);
> @@ -2883,7 +2873,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   		if (err)
>   			return -1;
>   	}
> -#endif
>   
>   	if (!strip_extensions && istate->split_index) {
>   		struct strbuf sb = STRBUF_INIT;
> @@ -3469,7 +3458,6 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
>   	strbuf_add(sb, hash, the_hash_algo->rawsz);
>   }
>   
> -#ifndef NO_PTHREADS
>   #define IEOT_VERSION	(1)
>   
>   static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
> @@ -3542,4 +3530,3 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
>   	       strbuf_add(sb, &buffer, sizeof(uint32_t));
>          }
>   }
> -#endif
> 
