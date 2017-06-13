Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0A520401
	for <e@80x24.org>; Tue, 13 Jun 2017 01:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbdFMBFX (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 21:05:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34882 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdFMBFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 21:05:23 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so15836495pgc.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Co7WwmnCNSgxwef0QklBoW9/zYvL9VA3jzXnywHqNA4=;
        b=hHW0wIMdynfanp8OJhFsNeHVP38givIGJXvnlLVwU3NGur5dKdKJ88kjEewZcLD6qc
         1K+0wdPsl/4n+h4sMv0nK/Ke7bF+Uyt0Rn47diiXgXQWuaPMWsEkcatBRaoLB29oWgMw
         YdtTspkViaNNpfczc++3SyD15luayghXTuJP5Chu6RJoa5PU19abpRDOl/Ykg7BRKfPd
         4qFQosl452Yf1jUK9y6xI4P7Am976qcX80DHhstsWXTaEQjAXa3e8+JRbrt4khrZZmWZ
         1TvGb5c2iwceV2Wc3l7MMpgSOiDfrIqGQvPBUTU08OckDricu7HwF6Kw8BQYXEOohT0e
         ducA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Co7WwmnCNSgxwef0QklBoW9/zYvL9VA3jzXnywHqNA4=;
        b=jLL6f/Sb89pCOTV8O29TDfCavvNPSR4MfucxNIGE4OcxtN/w9zDnK7lEuf49dXT5a3
         XAkBEp6MzXzQFItCyhu+e4QolOej1sN/LJqAtckzQvj2UVvAc2vE8l0FkG5UecLePw0D
         hDmYAUZosh5xZ1rvMpGit3msPB/S1ANAJNr4sH5V9AKPWvXgot1eCuTg44Oktm3sT+0b
         3QN/9TynpG5poKfyw7hpl+t6IxE8geAsPELWUANBOAf7t53DQ64t3INnNZGxdO5UYpyW
         y48g3sRrXoRrHnhw9uM5R1+ktN52JJsjzLkrtwB+Ei6U2DwPV1l1DGu9jZfKNudM0yPW
         yLlA==
X-Gm-Message-State: AODbwcDOaGRfZh/yK9FjY1C4VfaHuIpmIdmx1E0hZbCqRRCaxvYKTweE
        fJTal3Ud+68Jkg==
X-Received: by 10.98.86.13 with SMTP id k13mr36910932pfb.187.1497315922142;
        Mon, 12 Jun 2017 18:05:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id t5sm20091245pgt.19.2017.06.12.18.05.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 18:05:20 -0700 (PDT)
Date:   Mon, 12 Jun 2017 18:05:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613010518.GB133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612213406.83247-5-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> not set up) added a 'git_dir' field to the config_options struct.  Let's
> use this option field explicitly all the time instead of occasionally
> falling back to calling 'git_pathdup("config")' to get the path to the
> local repository configuration.  This allows 'do_git_config_sequence()'
> to not implicitly rely on global repository state.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/config.c | 2 ++
>  config.c         | 6 ++----
>  2 files changed, 4 insertions(+), 4 deletions(-)

Unlike the previous 3, this one makes me pause for a moment: it means
that "gitdir:" includes and .git/config discovery would stop working
if the caller does not remember to set git_dir in their
config_options.

So we have to inspect callers.

Callers that set respect_includes = 1:

- read_early_config carefully sets git_dir *phew*
- git_config_raw doesn't and is used approximately everywhere.

do_git_config_sequence call chain:
- called by git_config_with_options, which is called by
  - read_early_config
  - git_config_raw
  - various callers in builtin/config.c, using &config_options

> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -539,6 +539,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		config_options.respect_includes = !given_config_source.file;
>  	else
>  		config_options.respect_includes = respect_includes_opt;
> +	if (have_git_dir())
> +		config_options.git_dir = get_git_common_dir();

nit: because of the context, this 'if' can be "if (!nongit)".

[...]
> --- a/config.c
> +++ b/config.c
> @@ -219,8 +219,6 @@ static int include_by_gitdir(const struct config_options *opts,
>  
>  	if (opts->git_dir)
>  		git_dir = opts->git_dir;
> -	else if (have_git_dir())
> -		git_dir = get_git_dir();
>  	else
>  		goto done;

I wonder if this should have a sanity-check:

	else if (have_git_dir())
		BUG("caller forgot to set opts->git_dir");

Alternatively, could this patch rename git_config_with_options?  That
way any other patch in flight that calls git_config_with_options would
conflict with this patch, giving us an opportunity to make sure it
also sets git_dir.  As another nice side benefit it would make it easy
for someone reading the patch to verify it didn't miss any callers.

> @@ -1548,8 +1546,6 @@ static int do_git_config_sequence(const struct config_options *opts,
>  
>  	if (opts->git_dir)
>  		repo_config = mkpathdup("%s/config", opts->git_dir);
> -	else if (have_git_dir())
> -		repo_config = git_pathdup("config");
>  	else
>  		repo_config = NULL;

Likewise: either this should get a sanity check

	else if (have_git_dir())
		BUG("caller forgot to set opts->git_dir");

or the public interface git_config_with_options should be renamed.

> @@ -1613,6 +1609,8 @@ static void git_config_raw(config_fn_t fn, void *data)
>  	struct config_options opts = {0};
>  
>  	opts.respect_includes = 1;
> +	if (have_git_dir())
> +		opts.git_dir = get_git_common_dir();

curious: Why get_git_common_dir() instead of get_git_dir()?

Thanks,
Jonathan
