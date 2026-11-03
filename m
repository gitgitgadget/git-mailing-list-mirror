Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711096;
	b=tbem4O19IWg9z/aI6vvuCJrutql0j+32V6EwVxqyat60fknW/1e6LbPGFKvV3kQvRk4k
	 tfM5kWXt0i0taMMz8aRzUjmA1jG/b/uYItFBnZHWSNQIgcEXLqbdjpOOCSqqEMtSbaEHP
	 zWyZGpqP2e1Whx1pkP4GHFoXpnN5Zb38L8SIU7dSCdVh8n4lXSM3NzYb0BnFovJCTviiI
	 B1hUO9BMvI+3wGfpmRHYl0CN0bUmXrOB+fEQNTO0jLQ/AuZdGRZPpHxgPF90OIjZ086km
	 WxQ3ytYO4lsqLaeNrMv5gf2P5V+EI3e4BjlBdrzs6yE934tVrznGDEUVpW2JSweYGhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711096;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pYbMG2JT2xn6wmR7Frt3YWJWaoAR8z5GeGGyVoROxog=;
	b=5CMt/75lu4eO1E0nMy0QcyJ7PRsSo6lRE1crVlLFRlUnYjPeIQp+ZcWKLoJaBDmd8qil
	 XXu8q0ylujuZTA5xLONtsvx+NKDHq3e/UFFTVCZmTaQd2BcPeNSDVMhnfcAk8Lo+ghbW9
	 yKbpsN6bSvW9qC9NA5rpjl+g1LALDWIxMom3F8ojgHBphG0YWgSf8uSHalLXL/ho5I5bu
	 7jh+9+YWYFIYXV8IYKRPsiIPwuPpMejN3I24rxuowwtPM02D6BbYcQv43J+cS2pkDOq9b
	 Q3QF+JZCXx7xxFzQonY83J8GaAxphNTrdKSmAmfMSgHCJ9jWc/ii07xlpTiqn0fXsJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="t/DKoozg";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N2ikstlX;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0A606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E0A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=t/DKoozg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N2ikstlX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DF9231D00233
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:04:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 08:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793711094; x=1793797494; bh=pYbMG2JT2x
	n6wmR7Frt3YWJWaoAR8z5GeGGyVoROxog=; b=t/DKoozgDDbmY4LaJb4ds0X9vD
	vjO066s8y8jOPYhxX0022jgieZHiL1yDgqgTgPd03SKgdwopO0eg+JIfN0Vemn1v
	pcoKJCH9YRfsPno3GC+GN3a79ZuZTWliXxGme1Ks/hL48JD/DIqdPX1yAsTX4V9L
	qhlnpPx3fzT9TJ0Gh/MiJIIT/Vnsp/fCWtHT0gTxl37owv7FWAfhJnpmxrHYU+Lv
	3pckH/GQUPmQQPP19gwOVpjDXWTVbRmBFv9n64GCXKkWIVX1WpnNO/A00cwAqKPw
	rSieiHh+Iq1+g2q3lNqxOo5JU4Z6M25lqYUVlrCg3qNcwDMcV32HEZ68vtCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793711094; x=1793797494; bh=pYbMG2JT2xn6wmR7Frt3YWJWaoAR8z5GeGG
	yVoROxog=; b=N2ikstlXsw5ipS8D+lI/NP/bdsHhv2Q8KWci3tEpgXsF+2hT1WX
	2ipbFarpwpHcpa5bZTTYTV3hZfVWn0uNE04eRtvUrujJJDoPbGUtdmgMgh9O34kv
	kjmxrqOo2/2pDty3mvndQCKONnJpzAykbRMwhCGs0uenKHJWLpgLPVFyCxBBDjuM
	eTMqwvb6T4Jmf+sTcTtsnCCWJ1A+to1SCyqaudChm1wF2ZHeUG3DkvTP88Jmkksl
	7eDuysebIEG2ash4w8UcQnmkr4lTrX4TGd56uFnHZcHcK9zyN/691c0uTvGNYhX3
	6j1puFs+QgIy0W7/LZJFngdstWhp6QGd7Uw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793711094; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DoPQx+b2kDNlL5plH2PHzMrVu8c+N21I1tGKRWo9QR2q3Qh
	X+APw9zzAe+1PGk8sa70BD85HeL/2CHTc23ZbkmRKn4ECQfDUQUC5MPm+4FK1IMe
	lOD151YFwLmYGezzKH2KLuYUntwyYwKGHYDXJIygiaB4etYUP78BOk0mWG/ZzuBU
	lXEmF/8SIub9qSkAIg8bS2WWnENf4Q5iGP2CKzzXM+jMSKceb0mFFTgcRFArFwOM
	SPWUOV6HOG3DP4ZxCUUw01qanE0tFVL6K5n5oyJ7YU36G1aBAkM6u54Lq/1+lsTQ
	lt/oQvHhzIBjCFHPEw8GJXycA851y76Ipl54X9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6bq0rbx1kef17tOfHDfP7uA4M40VcbsNPUriruEzRTA=:tlqHa0kjKcdXz0uMtn9ZKZNmnPn8gWVlfrXz0vB74c8=;
