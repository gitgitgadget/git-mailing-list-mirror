Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088834;
	b=E6ZsFNRQ/RlfLrVFoPXdm0mH2lJP/dxNyXMKaTXkh2qzoC/UTHnL/AsVUm0aoToIwO0H
	 DfRHKHV9DLLlLVRtD5UN5WjIXYwtvtIBh9rznfEx0UKNQLud7kkkvDQ4ftob1/sxHugpj
	 hHZIT8un7JMJ8+qTUQ88y4SIrlxRRWoTRi3MeDJvBZWHFFw6/SwA22+TaeDzrx057iwS7
	 DV28aw89alz7jAJEI2F1O9wjd03c5CChXWErFxzeAhcp1Mx3DbUCb2jH9rafPgamrbIqk
	 ZDiu+HAVIkbHTuGPi2oHX4grdlnXeHXoLzRS6m37ApqlvRx46AlTptYYBwEZ9n2KImQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088834;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=Vkzd8jjy/3JBamYRf1xTnBQSUBKZY7XtNTIt/BCnG5s=;
	b=4pzJd3IU/mkYftVip3uayM28oNjsQOdz5aT94fzEGTbeVCE0hWDPT04hJabwSjg3ObEX
	 UjrN7PIRcqjAt8aYLX+Y3i2FbbGIHtUbz0u8iQ2GyZWRCSdK8BLKD7AMIuDPa9noUNoDg
	 +s/d8wf26xRN+u0j/5qkhj0LfMEVzOwtHvKuSs5rk1xHMhDqDbgcJIHW+ZaDtF/pPpTf4
	 CKGaMOF76Z4KViSLPnC400MSEt7pKERYYYL4+u6niUhk9qeQVY6k+/YaZLQBViXlbX8nO
	 tvgW1mrMzBuYQEWnQsfqDltucxWgfjIxLUdfMrCEn9bg3IOKRBwJtAOHRgK9YqVEpZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nRlCrTsn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o7QnESL0;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB9606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DB9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nRlCrTsn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o7QnESL0
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F9AC14001C7
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 06:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088832;
	 x=1795175232; bh=Vkzd8jjy/3JBamYRf1xTnBQSUBKZY7XtNTIt/BCnG5s=; b=
	nRlCrTsn7Z4dJvQG6fpgTlTs+1QtjIWwKKr5YyNY6tmd6SK+aheRNm/785Ypdf82
	JgR2yk91fCySd8NPSvWVB+B7YvYfoC/VsMxIrA5lRiN3aS4T3iTLXL5pKMAIEYQF
	slYcwrmmEvteVAK2wD2Bw8Mm9ydyWXxJDbW4YAVAJSx/C5R6tZOuclkIGAfwL4k5
	t763cVPttqqE5PHQpLviSM7Xva7hThMiNXWWJZmo4BC0InpRxJxsG/L2NnfyJFau
	rvQnSMzIGQGv49yjcz5tUB7c9smDlw8uv/HX7c9j2B6nAGDm/987B2k7YU7ghUPV
	1yzXohE4SO3BCAjjxqtCMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088832; x=
	1795175232; bh=Vkzd8jjy/3JBamYRf1xTnBQSUBKZY7XtNTIt/BCnG5s=; b=o
	7QnESL0Lt+GWZu9qhgKXzQCazEh3JGEU3dUYjfCqJqKAxgiFTDt5ZXN2pGobw/Wz
	6sy11BkQwTJHKKNqQKhcIWE/p7+waR5KZEtlE4/mB56gk1uxmaEqDxuE49+ySSO+
	MXIj7twpcXS2VYjE3heGOiFwYgFtcdtEGydesh+ifJouS+VJfdzv4ZF6AJPW8y6D
	n0CvQoJw6kGY+v+MR27/V3f8TaTrWN0JIxt8R1zBQOnIZj+E7hulT8xrbxmZeTRL
	cM52TK6/QqwPfBWicNBNOakgvSFOz3ufygk7cKMGr9q3F0PG7lP6xXeC/Mz99GR+
	OyIAxxbxHHKCJdsAKeLuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088832; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:c8oMxlNuWhsT1M98e8gX2ReOhBA4xquihYuWTjmiYlJM9YR
	vCI6PhPh5zWCMbmNwKhrVNBkSIkbdIsXrLYUqBJNmtCV4/jQOv2YFq2Y3H8ou/Em
	9y/Z+8xGy2wI6a/3psGG5kW1fipPN2WZrwQ+w/15sVYC0jUZIZFn9ytgBnsTUoLn
	qZxUqKDED+Ld1QZUa55FVZpZPKe45Oz/4E4UIxMby34hBFO/rc+9wOo3hHqwLbSf
	FlbZgKxywgoQjZmhDkZP3krkRkp/YU/7hj06ejxb3s0AkhTn9526ASFPeUoKINeD
	tnfgSlbsj2/vK6zRLr27ugbd25GC2THIZAl5IBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SBz6Be//Z/hkscs9IqRSJB4CVHlIT0a6mllbU5LIG18=:vE+xcBTwMlTLL5VbFvRG0qGSth2YeQCfokUbN4BD/oo=;
