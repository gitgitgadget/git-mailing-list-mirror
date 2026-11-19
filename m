Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111540;
	b=g+rRXJRNz8kKm72PlJEUpwtvmuHwx2HVpGzX466gA1RuC7qcFhqa9imurSsVIuxWOWgf
	 2BBST7xXWWGzNHfnZ3vbz5eRPg+QYMg+iRXlj1MP7tRwK3FGaWp+J41NNeWEhwDpnElan
	 C+ejfkb6kBq7A9dcqY0hsfmVFN0/vF/O5ymcHGFzwejAtcaa2a1X80A42qlpILYPVIPAO
	 d4vYfu6iJGMkWi4ugroZdsIAfxzj85mmdxP5gX5On4cDjTQR0MclAL5c7S0lHSc8RcGO7
	 eoSChrTfpSzQMSffv28s1+3/mvqckDmB2xOBjaC0kcUSjRDBtuWtsaZJ61+WM4gVHQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111540;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Iogx1E4F1qXqp3KhjHt3IVGKaqUtmr5f3fUxV2RqCZw=;
	b=HyWG488pJDUdp1RxmhLbgxSaSMTbx119ZLSHBqyJhvI66n8Co+6Gq68RD0F6Uc3bp/qg
	 JTrwDYkfJT7YEQcyedadnHuqthXZLmFvW+VVur1T3enU14AodDdekR4WaRrsu14fuQaj0
	 UTGaL4AypwuFEES8GgosidGP5jVb+/gjV4mdqLtEmslD0cx+Gl53eA/3qrp9fTV7IeEQd
	 83aZRkDJOdGv4JwIthC5l73ZVV1pyqMrjXqgRnp1NBnlYKAR13zGO3FnixHG23Eaib73T
	 kx7p7U15iEvBf1sr1HZHNDKOLzyIml9OFH31UecMrf+fbpkOsnfe6OhQXs/blFFHOVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AzQJht0D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GHe3T8oX;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636B606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 18:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2636B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AzQJht0D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GHe3T8oX
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39C267A02C1
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 13:05:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 19 Nov 2026 13:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795111538; x=1795197938; bh=Iogx1E4F1q
	Xqp3KhjHt3IVGKaqUtmr5f3fUxV2RqCZw=; b=AzQJht0D5192NQ8biQhDLltf4Y
	P2oTvczMGJd5gNlerryiViwZsiPhIzQLiV7uCtLCJX5hko0CsKaiq9Ow7qt3OHrZ
	N9h3+L9tefNmoH7aPftU9N8S65E+udpLTsKi6C56y1kUnt45j1N0E/U/aMaVrlNu
	8bSL6bNQk6q2Px0ZsInEE0OMsj2ch5PO6FxTros+cxlK7cw+t2veG1H2yZ1L6LSX
	0w3JJgcvGTRpsO4xUg6uRTvi0dEMacTrnFAUYJUrE0eMSWHFUqka78Q8WaTuvWXm
	dQwhaZW9dTFPFzveotSVNrhfJYoDc8nAFD80PfAvlL6XJSgWeqox5O3/G6hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795111538; x=1795197938; bh=Iogx1E4F1qXqp3KhjHt3IVGKaqUtmr5f3fU
	xV2RqCZw=; b=GHe3T8oXyzI0oRs7y7sdULVrJa0Rt44CjmzOcnOmW1Fx+2dnsRI
	cS0je01BKNYjCYgKw8l6ZSiqvObRsXxpahrMgIaOvOYLkbzDS5R8Dw0M1gLBp3d+
	J9sXTcjkzUpNhAPg2ELwicmu1ApcYwTPClLcgvSpcFlnegcEWfr2wDqzxsgQ0qeY
	+3zWB3xToz366GqdFMu0rGYtwsts4Gb1Fj2gwVZ2HH3Rg0Y4RWg3zdVYyj+aAEWx
	ckD1AGTtXA4djEDMdNvjS1cA7uaYIg+zQT6AF3CmDSzZ8jJOz5O+JMx86HtUdWB2
	0g0BBz7Xud5h0vZ2d4lZymwI36kxmXkxMeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795111538; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SMqXNpZNPR8aspTfsJXexan+Qc8jbtyxms8r+A1G01oUh6q
	sgF0IpVgItkZwPHaQDaPSGwXrEZGGVUR3EXiN6fa9WSx0CEHJhvc8bSd19WoUyKr
	vzAvTBjR1rSrGFXjvzDyVOBzmw+7da/qvYGOA5hhoNX6W4oQ13v+XVEWrRJTX9vc
	hpNleonofeVZ6+sEdyFGX3z27QdiKRvjXbbgBmMB9RTLYAXhvpYDLxz+cQsYfoAb
	ufqVGW6t3SnBv2Mfc3nyfMZksNYRJGccx6eeBWDT76G9cwMfUTeRgT6QIo7go2pL
	Irmo+G2+1tFt7xXSzmgW7mCrVmWTSn/CHXcDLaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:S0HVL1Bxvzmtp5zR2XNsmmCKER2rQ1gfAkHV+vIC88Y=:fEozSQFGgzgPIUq/6Etjwf1VRX2/y6IJq4Zl+R2ZpjE=;