X-ME-Sender: <xms:9tvpardxZckb3Ph85OIrjp61I9gfOI8yOhPdmsm5gN5qRsOCgXTvdA>
    <xme:9tvpaoOVPs4l964AvZe4GcIHFc0MwaJAFG6x793kSPIZYLpr2f77dpT4FzwEKD68s
    q0tWIeSO26wJdXHapbElhRmGppwAiHu6ZBBJUmXajom-P6i9Iub7w8F>
X-ME-Received: <xmr:9tvpaphop-fmI_RYSnY0qr2Hb3jIv2V_2cWJ8ZdoBg9AAUMTKSTkGQ>
X-ME-Proxy-Cause: dmFkZTGvmm7MlB10AyBNKjM+xdJswTI8mxuQxeN1wXVFSx+z+J03yuAmbCUV/rdUujx2XW
    jRyNwvaYi+Y8SAB55u3sWhXB0Z4TNB2m37Gh8pgsJx1bIYfvUsKqpvVpTEW4aOUzRYkHJ4
    RiRtQkveuBwRkx248jaYY3U5vVpr9oIhjMY3QSVJaICOia19V+p50Rpkaz5LYlHAzXuS88
    uHGgd7OBtp7rR67HzS4WCkjx3E5jnmwunDipMa/Fen0h2HgGUy4nTEtlX0ZRaQCC0PWlBN
    IREd1uskK9f+MV67+XIpJsvu6TEgEFEMAbEppVkfd55MaB/QLzzuK8FQ4ykNsRKi1W1oXh
    ypoWwZpx0pwqUJyUMcATi4IjEZgWTA3rH60wWF5lSriy38mSEWNwjP5Z4mWjVuKSnpMiE/
    Ms7s+QeRgart31wqs8zOJ7KPl3gYTi6iesn9EwiOQHrFgQBapVN3vla9L3Z1VXPbs+jJDw
    dr1b08yindJ/GGy14lsKSmk5Jz/k4JMApRJaKj6L6jEKSxnbdAsymsBMna9+pwDs0b4/LZ
    Y57j6KV5r24za2U7498LmOt8bA4AAq+7rUoIYCOig3Is5s8mUAKfLqTpm7AM9c1QPiJ0zl
    82qhCzSq7weB8t0d5DdEQaDutbyVve0gQIQQYB6TdlizwD2sP8taoAuxsA7w
X-ME-Proxy: <xmx:9tvpar0mgB8Mlyitj9psK0kvtkJlMezF14GemGT-PKNcF45s62oMNA>
    <xmx:9tvpajiC29WEdhupFbmofaPA3UWDscLcujoYGPDSEkkNjcWJNMozPg>
    <xmx:9tvparcPqy9813tX3TcjHLhNxzphqya54ueHO8olosmLjfrhxOACew>
    <xmx:9tvpamkuk7Jw6-WA8F1CjTKHuNv8KDoPnrscQoEBTw4iZn5KUxm95w>
    <xmx:9tvpatA80p7dMogX0wbZ_lZsRt3n4jiQpDDFzQoqGMSVtxkiooCnccQx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 08:04:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c52b6aff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 13:04:52 +0000 (UTC)
