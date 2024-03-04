Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9687D07C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596502; cv=none; b=gdMurXWE0YWPaQiNuIi2DL5zsiVPiHJ+9ZUocVlobDLUW6SpLjJMrRGUUzrV4oLTaFb65bA77qso83m+vKKtE3nHXXHPA2NGBL00dTRc08bJfig8QfCtsIssIdfL5zbV9P0R1yTxagAyZc85dUihtQAo+obYhtJdzOYj30ecGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596502; c=relaxed/simple;
	bh=zZuZnVcwCtWv28HbGY2bLeFOHzJnXQXVSzQtQL7wO+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HxAXzZEw+0nN0f/kV1LnCi0cxHw11k6OGkgjwNWeVlXg+tz1P70JYDelel/qmubkPEOERWY6I/eDN0q6cHkxTTJYVRCEHfBtvLxqYOoZS53z0JgJKfMnqsOonTyulznfHngDJ6Hxe19fU1/7NrcwWTR1uw2J3PdPTZK9GTqpe1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p2TWXNDN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p2TWXNDN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF6711D1C52;
	Mon,  4 Mar 2024 18:54:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zZuZnVcwCtWv
	28HbGY2bLeFOHzJnXQXVSzQtQL7wO+k=; b=p2TWXNDNAgXkjoYXoDwPyh/4oFxb
	t1E3qbCO9vwktgtQE5D6aIqO7mPJ25ExPc9H7D+zHzn2MuSERO8ytf5LhQksqv5E
	DdPeR/JVtWw8y+SPceLzZArI2gyIncN8r9AVPS0/rJw/WN8T7Vpa+RggwjyACqNq
	5E7i3btmIsZxx5M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E57881D1C51;
	Mon,  4 Mar 2024 18:54:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 581C41D1C50;
	Mon,  4 Mar 2024 18:54:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/5] advice: use backticks for code
In-Reply-To: <30d662a04c75b80166db9ef94f95e8a841994fb5.1709590037.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Mon, 4 Mar 2024 23:07:28 +0100")
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
	<cover.1709590037.git.code@khaugsbakk.name>
	<30d662a04c75b80166db9ef94f95e8a841994fb5.1709590037.git.code@khaugsbakk.name>
Date: Mon, 04 Mar 2024 15:54:58 -0800
Message-ID: <xmqqzfvdlfhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9C0CAB4A-DA82-11EE-92B6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Use backticks for quoting code rather than single quotes.

Good.  Technically it does not have to be "code", but rather what
the user would literally type from their keyboard verbatim, but
"quoting code" is so concise way to describe, it probably is good
enough hint for future developers who will find this commit via "git
blame" and read "git show" to read this explanation.

> Also replace =E2=80=9Cthe add command=E2=80=9D with =E2=80=9C`git add`=E2=
=80=9D.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/config/advice.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/adv=
ice.txt
> index cfca87a6aa2..df447dd5d14 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -2,14 +2,14 @@ advice.*::
>  	These variables control various optional help messages designed to
>  	aid new users.  When left unconfigured, Git will give the message
>  	alongside instructions on how to squelch it.  You can tell Git
> -	that you do not need the help message by setting these to 'false':
> +	that you do not need the help message by setting these to `false`:
>  +
>  --
>  	addEmbeddedRepo::
>  		Shown when the user accidentally adds one
>  		git repo inside of another.
>  	addEmptyPathspec::
> -		Shown when the user runs the add command without providing
> +		Shown when the user runs `git add` without providing
>  		the pathspec parameter.
>  	addIgnoredFile::
>  		Shown when the user attempts to add an ignored file to
> @@ -75,7 +75,7 @@ advice.*::
>  		non-fast-forward update to the current branch.
>  	pushNonFFMatching::
>  		Shown when the user ran linkgit:git-push[1] and pushed
> -		'matching refs' explicitly (i.e. used ':', or
> +		'matching refs' explicitly (i.e. used `:`, or
>  		specified a refspec that isn't the current branch) and
>  		it resulted in a non-fast-forward error.
>  	pushRefNeedsUpdate::
> @@ -90,9 +90,9 @@ advice.*::
>  		refs/heads/* or refs/tags/* based on the type of the
>  		source object.
>  	pushUpdateRejected::
> -		Set this variable to 'false' if you want to disable
> -		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
> -		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
> +		Set this variable to `false` if you want to disable
> +		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
> +		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
>  		simultaneously.
>  	resetNoRefresh::
>  		Shown when linkgit:git-reset[1] takes more than 2
