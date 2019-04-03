Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B3E20248
	for <e@80x24.org>; Wed,  3 Apr 2019 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDCAAh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 20:00:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35245 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDCAAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 20:00:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so7348074pgf.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQQ350/SiswazYfNE0dPQ8/Cwv1UivcD8IqXiWkK+/Y=;
        b=cvKCGUJaUN44hvn3KdEwEYh9Tmq7+b95FVxzg6giuW8IDVv9v4bgdJaER6aH7BNodr
         Ebkt7ZPzGruyx+D3p9ZT1/fxlJ9JsaBF6EhcUrcBn2qHm/HmPOMkWa1mdU5CMWYZ7gx/
         FFJ3l3KIt1No7CpdRvtPKzDQDhdgdLpSdBFwkzBepxv4OLHcM9NcvTu7JpIZLh+M9i3i
         vb5cn9TrzE1y1VPv8oVQXuAEVmSVoZ34W5P2t4aiEzOI57G0Mdtc4zqYsyDeOqkI8vEq
         sP0qQUJyrw3jfdhsH+At4e98OOX7oHH+MKZmR6MAgymRCQ9CTiAbrBUitR5sx5n5ZLGu
         7SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQQ350/SiswazYfNE0dPQ8/Cwv1UivcD8IqXiWkK+/Y=;
        b=mjJ4LrepESJk45ciuDW32Sk8PVZVNXBAQ0iyz18OeO8Z5KzabM+PfWLao4ybGlAtjy
         +BSfQGdaniE2/wt9Nau7nQ7WxPm4DrPYznpVIcWCgIaW0AqjQtlkyCYVqsxemZZKjmvM
         AfhSbW0W9LZvhVFGa9q7ozCPdNyhh+jWkpjiCNbW/vDOFKr148ihBa6mjaJq9HoiP5nr
         QH5Dib0jx3RfxMfrLYTdfdnUryqy27K1uZi4GkDzzLBNBvk+EvA8nKE4c4GH3DKVoB19
         88Wj6rJn78TmWrsTyhmjxGZR/qJdnGJ6og84k0qIuVh0aXVCWvOBd7eUJiSaN2odNJnb
         qwtg==
X-Gm-Message-State: APjAAAWPL7BHmUs1bJ4DOTKEzglsp3sjDnKipjW7OH0TzUc7i14bOtJr
        KHbtw8CeQVQGautrKpHkxCA=
X-Google-Smtp-Source: APXvYqwKrOO0Er0mWWeOG5CiNA/eoHUvqSGRCNCVp/uj5GF8ekdNbViyZs5Kb3ceeWDw0HhMBfcf7g==
X-Received: by 2002:a65:51c3:: with SMTP id i3mr68569711pgq.45.1554249635577;
        Tue, 02 Apr 2019 17:00:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id q10sm15749724pgh.93.2019.04.02.17.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 17:00:34 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:00:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        steadmon@google.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/7] trace2: use system config for default trace2
 settings
Message-ID: <20190403000032.GA190454@google.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler via GitGitGadget wrote:

> Teach git to read the system config (usually "/etc/gitconfig") for
> default Trace2 settings.  This allows system-wide Trace2 settings to
> be installed and inherited to make it easier to manage a collection of
> systems.

Yay!  Thanks for writing this, and sorry for the slow review.

[...]
> Only the system config file is used.  Trace2 config values are ignored
> in local, global, and other config files.  Likewise, the "-c" command
> line arguments are ignored for Trace2 values.  These limits are for
> performance reasons.

Can you say a bit more about this?  If I'm willing to pay the
performance cost, is there a way for me to turn on respecting other
config files?  What is that performance cost?

[...]
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -117,6 +117,37 @@ values are recognized.
>  Socket type can be either `stream` or `dgram`.  If the socket type is
>  omitted, Git will try both.
>  
> +== Trace2 Settings in System Config
> +
> +Trace2 also reads configuration information from the system config.
> +This is intended to help adminstrators to gather system-wide Git
> +performance data.
> +
> +Trace2 only reads the system configuration, it does not read global,
> +local, worktree, or `-c` config settings.

An additional limitation is that this doesn't appear to support
include.* directives.  Intended?

[...]
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
[...]
> +MOCK=./mock_system_config
> +
> +test_expect_success 'setup mocked /etc/gitconfig' '
> +	git config --file $MOCK trace2.normalTarget "$(pwd)/trace.normal" &&
> +	git config --file $MOCK trace2.normalBrief 1
> +'
> +
> +test_expect_success 'using mock, normal stream, return code 0' '
> +	test_when_finished "rm trace.normal actual expect" &&
> +	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 001return 0 &&

Tests run with GIT_CONFIG_NOSYSTEM=1 to protect themselves from any
system config the user has.

So this would be easier to test if we can use user-level config for
it.

[...]
> --- /dev/null
> +++ b/trace2/tr2_sysenv.c
> @@ -0,0 +1,128 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "dir.h"
> +#include "tr2_sysenv.h"
> +
> +/*
> + * Each entry represents a trace2 setting.
> + * See Documentation/technical/api-trace2.txt
> + */
> +struct tr2_sysenv_entry {
> +	const char *env_var_name;
> +	const char *git_config_name;
> +
> +	char *value;
> +	unsigned int getenv_called : 1;
> +};
> +
> +/*
> + * This table must match "enum tr2_sysenv_variable" in tr2_sysenv.h.

Can we deduplicate to avoid the need to match?

Perhaps using C99 array initializers would help:

	[TR2_SYSENV_CFG_PARAM] = { ... },

[...]
> +/*
> + * Load Trace2 settings from the system config (usually "/etc/gitconfig"
> + * unless we were built with a runtime-prefix).  These are intended to
> + * define the default values for Trace2 as requested by the administrator.
> + */
> +void tr2_sysenv_load(void)
> +{
> +	const char *system_config_pathname;
> +	const char *test_pathname;
> +
> +	system_config_pathname = git_etc_gitconfig();
> +
> +	test_pathname = getenv("GIT_TEST_TR2_SYSTEM_CONFIG");
> +	if (test_pathname) {
> +		if (!*test_pathname || !strcmp(test_pathname, "0"))
> +			return; /* disable use of system config */
> +
> +		/* mock it with given test file */
> +		system_config_pathname = test_pathname;
> +	}
> +
> +	if (file_exists(system_config_pathname))
> +		git_config_from_file(tr2_sysenv_cb, system_config_pathname,
> +				     NULL);

This duplicates functionality from config.c and misses some features
along the way (e.g. support for include.*).

Would read_early_config work?  If we want a variant that doesn't
discover_git_directory, we can change that function to handle it.

For our needs at Google, it would be very helpful to have support for
include.* and reading settings from at least $HOME/.gitconfig in
addition to /etc/gitconfig (even better if it supports per-repo config
as well).  I believe it would simplify the code and tests, too.  If
there's anything I can to help, please don't hesitate to ask.

Thanks,
Jonathan
