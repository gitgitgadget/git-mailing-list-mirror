Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23397C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 13:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354761AbiBNOAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:00:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiBNOAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 09:00:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54813E31
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 05:59:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o34so5938168wms.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rDXOAJOXfPVNCcbj9hLU+reJSwjgPGTwpPPqAPgivVU=;
        b=arVUO5Vw7Kb+tDcW/3JTTwwSTNnPot/6qfgv0m1hD2U+oN+d/mMfk+2p4ZppVYsw6H
         Ik68ZJ+C5gFPCcvbTmHlA/JR9iP7w/SoI/Q7RmH0aY4HjT8d0Uv8fNyR2x47cye67A99
         jxbKKDkIA6hyMFt7N91SGB0mQj1V1ZXo5/LKkiRdbmsBYz/+1yb3Qyaf37ZKeWtjx2cn
         yarqbnBF8zECY/H83YSVQeIrg3Dr1xZmUglFN7bDnT2AOqennisC9RLmZ1cYIqdJa/QV
         UVT5ZhVRs97jv7G/DupXEDDa56JLW5WrG8tgBPHU2RvT5HA59JZkd9Ab/tBUAUw84qD2
         GFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rDXOAJOXfPVNCcbj9hLU+reJSwjgPGTwpPPqAPgivVU=;
        b=lTtqGTHspwN2PyPcUZtuAq7pXvV8SYtRUlnlwIksFUVd6zw5BoKeLalcVrY+Ha0ZYv
         z8lLaEuZ3CIhBJmPIODrENJplVJa1tkpPSapy/a9Uidd/qkZbv9X+9gjVOk05wpbdCYq
         eGDtOQTANAjjnOEUVY0UNxnicdFbW+ZaxcUNGSEBtqtfFNYAnYPjQM70L9aIwCg/r6kS
         ajs09+D5YAkn1Rmj9LbQmwGF0ta14+JoT3WlJoOl67nODH4mM6h1cTIt33LLKG7MuANH
         l0/faXFwKIWEXW5MLqDaUzj+8nKq+QXghNOmDCnpwb0Z8uJ658y5qJX1hILzfTMxiPai
         P0DA==
X-Gm-Message-State: AOAM531p2Rg9wPkb6iqDuYCBrgEjJbl6dydbLGeDWA8NfpP3JwcvjbGu
        VcquIZsQ8rb8Cm0ws8lSWeI=
X-Google-Smtp-Source: ABdhPJyPZfWFmA3tv2Svk4RHkrtlRoVr+R65VN1kEdYKtzZ8ADqx/EPwleyb/8R9wMqXVN5a3v9sYA==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr11300691wmj.41.1644847192234;
        Mon, 14 Feb 2022 05:59:52 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id n15sm15122780wmr.9.2022.02.14.05.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 05:59:51 -0800 (PST)
Message-ID: <3932558a-ce38-d94b-b974-65510688d8c0@gmail.com>
Date:   Mon, 14 Feb 2022 13:59:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] cat-file: add --batch-command mode
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com, e@80x24.org,
        bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
 <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
 <ad66d1f3e2bc84498b3168416ae1ccdd41f8a7ce.1644609683.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ad66d1f3e2bc84498b3168416ae1ccdd41f8a7ce.1644609683.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

I've concentrated on the tests again, I think the flush tests still need 
some work but the others are looking good

 >[...]>   Documentation/git-cat-file.txt |  41 +++++++-
>   builtin/cat-file.c             | 133 ++++++++++++++++++++++++
>   t/t1006-cat-file.sh            | 178 ++++++++++++++++++++++++++++++++-
>   3 files changed, 347 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index bef76f4dd06..e8da704477d 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,32 @@ OPTIONS
>   	need to specify the path, separated by whitespace.  See the
>   	section `BATCH OUTPUT` below for details.
>   
> +--batch-command::

+--batch-command=<format>::

as we also take an optional format string

