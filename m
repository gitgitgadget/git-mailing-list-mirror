Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7036C1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 12:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeGYNNv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 09:13:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42201 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeGYNNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 09:13:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so6981328edp.9
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiYYFS5KcgT3YxgadgccXtOJG1byvY9KnZhQgOv6Ml8=;
        b=DWneJ/YdLrkVBChtJ69J+IESkzSOrhrZECsfG0dqhvgNmOzQPUU3KxeKNUY4TddEfF
         4U50r/LMNfLgdjhvK5XcbCD4VKodpV2CprzMryNiZcvZrRwt64E8JwVHv+wrHrY92O34
         CZRf39SLnz6wwla+o6yIJUgT4XbW/gIf8fYy0spXi+vIaTqlzB4PBIHHPvZQWq3V6fIw
         2ObNsyAlxHMXMIevlKbio83ZgiUfiV1Ptw9tTzEA3YvsERISeYCvLEV9Ik1BJNFnKYeb
         5gnMqnPaWe65utHFliFVVznCO48ZolRCGMp+x7EEzuuDV3uZ/657F9Z/NM3R8O0Jd4qs
         tKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiYYFS5KcgT3YxgadgccXtOJG1byvY9KnZhQgOv6Ml8=;
        b=IFU/e72UeHXNJjmI7Z0Zlfl/wFxsBpXSwqUD0KHcRo3QdC/GSEXvtVPsk1HXMOi7MA
         0D+o51KlqmVx9WLMv/bqfCruIG8iTh6xE/BPDAbgnvtK8FAccMODlxBjEKwiW4dxt1Wo
         q4BWBvEFhcHXOw3KZMtZXE0jB+cY4l34JX0gSt6LYOwu1yzWW450n02+GvVqLBh2YL9E
         ZX2h666tnA+jJSmCGo+QIoHX9HejIOo9wJq2qomQhuYHY8dvvbKTeAlUlsMV7+HqphJZ
         WICqyrH8F+V9uF/iIsGF7LVsqzcC0aDcLW8ZDm0qIb5JTjDulMStVgdVOopcvP+XQgjn
         X3wA==
X-Gm-Message-State: AOUpUlHqThKbOhYBsW0bFV5ZZ+EAwObCQO46VeLirW85Ly0byxjnYI83
        QUOgOp6fkZQSVSBZmnkFfXY=
X-Google-Smtp-Source: AAOMgpd7oDrUpE7sJ79bff664pw/m48bT1MO39H66VsfgGdK3/10umRKNatZbhyauuaI4R/kvsTAFA==
X-Received: by 2002:a50:aa43:: with SMTP id p3-v6mr22765273edc.233.1532520146439;
        Wed, 25 Jul 2018 05:02:26 -0700 (PDT)
Received: from localhost.localdomain (x590e43f2.dyn.telefonica.de. [89.14.67.242])
        by smtp.gmail.com with ESMTPSA id h1-v6sm6351218edr.86.2018.07.25.05.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jul 2018 05:02:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] http-backend: respect CONTENT_LENGTH for receive-pack
Date:   Wed, 25 Jul 2018 14:02:06 +0200
Message-Id: <20180725120206.19810-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Push passes to another commands, as described in
> https://public-inbox.org/git/20171129032214.GB32345@sigill.intra.peff.net/
> 
> As it gets complicated to correctly track the data length, instead transfer
> the data through parent process and cut the pipe as the specified length is
> reached. Do it only when CONTENT_LENGTH is set, otherwise pass the input
> directly to the forked commands.
> 
> Add tests for cases:
> 
> * CONTENT_LENGTH is set, script's stdin has more data, with all combinations
>   of variations: fetch or push, plain or compressed body, correct or truncated
>   input.
> 
> * CONTENT_LENGTH is specified to a value which does not fit into ssize_t.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  help.c                                 |   1 +
>  http-backend.c                         |  32 ++++-
>  t/t5562-http-backend-content-length.sh | 169 +++++++++++++++++++++++++
>  t/t5562/invoke-with-content-length.pl  |  37 ++++++
>  4 files changed, 237 insertions(+), 2 deletions(-)
>  create mode 100755 t/t5562-http-backend-content-length.sh
>  create mode 100755 t/t5562/invoke-with-content-length.pl


> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> new file mode 100755
> index 0000000000..8040d80e04
> --- /dev/null
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -0,0 +1,169 @@
> +#!/bin/sh
> +
> +test_description='test git-http-backend respects CONTENT_LENGTH'
> +. ./test-lib.sh
> +
> +test_lazy_prereq GZIP 'gzip --version'
> +
> +verify_http_result() {
> +	# sometimes there is fatal error buit the result is still 200

s/buit/but/

> +	if grep 'fatal:' act.err
> +	then
> +		return 1
> +	fi

I just happened to stumble upon a failure because of 'fatal: the
remote end hung up unexpectedly' in the test 'push plain'.

What does that "sometimes" in the above comment mean, and how often
does such a failure happen?  I see these patches are in 'pu' for over
a month now, so based on the number of reflog entries since then it
happened once from about 30-35 builds on Travis CI so far.

I don't really like the idea of adding a bunch of flaky test cases...
we have enough of them already, unfortunately.

> +
> +	if ! grep "Status" act.out >act
> +	then
> +		printf "Status: 200 OK\r\n" >act
> +	fi
> +	printf "Status: $1\r\n" >exp &&
> +	test_cmp exp act
> +}
> +
> +test_http_env() {
> +	handler_type="$1"
> +	shift
> +	env \
> +		CONTENT_TYPE="application/x-git-$handler_type-pack-request" \
> +		QUERY_STRING="/repo.git/git-$handler_type-pack" \
> +		PATH_TRANSLATED="$PWD/.git/git-$handler_type-pack" \
> +		GIT_HTTP_EXPORT_ALL=TRUE \
> +		REQUEST_METHOD=POST \
> +		"$@"
> +}
> +
> +ssize_b100dots() {
> +	# hardcoded ((size_t) SSIZE_MAX) + 1
> +	case "$(build_option sizeof-size_t)" in
> +	8) echo 9223372036854775808;;
> +	4) echo 2147483648;;
> +	*) die "Unexpected ssize_t size: $(build_option sizeof-size_t)";;
> +	esac
> +}
> +
> +test_expect_success 'setup' '
> +	git config http.receivepack true &&
> +	test_commit c0 &&
> +	test_commit c1 &&
> +	hash_head=$(git rev-parse HEAD) &&
> +	hash_prev=$(git rev-parse HEAD~1) &&
> +	printf "want %s" "$hash_head" | packetize >fetch_body &&
> +	printf 0000 >>fetch_body &&
> +	printf "have %s" "$hash_prev" | packetize >>fetch_body &&
> +	printf done | packetize >>fetch_body &&
> +	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
> +	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
> +	printf "%s %s refs/heads/newbranch\\0report-status\\n" "$_z40" "$hash_next" | packetize >push_body &&
> +	printf 0000 >>push_body &&
> +	echo "$hash_next" | git pack-objects --stdout >>push_body &&
> +	test_copy_bytes 10 <push_body >push_body.trunc &&
> +	: >empty_body
> +'
> +
> +test_expect_success GZIP 'setup, compression related' '
> +	gzip -k fetch_body &&
> +	test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
> +	gzip -k push_body &&
> +	test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
> +'
> +
> +test_expect_success 'fetch plain' '
> +	test_http_env upload \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body git http-backend >act.out 2>act.err &&

