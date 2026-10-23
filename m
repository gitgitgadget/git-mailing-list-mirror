Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741319;
	b=Yi5CUcrcstXok2tmpG5sDr5BEld2l/X4/E9WkUXJ9lscdX0xH+eSsFG+382WQPQw23k7
	 7xexlarznuTKjGFp8KSmkXEEoBCCSj6j/d5or8Pk/4X80oRmOL+Srv5mgaBiNFwY8cSuM
	 rS3JMVW3z6cqDoM/MVOFLF/Ojoh+MpS7mGpu6v/xEAZcyeIw2sL/LjnJhepWVQbogXZze
	 N0VSdK0ljikHvqS4XHstDgdabipsFFWLFWA5n7IxeD88UFr9zuTLtE+quibCjMlK6RV4D
	 4XYtckxqET3IdhNgrlinADd81HIsjsfBo/rRcQRW29i2I5ICTNVr9HCDea0OXahr/2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741319;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4LdzMpW+W77u2qG8D5i/BVUjsZlVGaSglzmjifFOwG4=;
	b=Y/+dWvZYD58ToqUet5prH3g9cGscKOAa27vn+LNeG+HyKVQBk4sJmUiN5ztnq/7JTxzd
	 bKXmNtBF6tCTuy5sD/5TQ9Y/fY7uO1xN+T8l/OWqdiuN80U2O5CMk6Q0hKoGJ6dxf+E5d
	 UbH5ana2QtiHj77bBpbSlly4kgfBqOXRumGgq/4bgLxvSpoWhJgYt2nwJVP5elblOL+zm
	 utew97ytAqaTLK09KHF3DI8DnE0FZWnZXNF9b+NIHnO2HQcXjSl16JllujvwIRk0ACbAG
	 EsgXwGRhw5Bp+pzNrrTAgmO7zrJplqvx6QR1yzsg6X26TZYP0ugaaoTDGeUyN1WEoAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=UH62uPRy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MSNP1E36;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD0606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5AD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=UH62uPRy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MSNP1E36
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FBAB1400031
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:41:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 03:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792741318; x=1792827718; bh=4LdzMpW+W7
	7u2qG8D5i/BVUjsZlVGaSglzmjifFOwG4=; b=UH62uPRymqfN8df+KJ6IvEQvaG
	v3fqbF699nIGfSXjUwLKLafUBRE1SCqezg6fpfn2B02snwRHQMMBZPHb3G4wkZZ3
	PluneANKidI4G551QWZGvYt18css0vJ0W7AMc6Elib6+CSTYaL9gFcmi4TM6T8zM
	BPeUnhFUCsLdUZpjRFGDC9JE4urbUX7e3k1viyEROiNrNksWks2aXoU+UxncykXt
	dTznQDkQ6wPcOYcHXtKV7O8ZEPp2Rvj2Xq3OPZGQuZZdXsUH/leHpN9kp9haihcK
	dzEex/k66VcOCVBUo8mX0ljTDpIGi3Dr9x0YBlKr0kja8gi4wiYMVq/0FHPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792741318; x=1792827718; bh=4LdzMpW+W77u2qG8D5i/BVUjsZlVGaSglzm
	jifFOwG4=; b=MSNP1E36NBIiVF1Al8qpkHQ7/zo2oLLuWq7x44N9yrSJr8lGbJn
	aUC4i3uL2DbD+yfzDXeKuqFwJGRxNOfKq0NtFOvhGf2cxHMs2vjNbXbfzAp3hDSH
	LFMplmYS4tbRR/w/LZNM8XZLZLXCej/c32ulMwkuZiiEi8EztkWg1s6p8bKR/MzZ
	qDuDfSE4XTSqp2UunFj9g/WkFRv7J9knVQqOiUJA7h+xIKiZzbArpEYzHkTb4SE2
	XlTM03vh1fYtM3HsPgnLj3nm8eaIUWVLGqiTBTaPb+nlTroH8fNiWhihPrmvM4nU
	fTMQDd1h8FxuoCFzF7PduJcyhoXiTaWMH4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792741318; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nYSwZczyafm9hj76pEJM8rdmWrTfNiAC+BQvb8+RkAYshHF
	JCijVmaD7B3syhV22W/uKt9iOwlqwIfGezK71AzmD8VheVVrRRZLDEwjgWnCcON7
	ldBPOul/QkdTmMUXWZp1MuKmhjeh73g5R4SAcb39BE0W8MUjfuT9efd0Z+9lOU8d
	0ltNGwbfacMo7YOK6AZKBcuIVA21lhUuTpI9MT+PV4YB0QXvZ/5rnxM8vN+NpUJt
	7IdnfL9FuGz6cRj6PpW3/YQwOciJILKgXT+bSI6UXm0I9FHcZfMX/lL6Zd6sQRMR
	S4eDHyHWzOwcTmLhHaYcuSonildADgZsZK5qYVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:u/z3ghRpMmv7hePZCyHtqfm7n4RVju2JGUsDQWTt54I=:1/Ye+Y/FDNbZif+MWo2jJn/W1lKb6HJq1Z35PfLC3gQ=;
