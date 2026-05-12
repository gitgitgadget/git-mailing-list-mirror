Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C519D531
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545934; cv=none; b=Hsp5yqzQvevgO9t7HHm0CXGvDcTjhLES9nX1+dCnPxF2aYuLbEZYQa8qehO9s5qr/NsbGdulgIzY1GjCn/9QUw+U8j+yYfpNGl6mR3pNJZjDZoQr7dABKjdxmZ2ZcajiKmC7ipGqtXvR5Wn9i1zuJoZWBuFsNIlugO/SSSDIgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545934; c=relaxed/simple;
	bh=DpnnaTym5cqEFMC0FiuovMKOVgKhWYIeSGs0h85bUJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfKfzKGTabbPCJSyNpe8mljFjEplS6172hL16QeSu6j9lNeT31pFXG7G6TZmZu3Q5QV/M3Qr8jWm24TNyiwXHjd/e4Z4O63uhtv54ajUfActOnja2SOQm+GG3bMJneQZb8/csM6LujuWXZ1mtzH+YJSf25zJd2zj7jv5zWRSRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZbYSW/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9x2dxdI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZbYSW/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9x2dxdI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F7EE1D0008A;
	Mon, 11 May 2026 20:32:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 20:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778545931; x=1778632331; bh=N9qsEKwAau
	nDZ1cWGkWaf+fzymKYQU8uvBFGEgnwLbY=; b=TZbYSW/TCfSY1mMCQD5er2uL9D
	0mGieSi5tRAibl7EAI0mu7VRDbr83UfkoBLkfm+j2RlprnOgpGdKeZOg6GYDMg0s
	Erh0kAkVARRG7dk7Lq42II6hp4RlXseR2Xf+MjXap1b9e5FIRYcGGHiFPNLW1ad8
	RGzmScpn7SicBbKPPxGgHboSY0Xr8d+Vxo3rfmZs2fUKB9eRY5G/NQHHUUSyxxMs
	kzvxbvfvSf3k1qglCQqhUldtMWEMRDBuLFSaCIKMf6PqJLHLy4qonfj9kAhJCd5M
	bWLzdLznmVUyF8spZsZ0g/dBx9CDXYIoQvHJWuYcTtUcV+qQ30eRAx/8EDxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778545931; x=1778632331; bh=N9qsEKwAaunDZ1cWGkWaf+fzymKYQU8uvBF
	GEgnwLbY=; b=Y9x2dxdI7JzEf7ujhMjCirtPLwfyrveYc+vBeF4rYZa1KNp3Tb4
	zQhe3Wv2XQ2+bnOiIDYv4043yRI5DhzR5Qk531X/6x3gi2osS9inMbF8M5HF7aah
	+vyqqf8mHzGMmSmco9TS/5NbpV29lQFvtL0u43c7pegX0dmrVpoJJhg9/RP8pgTs
	3oGAO9w63dun0xHtcDJItEe/TaZwujL2OgTWvhvRgb+XvkyQcHL8cQnc/h1Pnj1E
	o5ripucFE/4arGRuMqQqev5Yq7PcWby+qZAqsssmBQO8LwRA6luLf4i7fYil/iY9
	NhV5jw3HxUxdrpr0mzesWG9qsrHY0iym4UQ==
X-ME-Sender: <xms:CnUCagCrHGOV26Zpva86NJTr2SJ7at7EMM_9Og3snZdlYDvw42VRhQ>
    <xme:CnUCaneEY6YfJUTte0L6_AkuySXwCVTekvgWWOFB9BfPFNa8MatrvyPH5bL7Rqml7
    sRvHY2njgvNOdTt7iKurCTlBO2Y74aXI_7R63K9E4o3rXOSQzqJ>
X-ME-Received: <xmr:CnUCan2AlhJv2GVXFEWt7g-FKE39cyEZAKhc8lupsXkhSQ4ofpcz0VOfywdGt6m8RCs7wEvzPfJOaujzs9mEJv-IYXXut6THmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grrhgtnhgrrhgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:CnUCami5YgxnoWEKXWcO76Y6xLlDA7f_VDc0gzXn-Bx0ds1twhqWfg>
    <xmx:CnUCaoldg904wD_i3SuopoLWEzEOKPq26L8BPpVdPYl_xOVvniG3uQ>
    <xmx:CnUCakbQD9eUM8Tr3oHx-HvqjLuH2gKqET8_evvPfHlXKqXCJvsdgQ>
    <xmx:CnUCarHKCO-RCWKzxOX0p1cSTnoG7Is3DHMDl34jF-4vywul_EEFPQ>
    <xmx:C3UCagrZ3_0iYEC8NQT2P_Cp6MSk8OcUi0xodRqlokGRrRWJpNOPpj9K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 20:32:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <pull.2281.v8.git.git.1778507225500.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 11 May 2026
	13:47:05 +0000")
References: <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
	<pull.2281.v8.git.git.1778507225500.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 09:32:09 +0900