X-ME-Sender: <xms:cjr_asTZZIQKz5gszce9jqqbpcopm0h2eSwlkBaPOJ4MQLRvuV12_g>
    <xme:cjr_agq3c87x07uiMaBEvrfsaYPhDQDUcdmcadaKXxOuJ6iV75CWSbNqF3qXl_FLP
    hUNqDD30939UzoR8wXWI4S_OWpGAeZl0Dytv4d9Tzl6gKTSw4rD79A>
X-ME-Received: <xmr:cjr_aiJ-Auq5hwP49ZRkzvonQu5kwIDuSwJE9Mn3aJ_etbheXzrVkG7hm4wOZEoezi9VId2P2NILiFhQ0KwAE00SV8dsCNZpxCYz>
X-ME-Proxy-Cause: dmFkZTELRixaFPZ7Men2EoEMA6VAQz3fHCLNzxgf37ZCz+3UFSrzLQbFZgV9fIV3czrH8r
    TCEh4GympjCQu3WIB/AtiT4PnIQhDhNhQyx4GxUZNjaI2CmgLd7RhEmeXTEjOW0nsb/Uk4
    qJVCrGRe4JLdX04rNYsnkh1P2hMJF9csYPchXLRmPc7W8dHrp5IUH6FozX4/gHp5m4XXWi
    wxpTRXY+Bs0N/+nWYeVQwiRaWOMhwxZ+YX+CXpqZibqU7YyIsqGgjC2qnW0mcmQkWrf+HI
    AibjKheMixIGEMq7D7UxGzWmsnkDYUtePw7RGAEEtr+Ft6TGzQmnuUciQGc7XomifwcyE8
    TE2Ea56xbdFxQqjJV/E9HJpSEMzSPWGmDGcDZr6/IPygPF6RZZa3/1/2DaYyEPtkA6zMyA
    jWVx0rPrIHI6QPC5xcdvpbujxTjhp0N+l8emvKhoOVlN76XzOZZ4X4cT2kLxQZQj59LsCX
    7koHD4toOxcXr9hxM0mj7frGM66TBMNXrFUMYMhMfkxafrX0MfGNZYo4N47z94bDqw/WbD
    updRUSuNTE06SS8AvVmA5w3QU80jYyi/dzxc49tRajZZ8qzWJ0HtWXcJbmnqaEdV4VzdDc
    /vkRZtmCGHurvmRwHk0oWySAn7SaTZxnmoQsnjTb16A8vwrpDxPkchDLu6JA
X-ME-Proxy: <xmx:cjr_arpqWylCfy9OfNC68DMoVk3wObfrZ4mYziUwUAW0mx7bEQXDqw>
    <xmx:cjr_aixKXaJiVHayKOmJzkeKv_aC7m6bRld5NToMnpoZKYj2s1XDZQ>
    <xmx:cjr_anN26H5anlIIFCgdX3FQuNHzjNieOgYUoaj8yQr8X_6yBjcddg>
    <xmx:cjr_av4IoyVlANI3GWYzNAjYMgrhhNZVMz7eqHc3KlwA8WPBL6Ey8w>
    <xmx:cjr_am656o2i6qdXvSzXMlP8O8Nczu9bAa8Ck0NtfTTP7MkpeO-1yH8->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 13:05:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] status: reword message for a missing upstream branch
In-Reply-To: <20261119055726.774485-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Thu, 19 Nov 2026 06:57:26 +0100")
References: <20261021072137.258934-1-gitter.spiros@gmail.com>
	<20261119055726.774485-1-gitter.spiros@gmail.com>
