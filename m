Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16E1E47CC
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963046; cv=pass; b=TASzYn8/LHUjEEcUoM3LTqCyUR3+Y7hYgNUKxFpVY1nihP5n1UukW8wv22+h9opAxUhkRGnZWrZi0WWRUNVBTtVnhYdV3B6d3SWR0pcS0x3eV5gSZNRP5YUQuu0JSxlVt28EDNyz63BFIZpwytLoaa0daQXJgi6tkrGaGDPnuHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963046; c=relaxed/simple;
	bh=x4ZIiJvSaYZRNDx2tSkfgrOIfcKr21oYryB/TUtJImc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIUukI1h68Pg2TRCnKY28ewmQ8eysG5N1l0TB6q5p2ebAxxOfE+sQv0VbqS+frruXQ+zoacjhd33Hzn+2zYI843zPwQTqaMunYkJ1EBMU6rQlNIX+UoZnOcMgTnDNN2KWlwYMIJuG+FGabhAZDnaC+U6QgoSGp8RzYMXNw2vHZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WVwIKCJ4; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WVwIKCJ4"
ARC-Seal: i=1; a=rsa-sha256; t=1764963028; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=POPkI3/Z5OZus6SNLyNfGMK0PZCfdvO0IXQ19E0ORODFuo1rzOSkZ7x1LEJrwUIYs0vhDRgEhv6mY8mlbZVG9dT2OU0J0NpiKuXltgGuMD5c/IPw9Ih0qKAWP6e9UIaRCdORcjwGYkzi4EZ7iPK/3Qt3R/NQID4jA4O7Q1cSoVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764963028; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oAbH4pWtdnsxGLJKo/A1wZ13rNDTbtq4v+h6QOmqL+M=; 
	b=agS755zqbxZXPEfzx8LgqvhdACaa04WM5V0oN7NMxReu2wNeNSS9z4grKd+q2qR0K9kX9+sGKlV6OKXvkXQrmJPDFAd04bSEANGaGprD2jkrcUBijweNDtIOQ6saPp6q2uvsLGuyN6NLdRVcGGLN5Dly9LKXXBMam4obj7+yQcc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764963028;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=oAbH4pWtdnsxGLJKo/A1wZ13rNDTbtq4v+h6QOmqL+M=;
	b=WVwIKCJ429pRzlqN2he6jIlZTFbWINFe746f9PyvRmVrVzA0qDMT3rBJ1JdGAwB+
	kM+1rKnq9LuGfyf+sdUay9mp3X/zGIbHwjfFVCM+Jqv0SlgXN6hfg+Ye5RR5cl7PCGC
	M1VPr0suWF3Ckvz5I5ip5JlSWtKRzp1XJEmFydXo=
Received: by mx.zohomail.com with SMTPS id 1764963026751242.07227632400418;
	Fri, 5 Dec 2025 11:30:26 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
In-Reply-To: <aTLNwHpLUcy-WsZs@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
 <aTLNwHpLUcy-WsZs@pks.im>
Date: Fri, 05 Dec 2025 21:30:21 +0200
Message-ID: <87v7ikeng2.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Nov 19, 2025 at 11:10:27PM +0200, Adrian Ratiu wrote:
>> Add a submoduleEncoding extension which fixes filesystem collisions by
>> encoding gitdir paths. At a high level, this implements a mechanism to
>> encode -> validate -> retry until a working gitdir path is found.
>> 
>> Credit goes to Junio for coming up with this design: encoding is only
>> applied when necessary, e.g. uppercase characters are encoded only on
>> case-folding filesystems and only if a real conflict is detected.
>> 
>> To make this work, we rely on the submodule.<name>.gitdir config as the
>> single source of truth for gitidir paths: the config is always set when
>
> s/gitidir/gitdir/

Ack, will fix.

