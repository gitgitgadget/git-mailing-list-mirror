Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7278C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiFBM5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFBM5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:57:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D665123D5CA
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:56:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b4so4670984iog.11
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QbrDhwgkqN0z5UaBay75bi4GSX9h3wwjPbt/JrpOIvk=;
        b=XyT080CvEqEM6yE429iynz5iEUfPWnm2GoEf6rwdVT2eWt4c9mczH5LSL/iSEyxTd1
         pBQgl6vCyM5x3nTZd8sI3taHKtLtNwAOxwpBNv3n/cT/ESr+OHZngl1fpxl2mtOoH1iF
         Ez30iIyPfd4KtCNMD8ds2ZViYAanlNNdQEivgMtNZMUuOBDGWh07hQyMWbqO4XlIwpd4
         wkQnl9uDznO1HkFCHMiac6+Cy1pTfpXyUc33VDBG6rNNXNAjV0UvC/H4V9OFumv9qi/s
         pl2VQlqcmAUdzApLpX1R6X8KF3DuXSQk010HnOgczNE4yWvS97M+C3tg3IBSGoYL1TOh
         9oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QbrDhwgkqN0z5UaBay75bi4GSX9h3wwjPbt/JrpOIvk=;
        b=gILNqAy0sr00X1O47MMA2xnjAXb3rcahzGhcdnJ5uWO/0wZXHpxbFGYQZg8LV7txJs
         2TbFKRXNN8TKG4WZ6hfoGDWYUUY1AbAsZySalwemWAB18pncw8P6N/pEY46n7s980Llm
         BkCmUiww+kpG+2enif34lIsYao2vTghDwTepnb73yY18iw8vhI44wCL498VNndPbqVvw
         L6YDkAm3L8n0R9dhkb/qXi3zW4FaEiHecgpk6s6P2RoBtr/cqfq1TU0gsKbl/+P1q0TR
         v8s1PAjqHsV7zDJyBgoZNBL5/8qx90C/RNpNAF98flsK+juC8QOmg5qb9qu9nox4um6c
         fNzA==
X-Gm-Message-State: AOAM533bPof2qQAFcTEs30QpFzngTY9eX/ordIk4AC01juBDRLY7MJLN
        7BjmfjFBjiLD7CJ8vFILt+HRxVq37zs8
X-Google-Smtp-Source: ABdhPJxRxMZthI1UrNYPoIdWWOmxIx31yqQbZ5tKQyQ7pWd7iyYT+qcqs6rETwDmrTy1JxR4eHI+cw==
X-Received: by 2002:a5e:8419:0:b0:65e:4ea1:243d with SMTP id h25-20020a5e8419000000b0065e4ea1243dmr2340587ioj.70.1654174618341;
        Thu, 02 Jun 2022 05:56:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id q3-20020a022443000000b0032e798bc927sm1162878jae.133.2022.06.02.05.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:56:57 -0700 (PDT)
Message-ID: <802c3541-3301-43fc-c39e-edd44e61a4eb@github.com>
Date:   Thu, 2 Jun 2022 08:56:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] config: read protected config with
 `git_protected_config()`
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 5:09 PM, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
> 
> Protected config is read using `read_very_early_config()`, which has
> several downsides:
> 
> - Every call to `read_very_early_config()` parses global and
>   system-level config files anew, but this can be optimized by just
>   parsing them once [1].
> - Protected variables should respect "-c" because we can reasonably
>   assume that it comes from the user. But, `read_very_early_config()`
>   can't use "-c" because it is called so early that it does not have
>   access to command line arguments.
> 
> Introduce `git_protected_config()`, which reads protected config and
> caches the values in `the_repository.protected_config`. Then, refactor
> `safe.directory` to use `git_protected_config()`.
> 
> This implementation can still be improved, however:
> 
> - `git_protected_config()` iterates through every variable in
>   `the_repository.protected_config`, which may still be too expensive to
>   be called in every "git" invocation. There exist constant time lookup
>   functions for non-protected config (repo_config_get_*()), but for
>   simplicity, this commit does not implement similar functions for
>   protected config.

I originally thought that we should jump to that "right" solution, but
the existing logic in ensure_valid_ownership() uses the iterator method,
mostly because it uses a multi-valued string. There are helpers that
allow iterating over a specific multi-valued key, but there is no reason
to complicate the current patch with that amount of refactoring. That
can be handled as a completely separate topic.
 
> - Protected config is stored in `the_repository` so that we don't need
>   to statically allocate it. But this might be confusing since protected
>   config ignores repository config by definition.

I agree with Junio's suggestion of keeping this as a static global in
config.c, accessible only by the public methods from config.h. A future
where we have "the_world" might be nice for inventory on all these
globals. Definitely not something to hold up this series.

> +/* Read protected config into the_repository->protected_config. */
> +static void read_protected_config(void)
> +{
> +	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
> +
> +	CALLOC_ARRAY(the_repository->protected_config, 1);
> +	git_configset_init(the_repository->protected_config);
> +
> +	system_config = git_system_config();
> +	git_global_config(&user_config, &xdg_config);
> +
> +	git_configset_add_file(the_repository->protected_config, system_config);
> +	git_configset_add_file(the_repository->protected_config, xdg_config);
> +	git_configset_add_file(the_repository->protected_config, user_config);
> +
> +	free(system_config);
> +	free(xdg_config);
> +	free(user_config);
> +}

This loads the config from three files, including the xdg_config, which
I wasn't thinking about before.

This implementation does not use the -c config yet, which you listed as
a downside of read_very_early_config(). I see that you include that in
your patch 4, but the commit message for this patch could list that as a
step that will be handled by a later change.

(You could also do that as patch 3 and add a test near the existing
safe.directory tests instead of waiting for discovery.bare.)

> +
> +/* Ensure that the_repository->protected_config has been initialized. */
> +static void git_protected_config_check_init(void)
> +{
> +	if (the_repository->protected_config &&
> +	    the_repository->protected_config->hash_initialized)
> +		return;
> +	read_protected_config();
> +}
> +
> +void git_protected_config(config_fn_t fn, void *data)
> +{
> +	git_protected_config_check_init();
> +	configset_iter(the_repository->protected_config, fn, data);
> +}

These two methods are clearly correct.

..._check_init() is an OK name. I've seen us use "prepare_...()" in
other areas as a way of making sure that we have the proper state
(see prepare_packed_git() and the like), so maybe a rename here to
match would be worthwhile. Feel free to ignore.

> +	if (repo->protected_config) {
> +		git_configset_clear(repo->protected_config);
> +		FREE_AND_NULL(repo->protected_config);
> +	}

This will have no equivalent when protected_config is left as a
static global, but that is fine. It only goes out of scope with
the end of the process, anyway.

> @@ -1128,7 +1128,7 @@ static int ensure_valid_ownership(const char *path)
>  	    is_path_owned_by_current_user(path))
>  		return 1;
>  
> -	read_very_early_config(safe_directory_cb, &data);
> +	git_protected_config(safe_directory_cb, &data);

Nice to have a very simple conversion here.

Thanks,
-Stolee
