Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390A158535
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308844; cv=none; b=lDUx3UPVx+XpEuMFxHLZPSlTDak1EfQYfhNN+xFnhquYYLFY5NkCRg4MA4mnkume8OzCWrAp9j4RAf9XBUqYG3KxZ2RXL/Ybo8znCrcXk2SXZGOtnXmsN+bM4XmKBciP94QhaaLTp5XTDauVNXdggjZ9av9tVxRedjoBuBks3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308844; c=relaxed/simple;
	bh=l4w9ZWI3Xpi0QzFkQvZAgUVEkWF5NSg9eewQR04KULQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt4oumvRWyIigdlnwns3Tnxv+Y3HePONQah75hIwNJNIoeqLnzEoU0ZhXBWG7rNaXigxNQEJeHNzJ95VYiNxEpLTdqtXuisScEJzMDQJMOLRlKEUlRPo6ywUjHBsGTpGqm4HNIjacsSHc8HzXFc62OrcIHy6dzt3j3xWjgd16Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tsZ8c+HE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3MgS181; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tsZ8c+HE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3MgS181"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B6C7413805FF;
	Mon, 11 Nov 2024 02:07:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 02:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731308840; x=1731395240; bh=05OXv7n6Dk
	EJpfm4N/jA9PB1ZfkpEK+l7CLO7jsTvc0=; b=tsZ8c+HEcYa6Ah1SqfCoAdHYA/
	aqx1Fy6dLukBx+cQ/EsWyPWst1Bu+eCp5+kXkhDB+hQW5zzg7dyMv4Kr8riG89io
	xWF9tQBB3vBPqzx2i/59S6rg+wEO5oap3zU0TCc2YzAvyoqeXZao1ehFkDAXzOl1
	TZ7E2oNT0YkAPrPaZuOn+YiowsgQaX/z2L7gWPkssm5RmEua8P6H32fDuqDBsi8H
	NZ9KaCfE8LQxmdnvnJZa1yEVtWOxS6v/S+EFe5wV0bdRczxxdLpaN+Bhnc7svzxg
	GSdWNmSlxakl5R1IrGAoVMPXKwolYPsKMeghOwdxW6UiV4ftm6u4XzacZzpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731308840; x=1731395240; bh=05OXv7n6DkEJpfm4N/jA9PB1ZfkpEK+l7CL
	O7jsTvc0=; b=L3MgS181Ea5EPCS10jrkvM7GYFze6bt6eve6kkCSY+TvybTTL7x
	eekgWPBtMI8mz0PUtLTkKchvb+VO+2xmS/zcnO5raKOdKKsf9lVCMeiYAMhKpEYY
	9++ZUxOxD20kA07fnS9ptbgwmGbYltY3TpxPSohqlpR5SQ/igVanGovVq83juEpk
	qlPBv52jbSonhj0ue+qeNPo4YeVsMZ2y4Svhw+/US/EBcCabrfharOuUqgrJEzBw
	8jIJCj7kDOy9tADO0Z9KHSoNr/03JaeqVwuxGOguVX/CB3dyATQOn3lFQGOL7B4a
	dKj9UPck/GJubNIfGhdC4VHvSVhC14W5j1w==
X-ME-Sender: <xms:KK0xZy_Xd3K6nPHACQSlMDZKYyKFw8Mrb2ErhUIufJ5ry7Zkd4GehQ>
    <xme:KK0xZyv1pNFNpNXVPXJ4q0UmJMgiPzKo2kbW1NpeGTO3j9VbDX-FSR3xNBGvdfO2e
    MiyqUDxlL-BBnAsFg>
X-ME-Received: <xmr:KK0xZ4BdhbysiIWQgQt0O8WT_fEY_a-xkZ69gbS9zlr41Jq8me2z-e5n0QD3H-rrXSXJOUUmpvz6URXTI1QNaENhD-a2gduM1reiFYUYb0GB3P2x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrmhgu
    ohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopegvmhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KK0xZ6c7rY0T2eOScInQI8oUq4n6ukwzH5IqMibZ2QnLALIDMt7NSg>
    <xmx:KK0xZ3M0kgL3Q18YS8ZvsFUxEJ6OmL3fBfwtfSjaVwKWbvg4ZdNFfw>
    <xmx:KK0xZ0lDSggwOrlmckx51AAqKsSGKjOM-WXxxmsL6Bw1It3h3YEn7Q>
    <xmx:KK0xZ5vN-wcNjHRV1R_FxaNbChaVpPOjNMfbn19urjN83WcCq1R9Mw>
    <xmx:KK0xZzBm1cyjNZibXvdVZuFYdvUN6U3Yiyq3U56-7YgcXVNMzBdG_Y0X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 02:07:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf336b20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 07:06:42 +0000 (UTC)
