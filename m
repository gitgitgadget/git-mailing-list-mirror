Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E01B1FD4F
	for <e@80x24.org>; Wed, 30 May 2018 16:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeE3QHo (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:07:44 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34374 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeE3QHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:07:42 -0400
Received: by mail-qk0-f193.google.com with SMTP id q70-v6so6154374qke.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+U3VN1MUevV1bNG5jxjr8lBy2WrdoTn8L/Z9niZEY6E=;
        b=XR2u6Nrzppb3XzIjeASzax86gPbF9vnczdW3aP9ltp4ExjI1/6PJG4SnXKEqkhMpVU
         WRGGKmFCyyfszvoihd2Xzbk2Ve+4AeugfyM0IIJw4MYERs9RgCgjjwnTwY4aUBIva+VI
         oym+zXuaU2wMzJYy+ZcQjGA12iTVqFUqYU7L9OX5zW97gS7E1PC2HSWiDMr4MVmghIze
         ndhte4CMd2PCdEomRXbqX9ONrSFuqv/N3zMFLCKMOcsNjGq5lPQsafmh4qXlJcXc9YaS
         x+kYlCe9/mgUrxox0VU7TO6r54n+NeJP7NWl1Lf7951iA9qd7Nqiygzr7+cHNUiuE1EH
         Kc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+U3VN1MUevV1bNG5jxjr8lBy2WrdoTn8L/Z9niZEY6E=;
        b=HdFVMlZfGnYcZixxCOEFs2XEJhBJ5j4SE0D3VnKYYQpnhHPw0S6sB9HQYKozJ1nDXh
         mp3qrMDgAzuMsXnMGW5DFBCOm5VFz/UcAyifloJHrGjDcBvNujGkH8Rr3JFkTHrVB5WK
         hqJgkCz5i/jq8i7Xx7eyAjo2iFxkw1DvxixkDJw+E9qMOoY0loPBfRsg7Hxdg5BFFlO5
         6SEkv/ZAQSYsrzIk6u9sMT3zsLaNolrbw5B6dI9UNUYRRGyuMsSbapO2/geUbibrHioz
         aHNvF9TxMFUo+d2FUc7rKaZfkAid5s1jGwNTVNF2pqhO5PbKpp11yyNasTO/Wd+xbV+w
         qe9g==
X-Gm-Message-State: APt69E11g70dzNGrCfJ76sPWugfkW/f3q0liFUSHSz9sjeuMCHnqiMuv
        1RJW2klAAB/lN3JmSV99ruQ=
X-Google-Smtp-Source: ADUXVKKIL9avndsocAYgrijYjf6dkkGi06mlIAKQdi3tNVSfiFQB6jT74AGrY2rKVSuAMSaCemTOCQ==
X-Received: by 2002:a37:8f84:: with SMTP id r126-v6mr2853194qkd.8.1527696461211;
        Wed, 30 May 2018 09:07:41 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id n79-v6sm11506811qkn.84.2018.05.30.09.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 09:07:40 -0700 (PDT)
Subject: Re: [PATCH v3 06/20] commit-graph: add 'verify' subcommand
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-7-dstolee@microsoft.com> <86y3g4yahm.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4343f593-5650-3b24-54ec-a0d97d5251e9@gmail.com>
Date:   Wed, 30 May 2018 12:07:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <86y3g4yahm.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2018 6:55 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> If the commit-graph file becomes corrupt, we need a way to verify
>> that its contents match the object database. In the manner of
>> 'git fsck' we will implement a 'git commit-graph verify' subcommand
>> to report all issues with the file.
>>
>> Add the 'verify' subcommand to the 'commit-graph' builtin and its
>> documentation. The subcommand is currently a no-op except for
>> loading the commit-graph into memory, which may trigger run-time
>> errors that would be caught by normal use.
> So this commit is simply getting the boilerplate out of the way for
> implementing 'git commit-graph verify' subcommand.  Good.
>
>>                                             Add a simple test that
>> ensures the command returns a zero error code.
> Nice.
>
>> If no commit-graph file exists, this is an acceptable state. Do
>> not report any errors.
> All right.  I assume that as it is explicit verification call, it does
> ignore core.commitGraph setting, isn't it?
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-commit-graph.txt |  6 ++++++
>>   builtin/commit-graph.c             | 38 ++++++++++++++++++++++++++++++++++++++
>>   commit-graph.c                     | 26 ++++++++++++++++++++++++++
>>   commit-graph.h                     |  2 ++
>>   t/t5318-commit-graph.sh            | 10 ++++++++++
>>   5 files changed, 82 insertions(+)
>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index 4c97b555cc..a222cfab08 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -10,6 +10,7 @@ SYNOPSIS
>>   --------
>>   [verse]
>>   'git commit-graph read' [--object-dir <dir>]
>> +'git commit-graph verify' [--object-dir <dir>]
>>   'git commit-graph write' <options> [--object-dir <dir>]
> In alphabetical order, good.
>
>>   
>>   
>> @@ -52,6 +53,11 @@ existing commit-graph file.
>>   Read a graph file given by the commit-graph file and output basic
>>   details about the graph file. Used for debugging purposes.
>>   
>> +'verify'::
>> +
>> +Read the commit-graph file and verify its contents against the object
>> +database. Used to check for corrupted data.
>> +
> All right, good enough description.
>
>>   
>>   EXAMPLES
>>   --------
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index f0875b8bf3..0433dd6e20 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -8,10 +8,16 @@
>>   static char const * const builtin_commit_graph_usage[] = {
>>   	N_("git commit-graph [--object-dir <objdir>]"),
>>   	N_("git commit-graph read [--object-dir <objdir>]"),
>> +	N_("git commit-graph verify [--object-dir <objdir>]"),
>>   	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
>>   	NULL
>>   };
> In alphabetical order, same as in the manpage for git-commit-graph.
>
>>   
>> +static const char * const builtin_commit_graph_verify_usage[] = {
>> +	N_("git commit-graph verify [--object-dir <objdir>]"),
>> +	NULL
>> +};
>> +
>>   static const char * const builtin_commit_graph_read_usage[] = {
>>   	N_("git commit-graph read [--object-dir <objdir>]"),
>>   	NULL
>> @@ -29,6 +35,36 @@ static struct opts_commit_graph {
>>   	int append;
>>   } opts;
>>   
>> +
>> +static int graph_verify(int argc, const char **argv)
>> +{
>> +	struct commit_graph *graph = 0;
>> +	char *graph_name;
>> +
>> +	static struct option builtin_commit_graph_verify_options[] = {
>> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> +			   N_("dir"),
>> +			   N_("The object directory to store the graph")),
>> +		OPT_END(),
>> +	};
>> +
>> +	argc = parse_options(argc, argv, NULL,
>> +			     builtin_commit_graph_verify_options,
>> +			     builtin_commit_graph_verify_usage, 0);
>> +
>> +	if (!opts.obj_dir)
>> +		opts.obj_dir = get_object_directory();
> Getting the boilerplate of implementing the command mostly out of the
> way.  Good.
>
>> +
>> +	graph_name = get_commit_graph_filename(opts.obj_dir);
>> +	graph = load_commit_graph_one(graph_name);
> So we are verifying only the commit-graph file belonging directly to
> current repository, as I have expected.  This is needed to for warnings
> and error messages from the 'verify' action, to be able to tell in which
> file there are problems.
>
> This means that it is possible that there would be problems with
> commit-graph files that running 'git commit-graph verify' would not
> find, because they are in commit-graph file in one of the alternates.
>
> It is very easy, though, to check all commit-graph files that would be
> read and its data concatenated when using commit-graph feature
> (e.g. 'git commit-graph read', IIRC):
>
>    $ git commit-graph verify
>    $ for obj_dir in $(cat .git/objects/info/alternates) do;
>          git commit-graph --object-dir="$obj_dir";
>      done
>
> Note: I have not checked the above that it works.
>
>> +	FREE_AND_NULL(graph_name);
> Freeing the resources, always nice to have.
>
>> +
>> +	if (!graph)
>> +		return 0;
> DS> If no commit-graph file exists, this is an acceptable state. Do
> DS> not report any errors.
>
> Right, non existant commit-graph file is certainly valid ;-)
>
>> +
>> +	return verify_commit_graph(graph);
>> +}
> I guess that graph_verify() would not change much, if at all, in
> subsequent commits in this patch series.
>
>> +
>>   static int graph_read(int argc, const char **argv)
>>   {
>>   	struct commit_graph *graph = NULL;
>> @@ -163,6 +199,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>>   			     PARSE_OPT_STOP_AT_NON_OPTION);
>>   
>>   	if (argc > 0) {
>> +		if (!strcmp(argv[0], "verify"))
>> +			return graph_verify(argc, argv);
>>   		if (!strcmp(argv[0], "read"))
>>   			return graph_read(argc, argv);
>>   		if (!strcmp(argv[0], "write"))
> Not in alphabetical order... is there a reason for that?
This will be fixed in v4.
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 25893ec096..55b41664ee 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -836,3 +836,29 @@ void write_commit_graph(const char *obj_dir,
>>   	oids.alloc = 0;
>>   	oids.nr = 0;
>>   }
>> +
>> +static int verify_commit_graph_error;
>> +
>> +static void graph_report(const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +	struct strbuf sb = STRBUF_INIT;
>> +	verify_commit_graph_error = 1;
>> +
>> +	va_start(ap, fmt);
>> +	strbuf_vaddf(&sb, fmt, ap);
>> +
>> +	fprintf(stderr, "%s\n", sb.buf);
>> +	strbuf_release(&sb);
>> +	va_end(ap);
> Why do you use strbuf_vaddf + fprintf instead of straighforward
> vfprintf (or function instead of variable-level macro)?
>
> Is it because of [string] safety?

It's because I've never used this variable-parameter thing before and 
found a different example.

I'll use vfprintf() in v4, as it is simpler.


>> +}
>> +
>> +int verify_commit_graph(struct commit_graph *g)
>> +{
>> +	if (!g) {
>> +		graph_report("no commit-graph file loaded");
>> +		return 1;
>> +	}
> All right, this is just a placeholder - we should not ever get this
> message because in this case we exit with error code of 0 (EXIT_SUCCESS)
> if there is no commit-graph file loaded before invoking
> verify_commit_graph().
>
>> +
>> +	return verify_commit_graph_error;
> All right, this is for the future.  Good.
>
>> +}
>> diff --git a/commit-graph.h b/commit-graph.h
>> index 96cccb10f3..71a39c5a57 100644
>> --- a/commit-graph.h
>> +++ b/commit-graph.h
>> @@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
>>   			int nr_commits,
>>   			int append);
>>   
>> +int verify_commit_graph(struct commit_graph *g);
>> +
> Why does this need to be exported?  I think it is not used outside of
> commit-graph.c, isn't it?