Date: Thu, 19 Nov 2026 10:05:37 -0800
Message-ID: <xmqqjym8y9vy.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> diff --git a/remote.c b/remote.c
> index 49ee2ea318..7e26088f65 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2449,6 +2449,47 @@ static void format_branch_comparison(struct strbuf *sb,
>  	}
>  }
>  
> +/*
> + * Would a plain "git push" create the remote-tracking ref "upstream"?
> + *
> + * Only if "push_ref", what @{push} resolves to, is the upstream. That
> + * rules out push.default=nothing, push refspecs that do not include
> + * the branch, and pushes that go elsewhere, e.g. a mirror remote when
> + * the branch tracks a branch of a different name: @{push} does not
> + * resolve or names another ref.
> + *
> + * Even then, "matching" only updates branches that already exist on
> + * the remote, unless push refspecs or mirroring override it, as in
> + * branch_get_push_1().
> + */
> +static bool push_creates(struct branch *branch, const char *push_ref,
> +			 const char *upstream)
> +{
> +	struct remote *remote;
> +
> +	if (!push_ref || strcmp(push_ref, upstream))
> +		return false;
> +	remote = pushremote_get(pushremote_for_branch(branch, NULL));
> +	if (remote && (remote->push.nr || remote->mirror))
> +		return true;
> +	return repo_config_values(the_repository)->push_default !=
> +	       PUSH_DEFAULT_MATCHING;
> +}
> +
> +static void format_missing_upstream(struct strbuf *sb, struct branch *branch,
> +				    const char *name, const char *push_ref,
> +				    const char *upstream)
> +{
> +	strbuf_addf(sb, _("Your branch is set up to track '%s', "
> +			  "which does not exist.\n"), name);
> +	if (!advice_enabled(ADVICE_STATUS_HINTS))
> +		return;
> +	if (push_creates(branch, push_ref, upstream))
> +		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
> +	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
> +			    "to stop tracking it)\n"));
> +}

OK.  This kills two birds with one stone.  An early return based on
ADVICE_STATUS_HINTS omits the call to push_creates() that is only
relevant when giving the advance, and the overly long lines in the
caller due to a deeply nested block are now much more readable.

>  /*
>   * Return true when there is anything to report, otherwise false.
>   */
> @@ -2510,12 +2551,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  
>  		if (cmp < 0) {
>  			if (is_upstream) {
> -				strbuf_addf(sb,
> -					_("Your branch is based on '%s', but the upstream is gone.\n"),
> -					short_ref);
> -				if (advice_enabled(ADVICE_STATUS_HINTS))
> -					strbuf_addstr(sb,
> -						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
> +				format_missing_upstream(sb, branch, short_ref,
> +							push_ref, full_ref);
>  				reported = 1;
>  			}
>  			free(full_ref);

When the push.default configuration is set to 'upstream', and the
branch.<name>.pushRemote (or remote.pushDefault) configuration is
set to a remote that is different from branch.<name>.remote, because
"git push" would detect misconfiguration and immediately abort like

    fatal: You are pushing to remote '<remote>', which is not the
    upstream of your current branch '<name>', without telling me
    what to push to update which remote branch.

Yet, we suggest '(use "git push" to create it)' with the advice, it
seems (reproduction added at the end).

branch_get_push_1() returns the upstream for PUSH_DEFAULT_UPSTREAM
without checking whether the push remote matches the upstream
remote, and that is what comes back from branch_get_push() and
stored in push_ref.

push_creates() checks !remote->push.nr and !remote->mirror and
push_default != PUSH_DEFAULT_MATCHING to decide if "git push" would
create the upstream we want, which says "yes" unfortunately in this
situation.

But in builtin/push.c, setup_default_push_refspecs() has a guard
"if (!same_remote)" in PUSH_DEFAULT_UPSTREAM before allowing the
branch to be used as the destination.  That is what makes the advice
message incorrect in this case.

I am not sure what the right fix should be.

Intuitively, the correct change may be to update branch_get_push_1()
to pay attention to the remote being the same (in other words, we
are not in a triangular workflow), as that would match what "git
push" does.  Such a change, however, may have fallouts and break
other callers of branch_get_push() that have been assuming the
current behaviour.

Adding a band-aid guard to push_creates() to specifically detect
this particular case would be safer, but it is far less satisfactory
and makes me feel dirty, playing whack-a-mole with the code.

Perhaps branch_get_push_simple(), which is a relatively recent
addition, might point us in a good direction? 

I dunno.

 t/t6040-tracking-info.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git c/t/t6040-tracking-info.sh w/t/t6040-tracking-info.sh
index 1f0583b391..4752559280 100755
--- c/t/t6040-tracking-info.sh
+++ w/t/t6040-tracking-info.sh
@@ -221,6 +221,14 @@ test_expect_success 'status (missing upstream, pushRemote is another remote)' '
 	test_cmp expect-no-push actual
 '
 
+test_expect_success 'status (missing upstream, push.default=upstream with pushRemote)' '
+	test_must_fail git -C empty-clone -c push.default=upstream \
+		-c branch.main.pushRemote=fork push &&
+	git -C empty-clone -c push.default=upstream \
+		-c branch.main.pushRemote=fork status >actual &&
+	test_cmp expect-no-push actual
+'
+
 test_expect_success 'status (missing upstream, advice.statusHints=false)' '
 	cat >expect <<-EOF &&
 	On branch main
