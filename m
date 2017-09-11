Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89D8E1FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 14:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdIKOxx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 10:53:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38305 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdIKOxw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 10:53:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id p37so4533879wrb.5
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=svUoqG7IyuQWV8GepRH1pT9Ihyuv1fwdqANwirAHQ9Q=;
        b=uwSjm2gdBr7jtfk/9MERljTKs5N3c9Gc9+R5HEEuYxItTZAGkbYjTAdu+rgArVrJPA
         a38oqI8mYAbEBOsA82tU3oFUQCNqsOZVaCUJfAZ/AFXhaKcDSkhP93HAUJ0nkKzWyXV5
         l0OzQUjrwPaey/Y+qdZOR9ITbzvujFWBLk5vxRlJnrpo7Mrb/mty7QNo8dOW2OUkpFBO
         5B9FY0f7FFz18JhlFO8TmSWh9rxDCD3vUP7hFs1+Avz2LgV6lSLxJjVVGF8Ph7hgRK9/
         SJd9QKkpH8Rhqs7xfjwHbk+h7RdzadLzzZvMBrPN31xrCzImb0vMAU6QWbub/YzC/0Do
         m1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=svUoqG7IyuQWV8GepRH1pT9Ihyuv1fwdqANwirAHQ9Q=;
        b=fDoZsGwC+4vMVISiH5kjPv06gHAP9xM2eY4hDpgHtX1XQrE60KPxA+21h6macTI3AB
         LDjiidivSybV59Cm/ow2k0mQd9AS+YQQldG8aTEmMyUV0RwHSKo2TKnSbS0JFjbZqUea
         H3DcFX+U5Kbb8UH1CMJN6EYG60t9b4KrIFfWZqJArzQ8cts8pCh4WKHEoUXynuvV44BO
         TXItgNZLCj3Bb/hRO3u764b6ArmAgJMXrJw5C/uYXadqiFEigCfv6RWXHEb2AjRX+uJr
         E9SeYV2mgTw7oNPJTyJ7RZlYESmbj5MWA7EfzWPtLuvCqRZwNMUyM3TbTy2JIcOIgnNs
         D+LQ==
X-Gm-Message-State: AHPjjUinJrV9kaj4qgETwEPJKCwl7AIFdNh+pMs/EA2REkgaI2t8IFAo
        qwzw8hr3yAmHuA==
X-Google-Smtp-Source: ADKCNb6NvGnOVF5NkzeXDNgAOKjDBv+2uHRHOrjbekjprHfXUdLw3Hi1LEn+nD1oYkyXllHKznKigg==
X-Received: by 10.223.135.97 with SMTP id 30mr8122562wrz.245.1505141631157;
        Mon, 11 Sep 2017 07:53:51 -0700 (PDT)
Received: from localhost.localdomain (x590e3ec7.dyn.telefonica.de. [89.14.62.199])
        by smtp.gmail.com with ESMTPSA id n29sm6470046wmi.46.2017.09.11.07.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Sep 2017 07:53:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] travis-ci: skip a branch build if equal tag is present
Date:   Mon, 11 Sep 2017 16:52:41 +0200
Message-Id: <20170911145241.18571-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.1.527.g3f6d5ed64
In-Reply-To: <20170910144429.47346-3-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If we push a branch and a tag pointing to the HEAD of this branch,

s/the HEAD of//, perhaps?
There is no such thing as "HEAD" (all capital!) of a branch, is it?

> then Travis CI would run the build twice. This wastes resources and

Nit: s/run the build/build and test the same tree/, to further stress
that the two builds are redundant.

> slows the testing.
> 
> Add a function to detect this situation and skip the build the branch

s/skip the build/skip building/ ?

> if appropriate. Invoke this function on every build.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  ci/lib-travisci.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 44d6ba2dd2..9c4ae9bdd0 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -1,5 +1,28 @@
>  # Library of functions shared by all CI scripts
>  
> +skip_branch_tip_with_tag () {
> +	# Sometimes, a branch is pushed at the same time the tag that points
> +	# at the same commit as the tip of the branch is pushed, and building
> +	# both at the same time is a waste.
> +	#
> +	# Travis gives a tagname e.g. v2.14.0 in $TRAVIS_BRANCH when
> +	# the build is triggered by a push to a tag.  Let's see if
> +	# $TRAVIS_BRANCH is exactly at a tag, and if so, if it is
> +	# different from $TRAVIS_BRANCH.  That way, we can tell if
> +	# we are building the tip of a branch that is tagged and
> +	# we can skip the build because we won't be skipping a build
> +	# of a tag.
> +
> +	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
> +		$TAG != $TRAVIS_BRANCH

This must be

    [ $TAG != $TRAVIS_BRANCH ]

otherwise the shell will rightfully complain:

  $ TRAVIS_BRANCH=v2.14.0 ./ci/lib-travisci.sh 
  ./ci/lib-travisci.sh: line 17: v2.14.0: command not found

Furthermore, I would prefer quotes around $TAG and $TRAVIS_BRANCH.  If
either one of those two variables were empty (or contain multiple
words) at that point, the shell would complain.  Now, I don't think
that either can end up being empty, so quotes are not necessary, but
having quotes around them would save future readers from spending
brain cycles on this unnecessarily.

> +	then
> +		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
> +		exit 0
> +	fi
> +}
> +
>  # Set 'exit on error' for all CI scripts to let the caller know that
>  # something went wrong
>  set -e
> +
> +skip_branch_tip_with_tag
> -- 
> 2.14.1
> 
> 
