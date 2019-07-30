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
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE9D1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 22:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfG3WCG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 18:02:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38610 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfG3WCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 18:02:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so29403247plb.5
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dw3+PCfERjGQwFsU1BTY+zMjj+Opm3NV77eoT9q3/LU=;
        b=Pyi42Kgth4QA66XKq+eWhNSUl49yHafAZMEDB+H4A2J5D7rW+LVnarUhnvqZFWaRW0
         Cha8iNKhdnAspImiZgXzLgFFeDowEHgAhHViiH/9ITkU/qnspdAMmeXG6bFH8fZxelme
         vp9e2S5CKKfpU4MWSLHqeipZgi0tKqNHXN7srH4fA4sMoQkQZFndfJOyk6TxKaU1L4df
         uZh6jcDw0am4k5CM62R0VCmLjg69bZRn49dvvpiD0C3JSdC5F1NyIQYwG4tlcfcr8EzY
         /BEAfNJT1NDOcjvm2gY9WF9uZIdAc8xXSaLpnaqi2CU2yX0gUG7YT7Z2FykHxKKH8kcN
         DPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Dw3+PCfERjGQwFsU1BTY+zMjj+Opm3NV77eoT9q3/LU=;
        b=n2++ZNwMmY/C14RhNWj45LulYiZsyWC0tyLEmAbJRvfq62CGjVgEtYTk6/Yf5wcAGz
         NDOYrNigSK8oUK7hGcnax3NX13fufXosFrjC+eHCO7ykZgKFmkOHpsEZZ5DcFJwXmeVk
         gwxl70jy/xVjK5pdtFNpO3fXGm+EaOW3JXAnRB+/HYp8wrZtWdRCQyZbI1w1R7fGhg84
         KY+K2XcmJBXfrAJL60WMOI6g8jYU2l3gcZbz4hXGax8o/YcOnASQ79+MZXn04VV2VhuD
         FC3CUtvKSiklEnnI2+reIKpqfcDrRnQ8NY7rRxCo5ynWlCQdZ9l9hHp7ZXT6FlxJ9OZz
         +Cxg==
X-Gm-Message-State: APjAAAWBG3MAggaL84JmhA9LIC9zaS8DD8gr/LdIg+U7NDNRrRoiydx7
        yMdy1km3C94nKGssNK6L92go+wJpnAahQQ==
X-Google-Smtp-Source: APXvYqwgmcGoF/xu4JS5fHqlNZ+HQYdQSWpuyj/JUhoIebY6ZfE/nkF3oMVbPMkanWgsItj/+9xPuA==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr116904473plt.102.1564524124471;
        Tue, 30 Jul 2019 15:02:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id j20sm63227043pfr.113.2019.07.30.15.02.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:02:03 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:01:58 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] trace2: don't overload target directories
Message-ID: <20190730220158.GL43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <8612596d-1dfe-1b8e-9e01-c091e43c0556@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8612596d-1dfe-1b8e-9e01-c091e43c0556@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.30 12:46, Jeff Hostetler wrote:
> 
> 
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
> 
> Something about this idea bothers me, but I can't quite put my finger
> on it.  You're filling a directory with thousands of files while
> (hopefully simultaneously) having a post-processor/aggregator app
> read and delete them.  I understand that if the aggregator falls
> behind or isn't running, the files will just accumulate and that the
> total number of files is the problem.  But I have to wonder if
> contention on that directory is going to be a bottleneck and/or
> a source of problems.  That is, you'll have one process reading and
> deleting and one or more Git processes scanning/counting/creating.
> It seems like there might be opportunity for some kinds of races
> here.

Yeah, this probably deserves some performance testing. I'll see what I
can arrange prior to sending out V2. I don't think that racing issue is
that big a deal, as there's not a ton of difference if we stop tracing
after (say) 10**6 - 100 files vs 10**6 + 100 or whatever. But contention
from multiple processes could definitely slow things down.


> It have to wonder if it would be better to do some kind of directory
> rotation rather than create a marker file.
> 
> Alternatively, I think it would be better to not have the marker
> file be inside the directory, but rather have a lock file somewhere
> to temporarily disable tracing.  Then your stat() call would not need
> to effectively search the large directory.  Maybe make this
> "<dirname>.lock" as a peer to "<dirname>/", for example.

