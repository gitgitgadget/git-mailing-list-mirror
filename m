Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8FD20248
	for <e@80x24.org>; Fri,  8 Mar 2019 03:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCHDS5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 22:18:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40012 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCHDS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 22:18:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so569956wrw.7
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 19:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kprfdM9tWpDnKzpTEKg6z9tt0gzjjqEWTI885ii6s48=;
        b=TawaNxOev2MGK8bns5j5Zw3FWkF34L7imPzCFwr6GgSo3ryKVvL8Jcw6qY0SnCMrF2
         mMGD+7A7XtKb1oIAnQ1nJbmcafN2c8yw3DmFBrpun0wiOY0IobcT04V2f95rR0GKbrS8
         NLNSAwXrihdKbwaGJQoJBAou9DszeoTwmO+irFSIV3sWOmasHkEBxf2mnLFGgnOWtaRv
         kCclk8jEupuColJdbWCKrheVQnBXZhc8lzgy4JJ4r+mwWTVmqPnFfzTexaI0h+sh4pxb
         qGDQgTzIEdskD5KDNODhbdhSe9Rmsc/R7Q9pBLRZ7EOOswcT91LqRi69FxqRJrIP/B9E
         ZX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kprfdM9tWpDnKzpTEKg6z9tt0gzjjqEWTI885ii6s48=;
        b=NmyxYyFwGWNDGmgpZPupFLXmpip/RXU5NhqEcDg6R3xN7Vv84SCVb8Y8wnvyUwPC1g
         /vuPAGltXx4vUF9389zSaMU2ul2dCIpirHbOoO3+bWwJOBFrEX8XGGHfGyk7TovMxcvL
         OIsLh86n3lOLeZgaV/sKiA261df3zEot3xBpBOIjukcdcN+oOlOSGmZ4wBAvHbFeZ+LI
         gnZ/fR5bxGpBr21aABrksU3waoWHq01lvJ1E3B3ToCvGYyZ5Er6CyGiapL+ad5wp1Swl
         2CZa1WKV9yTiEx7twKIPLGnHx6pr/5Tvoh0Bjdyn8Fo4rynwxY6cpPHyV9yuDqhqQAMM
         CnSA==
X-Gm-Message-State: APjAAAWgC9aJew87Z1dvPAbbiMlZ8ap5ZulW0fZcMtLwqCfAYrL6cGyQ
        QbSj7dvy/IhtXAJPlSnEpdk=
X-Google-Smtp-Source: APXvYqw9SKn+DnPSOe3Hdaok8j2DQjiFeS8xiK0+tsh8w5APjMRbiUVu2X1zXJhswbYPmC/zXuhkVA==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr8886039wrx.281.1552015135182;
        Thu, 07 Mar 2019 19:18:55 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g15sm9439803wmg.16.2019.03.07.19.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 19:18:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: respect core.hidedotfiles = false in git-init again
References: <pull.131.git.gitgitgadget@gmail.com>
        <008e367d26de12debd596e8f16356f70c74d3d7e.1551951339.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Mar 2019 12:18:53 +0900
In-Reply-To: <008e367d26de12debd596e8f16356f70c74d3d7e.1551951339.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 07 Mar 2019
        01:35:40 -0800 (PST)")
Message-ID: <xmqqva0ujboi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 93eff7618c..94df241ad5 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -155,6 +155,9 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
>  	if (!strcmp(k, "init.templatedir"))
>  		return git_config_pathname(&init_db_template_dir, k, v);
>  
> +	if (starts_with(k, "core."))
> +		return platform_core_config(k, v, cb);
> +
>  	return 0;
>  }

OK.  I think this is very much futureproof and a sensible thing to
have a "platform_core_config()" call here.  That way, we do not have
to say the details of what platform specific thing each platform
wants when init_db_config works.

> @@ -361,6 +364,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  	}
>  	startup_info->have_repository = 1;
>  
> +	/* Just look for `init.templatedir` and `core.hidedotfiles` */

And from that point of view, replacing `core.hidedotfiles` with
something like "platform specific core config" would be more
appropriate.

> +	git_config(git_init_db_config, NULL);
> +

We use git_init_db_config from create_default_files(), which is a
function called several lines after this point; shouldn't that now
be removed from create_default_files()?

>  	safe_create_dir(git_dir, 0);
>  
>  	init_is_bare_repository = is_bare_repository();
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 42a263cada..35ede1b0b0 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -453,6 +453,18 @@ test_expect_success 're-init from a linked worktree' '
>  	)
>  '
>  
> +test_expect_success MINGW 'core.hidedotfiles = false' '
> +	git config --global core.hidedotfiles false &&
> +	rm -rf newdir &&
> +	(
> +		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
> +		mkdir newdir &&
> +		cd newdir &&
> +		git init
> +	) &&

This is not incorrect per-se, but I think most tests do the mkdir
outside subshell, i.e.

	rm -rf newdir &&
	mkdir newdir &&
	(
		cd newdir &&
		sane_unset ... &&
		...
	) &&

Other than these, I find nothing questionable in the patch.  Nicely
done.


