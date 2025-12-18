Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D22C0299
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077931; cv=pass; b=rOEOz2ijY1sm1EW1m+/S/s3KrCJQUSJOJtPrYatEHYAULqYfP7Zt5inGLBfjS/w+5qH6ZjhMeVswCcADhILnq91nY1z+WSsraHGhuiIWN7ruuBBSbAK29GQh/4pNtZlsOacW91HgVPxeA9Y5xq5tSOwGLhM6JAVzrIQI49S4uTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077931; c=relaxed/simple;
	bh=YUjgX5QzX4e6RH0TOWqtl7OPAURSwE/lGjv5Js5kfwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhPNUOz3CCfn6Inf7LyXtjKWXOo+bKgAMBRiSscnLqYdD9OrrsgfiPneKJSamD0XrrPxzlGVLWNCm4fC6K5+eb1LjqKgTP4sh3PIgtf6WRcjhv3EDd4ZZFnDrC4bmHshF8VOHjzqz66w4R9YjCFXuHfG6qkt0dtIEfTI6WzKeXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=b8v64jU1; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="b8v64jU1"
ARC-Seal: i=1; a=rsa-sha256; t=1766077913; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dqMEVDA7285xJ2LMDPSGWCfwK4trykyWHXUzf99DXT51ewHcY5n81RiMfvYQKzNH8bW430a+qBSTfi2PWzXIoATaCgq/6DJlCaeMc8ko5nyEnEXS3dEjQwInSSdv7U41p0YYE3HoCEK1M/FDeJj4mlSN0UfH+HejugIG1Hwr22U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766077913; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Zj0mzuU0PNmUCZox7mr347qm/kgViG9GhNzZj8IVk3Q=; 
	b=mIgYkXGUPXqwgKMenRHcqOhbanGuSjFarXsBbTBEntoemFgxNYDgAaXz316PW6yvK3AkTTDwOx1Sqzlq88YgNoFOsPCRyHrNnpCO0mJYW8wVFgpVig76t7KLk6dM89+e1uDU7ViNhQhBAqFU+eFlYyWlidmuKSiZ3B6TsvvaiMo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766077913;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Zj0mzuU0PNmUCZox7mr347qm/kgViG9GhNzZj8IVk3Q=;
	b=b8v64jU1FXDOSx9qAhDIGZhsl5AyUG4R/u9LL7SqwaW/J3o7eLkzRB0dEGHG9ulx
	ADNdm6z0Vg+xOdtTOlsFR7XSkor4lqllzj3numtZVvxb0w4U7tTImdou6bZHTb+Ytey
	ctiR7mZZutoCJ+m9Ru+ZmcG0JewXWYRqB54MOcg4=
Received: by mx.zohomail.com with SMTPS id 1766077910488906.5075250728979;
	Thu, 18 Dec 2025 09:11:50 -0800 (PST)
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
Subject: [PATCH v5 00/11] Convert remaining hooks to hook.h
Date: Thu, 18 Dec 2025 19:11:14 +0200
Message-ID: <20251218171126.588066-1-adrian.ratiu@collabora.com>
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

v5 is just a minor cleanup refresh: details + range-diff below.

It is based on the latest master branch. There are no conflicts with
next and seen branches, the code is available on GitHub [1] and a
successful CI run [2] is also provided.

1: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v5
2: https://github.com/10ne1/git/actions/runs/20274558658

Changes in v5:
* Dropped some REF_STATUS_REJECT_* additions which are mostly unrelated (Patrick)
* Made a null output buffer in hook_output_to_sideband() trigger a BUG (Patrick)
* Cleaned up the diff in patch 11 to not unnecessarily move hook_output_to_sideband()
  around, though this looks a bit ugly in the range-diff for patches 10 & 11 (Adrian)
* Two small nitpicks / typos (Patrick)

