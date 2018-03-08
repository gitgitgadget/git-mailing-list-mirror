Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458FD1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbeCHMZe (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 07:25:34 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:39129 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755460AbeCHMZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 07:25:33 -0500
Received: by mail-wr0-f175.google.com with SMTP id w77so5487071wrc.6
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 04:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwNvVGJKshYklC3CPJVa0iK8ZFHWtLyejgnBRiZ/7xw=;
        b=F9hokVpmU2JcVLlx70XoxM0qG41JhU5EYbL+5pgyMso10TGUZZA8rS28le8SbKmsON
         s3Bib0ISZqh371L3siZ5DS774U54vb7ymbm1YDvH9DN0nIP2aMA8RR9WTsjS70RbGlFr
         IyTJwzLSBUt+ZnHz9Poza4Dqq1qxhKoYe0p8jGo3vbYFfd3fYxE4+5Q6Y3ImS/dfOZDM
         GoHoz9TGp2wkRtp72QYN+oYRTVtaHSFvdmZD9YfO4qtiANQy3JOlN4kl3Q4tUyPN6uNF
         le6zG3vM66pjIJc97V+gVT2YqnRsNiXn7JYUPtjaE9wA3sQJVXSKPXrZ0nyoEy3+/q4A
         DRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwNvVGJKshYklC3CPJVa0iK8ZFHWtLyejgnBRiZ/7xw=;
        b=ERDhWidVJ4tRiN5wRke76qfqEDkvuKh4oaQc8Cvv7dpxGP1wD+HwKcVviuSHbF1e2y
         4/D/vnhBUEwP6DWjfroj3p4J8T7tKd5MinlW9XZNpkbB8bsFfdPJivAIjdEkcVG5MnBR
         ibLhOdsmf/H4e/rQB65XNs3VNsaA7+Ghw6nToWB7RwXvQq55NwDH2zyAzD0D2bjaJfK0
         jPx7FNjcaO2iLGIIn+yHBHWbteNhpRtv9e6FXj4AKtByQcnEtnNAI2aKT9Szf73t3LBL
         E1xVVWUYkuMiFa6DOfhAzdMZKu2R1LEZoN3ejt3htYGjIp1q2FjyqAD71//TXaRCFQ8R
         hXsA==
X-Gm-Message-State: APf1xPAkzkagBAojj85j5F8lWk0g+xHjDbzOoxAS2OyeFKYFdxIpq3/l
        93NhtvbEbZezK62+dEfg7F8=
X-Google-Smtp-Source: AG47ELv4yUZBRu/L2vAuycuDI0VO4P4+NkyhjoFsaCp/MGyou6lKABrO5DUrJfqBpx+Enos09Kc1WQ==
X-Received: by 10.223.170.78 with SMTP id q14mr21640303wrd.271.1520511932156;
        Thu, 08 Mar 2018 04:25:32 -0800 (PST)
Received: from localhost.localdomain (x4db106d7.dyn.telefonica.de. [77.177.6.215])
        by smtp.gmail.com with ESMTPSA id 198sm22597274wmg.8.2018.03.08.04.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Mar 2018 04:25:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] Add testcases for improved file collision conflict handling
