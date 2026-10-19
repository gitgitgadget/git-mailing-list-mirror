Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445090;
	b=1KrigRfPPYWhFE9f/6neVKk0Ho0v3/0ruJrigv8CILBblmg5sURemnIcdZ7KlP6MQPPP
	 ADLSiDs1si1uzpI2oU8zP3ivb4znU9zr+2Rlhfl5V/RbVPwRpHJfG+iveo7uinS8RR2Hc
	 g38XVSQsU72scJop3P0lhmWhlyihJGX0fjnuNpr3UlfHSWdgAhT9V5+QSrLib5YVqIES7
	 VM5j6OYPMWjyf3t0ZNBpz5ky1UrBKZRztwr7uAb2krSh/WLjSv/i+aq4sN8VAEQeM8S9O
	 HTfiYIEgiXV9YVPRe7sNbDYSQGCOg3OPyZdCRVm033R1ZTHjG+zpEJDnZ0PqA0RTImQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445090;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=L3FCo1Z45dyMGJGZ1ZlpCFl6cDGFdSHXkkVomRL0zU8=;
	b=EgUht7nf/6PV2Hc3EvDwu0qyTN14SQGU660hkxRkQG22zHJF0ibSXzqLEFOwuI3oVkLv
	 lDTXpUCSZ6bCp4jFPDvflnQihhywAPGVQaD1OWsejXxFU02DK5RtHDZhdCLbc1sQdOXMC
	 cvVLpJhuKSmYgGjjM17mj1bpCr+u20kvW9zKsGyyT7u0P8M39Jr2UiC92sjXU3vA5unzd
	 K7h0B7ByAtTc2nyzu1qcm8my3hr2VLfzG4JFNMfQxApg2Jt2IYZzjUl46XbqCQ1yRoCSt
	 Wnt/59nCzV6SWC49ONWM34uVOmKNE03LhaEEpDrnFkbH7Hqx6zfXB45pCM2uV1Yd89A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b="hjBMH9/9";
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE59606A323
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE59606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=hjBMH9/9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792445083; bh=i9yYuQ12cjOjEJmEBMlfCzDyxM65NrSrhuSFsPXW8ig=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hjBMH9/9vbecf5Wm0j5MKQ2HYWzHiz0fZwUK8UgXaeLhzSEWCE1r6J+wyaOiin0KD
	 r21On7b/Wd8600W5wzRfrVcILk6JycKypDXeEPXo4QTbn9BtSY2/C5kUlNbwHFsUGO
	 uQdlSVtKjwdB+M5IldPrBonQsBp7UUGRk3k13dxk=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 20BAB6225B;
	Mon, 19 Oct 2026 21:24:43 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 17:24:30 -0400
Message-Id: <DM94QXU2Y6J7.39IGDUTB5XN1L@lfurio.us>
Subject: Re: [PATCH v1] remote.c: defer remote.<name>.followRemoteHEAD
 validation
Cc: <gitster@pobox.com>
To: "Colin Hinton" <colinlewishinton@gmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261018235508.848-1-colinlewishinton@gmail.com>
In-Reply-To: <20261018235508.848-1-colinlewishinton@gmail.com>

On Sun Oct 18, 2026 at 7:55 PM EDT, Colin Hinton wrote:
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
> Because both settings now go through the same parser,
> fetch.followRemoteHEAD accepts "warn-if-not-<branch>", which
> previously was only recognized for remote.<name>.followRemoteHEAD.
> Document it under fetch.followRemoteHEAD, drop the remote-specific
> paragraph, and add tests for the new fetch-level form.

I think a better justification is needed for this.  The intent behind
'warn-if-not-<branch>' makes much less sense in the context of the fetch
variable imo, and if it turns out to be problematic, reverting support
later will be tricky.

See previous discussion:
<20260611060123.GA2187173@coredump.intra.peff.net>
<DJ6IBPYNOTTY.3QKEZQ28P713V@ferdinandy.com>

>
> Messages for an unrecognized or missing value no longer name the
> fetch. prefix, as the helper now serves both the fetch-level and
> the remote-level setting.

I agree with Junio that this should be addressed.

>
> @@ -139,6 +139,9 @@ remove the value for the `fetch.bundleCreationToken` =
value before fetching.
>  `warn`;;
>  	Display a warning if the remote advertises a different `HEAD` than what=
 is
>  	set locally.  Behaves like "create" if the local symbolic-ref doesn't e=
xist.
> +`warn-if-not-<branch>`;;
> +	Like "warn", but do not display the warning if the remote's `HEAD`
> +	is `remotes/<name>/<branch>`.
>  `always`;;
>  	Silently update `remotes/<name>/HEAD` whenever the remote advertises a =
new
>  	value.

I like the style change from $branch to <branch>

> @@ -1978,14 +1982,10 @@ static int do_fetch(struct transport *transport,
>  		if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> -			/*
> -			 * See remote.c's handling of remote.<name>.followRemoteHEAD
> -			 * for the analogous, still-unresolved case.
> -			 */
> -			if (transport->remote->follow_remote_head)
> -				follow_remote_head =3D transport->remote->follow_remote_head;
> +			if (transport->remote->follow_remote_head_seen)
> +				follow_remote_head =3D get_follow_remote_head(transport->remote->fol=
low_remote_head_raw, &no_warn_branch);
>  			else if (config->follow_remote_head_seen)
> -				follow_remote_head =3D get_follow_remote_head(config->follow_remote_=
head_raw);
> +				follow_remote_head =3D get_follow_remote_head(config->follow_remote_=
head_raw, &no_warn_branch);

A couple more overly-long lines

>  			else
>  				follow_remote_head =3D BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
>  		}

By the way, I had previously made a comment about moving the definition
of 'enum follow_remote_head_settings' over to the fetch file since that
is now the only place it is relevant.  Do you think it's worth changing?
