Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F70D1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfG3N3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 09:29:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37342 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfG3N3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 09:29:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so46552408qkl.4
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RK2W7ZY+lLLNNblpD1Ev2N35ptU3umnuaklmufTO1Js=;
        b=TjapU+1cViwEAB1ud8KGD6DpDASb2Zu2HVG+fNQQTO3Ui86WNuwqryN/xWMQwWVQt7
         EanmHdupq6ml/pNYjMObTOQ/YztQV4g/zovJ0yFNLADw+nbElIJR7VHAh3QDLu8GPQNi
         bHLCzpNUipHuB6b3zYeBB3hw7jXSU6NyuFUx2egOJFKKS7QBGedTmio4NYti9N3bzrAA
         546lK0MK3VwCkgKS0EQoFDppx+uIUBvU9D7zfR4iJaZVuDvutJqaDMuoc+udwGQmOMCQ
         f4rZRt2J1c0W0WTqbPmvcgTl/tHCf139uQyyX6pf26olynfTYEBHXB3O47h4pGwlld7a
         731Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RK2W7ZY+lLLNNblpD1Ev2N35ptU3umnuaklmufTO1Js=;
        b=j1GVf68tiuCY0EJJwEIB7smM4l4k5mCQAJ9aIEAANLJ8JpYbeSwk+Z4RHWQZSg9sgY
         YZGxK2xNL6h32C65M00uVt1kQR+txUX8oDrb0RZX9s9BFZpYPyDcvYcMjJCBn429N3ZM
         QzMNoCcSyQ4EkaR6ZgXFgbT86Xg0V8eQa0qnoGE4r3194L/zdVnRicCEOOX/BLt0AZOI
         j0n5+0P/WVL/bbbUhsArzZZstSEao6zUeKOWmggDTBusiTiKBZ7rIamRpUfFOUFubEbC
         T42e/Qckf0RqsuhXra5OLqnsDC3x0LtkZgCfQqipo3KRJhwFu2NSZz7w4xOh9iEa/rq9
         8pKg==
X-Gm-Message-State: APjAAAXWMewQ6ekrBPAq8FQ5QiwIegV86p9idna3DBdWMLts6f3rtben
        j7UeJ97aSwCbejae45SW0h/ty5ZY
X-Google-Smtp-Source: APXvYqxs8bI5cyOKG9swkj3uw8nwGn3PXAg6yUpptF0akQpSTatx3WA+Ra8M6jSI+y8Bz+5MpsCHJw==
X-Received: by 2002:a37:aa0d:: with SMTP id t13mr81024874qke.167.1564493388119;
        Tue, 30 Jul 2019 06:29:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9049:226e:5210:8681? ([2001:4898:a800:1010:417f:226e:5210:8681])
        by smtp.gmail.com with ESMTPSA id c5sm39754786qta.5.2019.07.30.06.29.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 06:29:47 -0700 (PDT)
Subject: Re: [RFC PATCH] trace2: don't overload target directories
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <774bc2e2-2081-9969-f5d8-72231a9f7835@gmail.com>
Date:   Tue, 30 Jul 2019 09:29:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/29/2019 6:20 PM, Josh Steadmon wrote:
> trace2 can write files into a target directory. With heavy usage, this
> directory can fill up with files, causing difficulty for
> trace-processing systems.
> 
> When trace2 would write a file to a target directory, first check
> whether or not the directory is overloaded. A directory is overloaded if
> there is a sentinel file declaring an overload, or if the number of
> files exceeds a threshold. If the latter, create a sentinel file to
> speed up later overload checks.
> 
> The file count threshold is currently set to 1M files, but this can be
> overridden for testing with GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT.

1 million seems like a LOT, and the environment variable seems to be only
for testing.

* If the variable is only for testing, then it should start with GIT_TEST_

* Are we sure 1 million is the right number? I would imagine even 10,000
  starting to be a problem. How would a user adjust this value if they
  are having problems before 1,000,000?

> The assumption is that a separate trace-processing system is dealing
> with the generated traces; once it processes and removes the sentinel
> file, it should be safe to generate new trace files again.

