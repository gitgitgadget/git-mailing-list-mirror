Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBB7C6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCUSiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCUSiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:38:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1510F2914D
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:38:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z18so9139213pgj.13
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679423887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/Bbjer6PObg66IwgUUJFVbsHS/MOlWf2s4sh413Als=;
        b=MqSxkWbrHgtHONg+GoNR4hzDdc/cXkL2RED+ISJSGtFMSv+jo3bg9yqdUQpY+rnyoa
         42UOWKiuZfVqX6YcE4M/4oeH8S228PSRmVgvuYyBRRd+d3YAI3V12Kqx0tyVVlRzsY7B
         zTk2kqhnm4sGh08THhLWQAH5KSj0NQfi8n3rdiDqS58GwErxJd1f7nLymZt5CWtVuE9T
         YyYXvU7kzhtiS7EWMMQzzFO9yZXtKpRbSYFZTQaJrfAllm5C4vnDXPWEK45LyqTVmzVA
         ClJpR11gtpSb0OPkZLRb4KZCykr3bkrPJGJAWVN3OVmzuMzZPYg5I2KGx+9TbI8rgOFV
         ojzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Bbjer6PObg66IwgUUJFVbsHS/MOlWf2s4sh413Als=;
        b=ZbMF2plmeu6MPLjjqzk+J3FCrv+533KqywISEZLQWTZYK8rqahdQoXshZ+bkugfvgK
         6TRR7Tt5pVlQbSLBBLZH3xIe+zvvAi17htWluQmWYSCohV9e7JWFjfrjGiwHPHa36llw
         L1SsMNPzx9caiC4yDlqycbNkpeByZAXEa4psNHPt72l9g1iIgoKftefu5IJXsVBVNBMj
         G5o6Q6CFPykyzZt+CvcXhAbmbkc94xqyRcOiFk9wxv+Rq0DMaJHoQxYAuCOF9WjI4OW3
         tGz0U6yyqih80AypZtbWobhdcRpbxNF50I5DIe6pug766AylUBmh6XVuMz5qr/6jNclk
         wHug==
X-Gm-Message-State: AO0yUKUrJ1DLuVHiBhspuWaJ7AtEYPRUKIGphZqO1oHx0po2ehKhyrKt
        Ya0hNo9XGrhgM0u4FGHVNcxP
X-Google-Smtp-Source: AK7set/32ac8kK78Bf28QqZc3HMnfPBlDCejw2rKgW1O1I1Oj+2R3G4beBhjE+w6YHqeCEXDL1PAWA==
X-Received: by 2002:a62:4ec9:0:b0:625:cf6d:b260 with SMTP id c192-20020a624ec9000000b00625cf6db260mr718201pfb.6.1679423887408;
        Tue, 21 Mar 2023 11:38:07 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b00592543d7363sm8601582pfo.1.2023.03.21.11.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:38:06 -0700 (PDT)
Message-ID: <af4cd38c-bd57-6e32-867d-a205ff0bb93b@github.com>
Date:   Tue, 21 Mar 2023 11:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC PATCH v6 0/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230320205241.105476-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Did not fix the logic of spare-checkout yet. Leave the spare diff-files 
> with pathspec outside sparse definition as 'test_expect_failure' now.
> but will fix soon.
> 
> Changes since v5:
> 
> 1. Add space after "definition."
> 
> 2. Add test case for a pathspec with wildcards or other "magic"
> 
> 3. Before messing with modified files on disk, add a "baseline" 
> of correct behavior when a pathspec points to out-of-cone files.
> 
> 4. Write the contents of an
> existing file inside that sparse directory to disk manually
> 
> 5. Use 'test_all_match' rather than 'test_sparse_match'. 
> wouldn't need the additional 'test_must_be_empty' checks.
> 
> 
> Shuqi Liang (2):
>   t1092: add tests for `git diff-files`
>   diff-files: integrate with sparse index
> 
>  builtin/diff-files.c                     |  8 +++
>  t/perf/p2000-sparse-operations.sh        |  2 +
>  t/t1092-sparse-checkout-compatibility.sh | 73 ++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)

[forgot to Reply-All - Shuqi, sorry for the duplicate email!]

In future iterations, please also include a range-diff in your version
iterations. The description of changes is useful, but the range-diff
provides a much more detailed and comprehensive summary of the changes
(making it exceptionally helpful for reviewers). I *think* you can just add
the '--range-diff <previous iteration>' option to 'git format-patch' (see
MyFirstContribution [1] for more detailed instructions).

[1] https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

For anyone that's interested, here's the range-diff vs. v5:

