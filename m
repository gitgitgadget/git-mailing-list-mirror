Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353938E8A0
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316671; cv=pass; b=REsa3n8ehD3L+Gxtt4HSXPNfo2wJALWwV8/vzDdGa4qL6gpQNUZJ6XKWNJqs2V4SnlyATwfDu50oIaEciXIDrN/HXl2E9QzIojOYdztnDzqm16ipd7k9z6DTeJ1FMjFfZqRvXOCI4qVaMPMVvSo+l6Le3cWf7XSCMAmKlFS6+4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316671; c=relaxed/simple;
	bh=LAHceta9ol2JY8lHWxKT9MqBWfV6eb7bldB0puzPO64=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=VXyyzteqY9uXxJKpP90m3UvLP4AhnPCO62yJvh453DqYF3M/Ok4E1xqb1J/FAGVOVOPs5r+Xm6VqG8teSL/ZBtkJMZlUB/no5Yze5GkSsVS1/0+6f4bwQ7l/yHyHF79bNwb6kX+zB4BwgA1nOqlei1xpYLRGUe4NvTVJ/QNuYmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDAl2E0X; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDAl2E0X"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so608043241.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787316668; cv=none;
        d=google.com; s=arc-20260327;
        b=X7/jiPWkQywlFcBsT360S0hSVVbp/H1b7EqYweTCQG01kpWCQB74CJ9kvDU82i49Cf
         seW9gLrhvAr7lwH9hIPpU9rEyJmFKp1/aGSDwIT9Pttp8Wi+8K958Vnk1EhYMZZqh+hG
         +Js2fF2ir3l+ovXGswXWDPkjKdPiPVwoQlIf97IgO6ERC6BEsqk3L2SqZ4OQzUGvKCGt
         F4yFzOkFZ8a8cWvLROULgEJ1e0K3y74tGqKwh66nK2HoWXWRaRpplyZsEl1nTFqwv3O1
         /O2f3BYcuQhObFZKJXufIrhjM3EIQFXhdJwHR54gEMbN5W2LqshuPieG1D1Ps749/Opp
         47Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=MA0k9AF5bp958LuF8V8uSAAmuLgoias2wKUJNYuMK1c=;
        fh=tvJSwwxzzyprnMYAjDypgrHRPXUTk8Us7i3uYHz7Ei0=;
        b=dTJ+/aA3ApYj050MNAk255vUwcTuaaDpe+qs5O+gZO/9hh5yeDaC1rHpmd3KqcxFNF
         sRdaEYWJBB+YnM6hErOoQuwW6LkwUUak9LMA8pqA8O7jBLohIDMTIlTxE2yZIEzoyi58
         3GUesSAWkXRXjkzrCMWjqS2y0+4bJHW3L/JZNNdxVwSOyZVko1SKZJxzG2GuPUko5s24
         kWRNij/fyaa8vWSxIKJSAqK5q8DS5TVCeCJMIa8j+PE2lvE0K27mpgZjhXHLCBm2yLza
         BDUrk9+0raII/a+qG+jUSZW3ZvjjFaEQr9RniD3hEZTcnSIL5cmzqCn3ICgRRts8DCz/
         GUcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787316668; x=1787921468; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MA0k9AF5bp958LuF8V8uSAAmuLgoias2wKUJNYuMK1c=;
        b=KDAl2E0XGU87R/qIC8mTSQR2OlqGZ4Vg5bxq1WD685T0fsNyZ6/qvR1A/7Lm5Wjc5q
         l6mZ3RnCgDEhevnxQ0tNo/oNZUlwvKHne8rgdCqS2xborCBXOJbggM1j21YtI8Jrvb2o
         bcbPh2n/1Vq6YEtNd8QD5kc38qAsvBew6GeZ7lNhvzabkueWqaslva5vfDZ+TsDcLflc
         OgVQYhIP+W6n3QwSOkbPmxcIJ9w9ivHc4HtVCQRArvqdj08+l1k7kY8uLfBox+pwCo4Q
         Zhu2MWuJ2jZ9Xk5be1vWmFzs3OQuPlfkrEYU0Dy4lnYNjE9nJnwMCq0hbg0VjfGN3rj9
         RjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316668; x=1787921468;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA0k9AF5bp958LuF8V8uSAAmuLgoias2wKUJNYuMK1c=;
        b=tJoybuOoOIflvTIoJMDJiZZqCgpkYZlto+HypI+/sn9s5UhKnGbkTwTSyNWIBGaOd2
         JnT8FuwhatUJzP3L/qX9uN0PXM/xM1SWhxkvzKAkr0jaav0X3Kxn0Y5Ls83gVTyryHQ8
         IYslOvYvo0M8vlepCIcXmCq4ppHozefTAmh9eQO3OjpZZVkmJa3cKgUa5XVOrCDE4qvv
         9+cqg8ySvWOFYAlKIrbECufZTv8VaBPB7k8JAJt1V6gX67Xez+2ZG9lQOyObLy+j1l95
         IB2P2n0rCcwK/XqVvwkkKzfBrkcbojVpSVnfAGe4JkpG0ifPtZ+Nxa5661Nz+3AGd4sR
         bQvw==
