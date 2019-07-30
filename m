Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04A41F462
	for <e@80x24.org>; Tue, 30 Jul 2019 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfG3VwP (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 17:52:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39828 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfG3VwO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 17:52:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so30739321pgi.6
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hv8lRWv35QAqhOfgIKapMXOzQHgpfNx+yvhcM/mq3ns=;
        b=iHnWW26OVBsjh1NJe9FHB2bOW1zOAvcApc0ZxSLRPJB77sxX5jVFFdJLwcOGOnjwEt
         ETjLLn4e/zI6b9xx9vt6C8lQCOWk243brTJbyR4BRajWmL8bZrrB3Wzwy7TSv3v8SZka
         mEFfDwuqOCuUaNLEenKtXkQgMS3KgGLqucoMAUdQvAiKLEnyVQyblrZjxKw9Kg77mV2c
         kROESc/SvxDBAVSf8wukf7Ovsriz//yr2+3V8CibNK+kB6g4MfkoXdTL/4WZdVlUHr7+
         BFOcfVmUW20InJGiE9InegBKpYiG2EG/XCLPp6ls4JtyTRYkHBm3d37u3k0kqGfZwIPf
         C6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Hv8lRWv35QAqhOfgIKapMXOzQHgpfNx+yvhcM/mq3ns=;
        b=iar7Xa/emoEOyJlPhO9eVCY1uSQy3Yg981GcPRmcGJK4BwWDMqi4R8WVriL7vw1DLi
         VRQ7Pacz4dYXbydqTGMWyM1Qz+rK3luhPQkVtCLkic21/NWErkLBrndAnt4LLVr7WoqF
         bFMtPXyzYpCgtznQrm0f7Y9G2eZn9A1SHBtYl9eLAoBfxnwyaXPyAa3TFX4/9SLJF6KI
         ZvM7Zv4lEpAnIxNbo4b2BWI2TiI6G6tfZS9CAvNgyrINegQftqLvYV9x38JaJy+syH7t
         VE6a0RbJlfOSePgq3G9EBMaGJArWemkwCdschb71FEjl0e69AhYI1ahwWgtx5M/ZcH6x
         leoA==
X-Gm-Message-State: APjAAAWEXy3CRBDt3YLWDIrK6tIDkIztK18h8qvzppvYBhUrzamD9UYO
        z5nGkRSHi1Dbte3rk3n8WtxobER551USAw==
X-Google-Smtp-Source: APXvYqx9UXF6zkd4EXfR7Cnl9vjOHbE3mGT/K3XivqwXL+aq+8FQicEShFXhB10b4feEOp82rJKrRg==
X-Received: by 2002:a63:904:: with SMTP id 4mr38016714pgj.19.1564523533343;
        Tue, 30 Jul 2019 14:52:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id q8sm132449511pjq.20.2019.07.30.14.52.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:52:12 -0700 (PDT)
Date:   Tue, 30 Jul 2019 14:52:07 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] trace2: don't overload target directories
Message-ID: <20190730215207.GK43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <774bc2e2-2081-9969-f5d8-72231a9f7835@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774bc2e2-2081-9969-f5d8-72231a9f7835@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.30 09:29, Derrick Stolee wrote:
> On 7/29/2019 6:20 PM, Josh Steadmon wrote:
> > trace2 can write files into a target directory. With heavy usage, this
> > directory can fill up with files, causing difficulty for
> > trace-processing systems.
> > 
> > When trace2 would write a file to a target directory, first check
> > whether or not the directory is overloaded. A directory is overloaded if
> > there is a sentinel file declaring an overload, or if the number of
> > files exceeds a threshold. If the latter, create a sentinel file to
> > speed up later overload checks.
> > 
> > The file count threshold is currently set to 1M files, but this can be
> > overridden for testing with GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT.
> 
> 1 million seems like a LOT, and the environment variable seems to be only
> for testing.
> 
> * If the variable is only for testing, then it should start with GIT_TEST_
> 
> * Are we sure 1 million is the right number? I would imagine even 10,000
>   starting to be a problem. How would a user adjust this value if they
>   are having problems before 1,000,000?

Yeah. I think we've only had reports of trouble starting around 5
million files. This definitely feels more like a config variable, but on
the other hand I thought there was some resistance towards adding the
somewhat special early-initialization trace config variables. So for the
first revision I figured I'd just throw out a constant and see if there
were any objections.

If people feel like it's OK to add this to the early trace2 config
options, then I'd be happy to do that in V2.