Date:   Thu,  8 Mar 2018 13:25:23 +0100
Message-Id: <20180308122523.14434-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.603.g180c1428f0
In-Reply-To: <20180305171125.22331-2-newren@gmail.com>
References: <20180305171125.22331-1-newren@gmail.com> <20180305171125.22331-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Adds testcases dealing with file collisions for the following types of
> conflicts:
>   * add/add
>   * rename/add
>   * rename/rename(2to1)
> These tests include expectations for proposed smarter behavior which has
> not yet been implemented and thus are currently expected to fail.
> Subsequent commits will correct that and explain the new behavior.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6042-merge-rename-corner-cases.sh | 220 +++++++++++++++++++++++++++++++++++
>  1 file changed, 220 insertions(+)
> 
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index 411550d2b6..a6c151ef95 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -575,4 +575,224 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
>  	test ! -f c
>  '
>
> +test_conflicts_with_adds_and_renames() {
> +	test $1 != 0 && side1=rename || side1=add
> +	test $2 != 0 && side2=rename || side2=add

For additonal context I'm going to quote the callsites of this
function from the end of the test script:

> +test_conflicts_with_adds_and_renames 1 1
> +test_conflicts_with_adds_and_renames 1 0
> +test_conflicts_with_adds_and_renames 0 1
> +test_conflicts_with_adds_and_renames 0 0

Instead of the two conditions at the beginning of the function and the
1 and 0 sort-of magic numbers at the callsites, you could just pass
the words "rename" and "add" as parameters to the function.  The
callsites would be clearer and the function could start with two
simple variable assignments side1=$1 ; side2=$2.

Please feel free to dismiss this as bikeshedding: since the branches
are called 'L' and 'R', maybe calling the variables $sideL and $sideR
would match better the rest of the test?  Dunno.

> +	# Setup:
> +	#          L
> +	#         / \
> +	#   master   ?
> +	#         \ /
> +	#          R
> +	#
> +	# Where:
> +	#   Both L and R have files named 'three-unrelated' and
> +	#   'three-related' which collide (i.e. 4 files colliding at two
> +	#   pathnames).  Each of the colliding files could have been
> +	#   involved in a rename, in which case there was a file named
> +	#   'one-[un]related' or 'two-[un]related' that was modified on the
> +	#   opposite side of history and renamed into the collision on this
> +	#   side of history.
> +	#
> +	# Questions for both sets of collisions:
> +	#   1) The index should contain both a stage 2 and stage 3 entry
> +	#      for the colliding file.  Does it?
> +	#   2) When renames are involved, the content merges are clean, so
> +	#      the index should reflect the content merges, not merely the
> +	#      version of the colliding file from the prior commit.  Does
> +	#      it?
> +	#
> +	# Questions for three-unrelated:
> +	#   3) There should be files in the worktree named
> +	#      'three-unrelated~HEAD' and 'three-unrelated~R^0' with the
> +	#      (content-merged) version of 'three-unrelated' from the
> +	#      appropriate side of the merge.  Are they present?
> +	#   4) There should be no file named 'three-unrelated' in the
> +	#      working tree.  That'd make it too likely that users would
> +	#      use it instead of carefully looking at both
> +	#      three-unrelated~HEAD and three-unrelated~R^0.  Is it
> +	#      correctly missing?
> +	#
> +	# Questions for three-related:
> +	#   3) There should be a file in the worktree named three-related
> +	#      containing the two-way merged contents of the content-merged
> +	#      versions of three-related from each of the two colliding
> +	#      files.  Is it present?
> +	#   4) There should not be any three-related~* files in the working
> +	#      tree.
> +	test_expect_success "setup simple $side1/$side2 conflict" '
> +		test_create_repo simple_${side1}_${side2} &&
> +		(
> +			cd simple_${side1}_${side2} &&
> +
> +			# Create a simple file with 10 lines
> +			ten="0 1 2 3 4 5 6 7 8 9" &&
> +			for i in $ten
> +			do
> +				echo line $i in a sample file
> +			done >unrelated1_v1 &&
> +			# Create a 2nd version of same file with one more line
> +			cat unrelated1_v1 >unrelated1_v2 &&

'cp unrelated1_v1 unrelated1_v2', perhaps?

> +			echo another line >>unrelated1_v2 &&
> +
> +			# Create an unrelated simple file with 10 lines
> +			for i in $ten
> +			do
> +				echo line $i in another sample file
> +			done >unrelated2_v1 &&
> +			# Create a 2nd version of same file with one more line
> +			cat unrelated2_v1 >unrelated2_v2 &&

Likewise.

> +			echo another line >>unrelated2_v2 &&
> +
> +			# Create some related files now
> +			for i in $ten
> +			do
> +				echo Random base content line $i
> +			done >related1_v1 &&
> +			cp -a related1_v1 related1_v2 &&

Wouldn't a "plain" 'cp', i.e. without '-a', be sufficient?

> +			echo modification >>related1_v2 &&
> +
> +			cp -a related1_v1 related2_v1 &&
> +			echo more stuff >>related2_v1 &&
> +			cp -a related2_v1 related2_v2 &&
> +			echo yet more stuff >>related2_v2 &&
> +
> +			# Use a tag to record both these files for simple
> +			# access, and clean out these untracked files
> +			git tag unrelated1_v1 `git hash-object -w unrelated1_v1` &&
> +			git tag unrelated1_v2 `git hash-object -w unrelated1_v2` &&
> +			git tag unrelated2_v1 `git hash-object -w unrelated2_v1` &&
> +			git tag unrelated2_v2 `git hash-object -w unrelated2_v2` &&
> +			git tag related1_v1 `git hash-object -w related1_v1` &&
> +			git tag related1_v2 `git hash-object -w related1_v2` &&
> +			git tag related2_v1 `git hash-object -w related2_v1` &&
> +			git tag related2_v2 `git hash-object -w related2_v2` &&

Style nit: please use $() for command substitutions instead of
backticks.

> +			git clean -f &&
> +
> +			# Setup merge-base, consisting of files named "one-*"
> +			# and "two-*" if renames were involved.
> +			touch irrelevant_file &&
> +			git add irrelevant_file &&
> +			if [ $side1 == "rename" ]; then

Another style nit:

        if test $side1 = "rename"
        then
                ...

> +				git show unrelated1_v1 >one-unrelated &&
> +				git add one-unrelated

Broken && chain.
Please check the subsequent if statements as well, there are more
places where the && is missing.

Also note that you can run 'git add one-unrelated one-related', i.e.
add more than one file at once, sparing a couple of lines and git
executions.

> +				git show related1_v1 >one-related &&
> +				git add one-related
> +			fi &&
> +			if [ $side2 == "rename" ]; then
> +				git show unrelated2_v1 >two-unrelated &&
> +				git add two-unrelated
> +				git show related2_v1 >two-related &&
> +				git add two-related
> +			fi &&
> +			test_tick && git commit -m initial &&
> +
> +			git branch L &&
> +			git branch R &&
> +
> +			# Handle the left side
> +			git checkout L &&
> +			if [ $side1 == "rename" ]; then
> +				git mv one-unrelated three-unrelated
> +				git mv one-related   three-related
> +			else
> +				git show unrelated1_v2 >three-unrelated &&
> +				git add three-unrelated
> +				git show related1_v2 >three-related &&
> +				git add three-related
> +			fi &&
> +			if [ $side2 == "rename" ]; then
> +				git show unrelated2_v2 >two-unrelated &&
> +				git add two-unrelated
> +				git show related2_v2 >two-related &&
> +				git add two-related
> +			fi &&
> +			test_tick && git commit -m L &&
> +
> +			# Handle the right side
> +			git checkout R &&
> +			if [ $side1 == "rename" ]; then
> +				git show unrelated1_v2 >one-unrelated &&
> +				git add one-unrelated
> +				git show related1_v2 >one-related &&
> +				git add one-related
> +			fi &&
> +			if [ $side2 == "rename" ]; then
> +				git mv two-unrelated three-unrelated
> +				git mv two-related three-related
> +			else
> +				git show unrelated2_v2 >three-unrelated &&
> +				git add three-unrelated
> +				git show related2_v2 >three-related &&
> +				git add three-related
> +			fi &&
> +			test_tick && git commit -m R
> +		)
> +	'

This setup test is enormous, and the conditions for the combination of
the two sides and the add/rename conflicts are somewhat distracting.
I don't know how it could be structured better/shorter/clearer...  I
couldn't come up with anything useful during lunch.

> +
> +	test_expect_failure "check simple $side1/$side2 conflict" '
> +		(
> +			cd simple_${side1}_${side2} &&
> +
> +			git checkout L^0 &&
> +
> +			# Merge must fail; there is a conflict
> +			test_must_fail git merge -s recursive R^0 &&
> +
> +			# Make sure the index has the right number of entries
> +			git ls-files -s >out &&
> +			test_line_count = 5 out &&
> +			git ls-files -u >out &&
> +			test_line_count = 4 out &&
> +
> +			# Nothing should have touched irrelevant_file
> +			git rev-parse >actual \
> +				:0:irrelevant_file \
> +				:2:three-unrelated :3:three-unrelated \
> +				:2:three-related   :3:three-related   &&
> +			git rev-parse >expected \
> +				master:irrelevant_file \
> +				unrelated1_v2      unrelated2_v2 \
> +				related1_v2        related2_v2   &&

Missing 'test_cmp'?  The above lines write the files 'actual' and
'expected', but they are never looked at.

> +			# Ensure we have the correct number of untracked files
> +			git ls-files -o >out &&
> +			test_line_count = 5 out &&
> +
> +			# Make sure each file (with merging if rename
> +			# involved) is present in the working tree for the
> +			# user to work with.
> +			git hash-object >actual \
> +				three-unrelated~HEAD three-unrelated~R^0 &&
> +			git rev-parse >expected \
> +				unrelated1_v2        unrelated2_v2 &&

Again, missing 'test_cmp'?

> +			# "three-unrelated" should not exist because there is
> +			# no reason to give preference to either
> +			# three-unrelated~HEAD or three-unrelated~R^0
> +			test_path_is_missing three-unrelated &&
> +
> +			# Make sure we have the correct merged contents for
> +			# three-related
> +			git show related1_v1 >expected &&
> +			cat <<EOF >>expected &&
> +<<<<<<< HEAD
> +modification
> +=======
> +more stuff
> +yet more stuff
> +>>>>>>> R^0
> +EOF

You could use 'cat <<-EOF ....' and indent the here doc with tabs, so
it won't look so out-of-place.  Or even '<<-\EOF' to indicate that
there is nothing to be expanded in the here doc. 

> +
> +			test_cmp expected three-related
> +		)
> +	'
> +}
> +
> +test_conflicts_with_adds_and_renames 1 1
> +test_conflicts_with_adds_and_renames 1 0
> +test_conflicts_with_adds_and_renames 0 1
> +test_conflicts_with_adds_and_renames 0 0
> +
>  test_done
> --
> 2.16.0.41.g6a66043158
> 
> 