Date: Mon, 11 Nov 2024 08:07:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, steamdon@google.com, emrass@google.com,
	me@ttaylorr.com, stolee@gmail.com
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and
 unsafe tasks
Message-ID: <ZzGtD4Jz9Wj6n0zH@pks.im>
References: <20241108173112.1240584-1-calvinwan@google.com>
 <20241108173112.1240584-2-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108173112.1240584-2-calvinwan@google.com>

On Fri, Nov 08, 2024 at 05:31:12PM +0000, Calvin Wan wrote:
> Certain maintenance tasks and subtasks within gc are unsafe to run in
> parallel with other commands because they lock up files such as
> HEAD.

I don't think it is fair to classify this as "unsafe". Nothing is unsafe
here: we take locks to guard us against concurrent modifications.
What you're having problems with is the fact that this safety mechanism
works as expected and keeps other processes from modifying locked the
data.

> Therefore, tasks are marked whether they are async safe or
> not. Async unsafe tasks are run first in the same process before running
> async safe tasks in parallel.
> 
> Since the gc task is partially safe, there are two new tasks -- an async
> safe gc task and an async unsafe gc task. In order to properly invoke
> this in gc, `--run-async-safe` and `--run-async-unsafe` have been added
> as options to gc. Maintenance will only run these two new tasks if it
> was set to detach, otherwise the original gc task runs.
> 
> Additionally, if a user passes in tasks thru `--task`, we do not attempt
> to run separate async/sync tasks since the user sets the order of tasks.
> 
> WIP: automatically run gc unsafe tasks when gc is invoked but not from
>      maintenance
> WIP: edit test in t7900-maintainance.sh to match new functionality
> WIP: add additional documentation for new options and functionality
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  builtin/gc.c           | 173 ++++++++++++++++++++++++++++++++++++-----
>  t/t7900-maintenance.sh |  24 +++---
>  2 files changed, 168 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index d52735354c..375d304c42 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c

It might make sense to split out the git-gc(1) changes into a
preparatory commit with its own set of tests.

> @@ -815,7 +824,12 @@ struct repository *repo UNUSED)
>  		atexit(process_log_file_at_exit);
>  	}
>  
> -	gc_before_repack(&opts, &cfg);
> +	if (run_async_unsafe) {
> +		gc_before_repack(&opts, &cfg);
> +		goto out;
> +	} else if (!run_async_safe)
> +		gc_before_repack(&opts, &cfg);
> +	
>  

Style: there should be curly braces around the `else if` here.

>  	if (!repository_format_precious_objects) {
>  		struct child_process repack_cmd = CHILD_PROCESS_INIT;
> @@ -1052,6 +1066,46 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
>  	return 0;
>  }
>  
> +static int maintenance_task_unsafe_gc(struct maintenance_run_opts *opts,
> +				      struct gc_config *cfg UNUSED)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	child.git_cmd = child.close_object_store = 1;
> +	strvec_push(&child.args, "gc");
> +
> +	if (opts->auto_flag)
> +		strvec_push(&child.args, "--auto");
> +	if (opts->quiet)
> +		strvec_push(&child.args, "--quiet");
> +	else
> +		strvec_push(&child.args, "--no-quiet");
> +	strvec_push(&child.args, "--no-detach");
> +	strvec_push(&child.args, "--run-async-unsafe");
> +
> +	return run_command(&child);
> +}
> +
> +static int maintenance_task_safe_gc(struct maintenance_run_opts *opts,
> +				    struct gc_config *cfg UNUSED)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	child.git_cmd = child.close_object_store = 1;
> +	strvec_push(&child.args, "gc");
> +
> +	if (opts->auto_flag)
> +		strvec_push(&child.args, "--auto");
> +	if (opts->quiet)
> +		strvec_push(&child.args, "--quiet");
> +	else
> +		strvec_push(&child.args, "--no-quiet");
> +	strvec_push(&child.args, "--no-detach");
> +	strvec_push(&child.args, "--run-async-safe");
> +
> +	return run_command(&child);
> +}

