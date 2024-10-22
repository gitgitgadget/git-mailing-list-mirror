Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325438B
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729571552; cv=none; b=jz9kUQB+GKS3SSSmqv0aantg7JMoiMlRyI2ZURTITbYt3SjeEOPuHXhE+5Drgi0PUoL5LakLEmy8nm0QujFe0hAkdPXPxTXo9hvJZ8tHMATPp7oqchga/Fgt58Pgmf95/6dm1c1gMGm8qDo7KsSLMxZrvS8RhzU/brQlNkiw4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729571552; c=relaxed/simple;
	bh=M8rgOx9AGRm/I8bpp6Gtb64gdl1KKeSBYeo+seWf0Pg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5pfbZWYXMTTDzEVcuHIL10CzZBF+Q+tG0ZGhSskPmsX9mPaKFPmXIEYfDb6bUBbp1ogQi9u4OCSbmNzvAzwdRm1Xq1533ZaEcxE7rTuQLbFDY64y7PANZ5Azkk67UyTb5faOvvx7OyLJeD+fNgfxnB2Mxe3GpyuYs8INb4v2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Zlgsvtrp; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Zlgsvtrp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729571542; x=1729830742;
	bh=1+Pyl9NQtCxSziEzaz49EmQ0DwFo2GvbeBqTHxGBL6M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZlgsvtrpaLoJ2MkRfEL+vnvd13AkfOplF0bwgFNXBGgqIWNN4eZux/6+CLtfs/CNo
	 xCsRQ+X2HAWQHYgGPeiT1CpHnYZkoQ7W4Oubw6OM0tS9B90fih9bEKtcEf0ByXSFyb
	 maqeprhnIK2x2bqPxZk3vvvE8zaS0qXZUwD0DqSJ9X7Jwa26vi+9WRHtM6bbdM1CD0
	 Dit3AfezGMF+NPqh9vdXmI8kxrSfGWhpIsxFVWQ5/j3mFl7GfAbHCuLx5HqdAqni86
	 XExOodtmERwZzjg5BCcRfj+oarif60gJXxrS09u28T2SJOhEFmZFphvMIdtcc8UoFq
	 WPNOv5uQv2OXw==
Date: Tue, 22 Oct 2024 04:32:17 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
Message-ID: <D521XSJ9N80C.19U6V5T7LCRSB@pm.me>
In-Reply-To: <xmqqfrp4onjd.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> <xmqqmsjexkcg.fsf@gitster.g> <k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me> <xmqqy12xqehd.fsf@gitster.g> <oUBKv4JI3Bf1nqAFU_C-HDl5vkZC6mg8mb5F0HB7akXC6n0T1ddV0LiOCqY_AGHCyr9_W7gs2EyTGqIihz89ciBbL61UFwznnHcYRNzfGLI=@pm.me> <xmqqfrp4onjd.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: b8d8e4a9ceda1f683689abf8eb1108eddf4c85ef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Oct 9, 2024 at 6:37 PM CDT, Junio C Hamano wrote:
> If we are talking about making irreversible change to an existing
> repository, we may need to grab one extensions bit (cf.
> Documentation/technical/repository-version.txt and then refer also
> to Documentation/config/extensions.txt [*]) and flip it when we
> wrote a relative link to refer to an worktree and repository.

This has been implemented.

> [Footnote]
>
>  * The repository-version document claims that any extensions
>    invented must be registered there, but config/extensions.txt that
>    came later ignored it and seems to have acquired a few more than
>    the "master list".  We should clean up the mess.

I cleaned up the mess in a separate patch[1].


[1]: https://lore.kernel.org/git/20241021-cleanup-extension-docs-v1-1-ab02c=
ece3132@pm.me

Best,

