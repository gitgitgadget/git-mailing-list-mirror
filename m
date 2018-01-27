Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42FCD1F576
	for <e@80x24.org>; Sat, 27 Jan 2018 11:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeA0Lzp (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 06:55:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33294 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeA0Lzn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 06:55:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id x4so38337973wmc.0
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P3C/N6+1SvzzwBvGNB2gAbOcGLNa8id5DIP900sUNe4=;
        b=ldryF7rrIP4xgLq/O6i5bHdFBk118XOvDOW1DQfXZ/gI0/KGGFRrEE9sVY1mX+K+z2
         +FKY2SAC7wENitf+chbNwaRvCwHCDf5X1k4dm1T6GLvsg/uU7JyScF54dOlD6MCQuWtV
         izUPwiXvRjsGslYuxCVE0Y0CqiFQNtnJ/s/Wi+YyQE+v87mn8D3hp0uMmXdwHMOXSytx
         iN4lhvw6OMLSLjQiHwG4nferhu86bcthnMRMSl6ptqXCRH8V47rDrK9acpN8mihosEwf
         KT6k2Sj5rLWmZcgaywYk7/ZVt1aQswnWLhvjjPN+Kxtiws82aA3vDKql2HAtbO1b66eQ
         gQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P3C/N6+1SvzzwBvGNB2gAbOcGLNa8id5DIP900sUNe4=;
        b=cKvErWUdcCQvkV7EQY02LKbdoTGQYou2KfFjcKfbSbnwYuBaiQVzARtFQB/7Ybytyz
         qhDrSXvsPcnOAroq+XH/VQ409XvDpfokApO34g3N4hewzdTJuvwQatvfvQCcOwnc9DNR
         gltVFPF1B5OU2SrQU4rCWO5cXSMJqHNtf7PBEQu63OPoAGAeqgYGuoSalf+nk1nYY5hI
         sFRpVORfs6Uzf3PQHSa/EdswVKFctu5vful7P6CmQYVQ6+CZVDdXd4Xy0ww6tIr8DQpj
         haqv3r8Bz9r/bUzcz58rzRjY1KgQzn7xSd3jx/Euvu36pyU6zwsjB2VwJwLIAmuyRgpk
         4k2g==
X-Gm-Message-State: AKwxytf8x0PDJ3Ayc4pppYxsOoBSskftk0AqzkgQrJp0NMHkeY/WNmBr
        Ij/uouADOJSvefhkiMBZ8bk=
X-Google-Smtp-Source: AH8x224A0TsH2gkyrq5ZQDaCOEIy4FLRTiRU5V2QGfCEMHIfNsehIMpV3gn7KHIWMP0WsQYO0dyIxQ==
X-Received: by 10.28.7.68 with SMTP id 65mr12730222wmh.9.1517054142266;
        Sat, 27 Jan 2018 03:55:42 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 44sm14066956wrt.46.2018.01.27.03.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 03:55:41 -0800 (PST)
Date:   Sat, 27 Jan 2018 11:58:11 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        benpeart@microsoft.com, alexmv@dropbox.com,
        christian.couder@gmail.com, dturner@twopensource.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] trace: measure where the time is spent in the
 index-heavy operations
Message-ID: <20180127115811.GB2130@hank>
References: <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <20180127013956.21420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180127013956.21420-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/27, Nguyễn Thái Ngọc Duy wrote:
> All the known heavy code blocks are measured (except object database
> access). This should help identify if an optimization is effective or
> not. An unoptimized git-status would give something like below (92% of
> time is accounted).
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  This was in my old index-helper series. The series was replaced by
>  fsmonitor but perhaps some measurements like this still helps.
> 
>  In my old version I measured packed-refs read time too. But
>  packed-refs is mmap'd now, no need to worry about it (or at least its
>  initial cost).
> 
>  diff-lib.c      |  4 ++++
>  dir.c           |  2 ++
>  name-hash.c     |  3 +++
>  preload-index.c |  2 ++
>  read-cache.c    | 11 +++++++++++
>  5 files changed, 22 insertions(+)
>
> [...]
>  
> diff --git a/read-cache.c b/read-cache.c
> index 2eb81a66b9..1f00aee6a2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1372,6 +1372,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	const char *typechange_fmt;
>  	const char *added_fmt;
>  	const char *unmerged_fmt;
> +	uint64_t start = getnanotime();
>  
>  	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
>  	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
> @@ -1442,6 +1443,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  
>  		replace_index_entry(istate, i, new);
>  	}
> +	trace_performance_since(start, "refresh index");
>  	return has_errors;
>  }
>  
> @@ -1877,12 +1879,15 @@ int read_index_from(struct index_state *istate, const char *path)
>  	int ret;
>  	char *base_sha1_hex;
>  	const char *base_path;
> +	uint64_t start;
>  
>  	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
>  	if (istate->initialized)
>  		return istate->cache_nr;
>  
> +	start = getnanotime();
>  	ret = do_read_index(istate, path, 0);
> +	trace_performance_since(start, "read cache %s", path);
>  
>  	split_index = istate->split_index;
>  	if (!split_index || is_null_sha1(split_index->base_sha1)) {
> @@ -1897,6 +1902,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  
>  	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
>  	base_path = git_path("sharedindex.%s", base_sha1_hex);
> +	start = getnanotime();
>  	ret = do_read_index(split_index->base, base_path, 1);
>  	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
>  		die("broken index, expect %s in %s, got %s",
> @@ -1906,6 +1912,9 @@ int read_index_from(struct index_state *istate, const char *path)
>  	freshen_shared_index(base_sha1_hex, 0);
>  	merge_base_index(istate);
>  	post_read_index_from(istate);
> +	trace_performance_since(start, "read cache %s",
> +				git_path("sharedindex.%s",
> +					 sha1_to_hex(split_index->base_sha1)));

Would it be worth doing this on top of tg/split-index-fixes?  OTOH
this will only give a wrong output when tracing performance is on, and
it should be easy enough to figure out where the sharedindex actually
is.  So it might be better to keep this separate, and then just add a
patch on top for fixing the path later, which might be less work for
Junio.

So dunno what the best way is, just wanted to mention it.

>  	return ret;
>  }
>  
> @@ -2244,6 +2253,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  	struct ondisk_cache_entry_extended ondisk;
>  	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>  	int drop_cache_tree = 0;
> +	uint64_t start = getnanotime();
>  
>  	for (i = removed = extended = 0; i < entries; i++) {
>  		if (cache[i]->ce_flags & CE_REMOVE)
> @@ -2374,6 +2384,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  		return -1;
>  	istate->timestamp.sec = (unsigned int)st.st_mtime;
>  	istate->timestamp.nsec = ST_MTIME_NSEC(st);
> +	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
>  	return 0;
>  }
>  
> -- 
> 2.16.1.205.g271f633410
> 
