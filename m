Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8871F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQRja (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:39:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32954 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeGQRja (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:39:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so13051098wma.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P3nytjo1pl8YB/aOuz9mP73E1NX5bdo5P6zqvsj7BTg=;
        b=leBBSc64RPOXP4mVtNPHfEDBWIiwGFqA3sjRToHEF7wDD8E3oDd2G7/NOjQQn2krlK
         LpnX7SJ8o8bsGXzoMEhZAPkoIJLS/858+41EaU3XzKHXStfDIuyLtDoBmN3K77c+ki6i
         PV98pWUd4YfRgrUH8J9kUY63t3o9HoU9PynToZepO4hPAXQGLliDJAOt0Yg021u4v1q/
         /kEpVLr5jAkLk7avaby6Fvnq8Uf9EcBCztEFkkt7u7qh4/mFgk6m7oN/WfndWjm2Mrs2
         JZO4bCkks8aEwPudl0dRbI8vj7fFakwEoOKa41iPjKunabM/DN/2ZS009CC9dMZuZuE9
         +pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P3nytjo1pl8YB/aOuz9mP73E1NX5bdo5P6zqvsj7BTg=;
        b=OpCC9MvNgp3qgJiKCZhQVz3jg1nheobCj4LAAMMb1CAtsjT7jc+J1lIqPY9xNiNebG
         ZFsOW+O3p8PosCVsJcELFqFC8D2xp4M1z0uFcvjM34lIz3+dpYJFxHihTiLQPyzZThJl
         4hJypuFm94+py2P7W96N6BzbBGPoPHI85NmPg0ueicM+PQNFNvjb14yleyhR500QzG8N
         kPuiO0rbMmRmyKApkIK0nLXSLUWUvylASiKmMpnekebcrJGn9/gdmZxId7uuORDFPzaU
         oADMwJWB9Y13TFnso8X3iHPY1um7N/PKeqdc33xP9DDpsR7kFiQU6/NnMUYVCZJ9vqje
         rtew==
X-Gm-Message-State: AOUpUlG2noUC9oV6AIBeS/djFj9RFAkg/UWnK5t2WocUqqro3lzMqqm9
        Sh1C1lflOaGkkpMHvh9+wOY=
X-Google-Smtp-Source: AAOMgpeSr0Cycw12lmxZQjt9mj7HoU8qcMTsTU4ipRr/JUZaNnudIj4JJsnYvawQq8uhlKFMD33T3Q==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr1868614wmz.23.1531847153258;
        Tue, 17 Jul 2018 10:05:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l16-v6sm31592wme.36.2018.07.17.10.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:05:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] t7501: add merge conflict tests for dry run
References: <20180426092524.25264-1-sxlijin@gmail.com>
        <20180715110807.25544-2-sxlijin@gmail.com>
Date:   Tue, 17 Jul 2018 10:05:52 -0700
In-Reply-To: <20180715110807.25544-2-sxlijin@gmail.com> (Samuel Lijin's
        message of "Sun, 15 Jul 2018 07:08:05 -0400")
Message-ID: <xmqq1sc1rdvz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> The behavior of git commit when doing a dry run changes if there are
> unfixed/fixed merge conflits, but the test suite currently only asserts
> that `git commit --dry-run` succeeds when all merge conflicts are fixed.
>
> Add tests to document the behavior of all flags which imply a dry run
> when (1) there is at least one unfixed merge conflict and (2) when all
> merge conflicts are all fixed.

s/conflits/conflicts/
s/fixed/resolved/g	(both above and in the patch text)
s/unfixed/unresolved/g  (both above and in the patch text)

> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
>  t/t7501-commit.sh | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index fa61b1a4e..be087e73f 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -652,7 +652,8 @@ test_expect_success '--only works on to-be-born branch' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success '--dry-run with conflicts fixed from a merge' '
> +# set up env for tests of --dry-run given fixed/unfixed merge conflicts
> +test_expect_success 'setup env with unfixed merge conflicts' '
>  	# setup two branches with conflicting information
>  	# in the same file, resolve the conflict,
>  	# call commit with --dry-run
> @@ -665,11 +666,45 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
>  	git checkout -b branch-2 HEAD^1 &&
>  	echo "commit-2-state" >test-file &&
>  	git commit -m "commit 2" -i test-file &&
> -	! $(git merge --no-commit commit-1) &&
> -	echo "commit-2-state" >test-file &&
> +	test_expect_code 1 git merge --no-commit commit-1

The original is bad and also embarrassing.  Whatever comes out of
the standard output of "git merge" is $IFS split and executed as a
shell command (which likely results in "no such command" failure)
and it tries to make sure that a failure happens.

The right way to write that line (without your enhancement in this
patch) would have been:

	test_must_fail git merge --no-commit commit-1 &&

I doubt it is a good idea to hardcode exit status of 1 by using
test_expect_code, though.  "git merge --help" does not say anything
about "1 means this failure, 2 means that failure, 3 means that
other failure".  And my quick forward scan of this series does not
tell me that you are trying to declare that from here on we _will_
make that promise to the end users by carving the exit status(es) in
stone.  The same about "git commit"'s exit code in the following
four tests.

> +'
> +
> +test_expect_success '--dry-run with unfixed merge conflicts' '
> +	test_expect_code 1 git commit --dry-run
> +'
> +
> +test_expect_success '--short with unfixed merge conflicts' '
> +	test_expect_code 1 git commit --short
> +'
> +
> +test_expect_success '--porcelain with unfixed merge conflicts' '
> +	test_expect_code 1 git commit --porcelain
> +'
> +
> +test_expect_success '--long with unfixed merge conflicts' '
> +	test_expect_code 1 git commit --long
> +'
> +
> +test_expect_success '--dry-run with conflicts fixed from a merge' '
> +	echo "merge-conflicts-fixed" >test-file &&

The original test pretended that we resolved favouring the current
state with "commit-2-state" in the file, as if we ran "-s ours".
Is there a reason why we now use a different contents, or is this
just a change based on subjective preference?  

    Not saying that the latter is necessrily bad; just trying to
    understand why we are making this change.

>  	git add test-file &&
> -	git commit --dry-run &&
> -	git commit -m "conflicts fixed from merge."
> +	git commit --dry-run

OK, the original tried --dry-run to ensure it exited with 0 status
(i.e. have something to commit) and then did a commit to record the
updated state with a message.  You are checking only the dry-run
part, leaving the check of the final commit's status to another
test.

> +'
> +
> +test_expect_failure '--short with conflicts fixed from a merge' '
> +	git commit --short
> +'

With "test_expect_failure", you are saying that "--short" _should_
exit with 0 but currently it does not.  An untold expectation is
that even with the breakage with the exit code, the command still
honors the (implicit) --dry-run correctly and does not create a
new commit.

That was actually tested in the original.  By &&-chaining like this

	git commit --dry-run &&
	git commit -m "conflicts fixed from merge."

we would have noticed if a newly introduced bug caused the first
step "commit --dry-run" to return non-zero status (because then the
step would fail), or if it stopped being dry-run and made a commit
(because then the next step would fail with "nothing to commit").

But by splitting these into separate tests, the patch makes such a
potential failure with "git commit --short" break the later steps.

Not very nice.

It may be a better change to just do in the original one

	git add test-file &&
	git commit --dry-run &&
+	git commit --short &&
+	git commit --long &&
+	git commit --porcelain &&
	git commit -m "conflicts fixed from merge."

without adding these new and separate tests, and then mark that one
to expect a failure (because it would pass up to the --dry-run
commit, but the --short commit would fail) at this step, perhaps?

> +test_expect_failure '--porcelain with conflicts fixed from a merge' '
> +	git commit --porcelain
> +'
> +
> +test_expect_success '--long with conflicts fixed from a merge' '
> +	git commit --long
> +'
> +
> +test_expect_success '--message with conflicts fixed from a merge' '
> +	git commit --message "conflicts fixed from merge."
>  '
>  
>  test_done