X-Forwarded-Encrypted: i=1; AHgh+RptcT8duHsIeHAjO3+coyrNxbbpLmxbv8vM9Sm3981vqZbv4x6bGeLzw0XKSeofzeIb1yU=@vger.kernel.org
X-Gm-Message-State: AFuF++lS7ePbaf+jbHm9sD5CaXnv0cmaszS8ViIWrCzsDHOj6tcNrfMb
	1mbAzqesArkq5EZug77/0ddBqEMt8aHARvsHtj/A4jl7Sou8XxXcNjUfR6k0DgMjGvykQCgcAiu
	48fd2YztgOqNoQ6+ZJC+cj3NcFLRb9i3VEfe2
X-Gm-Gg: AR+sD12gKDSnWWc/b3rc85ZSOVRkHwd3/YjN+xs7vVlIHlL1wsrzJ2l5YuvBvy27haM
	273trQjS9gphWVJYCAm70txRsOoz1lNtrvRBPuIBgbyHc0yNfpjSq7fB0uHtisE4lgIrITAOGOb
	pQnnnrrVXkYmZdr3nDoEiB/r08o7oJoY8WZWpwn3LaPz+tyH1/tcBlRdzK4AbiGkgyM2D3otpIs
	704sd2imcM1rAjmwqfkCqNk2JHZCd5wwN4O0gIVO50lihI9NFRUsdKMnZQcwa+yHQdUanOt+X/B
	81rAWFZTEtTHn1QY0a500/hYbiGvMsPr3IYITnWWTQa3ge8Bd7kkVj9fuOho1E/9L6DRZjHIaV/
	zLrkFs4ZhdynvLNNUMdX7cuI1nrg53l4Z5qg=
X-Received: by 2002:a05:6102:2b95:b0:77a:2844:490b with SMTP id
 ada2fe7eead31-77a81275073mr1158639137.0.1787316667810; Fri, 21 Aug 2026
 05:51:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 07:51:07 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 07:51:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <29f39d8b-6cf0-4811-afb3-0a1656877f31@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com> <29f39d8b-6cf0-4811-afb3-0a1656877f31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 07:51:07 -0500
X-Gm-Features: AcwNN1V7qJflfct3Oh3RTBDGsJeeVe8I2emqlYdIR24BXGw8490w-vccr0NLLGw
Message-ID: <CAOLa=ZSH_YEuARVEXTHVfdGFoEP1kbL2d4nYvph3KQx+v-jPTw@mail.gmail.com>
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000016222e06598e17f5"