>
>> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
>> index 532456644b..4861d01894 100644
>> --- a/Documentation/config/extensions.adoc
>> +++ b/Documentation/config/extensions.adoc
>> @@ -73,6 +73,12 @@ relativeWorktrees:::
>>  	repaired with either the `--relative-paths` option or with the
>>  	`worktree.useRelativePaths` config set to `true`.
>>  
>> +submoduleEncoding:::
>> +	If enabled, submodule gitdir paths are encoded to avoid filesystem
>> +	conflicts due to nested gitdirs, case insensitivity or other issues.
>> +	When enabled, the submodule.<name>.gitdir config is always set for
>> +	all submodules and is the single point of authority for gitdir paths.
>> +
>>  worktreeConfig:::
>>  	If enabled, then worktrees will load config settings from the
>>  	`$GIT_DIR/config.worktree` file in addition to the
>
> I think the fact that the submodule gitdir paths are encoded now is
> secondary to this repository extension. The more important fact is that
> this changes the source of truth where the submodule gitdir path is
> actually derived from: before it was derived on the fly, whereas now it
> is persisted in the gitconfig.
>
> It follows that because the source of truth is now a persistent entry in
> the configuration, other implementations can read it without having to
> understand how exactly the value was computed in the first place. So an
> implementation may arbitrarily change the algorithm it uses to derive
> that path from now on, and it doesn't necessarily have to encode
> anything.
>
> So I'd propose to rename the extension and rephrase its description
> accordingly. It could for example be called something along the lines of
> "submodulePathConfig".

I think this is a very reasonable suggestion, thanks!

If nobody has objections or better suggestions, I will rename the
extension to "submodulePathConfig" and reword the description as you
suggested.

