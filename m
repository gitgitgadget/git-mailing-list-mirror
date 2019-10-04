Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E001F4C6
	for <e@80x24.org>; Fri,  4 Oct 2019 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfJDWF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:05:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:05:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so4699856pfb.7
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2L7ydwaQSwtvlS0q2Zk/vPeIp9xSopCq4woWEKjB9So=;
        b=T/FnAahFpuHP1kJhNTHdH7RJX3in53fkQuxnLY20fzSWvs+QASKSihLTIYMc43I7St
         L6dmTouLHhLMubSRUi9ngfpbf4ltT/VnAW5teOV7ZN6KItOB/kPgSzJEna7IHsfhz7bG
         U+dJE7Y1Qwc+J8ybza28oiIaXNecu5/USp5HXW9iLr0XjgdTkqT4eRid3xtvLE/h3WW5
         38RtjcqRyKs21AMStiAlqR3UQAuztBjBcGJ708BggjlKtHtqUuJcWHNFhbI0wnkXoXSR
         LUB6UPI674AdJ8YJr3w4Hv2tupbpw9ujC+QnEYeoozi2mvi4Ll1Nr+e5Zo5Dluc9V6mZ
         D6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2L7ydwaQSwtvlS0q2Zk/vPeIp9xSopCq4woWEKjB9So=;
        b=mP9mbHdKLEy7Wa5nG7aJ29tBcR9IMmdXCXD0Q0OUYPBDhfOKYN+pQMASJgvlSIq1IL
         3BdtDCuww4BGL8FYP1eO9WqgrlfIG0aHpsWyEGKRVS/eTLC9XKW61yUf3jvEU4Z22XKW
         XdQ/hs2tLMdHhvr+j9paV9X31J4rFQvObM0XKWozTuiJ91qSeNoSjmkxrlbUm5WSMA5q
         n/1YGZoOwHUN/sq19tmfyOIGxlNt/PTbD7uskBw4NYPgJYo9EBdKuB/2616aRL8RDkcA
         VbN9B40BwnoHIGEvvTKwGNY9VKthctB9a+xzNjJiQuvC7aMo0grCWLE5h8pFAD4fZvut
         iAlg==
X-Gm-Message-State: APjAAAUgVy4D/uuwWW6c6wnl9zciZtGuiNXR8bVM2z3wUD41/h1CTGbA
        7E19WymMlyxD9UKXLk8BN5auSw==
X-Google-Smtp-Source: APXvYqxic8QigsqiTDxMFTI0e8J/A+qk2XyudH8AH/mKmY39N1cyiqGucrlZS0WGp8y70jKWyKTKtw==
X-Received: by 2002:a65:48ca:: with SMTP id o10mr15674476pgs.116.1570226754101;
        Fri, 04 Oct 2019 15:05:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id j128sm10551450pfg.51.2019.10.04.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 15:05:53 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:05:48 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH v4 3/4] trace2: don't overload target directories
Message-ID: <20191004220548.GC224668@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570144820.git.steadmon@google.com>
 <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
 <nycvar.QRO.7.76.6.1910041105290.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910041105290.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.04 11:12, Johannes Schindelin wrote:
> Hi Josh,
> 
> On Thu, 3 Oct 2019, Josh Steadmon wrote:
> 
> > [...]
> > diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> > index 5dda0ca1cd..af3405f179 100644
> > --- a/trace2/tr2_dst.c
> > +++ b/trace2/tr2_dst.c
> > @@ -1,3 +1,5 @@
> > +#include <dirent.h>
> > +
> 
> This completely breaks the Windows build:
> 
> 	In file included from trace2/tr2_dst.c:1:
> 	compat/win32/dirent.h:13:14: error: 'MAX_PATH' undeclared here (not in a
> 	function)
> 	   13 |  char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversion) */
> 	      |              ^~~~~~~~
> 
> See the full build log in all its glory here:
> 
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=17409&view=logs&jobId=fd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=ce91d5d6-0c55-50f5-8ab9-6695c03ab102&lineStart=252&lineEnd=255&colStart=1&colEnd=30
> 
> The fix is as easy as probably surprising: simply delete that
> `#include`. It is redundant anyway:
> https://github.com/git/git/blob/v2.23.0/git-compat-util.h#L184

Sorry about that. Fixed in V5, which will be out shortly. Is there a way
to trigger the Azure pipeline apart from using GitGitGadget?

> Deleting that `#include` line from your patch not only lets the file
> compile cleanly on Windows, it also conforms to our coding style where
> `cache.h` or `git-compat-util.h` need to be the first `#include`. That
> rule's purpose is precisely to prevent platform-specific compile errors
> like the one shown above.

Hmm, I wonder if Coccinelle could catch more CodingGuideline mistakes
such as this? Although it seems there are a few exceptions to this rule,
so maybe it's not a good fit in this particular case.