X-ME-Sender: <xms:wOH-ankq-TLy-li3ml2_wql_2tBRJJzVJ8X-k5IaVEVYxSDHapBfAQ>
    <xme:wOH-ah2M-givOq6R5p7HhBaZisXF4X1yt5uhJRv9ZF6ARE9i3AcGK_xKUr4UHiRzJ
    QymZPxxj5SDUzpLQiovQncxwNHZD1gQ9EP9YGpwmpZU-hLYWyOFPAQ>
X-ME-Received: <xmr:wOH-airENatmElKiR_WLXaYMFZWUuUG1HHoFoCLjqLX8z2CL8kJOdIaXuV2WxQ8IhGiqORI>
X-ME-Proxy-Cause: dmFkZTF91qv5hQOPwhdrAURKAKLIlqVTXlHbeHpMhQSjGFL9zujtl6Ye0U30jM3jPwUTmv
    oQp/juA5+JqZhkhQGOYYNIvbl97k4wzpgmqjmpYTvtJCgC5NzypPPNoAtRlib6cg6b2iY3
    mXQqCr6dJqJgD/ByZo9gJdniY+8MklWB/bKz718ptoOc2rQDeuclxsilVadAFAbY6v9slx
    9+17uNURMHA7PMzGY+PYzvzmXSL0lcJP3nSk8Hwhb5J9ESjyMPKPdNDEhTmFCfpgdKh6gf
    aR5nqdjBbLDahxw2N4F0dexub80nL0VtKHpx/VKeeFmUSwVTx5ocFA3cpumwTJeYoriFTw
    uQeX/hBVSvkNJq4NIK3B7n1hlPecJml2Y/JMhuBR5IV0ybkRytihACWFVlN2ooL1pYFri3
    4w1+gLznW6S9RCAjwbFQYryKfBfDsNDLexIQCv4UiBFIb25CFxmYvV/DdsJNs3RtHlQyKu
    KDBdc+0ljKEQG60dDO7ES0OZLw+CxM85SPMm9EcGSDd/03K2tyvk4QTVj58I0LplcKeuP1
    a7qHrUAyfCJ6ZBKcklNxs6+p2NhZi0gQ8+ehaN1mgQFMOT/xfek3E81LldKbAWNAiU0sVW
    7QFDJSIELMGcc4Jxdpl6BKTwR83da+Am0/y9R3Rn/y7pivjjWeAWwyzw3XlA
X-ME-Proxy: <xmx:wOH-audP-k_u3sIWHwvPFlknUflteqTcn-Rwv46NoIiPJrT7J_s3xQ>
    <xmx:wOH-ahrFkpkiXD6YfZTqinPEjVFJO-XfFtDlmlZ49N2Ofq7WVSc1UA>
    <xmx:wOH-avGVIc8co4uVeHZ9kfv7J9-mk5Tx2Vxp9mO4yA_d1uyyX8R63g>
    <xmx:wOH-ahtxGh54NMymQ5fDzYQZ-yPkZFB2ANJ-NscoGoyyBR9fJTt3iw>
    <xmx:wOH-auICvobgkYCuhsQYGNDfXzuFxhEYung0zBJkUy4CNsc63NY7VXHC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bd180ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/13] builtin/rerere: convert to use subcommands
