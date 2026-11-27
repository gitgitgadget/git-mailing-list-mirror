Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803121;
	b=gbRJnoOXSkqlz/ExAp82iNSKNuiayzBuD2f/wMujszOCLze6Dm/vuJZAattESW2OK9Ai
	 bpJ/NlXHqhP9yyje+lKMNCZsyPnC4z0Rv9X1RBvgV875mB52rpdGigdAxgtGS6lVijDLu
	 DKWUDBhr1vSdK/gRc5fUVI/hL6K20xMw9wExl1k2yQdC5JQSsTI/DDKgU8+Wf0dueN6Ko
	 0YJqMFNv3DULjzCQIbusZec3/RGBYdh5sQ1ScU67pcSa7wbsEQH9bc2As324SCF/d1iKp
	 Q/UNi9NrKgj4cINrYXtBcxezqROSJ5FTxXsjrGaGIKOYRYg4tlZfhWYwfLk9Z952t1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803121;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=92qHsFf0OpsusAmmODXLKgZn5GD8V0JCf53jP+M+XXY=;
	b=FYhcF2h2qWK8PhEoDUp2EvdIe9DlO/GLYjazylBPRZ3kek4jZyP2H5SAdIAdcH78EdYH
	 gJkjPkeMjxhh+mcEy0R2KMZM/LoVGiN3K7C2IlKlR5DuwQHMTe9xdoOKzgvkpoESUt/y9
	 ayg8RqwbXdxpXVvjyLz51KHoY/D0Djkkcuz1RAXNc+EGoaVw0Pz/zeUb6zB7QlI59nAXC
	 8SRmzcw1n26o+LmN7PeE+2dJuaMEAmYBR7GyoV1pCiD0MCsIOVAHLhIPekUo92LdwjfXK
	 gx+blBgy40BALaDNLPm5eLR6RVamSH4Oqzkjy7MHhtxjKl8D8MoCTVu+xTAiWw1RnlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SeN2BTRV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ee6L5J8e;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D57606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SeN2BTRV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ee6L5J8e
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 429BEEC0BF7
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:11:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Nov 2026 13:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795803119; x=1795889519; bh=92qHsFf0Op
	susAmmODXLKgZn5GD8V0JCf53jP+M+XXY=; b=SeN2BTRVGRCqEwy2FijDF7tpOD
	shgGO8wiERB6WBqHE46m4P3JiR69rkTyuV6m4L84NDdW69KOA7zPFk7EeuBMzGvX
	gUHIpTeZPBqvGNpUDam3WG5mEQad9VhJBYtHOdXsuAFCJUW1ak12DTKw7zan0YjM
	YSkrxsnhikjbSq3fac9tA72BtRk58aey8sMwNVK5abChipKlLMLpadwMdCtuMSnw
	g2r1FB44+XfjBD4bRRprpL+YtujrXaxV4VkQwy/Tq29+y9/y2xAvsHtkFpFPx/bn
	hCAXASWfG5LcQo3EbBPClm9k2newTCUe7uiN6m+zp3vpX6ufps7IcJcOY/bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795803119; x=1795889519; bh=92qHsFf0OpsusAmmODXLKgZn5GD8V0JCf53
	jP+M+XXY=; b=ee6L5J8eZ//5YmHb+7ppI3ltlFNn1/eXfVKAvafSf2tkGb2Ch9d
	Df/6GwGCjHULPC4OYmaH28EsOkUY+/PVyjBix6q8Te1u5tAUiYiTWvLLlsztJvbb
	3eC7m/cr6Xq/Y2QX34TanNm7sxPX+GkZmv4c7lJztM68w4p2a3+IqXptlwwigjGu
	6wlaRJlR2e7f2uPrt1WojDGGWnUrnmZjIEwPAb1visTVkNOVMPOtQRaK63XtUeU+
	keJFWO5uBUdIw2sMUVz52yMPE4zh/o+3agbtC3p9aEclJlEBZOR2riQIGN9vIkZo
	EtD8a0o05qhjIxMfzvkm1ZP9OFtgexmemWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795803119; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:muwKAZ+BmPxFYKHNi7O6znhY94hi9k71NLQ9kE6KSDwlYpD
	9ARNJeFPzfbEaEpVxPLhLdWuh2FDYtO5WKYL1DZK6+PW+ljESz0MYRPMKtjK/H52
	ZTigrctsWUDQQPhVQBZyPBM2YUvLxfXtgMfN/pJ11PArAjkB+v9UffflkJp8RJ5p
	aIdmdO4c+UPsmNsRgFqCZc18dWc1j1ovO2RdAHGgk+j8hIKAOAJ8gjMvOabaazIK
	Ca5UJ738RrIUph4pDYqbbaj67v4dN56uQASJvk57wnSqe4NvNnHPJjZLPkPrkytt
	01DYejFqYW9sjZKd2/PIpKJgcRsTaAIJcxRfMWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BHEEW2aZLp6AW88Tt9eyVKH3Gfq4upGkFiL13krxymc=:Bv8ee6sMY2sufwA78OZ5/aQ2NeAKfwszaHxprxkMEqc=;