Don't save the standard error of the whole shell function.
When running the test with /bin/sh and '-x' tracing, then the trace of
commands executed in the function will be included in the standard
error as well, which may interfere with later verification (though in
this case it doesn't seem like it would cause any issues).

Please limit the redirections to the relevant command's output.  AFAICT
all invocations of 'test_http_env' in these tests have their stdout and
stderr redirected to the same pair of files, so perhaps you could
simply move all these redirections inside the function.

> +	verify_http_result "200 OK"
> +'
> +
> +test_expect_success 'fetch plain truncated' '
> +	test_http_env upload \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.trunc git http-backend >act.out 2>act.err &&

If this command were to print a "fatal: ..." message to its standard
error, then ...

> +	! verify_http_result "200 OK"

... this function would return error (because of that 'if grep fatal:
...' statement) without even looking at the status, but the test would
still succeed.  Is that really the desired behavior here?

> +'
> +
> +test_expect_success 'fetch plain empty' '
> +	test_http_env upload \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success GZIP 'fetch gzipped' '
> +	test_http_env upload \
> +		HTTP_CONTENT_ENCODING="gzip" \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.gz git http-backend >act.out 2>act.err &&
> +	verify_http_result "200 OK"
> +'
> +
> +test_expect_success GZIP 'fetch gzipped truncated' '
> +	test_http_env upload \
> +		HTTP_CONTENT_ENCODING="gzip" \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.gz.trunc git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success GZIP 'fetch gzipped empty' '
> +	test_http_env upload \
> +		HTTP_CONTENT_ENCODING="gzip" \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success GZIP 'push plain' '
> +	test_when_finished "git branch -D newbranch" &&
> +	test_http_env receive \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body git http-backend >act.out 2>act.err &&
> +	verify_http_result "200 OK" &&
> +	git rev-parse newbranch >act.head &&
> +	echo "$hash_next" >exp.head &&
> +	test_cmp act.head exp.head
> +'
> +
> +test_expect_success 'push plain truncated' '
> +	test_http_env receive \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.trunc git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success 'push plain empty' '
> +	test_http_env receive \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success GZIP 'push gzipped' '
> +	test_when_finished "git branch -D newbranch" &&
> +	test_http_env receive \
> +		HTTP_CONTENT_ENCODING="gzip" \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.gz git http-backend >act.out 2>act.err &&
> +	verify_http_result "200 OK" &&
> +	git rev-parse newbranch >act.head &&
> +	echo "$hash_next" >exp.head &&
> +	test_cmp act.head exp.head
> +'
> +
> +test_expect_success GZIP 'push gzipped truncated' '
> +	test_http_env receive \
> +		HTTP_CONTENT_ENCODING="gzip" \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.gz.trunc git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success GZIP 'push gzipped empty' '
> +	test_http_env receive \
> +		HTTP_CONTENT_ENCODING="gzip" \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
> +	! verify_http_result "200 OK"
> +'
> +
> +test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
> +	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
> +	env \
> +		CONTENT_TYPE=application/x-git-upload-pack-request \
> +		QUERY_STRING=/repo.git/git-upload-pack \
> +		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
> +		GIT_HTTP_EXPORT_ALL=TRUE \
> +		REQUEST_METHOD=POST \
> +		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> +		git http-backend </dev/zero >/dev/null 2>err &&
> +	grep "fatal:.*CONTENT_LENGTH" err
> +'
> +
> +test_done
> diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
> new file mode 100755
> index 0000000000..6c2aae7692
> --- /dev/null
> +++ b/t/t5562/invoke-with-content-length.pl
> @@ -0,0 +1,37 @@
> +#!/usr/bin/perl
> +use 5.008;
> +use strict;
> +use warnings;
> +
> +my $body_filename = $ARGV[0];
> +my @command = @ARGV[1 .. $#ARGV];
> +
> +# read data
> +my $body_size = -s $body_filename;
> +$ENV{"CONTENT_LENGTH"} = $body_size;
> +open(my $body_fh, "<", $body_filename) or die "Cannot open $body_filename: $!";
> +my $body_data;
> +defined read($body_fh, $body_data, $body_size) or die "Cannot read $body_filename: $!";
> +close($body_fh);
> +
> +my $exited = 0;
> +$SIG{"CHLD"} = sub {
> +        $exited = 1;
> +};
> +
> +# write data
> +my $pid = open(my $out, "|-", @command);
> +{
> +        # disable buffering at $out
> +        my $old_selected = select;
> +        select $out;
> +        $| = 1;
> +        select $old_selected;
> +}
> +print $out $body_data or die "Cannot write data: $!";
> +
> +sleep 60; # is interrupted by SIGCHLD
> +if (!$exited) {
> +        close($out);
> +        die "Command did not exit after reading whole body";
> +}
> -- 
> 2.17.0.1185.g782057d875
> 
> 