These two functions and `maintenance_task_gc()` all look exactly the
same. We should deduplicate them.

>  static int maintenance_task_gc(struct maintenance_run_opts *opts,
>  			       struct gc_config *cfg UNUSED)
>  {
> @@ -1350,6 +1404,7 @@ struct maintenance_task {
>  	const char *name;
>  	maintenance_task_fn *fn;
>  	maintenance_auto_fn *auto_condition;
> +	unsigned daemonize_safe;

We can use the enum here to give readers a better hint what this
variable is about.

>  	unsigned enabled:1;
>  
>  	enum schedule_priority schedule;
> @@ -1362,6 +1417,8 @@ enum maintenance_task_label {
>  	TASK_PREFETCH,
>  	TASK_LOOSE_OBJECTS,
>  	TASK_INCREMENTAL_REPACK,
> +	TASK_UNSAFE_GC,
> +	TASK_SAFE_GC,
>  	TASK_GC,
>  	TASK_COMMIT_GRAPH,
>  	TASK_PACK_REFS,
> @@ -1370,36 +1427,62 @@ enum maintenance_task_label {
>  	TASK__COUNT
>  };
>  
> +enum maintenance_task_daemonize_safe {
> +	UNSAFE,
> +	SAFE,
> +};

These names can conflict quite fast. Do we maybe want to rename them to
e.g. `MAINTENANCE_TASK_DAEMONIZE_(SAFE|UNSAFE)`?

>  static struct maintenance_task tasks[] = {
>  	[TASK_PREFETCH] = {
>  		"prefetch",
>  		maintenance_task_prefetch,
> +		NULL,
> +		SAFE,
>  	},

It might make sense to prepare these to take designated field
initializers in a preparatory commit.

>  	[TASK_LOOSE_OBJECTS] = {
>  		"loose-objects",
>  		maintenance_task_loose_objects,
>  		loose_object_auto_condition,
> +		SAFE,
>  	},
>  	[TASK_INCREMENTAL_REPACK] = {
>  		"incremental-repack",
>  		maintenance_task_incremental_repack,
>  		incremental_repack_auto_condition,
> +		SAFE,
> +	},
> +	[TASK_UNSAFE_GC] = {
> +		"unsafe-gc",
> +		maintenance_task_unsafe_gc,
> +		need_to_gc,
> +		UNSAFE,
> +		0,
> +	},
> +	[TASK_SAFE_GC] = {
> +		"safe-gc",
> +		maintenance_task_safe_gc,
> +		need_to_gc,
> +		SAFE,
> +		0,
>  	},

Hm. I wonder whether we really want to expose additional tasks to
address the issue, which feels like we're leaking implementation details
to our users. Would it maybe be preferable to instead introduce a new
optional callback function for every task that handles the pre-detach
logic?

I wonder whether we also have to adapt the "pack-refs" task to be
synchronous instead of asynchronous?

> @@ -1436,6 +1527,57 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  	}
>  	free(lock_path);
>  
> +	for (i = 0; !found_selected && i < TASK__COUNT; i++)
> +		found_selected = tasks[i].selected_order >= 0;
> +
> +	if (found_selected)
> +		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
> +	else if (opts->detach > 0) {
> +		/* 
> +		 * Part of gc is unsafe to run in the background, so
> +		 * separate out gc into unsafe and safe tasks.
> +		 * 
> +		 * Run unsafe tasks, including unsafe maintenance tasks,
> +		 * before daemonizing and running safe tasks.
> +		 */
> +
> +		if (tasks[TASK_GC].enabled) {
> +			tasks[TASK_GC].enabled = 0;
> +			tasks[TASK_UNSAFE_GC].enabled = 1;
> +			tasks[TASK_UNSAFE_GC].schedule = tasks[TASK_GC].schedule;
> +			tasks[TASK_SAFE_GC].enabled = 1;
> +			tasks[TASK_SAFE_GC].schedule = tasks[TASK_GC].schedule;
> +		}

If we did the above, then we could also get rid of the complexity here.

Thanks!

Patrick
