Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054415572C
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022734; cv=none; b=mF9eDZ+mdcn+wsC4A/nhzrqKuRzRFhUQbr7EB05Q2anrvuyMFhVqCmwLfLqcRflh7HNnlwl/suj0jwotZEWEk0p3wlJ4KKvSfW+jhrrKLdpCJjKoerI9B7yTUEIL/DixM65k0At2W9P26a0FuYmB5pnlkZFiJq0zIQmucpasj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022734; c=relaxed/simple;
	bh=2aXh+lrJ89cIfJpZrIXUsLlfZ32kR9VWN/KWCIg4CDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpL/FYZ7y4DBIdr75rthRu0mpXUlPGlBCK8l+//18V8WrUtCTZk6pTsYQppTvxMZKbZ8kKW7orWlSDsEsZEDTuCAEwyXAqnHTHc8th3lhowq0I7oaL010y5SRqlXgKcxkutE7XWsixDe5ntj7dioTFNE9eDKDnHSf9WsRRir5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=K9zJ6gtf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9zJ6gtf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AC1D32DE8F;
	Mon,  6 May 2024 15:12:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2aXh+lrJ89cI
	fJpZrIXUsLlfZ32kR9VWN/KWCIg4CDU=; b=K9zJ6gtffCe1KX9Ew16TulBeRH0F
	ohE9FF02mvPCBTt1najYDCGwq+J0BcaAzr/+fCkqFpnuNWnsv1je1oX1Kbj81a1+
	CBfYnqwUJ6AOTRqViTumfbN5hK71mzkU/FJIGtX8UvYZQ/ZHj7kIgA2lVM7nc4hf
	pVI01PCIKSZ6Wuw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A4E3B2DE8E;
	Mon,  6 May 2024 15:12:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 270EF2DE8D;
	Mon,  6 May 2024 15:12:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: Mention that refspecs are explained
 elsewhere
In-Reply-To: <20240506182317.13477-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Mon, 6 May 2024 20:23:17 +0200")
References: <20240506182317.13477-1-oystwa@gmail.com>
Date: Mon, 06 May 2024 12:12:07 -0700
Message-ID: <xmqqo79iycu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 890C17B6-0BDC-11EF-9276-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

=C3=98ystein Walle <oystwa@gmail.com> writes:

> The syntax for refspecs are explained in more detail in documention for
> git-fetch and git-push. Give a hint to the user too look there more for=
e
> information

Sounds sensible.  It is a bit unsatisfying that we cannot make the
glossary entry the single source of the authoritative truth, but the
refspec syntax needs to be slightly different between fetches and
pushes (hence Documention/git-push.txt does not include the same
Documentation/pull-fetch-param.txt like Documentation/git-fetch.txt
does), so this is probably the best we could do.

> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>  Documentation/glossary-content.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
> index d71b199955..1272809e13 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -576,7 +576,8 @@ The most notable example is `HEAD`.
>  [[def_refspec]]refspec::
>  	A "refspec" is used by <<def_fetch,fetch>> and
>  	<<def_push,push>> to describe the mapping between remote
> -	<<def_ref,ref>> and local ref.
> +	<<def_ref,ref>> and local ref. See linkgit:git-fetch[1] or
> +	linkgit:git-push[1] for details.

Will queue.  Thanks.
