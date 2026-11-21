Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291442;
	b=5NR1KOLQQg5bfA6iS1Yd1KKQjnlVVNAWKGeGqEA8cdrSQ+QNkdfR+CkrdmNWNHJhvM6E
	 lJ8CSbx2oQf8kMy5ZBxvKGh1duY11h8NIFEfDNjyds6Zqj490AdSWIQvMmtP2F56yjwKz
	 wZ+9aAmm3x9Ec/1V0H0IyhYgUFRs2BYZu3+9xuLqz2r1FUmQn1d0qW3v61KKxZCz5bFFp
	 mv2SLcJybhWT2RUVoXT85iE8bLQV0BaNmd+/KiT8Ei/KKsggTWdbGfp32XXYCYDxwUSb1
	 atZfrxQLZCsdTGQCE63bm2zw9xKujljM2lkpo4nTx50lEWqwHNoS5/qmFW6kmqjmQzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291442;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=N8U2wjvSlgkFcD3Q2xxFrde5JLUy4jP3D/BZSZx0xtc=;
	b=D9+CqOOd7WLJsBSc2cdcYeetwU+iVtD0mmAnWPup1ZJBIdopxgeVYS1Kxx8MSIas213w
	 a8p0zXm+DX8e01LecLKGCPKDu5QhC8XGPDs2b+DNDgtwTG+4OUr1BQJpDiomNZHeOGRTi
	 lySEqNfpESu0ZQevQeB5pvwKXFwRNYWDtgGzAinNMZx62QIlSM/bJ36FuR/9wJAJgof2i
	 uQ6dupej5YX+e5tWbvg6cHPkovz3XB5lCL1HTPzomml8xd1ZPcffXtrdMUGFz3LQ1+Xzu
	 X7vSmbVU47GzdWrwR+iZJ0BQK7E4AVRm+SzuXRS/bQY2JhQGRFF1va9oSNzZrdufYAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SddOAw7Z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iznhe6re;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA3606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7FA3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SddOAw7Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iznhe6re
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03B9414002DD
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:04:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 21 Nov 2026 15:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795291440; x=1795377840; bh=N8U2wjvSlg
	kFcD3Q2xxFrde5JLUy4jP3D/BZSZx0xtc=; b=SddOAw7ZSMR3N73f/DHFstoSvC
	PHiCzZ8bS48/f3PJJ5RBaB2NjmgS6gsS8jOGp/geIDJsaEgjbsZDrX3i5F7fSIDC
	CpY1JawI2gMySdyPwq6eAlJu52Ca08ES3LYxb/klJOGw1I51nMp/73Na3ORcclaV
	DivQ65RqkvfxeM/s8a4PWAlCgTWogD6bxGjt8Suy/Ma7kH4WOaj8P7qMAjUxy8Mq
	KozVm0ikn41n81l0CoBtdyFoZBLjsdN0m4ovOTXtZwFOeBgX2wbnYWG070C7ejy2
	icraXJLWezrd6+QKgHwgPHeV0tsWoJaJ7bBECtooUra09eqhyMcs4iOv2Apw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795291440; x=1795377840; bh=N8U2wjvSlgkFcD3Q2xxFrde5JLUy4jP3D/B
	ZSZx0xtc=; b=iznhe6reS5Ool4RTJYiICSisNCfV7sq30GX+PZ4GUPrwhCM2CwW
	dEpbRFRWIsVmiGCGwzgHCSP8tqo9otI8PSUCJ1M/id7mcrq8l6Av4p0BTngUlpM+
	WnXt/SQjsujMs6eNQUeWBrJAUJI/lWig61Vgc239IxQq87Na2YfaQ18aedBuQ5y8
	lgwfoMlMQeWzzKnmVVhZ1YxsV+E57Vg7i18+dzTunGiDp8RzUesweW16DfNrES3L
	HlK9+9bACZ9WgcZmzbsPNiRfvshCx0x9MLz7tkFUHyomd0CA23ZZTcpy/4dUlNMw
	7v6g+uACubsUiKFD/BP8zr0Y7XHtzCk4DRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795291440; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NmxbZ2by0THGsINTD5Gwyv4/CzN6W/f2FOX+Hs8KkEv3m1V
	M3qxWodG9lT5nbAH9LQelI3n6IyxPUf3iQCRTcUnLPprSx8I8Yrx1D++XJ+t7O6A
	TpEEqU6uj0b+EvgtiEKFlALM2lCz9hOGmPJMN3fVmvt5EczMs3xogsRwfWI6WvCO
	6SZ2Vr9SWsQwfb+T/9OORzwOLDH65QmATTmztDodS0yXyoFQ69NSkXQ0tgjqeLFt
	mKR36tZ/pIsbY0BHN8y7sTbu9pA/1KPFHtF0zVFQ7PtOqjn1zcVypEWlhMFUgVrY
	07zHzpZ1jTV1Xhk+OnmQvfEu35C37EmyZFuY0OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:F36wmw54oBtkuEnNxdYsdje+p1jp9kZxXX6yoQi6XIg=:gHXgfLu9wSt0/BPZFOA+tQ7L6W/IuhejGgiHdLSvgBg=;
X-ME-Sender: <xms:MPkBaxuYzoqmSxKoNUh8RJM968Cspo8sA3lv9QiCam5f5bb6CbXnCA>
    <xme:MPkBa78vJN_jUNDZQMzNYHKPJM1H4ADL0Vi9pH1xCnmiBQd5URUEkj1nKkqSB3ioB
    4tMkCllmnAZqvRLmahHVUKWjjzDNjau_Kn6VdCEPHXF0d1Px1RFFgc>
