Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DD7208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 21:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdHOVbU (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 17:31:20 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37666 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdHOVbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 17:31:19 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so13012161pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F+Gx3No0x+E1m0+MtRLnGGGWQUYP1qBSjAWCV64QC1I=;
        b=khzAHWqpmo6IRQ6bmmGWMNgAe/jaZMY2KEiBCKVO1k4jfrSVhFftT2sXftNZwDO5Q0
         53oQZPMTnnexcoP7YHR8nDtKT+z1ViZsKIdaLAW/dcIw1hkFbpvXQGDpisQS1iKPqRKt
         0DHcbJKiB/haLqwCW0rgLKMqbUBuenVFhgv8YBJlrb7WBYF1RPTyqsKdYD1DMl/GyLgD
         0W9BtyEn3VfExUQSaL9TAs0yRQQfIKPAIileNEf9wXHfJU20wgm718kQkfAXupZUAWOj
         Nb5fgJ1Wy0oUywKn2sOEAkwHe+W9/4jKKwhvMk9causjm4mWwFTUCLD0GcXKAVX2Gr8P
         Nc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+Gx3No0x+E1m0+MtRLnGGGWQUYP1qBSjAWCV64QC1I=;
        b=Z9Ejb/rfLCpkUGvIsmZNO169sLECr5w/BPRFaX17E21JfEi6ug5iQXnHN25GKUHhQ/
         0wHaqe4K66wvNOmn8hpfQOYdcFwaxipLsm/x6Z8ToOpD+fwzeATcgKANnF1gYmqn9qUb
         WKpzAn0sR7j6jNk/gYTEddhJsNzFm7sUwfcaIKDPE0tbjhhBf97jpSnTrjfZkwWeHk2v
         ranlLgKD9pzW4kU+hPWgkd1FsZxIbBacwu776RG+Z6NbbpOxCa5mf6Xv3p5BJgIGM8Cz
         6wB3cxG6CCWNL3TrcSZn8Ti0jgDz5R4ZziU/YpScOikwLcBsUzOiZ62kzH7cC31aLNcv
         JpUA==
X-Gm-Message-State: AHYfb5h96q+GYDbzCVWfP8nOf/62cgnxs1ztcr3cxbzIwoDgI+OTiMsx
        3t5xcrYQrr6W4Wqr
X-Received: by 10.98.75.218 with SMTP id d87mr28962491pfj.135.1502832678978;
        Tue, 15 Aug 2017 14:31:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:593a:8ead:b053:9e22])
        by smtp.gmail.com with ESMTPSA id t77sm19982228pfj.9.2017.08.15.14.31.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 14:31:17 -0700 (PDT)
Date:   Tue, 15 Aug 2017 14:31:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: make read_info_alternates static
Message-ID: <20170815213116.GC21874@google.com>
References: <20170815201319.32395-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815201319.32395-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/15, Stefan Beller wrote:
> read_info_alternates is not used from outside, so let's make it static.
> 
> We have to declare the function before link_alt_odb_entry instead of
> moving the code around, link_alt_odb_entry calls read_info_alternates,
> which in turn calls link_alt_odb_entry.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>   This helps in a later refactoring (moving the object
>   store to the_repository struct), too.
>   
>   Thanks,
>   Stefan
> 
>  cache.h     | 1 -
>  sha1_file.c | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 1c69d2a05a..4109efcf24 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1551,7 +1551,6 @@ extern struct alternate_object_database {
>  	char path[FLEX_ARRAY];
>  } *alt_odb_list;
>  extern void prepare_alt_odb(void);
> -extern void read_info_alternates(const char * relative_base, int depth);
>  extern char *compute_alternate_path(const char *path, struct strbuf *err);
>  typedef int alt_odb_fn(struct alternate_object_database *, void *);
>  extern int foreach_alt_odb(alt_odb_fn, void*);
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15f70..9186e2c6c7 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -347,6 +347,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
>   * SHA1, an extra slash for the first level indirection, and the
>   * terminating NUL.
>   */
> +static void read_info_alternates(const char * relative_base, int depth);
>  static int link_alt_odb_entry(const char *entry, const char *relative_base,
>  	int depth, const char *normalized_objdir)
>  {
> @@ -448,7 +449,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>  	strbuf_release(&objdirbuf);
>  }
>  
> -void read_info_alternates(const char * relative_base, int depth)
> +static void read_info_alternates(const char * relative_base, int depth)
>  {
>  	char *map;
>  	size_t mapsz;
> -- 
> 2.14.0.rc0.3.g6c2e499285
> 

Looks good to me.  Only nit is I would fix the style to not have a space
after the '*' ;)

-- 
Brandon Williams
