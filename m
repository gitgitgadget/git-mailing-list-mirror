Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C4A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeHMVWn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:22:43 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39139 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbeHMVWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:22:43 -0400
Received: by mail-qk0-f195.google.com with SMTP id b5-v6so11683848qkg.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xhqpi0fJSixRgxS9rJ9kBZ6u29j2Q9mJtxBahSCSjeE=;
        b=B/SWWastyQben50w1QNcRwdUer07h+Z4B5swETrSIzE0f8C6sCUWYjjJIp8dCK/Xq0
         S62RvAEX5pNzDz2291el293JpfUJSsfz/GgXB+TkktTrARKiE4meLAXGzXXcdqYFeRvE
         KhrNJvgY75HamwGREp0CzPiwLpK0y5WRTI1nF98BfNfVPVbpsfVT0Mh2fuqe21ZxromY
         IQC4fTUXFjFgrn95zgyfliJGfRuSW8Te5uit5WGM6gHfPNwGTOHLu8B+MP87jtMRyABQ
         sDjtfbl31TDAHrXILE03OzqeJjfAoJETvY7WgUMEuLSQ1kunSZbqFFgI4vp/folUfPoX
         2xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xhqpi0fJSixRgxS9rJ9kBZ6u29j2Q9mJtxBahSCSjeE=;
        b=sa/ShZ9VbTHlzCsIKpzHItjjgjGtEMyQeAnuOsa+A92qJ3NDtNUyTWKx9SU/UjVjmu
         p+ZCwRg6ZS/zWTwPSxmWhDKFXzm3ZBd8WAuTjElZ4+O31xkxZy8GCLGnMJrDRIPMc63u
         svOTj+9MMsWTBwoZWsfRCj4926mxs3BiJOVCb7U4JN0QjCV1cZCGWJOrcthOtaFX5HBV
         KzvESspjVsQjDI5BudXpEATydgyUZPRMNOtjbO897O/dPFK4Z80OmfCTh4Q6KYJCyOVq
         XLrbPOPWkYd3a5yApConLH3MpUmaE3govhmHO3g6NAyduIuGbMBZUbSM10p3Lr/w1YHs
         dkDA==
X-Gm-Message-State: AOUpUlFCn+gTVkFX/xBeFBWDTMnHjurvLc4IAtKM5k2So2nqKMdlk7KX
        PsmSSXXdZwEGoaVIDn1U8NwZxOTa
X-Google-Smtp-Source: AA+uWPzVfPqHuwld4+c/csFw81FNgQabfZc0W2DXytG1cIDukro9ZuCXIQ+Fifl6TdYIHly7LX3wug==
X-Received: by 2002:a37:ac02:: with SMTP id e2-v6mr12569282qkm.75.1534185557589;
        Mon, 13 Aug 2018 11:39:17 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n25-v6sm8478424qtp.94.2018.08.13.11.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 11:39:16 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] trace.h: support nested performance tracing
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, Elijah Newren <newren@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-2-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5361e977-c476-0efe-5a2a-7d377dd51bbe@gmail.com>
Date:   Mon, 13 Aug 2018 14:39:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180812081551.27927-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/12/2018 4:15 AM, Nguyễn Thái Ngọc Duy wrote:
> Performance measurements are listed right now as a flat list, which is
> fine when we measure big blocks. But when we start adding more and
> more measurements, some of them could be just part of a bigger
> measurement and a flat list gives a wrong impression that they are
> executed at the same level instead of nested.
> 
> Add trace_performance_enter() and trace_performance_leave() to allow
> indent these nested measurements. For now it does not help much
> because the only nested thing is (lazy) name hash initialization
> (e.g. called in diff-index from "git status"). This will help more
> because I'm going to add some more tracing that's actually nested.
> 

