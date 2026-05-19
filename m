Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDA2C0303
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171393; cv=none; b=nie4w/TzCazzKFrFV9pgnOOtZf5c0plMnrDZJIuGS1pI/KPjD2HfeUeJtJ8nYOnuCQTjjJ2sCmI5/A8dfIs67AI4GG2nCdOH/D8Q906F/cRHoQSgOHg1Y2aYRNyJFNnwO9M5vSW6C1d/ZEwlOPiICSje0SROfAYOp3lFGMKgj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171393; c=relaxed/simple;
	bh=YmmB8Z8SMCgBbVQf8bdHJ/HhOpoWffxLWuwfk2aQFYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBscjW2DuKXCw7/AMVP8or3aXgpT9pie/+Wx/kePZbA2B/DPa3vv1WSxFanwUwTIZQoiI7MSDKabu4RNnPjPnTI+QcpLU68kUGREtI2vIafIXqd1Li8bFIEdL5gZusJjp94mYPp6tiie5pWar3f0wzHg4cOkuPT756u7S8O0Sok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TPIIrIpF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZzioGy4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TPIIrIpF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZzioGy4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A246F7A0104;
	Tue, 19 May 2026 02:16:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 02:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779171389; x=1779257789; bh=uRUM9XaxDN
	1cikq7iV9uRAXnh5o8/lN2uRE69FkduKQ=; b=TPIIrIpFZxdKJ+9ICY0T8DpToM
	7AHR3bMfX0QMc0DVTd+CSnnOplMcrNdDVhdxXa7YsTCEozYWAtQTpxFPHiQjzF6t
	48CtlN1hoWin6V+07hfOu1z5tm8NlwXDGYQCB5a2c2sEv4weBxQZOfbMJd32wEP9
	4NC6l9TVFhSbHNgg9o1tgTeBglz/GgXKxYozirFSlBHBYI8HjpriqENC/zIw10mZ
	6j3keJigzbTvB40btrhUsGPju3R4rCWJEQFGJECHnphk+gD7v3N1F5rL1hGzk8Im
	ynLiZw4bHSH2m7Ir4fJ7U+Ek7Mmh2rBzEP4BlBWd16eh0QDWjwKDtGQ+2feA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779171389; x=1779257789; bh=uRUM9XaxDN1cikq7iV9uRAXnh5o8/lN2uRE
	69FkduKQ=; b=LZzioGy4k7gxYZcRuSV6cz/Hp4e8ZlMTAaRmxkET3RzaaQHz0Ur
	zmc1u27fFnPd6BuYSmU+ty0esfSvmEeUvvR0fN18Q77MDyBqA3F7M8e/xe7/5yBv
	I9YGtghAz22Am1XTp+Hubhy7fKNOD+JWwaBuUbpAihJuI0u5TorpfyDrkhtXqsaK
	mayQtQGu9kvfVO7NhePWn47FLJWmzk/MhwkhL+yRKA4lwGqPsiOlXE4qcC7YO4/G
	LAKRDCuulwJiJNxT1+Qfy8FK/dK8XjKaksLpeibTjLzDpccjCva5aeL+E9TPU9jy
	7J++ueBc80oJTSW7CS7RV4eg/LYd8gdlDeg==
X-ME-Sender: <xms:PAAMavh6tuD4d6gMc0ehpMBz2KvYNLRqmu39ZE2xi49i9ax3Ofbn8g>
    <xme:PAAMag_hWRpIlWETwuCsS1KXmVsK0XzxeM1irKXOWaVKhgEHRUIsI_FIglpAQP1St
    WXKodGmU1N5U1bDTPnHmphVPu7si_XxwsLN214WOuaDYUxyDZ-1>