X-ME-Sender: <xms:78cJa_ULMOTEUxzFrWTMKOSEiQi3Qzd-LgqzZ79pj2VIs3yu3Ne7Xw>
    <xme:78cJa-n1PTJDsDQBRLHt1sGyU0rlLpv_sKDoZdJynuvRavqYf7ZvvRyI1wtJUBvQN
    2fOT93BbcdyLnlcYZwgCYhUVGZyv69_gmbxafh1NkCagWqL7jMlDkU>
X-ME-Received: <xmr:78cJawYYBz6sVvyLblCTqTeLjwqjMxcQ5VYzdw749ZmEb1cuOSXeGAX3RzJx7gBIFPjBWWE9VDZKnh6hZUFFarc_71xQvOQOzc3prvQ>
X-ME-Proxy-Cause: dmFkZTE/Fxkc9SIP8Ma3w/gbXkfROdZqVh2LCD1Wc8oM8X9KTtz7tSp6TKBVgoTVzmZ1i4
    oKusYm41pLPQNXh7FfwmVm8NTVL4C/8G8qqm7y4wmWYwBTtDMMaQnP1A2cxH0xGFNKKkzO
    rIQIUznmYXb8MUC0NUP0tUMnFMZr5IwbhbahGK/oDaG6I6ixlZPYCbrRywsZD7DawJKGjs
    hA2VsL2GUhpMZ9hJagtbTo5KKthJsr0fLMY3S6Tbpd/KGXo1IpBpkeNDIWMcMY8eZkqSls
    jwhF9YnwCPZs9+rgbQrKe55Uaj0ycOLf9VFIAIMJ7N2TCtA1DGiPpXnxa7QqiQgB/3Afnj
    nnCIpNqdYSjUEpj80b4dUYae0kTChsHxHbbnvThbM/zWSUN2oBOthoHFweI1zKw0JR2w3G
    10jWa03k/TubTBcTqMN4O5ROF8ae0bnbisaYPprIky/9HCnu6U/sgtPDyDTvOFah/F4pZN
    maUdL6vZrIOPz0YMMaJLBgTixgBurZzwKOKh8FYg8ujMKY3BHBRhDOjq/G85pcQAkEBWb8
    BTNP4HehM7FrLY8+iuwBqdeGI/1I1GqhJxAV9JQluspJ61au7fE6H5pD8xD7He4+95tZtL
    fhtv3UvI76bzcx4hS1XfXUP0unmGwb+xLbP3Wixxmx7FxRR+1Dmvl6f1sjOA
X-ME-Proxy: <xmx:78cJa5OsQvsy7kQhx248BSbafeDfyuJ4xpuqmiX0lRmKF2EWQOCFnw>
    <xmx:78cJa1bCNCGc4WEm_zgOTq1u0mjjfRiOFX3UOHnRGk3EH7hpULyBHw>
    <xmx:78cJa31Q7pPV-NLgpDsnAMLjzl8s2h9JROaZpmAIPT_lAGMBF3F7Rw>
    <xmx:78cJa7em7zkq7O9cdT7qSP6GQwzUDdCkssmL_duVzj6HwFx1TwPoKQ>
    <xmx:78cJa2bLBjjZ7hiyCs5v1bJK7IAwx7CCLNsEBQlM5fZWbrKU1ZZrCvDa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 13:11:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <attilio.alessio@protonmail.com>