Yeah, this would make the stat() faster. But we'd have to add logic
either to git or to the collection system to clean up the .lock files
after we empty out the target directory. I'll have to think about this
and see if the collection team is open to this.


> > The file count threshold is currently set to 1M files, but this can be
> > overridden for testing with GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT.
> > 
> > The assumption is that a separate trace-processing system is dealing
> > with the generated traces; once it processes and removes the sentinel
> > file, it should be safe to generate new trace files again.
> > 
> > Potential future work:
> > * Write a message into the sentinel file (should match the requested
> >    trace2 output format).
> > * Make the overload threshold (and the whole overload feature)
> >    configurable.
> 
> I'm wondering if we should just make this setting another
> value in `tr2_sysenv_settings[]` rather than a *_TEST_* env var.
> 
> That would give you both env and system/global config support,
> since I'm assuming you'd eventually want to have this be in
> the user's global config with the other trace2 settings.
> 
> All of your tests could be expressed in terms of this new setting
> and we wouldn't need this new test env var.

I do think this makes more sense as a config variable, but as I
mentioned in my reply to Stolee, my impression was that we were somewhat
hesitant to add new trace config variables if they have to go through
the special early config initialization. If that impression is wrong
I'll add the config var.

> > 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >   t/t0210-trace2-normal.sh | 15 ++++++++
> >   trace2/tr2_dst.c         | 81 ++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 96 insertions(+)
> > 
> > diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> > index ce7574edb1..e8a03e9212 100755
> > --- a/t/t0210-trace2-normal.sh
> > +++ b/t/t0210-trace2-normal.sh
> > @@ -186,4 +186,19 @@ test_expect_success 'using global config with include' '
> >   	test_cmp expect actual
> >   '
> > +test_expect_success "don't overload target directory" '
> > +	GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT=100 &&
> > +	export GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT &&
> > +	test_when_finished "rm -r trace_target_dir" &&
> > +	mkdir trace_target_dir &&
> > +	test_seq $GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT | sed "s#^#trace_target_dir/#" | sort > expected_filenames.txt &&
> > +	xargs touch < expected_filenames.txt &&
> > +	ls trace_target_dir | sed "s#^#trace_target_dir/#" > first_ls_output.txt &&
> > +	test_cmp expected_filenames.txt first_ls_output.txt &&
> > +	GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0 &&
> > +	echo "trace_target_dir/git-trace2-overload" >> expected_filenames.txt &&
> > +	ls trace_target_dir | sed "s#^#trace_target_dir/#" > second_ls_output.txt &&
> > +	test_cmp expected_filenames.txt second_ls_output.txt
> > +'
> > +
> >   test_done
> > diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> > index 5dda0ca1cd..3286297918 100644
> > --- a/trace2/tr2_dst.c
> > +++ b/trace2/tr2_dst.c
> > @@ -1,3 +1,5 @@
> > +#include <dirent.h>
> > +
> >   #include "cache.h"
> >   #include "trace2/tr2_dst.h"
> >   #include "trace2/tr2_sid.h"
> > @@ -8,6 +10,18 @@
> >    */
> >   #define MAX_AUTO_ATTEMPTS 10
> > +/*
> > + * Sentinel file used to detect when we're overloading a directory with too many
> > + * trace files.
> > + */
> > +#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
> > +
> > +/*
> > + * How many files we can write to a directory before entering overload mode.
> > + * This can be overridden with the envvar GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT
> > + */
> > +#define OVERLOAD_FILE_COUNT 1000000
> > +
> >   static int tr2_dst_want_warning(void)
> >   {
> >   	static int tr2env_dst_debug = -1;
> > @@ -32,6 +46,63 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
> >   	dst->need_close = 0;
> >   }
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
> 
> Also release sentinel_path ?
> (And in both of the return statements below.)
> 
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
> > +		strbuf_release(&path);
> > +		return 1;
> > +	}
> > +
> > +	strbuf_release(&path);
> > +	return 0;
> > +}
> > +
> >   static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> >   {
> >   	int fd;
> > @@ -50,6 +121,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> >   	strbuf_addstr(&path, sid);
> >   	base_path_len = path.len;
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
> >   	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
> >   		if (attempt_count > 0) {
> >   			strbuf_setlen(&path, base_path_len);
> > 
> 
> hope this helps,
> Jeff
> 
