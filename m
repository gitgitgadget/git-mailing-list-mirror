Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5214B06E
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942380; cv=none; b=m71Rat4HUpWO9Qr0hazTuloXzaAGsBnLBgf3gf3OX9u6Fci09furygAGSoaIYbA2xPEq/2WeaRMicHOYcWAihIYFgMpMBiPRU8my6JPY6tbTXrfVS2LzhtfJfiIYDkKXNBD9CDZ1RgQyWE1hWugkIuiE1afeOrVlksi0k/6gI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942380; c=relaxed/simple;
	bh=4ZBKXQTI/2WYt0OHH7c5Eup/7h0TGf21dqde1FrXa+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtySAKNmEOtbFk/WUVXcqpvrM1UpsgYyIDFe6Qn1fC5kIT88SyPQ6fQVo1QGO790Rjdj3XYBA68hx1cxK7snrM7/K3ZV+bwt4uMZPgM0CpNRHFpLaRWcdVPsn2ORm1AGySB1StwGFKR6voNifxpq0j6BmGZbbnP24NVjGG0IIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gg8sn2US; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gg8sn2US"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1270A30698;
	Fri, 12 Apr 2024 13:19:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4ZBKXQTI/2WYt0OHH7c5Eup/7h0TGf21dqde1F
	rXa+o=; b=gg8sn2US36rbjihi1Ssb8RsOvWObbcLInZJvwUdQXlMhg7B0RcvILk
	jwo3rA3Zl0uD7zuCpVMKQ+kcf1wtA0DgwjXYX17TcCp3rIlM7Y932ffJRXFrMcXN
	eR9ZebnEj8Qfkl9ph4apUkPQt3GRNJcqn5p0sLjWy2YCYrpqTIuxY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A4C630697;
	Fri, 12 Apr 2024 13:19:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4373030696;
	Fri, 12 Apr 2024 13:19:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Kipras
 Melnikovas <kipras@kipras.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v4 8/8] SubmittingPatches: demonstrate using
 git-contacts with git-send-email
In-Reply-To: <84b1cf3f914067f8c2d056578e58d5b38bef7b45.1712878339.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Thu, 11 Apr 2024 23:32:19
	+0000")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<84b1cf3f914067f8c2d056578e58d5b38bef7b45.1712878339.git.gitgitgadget@gmail.com>
Date: Fri, 12 Apr 2024 10:19:31 -0700
Message-ID: <xmqqo7aemrbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4506B0E-F8F0-11EE-A79C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/SubmittingPatches | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index fd40a444f95..eac086133bc 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -420,6 +420,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
>  work by others conflicting with your changes.  There is a good possibility
>  that these people may know the area you are touching well.
>  
> +If you are using `send-email`, you can feed it the output of `git contacts` like
> +this:
> +
> +....
> +	git send-email --cc-cmd='git contacts' feature/*.patch
> +....

Doesn't this contradict with what we said in [2/8]?

>  :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
>  :git-ml: footnote:[The mailing list: git@vger.kernel.org]