This matches the model that you (Google) are using for collecting logs.
I'll trust your expertise here in how backed up these logs become. I
imagine that someone working without a network connection for a long
time would be likely to run into this problem.

[snip]

> +test_expect_success "don't overload target directory" '
> +	GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT=100 &&

For testing, does this need to be 100? Could it be 5?

> +	export GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT &&

To avoid leakage to other (future) tests, should these be in a subshell?

> +	test_when_finished "rm -r trace_target_dir" &&
> +	mkdir trace_target_dir &&
> +	test_seq $GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT | sed "s#^#trace_target_dir/#" | sort > expected_filenames.txt &&
> +	xargs touch < expected_filenames.txt &&

nit: no space between redirection and filename.

> +	ls trace_target_dir | sed "s#^#trace_target_dir/#" > first_ls_output.txt &&
> +	test_cmp expected_filenames.txt first_ls_output.txt &&
> +	GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0 &&
> +	echo "trace_target_dir/git-trace2-overload" >> expected_filenames.txt &&
> +	ls trace_target_dir | sed "s#^#trace_target_dir/#" > second_ls_output.txt &&
> +	test_cmp expected_filenames.txt second_ls_output.txt
> +'

[snip]

> +/*
> + * Check to make sure we're not overloading the target directory with too many
> + * files. First check for the presence of a sentinel file, then check file
> + * count. If we are overloaded, create the sentinel file if it doesn't already
> + * exist.
> + *
> + * We expect that some trace processing system is gradually collecting files
> + * from the target directory; after it removes the sentinel file we'll start
> + * writing traces again.
> + */
> +static int tr2_dst_overloaded(const char *tgt_prefix)
> +{
> +	int file_count = 0, overload_file_count = 0;
> +	char *test_threshold_val;
> +	DIR *dirp;
> +	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
> +	struct stat statbuf;
> +
> +	strbuf_addstr(&path, tgt_prefix);
> +	if (!is_dir_sep(path.buf[path.len - 1])) {
> +		strbuf_addch(&path, '/');
> +	}
> +
> +	/* check sentinel */
> +	strbuf_addstr(&sentinel_path, path.buf);
> +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
> +	if (!stat(sentinel_path.buf, &statbuf)) {
> +		strbuf_release(&path);
> +		return 1;
> +	}
> +
> +	/* check if we're overriding the threshold (e.g., for testing) */
> +	test_threshold_val = getenv("GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT");
> +	if (test_threshold_val)
> +		overload_file_count = atoi(test_threshold_val);
> +	if (overload_file_count <= 0)
> +		overload_file_count = OVERLOAD_FILE_COUNT;
> +
> +
> +	/* check file count */
> +	dirp = opendir(path.buf);
> +	while (file_count < overload_file_count && dirp && readdir(dirp))
> +		file_count++;
> +	if (dirp)
> +		closedir(dirp);
> +
> +	if (file_count >= overload_file_count) {
> +		creat(sentinel_path.buf, S_IRUSR | S_IWUSR);
> +		/* TODO: Write a target-specific message? */

Perhaps leave the TODO out of the code? I did see it in your commit message.

> +		strbuf_release(&path);
> +		return 1;
> +	}
> +
> +	strbuf_release(&path);
> +	return 0;
> +}
> +
>  static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
>  {
>  	int fd;
> @@ -50,6 +121,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
>  	strbuf_addstr(&path, sid);
>  	base_path_len = path.len;
>  
> +	if (tr2_dst_overloaded(tgt_prefix)) {
> +		strbuf_release(&path);
> +		if (tr2_dst_want_warning())
> +			warning("trace2: not opening %s trace file due to too "
> +				"many files in target directory %s",
> +				tr2_sysenv_display_name(dst->sysenv_var),
> +				tgt_prefix);
> +		return 0;
> +	}
> +
>  	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
>  		if (attempt_count > 0) {
>  			strbuf_setlen(&path, base_path_len);
> 

Overall, this looks correct and the test is very clear. Seems to be a helpful feature!

I only have the nits mentioned above.

Thanks!
-Stolee