> > The assumption is that a separate trace-processing system is dealing
> > with the generated traces; once it processes and removes the sentinel
> > file, it should be safe to generate new trace files again.
> 
> This matches the model that you (Google) are using for collecting logs.
> I'll trust your expertise here in how backed up these logs become. I
> imagine that someone working without a network connection for a long
> time would be likely to run into this problem.
>
> [snip]
> 
> > +test_expect_success "don't overload target directory" '
> > +	GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT=100 &&
> 
> For testing, does this need to be 100? Could it be 5?

Sure, changed to 5 in V2.


> > +	export GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT &&
> 
> To avoid leakage to other (future) tests, should these be in a subshell?

Yes, thanks for the catch. Fixed in V2.


> > +	test_when_finished "rm -r trace_target_dir" &&
> > +	mkdir trace_target_dir &&
> > +	test_seq $GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT | sed "s#^#trace_target_dir/#" | sort > expected_filenames.txt &&
> > +	xargs touch < expected_filenames.txt &&
> 
> nit: no space between redirection and filename.

Fixed in V2.


> > +	ls trace_target_dir | sed "s#^#trace_target_dir/#" > first_ls_output.txt &&
> > +	test_cmp expected_filenames.txt first_ls_output.txt &&
> > +	GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0 &&
> > +	echo "trace_target_dir/git-trace2-overload" >> expected_filenames.txt &&
> > +	ls trace_target_dir | sed "s#^#trace_target_dir/#" > second_ls_output.txt &&
> > +	test_cmp expected_filenames.txt second_ls_output.txt
> > +'
> 
> [snip]
> 
> > +/*
> > + * Check to make sure we're not overloading the target directory with too many
> > + * files. First check for the presence of a sentinel file, then check file
> > + * count. If we are overloaded, create the sentinel file if it doesn't already
> > + * exist.
> > + *
> > + * We expect that some trace processing system is gradually collecting files
> > + * from the target directory; after it removes the sentinel file we'll start
> > + * writing traces again.
> > + */
> > +static int tr2_dst_overloaded(const char *tgt_prefix)
> > +{
> > +	int file_count = 0, overload_file_count = 0;
> > +	char *test_threshold_val;
> > +	DIR *dirp;
> > +	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
> > +	struct stat statbuf;
> > +
> > +	strbuf_addstr(&path, tgt_prefix);
> > +	if (!is_dir_sep(path.buf[path.len - 1])) {
> > +		strbuf_addch(&path, '/');
> > +	}
> > +
> > +	/* check sentinel */
> > +	strbuf_addstr(&sentinel_path, path.buf);
> > +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
> > +	if (!stat(sentinel_path.buf, &statbuf)) {
> > +		strbuf_release(&path);
> > +		return 1;
> > +	}
> > +
> > +	/* check if we're overriding the threshold (e.g., for testing) */
> > +	test_threshold_val = getenv("GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT");
> > +	if (test_threshold_val)
> > +		overload_file_count = atoi(test_threshold_val);
> > +	if (overload_file_count <= 0)
> > +		overload_file_count = OVERLOAD_FILE_COUNT;
> > +
> > +
> > +	/* check file count */
> > +	dirp = opendir(path.buf);
> > +	while (file_count < overload_file_count && dirp && readdir(dirp))
> > +		file_count++;
> > +	if (dirp)
> > +		closedir(dirp);
> > +
> > +	if (file_count >= overload_file_count) {
> > +		creat(sentinel_path.buf, S_IRUSR | S_IWUSR);
> > +		/* TODO: Write a target-specific message? */
> 
> Perhaps leave the TODO out of the code? I did see it in your commit message.

Fixed in V2.


> > +		strbuf_release(&path);
> > +		return 1;
> > +	}
> > +
> > +	strbuf_release(&path);
> > +	return 0;
> > +}
> > +
> >  static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> >  {
> >  	int fd;
> > @@ -50,6 +121,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> >  	strbuf_addstr(&path, sid);
> >  	base_path_len = path.len;
> >  
> > +	if (tr2_dst_overloaded(tgt_prefix)) {
> > +		strbuf_release(&path);
> > +		if (tr2_dst_want_warning())
> > +			warning("trace2: not opening %s trace file due to too "
> > +				"many files in target directory %s",
> > +				tr2_sysenv_display_name(dst->sysenv_var),
> > +				tgt_prefix);
> > +		return 0;
> > +	}
> > +
> >  	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
> >  		if (attempt_count > 0) {
> >  			strbuf_setlen(&path, base_path_len);
> > 
> 
> Overall, this looks correct and the test is very clear. Seems to be a helpful feature!
> 
> I only have the nits mentioned above.

Thanks for the review!
