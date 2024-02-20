Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AB154444
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469837; cv=none; b=AlHgeGrDfxoa+CVKikW2U3hMo9/0EI/quzs3mp5Dy3kbiL2l2GdJPxjqpOvWvEqR1yehf3wjto2Yr9Wt1an5coZLX8f9ceRNtWihhd9ohvP+5VboBbGoFVchhujpprlCvSlgpH+7nGHi9+Eps9kTifS2zKF9xMhRBNPgeRzICmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469837; c=relaxed/simple;
	bh=OEiQ0FGPqPAYin5pAa14nq+3E/HAXJujSsadsKPNH6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YpbrOZ98r7ciOFaTJzDEutZGxtkceTzPHI0JmS0Hd04dKTzEM2n6fRag/SaPfQTMZEy3FDeulBxwtg1gge01pmfdT51fYkYS5M4caD/BYrdm/gJ44fTkjZEXG3C/SCFhd0Va9matLvessUtu0DCPdu8w9k29B/5SSKfR2csAsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=drZgqlqp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="drZgqlqp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EE191EB90F;
	Tue, 20 Feb 2024 17:57:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OEiQ0FGPqPAY
	in5pAa14nq+3E/HAXJujSsadsKPNH6k=; b=drZgqlqpGl0ZoHz+BnXm6vKWOhT7
	fIKNYsAgBNTYnYkjlJtXO5SO9vRV4v8LW2T4tx/HbVsttluzt649RzZkl5nObfpa
	B1XilTYxJbEsCAKgAArmuvSzyVzzgsuxAf/x/ujv8SeHt+MpV9/k0MRVL8pqd/7S
	wTklGDCSgIoJU2o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4646D1EB90E;
	Tue, 20 Feb 2024 17:57:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5DC61EB90D;
	Tue, 20 Feb 2024 17:57:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line
 description syntax
In-Reply-To: <17b0284c379e62a756e1bba008f4671f6afc0ad9.1708468374.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 20 Feb 2024
	22:32:52 +0000")
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
	<17b0284c379e62a756e1bba008f4671f6afc0ad9.1708468374.git.gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 14:57:12 -0800
Message-ID: <xmqqsf1mlp6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 62F91918-D043-11EE-83C8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  [verse]
> -'git rev-parse' [<options>] <args>...
> +'git rev-parse' [<options>] <arg>...

Good.  The "or more" is signalled by the ellipsis, not "args" being
plural.

> ---short[=3Dlength]::
> +--short[=3D<length>]::
>  	Same as `--verify` but shortens the object name to a unique
>  	prefix with at least `length` characters. The minimum length

This same comment applies throughout this patch, but in other places
when we use <placeholder> in the option argument description, don't
we use the same <placeholder> in text as well?  I am wondering if
the `length` (typeset in fixed-width) should become <length>.  What
do other recent[*] documentation pages commonly do?

	Side note: I say "recent" because rev-parse doc is one of
	the oldest ones that did not get typesetting attention they
	deserve, compared to more recent ones that got nitpicked
	while they were written and updated.

> ---branches[=3Dpattern]::
> ---tags[=3Dpattern]::
> ---remotes[=3Dpattern]::
> +--branches[=3D<pattern>]::
> +--tags[=3D<pattern>]::
> +--remotes[=3D<pattern>]::
>  	Show all branches, tags, or remote-tracking branches,
>  	respectively (i.e., refs found in `refs/heads`,
>  	`refs/tags`, or `refs/remotes`, respectively).

Ditto.  We see `pattern` that may want to become <pattern> in the
description (after the post context of this hunk).

> ---glob=3Dpattern::
> +--glob=3D<pattern>::
>  	Show all refs matching the shell glob pattern `pattern`. If
>  	the pattern does not start with `refs/`, this is automatically
>  	prepended.  If the pattern does not contain a globbing

Ditto.

> ---exclude-hidden=3D[fetch|receive|uploadpack]::
> +--exclude-hidden=3D(fetch|receive|uploadpack)::
>  	Do not include refs that would be hidden by `git-fetch`,
>  	`git-receive-pack` or `git-upload-pack` by consulting the appropriate
>  	`fetch.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs`

Good.

> ---since=3Ddatestring::
> ---after=3Ddatestring::
> +--since=3D<datestring>::
> +--after=3D<datestring>::
>  	Parse the date string, and output the corresponding
>  	--max-age=3D parameter for 'git rev-list'.

Good, modulo possibly "date string" -> "<datestring>".

> ---until=3Ddatestring::
> ---before=3Ddatestring::
> +--until=3D<datestring>::
> +--before=3D<datestring>::
>  	Parse the date string, and output the corresponding
>  	--min-age=3D parameter for 'git rev-list'.

Ditto.

> -<args>...::
> +<arg>...::
>  	Flags and parameters to be parsed.

Good.
