Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792781;
	b=Bjwqjgo9ZPa6RDB4ylEkllm7XBddHm52LH3VwhFM7vP/GpLO3hFHQ7e74BnKr5fapbW2
	 Lk7hsJPfFSbA9SgI4bizJyswByxecNfs4fsgzA0nMhEwB/CWHZdQNJ/2SawxXeTDM+7d7
	 Sh3cWiWpLL0iIX9L45BziA4gDkyr2UGUwV8mUwjzcjx/bnh01t3rpnCwYNCIkLg2QVbHh
	 ygWjFhovjqBzmRaJER73/HQMr6VN/Mb/+wDkmThuwHQijsqHFMBh08LEzvQNl5QxNFmHt
	 wzFA/wKT5RR8aK9+BZ5khU4O7ewz85foeOca7j8boPPq3m/K4xos4V7fhJSDrSuSt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792781;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iHcIrgUF+aFIf8/isGHnwCTaahc7czhnceo+GYofK14=;
	b=lDHp26wVt+fpSJkucrArEE4BIbLtQGUftvzDcO0GYXrYKGip2w3jGvV2f4ERhuBN2Gcy
	 xD/mlxSNu9uKHTF5c/chyyZF7+2osju0Rc1FyXHoatMbWbwVI2tQzKUBxptnpJHMEkEh+
	 91hnX/QiVeWLtUWQUC4Unx5fynlwpDJFo/uecQJ2VWs/zXehnQ4GFQVMLbFm29riq8CO+
	 C7SpUYIyDO4wAPV7U708ayU3XOePZbvU2xOVy1idrnOAFXh+Vfv+lqJheL/L4S1B+ERYO
	 0ds+df9i1GoSpE/GFXsEK/Jk62Mo2TeloBoJaPvYiNVtPfQ3xU7U7OWBz4YmyHHwKcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=p4P1lfTv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E1qM4Khd;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B65606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=p4P1lfTv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E1qM4Khd
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AB2D61D000D2
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:59:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 17:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792792780; x=1792879180; bh=iHcIrgUF+a
	FIf8/isGHnwCTaahc7czhnceo+GYofK14=; b=p4P1lfTvb6TvgNVoLThTt2VMBq
	AikQqbxuFKWKZqQh2XUL/Iw4/C2xh47frlFz8yhmO6QENVdR8bzWP+rOcVg3mVCA
	Z6AaF9kBb4hKDXfSLmbf2hbtwd/l/oEfRg0h5Zwcy6Y7bglG01mKdZfqtQoW3vJK
	Qv6J2UbfEPMjdLhaQpWAmA34am9WgrmMeQYEOFwjckggEE5rdX5IuR867TGidArJ
	F6jviX18yDwpnhXZfXR2qeyqe14YWvkhdtigodr2FQbM1TzRH+wPE0CF8FvTfy8l
	nMWldwnHJEOvB/PnIdNtve2UKXjjEKVCH/4wllvy7VRJ/KZlzadS/cFsf4Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792792780; x=1792879180; bh=iHcIrgUF+aFIf8/isGHnwCTaahc7czhnceo
	+GYofK14=; b=E1qM4KhdtaaXrbVmwoWLWCxIrIE0TAQmCXBoVxaLKTHFctyT3jh
	bYW2r01g1kq4DO/6wTZOsqpR4jxp2CntVC4yunt8z/B/mpGFQ142/y0LrvN1oTR1
	56YcmRtD86JHDAkuqXCt/BynRQNYSh72cxGkY4VUVFXI8sZZs8UbHU7BLoTZIwrK
	bczDeXGJOzErEHujB9NzBPyExMiW7sezW2tFXnwa37Kwcvu7K4ewAyRr+o8UAumb
	jP7ouXhllSnu6XCYOjZu7aygxv8/tY9JQXBaNI2abXFWdHe/xjtsX7AlofJ+KUdt
	7bpE2B7/HfPoozpL4nC0VugFfdXoJ7hpQnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792792780; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VQYwA5ZgvxMTwBeO2yR2VIzHQx1QyizaMPbRe8w6HJMddtY
	spnN3gbE8jOMiTDIyoRbfgyySSdZkCM4scHPhhvIKJZJeJDFqTNJYjzsJ+6SxZpE
	DVvrQJuxTntYM/HaVbBY8aYhWX+mnJMiz+xzJpGfgykYPc3GuDmpX1mVD/BRcM1G
	zA0ySHwG4CGZNEEk3/CKjkHr4It/n3YYqUMBECSPqnazwS0tueVoAfNJ5qZenZLh
	AyyuTsbL2Cqw4r5njyeN1djmPNeBlg64tydlz6HmNasZgxdZDzP9N4VTfX1Ct+Vi
	1C6zeEd1hZQvF9V0HmUm+97orBTBNVjZRAjlfQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YdHCAlkNn69RvTxnvdT5OEqMU7MHR2OwRUdsM6IAj4U=:9t0dyHBmVrkA8fhy9ZmId/0bAAuJgbapzWJg6wgbL4o=;