I reviewed this and it looks reasonable to me.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   diff-lib.c      |  4 +--
>   dir.c           |  4 +--
>   name-hash.c     |  4 +--
>   preload-index.c |  4 +--
>   read-cache.c    | 11 ++++----
>   trace.c         | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
>   trace.h         | 15 +++++++++++
>   7 files changed, 92 insertions(+), 19 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index a9f38eb5a3..1ffa22c882 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -518,8 +518,8 @@ static int diff_cache(struct rev_info *revs,
>   int run_diff_index(struct rev_info *revs, int cached)
>   {
>   	struct object_array_entry *ent;
> -	uint64_t start = getnanotime();
>   
> +	trace_performance_enter();
>   	ent = revs->pending.objects;
>   	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
>   		exit(128);
> @@ -528,7 +528,7 @@ int run_diff_index(struct rev_info *revs, int cached)
>   	diffcore_fix_diff_index(&revs->diffopt);
>   	diffcore_std(&revs->diffopt);
>   	diff_flush(&revs->diffopt);
> -	trace_performance_since(start, "diff-index");
> +	trace_performance_leave("diff-index");
>   	return 0;
>   }
>   
> diff --git a/dir.c b/dir.c
> index 21e6f2520a..c5e9fc8cea 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2263,11 +2263,11 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>   		   const char *path, int len, const struct pathspec *pathspec)
>   {
>   	struct untracked_cache_dir *untracked;
> -	uint64_t start = getnanotime();
>   

I think removing the cost of has_symlink_leading_path() from this perf 
trace is probably OK to simplify the enter/leave logic.

>   	if (has_symlink_leading_path(path, len))
>   		return dir->nr;
>   
> +	trace_performance_enter();
>   	untracked = validate_untracked_cache(dir, len, pathspec);
>   	if (!untracked)
>   		/*
> @@ -2302,7 +2302,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>   		dir->nr = i;
>   	}
>   
> -	trace_performance_since(start, "read directory %.*s", len, path);
> +	trace_performance_leave("read directory %.*s", len, path);
>   	if (dir->untracked) {
>   		static int force_untracked_cache = -1;
>   		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
> diff --git a/name-hash.c b/name-hash.c
> index 163849831c..1fcda73cb3 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -578,10 +578,10 @@ static void threaded_lazy_init_name_hash(
>   
>   static void lazy_init_name_hash(struct index_state *istate)
>   {
> -	uint64_t start = getnanotime();
>   
>   	if (istate->name_hash_initialized)
>   		return;
> +	trace_performance_enter();
>   	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
>   	hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
>   
> @@ -602,7 +602,7 @@ static void lazy_init_name_hash(struct index_state *istate)
>   	}
>   
>   	istate->name_hash_initialized = 1;
> -	trace_performance_since(start, "initialize name hash");
> +	trace_performance_leave("initialize name hash");
>   }
>   
>   /*
> diff --git a/preload-index.c b/preload-index.c
> index 4d08d44874..d7f7919ba2 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -78,7 +78,6 @@ static void preload_index(struct index_state *index,
>   {
>   	int threads, i, work, offset;
>   	struct thread_data data[MAX_PARALLEL];
> -	uint64_t start = getnanotime();
>   
>   	if (!core_preload_index)
>   		return;
> @@ -88,6 +87,7 @@ static void preload_index(struct index_state *index,
>   		threads = 2;
>   	if (threads < 2)
>   		return;
> +	trace_performance_enter();
>   	if (threads > MAX_PARALLEL)
>   		threads = MAX_PARALLEL;
>   	offset = 0;
> @@ -109,7 +109,7 @@ static void preload_index(struct index_state *index,
>   		if (pthread_join(p->pthread, NULL))
>   			die("unable to join threaded lstat");
>   	}
> -	trace_performance_since(start, "preload index");
> +	trace_performance_leave("preload index");
>   }
>   #endif
>   
> diff --git a/read-cache.c b/read-cache.c
> index e865254bea..4fd35f4f37 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1399,8 +1399,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>   	const char *typechange_fmt;
>   	const char *added_fmt;
>   	const char *unmerged_fmt;
> -	uint64_t start = getnanotime();
>   
> +	trace_performance_enter();
>   	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
>   	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
>   	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
> @@ -1470,7 +1470,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>   
>   		replace_index_entry(istate, i, new_entry);
>   	}
> -	trace_performance_since(start, "refresh index");
> +	trace_performance_leave("refresh index");
>   	return has_errors;
>   }
>   
> @@ -1901,7 +1901,6 @@ static void freshen_shared_index(const char *shared_index, int warn)
>   int read_index_from(struct index_state *istate, const char *path,
>   		    const char *gitdir)
>   {
> -	uint64_t start = getnanotime();
>   	struct split_index *split_index;
>   	int ret;
>   	char *base_oid_hex;
> @@ -1911,8 +1910,9 @@ int read_index_from(struct index_state *istate, const char *path,
>   	if (istate->initialized)
>   		return istate->cache_nr;
>   
> +	trace_performance_enter();
>   	ret = do_read_index(istate, path, 0);
> -	trace_performance_since(start, "read cache %s", path);
> +	trace_performance_leave("read cache %s", path);
>   
>   	split_index = istate->split_index;
>   	if (!split_index || is_null_oid(&split_index->base_oid)) {
> @@ -1920,6 +1920,7 @@ int read_index_from(struct index_state *istate, const char *path,
>   		return ret;
>   	}
>   

This one is kind of odd how it's splitting up the index read from the 
split index but it's no more odd than it was before.

> +	trace_performance_enter();
>   	if (split_index->base)
>   		discard_index(split_index->base);
>   	else
> @@ -1936,8 +1937,8 @@ int read_index_from(struct index_state *istate, const char *path,
>   	freshen_shared_index(base_path, 0);
>   	merge_base_index(istate);
>   	post_read_index_from(istate);
> -	trace_performance_since(start, "read cache %s", base_path);
>   	free(base_path);
> +	trace_performance_leave("read cache %s", base_path);
>   	return ret;
>   }
>   
> diff --git a/trace.c b/trace.c
> index fc623e91fd..fa4a2e7120 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -176,10 +176,30 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
>   	strbuf_release(&buf);
>   }
>   
> +static uint64_t perf_start_times[10];
> +static int perf_indent;
> +
> +uint64_t trace_performance_enter(void)
> +{
> +	uint64_t now;
> +
> +	if (!trace_want(&trace_perf_key))
> +		return 0;
> +
> +	now = getnanotime();
> +	perf_start_times[perf_indent] = now;
> +	if (perf_indent + 1 < ARRAY_SIZE(perf_start_times))
> +		perf_indent++;
> +	else
> +		BUG("Too deep indentation");
> +	return now;
> +}
> +
>   static void trace_performance_vprintf_fl(const char *file, int line,
>   					 uint64_t nanos, const char *format,
>   					 va_list ap)
>   {
> +	static const char space[] = "          ";
>   	struct strbuf buf = STRBUF_INIT;
>   
>   	if (!prepare_trace_line(file, line, &trace_perf_key, &buf))
> @@ -188,7 +208,10 @@ static void trace_performance_vprintf_fl(const char *file, int line,
>   	strbuf_addf(&buf, "performance: %.9f s", (double) nanos / 1000000000);
>   
>   	if (format && *format) {
> -		strbuf_addstr(&buf, ": ");
> +		if (perf_indent >= strlen(space))
> +			BUG("Too deep indentation");
> +
> +		strbuf_addf(&buf, ":%.*s ", perf_indent, space);
>   		strbuf_vaddf(&buf, format, ap);
>   	}
>   
> @@ -244,6 +267,24 @@ void trace_performance_since(uint64_t start, const char *format, ...)
>   	va_end(ap);
>   }
>   
> +void trace_performance_leave(const char *format, ...)
> +{
> +	va_list ap;
> +	uint64_t since;
> +
> +	if (perf_indent)
> +		perf_indent--;
> +
> +	if (!format) /* Allow callers to leave without tracing anything */
> +		return;
> +
> +	since = perf_start_times[perf_indent];
> +	va_start(ap, format);
> +	trace_performance_vprintf_fl(NULL, 0, getnanotime() - since,
> +				     format, ap);
> +	va_end(ap);
> +}
> +
>   #else
>   
>   void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
> @@ -273,6 +314,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>   	va_end(ap);
>   }
>   
> +void trace_performance_leave_fl(const char *file, int line,
> +				uint64_t nanos, const char *format, ...)
> +{
> +	va_list ap;
> +	uint64_t since;
> +
> +	if (perf_indent)
> +		perf_indent--;
> +
> +	if (!format) /* Allow callers to leave without tracing anything */
> +		return;
> +
> +	since = perf_start_times[perf_indent];
> +	va_start(ap, format);
> +	trace_performance_vprintf_fl(file, line, nanos - since, format, ap);
> +	va_end(ap);
> +}
> +
>   #endif /* HAVE_VARIADIC_MACROS */
>   
>   
> @@ -411,13 +470,11 @@ uint64_t getnanotime(void)
>   	}
>   }
>   
> -static uint64_t command_start_time;
>   static struct strbuf command_line = STRBUF_INIT;
>   
>   static void print_command_performance_atexit(void)
>   {
> -	trace_performance_since(command_start_time, "git command:%s",
> -				command_line.buf);
> +	trace_performance_leave("git command:%s", command_line.buf);
>   }
>   
>   void trace_command_performance(const char **argv)
> @@ -425,10 +482,10 @@ void trace_command_performance(const char **argv)
>   	if (!trace_want(&trace_perf_key))
>   		return;
>   
> -	if (!command_start_time)
> +	if (!command_line.len)
>   		atexit(print_command_performance_atexit);
>   
>   	strbuf_reset(&command_line);
>   	sq_quote_argv_pretty(&command_line, argv);
> -	command_start_time = getnanotime();
> +	trace_performance_enter();
>   }
> diff --git a/trace.h b/trace.h
> index 2b6a1bc17c..171b256d26 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -23,6 +23,7 @@ extern void trace_disable(struct trace_key *key);
>   extern uint64_t getnanotime(void);
>   extern void trace_command_performance(const char **argv);
>   extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
> +uint64_t trace_performance_enter(void);
>   
>   #ifndef HAVE_VARIADIC_MACROS
>   
> @@ -45,6 +46,9 @@ extern void trace_performance(uint64_t nanos, const char *format, ...);
>   __attribute__((format (printf, 2, 3)))
>   extern void trace_performance_since(uint64_t start, const char *format, ...);
>   
> +__attribute__((format (printf, 1, 2)))
> +void trace_performance_leave(const char *format, ...);
> +
>   #else
>   
>   /*
> @@ -118,6 +122,14 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
>   					     __VA_ARGS__);		    \
>   	} while (0)
>   
> +#define trace_performance_leave(...)					    \
> +	do {								    \
> +		if (trace_pass_fl(&trace_perf_key))			    \
> +			trace_performance_leave_fl(TRACE_CONTEXT, __LINE__, \
> +						   getnanotime(),	    \
> +						   __VA_ARGS__);	    \
> +	} while (0)
> +
>   /* backend functions, use non-*fl macros instead */
>   __attribute__((format (printf, 4, 5)))
>   extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
> @@ -130,6 +142,9 @@ extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
>   __attribute__((format (printf, 4, 5)))
>   extern void trace_performance_fl(const char *file, int line,
>   				 uint64_t nanos, const char *fmt, ...);
> +__attribute__((format (printf, 4, 5)))
> +extern void trace_performance_leave_fl(const char *file, int line,
> +				       uint64_t nanos, const char *fmt, ...);
>   static inline int trace_pass_fl(struct trace_key *key)
>   {
>   	return key->fd || !key->initialized;
> 