X-ME-Received: <xmr:MPkBa02rd2DfVB2kA2Iybc-t96ajRhdS0Soj-hY5LTqcf4b5UYj0tF-8LCIvNc3eqRyOSbWvzr-QzyCt-7GZ4gjXIgkFlifwDe2i>
X-ME-Proxy-Cause: dmFkZTFciVlM3t0iGANk4WcCYhargZg2jNQUEhwo22iPB32vgsuekmFevztc/JKQo/76Dh
    yklBUtbXCw4Vd1A0fzrg1Mq5h9lqDbiftwrwryFyfY2EjkBYBqtuPr1D0grVBj5quOa7Ld
    D3JhwQ9LiixWxVTtnBVrOJ5I65X7iQ5GHJv6UD77H6M7XQ/Hgjk1NEOj1p49tCM1qsBiz7
    A3rDYXMwveISv3uxnJiH+RC67QTXCdOfIhqrxw0D6vqAlffFqn7alJ9DuMUJf2xeK7A9eZ
    mWKdiNVhUolJ4lVZw2tXlLqtvh1i4qTEebtx3R8wL9zspOaMFJFCSIXGMdrqOPmIcjDfBD
    hjsubJxsoPJLLPchobS2A33xJPAqS8u+ycqiZzscW0PFCg7+ciw1PpHFjpX0DrnEAeu4Xe
    TLQ0uIG1PQoVxVOCpZe3SoFwvtpJM26BGmsLVdTa0B40zw8YP7QupA9YZhOeG1bZDGiwD6
    Sc40S+nHXH52SSz3KO/Z9mAgwdAmVL5zLJ0OAglePN7sWfqF2piWzKM1qpg5ZenAldeUyX
    deba3LXTsE83XWvHHGf/qz5L4rV0UPGl4C6MO2+c73KjfD6/c0ScgjcoHg94OYkq5QcA20
    fKKmONNzxl5gZEBU3Wl2cy7D4rcoA4/pjCjijZ/eCC1oKCGSKZ4z/jUNY99A
X-ME-Proxy: <xmx:MPkBa4B300u1LREBb2n2QCfGSh8Du-RY3bOxv_Ek_qTlq4CVfkNLWQ>
    <xmx:MPkBa4cpoMYcr1s9zwFyasVcVY4QYax0LFSzTTMde3fuskWOWbQT1g>
    <xmx:MPkBa945ZslPdlSFzxwX9k-naajy-2j36a24qq-ofN9I5hqwm6U67Q>
    <xmx:MPkBazVy770ECQ5WWwhsG2FLiFuOtB8KjgMyMa_nyxSYDwa0N6hdhg>
    <xmx:MPkBa6YAlx1GqmdZ8u8HuirR4zoU7xk6rm9gKp5QSbzbYRVcCOtZsj9Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 15:03:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Wonseok Oh <wonseok_oh@korea.ac.kr>,  Wonseok Oh
 <marinelay7@gmail.com>
Subject: Re: [PATCH] fast-import: catch missing data after inline M at EOF
In-Reply-To: <pull.2323.git.1795246845186.gitgitgadget@gmail.com> (Wonseok Oh
	via GitGitGadget's message of "Sat, 21 Nov 2026 07:40:45 +0000")
References: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 12:03:58 -0800
Message-ID: <xmqqeccekl3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If `M <mode> inline <path>` appears at the end of input,
> file_change_m() exits its read loop on EOF without reading a `data`
> command. It then puts an uninitialized stack object ID into the tree
> and exits 0, leaving a tree entry for a missing blob that `git fsck`
> flags.
>
> note_change_n() avoids this by calling parse_and_store_blob() at EOF,
> which dies on the missing `data` command. Do the same in
> file_change_m(), and add a test.

This reasoning seems wrong.  The reason note_change_n() can afford
to call parse_and_store_blob() is because it does not loop.  This
codepath needs a separate solution, I am afraid.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index ab5d2a2344..2b271222e1 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2456,8 +2456,9 @@ static void file_change_m(struct fast_import_state *state,
>  		if (S_ISDIR(mode))
>  			die(_("directories cannot be specified 'inline': %s"),
>  				command_buf.buf);
> -		while (read_next_command(state) != EOF) {
> +		for (;;) {
>  			const char *v;
> +			read_next_command(state);
>  			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
>  				parse_cat_blob(state, v);
>  			else {

Imagine that "cat-blob <object name>" appears on an incomplete line
without a trailing LF at the end of the stream.  The updated code
ignores the return value of read_next_command(), which would make us
loop forever here, I suspect.

 * We are about to read the final line "cat-blob <object name>".
   read_next_command() calls strbuf_getline_lf(), which returns 0
   (which is assigned to stdin_eof), stuffs the incomplete line in
   command_buf.buf and returns.  We have "cat-blob <object name>"
   in the command_buf (without the terminating LF).

 * We call skip_prefix() and call parse_cat_blob().  It does its
   thing, but does not do anything to affect this loop.

 * The loop calls read_next_command() again.  strbuf_getline_lf() is
   called, because stdin_eof in read_next_command() is still 0.  It
   notices that the underlying stdin stream has already given EOF,
   and returns EOF.  read_next_command() reacts to this EOF, sets
   stdin_eof = EOF, and returns EOF.

 * You updated the code to ignore this EOF.  In the meantime, nobody
   touched command_buf in the previous step.  We call skip_prefix()
   and call parse_cat_blob() with the same "cat-blob <object name>"
   that lacks the terminating newline.

 * The loop calls read_next_command() again.  strbuf_getline_lf() is
   not even called and we get EOF back.  Again you ignore it and we
   do the parse_cat_blob() dance once again.  Nobody will get us out
   of this loop.

In short, you have to pay attention to what read_next_command()
returns, even if that does not mean you have to leave the function
immediately, I think.
