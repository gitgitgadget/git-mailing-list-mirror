Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D253FC0B
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110994; cv=none; b=hqHXsDmn9PGyxpTFxocuqHb7B5+US6wG7bhR2reA8LW3dV8P01w6+adB+RnKrLawPG23pfcqYUi8Nl++wKIsR4YosJ++NzsD9BqXg7wbdVATzJp4GT9DxXkX8eyILnr30mgcMuLVBR8K0EDQii/FUZnyRBDL+3mP6GJJOdjYL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110994; c=relaxed/simple;
	bh=cw3myjdiPiq6iNLUTg0iR5s6By7BciAv/GM/ic0zUJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRTBO21YSz1+jpaog81PKFt4TB2v2SlVzunlG8G6gCw5hEuL+EyhuaUKPXkoRe6ChiaZ73GoY6scwUdgWdcgHWbPI6Zwf2Q99ysiOlQTSlrVNMwBAp/BExYrHFslD+f1SZILOWhJe+387HRuZzg9p1p3RwEH4l/uvwLLCtl0FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tsqd9T6+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tsqd9T6+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B8B72259F;
	Mon, 23 Sep 2024 13:03:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cw3myjdiPiq6
	iNLUTg0iR5s6By7BciAv/GM/ic0zUJU=; b=Tsqd9T6+ZdNaeD5KidcfjrTKhWqu
	I8gF9+OSfouH0kGCueZrBKxlwY7bV/Q/ccz0Zjf8MAQy1tgGuns73ozpiN+DXMmk
	RwExlvlwsJ+LdY2gRC7QZptXVyEjft/lEzfiTWjGGL6JS9QiH6A8STptijrtS1AD
	Jdcw+aWqC60Z/3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A6D52259E;
	Mon, 23 Sep 2024 13:03:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5431B2259D;
	Mon, 23 Sep 2024 13:03:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alexander Ziaee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alexander Ziaee <concussious.github@runbox.com>,
  Alexander Ziaee <ziaee@google.com>
Subject: Re: [PATCH] doc/git-format-patch: link git-apply
In-Reply-To: <pull.1785.git.git.1727010037470.gitgitgadget@gmail.com>
	(Alexander Ziaee via GitGitGadget's message of "Sun, 22 Sep 2024
	13:00:37 +0000")
References: <pull.1785.git.git.1727010037470.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 10:03:08 -0700
Message-ID: <xmqqtte62tgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B6308632-79CD-11EF-B59C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Alexander Ziaee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alexander Ziaee <ziaee@google.com>
>
> git formatted patches can be applied with git-apply(1),

Not necessarily.  They are meant to be consumed via "am", which
knows how to unwrap MIME, split the message into the log part and
the diff part, and create a commit out of the result, by calling
"mailinfo", "apply" and "comimt-tree" as the underlying mechanism.

Simple patches can often be consumed by "apply", but that is not
guaranteed.

To put it another way, if we link "apply" because format-patch
output can (sometimes) be consumed with the command in order to use
its the diff part, we would need to link "mailinfo" because the
format-patch output can (always) be consumed with the command in
order to extract the log message part and separate the diff part
out.  So I am modereately negative on this change, especially we
already refer readers to "am" (and "am" in turn refers to "apply").

Thanks.

> so link git-apply(1) in git-format-patch(1) =C2=A7 see also.
>
> Signed-off-by:	Alexander Ziaee <ziaee@google.com>
> ---
>     doc/git-format-patch: link git-apply
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
785%2Fconcussious%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1785=
/concussious/master-v1
> Pull-Request: https://github.com/git/git/pull/1785
>
>  Documentation/git-format-patch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> index 8708b315930..eeebc805d6c 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -790,7 +790,7 @@ merge commit.
> =20
>  SEE ALSO
>  --------
> -linkgit:git-am[1], linkgit:git-send-email[1]
> +linkgit:git-am[1], linkgit:git-apply[1], linkgit:git-send-email[1]
> =20
>  GIT
>  ---
>
> base-commit: 94b60adee30619a05296cf5ed6addb0e6d4e25dc
