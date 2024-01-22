Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659153F8C0
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939784; cv=none; b=OCLxScR8qcUv711/mqWIP1JXmaLKGC1R4gZ6p7VK5iBX7Urtz76ge2YREIJgcoGqmNCRWVkTY0jeYEkUSp+Bc/QDnpRBLB/tDEw7FK6Y6P+QLUkRQ+zRpeRQ5cKJEPkVxfnlBD2Fz8LDUacjMEKObmo86BZ3/jsXxjmtWQilvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939784; c=relaxed/simple;
	bh=5BuzZrF+MreSIDm1BLfS5K8XIMbyHGyS+CU1ZX2Y9po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1DPgPafQYk2SIdT3YNk0EKw6mWhmmTshk+yglE8OvHv40pAE09lHS9MH5XeVM4+0Yuy7yPM5yw8fVj/r656tVZheI8pw3qr9Aj7FyByOUciyAJWEnelrg4ksGbrGTgn4PgKb7K7U30UhyWSL05zonNAb6dlG7cJSKwL2MTkOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PKPKHT7h; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PKPKHT7h"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E56081D0975;
	Mon, 22 Jan 2024 11:09:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5BuzZrF+MreSIDm1BLfS5K8XIMbyHGyS+CU1ZX
	2Y9po=; b=PKPKHT7hWWGB9+FRCfa1pqDtnvW8fflwb3CUgLMpTd5MOmvqVEWxks
	4e2EjYfy6Z7I7p4d7MnenZvz81nVVB5+kuOM5SAh5jgUjr5gYXlZBy6HRkQ2up2a
	QUIGaBHsjJ3TM+pdxwUOuRrAF/beibacBtm6cgGnho2BNXFjohecI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE3EF1D0974;
	Mon, 22 Jan 2024 11:09:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EC4C1D0973;
	Mon, 22 Jan 2024 11:09:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/4] completion: complete --patch-with-raw
In-Reply-To: <1debe2fe18eec7f431f355241117afb0a5e2bf5f.1705810072.git.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Sun, 21 Jan 2024
	04:07:49 +0000")
References: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
	<1debe2fe18eec7f431f355241117afb0a5e2bf5f.1705810072.git.gitgitgadget@gmail.com>
Date: Mon, 22 Jan 2024 08:09:34 -0800
Message-ID: <xmqqo7ddcptt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2ADB9AC-B940-11EE-857B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6108d523a11..ccb17f4ad7b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1807,7 +1807,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--output= --output-indicator-context=
>  			--output-indicator-new= --output-indicator-old=
>  			--ws-error-highlight=
> -			--pickaxe-all --pickaxe-regex
> +			--pickaxe-all --pickaxe-regex --patch-with-raw
>  "

Its ancient company, --patch-with-stat, is listed there, so it is
not all that wrong to include it as a suggestion, I guess.

But in the longer term, I think we would want to slim "git diff -h"
output by hiding them (no reason to touch code to remove the
support) from the "common diff options" part.  They were added as a
kludge before I realized we need more than these two combinations
and made the options --patch, --stat, and --raw cumulative.

Thanks.
