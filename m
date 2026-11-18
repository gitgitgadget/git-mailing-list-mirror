Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040935;
	b=EDR12pITQhGXWomiGCG9nKWD5VS0BW5xE+70U7HY6EmseMmF5iiLUWqtl4RrlDwjpbvB
	 7Hiw5/GhTCZNWVyc1qmN9A2US2BSrDC25Nf6MicjkcfUzMYPjREtLF5/dRh/4/1wVO8Su
	 osloTys34ZwzD+3T+wsfw33r/0tMfmgtPXfrwtIc5R9FQUu0zYMqF87wGtrMene2/H0Tt
	 tTq363fmexjQwXHGAO47TRpDVn5p8+vSVc6JHx1J2jXytpbAYK+aMyONyNTAyAmhxwe1s
	 q5orqE6XyIGmMzA4o0GtFKnw3dysjPz0T8Kb/ID13Up5Yl5YisAfPxbe/uJ9oXheS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040935;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZqcH8gE3x6zSkC9KqxkBVwB+g7YDfWGzGMOh8A+q4q8=;
	b=y8jDqm5T5sUTP7mfQ0K8UoPBVLms+EnRtsIQ+4bThwpC7DE0fUg7sdkms6ZQYlU+Cevu
	 KSRB4HDC1PMMU4NjjCzYAl40Qquc979dd1OWLMqGqor9uvETOY9s/kAZet9W30lnF5HO9
	 ITcnE6aS2g4l8s2L7gTZj0M07rEp4l+YiZu87vUQ9L594C3XI26yRGEWbSKzkzPNfy3Lt
	 3rc7J7KOVCVCgSf/cAAo0CADGeoyWptxlp+PEMBXEFF/kOqQY9W6nqlDRsQCzAN11H0/D
	 gLKhxlULl9SHnmfs6bFBEPi9ZP4ejTRFdlZIW25Ox4Pk9vnzTCSN6yrjTOKm0F/59IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fHzGtTPP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Z4Omypp;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85C606A32C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE85C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fHzGtTPP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Z4Omypp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D58DDEC081B
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:28:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 17:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795040933; x=1795127333; bh=ZqcH8gE3x6
	zSkC9KqxkBVwB+g7YDfWGzGMOh8A+q4q8=; b=fHzGtTPPLK1Tyb/Igf11Lpb83y
	pV5p2VoHVP4vkd0KowFzhSM9z+Iw0dXn0zr5JO4vcVdVaI1syuiz4xrV9bKzz8yU
	/P+GCbbVhF1Yy1DKVqxgF2o2Kaw1KUfygvzVuLS+daWqthwO6AHwUIUD72YfV3xw
	bU7SRh8owLnbAmVb2T1kO7UiT0RMd8K5XlMw+ZLKEtCoRPnREQvnv/3Kz8mdGkZH
	8MF760dKT8anZebgsS9vEI0/x2j1/uclhRd8VUW402jkr5oSmAnh3Y0+X2Voawgj
	V++YvK1YK+s2wNO+gsxV1Gtfy1i5bJRbRBIOzAnjWTPLgj+jJUDTquAnsvVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795040933; x=1795127333; bh=ZqcH8gE3x6zSkC9KqxkBVwB+g7YDfWGzGMO
	h8A+q4q8=; b=1Z4Omyppn0KA4ZADXojv+rvOkRe+jylVB62f8NpO/l+TzIyn5Ry
	UJUhJVt5x5jufd1XtwAXCABzWNbk7yfqW0dEENWQY4jm2h7okDoGwDSqRrngSYPF
	Tfh44KB3Om2v/ZJZiUBAlfO0mrLa/vpOmlWUAapVh+e514ryfqhwkrMnsF2//uQ9
	jSBi9pJI5vXjk3aHjDmL9333940EYujq5VCD4+PREGoZIqZ8XtHSkXbMjOG3ij88
	uJVfwoGWZLQWWBQUSQnKmjuGm7CzNohPXpMmO0xdQxcUri9QN7EAdbX/gRVWWAUk
	AKHchqOXZpElUAmQtV6WbxRhq1OWosOBrtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795040933; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fEQIBptVUiJczcb5JmL4BTkJ/Takyc23Bys/r3J9HrJOWCS
	IWGpO3DcDUUt2i6a39w045ev6O9Woy/83bCJX/szIaZ79vzbw7sk96mdiLu3VWM9
	+Dnm7ycjh/oe1OuzV0RmeVir6wuG2dJ9CLlwGF4ErYLXFDxFhb1uuoE6deGunROV
	DPXa6znyOygv+hLGrkBtra8a97W5vrfb87m9hC47ym4d77t7WPK6XVAWNVPHXi4a
	WUJUK8VP7rOJPBJchpBy3Vr6peJsc6eYcYXQ3FqBmYeimdDF0JIH0fjtPLIV4sKX
	pIFEv0owf/bopP7PbQ4HlcaVbFQCE5ZugxD5PHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oGD9sFiMEUYncRkHym6cy8NKtttcxNQ+xBqQrTdvzYk=:zXoEER8sVXouHzuQRQtBsp7z9wRsi/iPIIASd4Z/mQo=;
