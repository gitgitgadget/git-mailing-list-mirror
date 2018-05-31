Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541F41F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeEaHp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:45:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36121 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaHp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:45:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so32948893wma.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B08nti+yA/YyJ34JQXtgQRRfVo1upie31OlWkiQr7T4=;
        b=b54clX0AI5up/eY7gjfXwJYpnKx7Y6gZy6a3qWnFc8h/DstO8sNq8TVyNsOKHsP3IG
         cPOLgKPuyFczaGEtXVTghaghPDhUiSFeDpl0sFMZEWZvGp4jcyAPQIm0+0vP2y0/lzQq
         lBV3XgY1XuP1EI2QT8v9P+KAbPOMxzu+E6D52GUGTsTM/JRYWCq9dlKhCBcAMbjYEDhF
         OBbNrEA9uc6va+3RtGzSQ2amWdIXb3oju75PoefNkhp2k5cui13KbdfOI+1Z6dKi0JhG
         jr8fcZv39oluykTvHpUzDxyoxOKHIlDFSkljfhmh0mb/FX89g9xMNwG7taWIWTCEq7BH
         uZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=B08nti+yA/YyJ34JQXtgQRRfVo1upie31OlWkiQr7T4=;
        b=anUBhaUR7IFOaoRmkU4JYCqViPdoUnZKnFuMISIdfXShrn5/i54RYY8B1bBbkSMAX9
         T+I+LuoZ3VppZ08MhiKb8qxr7zTS0SLHP1SlL15HPRpfkg9Uk4ZEQwkRaBKxGnpCAVgU
         gAg6uwCrOJj2KwrGi2BHP81tvFoPJekLfPP1yLMMv9W/ODxGhByzXDU4tmNiUwbgmgtJ
         Og+eJkiNomkMQ3Azlacp4CDHPJ8fpJ48TgDW5GeADooR/9K4FYZnNuShGNa9fcgTqUVK
         0K/chCcy3DKQZY4q1ESiDbQDU8RHDaFIeWf3zOpjg9eICe0HuZZa/3c6MsO1PB0ou0Lr
         +61Q==
X-Gm-Message-State: ALKqPwfJVNmRyvCeuGC0yC+Ac+oxKabV7VDQ09iKuzbn7g5mX14lHTX+
        8pAcFzxfcUNf2X2HnqicHh2bipSw
X-Google-Smtp-Source: ADUXVKJUP52Ys2O9C5akqgDkEWqP0GWpyi4omGuLvDGwz9xh5qkq+30la0hVnzkKkAQDntGCrBthBg==
X-Received: by 2002:a1c:8012:: with SMTP id b18-v6mr3323242wmd.13.1527752756616;
        Thu, 31 May 2018 00:45:56 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o138-v6sm566011wmg.10.2018.05.31.00.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:45:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] checkout & worktree: introduce checkout.implicitRemote
References: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com> <20180524194704.936-1-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180524194704.936-1-avarab@gmail.com>
Date:   Thu, 31 May 2018 09:45:52 +0200
Message-ID: <87a7sg9sjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 24 2018, Ævar Arnfjörð Bjarmason wrote:

>  struct tracking_name_data {
>  	/* const */ char *src_ref;
>  	char *dst_ref;
>  	struct object_id *dst_oid;
>  	int unique;
> +	const char *implicit_remote;
> +	char *implicit_dst_ref;
>  };

There's a bug here that I'll fix in a v3. We need to have a implicit_*
variant for dst_oid as well. Currently this will be buggy and check out
origin/<branch>, but then check the index out to the tree of whatever
the last <someremote>/<branch> we iterated over was.

Easiy fix and I already have it locally, I just want to improve some of
the testing. I missed it because in my tests I'd just re-add the same
remote again, so the trees were the same.

>  static int check_tracking_name(struct remote *remote, void *cb_data)
> @@ -20,6 +23,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
>  		free(query.dst);
>  		return 0;
>  	}
> +	if (cb->implicit_remote && !strcmp(remote->name, cb->implicit_remote))
> +		cb->implicit_dst_ref = xstrdup(query.dst);
>  	if (cb->dst_ref) {
>  		free(query.dst);
>  		cb->unique = 0;
> @@ -31,13 +36,21 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
>
>  const char *unique_tracking_name(const char *name, struct object_id *oid)
>  {
> -	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
> +	const char *implicit_remote = NULL;
> +	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1, NULL, NULL };
> +	if (!git_config_get_string_const("checkout.implicitremote", &implicit_remote))
> +		cb_data.implicit_remote = implicit_remote;
>  	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
>  	cb_data.dst_oid = oid;
>  	for_each_remote(check_tracking_name, &cb_data);
>  	free(cb_data.src_ref);
> -	if (cb_data.unique)
> +	free((char *)implicit_remote);
> +	if (cb_data.unique) {
> +		free(cb_data.implicit_dst_ref);
>  		return cb_data.dst_ref;
> +	}
>  	free(cb_data.dst_ref);
> +	if (cb_data.implicit_dst_ref)
> +		return cb_data.implicit_dst_ref;
>  	return NULL;
>  }
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index 3e5ac81bd2..da6bd74bbc 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -68,6 +68,16 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
>  	test_branch master
>  '
>
> +test_expect_success 'checkout of branch from multiple remotes succeeds with checkout.implicitRemote #1' '
> +	git checkout -B master &&
> +	test_might_fail git branch -D foo &&
> +
> +	git -c checkout.implicitRemote=repo_a checkout foo &&
> +	test_branch foo &&
> +	test_cmp_rev remotes/repo_a/foo HEAD &&
> +	test_branch_upstream foo repo_a foo
> +'
> +
>  test_expect_success 'checkout of branch from a single remote succeeds #1' '
>  	git checkout -B master &&
>  	test_might_fail git branch -D bar &&
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 2240498924..271a6413f0 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -402,6 +402,24 @@ test_expect_success '"add" <path> <branch> dwims' '
>  	)
>  '
>
> +test_expect_success '"add" <path> <branch> dwims with checkout.implicitRemote' '
> +	test_when_finished rm -rf repo_upstream repo_dwim foo &&
> +	setup_remote_repo repo_upstream repo_dwim &&
> +	git init repo_dwim &&
> +	(
> +		cd repo_dwim &&
> +		git remote add repo_upstream2 ../repo_upstream &&
> +		git fetch repo_upstream2 &&
> +		test_must_fail git worktree add ../foo foo &&
> +		git -c checkout.implicitRemote=repo_upstream worktree add ../foo foo
> +	) &&
> +	(
> +		cd foo &&
> +		test_branch_upstream foo repo_upstream foo &&
> +		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
> +	)
> +'
> +
>  test_expect_success 'git worktree add does not match remote' '
>  	test_when_finished rm -rf repo_a repo_b foo &&
>  	setup_remote_repo repo_a repo_b &&