Range-diff between v4 -> v5:
 1:  b252d447f5 =  1:  8c16f1bcbf run-command: add first helper for pp child states
 2:  f6fd3b9b0f =  2:  5e6e05ba92 run-command: add stdin callback for parallelization
 3:  59c07b618e !  3:  3669acfe6a hook: provide stdin via callback
    @@ hook.h: struct run_hooks_opt
     +	 * used for smaller inputs, where it gets called only once.
     +	 *
     +	 * Add hook callback initalization context to `feed_pipe_ctx`.
    -+	 * Add Hook callback internal state to `feed_pipe_cb_data`.
    ++	 * Add hook callback internal state to `feed_pipe_cb_data`.
     +	 *
     +	 */
     +	feed_pipe_fn feed_pipe;
 4:  8f591319a4 =  4:  bf9d8680e4 hook: convert 'post-rewrite' hook in sequencer.c to hook API
 5:  2427717a26 !  5:  bdcc1cff34 transport: convert pre-push to hook API
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -		finish_command(&proc);
     -		return -1;
     +	switch (r->status) {
    -+	case REF_STATUS_REJECT_ALREADY_EXISTS:
    -+	case REF_STATUS_REJECT_FETCH_FIRST:
    -+	case REF_STATUS_REJECT_NEEDS_FORCE:
    -+	case REF_STATUS_REJECT_NODELETE:
     +	case REF_STATUS_REJECT_NONFASTFORWARD:
     +	case REF_STATUS_REJECT_REMOTE_UPDATED:
    -+	case REF_STATUS_REJECT_SHALLOW:
     +	case REF_STATUS_REJECT_STALE:
     +	case REF_STATUS_UPTODATE:
     +		return 0; /* skip refs which won't be pushed */
 6:  22467bb074 =  6:  9c1d5e8726 reference-transaction: use hook API instead of run-command
 7:  9b0b13379c =  7:  0b986bf0fb hook: allow overriding the ungroup option
 8:  cae3c984e2 =  8:  5f07d07acc run-command: allow capturing of collated output
 9:  0383be2ebd =  9:  c4ff1e2270 hooks: allow callers to capture output
10:  d8e234c453 ! 10:  15c831ca15 receive-pack: convert update hooks to new API
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
    - 	return status;
    +@@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
    + 	return 0;
      }
      
    --static int run_update_hook(struct command *cmd)
     +static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
    ++{
    ++	if (!output)
    ++		BUG("output must be non-NULL");
    ++
    ++	/* buffer might be empty for keepalives */
    ++	if (output->len)
    ++		send_sideband(1, 2, output->buf, output->len, use_sideband);
    ++}
    ++
    + static int run_receive_hook(struct command *commands,
    + 			    const char *hook_name,
    + 			    int skip_broken,
    +@@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
    + 
    + static int run_update_hook(struct command *cmd)
      {
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	int code;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     -
     -	if (!hook_path)
     -		return 0;
    -+	if (output && output->len)
    -+		send_sideband(1, 2, output->buf, output->len, use_sideband);
    -+}
    - 
    +-
     -	strvec_push(&proc.args, hook_path);
     -	strvec_push(&proc.args, cmd->ref_name);
     -	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
     -	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
    -+static int run_update_hook(struct command *cmd)
    -+{
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      
     -	proc.no_stdin = 1;
11:  6bad9aed4d ! 11:  4bd2c2974a receive-pack: convert receive hooks to hook API
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -		finish_async(&muxer);
      
     -	sigchain_pop(SIGPIPE);
    -+	state->cmd = cmd;
    - 
    +-
     -	return finish_command(&proc);
    -+	if (state->buf.len > 0) {
    -+		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
    -+		if (ret < 0) {
    -+			if (errno == EPIPE)
    -+				return 1; /* child closed pipe */
    -+			return ret;
    -+		}
    -+	}
    -+
    -+	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
    - }
    +-}
    ++	state->cmd = cmd;
      
     -static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
    -+static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
    - {
    +-{
     -	struct receive_hook_feed_state *state = state_;
     -	struct command *cmd = state->cmd;
     -
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -	if (bufp) {
     -		*bufp = state->buf.buf;
     -		*sizep = state->buf.len;
    --	}
    ++	if (state->buf.len > 0) {
    ++		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
    ++		if (ret < 0) {
    ++			if (errno == EPIPE)
    ++				return 1; /* child closed pipe */
    ++			return ret;
    ++		}
    + 	}
     -	return 0;
    -+	if (output && output->len)
    -+		send_sideband(1, 2, output->buf, output->len, use_sideband);
    ++
    ++	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
      }
      
    - static int run_receive_hook(struct command *commands,
    + static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
     @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      			    int skip_broken,
      			    const struct string_list *push_options)
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     -	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
     -	strbuf_release(&state.buf);
     -	return status;
    --}
    - 
    --static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
    --{
    --	if (output && output->len)
    --		send_sideband(1, 2, output->buf, output->len, use_sideband);
    ++
     +	if (push_options) {
     +		int i;
     +		for (i = 0; i < push_options->nr; i++)

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
 builtin/receive-pack.c      | 272 ++++++++++++++++--------------------
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
 12 files changed, 585 insertions(+), 292 deletions(-)

-- 
2.51.2

