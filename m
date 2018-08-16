Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E08D1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeHPUFs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:05:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52353 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeHPUFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:05:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so5092337wmh.2
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G5riX0dUrJ7OwXtPEib/dn+M7iiT6wHcCPHGizvlulQ=;
        b=EjNGYof9zgP3YkKtHRu0jzfSnGFpiBPXadnrX/aqeO7zy9kt/nI5jxX9atnkjWTjsw
         uV/4s730eJeFBDeKZF1InNDUJr+IPBr+QoRm0Or+wEvK/TNvWH1hEgEOEWg8L0yDJvlp
         JZkfUGfIEW8+d3SVUbCBdt2kKX3dMQ85TUoFjUWyYfXyTlrOa1knHWMu2Kmt/FXbXxeh
         /bvbNWIpkLVyky28YjJ4+nnlHB0rGZDpb8L8e6jFN8ThLZ00qTBaJHzfI1YmAJsK4IvO
         ahrt4MWiMx71dlEawILqqiCYjSOloTXVaGE4yfJ84OQ9uW1v/JefF/t8NQARHl6wWcDA
         AvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G5riX0dUrJ7OwXtPEib/dn+M7iiT6wHcCPHGizvlulQ=;
        b=j9/O0DvKYC8A84AhGMwjo3TNIHImD1RpuGLjkGZPiDpTW3nUIYDXsytv+ptV3gvwNu
         spgR3hCYSd/jsdUeJzSmNYArzcS/V5lAvyibB0qMmAjKiYr9vXSmrAUxUsJAbbkiijyG
         3FHf16THwFCHrimhrNVWYGMYA9lKkm2wdVhIjDI5gDwwpoF8T8KZj6j/99dLsjkPmcfi
         m++r2xZYKEQdVZDkGdYCV/qMv6M55ljkAfGTLlDgTMJio3obPkVjEv9w/81qSQUOAWUY
         ExIEI/Iv6uQpcZjOLpIxKgMl+HU5YH4VepBlIkdA9ABIZOaG1H9RLjuIxd+QMMNcJTzN
         Bszg==
X-Gm-Message-State: AOUpUlGhFpYrIShHmlwpjoxgdAdow4MyLEzT8ify07R6UGaJmOjlbyNG
        yWRw2Y4gVN7X1g0SetKomR4=
X-Google-Smtp-Source: AA+uWPxSIVZ3Wv9GWTHSz41oyBFrB8YMVxs09fpusxNlTqrSS5MLZfWYLX1+x5dALVOLvg+TthVXsQ==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr15652952wmc.30.1534439162274;
        Thu, 16 Aug 2018 10:06:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z101-v6sm1916167wrb.55.2018.08.16.10.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 10:06:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com
Subject: Re: [PATCH 1/7] t7410: update to new style
References: <20180816023100.161626-1-sbeller@google.com>
        <20180816023100.161626-2-sbeller@google.com>
Date:   Thu, 16 Aug 2018 10:06:01 -0700
In-Reply-To: <20180816023100.161626-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Aug 2018 19:30:54 -0700")
Message-ID: <xmqqa7pmfdhi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> While at it fix a typo (s/independed/independent) and
> make sure git is not in a chain of pipes.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7410-submodule-checkout-to.sh | 99 +++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 41 deletions(-)

Makes sense and the result does read easier.

> diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
> index 1acef32647a..f1b492ebc46 100755
> --- a/t/t7410-submodule-checkout-to.sh
> +++ b/t/t7410-submodule-checkout-to.sh
> @@ -6,55 +6,72 @@ test_description='Combination of submodules and multiple workdirs'
>  
>  base_path=$(pwd -P)
>  
> -test_expect_success 'setup: make origin' \
> -    'mkdir -p origin/sub && ( cd origin/sub && git init &&
> -	echo file1 >file1 &&
> -	git add file1 &&
> -	git commit -m file1 ) &&
> -    mkdir -p origin/main && ( cd origin/main && git init &&
> -	git submodule add ../sub &&
> -	git commit -m "add sub" ) &&
> -    ( cd origin/sub &&
> -	echo file1updated >file1 &&
> -	git add file1 &&
> -	git commit -m "file1 updated" ) &&
> -    ( cd origin/main/sub && git pull ) &&
> -    ( cd origin/main &&
> -	git add sub &&
> -	git commit -m "sub updated" )'
> -
> -test_expect_success 'setup: clone' \
> -    'mkdir clone && ( cd clone &&
> -	git clone --recursive "$base_path/origin/main")'
> +test_expect_success 'setup: make origin'  '
> +	mkdir -p origin/sub &&
> +	(
> +		cd origin/sub && git init &&
> +		echo file1 >file1 &&
> +		git add file1 &&
> +		git commit -m file1
> +	) &&
> +	mkdir -p origin/main &&
> +	(
> +		cd origin/main && git init &&
> +		git submodule add ../sub &&
> +		git commit -m "add sub"
> +	) &&
> +	(
> +		cd origin/sub &&
> +		echo file1updated >file1 &&
> +		git add file1 &&
> +		git commit -m "file1 updated"
> +	) &&
> +	git -C origin/main/sub pull &&
> +	(
> +		cd origin/main &&
> +		git add sub &&
> +		git commit -m "sub updated"
> +	)
> +'
> +
> +test_expect_success 'setup: clone' '
> +	mkdir clone &&
> +	git -C clone clone --recursive "$base_path/origin/main"
> +'
>  
>  rev1_hash_main=$(git --git-dir=origin/main/.git show --pretty=format:%h -q "HEAD~1")
>  rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1")
>  
> -test_expect_success 'checkout main' \
> -    'mkdir default_checkout &&
> -    (cd clone/main &&
> -	git worktree add "$base_path/default_checkout/main" "$rev1_hash_main")'
> +test_expect_success 'checkout main' '
> +	mkdir default_checkout &&
> +	git -C clone/main worktree add "$base_path/default_checkout/main" "$rev1_hash_main"
> +'
>  
> -test_expect_failure 'can see submodule diffs just after checkout' \
> -    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
> +test_expect_failure 'can see submodule diffs just after checkout' '
> +	git -C default_checkout/main diff --submodule master"^!" >out &&
> +	grep "file1 updated" out
> +'
>  
> -test_expect_success 'checkout main and initialize independed clones' \
> -    'mkdir fully_cloned_submodule &&
> -    (cd clone/main &&
> -	git worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
> -    (cd fully_cloned_submodule/main && git submodule update)'
> +test_expect_success 'checkout main and initialize independent clones' '
> +	mkdir fully_cloned_submodule &&
> +	git -C clone/main worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main" &&
> +	git -C fully_cloned_submodule/main submodule update
> +'
>  
> -test_expect_success 'can see submodule diffs after independed cloning' \
> -    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
> +test_expect_success 'can see submodule diffs after independent cloning' '
> +	git -C fully_cloned_submodule/main diff --submodule master"^!" >out &&
> +	grep "file1 updated" out
> +'
>  
> -test_expect_success 'checkout sub manually' \
> -    'mkdir linked_submodule &&
> -    (cd clone/main &&
> -	git worktree add "$base_path/linked_submodule/main" "$rev1_hash_main") &&
> -    (cd clone/main/sub &&
> -	git worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub")'
> +test_expect_success 'checkout sub manually' '
> +	mkdir linked_submodule &&
> +	git -C clone/main worktree add "$base_path/linked_submodule/main" "$rev1_hash_main" &&
> +	git -C clone/main/sub worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub"
> +'
>  
> -test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
> -    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
> +test_expect_success 'can see submodule diffs after manual checkout of linked submodule' '
> +	git -C linked_submodule/main diff --submodule master"^!" >out &&
> +	grep "file1 updated" out
> +'
>  
>  test_done
