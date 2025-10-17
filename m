Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB32F6911
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710637; cv=pass; b=hNfqJu9nicQStq9d9fex0NRnL/spAu7koAwRxcYnRbbIaAAoFr75XLx3jHVMZq+xmeg8ocjz3DMcNYdskm499F3pWViVoqWoKiY74vaGM+JyTXZrd+xHmGPIVrrRMDEOm3B8Pbi0I1miDNcs5g9XB7pu7Zblq/FpQFMXQiMAd6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710637; c=relaxed/simple;
	bh=TZM+Xw7tkIHHJo6uyIwij84YbPSi7RIB7VuB9+y27Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlvAF2dZUEL/bjHOpG48Tcw4oUCouz8BQIuK1/cZJy2eX3BTjoRRHtA6V7zqLgrWcZIxCLBdkHtoeBZ/aXnW38lIMOYbeubZaLTZ7XhrhxX0Ok46XFatl8mHSO4MiFvKOHh/JYEjc2KceY4sNufSX212U7oIQpX3iYFUJ1xirtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Lg130Tod; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Lg130Tod"
ARC-Seal: i=1; a=rsa-sha256; t=1760710625; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=biFxsoD5Mzf9LQgaghwwjLVjVO761+MYMp5zU2uubgvLJRlXK+84AnSDfKD46AvgL9rYdwuboS9HcQOnFMopkU7k/lNSlhiqeA+Jim6gdjOFbdLzfDPvPVct9XQiAOn1voD3wZmKKzzVtEJsHIMxfSAuArRLp8TNW4s8tcTSe/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710625; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uz9UFANagPyYj8j3emFNjl5SjmqECAV42lc4tEFv9zg=; 
	b=fzGpPFEPKenktqnEBYUOy16/9qqVITp9bd0+yAlJdO9JUsFAFyEaeck6ltWVtHFQfNZdsCmeqyetFWg/KrlIhVjSyxGuSiHwteFw3IOX7TtthCxMprFAr2l9EKLvQFe7di+QsinSq/DrtImRh1uZ9gM1ckadL5omR89W+hKP86s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710625;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Uz9UFANagPyYj8j3emFNjl5SjmqECAV42lc4tEFv9zg=;
	b=Lg130Tod/y2VjYNLR4N8jZAZBuZSqrb/3zAtomEelMg1gy2hbUdNYTk0yMGfFsw3
	XMKACwW5VOMMQNp5WoTn+oClQiNEbJCdc1933t1u6Wvd1z3YIZtL3/tX6w803d+eu27
	NMg5qP4/do1lEIFd9HthSqT6wOdU+ivbINdfxwZY=
Received: by mx.zohomail.com with SMTPS id 1760710621495805.4299807071867;
	Fri, 17 Oct 2025 07:17:01 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 00/10] Convert remaining hooks to hook.h
Date: Fri, 17 Oct 2025 17:15:34 +0300
Message-ID: <20251017141544.1538542-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
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

This is v2 of the series which converts the remaining hooks to the new API.

I addressed all the feedback received in v1, with two small exceptions
(the ones starting with "Opted not to" in the below Changes list).

I had a minor conflict with an upstream change [1] which was trivial to fix.

I added 1 new commit and squashed together two commits (the simplified update
hooks), so in total it's still 10 patches.

The plan is to follow this up with another series which enables config-based
hooks and parallel hook execution, where possible.

As always this is based on the latest master branch, I've pushed it to GitHub
and ran the CI pipeline [3]. The Win+Meson "missing libgitcore.a" and doc
"invalid escape sequence" failures seem to be unrelated, since I get them
without these patches.

1: https://github.com/git/git/commit/22e7bc801cd9c5e5b5c4489b631be28e506fec42
2: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v2
3: https://github.com/10ne1/git/actions/runs/18593709082

Changes between v1 -> v2:
* Added a new commit with a mechanism to override ungroup options (Junio)
* Addded a BUG if hook path_to_stdin and feed_pipe are both provided (Junio)
* The feed_pipe cb can be set independently from path_to_stdin (Junio)
* Simplified the post-rewrite callback (Patrick, Phillip and Junio)
* Document that hook caller owns the feed_pipe_ctx (Junio)
* Removed unnecessary "child" -> "notes_cp" renames (Phillip)
* Reuse strbuf inside pre-push cb to avoid multiple alloc (Phillip)
* Simplified pre-push hook cb logic (Phillip)
* Rewrote reference-transaction cb logic to mirror pre-push (Patrick)
* Simplified the update hook cb by removing the keepalive logic (Emily)
* Squashed the simplified update and post-update conversions
* Iterator types, if conditions and other small fixes (Patrick)
* Fixed a conflict in refs.c with an upstream for loop sign compare check
* Opted not to use -1 to signify no fd value instead of 0, because I'd have to
  significantly rework the run-command.h .in/.out/.err API (Patrick)
* Opted not to move sigchain_push(SIGPIPE, SIG_IGN); into pp_buffer_stdin())
  because it will called too many times inside the process loop (Patrick)
* Added Helped-by: Emily Shaffer tag to the reference-transaction coversion
* Comments, typos, stray lines, commit rewordings (Ben, Patrick, Emily, Junio)

Adrian Ratiu (2):
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
 builtin/receive-pack.c      | 289 +++++++++++++++++-------------------
 commit.c                    |   3 +
 hook.c                      |  21 ++-
 hook.h                      |  36 +++++
 refs.c                      | 101 +++++++------
 run-command.c               | 110 ++++++++++++--
 run-command.h               |  42 ++++++
 sequencer.c                 |  42 +++---
 t/helper/test-run-command.c |  67 ++++++++-
 t/t0061-run-command.sh      |  38 +++++
 transport.c                 |  83 +++++------
 12 files changed, 557 insertions(+), 281 deletions(-)

-- 
2.49.1