X-ME-Received: <xmr:PAAMajV9zPUuljv7cNG7tUw8JL-UL5Dw_h6MA4hgsNjWVHB1AgXpcPJ84Cj4kYv8yRDPM6B80XBBlqEO_gH8xxEjn1Ff3f4x5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjoh
    hnvghsrdhplhhushdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehmrghrtghnrghrtgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PAAMasCjDNXto7CSRJE72FG-gaZIRTGTC0EYvHiaWEfz4QIHJE3SNg>
    <xmx:PAAMagE1h08peZ2rrzZcV9IN3QukG-uV70xVWVpDuqZdKa8bZovTog>
    <xmx:PAAMal5e6IhOpxbj8IvFZIT4lkuEmSb3ecfHdZGUKX5zx_gHXjNV2g>
    <xmx:PAAMaunaBga647EJJ0IQlgHPgrhZF0RCfRop45hGfMbuY54BBurJ_g>
    <xmx:PQAMarfTG2KkzKwcwzv87Dh1rk65AVspBTSqe0q7KhTAy46HxGR2ZSob>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 02:16:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 18 May 2026
	08:04:43 +0000")
References: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
	<pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 15:16:27 +0900
Message-ID: <xmqq8q9f9b5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> If you want to fork your topic branch from the very latest of the
> tip of a branch your remote has, you would do:
>
>     git fetch origin some-branch
>     git checkout -b new_branch --track origin/some-branch
>
> Extend the "--track" option of "git checkout" and allow users to
> write
>
>     git checkout -b new_branch --track=fetch origin/some-branch
>
> to (1) fetch 'some-branch' from the remote 'origin', updating the
> remote-tracking branch 'origin/some-branch', (2) arrange subsequent
> 'git pull' on 'new_branch' to interact with 'origin/some-branch' and
> (3) fork 'new_branch' from it.
>
> In the value of the '--track' option, 'fetch' can be combined with
> the existing 'direct' (default) and 'inherit' modes via a
> comma-separated list. Examples:
>
>     git checkout -b new_branch --track=fetch,inherit some_local_branch
>     git switch -c new_branch --track=fetch origin/some-branch
>
> When "fetch" is requested and <start-point> is in <remote>/<branch>
> form, run "git fetch <remote> <branch>" before resolving the ref, so
> that other remote-tracking branches are left untouched. If
> <start-point> is a bare remote name like "origin" (which resolves to
> that remote's default branch), "git fetch <remote>" is run instead,
> since the target branch is not known up front. Abort the checkout if
> the fetch fails.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     checkout: --track=fetch
>     
>     Rebased to fix merge conflict with master.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v10
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v10
> Pull-Request: https://github.com/git/git/pull/2281
>
> Range-diff vs v9:
>
>  1:  021375e4cc ! 1:  a773fb6bdf checkout: extend --track with a "fetch" mode to refresh start-point
>      @@ Documentation/git-checkout.adoc: of it").
>        the refspec configured for the corresponding remote, and then stripping
>       
>        ## Documentation/git-switch.adoc ##
>      -@@ Documentation/git-switch.adoc: should result in deletion of the path).
>      +@@ Documentation/git-switch.adoc: variable.
>        	attached to a terminal, regardless of `--quiet`.
>        
>        `-t`::
>      @@ builtin/checkout.c
>        #include "resolve-undo.h"
>        #include "revision.h"
>       +#include "run-command.h"
>      + #include "sequencer.h"
>        #include "setup.h"
>        #include "strvec.h"
>      - #include "submodule.h"
>       @@ builtin/checkout.c: struct checkout_opts {
>        	int count_checkout_paths;
>        	int overlay_mode;
>
>
>  Documentation/git-checkout.adoc |  13 ++-
>  Documentation/git-switch.adoc   |  13 ++-
>  builtin/checkout.c              | 168 +++++++++++++++++++++++++++++++-
>  t/t7201-co.sh                   | 144 +++++++++++++++++++++++++++
>  4 files changed, 332 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index a8b3b8c2e2..ec63434159 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -158,11 +158,22 @@ of it").
>  	resets _<branch>_ to the start point instead of failing.
>  
>  `-t`::
> -`--track[=(direct|inherit)]`::
> +`--track[=(direct|inherit|fetch)[,...]]`::
>  	When creating a new branch, set up "upstream" configuration. See
>  	`--track` in linkgit:git-branch[1] for details. As a convenience,
>  	--track without -b implies branch creation.
>  +
> +The argument is a comma-separated list. `direct` (the default) and
> +`inherit` select the tracking mode and are mutually exclusive. Adding
> +`fetch` requests that the remote be fetched before _<start-point>_ is
> +resolved, so the new branch starts from a fresh tip: when
> +_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
> +updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
> +only the remote's default branch is updated. If the fetch fails and the
> +corresponding remote-tracking ref already exists, a warning is printed
> +and the checkout proceeds from the existing tip; otherwise the checkout
> +is aborted.
> ++
>  If no `-b` option is given, the name of the new branch will be
>  derived from the remote-tracking branch, by looking at the local part of
>  the refspec configured for the corresponding remote, and then stripping
> diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
> index d6c4f229a5..b5e79435cd 100644
> --- a/Documentation/git-switch.adoc
> +++ b/Documentation/git-switch.adoc
> @@ -155,11 +155,22 @@ variable.
>  	attached to a terminal, regardless of `--quiet`.
>  
>  `-t`::
> -`--track[ (direct|inherit)]`::
> +`--track[=(direct|inherit|fetch)[,...]]`::
>  	When creating a new branch, set up "upstream" configuration.
>  	`-c` is implied. See `--track` in linkgit:git-branch[1] for
>  	details.
>  +
> +The argument is a comma-separated list. `direct` (the default) and
> +`inherit` select the tracking mode and are mutually exclusive. Adding
> +`fetch` requests that the remote be fetched before _<start-point>_ is
> +resolved, so the new branch starts from a fresh tip: when
> +_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
> +updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
> +only the remote's default branch is updated. If the fetch fails and the
> +corresponding remote-tracking ref already exists, a warning is printed
> +and the switch proceeds from the existing tip; otherwise the switch is
> +aborted.
> ++
>  If no `-c` option is given, the name of the new branch will be derived
>  from the remote-tracking branch, by looking at the local part of the
>  refspec configured for the corresponding remote, and then stripping
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 1345e8574a..fc58456546 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -25,10 +25,12 @@
>  #include "preload-index.h"
>  #include "read-cache.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "remote.h"
>  #include "repo-settings.h"
>  #include "resolve-undo.h"
>  #include "revision.h"
> +#include "run-command.h"
>  #include "sequencer.h"
>  #include "setup.h"
>  #include "strvec.h"
> @@ -62,6 +64,7 @@ struct checkout_opts {
>  	int count_checkout_paths;
>  	int overlay_mode;
>  	int dwim_new_local_branch;
> +	int fetch;
>  	int discard_changes;
>  	int accept_ref;
>  	int accept_pathspec;
> @@ -115,6 +118,158 @@ struct branch_info {
>  	char *checkout;
>  };
>  
> +static int resolve_fetch_target(const char *arg, char **remote_out,
> +				char **src_ref_out, char **existing_ref_out)
> +{
> +	const char *slash;
> +	char *remote_name = NULL;
> +	struct remote *remote = NULL;
> +	struct refspec_item query = { 0 };
> +	struct strbuf dst = STRBUF_INIT;
> +	struct object_id oid;
> +	const char *rest = NULL;
> +	const char *head_target = NULL;
> +	const char *short_target;
> +
> +	*remote_out = NULL;
> +	*src_ref_out = NULL;
> +	*existing_ref_out = NULL;
> +
> +	if (!arg || !*arg || *arg == '/')
> +		return -1;
> +
> +	slash = arg + strlen(arg);
> +	while (1) {
> +		free(remote_name);
> +		remote_name = xstrndup(arg, slash - arg);
> +		remote = remote_get(remote_name);
> +		if (remote && remote_is_configured(remote, 1))
> +			break;
> +		while (slash > arg && *--slash != '/')
> +			;
> +		if (slash == arg) {
> +			free(remote_name);
> +			return -1;
> +		}
> +	}

OK.  So the caller gives "foo/bar/baz" when "foo/bar" is the name of
the remote that uses "refs/remotes/foo/bar" to store remote-tracking
branches from there.  You check "foo/bar/baz", which fails to be a
remote, then "foo/bar", which is a configured remote and break.

> +
> +	if (*slash == '/' && slash[1])
> +		rest = slash + 1;

And "baz" becomes the "rest"; if the user gave us "foo/bar" and the
abobve loop found it as the name of the remote, we would want to use
"refs/remotes/foo/bar/HEAD", which is the "if (!rest)" below is
about.

> +	if (!rest) {
> +		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
> +		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +						      dst.buf,
> +						      RESOLVE_REF_READING |
> +						      RESOLVE_REF_NO_RECURSE,
> +						      &oid, NULL);
> +		if (head_target) {
> +			*existing_ref_out = xstrdup(dst.buf);
> +			if (skip_prefix(head_target, "refs/remotes/", &short_target) &&
> +			    skip_prefix(short_target, remote_name, &short_target) &&
> +			    *short_target == '/')
> +				rest = short_target + 1;
> +		}
> +		strbuf_reset(&dst);
> +	}

So we may have been given "foo/bar" and after resolving HEAD there,
have "baz" in rest.  Or "foo/bar/baz" was given and we may have
figured out that that is "baz" in "foo/bar".

> +	if (rest) {
> +		strbuf_addf(&dst, "refs/remotes/%s/%s", remote_name, rest);
> +		query.dst = dst.buf;
> +		if (!remote_find_tracking(remote, &query) && query.src) {
> +			*src_ref_out = xstrdup(query.src);
> +			free(query.src);
> +		} else {
> +			*src_ref_out = xstrdup(rest);
> +		}
> +		if (!*existing_ref_out) {
> +			strbuf_reset(&dst);
> +			strbuf_addf(&dst, "refs/remotes/%s", arg);
> +			if (!refs_read_ref(get_main_ref_store(the_repository),
> +					   dst.buf, &oid))
> +				*existing_ref_out = xstrdup(dst.buf);
> +		}
> +	}

What happens if "HEAD" was not there, though.  If "refs/remotes/foo/bar/"
did not exist, we would have already returned -1 after trying to
find which part in arg is the remote name.  But if "refs/remotes/foo/bar"
is valid, the user gave us "foo/bar", and we cannot find HEAD, then
the above "if (rest)" is skipped.  We give "foo/bar" to *remote_out,
and return 0 without touching *src_ref_out or *existing_ref_out at
all.

> +	strbuf_release(&dst);
> +	*remote_out = remote_name;
> +	return 0;
> +}
> +
> +static void fetch_remote_for_start_point(const char *arg)
> +{
> +	char *remote_name = NULL;
> +	char *src_ref = NULL;
> +	char *existing_ref = NULL;
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +	if (resolve_fetch_target(arg, &remote_name, &src_ref, &existing_ref))
> +		return;
> +
> +	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
> +	if (src_ref)
> +		strvec_push(&cmd.args, src_ref);

What should happen with this configuration

    [remote "origin"]
        fetch = refs/heads/*:refs/upstream/*

and the user says either of these two:

    $ git checkout --track=fetch upstream
    $ git checkout --track=fetch upstream/master

We fail to find in "where does the remote name ends and branch name
start?" loop that this request is about remote "origin" at all, no?
We may see in the former case that there is
refs/remotes/upstream/HEAD >that points at "master" in the same
hierarchy, but the code thinks "upstream" is the remote name, which
would mean you would "git fetch upstream", when the remote you need
to fetch from is "origin".

> +	cmd.git_cmd = 1;
> +	if (run_command(&cmd)) {
> +		if (existing_ref)
> +			warning(_("failed to fetch start-point '%s'; "
> +				  "using existing '%s'"),
> +				arg, existing_ref);
> +		else
> +			die(_("failed to fetch start-point '%s'"), arg);

If we failed to set *existing_ref_out, shouldn't we fail without
even attempting to call run_command() here, as we will have to die()
anyway even if "git fetch" succeeds.  For that matter, it may be
simpler and more correct for resolve_fetch_target() to fail (return
-1) when it happens, by making the lat "if (rest) {...}" to have a
corresponding "else { return -1 }" after it.

> +	}
> +
> +	free(remote_name);
> +	free(src_ref);
> +	free(existing_ref);
> +}

I'll stop here.