1:  fb9ec0901c ! 1:  14bbcf41e0 t1092: add tests for `git diff-files`
    @@ Commit message
         the sparse-checkout cone.
     
         In order to have staged changes outside of
    -    the sparse-checkout cone, create a 'newdirectory/testfile' and
    -    add it to the index, while leaving it outside of
    -    the sparse-checkout definition.Test 'newdirectory/testfile'
    -    being present on-disk without modifications, then change content inside
    -    'newdirectory/testfile' in order to test 'newdirectory/testfile'
    -    being present on-disk with modifications.
    +    the sparse-checkout cone, make a directory called 'folder1' and
    +    copy `a` into 'folder1/a'. 'folder1/a' is identical to `a` in the base
    +    commit. These make 'folder1/a' in the index, while leaving it outside of
    +    the sparse-checkout definition. Test 'folder1/a'being present on-disk
    +    without modifications, then change content inside 'folder1/a' in order
    +    to test 'folder1/a' being present on-disk with modifications.
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
     +
     +	test_all_match git diff-files &&
     +
    -+	test_all_match git diff-files deep/a 
    ++	test_all_match git diff-files deep/a && 
     +
    ++	# test wildcard
    ++	test_all_match git diff-files deep/*
     +'
     +
    -+test_expect_success 'diff-files with pathspec outside sparse definition' '
    ++test_expect_failure 'diff-files with pathspec outside sparse definition' '
     +	init_repos &&
     +
    ++	test_sparse_match test_must_fail git diff-files folder2/a &&
    ++
     +	write_script edit-contents <<-\EOF &&
     +	echo text >>"$1"
     +	EOF
     +
    -+	# add file to the index but outside of cone
    -+	run_on_sparse mkdir newdirectory &&
    -+	run_on_sparse ../edit-contents newdirectory/testfile &&
    -+	test_sparse_match git add --sparse newdirectory/testfile &&
    ++	# Add file to the index but outside of cone for sparse-checkout cases.
    ++	# Add file to the index without sparse-checkout cases to ensure all have 
    ++	# same output.
    ++	run_on_all mkdir folder1 &&
    ++	run_on_all cp a folder1/a &&
     +
     +	# file present on-disk without modifications
    -+	test_sparse_match git diff-files &&
    -+	test_must_be_empty sparse-checkout-out &&
    -+	test_must_be_empty sparse-checkout-err &&
    -+	test_sparse_match git diff-files newdirectory/testfile &&
    -+	test_must_be_empty sparse-checkout-out &&
    -+	test_must_be_empty sparse-checkout-err &&
    ++	test_all_match git diff-files &&
    ++	test_all_match git diff-files folder1/a &&
     +
     +	# file present on-disk with modifications
    -+	FN=newdirectory/testfile &&
    -+	OID=$(git -C sparse-checkout hash-object $FN) &&
    -+	ZERO=$(test_oid zero) &&
    -+	echo ":100644 100644 $OID $ZERO M	$FN" >expect &&
    -+
    -+	run_on_sparse ../edit-contents newdirectory/testfile &&
    -+	test_sparse_match git diff-files &&
    -+	test_cmp expect sparse-checkout-out &&
    -+	test_sparse_match git diff-files newdirectory/testfile &&
    -+	test_cmp expect sparse-checkout-out
    ++	run_on_all ../edit-contents folder1/a &&
    ++	test_all_match git diff-files &&
    ++	test_all_match git diff-files folder1/a
     +'
     +
      test_done
2:  04e24f7db5 ! 2:  734cd24f0c diff-files: integrate with sparse index
    @@ Metadata
      ## Commit message ##
         diff-files: integrate with sparse index
     
    +    Originally, diff-files a pathspec that is out-of-cone in a sparse-index
    +    environment, Git dies with "pathspec '<x>' did not match any files",
    +    mainly because it does not expand the index so nothing is matched.
    +    Expand the index when the <pathspec> needs an expanded index, i.e. the
    +    <pathspec> contains wildcard that may need a full-index or the
    +    <pathspec> is simply outside of sparse-checkout definition.
    +
         Remove full index requirement for `git diff-files`
    -    and test to ensure the index is not expanded in `git diff-files`.
    +    and add test to ensure the index only expanded when necessary
    +    in `git diff-files`.
     
         The `p2000` tests demonstrate a ~96% execution time reduction for 'git
         diff-files' and a ~97% execution time reduction for 'git diff-files'
    @@ builtin/diff-files.c: int cmd_diff_files(int argc, const char **argv, const char
      	repo_init_revisions(the_repository, &rev, prefix);
      	rev.abbrev = 0;
      
    +@@ builtin/diff-files.c: int cmd_diff_files(int argc, const char **argv, const char *prefix)
    + 		result = -1;
    + 		goto cleanup;
    + 	}
    ++
    ++	if (pathspec_needs_expanded_index(the_repository->index, &rev.diffopt.pathspec))
    ++		ensure_full_index(the_repository->index);
    ++		
    + 	result = run_diff_files(&rev, options);
    + 	result = diff_result_code(&rev.diffopt, result);
    + cleanup:
     
      ## t/perf/p2000-sparse-operations.sh ##
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all
      test_done
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff-files with pathspec outside sparse definition' '
    - 	test_cmp expect sparse-checkout-out
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'diff-files with pathspec outside sparse definition' '
    + 	test_all_match git diff-files folder1/a
      '
      
    ++test_expect_success 'diff-files pathspec expands index when necessary' '
    ++	init_repos &&
    ++
    ++	write_script edit-contents <<-\EOF &&
    ++	echo text >>"$1"
    ++	EOF
    ++
    ++	run_on_all ../edit-contents deep/a &&
    ++	
    ++	# pathspec that should expand index
    ++	! ensure_not_expanded diff-files "*/a" &&
    ++	test_must_be_empty sparse-index-err &&
    ++
    ++	! ensure_not_expanded diff-files "**a" &&
    ++	test_must_be_empty sparse-index-err
    ++'
    ++
     +test_expect_success 'sparse index is not expanded: diff-files' '
     +	init_repos &&
     +
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff-files with p
     +
     +	run_on_all ../edit-contents deep/a &&
     +
    -+	ensure_not_expanded diff-files  &&
    -+	ensure_not_expanded diff-files deep/a 
    ++	ensure_not_expanded diff-files &&
    ++	ensure_not_expanded diff-files deep/a &&
    ++	ensure_not_expanded diff-files deep/*
     +'
     +
      test_done

> 
> 
> base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1

