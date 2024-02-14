Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02360DE5
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937272; cv=none; b=N4nSG12MSIrS+1s+2fVKTnjpq4Co59z71Ab/Oz2m470mBkThSF9L94rjOiskUTlmz6ZK7DB0pFl/idpkoDdOkJZ68g01wHPlPiAwpDc3K229E1TmkbVkrqmvzV/RJKMporu0wi7qcnGVjl8ZGi+D+yu2aoGterH6v3Eg4cltl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937272; c=relaxed/simple;
	bh=7efQLA8ChN+0DvJ6oQLA7FuiLKqMBRxH7AkNIQ50ITs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eHLjArQWfxb/vAEsO9TKkBifUxHbCsEMBLi2wBQTscPvWkNLdfErADFfWRiVawkXkJwIwIBwCOInHaXR0+ZlufxrCynk6iYMKORkQJD+soKCZ4d6u2KN7jrlOEB50dKXvLBYuKd1fYySc84CM9KtWWhJGAFtKOWJVfzt7MUIzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xakP6atb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xakP6atb"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707937267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCn1oxWremBmjYunW4i2vE14vuJfY8bVQF9Ztd/z4Ps=;
	b=xakP6atbexkxRDDijnyojhXtCdtz0D/ZWqlSQn6szSkz0RgdAg9gzhFVn1eQzCmrpOKPSi
	DJ7bqL+R8FwveqbTOhXPtsB6smI7r/3wm8SI2EL0ZTGjTh6d+sZYpbxOj83MzCVuRjy7RX
	M636cXyoM7aNjGlFDj1h2njv/SkWdDthxtjGnG0jpoWM8pbgMuLhvU2u4sfJb++NuQ+5Zl
	+LSWeiz8MwgN6gJjGFSiY0SmvWwmm15DCuLkZVTupy0N2prc5A61hzr5JyXEes5BYjaNlt
	ZkeR7KjxNqDmNBscZHTCPM4WtfMOXVlntotrLCvtUzQ8IAzDV6WFfWq3vXmsug==
Date: Wed, 14 Feb 2024 20:01:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: add shortcut to "am --whitespace=<action>"
In-Reply-To: <xmqqplwyvqby.fsf@gitster.g>
References: <xmqqplwyvqby.fsf@gitster.g>
Message-ID: <c329d3ed43f852453ad78ba430363416@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-14 19:44, Junio C Hamano wrote:
> We refer readers of "git am --help" to "git apply --help" for many
> options that are passed through, and most of them are simple
> booleans, but --whitespace takes from a set of actions whose names
> may slip users' minds.  Give a list of them in "git am --help" to
> reduce one level of redirection only to find out what they are.
> 
> In the helper function to parse the available options, there was a
> helpful comment reminding the developer to update list of <action>s
> in the completion script. Mention the two documentation pages there
> as well.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looking to me, with one small nitpick below.

> ---
>  Documentation/git-am.txt | 3 +++
>  apply.c                  | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 82dadbecc8..67b12f315f 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -128,6 +128,9 @@ include::rerere-options.txt[]
>  	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
>  	program that applies
>  	the patch.

It would be nice to, while there, move "the patch." to the line above.

> ++
> +Valid <action> for the `--whitespace` option are:
> +`nowarn`, `warn`, `fix`, `error`, and `error-all`.
> 
>  --patch-format::
>  	By default the command will try to detect the patch format
> diff --git a/apply.c b/apply.c
> index 3d69fec836..4e57831aeb 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -78,7 +78,8 @@ static int parse_whitespace_option(struct
> apply_state *state, const char *option
>  		return 0;
>  	}
>  	/*
> -	 * Please update $__git_whitespacelist in git-completion.bash
> +	 * Please update $__git_whitespacelist in git-completion.bash,
> +	 * Documentation/git-apply.txt, and Documentation/git-am.txt
>  	 * when you add new options.
>  	 */
>  	return error(_("unrecognized whitespace option '%s'"), option);