Date: Thu, 19 Nov 2026 12:47:01 +0100
Message-Id: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPzY7CIBQF4FcxrGXC5a9XV/MeExctXJQxbQ1oo
 zF99wEnGXXRTGBzksN3wp1lSpEy267uLNEUcxyHEsx6xdyhHfbEoy+ZSSEtCNnw0zHzRPXwfOn
 c2Pft4DNXgF6DMUorZOXxKVGI1wf8tfvNpf5N7ly12jjEfB7T7bE8Qe39OzIBF9yjsq5cEs58l
 uJH7FldmOSrsVk0ZDFE403XAhKifDPU0wBhFw1VDB0CWO0xdAhvhn4xABYNXf8ShMMuNBsC+2f
 M8/wD4VSY8pcBAAA=
X-Change-ID: 20261027-pks-rerere-subcommands-318d41553438
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

while reviewing some patch series around git-rerere(1) recently I was a
bit appalled by our custom subcommand parsing that we do here. This
patch series here thus cleans up and modernizes that part a bit so that
git-rerere(1) behaves like every other Git command that happens to have
subcommands.

This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
rerere cache state, 2026-10-23) merged into it.

Changes in v5:
  - Explicitly docmuent the change in behaviour for the "--skip-lock"
    flag.
  - Add another patch to fix our documentation of `git rerere diff`,
    which has been stale for the last two decades.
  - Fix a regression where we didn't print the synopsis anymore when an
    unknown subcommand is being passed.
  - NULL-terminate argv.
  - Link to v4: https://patch.msgid.link/20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im

Changes in v4:
  - Some more polishing for `RERERE_{NO,}AUTOUPDATE` documentation.
  - Die in case both of these flags are passed.
  - Link to v3: https://patch.msgid.link/20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im

Changes in v3:
  - Clarify what `RERERE_NOAUTOUPDATE` does.
  - Link to v2: https://patch.msgid.link/20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im

Changes in v2:
  - Document rerere flags.
  - Rename `rerere_record()` to just `rerere()`.
  - Link to v1: https://patch.msgid.link/20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (13):
      rerere: rename `repo_rerere()`
      rerere: convert flags into an enum
      builtin/rerere: drop `the_repository`
      builtin/rerere: stop passing flags to subcommands that ignore them
      builtin/rerere: turn "forget" into a proper subcommand
      builtin/rerere: turn "clear" into a proper subcommand
      builtin/rerere: turn "status" into a proper subcommand
      builtin/rerere: turn "remaining" into a proper subcommand
      builtin/rerere: turn "diff" into a proper subcommand
      builtin/rerere: turn "gc" into a proper subcommand
      builtin/rerere: use `OPT_SUBCOMMAND()`
      builtin/rerere: introduce proper usage strings for subcommands
      Documentation/git-rerere: drop claim that we pass args to diff(1)

 Documentation/git-rerere.adoc |  11 +-
 apply.c                       |   2 +-
 builtin/am.c                  |   4 +-
 builtin/commit.c              |   2 +-
 builtin/merge.c               |   2 +-
 builtin/rerere.c              | 328 ++++++++++++++++++++++++++++++++----------
 builtin/stash.c               |   2 +-
 rerere.c                      |  14 +-
 rerere.h                      |  43 ++++--
 sequencer.c                   |   4 +-
 t/t4200-rerere.sh             |   5 -
 11 files changed, 309 insertions(+), 108 deletions(-)