--00000000000016222e06598e17f5
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 18/08/2026 08:55, Karthik Nayak wrote:
>>
>> Similar to the 'proc-receive' hook, this does not use the config-based
>> hook infrastructure. That infrastructure is designed for parallelizable
>> notification hooks. As this hook is a bidirectional filter, it would
>> require significant modifications to that infrastructure and this hook
>> cannot be parallelized anyway.
>
> Config based hooks are about running more than one script to run per
> hook event, they're not about parallel execution per-se. Indeed the
> documentation for git hook notes
>
>      Some hooks always run sequentially regardless of this flag or the
>      hook.jobs config, because Git knows they cannot safely run in
>      parallel: applypatch-msg, pre-commit, prepare-commit-msg, commit-
>      msg, post-commit, post-checkout, and push-to-checkout.
>
> I think the question the commit message should be answering is, whether
> a design like proc-receive that predates config based hooks and only
> allows a single hook script, makes sense now that we have config based
> hooks, or, if we were adding that functionality now, would we design it
> differently? I think the answer for server side hooks is that a design
> around a single script is probably reasonable but it would be worth
> discussing that in the commit message.
>
> Thanks
>
> Phillip
>
>

That's fair.

I did spend some time trying to modify the config based infrastructure
to work with bi-directional input/output so I could transfer both this
hook and proc-receive to using it, but I couldn't find a good design
around it and looked messy.

I do agree with Junio that the condition for being single script is not
a client vs server argument, but rather its more of a one way
notification vs bi-directional input/output argument. We could pipe the
output of one hook as input to the other for this hook, but that
wouldn't make sense for proc-receive.