Subject: Re: [PATCH v2 2/2] status: warn about stale submodule URLs
In-Reply-To: <b0dd21100ccfe4411ccc1237fdb7ddedb66075e8.1795796162.git.gitgitgadget@gmail.com>
	(Alessio Attilio via GitGitGadget's message of "Fri, 27 Nov 2026
	16:16:02 +0000")
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com>
	<b0dd21100ccfe4411ccc1237fdb7ddedb66075e8.1795796162.git.gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 10:11:57 -0800
Message-ID: <xmqqecc69maa.fsf@gitster.g>
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

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alessio Attilio <attilio.alessio@protonmail.com>
>
> When a submodule URL changes in .gitmodules, the cached
> submodule.<name>.url in the superproject config can stay stale. Warn
> in git status so users can run git submodule sync before a later
> submodule operation uses the outdated URL.
>
> Resolve relative URLs using the same paths as git submodule sync.
> Avoid warning when the submodule remote indicates a local
> customization that sync would overwrite.
>
> Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
> ---

Surfacing stale submodule configuration in "git status" is a very useful
improvement.  Like Ben noted, splitting the helper extraction out into a
preparatory commit made the series easier to follow.

It would help to explain in the proposed log message why three URLs are
compared and under what condition, and which status formats emit the
warning.

> diff --git a/submodule.c b/submodule.c
> index f9ca99c5c8..5d0018d032 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -299,6 +299,9 @@ char *resolve_submodule_url(struct repository *repo, const char *url,
>  	char *remoteurl, *resolved_url;
>  	struct strbuf remotesb = STRBUF_INIT;
>  
> +	if (!starts_with_dot_dot_slash(url) && !starts_with_dot_slash(url))
> +		return xstrdup(url);
> +
>  	strbuf_addf(&remotesb, "remote.%s.url", remote);
>  	if (repo_config_get_string(repo, remotesb.buf, &remoteurl)) {
>  		if (!quiet)

The split made it harder to spot, but this addition forces the helper
function to return if 'url' is not relative, yet we have already spent
cycles calling repo_default_remote() to compute 'remote', paying the
cost to call repo_config() and to look up the HEAD branch.  Perhaps move
the unnecessary call to repo_default_remote() after this early return,
before the first use of 'remote'?


> diff --git a/wt-status.c b/wt-status.c
> index 238bb48643..be6902c9dd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> ...
> +static int submodule_has_custom_remote_url(struct repository *repo,
> +					  const char *path,
> +					  const char *gitmodules_url,
> +					  const char *config_url)
> +{
> +	struct repository subrepo = { 0 };
> +	const struct string_list *remote_urls = NULL;
> +	const char *remote;
> +	const char *remote_url;
> +	char *key, *up_path, *config_remote_url, *gitmodules_remote_url;
> +	int error_code, ret = 0;
> +
> +	if (!is_submodule_populated_gently(path, &error_code))
> +		return 0;
> +
> +	if (repo_submodule_init(&subrepo, repo, path,
> +				null_oid(repo->hash_algo)) < 0) {
> +		repo_clear(&subrepo);
> +		return 0;
> +	}
> +
> +	remote = repo_default_remote(&subrepo);
> +
> +	key = xstrfmt("remote.%s.url", remote);
> +	if (!repo_config_get_value_multi(&subrepo, key, &remote_urls) &&
> +	    remote_urls->nr == 1) {
> +		remote_url = remote_urls->items[0].string;

Can the '.string' member be NULL here, either by mistake or by malice?
We have two strcmp() calls below to compare this with two other URLs,
and either would segfault.

Perhaps use repo_config_get_string_multi() instead?  I do not know what
error behavior you are aiming for here, but the 'string' variant would
barf on an entry like '[remote "origin"] url' (valueless true), which
would give you NULL in the '.string' member.


> +		up_path = get_submodule_up_path(path);
> +		config_remote_url = resolve_submodule_url(repo, config_url,
> +							  up_path, 1);
> +		gitmodules_remote_url = resolve_submodule_url(repo, gitmodules_url,
> +							      up_path, 1);
> +		/*
> +		 * The submodule's remote URL may be a local fork. If it matches
> +		 * neither the old cached URL nor the new .gitmodules URL, leave it
> +		 * alone; syncing would overwrite that customization.
> +		 */
> +		ret = strcmp(remote_url, config_remote_url) != 0 &&
> +			strcmp(remote_url, gitmodules_remote_url) != 0;

Renaming of new/old may address one of the points of confusion Ben had.

When the superproject's own default remote URL is relative, doesn't
this logic break?

In wt_status_check_submodule_urls() we see below, 'gitmodules_url' was
already computed by resolving sub->url against the superproject's
default remote with 'up_path' set to NULL.  Likewise, 'config_url' from
submodule.<name>.url in .git/config was already resolved once with
'up_path' set to NULL when init_submodule() or sync_submodule() wrote
it.

Passing already-resolved URLs into resolve_submodule_url() again smells
fishy.  There are a few ways I can think of that this can break.  I may
be misreading the code flow, and these may be no issue, or there may be
other issues.

 * When the superproject has "remote.origin.url = a/b" (relative without
   "./" or "../") and .gitmodules has "../mod1", sync_submodule() stores
   "a/mod1" in submodule.module.url and "../a/mod1" in the submodule's
   remote.origin.url.

   submodule_has_custom_remote_url() calls resolve_submodule_url() on
   "a/mod1".  It hits the early return without prepending 'up_path', so
   'config_remote_url' is "a/mod1" instead of "../a/mod1" and fails to
   match.

 * When the superproject has "remote.origin.url = ../a/b", .gitmodules
   initially has "submodule.module.url = ../mod1", and the user runs
   "git submodule sync".  In sync_submodule(), relative_url() stores
   "../a/mod1" in submodule.module.url and "../../a/mod1" in the
   submodule's remote.origin.url.

   If submodule.module.url in .gitmodules then changes to "../mod2",
   wt_status_check_submodule_urls() sets 'gitmodules_remote_url' to
   "../a/mod2".  Inside submodule_has_custom_remote_url(), both
   "../a/mod1" and "../a/mod2" still start with "../", so
   resolve_submodule_url() resolves them a second time against "../a/b".

   Wouldn't the result be "../../a/a/mod1" and "../../a/a/mod2" in such
   a case?

   Neither matches "../../a/mod1", so submodule_has_custom_remote_url()
   returns 1 and suppresses the warning even though the submodule remote
   was never customized.  The new test in t7508 used "../source-parent"
   with only one path component after "..", where the second resolution
   happened to be a no-op, so it may not have noticed the breakage.

In order to match what sync_submodule() does, 'gitmodules_remote_url'
should be computed from the raw 'sub->url', not from 'gitmodules_url',
no?  For 'config_remote_url', we do not want to run relative_url() again
on 'config_url', I think.  You only need to prepend 'up_path', or
something, no?  I didn't think this one through, so take it with a huge
grain of salt.


> +static void wt_status_check_submodule_urls(struct wt_status *s)
> +{
> +	int i;
> +
> +	if (s->status_format != STATUS_FORMAT_LONG &&
> +	    s->status_format != STATUS_FORMAT_NONE)
> +		return;

Mental note.  Restricting this only to the "long" and "none" formats
somehow feels arbitrary.  Perhaps the callers ought to have more direct
and finer control, and tell the callchain leading to wt_status_print()
to refrain from calling this helper at all when the callers do not want
the warnings (like "git commit" preparing the commit template).  That
would allow us to free this helper from making this arbitrary choice.

> +		key = xstrfmt("submodule.%s.url", sub->name);
> +		if (repo_config_get_value(s->repo, key, &config_url)) {
> +			free(key);
> +			continue;
> +		}
> +		free(key);
> +
> +		gitmodules_url = resolve_submodule_url(s->repo, sub->url, NULL, 1);
> +		if (strcmp(config_url, gitmodules_url) &&

This is another potential NULL dereference due to the use of
repo_config_get_value() instead of _get_string(), no?  The same
mechanism, the same segfault.

>  void wt_status_print(struct wt_status *s)
>  {
> +	wt_status_check_submodule_urls(s);
> +
>  	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
>  	trace2_data_intmax("status", s->repo, "count/untracked",
>  			   s->untracked.nr);

wt_status_print() is not just for "git status", but is also used to
generate commit templates.  Checking only '.status_format' at the
beginning of wt_status_check_submodule_urls() means that these extra
checks are done and warnings are leaked into unrelated commands.

In builtin/commit.c, cmd_commit() sets '.commit_template' to 1 and
'status_format' to STATUS_FORMAT_NONE, and prepare_to_commit() calls
run_status() with 'nowarn' set to 1 when populating COMMIT_EDITMSG.

Similarly, fill_commit_message() in builtin/history.c leaves
'.status_format' at STATUS_FORMAT_NONE, sets '.commit_template' to 1,
and calls wt_status_print() after collecting a diff between two trees.

As a result, running "git commit" with an editor or "git history" emits
this status warning to stderr.

Instead of excluding individual cases (like "commit or history can call
and .commit_template or .nowarn may be set by them"), can we make sure
we call the extra check only when "git status" is calling the wt-status
machinery to prevent it?

There are also a few design questions.

 * Should "git status <pathspec>" limit its check to submodules under
   the given directory?

 * Should "git status --ignore-submodules" bypass the new check
   altogether?

 * Should "git status -s" and "git status --porcelain" detect the
   misconfiguration like the normal "git status"?

My tentative answers to the above are all "yes", but the design needs to
be discussed, the choices justified, and the result documented in both
the proposed commit log message and in the "git status --help"
documentation.

Thanks.
