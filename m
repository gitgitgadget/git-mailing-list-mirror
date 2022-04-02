Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B3C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 01:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiDBBZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 21:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDBBZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 21:25:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D912927B
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 18:24:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z92so4861587ede.13
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 18:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hVVL/su3ImvqUS9egE1dgJz/2xxgo2SzSErmMzAetjc=;
        b=EwymB0C2BJPVAJMszbNr3MaXkMZi/TSWvpg780V7ZeP6rUdz7LcFQgfCkdeY5kuVEI
         P0lcdSDm5VdJHAn8HMy8MVPAuYMYtWImcvLtrjaocy4OQl/CWZJy5rvm1YZLwUaHBA+6
         ZW3XS413KNd0U+El7XD/JXYHYmgv+1TWbYR54upoXWjQqn0jFZbdLE8JjeW+ZUvf947K
         lVka9WWVV5PnShO7+S/GYq7mItz8Gvm+AHdab9XlC7/e2kAS9qJOTFEiBd8Aoub0vo+e
         ZtSgpDjE8wSZDhCA+nffreq3aMaymPln9ZLb9bIyk1c1A/lPPN2LE9pblBriK6+0r0Px
         Ykeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hVVL/su3ImvqUS9egE1dgJz/2xxgo2SzSErmMzAetjc=;
        b=5LtqmxM+fcwgGaMTwHFhKKs/6RkOxIcKDJnshSDjYIu58SzV00ExoU5mipH8oPEilt
         su5syeFueCHdfEtDnyXj7Q6mGu26zgLOiCpBUPRreOd7rXqN43Ls0ZCJ3K0dcRUtBs5+
         +pD9+IIrGborrcE0GqJJN3n5JiWDYD92cuC3ZdHlOVkCwdJ2yysgfVhjJYRtg/okFfui
         Gclmi4jKD62zkxlwxdj5HC5IXO7+DaT9IDg3SLTnOWHr53puXE1ebbYaOp6PEqRpj9Za
         7AVwGggqbuVQzCqO7iS9BeMtvV6R5AJ4IHsZ6Gx5znIhwN4j8DeORequH1jzbCAQIsMU
         R7vA==
X-Gm-Message-State: AOAM533rDpCb7fm3Qb6ESBgCAjUyvUxln+K9GfEdnZz5AjhP0TIiT+Zr
        KJmFCwtsTBSM7DoCJ169lbbmS7PSZEM=
X-Google-Smtp-Source: ABdhPJzjhJEp/nR4RBmVDJg+af/EV/wTK2ABXvmegX7bSMNVu7wMkCEKhtjm/dBcqcfj6N+dp238/g==
X-Received: by 2002:a05:6402:60e:b0:419:d2e:bcea with SMTP id n14-20020a056402060e00b004190d2ebceamr23917446edv.326.1648862641202;
        Fri, 01 Apr 2022 18:24:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b006e091a0cf8bsm1564248ejb.16.2022.04.01.18.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 18:24:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naSUi-001YjN-4e;
        Sat, 02 Apr 2022 03:24:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5510-fetch: upgrade to a more modern style
Date:   Sat, 02 Apr 2022 03:14:37 +0200
References: <20220331175412.305968-1-gitter.spiros@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220331175412.305968-1-gitter.spiros@gmail.com>
Message-ID: <220402.86v8vsmg5r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Elia Pinto wrote:

> Clean up the code style so all the tests, and not just a few,
> that chdir around isolate themselves in a subshell.

Sounds sensible.