Used by builtin/commit-graph.c


>
>>   #endif
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 77d85aefe7..6ca451dfd2 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -11,6 +11,11 @@ test_expect_success 'setup full repo' '
>>   	objdir=".git/objects"
>>   '
>>   
>> +test_expect_success 'verify graph with no graph file' '
>> +	cd "$TRASH_DIRECTORY/full" &&
> Is sich bare `cd`, without corresponding `cd` back or using subshell
> safe?
>
>> +	git commit-graph verify
>> +'
>> +
>>   test_expect_success 'write graph with no packs' '
>>   	cd "$TRASH_DIRECTORY/full" &&
>>   	git commit-graph write --object-dir . &&
>> @@ -230,4 +235,9 @@ test_expect_success 'perform fast-forward merge in full repo' '
>>   	test_cmp expect output
>>   '
>>   
>> +test_expect_success 'git commit-graph verify' '
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	git commit-graph verify >output
>> +'
> Those are tests with nearly the same code, but they are (by their
> descriptions) testing different things.  This means that they rely on
> side effects of earlier tests.
>
> This is suboptimal, as it means that it would be impossible or very
> difficult to run individual tests (e.g. with GIT_SKIP_TESTS environment
> variable, or with an individual test suite --run option), unless you
> know which tests setup the repository state for later tests.
>
> It also means that running only failed tests with prove
> --state=failed,save or equivalently with
>
>    $ make DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS='--state=failed,save' test
>
> wouldn't work correctly.
>
> As Johannes Schindelin (alias Dscho) said in latest Git Rev News
> interview: https://git.github.io/rev_news/2018/05/16/edition-39/
>
> JS> We have a test suite where debugging a regression may mean that you
> JS> have to run 98 test cases before the failing one every single time in
> JS> the edit/compile/debug cycle, because the 99th test case may depend on
> JS> a side effect of at least one of the preceding test cases. Git’s test
> JS> suite is so not [21st century best practices][1].
> JS>
> JS> [1]: https://www.slideshare.net/BuckHodges/lessons-learned-doing-devops-at-scale-at-microsoft
>
>
> I think can be solved quite efficiently by creating and using shell
> function, or two shell functions, which would either:
>
>   * rename commit-graph file to some other temporary name if it exists,
>     and move it back after the test.
>   * create commit-graph file if it does not exist.
>
> For example (untested):
>
>    prepare_no_commit_graph() {
>    	mv .git/info/commit-graph .git/info/commit-graph.away &&
>    	test_when_finished "mv .git/info/commit-graph.away .git/info/commit-graph"
>    }
>
>    prepare_commit_graph() {
>    	if ! test -f ".git/info/commit-graph"
>    	then
>    		git commit-graph write
>    	fi
>    }
>
> Or something like that.

Do we have a way to run individual steps of the test suite? I am unfamiliar with that process.

Adding the complexity of storing a copy of the commit-graph file for re-use in a later test is wasted energy right now, because we need to run the steps of the test that create the repo shape with the commits laid out as set earlier in the test. This shape changes as we test different states of the commit-graph (exists and contains all commits, exists and doesn't contain all commits, etc.)

Thanks,
-Stolee