X-ME-Sender: <xms:zNjbauiWeDn7M_5DTipwe7QvFEseAHtMk-5XhFf4ZTt2jG8lKuVIyg>
    <xme:zNjbamBx-4CUoUMbJ0Zt-BzKXDZ_62BXGj0r0JdyjlgE-Ga4ZRzKxxfcWHm3onMO-
    zBn_vH7gavhyiwefN5COjPDow7tRYU3Bgm5g7TCeTL4FZtcZQm2lvtv>
X-ME-Received: <xmr:zNjbarGTVQUNsn1g41mJ2sCuZNzRVXjJS9_FOuGWYC4LtUMvEn8OdiJ6bW1h0I2HXAru27qnjZyfoXdswOb312e5wOiKmiPLFHBL>
X-ME-Proxy-Cause: dmFkZTGWW6TdPErI2mrcVpdZeaL0wdiGjeKhyPx0wfGikTfZJhkZSbVLH27InuXTgiZugK
    D2HkDx9aNrbp/pqU6eCVynfqvmusMcMwfkKtSTPGCkEY8DyWh17/L/sgelQnaEHK2pjIQj
    xubSVWI1CfJyaM1RHCgtKbkFKE8qgT3YbbPIPT+3vYWQ9H5GMJx8Bg3SMPWh3FgtA3B4oe
    vP9UHKB+ip9sT+/1yIqRmsgDHYictudxpjeBVdJ5U+ODGYWhoon70sBQB2SfhTQ3gJIHYF
    OAPIXL8kBdwv7aL5zhAObDDwFwCHsROfUzcEHOnq8GhOcmhs8A9x7XSinMTibblBtWpxJh
    8bgDaWiJV8TQeadObjGvpchEAvwOxWiz6HYcL2TA/R+uagbYpOKi50fOFEJbr9PhD3SF/b
    7vgbcYHx12h5PrGNdy3UcRdVjWBec2KG0v965sYPCKr48GL3EtqIzVfKqdKzHNwLc/t+4I
    gggNahtL5s99wNhqfWj1+YsxnqzMPTfyfMCfivptld85F39oBPnOiTQ4NzSksC1V0w3+uf
    BFs4M9E1ZDqfkAeJi/oqdnsfxd1pblfzZrab4WV39Fv4hXmYkm2wPjbaiez6cGcQzdjGLk
    qQJgD7ATmE5SF4N1Ee3TsOxgKdnNtSSTgWJLHNhbOr+OjY5PnDo9A684e1VQ
X-ME-Proxy: <xmx:zNjbamL2bKamUfVL5XBaSE5m254rtwYO0NDITBsBv5BGgfBesmmdaw>
    <xmx:zNjbankpWo0qJVmVjNn8Qcr_SEBUF3kI6GBqYzFNywwlC6OZCCRNmw>
    <xmx:zNjbamSsyKjC8YViOWe6dbMxtw1TsGV7D2EKLyfKK0UHb698HNL0KQ>
    <xmx:zNjbahJSblTlEj-xts_iWUBN-f5GM-zk5YxiHJNW2EXmnXsWRjcPIw>
    <xmx:zNjbaqUr_kZIs2vLJhhuIuH7jYjymfUvCxh0rxbs2Gj0jUsTz-MdlGP1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 17:59:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <20261023185007.21642-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Fri, 23 Oct 2026 11:50:07 -0700")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
Date: Fri, 23 Oct 2026 14:59:38 -0700
Message-ID: <xmqq33tw3wol.fsf@gitster.g>
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

Colin Hinton <colinlewishinton@gmail.com> writes:

