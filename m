Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E6487A7
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346450; cv=none; b=PcgZGysg94dJxddW1fHGHvTzektEyfV7mjXSzis2l/kFvq98tt2KgnyQvgQmBZK9h41FmBQa6cEun6SrF24LYfJWAIHZgqAZ1T17JBSHAKiVod7YWk/+7v/hmaPtFkfuNqON/rXe5XzeWnwAiEuP8T+TjlIWellEqcS1mECyZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346450; c=relaxed/simple;
	bh=GC69dfqUBpib9GwUhJ+R8UCx3ppHe3MnkzuiOnly+0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IV9zdzSHHDKo6WAgn1kRaLnNhaUJlLnHWGWkxznsKspn+Cw5gEpzqHC6KyzTir1Y0VnfNPoa/YMdzmgpxDBd/5cob2qS0We0CSLN1pAhrPFIfyo2P4FT8H2PkVoa5BDVvPhMvcFPwrquvMwRnqVhZdJ+XR5iLdVJizbFxVseL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iQvrmuwA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iQvrmuwA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB06F1D38B7;
	Wed, 13 Mar 2024 12:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GC69dfqUBpib9GwUhJ+R8UCx3ppHe3MnkzuiOn
	ly+0s=; b=iQvrmuwAJUaQfm1fa2tuznPEGVX5CQ86h8e4HV9MPlBjmjILay5Tnn
	3rydjuXBI6tvpYU3iwzXDH8FYJQbkmkZgL0capr4UhZAUZlJgKYsQ5RqKsRgOYlJ
	jF8Df3EFz9S47PvWpbxwK4WyQHhVYZXpDqoNQXJZH4RJre6M/pMC4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D34941D38B6;
	Wed, 13 Mar 2024 12:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C69E1D38B5;
	Wed, 13 Mar 2024 12:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jonas Wunderlich via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jonas Wunderlich <git@03j.de>
Subject: Re: [PATCH] documentation: camel case of config option, and "no"
 instead of "false"
In-Reply-To: <pull.1686.git.git.1710279251901.gitgitgadget@gmail.com> (Jonas
	Wunderlich via GitGitGadget's message of "Tue, 12 Mar 2024 21:34:11
	+0000")
References: <pull.1686.git.git.1710279251901.gitgitgadget@gmail.com>
Date: Wed, 13 Mar 2024 09:14:05 -0700
Message-ID: <xmqqcyryds8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B7BEDB96-E154-11EE-B858-25B3960A682E-77302942!pb-smtp2.pobox.com

"Jonas Wunderlich via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jonas Wunderlich <git@03j.de>
>
> The `status.showUntrackedFiles` config option only accepts the values "no",
> "normal" or "all", but not as this part of the man page suggested "false".
>
> Signed-off-by: Jonas Wunderlich <git@03j.de>
> ---
>     documentation: camel case of config option, and "no" instead of "false"

The title does not say what variable was broken, and might be better
to pick one that does so, perhaps

	documentation: status.showUntrackedFiles does not take 'false'

or something.  

The name of the configuration variable does make it sound that it is
a Boolean ("do you want me to show untracked files?") and the code
may want to be updated to do accept any string that we recognise as
a Boolean and take 'false' as "no", take 'true' as "normal", and
treat all other input with the current logic.  But documenting the
long-established behaviour correctly is the right thing to do no
matter what we will do next.

Thanks.  Will apply.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1686%2Fjonas-w%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1686/jonas-w/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/1686
>
>  Documentation/git-status.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 4dbb88373bc..b0f36fabfb3 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -472,7 +472,7 @@ again, because your configuration may already be caching `git status`
>  results, so it could be faster on subsequent runs.
>  
>  * The `--untracked-files=no` flag or the
> -	`status.showUntrackedfiles=false` config (see above for both):
> +	`status.showUntrackedFiles=no` config (see above for both):
>  	indicate that `git status` should not report untracked
>  	files. This is the fastest option. `git status` will not list
>  	the untracked files, so you need to be careful to remember if
>
> base-commit: 945115026aa63df4ab849ab14a04da31623abece
