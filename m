Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623890;
	b=PdWn1lAdamCeIzTCtBlSGCWr2EuCs4f1ej4+4ORFkB/wtlw/ZZ6YDoLwrF/gFQ6DxMdP
	 zk5oy4ApAOeTCbISWLZVCD+PzURs8JUSI/P8zIF46DIbLj8EH3e6dUyvYozdcce+3cGvZ
	 RpJh1dOEszhcILBNKKkAoKzmVAFMYOh+wPjwxk3UWwlC7yYBohboLU2Sf2AvD94NnGIim
	 4GLW2ba+vLvlq5572m7WcZhB/Htw+X5wzintKwmnbWdN9xSJWJfqCbqr0opYMS6NYuE6w
	 bMYvwbQ0gydzduv13NfiiYAffG+3nEaKdCiWRFcpM7YPzNxb6svRusW4uzK5cRz89kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623890;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r5oORY9wsnfPK4aYXH1ki1pUTuZgetBvSOMfGZeUt40=;
	b=D0XTl1Gx7ZmLtMPzJDiti08Sm3wFM45Yh+hUjt4hd+bG4fWL5fds4qk69ZeTmjeU59t2
	 YmeLsweA1o4tycIPiAh88d2HETo56PUysbY/fmkezvKL2EwxIJ9GBoRV9MjEQgAqepl7B
	 Dgr6/GMR3LJGda/ze5lrTrlcsJksKmrV3omZ/z+N5nxDPpOPVjOl0asDclrocHSgkbofU
	 xSuu2fosFOL4j/uOPvSf4VETbOPb+JxtC5yudiE+mQKLddeKYRC6sQ9gtpVWVlJXXb3oz
	 6i/7JSrC+VgcFvjIfF1XH01JwZZY2PCkXXeu/1i/I8fEZdk4Ajx80OBweRsj7kqVnhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=SVnVHTwo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="L/UEo1NN";
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47375606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47375606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=SVnVHTwo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L/UEo1NN
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B63A1D00046
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 07:51:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 07:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793623889; x=1793710289; bh=r5oORY9wsn
	fPK4aYXH1ki1pUTuZgetBvSOMfGZeUt40=; b=SVnVHTwoJjkQd+Qn9uEYrNLilj
	cROeT4omTmZOyalRpJjEpF18Df5xxcz/C7TjXs2ikM9DwWUINwyLy+SAazUj2IyG
	ELkHUUXGE3ofx0tMzBpmWMJUWnNkrK1U05l5Ic2LF8OkR4B+OS2gsC3dCCLMvQ9x
	5myl0SNwnhMYoo+4hYbc8N2gQ458Tgm+TIMAgF2rqE/GiuPU+JZxXJ3fVBRD8hYX
	MqmoTGckg4v2duuIwtCnsh/qW8JS+I6Q6MNFuFFCjXbKlIF2Mf0FCY6/wUIlC8VL
	PHHM1+l3us4kvBiJmTGfBfhOUhg3o8sHztXC8I1654O3zGx/pYM3LsjzOWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793623889; x=1793710289; bh=r5oORY9wsnfPK4aYXH1ki1pUTuZgetBvSOM
	fGZeUt40=; b=L/UEo1NN7t4ZS4fMrg2QtAvhu76SF1TvsYWF1+d08maZpHQjwky
	FP0mGCz9qRxfvKgNG0ooPvebncqHk96bhNfFfIw80DRMCrbc4xJHDe2SsbZbnYK3
	yTJnhZdrk5P3XVt0tjCrzzl5whk2JQnkNta/9ZNVR93pNL3jN1HHAwwcctFmTniz
	ihL9pbTp2cWraBUbVJSTyirsa7y/zDAQ79VR99yIxjtOzB4pkrSGGjyGONM0Xk4U
	y4oUT4MT6WQVn0kkIJVz8hMpbdfLJ0u0lHc4F58WNd7yUDIRkgXCDZOnUrVh5xc2
	u6HdeVPAVHoqZYmcuNNExRDE6d/faLx5jeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793623889; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OP52uXuUaOIVjXEXjH7DfkJoa99W9/TCDKw8Ddld8EElBpO
	lqVS9PCAU8REAGeENA0RIDvnN3lZLgkjFPte6/zCgpu9drAZcAEsqmCVt85cxsb4
	zH2v9yGoGDSF+pM5Mo5UqA/4ybPztve0JN7rJDy/AU4fDrMHfhoke/bK7iPGIoSQ
	vac3LuSPxghubJcddsjbb8Umomdne16n8bCeCB3nfd6LDJX9oh/2RHdyKiMh/dzP
	m4gN3zM3XSpFC//x2li6vXXYOd1FPmyQyFGz0+NAsPR3Rl3vCTYa2lfwcxqwvmw6
	anTMCwCCiQGs4AGxTkTq3isSDpDzEXvN7ykTEcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2GEL+NCOlCazsEe4E4IxSH+lYR5b/KvRRMDQetIOPvE=:XoW8I601f3pgJb4w81ZyNxrrsgKuMK2tQM8efLu2CmE=;
