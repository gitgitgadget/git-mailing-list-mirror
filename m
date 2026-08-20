Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9867408630
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219416; cv=none; b=r9lZDzpzz9+cT1N3nLRsisg0ovyLJzEuOYnlUT8qezizJwq8IFRGSzRwBEXtu6+I2+DLWE67UuQ+VXuBeFocTFNlgDRcgtIn03lYM7PFD8eZOyJTisOt2C+PJ1c1GXLTAzO+yX44xC/uD4sQkmp9oQBgZktysRNNZnWvyXpYuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219416; c=relaxed/simple;
	bh=wHGO51DXTdOEmVO0NBUrHiOnh493lDLCSok8btRKtw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HaZ3lLYnIyKwVjGIi02lmDqxaDrIm+YIjwjDUD0W04x6x+vaNcD+mG32BNejLuqexc4DPsrisSklt8q+2NnsFUTLZh0Q5g9bgaxiSvWVlVgxnxavEyT6PW+YA3hdhjk/4tTGrL8R6QwFo0WqoyF5zD4ErAhQUhOLg/KfNVINWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO/wwaTd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO/wwaTd"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956242332dso21014425e9.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787219409; x=1787824209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HkiqRjBGQyAvDTLr6MV1nreRbHSK9+0b+DSE5VHiL8M=;
        b=AO/wwaTdz+rCCHf+1fe41hVyfAxcq5T19fnlkpyFEYhWiM//me7Hxdtce9nOTl7cRa
         cPSq6SDHc7LEvZwx+c7nd1UCpNYUuH9Z6J2bLd2A/cHudSJMQVmsTaeFF607uAHWdXcl
         7TjKimTpBVH7jnvQ5yaeOgg870ZRzESI6/YCuRT83UtZ0d1v2qc6OtghQqJYYyQOF4vJ
         wyp3eSW980ZNyI9fX5RcZy0J25lZntc641mEeem3rMlbZQpdc6IPLlW+CUMp99trsIVL
         y1NZ/LXxyo/AUInzG4zGNFv9Mr09vkmPfaGDNcj4x3y+VJ+pw0EvRXGP4M6IElvCT4fF
         6LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219409; x=1787824209;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HkiqRjBGQyAvDTLr6MV1nreRbHSK9+0b+DSE5VHiL8M=;
        b=ghlHGSl3zag6dZJrwKjb2/p0Bkw7aIeFwixL9YdwBCnm7n9iwCiJD6hjDaC98H28Lm
         GcBlAJ/ATxLfIg/0VscQvu2NAwcHCwHu4ETfKAXAJYV7GAccKiZ+3ud+Jm1Vtq6Zl7tx
         2BkrBQyThNj6iwSuC2O9ht1yxyoGsejS40WwdwyO4AkIPn/py5tAXuiZ1t03OZIyk+sK
         H6SWmrS1sniVXW9ocHwtzEVFcEb2GxRLX8jghR3nXOSmkkQEAAfat3RKzuEWOAgxNFs4
         Sh/GqdUe9vWKZKy4oQacy+DWwgoy2Nz8+dFUf7/x9KUdPIOYdFlYN4aTMuNoLvIqhsoh
         e8YA==
X-Forwarded-Encrypted: i=1; AHgh+RrrZUSOSkKLxaIiH2PA6FO2a/YusJqcMs5/t7m6H5gCr+NDWa0n67BB6brJDakx2Hr3xoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+jsMFAyxO+331Qz1+GdSiIMHFOwWKcTRGQG5A0Te/f5+0DYH
	SzyDx4l5OPTFK2RfAfd6A4zMqa8JwY0SiEVGY2yk0c/6VmOPrbj7RnfqukBCqA==
X-Gm-Gg: AR+sD10A5WFkEZP9B5ZLSGMEw3xXrKE4CSL4plJWF3sfJu1SL5frjPP4XLUvdbqucOf
	AO7WminNU96RJpK76rw4a5f1Pg6iw/a/dmxltRaeYpK44GOkwozOkwCyE8nldLTarm8d1YgVt1X
	QhhCzVKs7YgewLq+d5MjT21YrL5dDDL3NEJDg9qAKl5H0FoY55fLtAl2ug5xkLPHNV3a2AKDv1/
	7I6xPgDgBCvd64ZxX9ssTlfvu+tCKEdJEb0ccUWiMddAHsu+wZhcOEJPVdRF4ivU3fCQDS1bx22
	gPUOg8Vl6gktLO99c/lQw2pzFinbWeI4jC7iahLEmkagPEZPEc64nwi2D71wYCa+jEQbbxt8ax1
	JGHstxp/Hx4Q3Km/rXCbtms/le8PGgpZJbHV+9LcZpVqHk08PXXsVv/bxEv4SZfXa3B/zUJlsrC
	yPugZL+ZGHYITSB/+x96T/9Qd73pX5x/ie2WZWjEwLz2K9NuNaypK2nq6aZx85TwCKboY9WCvqo
	lbxHjK0xj1knQ5NJc5WGOveR+ogEEdZzGQvbFlefhE=