> Ciao,
> Johannes
> 
> >  #include "cache.h"
> >  #include "trace2/tr2_dst.h"
> >  #include "trace2/tr2_sid.h"
> > @@ -8,6 +10,19 @@
> >   */
> >  #define MAX_AUTO_ATTEMPTS 10
> >
> > +/*
> > + * Sentinel file used to detect when we're overloading a directory with too many
> > + * trace files.
> > + */
> > +#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
> > +
> > +/*
> > + * When set to zero, disables directory overload checking. Otherwise, controls
> > + * how many files we can write to a directory before entering overload mode.
> > + * This can be overridden via the TR2_SYSENV_MAX_FILES setting.
> > + */
> > +static int tr2env_max_files = 0;
> > +
> >  static int tr2_dst_want_warning(void)
> >  {
> >  	static int tr2env_dst_debug = -1;
> > @@ -32,6 +47,67 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
> >  	dst->need_close = 0;
> >  }
> >
> > +/*
> > + * Check to make sure we're not overloading the target directory with too many
> > + * files. First get the threshold (if present) from the config or envvar. If
> > + * it's zero or unset, disable this check.  Next check for the presence of a
> > + * sentinel file, then check file count. If we are overloaded, create the
> > + * sentinel file if it doesn't already exist.
> > + *
> > + * We expect that some trace processing system is gradually collecting files
> > + * from the target directory; after it removes the sentinel file we'll start
> > + * writing traces again.
> > + */
> > +static int tr2_dst_overloaded(const char *tgt_prefix)
> > +{
> > +	int file_count = 0, max_files = 0, ret = 0;
> > +	const char *max_files_var;
> > +	DIR *dirp;
> > +	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
> > +	struct stat statbuf;
> > +
> > +	/* Get the config or envvar and decide if we should continue this check */
> > +	max_files_var = tr2_sysenv_get(TR2_SYSENV_MAX_FILES);
> > +	if (max_files_var && *max_files_var && ((max_files = atoi(max_files_var)) >= 0))
> > +		tr2env_max_files = max_files;
> > +
> > +	if (!tr2env_max_files) {
> > +		ret = 0;
> > +		goto cleanup;
> > +	}
> > +
> > +	strbuf_addstr(&path, tgt_prefix);
> > +	if (!is_dir_sep(path.buf[path.len - 1])) {
> > +		strbuf_addch(&path, '/');
> > +	}
> > +
> > +	/* check sentinel */
> > +	strbuf_addbuf(&sentinel_path, &path);
> > +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
> > +	if (!stat(sentinel_path.buf, &statbuf)) {
> > +		ret = 1;
> > +		goto cleanup;
> > +	}
> > +
> > +	/* check file count */
> > +	dirp = opendir(path.buf);
> > +	while (file_count < tr2env_max_files && dirp && readdir(dirp))
> > +		file_count++;
> > +	if (dirp)
> > +		closedir(dirp);
> > +
> > +	if (file_count >= tr2env_max_files) {
> > +		creat(sentinel_path.buf, 0666);
> > +		ret = 1;
> > +		goto cleanup;
> > +	}
> > +
> > +cleanup:
> > +	strbuf_release(&path);
> > +	strbuf_release(&sentinel_path);
> > +	return ret;
> > +}
> > +
> >  static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> >  {
> >  	int fd;
> > @@ -50,6 +126,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> >  	strbuf_addstr(&path, sid);
> >  	base_path_len = path.len;
> >
> > +	if (tr2_dst_overloaded(tgt_prefix)) {
> > +		strbuf_release(&path);
> > +		if (tr2_dst_want_warning())
> > +			warning("trace2: not opening %s trace file due to too "
> > +				"many files in target directory %s",
> > +				tr2_sysenv_display_name(dst->sysenv_var),
> > +				tgt_prefix);
> > +		return 0;
> > +	}
> > +
> >  	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
> >  		if (attempt_count > 0) {
> >  			strbuf_setlen(&path, base_path_len);
> > diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
> > index 5958cfc424..3c3792eca2 100644
> > --- a/trace2/tr2_sysenv.c
> > +++ b/trace2/tr2_sysenv.c
> > @@ -49,6 +49,9 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
> >  				       "trace2.perftarget" },
> >  	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TRACE2_PERF_BRIEF",
> >  				       "trace2.perfbrief" },
> > +
> > +	[TR2_SYSENV_MAX_FILES]     = { "GIT_TRACE2_MAX_FILES",
> > +				       "trace2.maxfiles" },
> >  };
> >  /* clang-format on */
> >
> > diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
> > index 8dd82a7a56..d4364a7b85 100644
> > --- a/trace2/tr2_sysenv.h
> > +++ b/trace2/tr2_sysenv.h
> > @@ -24,6 +24,8 @@ enum tr2_sysenv_variable {
> >  	TR2_SYSENV_PERF,
> >  	TR2_SYSENV_PERF_BRIEF,
> >
> > +	TR2_SYSENV_MAX_FILES,
> > +
> >  	TR2_SYSENV_MUST_BE_LAST
> >  };
> >
> > --
> > 2.23.0.581.g78d2f28ef7-goog
> >
> >