X-ME-Sender: <xms:pSb-anpPwC7sauXwKt17qo9vssE-Za6DfMr0w3Ac1sz7RoI2oMQUqA>
    <xme:pSb-aohZ7to0MdDbNNVDYK9P5Qbcjz_6WQ52HEq-sqFcpMc7HnrgF0ZqXDOoXPOE8
    QDuoahVv1H8cfJWN1DNcGHvukMy3o_sk5GSXWEn_LRLGwMFBIBJdE8>
X-ME-Received: <xmr:pSb-asjhXnj-0nZmuHzmYtGVZZWVH6Y1A-Q-yvQG9kLzJjeHBqhTgKUoX3ZgnaQRQEkt8_9OtVj_pnvTOCd0GzyfNwF7QIeqtTjO>
X-ME-Proxy-Cause: dmFkZTGn4iZf1FFUzdjl5TrrgH/w3fGX6+UIbVUCfpWsflcAeWtZwzOzGHubWBoAC1K7L4
    s2qWwuMxp7fDLpZ0fZV/iZbdMU4avRdPX85BXBgd2rlJ2NSFVyNi+JHaKa5SMewpVRC7PK
    MlY9Bmicnr1AtJ8yE9oau3YdvA+xMcMCcpXymjP6bi58doH1wfpn/HYrd0cKjqHjRUd9BD
    vh+t3swTkSLe2hWgb7akZzGO9ZJVAMKkRnVXLLiv4C487nE7f12G6aM72sI04wUXbl+FN2
    CrfFh0DBU+OUxIHPIBItrbNke5kMWUUssCpXSQMMchJJbG2N17pGrSQQaVnO0DZCc8RzYq
    hj+M9DC30TPU3zoBOBTPYfS0FVIB5QrsRJVdiLEr+QO1m+EGaZ7gS+7JcQGNOX0DITRjsI
    O8JwXNSi8+Dnd27oNk/Ayc9ohR8DrliU1bJtoDZ+jeXnO4puf2Kk2Xb9Wtau+rSHWDBuql
    T6kf2c9Ik/gu2GTM8eCB2LrhvbJpqozVF/H0YxADXCAPDJT7n24xm8AzRd/1iAGdXu8pCy
    MRyhM1rP/Vm6ZpBp5hkw8+0ZvCwOVDuEmI4w5Xk7S6TBp0ijSKod6NluTIao8MZEZlajwZ
    gR6wCXzfK/0PpvGm41JYBpDRMrqPRL0lxXEsdiiqnOgGmR05B83ZhJvOWDrg
X-ME-Proxy: <xmx:pSb-amj8QJl98Ei1pfm_WtqLeqvxZ4tipZ5bkoxW_A6YapMZgwJMkA>
    <xmx:pSb-akKlZriJVtYgUqyWqX4Ujqm3cu8J8odE6GVw56-f73pyhpHQYQ>
    <xmx:pSb-atECAlWHv8pfULKjW2x_6bnztCHrDznfu1-xwxei8xnc2VGrkQ>
    <xmx:pSb-agRBSC1hpYABhdYk8abaLvcva5YKdRWbCYHyiL4Q6TKwwENp0A>
    <xmx:pSb-apzwZ4Oqi3us6TMUZjuOfr-MhSQ_Yf4ueXU0QikiL_nZYi2uYVCU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:28:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v8 1/1] repo: add filtering options to "repo structure"
In-Reply-To: <20261118203519.2379494-2-markchucarroll@fastmail.com> (Mark
	C. Chu-Carroll's message of "Wed, 18 Nov 2026 15:35:19 -0500")
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
	<20261118203519.2379494-1-markchucarroll@fastmail.com>
	<20261118203519.2379494-2-markchucarroll@fastmail.com>
Date: Wed, 18 Nov 2026 14:28:52 -0800
Message-ID: <xmqq33sx3haz.fsf@gitster.g>
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

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> The current implementation of "git repo stucture" provides summary
> information about everything in the repository - all of the
...

> +	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);

Are we willing to lose "--" from the command line?  For example, to
count only the commits that touch things under the t/ directory
between master and grobble:

    git repo stucture master..grobble -- t/

might be useful, but without PARSE_OPT_KEEP_DASHDASH, wouldn't you
lose "--"?  If there are directories or files that happen to have
the same name as an existing revision, the users would need to be
able to disambiguate them with "--".

>  	if (show_progress < 0)
>  		show_progress = isatty(2);
>  
> +	repo_init_revisions(repo, &revs, prefix);
> +	if (argc > 1) {
> +		argc = setup_revisions(argc, argv, &revs, NULL);
> +		included_revision_args = true;

Things like

    git repo stucture --objects
    git repo stucture --stdin
    git repo stucture --end-of-options

would still count as (argc > 1) and cause setup_revisions() to be
called, but we still have not received any positive (or negative)
revision to start traversing.  Should not included_revision_args be
initialized based on revs.rev_input_given or something?

> +		if (argc > 1)
> +			return error(_("unrecognized argument: %s"), argv[1]);

This leaks revs and resources held by it because release_revisions()
has not been called on it, which may not matter all that much as we
will exit soon.

> +	}
> +
> +	structure_count_references(&stats.refs, &revs, repo, show_progress, !included_revision_args);
>  	structure_count_objects(&stats.objects, &revs, repo, show_progress);