> +	Enter a command mode that reads commands and arguments from stdin. May
> +	only be combined with `--buffer`, `--textconv` or `--filters`. In the
> +	case of `--textconv` or `--filters`, the input lines also need to specify
> +	the path, separated by whitespace. See the section `BATCH OUTPUT` below
> +	for details.
> ++
> +`--batch-command` recognizes the following commands:
> ++
> +--
> +contents `<object>`::
> +	Print object contents for object reference `<object>`. This corresponds to
> +	the output of `--batch`.
> +
> +info `<object>`::
> +	Print object info for object reference `<object>`. This corresponds to the
> +	output of `--batch-check`.
> +
> +flush::
> +	Used with `--buffer` to execute all preceding commands that were issued
> +	since the beginning or since the last flush was issued. When `--buffer`
> +	is used, no output will come until a `flush` is issued. When `--buffer`
> +	is not used, commands are flushed each time without issuing `flush`.
> +--
> ++
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 145eee11df9..a501dbcc39b 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -177,6 +177,24 @@ $content"
>   	test_cmp expect actual
>       '
>   
> +    for opt in --buffer --no-buffer
> +    do
> +	test -z "$content" ||
> +		test_expect_success "--batch-command $opt output of $type content is correct" '
> +		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
> +		| git cat-file --batch-command $opt)" $no_ts >actual &&
> +		test_cmp expect actual
> +	'
> +
> +	test_expect_success "--batch-command $opt output of $type info is correct" '
> +		echo "$sha1 $type $size" >expect &&
> +		test_write_lines "info $sha1" \
> +		| git cat-file --batch-command $opt >actual &&
> +		test_cmp expect actual
> +	'
> +    done
> +
>       test_expect_success "custom --batch-check format" '
>   	echo "$type $sha1" >expect &&
>   	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
> @@ -213,6 +231,84 @@ $content"
>       '
>   }
>   
> +run_buffer_test_flush () {
> +	type=$1
> +	sha1=$2
> +	size=$3
> +
> +	rm -f input output &&

I think that this should not be needed with the addition of 
"test_when_finished 'rm input output'" in run_buffer_test_no_flush()

> +	mkfifo input &&
> +	test_when_finished 'rm input'
> +	mkfifo output &&
> +	exec 9<>output &&

To address the worries about this test hanging rather than failing if 
something goes wrong I wonder if we could do something like

	(
		sleep 10
		echo "error: timeout" >&2
		echo TIMEOUT >&9
	) &
	watchdog_pid=$! &&
	test_when_finished 'kill $watchdog_pid; wait $watchdog_pid'

That should unblock any reads from fd 9 if the test hangs

> +	test_when_finished 'rm output; exec 9<&-'
> +	(
> +		# TODO - Ideally we'd pipe the output of cat-file
> +		# through "sed s'/$/\\/'" to make sure that that read
> +		# would consume all the available
> +		# output. Unfortunately we cannot do this as we cannot
> +		# control when sed flushes its output. We could write
> +		# a test helper in C that appended a '\' to the end of
> +		# each line and flushes its output after every line.
> +		git cat-file --buffer --batch-command <input 2>err &
> +		echo $! &&
> +		wait $!
> +		echo $?
> +	) >&9 &
> +	sh_pid=$! &&
> +	read cat_file_pid <&9 &&
> +	test_when_finished "kill $cat_file_pid
> +			    kill $sh_pid; wait $sh_pid; :" &&
> +	(
> +		test_write_lines "info $sha1" flush "info $sha1" &&
> +		# TODO - consume all available input, not just one
> +		# line (see above).
> +		read actual <&9 &&
> +		echo "$actual" >actual &&
> +		echo "$sha1 $type $size" >expect &&
> +		test_cmp expect actual
> +	) >input &&
> +	# check output is flushed on exit
> +	read actual <&9 &&
> +	echo "$actual" >actual &&
> +	test_cmp expect actual &&
> +	test_must_be_empty err &&
> +	read status <&9 &&
> +	test "$status" -eq 0
> +}
> +
> +run_buffer_test_no_flush () {

This test reliably hangs for me when running with --stress

> +	type=$1
> +	sha1=$2
> +	size=$3
> +
> +	touch output &&

If output is missing at the end it means cat-file never ran which is an 
error which we do not want to hide. This is because the subshell creates 
output after opening input and before it executes cat-file below. As 
input is a fifo the open will block until it is opened for writing by 
another process and nothing wrote to it in V4 so I think that is why you 
saw an error there.

> +	test_when_finished 'rm output'
> +	mkfifo input &&
> +	test_when_finished 'rm input'
> +	mkfifo pid &&
> +	exec 9<>pid &&
> +	test_when_finished 'rm pid; exec 9<&-'
> +	(
> +		git cat-file --buffer --batch-command <input >>output &
> +		echo $! &&
> +		wait $!
> +		echo $?
> +	) >&9 &
> +	sh_pid=$! &&
> +	read cat_file_pid <&9 &&
> +	test_when_finished "kill $cat_file_pid
> +			    kill $sh_pid; wait $sh_pid; :" &&
> +	(
> +		test_write_lines "info $sha1" "info $sha1" &&
> +		kill $cat_file_pid &&
> +		read status <&9 &&

This is where the test hangs. There seems to be a race (which I don't 
understand) where we're able to read the pid of cat-file but it is not 
killed by the kill above (the subshell above is blocked on "wait $!"). 
Adding "sleep 1" before the kill above makes everything work but I'm not 
very comfortable with it. I think we might be better taking a different 
approach and introducing an environment variable such as 
GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT which stops cat-file flushing its 
output on exit and having a test along the lines of

test_write_lines "info $sha1" | GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 git 
cat-file --batch-command --buffer >output &&
test_must_be_empty_output



> +		test "$status" -ne 0 &&
> +		test_must_be_empty output
> +	) >input
> +}
> +
> +
>   hello_content="Hello World"
>   hello_size=$(strlen "$hello_content")
>   hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
> @@ -224,6 +320,14 @@ test_expect_success "setup" '
>   
>   run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
>   
> +test_expect_success PIPE '--batch-command --buffer with flush for blob info' '
> +       run_buffer_test_flush blob $hello_sha1 $hello_size
> +'
> +
> +test_expect_success PIPE '--batch-command --buffer without flush for blob info' '
> +       run_buffer_test_no_flush blob $hello_sha1 $hello_size false
> +'
> +
>   test_expect_success '--batch-check without %(rest) considers whole line' '
>   	echo "$hello_sha1 blob $hello_size" >expect &&
>   	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
> @@ -267,7 +371,7 @@ test_expect_success \
>       "Reach a blob from a tag pointing to it" \
>       "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
>   
> -for batch in batch batch-check
> +for batch in batch batch-check batch-command
>   do
>       for opt in t s e p
>       do
> @@ -373,6 +477,43 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>       "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>   '
>   
> +test_expect_success '--batch-command with multiple info calls gives correct format' '
> +	cat >expect <<-EOF &&
> +	$hello_sha1 blob $hello_size
> +	$tree_sha1 tree $tree_size
> +	$commit_sha1 commit $commit_size
> +	$tag_sha1 tag $tag_size
> +	deadbeef missing
> +	EOF
> +
> +	test_write_lines "info $hello_sha1"\
> +	"info $tree_sha1"\
> +	"info $commit_sha1"\
> +	"info $tag_sha1"\
> +	"info deadbeef" | git cat-file --batch-command --buffer >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--batch-command with multiple command calls gives correct format' '
> +	cat >expect <<-EOF &&
> +	$hello_sha1 blob $hello_size
> +	$hello_content
> +	$commit_sha1 commit $commit_size
> +	$commit_content
> +	$tag_sha1 tag $tag_size
> +	$tag_content
> +	deadbeef missing
> +	EOF
> +
> +	maybe_remove_timestamp "$(cat expect)" 1 >expect &&
> +	maybe_remove_timestamp "$(test_write_lines "contents $hello_sha1"\
> +	"contents $commit_sha1"\
> +	"contents $tag_sha1"\
> +	"contents deadbeef"\
> +	"flush" | git cat-file --batch-command --buffer)" 1 >actual &&
> +	test_cmp expect actual

