Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274F8479
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766751891; cv=pass; b=FJ5lfChVu5G7UohLUpi2H8q7eIaCDjTMfl1Dr+UeOpbB0dIIt7CIgtv0iuDUOAgVa4AJ3Cp8Yw97WsPaXSVIT62M+o8MwLRV+zHA3pOpqTOoj6wZk6daogPYO69W1RFBCizaSNSOEdQWBCFNqsIDtCKDXzUBsvTibx7CWGDsckQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766751891; c=relaxed/simple;
	bh=urkh/eYGdk3Kj/X+2SA/lK0yb9WpBb3OqIrJv/CR7vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHn1kQOlRA1OXnNlKJn3VYckjcyRrGjhschyJcupGlscOzP7g4ZryZ8ch7064Rqnhsmuy04WHscEwvs8tkoLR9fa87DDt9+BgP1JiVtWi1g4YOiA1YXXQeYRAv5xNJLG2XoJSzS6EgOAmJap9BBkF2Aggb024oWlzPzvaH7rt1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ZVmhOXFy; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ZVmhOXFy"
ARC-Seal: i=1; a=rsa-sha256; t=1766751875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KPiSm88QSc+1wCC3UPGd2LixoygpuOhWMpcj9g7Usw7vfdXXSeAHXVsXz6IDOMNFLPC1BGs833PGfHCLUJNGzQp1tlW9Eqwx7MhoRJsbqib5rbuoq/5C10he3OPk3Xb4MU9BTX3CRMFzeP3uk5PQ8L/f80mHKKzMESa2BKlV0rU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766751875; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tOFI4GdW/N/tmSCIZDpEpQWB3vYvO1JmSCSClhOxYZg=; 
	b=K3fH/aUCTtAlw+5BIJbcZN+42Dk1u80jWSCHuJNNIBjUXaZ3SFJVyKE1F0618dGZUoFJkj1Qe65pyFwWpvndpU4myCAMWKMcYPJSjlBnRQg5w196AUF9F1FD3ONqBTT10AiL8GxJftpTR5dxlx6B12n2B5yJfdyRGqSMUDJxbSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766751875;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tOFI4GdW/N/tmSCIZDpEpQWB3vYvO1JmSCSClhOxYZg=;
	b=ZVmhOXFyMfL3t3WHXw3PqP2rqAKULpP/sNRkoGKQBumB5blLY8+9Ns176ML+KCtR
	6unhvx8t2MdAGrTkh/ITQ0Fg3HFxrE2TLQLw2TtaiF+cC2Gatt+/QgO3q2SdbZRcN+V
	FLRqeCFqHrXYAFvKXRhXmjNnuclHtr1OANXQR25Y=
Received: by mx.zohomail.com with SMTPS id 1766751873089270.7906733448634;
	Fri, 26 Dec 2025 04:24:33 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v6 00/11] Convert remaining hooks to hook.h
Date: Fri, 26 Dec 2025 14:23:23 +0200
Message-ID: <20251226122334.16687-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This series finishes the hook.[ch] conversion for the remaining hooks in
preparation for adding config-based hooks and enabling parallel hook
execution where possible (that will be a separate series from this one).

v6 is minor refresh for some last nits. Details + range-diff below.

It is based on the latest master branch. There are no conflicts with
next and seen branches, the code is available on GitHub [1] and a
successful CI run [2] is also provided.

1: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v6
2: https://github.com/10ne1/git/actions/runs/20436908624

Changes in v6:
* Last commit cb state is new allocated on the stack (Patrick)
* Small loop variable and brace fixes (Patrick)