Message-ID: <xmqqh5odqxh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 43ccf47cf6..28f17f427e 100644
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
> +only the remote's default branch is updated.

The latter is because "checkout -t -b new remote/origin" makes "new"
track "remote/origin/HEAD", which makes sense.  And of course this
fetch can fail.

> +static int resolve_fetch_target(const char *arg, char **remote_out,
> +				char **src_ref_out)
> +{
> +	const char *slash;
> +	char *remote_name;
> +	struct remote *remote;
> +	struct refspec_item query = { 0 };
> +	struct strbuf dst = STRBUF_INIT;
> +	const char *rest;
> +
> +	*remote_out = NULL;
> +	*src_ref_out = NULL;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +
> +	slash = strchr(arg, '/');
> +	if (slash == arg)
> +		return -1;
> +	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
> +
> +	remote = remote_get(remote_name);
> +	if (!remote || !remote_is_configured(remote, 1)) {
> +		free(remote_name);
> +		return -1;
> +	}
> +
> +	rest = (slash && slash[1]) ? slash + 1 : NULL;

There is no slash when asking for "origin", and the control goes
into the "if (!rest)" block.

> +	if (!rest) {
> +		struct object_id oid;
> +		const char *head_target;
> +		const char *short_target;
> +
> +		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
> +		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +						      dst.buf,
> +						      RESOLVE_REF_READING |
> +						      RESOLVE_REF_NO_RECURSE,
> +						      &oid, NULL);
> +		strbuf_reset(&dst);
> +		if (head_target &&
> +		    skip_prefix(head_target, "refs/remotes/", &short_target) &&
> +		    skip_prefix(short_target, remote_name, &short_target) &&
> +		    *short_target == '/')
> +			rest = short_target + 1;
> +	}

If refs/remotes/origin/HEAD points at refs/remotes/origin/main, rest
gets "main".  Otherwise (i.e. unexpected contents in HEAD or lacking
HEAD), rest remains NULL.  And then we have the "if (rest)" block.

> +	if (rest) {
> +		strbuf_addf(&dst, "refs/remotes/%s/%s", remote_name, rest);
> +		query.dst = dst.buf;
> +		if (!remote_find_tracking(remote, &query) && query.src) {
> +			*src_ref_out = xstrdup(query.src);
> +			free(query.src);
> +		} else {
> +			*src_ref_out = xstrdup(rest);
> +		}
> +	}
> +
> +	strbuf_release(&dst);
> +	*remote_out = remote_name;
> +	return 0;
> +}

It is not a new problem but I do not remember how we explicitly
forbid "hierarchical" remote names.  refs/remotes/a/b/c might be
their branch "b/c" at remote we call "a", or branch "c" at remote
"a/b".  Unless we forbid slashes in remote names, the "there is no
slash so we got only the name of the remote to mean its HEAD" logic
would not work well, so we may want to double check.

> +static void fetch_remote_for_start_point(const char *arg)
> +{
> +	char *remote_name = NULL;
> +	char *src_ref = NULL;
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf dst_ref = STRBUF_INIT;
> +	int have_existing_ref = 0;
> +
> +	if (resolve_fetch_target(arg, &remote_name, &src_ref))
> +		return;
> +
> +	{
> +		struct object_id oid;
> +
> +		if (strchr(arg, '/'))
> +			strbuf_addf(&dst_ref, "refs/remotes/%s", arg);
> +		else
> +			strbuf_addf(&dst_ref, "refs/remotes/%s/HEAD", arg);
> +		if (!refs_read_ref(get_main_ref_store(the_repository),
> +				   dst_ref.buf, &oid))
> +			have_existing_ref = 1;
> +	}

I do not quite see the point of this extra block.  Can we do without
it (and move the def of oid up near the beginning of the function,
of course)?

Even better, as resolve_fetch_target() already looks at "arg" and
poked at the remote-tracking ref hierarchy, wouldn't it make more
sense to make that helper function responsible for finding out if
there already is a usable, albeit potentially stale, ref?  


> +	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
> +	if (src_ref)
> +		strvec_push(&cmd.args, src_ref);
> +	cmd.git_cmd = 1;
> +	if (run_command(&cmd)) {
> +		if (have_existing_ref)
> +			warning(_("failed to fetch start-point '%s'; "
> +				  "using existing '%s'"),
> +				arg, dst_ref.buf);
> +		else
> +			die(_("failed to fetch start-point '%s'"), arg);
> +	}
> +
> +	free(remote_name);
> +	free(src_ref);
> +	strbuf_release(&dst_ref);
> +}

> @@ -1244,7 +1398,6 @@ static int git_checkout_config(const char *var, const char *value,
>  		opts->dwim_new_local_branch = git_config_bool(var, value);
>  		return 0;
>  	}
> -
>  	if (starts_with(var, "submodule."))
>  		return git_default_submodule_config(var, value, NULL);

Unrelated patch noise?