>  test_expect_success "fetch test" '
> -	cd "$D" &&
> -	echo >file updated by origin &&
> -	git commit -a -m "updated by origin" &&
> -	cd two &&
> -	git fetch &&
> -	git rev-parse --verify refs/heads/one &&
> -	mine=$(git rev-parse refs/heads/one) &&
> -	his=$(cd ../one && git rev-parse refs/heads/main) &&
> -	test "z$mine" = "z$his"
> +	(
> +		cd "$D" &&
> +		echo >file updated by origin &&
> +		git commit -a -m "updated by origin" &&
> +		(
> +			cd two &&

Why the two levels of subshelling though? We don't need a new one every
time we change directories, or do we?

The point is usually to avoid cd-ing in our main shell, not that each
level needs a new shell & indentation...

> -	test_cmp expected actual'
> +	(
> +		cd "$D" &&
> +		(
> +			cd three &&

ditto..

> +			git fetch &&
> +			git rev-parse --verify refs/heads/two &&
> +			git rev-parse --verify refs/heads/one &&

FWIW an alternative here is to use git -C "$D/three", but that may end
up being too verbose..

>  test_expect_success 'fetch --prune handles overlapping refspecs' '
> -	cd "$D" &&
> -	git update-ref refs/pull/42/head main &&
> -	git clone . prune-overlapping &&
> -	cd prune-overlapping &&
> -	git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
> -
> -	git fetch --prune origin &&
> -	git rev-parse origin/main &&
> -	git rev-parse origin/pr/42 &&
> -
> -	git config --unset-all remote.origin.fetch &&
> -	git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
> -	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
> -
> -	git fetch --prune origin &&
> -	git rev-parse origin/main &&
> -	git rev-parse origin/pr/42
> +	(
> +		cd "$D" &&
> +		git update-ref refs/pull/42/head main &&
> +		git clone . prune-overlapping &&
> +		cd prune-overlapping &&
> +		git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
> +		git fetch --prune origin &&
> +		git rev-parse origin/main &&
> +		git rev-parse origin/pr/42 &&
> +		git config --unset-all remote.origin.fetch &&
> +		git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
> +		git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
> +		git fetch --prune origin &&
> +		git rev-parse origin/main &&
> +		git rev-parse origin/pr/42
> +	)
>  '

Please don't lose grouping whitespace while at it.  I.e. the pre-image
intentionally splits "steps" by \n\n.

>  
>  test_expect_success 'fetch --prune --tags prunes branches but not tags' '
> -	cd "$D" &&
> -	git clone . prune-tags &&
> -	cd prune-tags &&
> -	git tag sometag main &&
> -	# Create what looks like a remote-tracking branch from an earlier
> -	# fetch that has since been deleted from the remote:
> -	git update-ref refs/remotes/origin/fake-remote main &&
> -
> -	git fetch --prune --tags origin &&
> -	git rev-parse origin/main &&
> -	test_must_fail git rev-parse origin/fake-remote &&
> -	git rev-parse sometag
> +	(
> +		cd "$D" &&
> +		git clone . prune-tags &&
> +		cd prune-tags &&
> +		git tag sometag main &&
> +		# Create what looks like a remote-tracking branch from an earlier
> +		# fetch that has since been deleted from the remote:
> +		git update-ref refs/remotes/origin/fake-remote main &&
> +		git fetch --prune --tags origin &&
> +		git rev-parse origin/main &&
> +		test_must_fail git rev-parse origin/fake-remote &&
> +		git rev-parse sometag
> +	)
>  '
>  
>  test_expect_success 'fetch --prune --tags with branch does not prune other things' '
> -	cd "$D" &&
> -	git clone . prune-tags-branch &&
> -	cd prune-tags-branch &&
> -	git tag sometag main &&
> -	git update-ref refs/remotes/origin/extrabranch main &&
> -
> -	git fetch --prune --tags origin main &&
> -	git rev-parse origin/extrabranch &&
> -	git rev-parse sometag
> +	(
> +		cd "$D" &&
> +		git clone . prune-tags-branch &&
> +		cd prune-tags-branch &&
> +		git tag sometag main &&
> +		git update-ref refs/remotes/origin/extrabranch main &&
> +		git fetch --prune --tags origin main &&
> +		git rev-parse origin/extrabranch &&
> +		git rev-parse sometag
> +	)
>  '

Skimming these these seem like much of the same code over & over again
with tiny variations. Perhaps even better would be splitting much of
this into a helper function(s)?

> -	git -C atomic fetch --atomic origin &&
> -	git -C atomic rev-parse origin/atomic-branch >actual &&
> -	test_cmp expected actual &&
> -	test $oid = "$(git -C atomic rev-parse --verify FETCH_HEAD)"
> +	(
> +		cd "$D" &&
> +		git clone . atomic &&
> +		git branch atomic-branch &&
> +		oid=$(git rev-parse atomic-branch) &&
> +		echo "$oid" >expected &&
> +		git -C atomic fetch --atomic origin &&
> +		git -C atomic rev-parse origin/atomic-branch >actual &&
> +		test_cmp expected actual &&
> +		test $oid = "$(git -C atomic rev-parse --verify FETCH_HEAD)"

speaking of modern style, perhaps it's worth it to fix these exit code
hiding issues? I.e. use test_cmp, test_cmp_rev etc.

> +		head_oid=$(git rev-parse HEAD) &&
> +		cat >expected <<-EOF &&
> +			prepared
> +			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
> +			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
> +			committed
> +			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
> +			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
> +		EOF

There was a discussion on-list the other day about how this particular
here-doc style is the odd one out, and we'd prefer the content aligned
with the "cat".

So if we're re-indenting all of these that would be a nice change while
we're at it, particularly as it would make the diff smaller, they'd
already be at the "right" indent level.
