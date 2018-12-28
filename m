Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1511F804
	for <e@80x24.org>; Fri, 28 Dec 2018 22:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeL1WeT (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 17:34:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeL1WeS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 17:34:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so22050242wrr.12
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p+IYhu+Qk3t4eJw7vXRsFcAhZbJrveAqEPbdxHbUzSQ=;
        b=fGgU0/5quqZZsfi40BCOmDn3pD9ffQoRdcwHhW8zk3VOwsXuWja9BB+qiWwd9AavV6
         74bd6sCRiM+cw/31aDpPUs/PyWQkzCK4R4ZdM979u+ekMtrSgGEYaUjKPeiQYoTprgLH
         rxZwxhhHNDCAhtggXlGciKudxGLdsq4xG8n3mGCsYY+vNl6gRfZs9XyJgizvg9Qf2XvI
         te4xjdxeGagrDhBc5IR5i4dBHLN2kqCwYO6wuBJLwk+4vE/aKJuhBMiQbmcQJjJs0Y1l
         hqjuVnnU6hqHb8XP93PYO5fdm5wI68YYOB+apzou2cwTgDtz9/TrKQ6EWwSjumqq8mpB
         o5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p+IYhu+Qk3t4eJw7vXRsFcAhZbJrveAqEPbdxHbUzSQ=;
        b=KaXbLRUMjiC4TXNCrCpsuW0gvU2ubMb/l/Iuv36sxAU1f5WzvQ+vmnEoJob2ygpAGR
         Sr/HZpcVGvYPxyEQaBPPLWoRwkpGJvtd4m22J/5bnoFiO8WGbt+SCFGnbx882n+oBLQT
         5RtEFMrQq9M/NYllVHBYpwRUHkHD9r/QBMLWj2vRTSeTf+OI4+YfdqeUppZwrsjsccgq
         mkvgBYWFfOMlBMS3nhXW/T4hYxEkSueoxCW2U7jwWfnWt0fdMuyO3z+f1yx3dT3q1tp4
         /61KekbcA/wEyB+jjMZTomfObgtsQLApae+cv+JXblSJjnpmp6mKkN+W/jj4CE4g+Rhj
         O6Tg==
X-Gm-Message-State: AJcUukcbCyxN3T2pTXi8CDpnS9y3D3VLaWXgckRUKm76mkCIJ8Vs04SC
        A9Ip+fDMIhjxt9DtMH6/f4cRqYLM
X-Google-Smtp-Source: ALg8bN5PaFlLtMkntZ2xO6CvMmxBFpBHq6tROhW5xS3qpwFiyLbvfYTsd1x3DJNojDHsIc4L6gMj2w==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr28233729wrt.241.1546036455779;
        Fri, 28 Dec 2018 14:34:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v12sm19922009wmd.27.2018.12.28.14.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:34:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     orgads@gmail.com
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/2] t5403: Refactor
References: <20181224212425.16596-1-orgads@gmail.com>
        <20181224212425.16596-2-orgads@gmail.com>
Date:   Fri, 28 Dec 2018 14:34:12 -0800
In-Reply-To: <20181224212425.16596-2-orgads@gmail.com> (orgads's message of
        "Mon, 24 Dec 2018 23:24:24 +0200")
Message-ID: <xmqqmuopl1qz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

orgads@gmail.com writes:

> Subject: Re: [PATCH 1/2] t5403: Refactor

Hmph.  "Refactor" alone leaves readers wondering "refactor what?",
"refactor for what?" and "refactor how?".  Given that the overfall
goal this change seeks seems to be to simplify it by losing about 20
lines, how about justifying it like so?

	Subject: t5403: simplify by using a single repository

	There is no strong reason to use separate clones to run
	these tests; just use a single test repository prepared
	with more modern test_commit shell helper function.

	While at it, replace three "awk '{print $N}'" on the same
	file with shell built-in "read" into three variables.

> From: Orgad Shaneh <orgads@gmail.com>
>
> * Replace multiple clones and commits by test_commits.
> * Replace 3 invocations of awk by read.
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>  t/t5403-post-checkout-hook.sh | 80 +++++++++++++----------------------
>  1 file changed, 29 insertions(+), 51 deletions(-)
>
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index fc898c9eac..9f9a5163c5 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -7,77 +7,55 @@ test_description='Test the post-checkout hook.'
>  . ./test-lib.sh
>  
>  test_expect_success setup '
> -	echo Data for commit0. >a &&
> -	echo Data for commit0. >b &&
> -	git update-index --add a &&
> -	git update-index --add b &&
> -	tree0=$(git write-tree) &&
> -	commit0=$(echo setup | git commit-tree $tree0) &&
> -	git update-ref refs/heads/master $commit0 &&
> -	git clone ./. clone1 &&
> -	git clone ./. clone2 &&
> -	GIT_DIR=clone2/.git git branch new2 &&
> -	echo Data for commit1. >clone2/b &&
> -	GIT_DIR=clone2/.git git add clone2/b &&
> -	GIT_DIR=clone2/.git git commit -m new2
> -'
> -
> -for clone in 1 2; do
> -    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
> -#!/bin/sh
> -echo $@ > $GIT_DIR/post-checkout.args
> -EOF
> -    chmod u+x clone${clone}/.git/hooks/post-checkout
> -done
> -
> -test_expect_success 'post-checkout runs as expected ' '
> -	GIT_DIR=clone1/.git git checkout master &&
> -	test -e clone1/.git/post-checkout.args
> +	mv .git/hooks-disabled .git/hooks &&

