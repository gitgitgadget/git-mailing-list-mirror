Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0BEEAE
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370220; cv=none; b=bvfJL9nojDN/+53667TK+pnxpCZkBkLkdM1l2uwx1+Fz80xtxa9o5Cnr7xeWM6SCOAIqBMiRfDaHp6M9jKt/URZsflDg80pLpImdwmFiRaU+eudtgLSZfE9eiKr+L2Dw7gwSxYOhlGn/3vufZ8iFirvj7o79i7T0uRf3hgkIWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370220; c=relaxed/simple;
	bh=y2OQs4Rkp8rOVd2vajuPFzGhV/cx+M+ypa6p7GT461w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+yXGqiZskElQ/SqhL2R1YVJZjg0kn+GyFm1jmWTZF3+yfk6ZOkzZ4k+c+q9it11Je5OHJR2pOGzrZXSu0qS6pkZpy9WfG9oklx7Fnw+FjSgE4J0O/aSdUkBQP24JBgQHxUH87U+9yxU2fXI+TPtr+zfzaYaVtare54vrjJV/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NVSoEjTt; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVSoEjTt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B025324D6C;
	Fri,  5 Apr 2024 22:23:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=y2OQs4Rkp8rOVd2vajuPFzGhV/cx+M+ypa6p7G
	T461w=; b=NVSoEjTtlj++wloHlPL9u9a4xAt1QdxI6r5+W0giEu+Bg7TdQDU/AO
	T1dXQIIDoQt3CPKr3zyEZRxYbi95ObS88fyHh7eg0Q0DYqlQbMhJqiXwTQEYcWNa
	9HANAOQgIY7THbQuwGRm/qBvrFD5XHwOVbWEDJskWKUhlyEEChHuc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A887924D6B;
	Fri,  5 Apr 2024 22:23:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DEFF24D6A;
	Fri,  5 Apr 2024 22:23:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 2/8] SubmittingPatches: make 'git contacts'
 grep-friendly
In-Reply-To: <82e5e05288ded6394e562408507e3269c26e688a.1712366536.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Sat, 06 Apr 2024 01:22:10
	+0000")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<82e5e05288ded6394e562408507e3269c26e688a.1712366536.git.gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 19:23:33 -0700
Message-ID: <xmqq4jcfqlei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB8E0C64-F3BC-11EE-8F40-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Avoid splitting up the command over two lines. This way, a command like
>
>     $ git grep git.contacts Documentation
>
> will return a positive hit for this location.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/SubmittingPatches | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e734a3f0f17..a33fe7e11f6 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -494,8 +494,8 @@ mentioned below, but should instead be sent privately to the Git
>  Security mailing list{security-ml-ref}.
>  
>  Send your patch with "To:" set to the mailing list, with "cc:" listing
> -people who are involved in the area you are touching (the `git
> -contacts` command in `contrib/contacts/` can help to
> +people who are involved in the area you are touching (the `git contacts`
> +command in `contrib/contacts/` can help to
>  identify them), to solicit comments and reviews.  Also, when you made
>  trial merges of your topic to `next` and `seen`, you may have noticed
>  work by others conflicting with your changes.  There is a good possibility

Sure.  But I think a general rule to avoid writing documentation pages
that require a fix-up like this patch would be more valuable in the
longer term.

Or investing in a better "grep" command ;-)

In any case, this is an improvement, so let's queue it as-is.