Range-diff versus v4:

 1:  0bb466edb5e =  1:  1587a58d92c rerere: rename `repo_rerere()`
 2:  cc7e58429b2 !  2:  9ae3253dda0 rerere: convert flags into an enum
    @@ rerere.h: struct rerere_id {
     +	RERERE_AUTOUPDATE = (1 << 0),
     +
     +	/*
    -+	 * update the file in the working tree but don't touch the index. This
    ++	 * Update the file in the working tree but don't touch the index. This
     +	 * can be used to explicitly override "rerere.autoUpdate".
     +	 *
     +	 * This flag is essentially the reverse of `RERERE_AUTOUPDATE`. It is
 3:  85299db3099 =  3:  e87e54d9b8a builtin/rerere: drop `the_repository`
 4:  2f41c69859d =  4:  59ff81ab701 builtin/rerere: stop passing flags to subcommands that ignore them
 5:  461e1c0848f =  5:  214ba91b19a builtin/rerere: turn "forget" into a proper subcommand
 6:  09bc2e4b0da =  6:  e8f7fe874e7 builtin/rerere: turn "clear" into a proper subcommand
 7:  6d058b1cef3 =  7:  e63f6f77887 builtin/rerere: turn "status" into a proper subcommand
 8:  cfa7939b6b0 =  8:  893cd386a4c builtin/rerere: turn "remaining" into a proper subcommand
 9:  13f60ac35aa =  9:  b7ff0206cac builtin/rerere: turn "diff" into a proper subcommand
10:  f33edb14768 ! 10:  c40013dcbef builtin/rerere: turn "gc" into a proper subcommand
    @@ Commit message
         proper subcommands as supported by our parse-options subsystem. Refactor
         the "gc" subcommand to use parse-options as a preparatory step.
     
    +    Note that this results in an intentional change in behaviour, as we
    +    previously accepted the "--skip-lock" flag both before the subcommand
    +    and after the subcommand name, whereas after this change we only allow
    +    it after the subcommand name. But that flag has only recently been
    +    introduced via 5f6b6aa3ab4 (rerere: add "gc --skip-locked" for auto
    +    maintenance, 2026-10-13), which is not yet part of any release, so it's
    +    unlikely that anybody will complain about this change.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/rerere.c ##
11:  bb81a6d1d53 ! 11:  be17f9cc9a8 builtin/rerere: use `OPT_SUBCOMMAND()`
    @@ builtin/rerere.c: int cmd_rerere(int argc,
     -		flags = RERERE_AUTOUPDATE;
     -	if (autoupdate == 0)
     -		flags = RERERE_NOAUTOUPDATE;
    -+	if (!fn) {
    -+		struct strvec args = STRVEC_INIT;
    -+		const char **args_copy;
    -+		int ret;
    - 
    +-
     -	if (argc < 1)
     -		return rerere(repo, flags);
     -
    @@ builtin/rerere.c: int cmd_rerere(int argc,
     -		return cmd_rerere_diff(argc, argv, prefix, repo);
     -	else
     -		usage_with_options(rerere_usage, options);
    ++	if (!fn) {
    ++		struct strvec args = STRVEC_INIT;
    ++		const char **args_copy;
    ++		int ret;
    ++
    ++		/*
    ++		 * The user may have either passed options for `git rerere`
    ++		 * itself or they may have mistyped the subcommand name. We try
    ++		 * to distinguish these two cases by checking whether argv[0]
    ++		 * is a flag or not.
    ++		 */
    ++		if (argc && !starts_with(argv[0], "-"))
    ++			usage_with_options(rerere_usage, options);
    ++
     +		strvec_push(&args, "perform");
     +		strvec_pushv(&args, argv);
    - 
    --	return 0;
    ++
     +		/*
     +		 * We need to copy the array as it will be modified by
     +		 * `parse_options()`, and if so we leak the strings
     +		 * referenced by `args`.
     +		 */
    -+		CALLOC_ARRAY(args_copy, args.nr);
    ++		CALLOC_ARRAY(args_copy, args.nr + 1);
     +		COPY_ARRAY(args_copy, args.v, args.nr);
     +
     +		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
    @@ builtin/rerere.c: int cmd_rerere(int argc,
     +		free(args_copy);
     +		return ret;
     +	}
    -+
    + 
    +-	return 0;
     +	return fn(argc, argv, prefix, repo);
      }
12:  d9f0b174247 = 12:  7b85011eeeb builtin/rerere: introduce proper usage strings for subcommands
 -:  ----------- > 13:  ce0b34c4aee Documentation/git-rerere: drop claim that we pass args to diff(1)

---
base-commit: 710910c03a22ac663885049213b9fef5853ea8e0
change-id: 20261027-pks-rerere-subcommands-318d41553438