> Continuing from 86129fd (fetch.c: defer fetch.followRemoteHEAD
> validation), apply the same treatment to
> remote.<name>.followRemoteHEAD, which is still validated in
> handle_config(). That emits a warning for any command that loads the
> remote configuration, such as "git push" or "git remote -v", even
> though only "git fetch" ever consults the value.
>
> Store the raw string in struct remote instead, and resolve it lazily
> in do_fetch() through the get_follow_remote_head() helper introduced
> by 86129fd. This replaces the parsed follow_remote_head and
> no_warn_branch members, and the NEEDSWORK comment left behind by
> 86129fd is removed. "git remote set-head" now compares against the
> raw string to decide whether to rewrite "always" to "warn".
>
> Moved enum follow_remote_head_settings to builtin/fetch.c as it is no
> longer referenced in remote.
>
> Messages for an unrecognized or missing value name the full variable
> name prefix, as the helper now serves both the fetch-level and
> the remote-level setting.
>
> Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
> ---
>  Documentation/config/remote.adoc |  4 +--
>  builtin/fetch.c                  | 45 +++++++++++++++++++++-----------
>  builtin/remote.c                 |  3 ++-
>  remote.c                         | 28 +++-----------------
>  remote.h                         | 13 ++-------
>  t/t5510-fetch.sh                 | 18 +++++++++++++
>  6 files changed, 58 insertions(+), 53 deletions(-)

This looks mostly good, except that I see a few places where the
indentation is a bit off.

> -static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
> +static enum follow_remote_head_settings get_follow_remote_head(const char *setting,
> +    const char *key, const char **no_warn_branch)

Perhaps indent with a tab (instead of four spaces).

>  {
>  	if (!setting)
> -		die(_("missing value for 'fetch.followRemoteHEAD'"));
> +		die(_("missing value for '%s'"), key);
>  	else if (!strcmp(setting, "never"))
>  		return FOLLOW_REMOTE_NEVER;
>  	else if (!strcmp(setting, "create"))
>  		return FOLLOW_REMOTE_CREATE;
>  	else if (!strcmp(setting, "warn"))
>  		return FOLLOW_REMOTE_WARN;
> +	else if (no_warn_branch && skip_prefix(setting, "warn-if-not-", no_warn_branch))
> +		return FOLLOW_REMOTE_WARN;
>  	else if (!strcmp(setting, "always"))
>  		return FOLLOW_REMOTE_ALWAYS;
> -	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
> +	warning(_("unrecognized %s value '%s' ignored"), key, setting);
>  	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
>  }
>  
> @@ -1760,12 +1772,11 @@ static void warn_set_head(const char *remote, const char *head_name,
>  }
>  
>  static int set_head(const struct ref *remote_refs, struct remote *remote,
> -			int follow_remote_head)
> +		    int follow_remote_head, const char *no_warn_branch)
>  {
>  	int result = 0, create_only, baremirror, was_detached;
>  	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
>  		      b_local_head = STRBUF_INIT;
> -	const char *no_warn_branch = remote->no_warn_branch;
>  	char *head_name = NULL;
>  	struct ref *ref, *matches;
>  	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
> @@ -1955,6 +1966,7 @@ static int do_fetch(struct transport *transport,
>  	struct strmap rejected_refs = STRMAP_INIT;
>  	int summary_width = 0;
>  	int follow_remote_head = FOLLOW_REMOTE_NEVER;
> +	const char *no_warn_branch = NULL;
>  
>  	if (tags == TAGS_DEFAULT) {
>  		if (transport->remote->fetch_tags == 2)
> @@ -1978,16 +1990,19 @@ static int do_fetch(struct transport *transport,
>  		if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> -			/*
> -			 * See remote.c's handling of remote.<name>.followRemoteHEAD
> -			 * for the analogous, still-unresolved case.
> -			 */
> -			if (transport->remote->follow_remote_head)
> -				follow_remote_head = transport->remote->follow_remote_head;
> -			else if (config->follow_remote_head_seen)
> -				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
> -			else
> +			if (transport->remote->follow_remote_head_seen) {
> +				char *key = xstrfmt("remote.%s.followRemoteHEAD", transport->remote->name);

This line is +l00 columns of long.  Line wrap?

> +test_expect_success "fetch test followRemoteHEAD unrecognized value names the remote" '
> +   	test_config -C two remote.origin.followRemoteHEAD bogus &&
> +   	git -C two fetch 2>err &&
> +   	test_grep "unrecognized remote.origin.followRemoteHEAD value ${SQ}bogus${SQ} ignored" err
> +'

These lines have space-before-tab whitespace errors.

>  test_expect_success "fetch test default followRemoteHEAD always" '
>  	git -C two rev-parse --verify refs/remotes/origin/other &&
>  	git -C two remote set-head origin other &&