It is a shame that maybe_remove_timestamp does no read from stdin, this 
test would look much nicer if it did. Apart from that these and the ones 
below are looking good

Best Wishes

Phillip

> +'
> +
>   test_expect_success 'setup blobs which are likely to delta' '
>   	test-tool genrandom foo 10240 >foo &&
>   	{ cat foo && echo plus; } >foo-plus &&
> @@ -963,5 +1104,40 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
>   	echo "$orig commit $orig_size" >expect &&
>   	test_cmp expect actual
>   '
> +test_expect_success 'batch-command empty command' '
> +	echo "" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep "^fatal:.*empty command in input.*" err
> +'
> +
> +test_expect_success 'batch-command whitespace before command' '
> +	echo " info deadbeef" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep "^fatal:.*whitespace before command.*" err
> +'
> +
> +test_expect_success 'batch-command unknown command' '
> +	echo unknown_command >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep "^fatal:.*unknown command.*" err
> +'
> +
> +test_expect_success 'batch-command missing arguments' '
> +	echo "info" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep "^fatal:.*info requires arguments.*" err
> +'
> +
> +test_expect_success 'batch-command flush with arguments' '
> +	echo "flush arg" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
> +	grep "^fatal:.*flush takes no arguments.*" err
> +'
> +
> +test_expect_success 'batch-command flush without --buffer' '
> +	echo "flush arg" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep "^fatal:.*flush is only for --buffer mode.*" err
> +'
>   
>   test_done