I am not sure why you want to do this---it sends a wrong signal to
readers saying that you want to use whatever hook that are in the
moved-away .git/hooks-disabled/ directory.  I am guessing that the
only reason why you do this is because there must be .git/hooks
directory in order for write_script below to work, so a more
readable approach would be to "mkdir .git/hooks" instead, no?

> +	write_script .git/hooks/post-checkout <<-\EOF &&
> +	echo $@ >.git/post-checkout.args

A dollar-at inside a shell script that is not in a pair of dq always
makes readers wonder if the author forgot dq around it or omitted eq
around it deliberately; avoid it.

In this case, use "$@" (i.e. within dq) would be more friendly to
readers.  The second best is to write it $*, as in this context we
know that $1, $2 and $3 will not contain any $IFS, that echo will
take these three separate arguments and write them on one line
separated by a space in between, which will allow "read A B C" read
them.  Or "$*" to feed such a single line with three arguments
separated by a space in between as a single string to echo for the
same effect.


> +	EOF
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three three

Makes readers wonder why the last one duplicates.  Is this because
you somehow do not want to use three.t as the pathname in a later
test?  "test_commit X" that creates test file X.t is a quite well
established convention (see "git grep '\.t\>' t/"), by the way.


>  '
>  
>  test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
> -	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> -	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
> -	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
> -	test $old = $new && test $flag = 1

> +	git checkout master &&
> +	test -e .git/post-checkout.args &&

Use "test -f", as you do know you'd be creating a file ("-e"
succeeds as long as it _exists_, and does not care if it is a file
or directory or whatever).

> +	read old new flag <.git/post-checkout.args &&

This indeed is much nicer.

> +	test $old = $new && test $flag = 1 &&
> +	rm -f .git/post-checkout.args

The last one is not a test but a clean-up.  If any of the earlier
step failed (e.g. $old and $new were different), the output file
would be left behind, resulting in confusing the next test.

Instead, do it like so:

	test_expect_success 'title of the test' '
        	test_when_finished "rm -f .git/post-checkout.args" &&
		git checkout master &&
		test -f .git/post-checkout.args &&
		read old new flag <.git/post-checkout.args &&
		test $old = $new &&
		test $flag = 1
	'

That is, use test_when_finished() before the step that creates the
file that may be left behind to arrange that it will be cleaned at
the end.

This comment on clean-up applies to _all_ tests in this patch that
has "rm -f .git/post-checkout.args" at the end.

>  '
>  
>  test_expect_success 'post-checkout runs as expected ' '
> -	GIT_DIR=clone1/.git git checkout master &&
> -	test -e clone1/.git/post-checkout.args
> +	git checkout master &&
> +	test -e .git/post-checkout.args &&
> +	rm -f .git/post-checkout.args
>  '

Now that the script got so simplified, this one looks even more
redundant, given that the previous one already checked the same
"checkout 'master' when already at the tip of 'master'" situation.

Do we still need this one, in other words?

>  test_expect_success 'post-checkout args are correct with git checkout -b ' '
> -	GIT_DIR=clone1/.git git checkout -b new1 &&
> -	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> -	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
> -	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
> -	test $old = $new && test $flag = 1
> +	git checkout -b new1 &&
> +	read old new flag <.git/post-checkout.args &&
> +	test $old = $new && test $flag = 1 &&
> +	rm -f .git/post-checkout.args
>  '

This one forgets "did the hook run and create the file" before
"read", unlike the previous tests.  It is not strictly necessary as
"read" will fail if the file is not there, but it'd be better to be
consistent.

>  if test "$(git config --bool core.filemode)" = true; then

This is a tangent but this conditional came from an ancient d42ec126
("disable post-checkout test on Cygwin", 2009-03-17) that says

    disable post-checkout test on Cygwin
    
    It is broken because of the tricks we have to play with
    lstat to get the bearable perfomance out of the call.
    Sadly, it disables access to Cygwin's executable attribute,
    which Windows filesystems do not have at all.

I wonder if this is still relevant these days (Cc'ed Ramsay for
input).  Windows port should be running enabled hooks (and X_OK is
made pretty much no-op in compat/mingw.c IIUC), so the above
conditional is overly broad anyway, even if Cygwin still has issues
with the executable bit.

>  mkdir -p templates/hooks
> -cat >templates/hooks/post-checkout <<'EOF'
> -#!/bin/sh
> -echo $@ > $GIT_DIR/post-checkout.args
> +write_script templates/hooks/post-checkout <<-\EOF
> +echo $@ >$GIT_DIR/post-checkout.args
>  EOF
> -chmod +x templates/hooks/post-checkout
>  
>  test_expect_success 'post-checkout hook is triggered by clone' '
>  	git clone --template=templates . clone3 &&