>
>> diff --git a/submodule.c b/submodule.c
>> index 8ef028f26b..07cb4694cf 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2559,33 +2591,74 @@ int submodule_to_gitdir(struct repository *repo,
>>  	return ret;
>>  }
>>  
>> +static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
>> +					     const char *submodule_name)
>> +{
>> +	char *key;
>> +
>> +	if (validate_submodule_encoded_git_dir(gitdir_path->buf, submodule_name))
>> +		return -1;
>> +
>> +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
>> +	repo_config_set_gently(the_repository, key, gitdir_path->buf);
>> +	FREE_AND_NULL(key);
>
> I think a simple call to `free()` should be sufficient here. There is no
> risk of it being used afterwards.

Ack, will fix.

>
>> +	return 0;
>> +}
>> +
>>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>>  			      const char *submodule_name)
>>  {
>> +	const char *gitdir;
>> +	char *key;
>> +
>> +	repo_git_path_append(r, buf, "modules/");
>> +	strbuf_addstr(buf, submodule_name);
>> +
>> +	/* If extensions.submoduleEncoding is disabled, use the plain path set above */
>> +	if (!r->repository_format_submodule_encoding) {
>> +		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
>> +			die(_("refusing to create/use '%s' in another submodule's "
>> +			      "git dir"), buf->buf);
>> +
>> +		return; /* plain gitdir is valid for use */
>> +	}
>> +
>> +	/* Extension is enabled: use the gitdir config if it exists */
>> +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
>> +	if (!repo_config_get_string_tmp(r, key, &gitdir)) {
>> +		strbuf_reset(buf);
>> +		strbuf_addstr(buf, gitdir);
>> +		FREE_AND_NULL(key);
>> +
>> +		/* validate because users might have modified the config */
>> +		if (validate_submodule_encoded_git_dir(buf->buf, submodule_name))
>> +			die(_("Invalid 'submodule.%s.gitdir' config: '%s' please check "
>> +			      "if it is unique or conflicts with another module"),
>
> Nit: error messages start with a lower-case character.

Ack, will fix.

>
>> +			    submodule_name, gitdir);
>> +
>> +		return;
>> +	}
>> +	FREE_AND_NULL(key);
>> +
>>  	/*
>> -	 * NEEDSWORK: The current way of mapping a submodule's name to
>> -	 * its location in .git/modules/ has problems with some naming
>> -	 * schemes. For example, if a submodule is named "foo" and
>> -	 * another is named "foo/bar" (whether present in the same
>> -	 * superproject commit or not - the problem will arise if both
>> -	 * superproject commits have been checked out at any point in
>> -	 * time), or if two submodule names only have different cases in
>> -	 * a case-insensitive filesystem.
>> -	 *
>> -	 * There are several solutions, including encoding the path in
>> -	 * some way, introducing a submodule.<name>.gitdir config in
>> -	 * .git/config (not .gitmodules) that allows overriding what the
>> -	 * gitdir of a submodule would be (and teach Git, upon noticing
>> -	 * a clash, to automatically determine a non-clashing name and
>> -	 * to write such a config), or introducing a
>> -	 * submodule.<name>.gitdir config in .gitmodules that repo
>> -	 * administrators can explicitly set. Nothing has been decided,
>> -	 * so for now, just append the name at the end of the path.
>> +	 * The gitdir config does not exist, even though the extension is enabled.
>> +	 * Therefore we are in one of the following cases:
>>  	 */
>> +
>> +	/* Case 1: legacy migration of valid plain submodule names */
>> +	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
>> +		return;
>> +
>> +	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
>> +	strbuf_reset(buf);
>>  	repo_git_path_append(r, buf, "modules/");
>> -	strbuf_addstr(buf, submodule_name);
>> +	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
>> +	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
>> +		return;
>>  
>> -	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
>> -		die(_("refusing to create/use '%s' in another submodule's "
>> -		      "git dir"), buf->buf);
>> +	/* Case 3: Nothing worked: error out */
>> +	die(_("Cannot construct a valid gitdir path for submodule '%s': "
>> +	      "please set a unique git config for 'submodule.%s.gitdir'."),
>> +	    submodule_name, submodule_name);
>
> It feels somewhat fragile to me that we unconditionally handle these
> cases and try to find old submodule directories. If the extension is
> enabled I'd expect that the submodule configuration is the _only_ source
> of truth.
>
> May I propose that we instead always error out in case the submodule
> configuration does not exist? In the best case we'd then give the user a
> nice error message that tells them how to run the migration manually.

Junio told me to not do any kind of manual migration and just attempt
new names until one works and then use it consistently.

That's why the "submodule.%s.gitdir" path is always used if set and
has precedence (no new names are attempted). :)

>
> (Coming back from reading subsequent patches) Maybe what's putting me
> off is that this function is seemingly used for two things:
>
>   1. To derive the submodule path in case we know it should already
>      exist.
>
>   2. To compute the submodule path so we can end up writing it into the
>      "submodule.*.gitdir" variable.
>
> I think we should tell these two cases apart. In the first case I expect
> that we never fall back to a computed name, but bail out in case the
> configuration key does not exist. And in the second case it of course
> makes sense to compute the actual path that we want to store in the
> configuration.

I think I understand where you're coming from.

Even before my patches, the unmodified submodule_name_to_gitdir() is
used for both new (non-existing) and old (existing) submodules.

It has no way of knowing whether a submodule exists, whether it should
exist, or whether a new name is required for a new clone, which will
eventually exist in the future.

If I also understood your suggestion, you just need an additional check
to verify if the path pointed to by "submodule.%s.gitdir" is an existing
gitdir and error out if not?

Or did I misunderstood your suggestion and you mean to bail out if the
config key is missing entirely for any submodule when the extension is
enabled?

That would imply a manual migration by the user which is something both
Aaron and Junio asked me to avoid and Josh also said they want to avoid
setting any kind of config keys (or distributing configs), so that's why
I also added the compile-time extension option, to ease the transition,
together with the "retry-on-fallback" approach for setting the config.

I am in favor of implementing the split you suggested, however how do we
automatically figure out if a name's gitdir **should** exist if you mean
the latter not the former? :)