X-Received: by 2002:a05:600c:37c6:b0:499:8f9f:e9ee with SMTP id 5b1f17b1804b1-499aa173a16mr207306045e9.7.1787219408531;
        Thu, 20 Aug 2026 02:50:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b19dba34sm56074405e9.9.2026.08.20.02.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:50:07 -0700 (PDT)
Message-ID: <29f39d8b-6cf0-4811-afb3-0a1656877f31@gmail.com>
Date: Thu, 20 Aug 2026 10:50:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 18/08/2026 08:55, Karthik Nayak wrote:
> 
> Similar to the 'proc-receive' hook, this does not use the config-based
> hook infrastructure. That infrastructure is designed for parallelizable
> notification hooks. As this hook is a bidirectional filter, it would
> require significant modifications to that infrastructure and this hook
> cannot be parallelized anyway.

Config based hooks are about running more than one script to run per 
hook event, they're not about parallel execution per-se. Indeed the 
documentation for git hook notes

     Some hooks always run sequentially regardless of this flag or the
     hook.jobs config, because Git knows they cannot safely run in
     parallel: applypatch-msg, pre-commit, prepare-commit-msg, commit-
     msg, post-commit, post-checkout, and push-to-checkout.

I think the question the commit message should be answering is, whether 
a design like proc-receive that predates config based hooks and only 
allows a single hook script, makes sense now that we have config based 
hooks, or, if we were adding that functionality now, would we design it 
differently? I think the answer for server side hooks is that a design 
around a single script is probably reasonable but it would be worth 
discussing that in the commit message.

Thanks

Phillip



> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> To give some context, we at GitLab are building a custom MVCC around
> Git. Each git-push would initialize a new version which is then
> committed as the default post some operations. These operations take
> place after the reference transaction and based on the output status of
> those operations, we want to propagate the status to the user. There
> currently exists no good mechanism to do so.
> 
> Having a report hook which allows us to modify the report being
> propagated to the user, allows us to modify the report based on the
> status of our MVCC commit phase.
> ---
>   Documentation/githooks.adoc |  23 ++++++
>   builtin/receive-pack.c      |  41 +++++++++++
>   t/meson.build               |   1 +
>   t/t5412-report-hook.sh      | 176 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 241 insertions(+)
> 
> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index ed045940d1..7e6643ad89 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
>   status will cause the transaction to be aborted. The hook will not be
>   called with "aborted" state in that case.
>   
> +report
> +~~~~~~
> +
> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
> +`git push` and updates reference(s) in its repository. It executes on
> +the remote repository once after all refs have been updated, but before
> +the status report is sent back to the client.
> +
> +The hook receives the pkt-line encoded status report on standard input
> +and its standard output replaces the report sent to the client. Any
> +output written to standard error is forwarded to the client over the
> +sideband channel and will appear as `remote:` lines on the client's
> +terminal. To reject individual ref updates, rewrite the corresponding
> +`ok` lines to `ng` lines in the output report (with an explanatory
> +error string) and exit zero; standard error can accompany this to
> +provide a human-readable explanation. A non-zero exit status causes
> +`receive-pack` to die.
> +
> +Note that by the time this hook runs, all ref updates have already been
> +applied to the repository. A non-zero exit causes the client to see the
> +push as failed, but does *not* roll back any ref changes that were
> +already committed server-side.
> +
>   push-to-checkout
>   ~~~~~~~~~~~~~~~~
>   
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 86933d8d7e..bc22b3ec31 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
>   	return code;
>   }
>   
> +static int run_report_hook(struct strbuf *report)
> +{
> +	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct async sideband_async;
> +	int sideband_async_started = 0;
> +	int saved_stderr = -1;
> +	struct strbuf out = STRBUF_INIT;
> +	const char *hook_path;
> +	int code;
> +
> +	hook_path = find_hook(the_repository, "report");
> +	if (!hook_path)
> +		return 0;
> +
> +	strvec_push(&proc.args, hook_path);
> +	proc.trace2_hook_name = "report";
> +
> +	prepare_sideband_async(&sideband_async, &saved_stderr,
> +			       &sideband_async_started);
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	code = pipe_command(&proc, report->buf, report->len, &out,
> +			    report->len, NULL, 0);
> +	sigchain_pop(SIGPIPE);
> +
> +	finish_sideband_async(&sideband_async, saved_stderr,
> +			      sideband_async_started);
> +
> +	if (!code)
> +		strbuf_swap(&out, report);
> +
> +	strbuf_release(&out);
> +	return code;
> +}
> +
>   static struct command *find_command_by_refname(struct command *list,
>   					       const char *refname)
>   {
> @@ -2547,6 +2582,9 @@ static void report(struct command *commands, const char *unpack_status)
>   	}
>   	packet_buf_flush(&buf);
>   
> +	if (run_report_hook(&buf))
> +		die("report hook failed");
> +
>   	if (use_sideband)
>   		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>   	else
> @@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands, const char *unpack_status)
>   	}
>   	packet_buf_flush(&buf);
>   
> +	if (run_report_hook(&buf))
> +		die("report hook failed");
> +
>   	if (use_sideband)
>   		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>   	else
> diff --git a/t/meson.build b/t/meson.build
> index a25f37d2f5..7056e31326 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -651,6 +651,7 @@ integration_tests = [
>     't5409-colorize-remote-messages.sh',
>     't5410-receive-pack.sh',
>     't5411-proc-receive-hook.sh',
> +  't5412-report-hook.sh',
>     't5500-fetch-pack.sh',
>     't5501-fetch-push-alternates.sh',
>     't5502-quickfetch.sh',
> diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
> new file mode 100755
> index 0000000000..47f20e8d67
> --- /dev/null
> +++ b/t/t5412-report-hook.sh
> @@ -0,0 +1,176 @@
> +#!/bin/sh
> +
> +test_description='test report hook'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/t5411/common-functions.sh
> +
> +URL_PREFIX="\.\."
> +
> +test_expect_success "setup workbench" '
> +	git init workbench &&
> +	create_commits_in workbench A B
> +'
> +
> +test_expect_success "no report hook, push succeeds" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +	git init --bare upstream &&
> +
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-\EOF &&
> +	To ../upstream
> +	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "passthrough does not alter report" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +	git init --bare upstream &&
> +
> +	test_hook -C upstream --setup report <<-\EOF &&
> +	cat
> +	EOF
> +
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-\EOF &&
> +	To ../upstream
> +	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "non-zero exit causes receive-pack to die" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +
> +	git init --bare upstream &&
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +
> +	test_hook -C upstream --setup report <<-\EOF &&
> +	exit 1
> +	EOF
> +
> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-\EOF &&
> +	fatal: report hook failed
> +	send-pack: unexpected disconnect while reading sideband packet
> +	fatal: the remote end hung up unexpectedly
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "hook is invoked and receives report on stdin" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +
> +	git init --bare upstream &&
> +	test_hook -C upstream --setup report <<-EOF &&
> +	tee raw
> +	EOF
> +
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	To ../upstream
> +	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
> +	EOF
> +	test_cmp expect actual &&
> +
> +	test-tool pkt-line unpack <upstream/raw >actual-report &&
> +	cat >expect-report <<-EOF &&
> +	unpack ok
> +	ok refs/heads/main
> +	0000
> +	EOF
> +	test_cmp expect-report actual-report
> +'
> +
> +test_expect_success "hook can modify the report sent to client" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +
> +	git init --bare upstream &&
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +
> +	test_hook -C upstream --setup report <<-\EOF &&
> +	test-tool pkt-line unpack |
> +	sed "s/^ok /ng /" |
> +	test-tool pkt-line pack
> +	EOF
> +
> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-\EOF &&
> +	To ../upstream
> +	 ! [remote rejected] <COMMIT-B> -> main (failed)
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "hook can report a custom failure message" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +
> +	git init --bare upstream &&
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +
> +	test_hook -C upstream --setup report <<-\EOF &&
> +	echo "push rejected: service X is down" >&2
> +	test-tool pkt-line unpack |
> +	sed "s/^ok \(.*\)/ng \1 service-x-is-down/" |
> +	test-tool pkt-line pack |
> +	tee raw
> +	EOF
> +
> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +	test_grep "push rejected: service X is down" out &&
> +
> +	test-tool pkt-line unpack <upstream/raw >actual-report &&
> +	cat >expect-report <<-\EOF &&
> +	unpack ok
> +	ng refs/heads/main service-x-is-down
> +	0000
> +	EOF
> +	test_cmp expect-report actual-report
> +'
> +
> +test_expect_success "hook stderr is relayed to client via sideband" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +
> +	git init --bare upstream &&
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +
> +	test_hook -C upstream --setup report <<-\EOF &&
> +	echo "hook-stderr-message" >&2
> +	exit 1
> +	EOF
> +
> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +	test_grep "hook-stderr-message" out
> +'
> +
> +test_done
> 
> ---
> base-commit: 11c6700f10234578d10523faf35656ca491425c9
> change-id: 20260812-758-introduce-hook-5b3af9f1a7e8
> 
> 
> Thanks
> - Karthik
> 
> 

