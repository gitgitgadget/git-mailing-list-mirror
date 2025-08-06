Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7B23CE
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481688; cv=none; b=Rhjjw1Jh8eSOJ/dEzx7WIQahbviDtwTPnvu/h0OKOguob7j/i9OmaBkSzEG4xPpZFdnx7vKxyodeaR5lr7G5VlL/EooBmPVNSGsnbe1SfLFT7+cIBfmAYIuPCcrrNwSsjQwwEMvJlQG2XXq6uHkPIuNsjVENFR8RuB4ygkGVYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481688; c=relaxed/simple;
	bh=Clgl0vaHPA3QsDcaA0WWEsUOZual3hvfUIgq4GnNwmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQjKGFkbpDItXkxaVJXyzhKQex0WZ1NRxpJ5CTVGl+tjvbrQY2BZg38M6owF+czukDTP9tU48WYltlOI1LRg39Z24zQ1e8QdXtzwaE/biy4jlb1ORNIvYv1bx4arWIQsHVHJEP5hmBWAhgmQ5OSTVzL3OXqNp1AK4RYw2vN3Tek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=odLLCf9J; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="odLLCf9J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754481679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ndo0USezKLV+M6uKlyfSdsG0Vtv/nS9PGYX2BMHeNvA=;
	b=odLLCf9JbaNSLIv29gzgWSFyfQTYUrb781cKc8D3oiC+LvW4ZTTOT8mqteEuTmnxb/PHKm
	rGj0n6VkRBxjQZ927a1Rr6dinklxt6R6zurIfP5lZE5cU9cuP2/74CzRl3aZyFU1DAZGtQ
	xn0cL3s4xUduS3b5XBDerGnepNI8Z1c=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>, git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <xmqqwm7hxx0a.fsf@gitster.g>
References: <20250730175510.987383-1-toon@iotcl.com>
 <xmqqjz3h20cs.fsf@gitster.g> <87tt2lu2rx.fsf@iotcl.com>
 <1929210.tdWV9SEqCh@cayenne> <xmqqwm7hxx0a.fsf@gitster.g>
Date: Wed, 06 Aug 2025 14:01:04 +0200
Message-ID: <87qzxou0an.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> This is what I queued on top of your topic to prepare the
> integration today.
>
> --- >8 ---
> From: Junio C Hamano <gitster@pobox.com>
> Date: Tue, 5 Aug 2025 14:37:25 -0700
> Subject: [PATCH] fixup! last-modified: new subcommand to show when files were last modified
>
> ---
>  Documentation/git-last-modified.adoc | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
> index 35bd4a1dd0..602843e095 100644
> --- a/Documentation/git-last-modified.adoc
> +++ b/Documentation/git-last-modified.adoc
> @@ -22,24 +22,24 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>  OPTIONS
>  -------
>  
> --r::
> ---recursive::
> +`-r`::
> +`--recursive`::
>  	Instead of showing tree entries, step into subtrees and show all entries
>  	inside them recursively.
>  
> --t::
> ---show-trees::
> +`-t`::
> +`--show-trees`::
>  	Show tree entries even when recursing into them. It has no effect
>  	without `--recursive`.
>  
> -<revision-range>::
> +`<revision-range>`::
>  	Only traverse commits in the specified revision range. When no
>  	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
>  	history leading to the current commit). For a complete list of ways to
>  	spell `<revision-range>`, see the 'Specifying Ranges' section of
>  	linkgit:gitrevisions[7].
>  
> -[--] <path>...::
> +`[--] <path>...`::
>  	For each _<path>_ given, the commit which last modified it is returned.
>  	Without an optional path parameter, all files and subdirectories
>  	in path traversal the are included in the output.
> -- 
> 2.51.0-rc0-162-g220549999b

Looks good to me. Do you want me to reroll, or will you `--autosquash`
yourself? 

-- 
Cheers,
Toon