>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> To give some context, we at GitLab are building a custom MVCC around
>> Git. Each git-push would initialize a new version which is then
>> committed as the default post some operations. These operations take
>> place after the reference transaction and based on the output status of
>> those operations, we want to propagate the status to the user. There
>> currently exists no good mechanism to do so.
>>
>> Having a report hook which allows us to modify the report being
>> propagated to the user, allows us to modify the report based on the
>> status of our MVCC commit phase.
>> ---
>>   Documentation/githooks.adoc |  23 ++++++
>>   builtin/receive-pack.c      |  41 +++++++++++
>>   t/meson.build               |   1 +
>>   t/t5412-report-hook.sh      | 176 ++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 241 insertions(+)
>>
>> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
>> index ed045940d1..7e6643ad89 100644
>> --- a/Documentation/githooks.adoc
>> +++ b/Documentation/githooks.adoc
>> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
>>   status will cause the transaction to be aborted. The hook will not be
>>   called with "aborted" state in that case.
>>
>> +report
>> +~~~~~~
>> +
>> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
>> +`git push` and updates reference(s) in its repository. It executes on
>> +the remote repository once after all refs have been updated, but before
>> +the status report is sent back to the client.
>> +
>> +The hook receives the pkt-line encoded status report on standard input
>> +and its standard output replaces the report sent to the client. Any
>> +output written to standard error is forwarded to the client over the
>> +sideband channel and will appear as `remote:` lines on the client's
>> +terminal. To reject individual ref updates, rewrite the corresponding
>> +`ok` lines to `ng` lines in the output report (with an explanatory
>> +error string) and exit zero; standard error can accompany this to
>> +provide a human-readable explanation. A non-zero exit status causes
>> +`receive-pack` to die.
>> +
>> +Note that by the time this hook runs, all ref updates have already been
>> +applied to the repository. A non-zero exit causes the client to see the
>> +push as failed, but does *not* roll back any ref changes that were
>> +already committed server-side.
>> +
>>   push-to-checkout
>>   ~~~~~~~~~~~~~~~~
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 86933d8d7e..bc22b3ec31 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
>>   	return code;
>>   }
>>
>> +static int run_report_hook(struct strbuf *report)
>> +{
>> +	struct child_process proc = CHILD_PROCESS_INIT;
>> +	struct async sideband_async;
>> +	int sideband_async_started = 0;
>> +	int saved_stderr = -1;
>> +	struct strbuf out = STRBUF_INIT;
>> +	const char *hook_path;
>> +	int code;
>> +
>> +	hook_path = find_hook(the_repository, "report");
>> +	if (!hook_path)
>> +		return 0;
>> +
>> +	strvec_push(&proc.args, hook_path);
>> +	proc.trace2_hook_name = "report";
>> +
>> +	prepare_sideband_async(&sideband_async, &saved_stderr,
>> +			       &sideband_async_started);
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	code = pipe_command(&proc, report->buf, report->len, &out,
>> +			    report->len, NULL, 0);
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	finish_sideband_async(&sideband_async, saved_stderr,
>> +			      sideband_async_started);
>> +
>> +	if (!code)
>> +		strbuf_swap(&out, report);
>> +
>> +	strbuf_release(&out);
>> +	return code;
>> +}
>> +
>>   static struct command *find_command_by_refname(struct command *list,
>>   					       const char *refname)
>>   {
>> @@ -2547,6 +2582,9 @@ static void report(struct command *commands, const char *unpack_status)
>>   	}
>>   	packet_buf_flush(&buf);
>>
>> +	if (run_report_hook(&buf))
>> +		die("report hook failed");
>> +
>>   	if (use_sideband)
>>   		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>>   	else
>> @@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands, const char *unpack_status)
>>   	}
>>   	packet_buf_flush(&buf);
>>
>> +	if (run_report_hook(&buf))
>> +		die("report hook failed");
>> +
>>   	if (use_sideband)
>>   		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>>   	else
>> diff --git a/t/meson.build b/t/meson.build
>> index a25f37d2f5..7056e31326 100644
>> --- a/t/meson.build
>> +++ b/t/meson.build
>> @@ -651,6 +651,7 @@ integration_tests = [
>>     't5409-colorize-remote-messages.sh',
>>     't5410-receive-pack.sh',
>>     't5411-proc-receive-hook.sh',
>> +  't5412-report-hook.sh',
>>     't5500-fetch-pack.sh',
>>     't5501-fetch-push-alternates.sh',
>>     't5502-quickfetch.sh',
>> diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
>> new file mode 100755
>> index 0000000000..47f20e8d67
>> --- /dev/null
>> +++ b/t/t5412-report-hook.sh
>> @@ -0,0 +1,176 @@
>> +#!/bin/sh
>> +
>> +test_description='test report hook'
>> +
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>> +. ./test-lib.sh
>> +
>> +. "$TEST_DIRECTORY"/t5411/common-functions.sh
>> +
>> +URL_PREFIX="\.\."
>> +
>> +test_expect_success "setup workbench" '
>> +	git init workbench &&
>> +	create_commits_in workbench A B
>> +'
>> +
>> +test_expect_success "no report hook, push succeeds" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +	git init --bare upstream &&
>> +
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +
>> +	make_user_friendly_and_stable_output <out >actual &&
>> +	cat >expect <<-\EOF &&
>> +	To ../upstream
>> +	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success "passthrough does not alter report" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +	git init --bare upstream &&
>> +
>> +	test_hook -C upstream --setup report <<-\EOF &&
>> +	cat
>> +	EOF
>> +
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +
>> +	make_user_friendly_and_stable_output <out >actual &&
>> +	cat >expect <<-\EOF &&
>> +	To ../upstream
>> +	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success "non-zero exit causes receive-pack to die" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +
>> +	git init --bare upstream &&
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +
>> +	test_hook -C upstream --setup report <<-\EOF &&
>> +	exit 1
>> +	EOF
>> +
>> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +	make_user_friendly_and_stable_output <out >actual &&
>> +	cat >expect <<-\EOF &&
>> +	fatal: report hook failed
>> +	send-pack: unexpected disconnect while reading sideband packet
>> +	fatal: the remote end hung up unexpectedly
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success "hook is invoked and receives report on stdin" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +
>> +	git init --bare upstream &&
>> +	test_hook -C upstream --setup report <<-EOF &&
>> +	tee raw
>> +	EOF
>> +
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +
>> +	make_user_friendly_and_stable_output <out >actual &&
>> +	cat >expect <<-EOF &&
>> +	To ../upstream
>> +	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
>> +	EOF
>> +	test_cmp expect actual &&
>> +
>> +	test-tool pkt-line unpack <upstream/raw >actual-report &&
>> +	cat >expect-report <<-EOF &&
>> +	unpack ok
>> +	ok refs/heads/main
>> +	0000
>> +	EOF
>> +	test_cmp expect-report actual-report
>> +'
>> +
>> +test_expect_success "hook can modify the report sent to client" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +
>> +	git init --bare upstream &&
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +
>> +	test_hook -C upstream --setup report <<-\EOF &&
>> +	test-tool pkt-line unpack |
>> +	sed "s/^ok /ng /" |
>> +	test-tool pkt-line pack
>> +	EOF
>> +
>> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +	make_user_friendly_and_stable_output <out >actual &&
>> +	cat >expect <<-\EOF &&
>> +	To ../upstream
>> +	 ! [remote rejected] <COMMIT-B> -> main (failed)
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success "hook can report a custom failure message" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +
>> +	git init --bare upstream &&
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +
>> +	test_hook -C upstream --setup report <<-\EOF &&
>> +	echo "push rejected: service X is down" >&2
>> +	test-tool pkt-line unpack |
>> +	sed "s/^ok \(.*\)/ng \1 service-x-is-down/" |
>> +	test-tool pkt-line pack |
>> +	tee raw
>> +	EOF
>> +
>> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +	test_grep "push rejected: service X is down" out &&
>> +
>> +	test-tool pkt-line unpack <upstream/raw >actual-report &&
>> +	cat >expect-report <<-\EOF &&
>> +	unpack ok
>> +	ng refs/heads/main service-x-is-down
>> +	0000
>> +	EOF
>> +	test_cmp expect-report actual-report
>> +'
>> +
>> +test_expect_success "hook stderr is relayed to client via sideband" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +
>> +	git init --bare upstream &&
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +
>> +	test_hook -C upstream --setup report <<-\EOF &&
>> +	echo "hook-stderr-message" >&2
>> +	exit 1
>> +	EOF
>> +
>> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +	test_grep "hook-stderr-message" out
>> +'
>> +
>> +test_done
>>
>> ---
>> base-commit: 11c6700f10234578d10523faf35656ca491425c9
>> change-id: 20260812-758-introduce-hook-5b3af9f1a7e8
>>
>>
>> Thanks
>> - Karthik
>>
>>

--00000000000016222e06598e17f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4c3662d331af645c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSVNia1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEpMQy80NFNxMGdLM1BVRWV3YmovbFIvWHhkb0l6TQp6cCtoOGs2TEpF
emtjMDdoalhvYzBkVjBWZS9KTTVTeUI2TG10T0lCMlFSZGhMN0dYQkFveVp0ZXVUZzNsZzBqCmRH
VCt4QmN2d2hDZTc0c2xPK0J3YThtOXpJaEo1aHpTNVJGb3dFZTkzdnp0bklTTGNXRDVzSUJTTW9O
Mmd4YVMKTFg3V21HaGk1UGdtMGVrbDU4bnNPUU9RNWhmZkpWUWxvRnNrVXM3Sis0dWlualh5WUpQ
bXZsWmFyMzVwTklJUQoraXhwdGw4RWlqRm1jZDQ0ZVdsNXg1YVNBS1c1U2IrSGpkTXBoYmRnSSs3
WjdKelNOQUhCaFlxbjdQSTlqMzlHCkF0RTZqbHppVHB5c01BZG9pRnJ2RktBV3ZMRElsRlBrS2x0
QkJxdCtEOTBXZHNsODRSZWUxNWk5QVVGWWxEQWYKenRUbEV5dlFGTDg3VnZ0Mlp6WEkxUXAvRWRi
aUFvRU5OQnFVVVNiNjB4VDg5RHB5c1FKcHdFT2JHaGVZMVgxaApMYmMrSWxVR1YyTDVwYmhWUTJv
S1U0UUEyYWdlMEJHVXlYQlBEc0hrOG1oNWI2N1B1RkZhdGxsdk5heWpRcjFJCm4rREpCTnRYa3Q4
WGQ4Y3VpSittQ3JXSlFxak1nbUtBd2ZzVTlkOD0KPVFGdzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000016222e06598e17f5--