X-ME-Sender: <xms:UYfoatQMk6as_E3HHr4tUXiA_HxaMI4tJT1vmPPqI4ssRsWfvYTqaw>
    <xme:UYfoatrUv9Alb1NifyslMnGpt-V82ImMDAaVVGkWZDAejoAiyqKQoJLS9Pp7oGcaT
    ew3kxjs0cUMNfbqA9AhTIsh736Z9pUcBFDAGINbQ2fW3aACTaUetKU>
X-ME-Received: <xmr:UYfoarIP9CKaWeQlII1SrTrbG_iwProsvnM8QrkqooyrTkXt0i1SGc6YnpKVD3oc1dEyOg>
X-ME-Proxy-Cause: dmFkZTGczaqE4Qdl1tHGB/WaBpIyG0r05pjYotsg515Vj5UlAtbKVzNFJXd/iTHo5LmZMm
    NLjF92SDLbdeowlNTEsNAmIpGrMAgdL+6mLjUvuBLUKH0mxWJROeoQiOfes5/CWxZwoPP1
    ehbSTTSOU3k1vBDckEDdp37eEXbl8kbddt89l33V/5y1mzgAZGmdyZIqSoEiXZVmUDucpQ
    AwMOnZTe+Ra6csmDx+PFnhKn+dNUdnjyTD1QvEAiClY2YHMLWjl78krU2Sm+kP7piuFh5z
    7wwWVikJskeoCzmjPLQ3UA8AlfwwszpU2Zhullv0J7NBENMYx9hL3LAFC9k3ZpO3d9Oldc
    PXu/cTDqvhYCsIBCJPfh5YirpTHR0lD7eXVYFmOnlq+a2dz/KkWb5TMxg5HX+Q0W8YgChn
    SL1tMnqxjQQ15j0cKMsDzz1ItaFNv+a6umk7w2hB1UXyONgBZAKhrEmA6QBcnW49F3LiE6
    775nwtvPOk7S+a5MFUdGjQ+JFKRFTWtIwUrATxD/9mtCUroiIs+ZFPqI5jO6Krp7/vtyE6
    AkYSR74t3n3r7Dsn4Kk5r7NFTtCQkLb1JAmFbaW4LdTwDBW8zdVTB1cn8O4y7TsvjMyRGI
    J9QUE6lXYSXK4z3oVk0ZtAmN5ZgRPjL8K4ldtAl1wpXvV3VB8JAK9Pgfsxkw
X-ME-Proxy: <xmx:UYfoagrFvYGY2u1bP2L6Dpk3wmhYMeBBecWTL-naKaGUNfBoryyDpQ>
    <xmx:UYfoajyeIUOGBac9EvH39rDhxJcW4RWY8Cu5AvPF4a9tH-6eoQXs1g>
    <xmx:UYfoakOhxrQyu_TwqEA1-4jdDcFzHoJrRoUFVC_JKvyDNfaJ5SSzsA>
    <xmx:UYfoao4jcoc-miiCEZFUGW_twMqR-G8-WJiwoCNoh8NcASfLXjsi7w>
    <xmx:UYfoaqBSLUaPG5TwRFiEEYbNVTCaxxU0xFXt59e7YtlofwFhfPrxDXCm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 07:51:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5a4c1dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 12:51:26 +0000 (UTC)
Date: Mon, 2 Nov 2026 13:51:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, mail@thomasbachem.com,
	ttaylorr@openai.com
Subject: Re: [PATCH v2] maintenance: improve handling of lock acquisition
 failures
Message-ID: <auiHS_439EeHCGH6@pks.im>
References: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>
 <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>

On Mon, Nov 02, 2026 at 12:29:56PM +0000, Pushkar Singh wrote:
> Changes in v2:
> - Report lock acquisition failures for manual invocations as errors.
> - Print a warning for automatic invocations while preserving successful exit status.
> - Trace the reason for all automatic lock acquisition failures, not just EEXIST.
> - Add tests for automatic and manual lock failure behavior.

This really should be two patches now:

  - One patch that changes how we handle the failure to lock.

  - One patch that introduces your trace2 string.

One note though: please wait a bit before rerolling again so that others
can chime in first. You should ideally reroll at most once per day.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 81cecf6b6c..9223409750 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1402,6 +1402,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
>  
>  	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0) {
> +		int err = errno;
> +
>  		/*
>  		 * Another maintenance command is running.
>  		 *
> @@ -1409,11 +1411,29 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  		 * recursive process stack. Do not report an error in
>  		 * that case.
>  		 */
> -		if (!opts->auto_flag && !opts->quiet)
> -			warning(_("lock file '%s' exists, skipping maintenance"),
> -				lock_path);
> +		if (opts->auto_flag) {
> +			trace2_data_string("maintenance", r, "lock/skip",
> +				(err == EEXIST) ? "exists" : strerror(err));

Why don't you use strerror(3p) for both cases?

> +			if (!opts->quiet) {
> +				struct strbuf buf = STRBUF_INIT;
> +				unable_to_lock_message(lock_path, err, &buf);
> +				warning("%s", buf.buf);
> +				strbuf_release(&buf);
> +			}
> +
> +			free(lock_path);
> +			return 0;
> +		}
> +
> +		if (!opts->quiet) {
> +			struct strbuf buf = STRBUF_INIT;
> +			unable_to_lock_message(lock_path, err, &buf);
> +			error("%s", buf.buf);
> +			strbuf_release(&buf);

There's some duplication here with the auto-flag case. Can't we
deduplicate that?

Thanks!

Patrick