X-ME-Sender: <xms:xg_baucxICOrz6e8_DWKwlMQ8JXGhnI0OuwsWuMqUJMK7b_Jss8D2Q>
    <xme:xg_bavOJrZfjpuQJSKXocFDoc-sLPFyqQ5EfuFjUMwcAqzMCkCpmgMcMFDufiHiYQ
    EjpLHJLcjjYuHTLpPw0yehvwZjvaL94GHZ1sWmzr1676bdlmMbwBw>
X-ME-Received: <xmr:xg_bakgcwtKSRV37pdNh7UgJ6tcqC0uwVVwhR6RwZq6youuVr5PoXvA62yLQ9H4lnJ8qBA>
X-ME-Proxy-Cause: dmFkZTFGRgASGGSMCuP1qhSLnRREWeMs3Yjpj2ZQBJa8kbDVqF3OnQYagfXSQeATUsL+ME
    mB8EQccRDceGEZE+49/Ru4CG3gOl8GGpO0EGidIrKLJXlQYN0uwLNaiBFtzDgVNvx02qga
    DAfGNhZoS5KG4sFQ6SI0R65g8yVnmjiaCZG7LUF0QB3zYlIIt1eX93mggc+odDcNH2R4E2
    NdH69ItwYD+Jku4DnnMqMyVSEzvI1ReHij87gbU2mx+6jenxGBd7RZVCThxnNnyHZxeppS
    qIf5KHqObb+L8io7MM9AKROZE3LYckLtTZ1FraXqyrlU5FKCVzo15IKOEewNM0c13XS/tp
    ZAMDsE/5o2dZSXY9rhpQnqK2STxTF7+vCchSSvkLvBZQyc3L4rdJmAB/zMFic4CKCWeZNf
    natW+Qta4xasflQjbJ5ZsOjC7fT+BZB3Ys4atsYbM8UcgCAn2qqP9ik0OT3q1LhaXM3Wiv
    DXM3egmuR9JMxp7M0mujwd0SSfV246LUNPPhkS8Rb25lwMAIz1AqggiFNAx8wLMxI2fJak
    7IQJnhRiKE5B1QMoUrgxgwI93Swo8JrEDgv7cLAkwWZEVNIQHyX8u7UOwpFTzGb6gZWL/2
    FB8SPgMZ4Hc43zxGdjCD9O7QD8BuxCBQNafykI5Eahf7Lm+wId0E1GqzZ93Q
X-ME-Proxy: <xmx:xg_baq3Ijn0gWE8sqNqwme75mEMxTCMXT65nBUkhoQlzMf8vPEsl-g>
    <xmx:xg_bamgV1HAwSUhuiTpDHzDUvWkfYm9ui7RLxs0XzOX9WV3NWRCLeg>
    <xmx:xg_baifb_s9qvMYqkBALHTFJfelRIUs7S4V_hfUzavMbsqvBo-tmBg>
    <xmx:xg_bahltR-qLUtq9owJEzWePRfx-UcfhlCop7Fwj9ln7-7sf2DqJfA>
    <xmx:xg_barewIXxsI5pYQuEwCOhXSHWwyMknyXQj-FggfgxNEmOTWpAbiXSc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 03:41:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0f65ebb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 07:41:56 +0000 (UTC)
Date: Fri, 23 Oct 2026 09:41:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 3/5] doc: stop calling root refs pseudorefs
Message-ID: <atsPwpbD3YqmBds_@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261022212903.177261-4-andy.koppe@gmail.com>
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
In-Reply-To: <20261022212903.177261-4-andy.koppe@gmail.com>

On Thu, Oct 22, 2026 at 10:28:51PM +0100, Andy Koppe wrote:
> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 37a5019a8b..c775334230 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -163,13 +163,12 @@ still see a subset of the modifications.
>  
>  LOGGING UPDATES
>  ---------------
> -If config parameter "core.logAllRefUpdates" is true and the ref is one
> -under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
> -like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
> -`git update-ref` will append a line to the log file
> -"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
> -the log name) describing the change in ref value.  Log lines are
> -formatted as:
> +If config parameter "core.logAllRefUpdates" is true and the ref is
> +HEAD or one under "refs/heads/", "refs/remotes/" or "refs/notes/", or
> +if the file "$GIT_DIR/logs/<ref>" exists, then `git update-ref` will

It's kind of hard to understand how the ANDs and ORs play together.
Like, does the config parameter extend to all subsequent ORs? That's not
really a new issue though.

> +append a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all

Also, this infomation about "$GIT_DIR/logs/<ref>" is out-of-date, as the
reftable backend doesn't store its reflogs in there.

I wonder whether we should maybe just stop explaining how
"core.logAllRefUpdates" works and instead refer to git-config(1).

> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index e6e77252ab..f0eb6d4137 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -303,11 +303,10 @@ but others are specific to an individual worktree. One example is `HEAD`,
>  which is different for each worktree. This section is about the sharing
>  rules and how to access refs of one worktree from another.
>  
> -In general, all pseudo refs are per-worktree and all refs starting with
> -`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
> -under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
> -however: refs inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are
> -not shared.
> +In general, all root refs and pseudorefs are per-worktree and all refs
> +starting with `refs/` are shared. There are exceptions, however: refs
> +inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are not
> +shared.

It might make sense to have a bulleted list here, same as I proposed in
a preceding patch.

Patrick