Date: Tue, 3 Nov 2026 14:04:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] bundle-uri: do not die on unresolvable relative URIs
Message-ID: <aunb6OjWKWLyl-mp@pks.im>
References: <20261028115818.410-1-aniketgupta3001@gmail.com>
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
In-Reply-To: <20261028115818.410-1-aniketgupta3001@gmail.com>

On Wed, Oct 28, 2026 at 11:58:18AM +0000, Aniket Gupta wrote:
> relative_url() calls die() when the relative URL has more "../"
> components than the remote URL can absorb. bundle_list_update() calls
> it on URIs taken from a bundle list and a single bad entry takes down
> the whole command.

Which command?

> Add relative_url_gently() which returns NULL and records the reason in
> a strbuf instead of dying. This will keep relative_url() as a wrapper

s/will keep/keeps/. We're in present tense.

> that dies so the submodule callers are unchanged. Use the new function
> in bundle_list_update() and report the problem as an error like the
> other malformed lines in a bundle list.

These "bundle lists" are quite abstract here. It would help the reader
if the commit message briefly mentioned where such a list even comes
from.

Even more importantly though, do we now only print the error and then
die or do we continue? And if the latter, why is it fine to continue
even if we have failed to retrieve the bundle? And is it fine to
continue for both callers of this function?

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 2bb2eb99e4..1f198ef9a9 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -210,9 +210,17 @@ static int bundle_list_update(const char *key, const char *value,
>  	strbuf_release(&id);

Okay. The only other allocated variable was released already, so nothing
that we'd have to do in that case.

>  	if (!strcmp(subkey, "uri")) {
> +		struct strbuf err = STRBUF_INIT;
> +
>  		if (bundle->uri)
>  			return -1;
> -		bundle->uri = relative_url(list->baseURI, value, NULL);
> +		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
> +						  &err);
> +		if (!bundle->uri) {
> +			error("%s", err.buf);
> +			strbuf_release(&err);
> +			return -1;
> +		}
>  		return 0;
>  	}

Looks reasonable. There's already other branches here that may return
errors, so any caller that wouldn't know to hanlde such an error would
already be broken right now.

> diff --git a/remote.c b/remote.c
> index 49ee2ea318..7472c426aa 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -3073,8 +3077,16 @@ char *relative_url(const char *remote_url, const char *url,
>  	 */
>  	while (*url) {
>  		if (starts_with_dot_dot_slash_native(url)) {
> +			int chopped;
> +
>  			url += 3;
> -			colonsep |= chop_last_dir(&remoteurl, is_relative);
> +			chopped = chop_last_dir(&remoteurl, is_relative, err);
> +			if (chopped < 0) {
> +				free(remoteurl);
> +				strbuf_release(&sb);
> +				return NULL;
> +			}
> +			colonsep |= chopped;

The error handling does get a bit unwieldy in this function by now. It
would have been great to maybe add a preparatory commit where we adapt
it to have a single unified exit path that releases memory. But I won't
insist on it.

> diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
> index 70ae94c4d0..0f0ac29565 100755
> --- a/t/t5750-bundle-uri-parse.sh
> +++ b/t/t5750-bundle-uri-parse.sh
> @@ -68,17 +68,16 @@ test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
>  		uri = <uri>/bundle.bdl
>  	[bundle "two"]
>  		uri = bundle.bdl
> -	[bundle "three"]
> -		uri = <uri>/../bundle.bdl

Why do we have to drop these lines here? Interestingly, we don't seem to
use this file at all in this test.

>  	EOF
>  
> -	# TODO: We would prefer if parsing a bundle list would not cause
> -	# a die() and instead would give a warning and allow the rest of
> -	# a Git command to continue. This test_must_fail is necessary for
> -	# now until the interface for relative_url() allows for reporting
> -	# an error instead of die()ing.
> +	cat >err.expect <<-\EOF &&
> +	error: cannot strip one component off url '\''.'\''

This error message doesn't really look useful to me. In the current form
the user wouldn't be able to figure out which URL specifically we failed
to strip. It's a preexisting issue, true, but do we maybe want to fix it
while at it?

Thanks!

Patrick