Range-diff v5 -> v6:
 1:  8c16f1bcbf =  1:  8c16f1bcbf run-command: add first helper for pp child states
 2:  5e6e05ba92 =  2:  5e6e05ba92 run-command: add stdin callback for parallelization
 3:  3669acfe6a =  3:  3669acfe6a hook: provide stdin via callback
 4:  bf9d8680e4 =  4:  bf9d8680e4 hook: convert 'post-rewrite' hook in sequencer.c to hook API
 5:  bdcc1cff34 =  5:  bdcc1cff34 transport: convert pre-push to hook API
 6:  9c1d5e8726 =  6:  9c1d5e8726 reference-transaction: use hook API instead of run-command
 7:  0b986bf0fb =  7:  0b986bf0fb hook: allow overriding the ungroup option
 8:  5f07d07acc =  8:  5f07d07acc run-command: allow capturing of collated output
 9:  c4ff1e2270 =  9:  c4ff1e2270 hooks: allow callers to capture output
10:  15c831ca15 = 10:  15c831ca15 receive-pack: convert update hooks to new API
11:  4bd2c2974a ! 11:  432dc14871 receive-pack: convert receive hooks to hook API
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -		finish_async(&muxer);
      
     -	sigchain_pop(SIGPIPE);
    --
    --	return finish_command(&proc);
    --}
     +	state->cmd = cmd;
      
    +-	return finish_command(&proc);
    +-}
    +-
     -static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
     -{
     -	struct receive_hook_feed_state *state = state_;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     -	if (feed_receive_hook(&state, NULL, NULL))
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct command *iter = commands;
    -+	struct receive_hook_feed_state *feed_state;
    ++	struct receive_hook_feed_state feed_state;
     +	int ret;
     +
     +	/* if there are no valid commands, don't invoke the hook at all. */
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     -	return status;
     +
     +	if (push_options) {
    -+		int i;
    -+		for (i = 0; i < push_options->nr; i++)
    ++		for (int i = 0; i < push_options->nr; i++)
     +			strvec_pushf(&opt.env, "GIT_PUSH_OPTION_%d=%s", i,
     +				     push_options->items[i].string);
     +		strvec_pushf(&opt.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
     +					     (uintmax_t)push_options->nr);
    -+	} else
    ++	} else {
     +		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
    ++	}
     +
     +	if (tmp_objdir)
     +		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +		opt.consume_output = hook_output_to_sideband;
     +
     +	/* set up stdin callback */
    -+	feed_state = xmalloc(sizeof(struct receive_hook_feed_state));
    -+	feed_state->cmd = commands;
    -+	feed_state->skip_broken = skip_broken;
    -+	feed_state->report = NULL;
    -+	strbuf_init(&feed_state->buf, 0);
    -+	opt.feed_pipe_cb_data = feed_state;
    ++	feed_state.cmd = commands;
    ++	feed_state.skip_broken = skip_broken;
    ++	feed_state.report = NULL;
    ++	strbuf_init(&feed_state.buf, 0);
    ++	opt.feed_pipe_cb_data = &feed_state;
     +	opt.feed_pipe = feed_receive_hook_cb;
     +
     +	ret = run_hooks_opt(the_repository, hook_name, &opt);
     +
    -+	strbuf_release(&feed_state->buf);
    -+	FREE_AND_NULL(opt.feed_pipe_cb_data);
    ++	strbuf_release(&feed_state.buf);
     +
     +	return ret;
      }

Adrian Ratiu (3):
  run-command: add first helper for pp child states
  reference-transaction: use hook API instead of run-command
  hook: allow overriding the ungroup option

Emily Shaffer (8):
  run-command: add stdin callback for parallelization
  hook: provide stdin via callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook API
  transport: convert pre-push to hook API
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert update hooks to new API
  receive-pack: convert receive hooks to hook API

 builtin/hook.c              |   6 +
 builtin/receive-pack.c      | 270 +++++++++++++++---------------------
 commit.c                    |   3 +
 hook.c                      |  29 +++-
 hook.h                      |  51 +++++++
 refs.c                      | 100 ++++++-------
 run-command.c               | 142 +++++++++++++++----
 run-command.h               |  38 +++++
 sequencer.c                 |  42 +++---
 t/helper/test-run-command.c |  67 ++++++++-
 t/t0061-run-command.sh      |  38 +++++
 transport.c                 |  89 ++++++------
 12 files changed, 583 insertions(+), 292 deletions(-)

-- 
2.51.2

