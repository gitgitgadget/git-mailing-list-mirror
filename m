Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599311D9A6F
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938659; cv=none; b=uzh84z51uOnBphLgkNrNulFjiWsbUp2+kZl2hx6eMVkrCmW+ggZYATXG2HgJwanCJLirzpDPayaKAXsBsokSVF08L2/EoQrLEiGi6wqbmZqx5xR5278Cy6xf1Z9UunXDkaulLUMaZcSfzBB4TlbazSPAyxDry5PN0vw5Oqqe3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938659; c=relaxed/simple;
	bh=9ZIUKhd2boKBYEa3U2NUmVbWQ8BGIaGzr2ItJdFfy0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUibi6zvHpwwHjT/IULNr3YAyKeWRsY4CfDvqTfrEH37G8dxKnLnPiis720zrNCde2LMDel5jnWwjMlgvi1JSQWXnWHh/U7jCdp/U+fJSEzPeUk53AwV8xgGB++Hcu0SAOQFNA8JcIGUOdXGjlDtlxh6l1hvrakV9UofmiOD7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YF2HKP0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YF2HKP0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C0DC4CED2;
	Wed, 11 Dec 2024 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733938658;
	bh=9ZIUKhd2boKBYEa3U2NUmVbWQ8BGIaGzr2ItJdFfy0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF2HKP0WHNcWdeNxsMu6D0wkn+DJjXrhCgAO7GKgw9nSrINhdDoaCE8mRVF3AgbSz
	 QliXfIgd1YlYnspjPRa0wa6RGLb5GEKaSifMHqtyFSoOljSSghfrdXwnTpQFadjHxS
	 mObFSzxOpcj9sNuWgaiwwoBI+4ambfjl2a6P28xw=
Date: Wed, 11 Dec 2024 12:37:35 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: branch description as a note?
Message-ID: <sem23vxg5c3xc62wvy5qn6gvoh6hc6m75mx35zgwsdyw36oexm@ayfez6uqghtt>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <xmqq4j3ai4it.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j3ai4it.fsf@gitster.g>

On Thu, Dec 12, 2024 at 01:11:06AM +0900, Junio C Hamano wrote:
> > Now my problem with the description being a local configuration, is that
> > I often work on patches on two different computers. I can easily share my patch
> > notes with myself, but not the branch description. If these could be pushed and
> > fetched like a note, I think that would open up some other nice possibilities
> > as well, like having a standard place for MR/PR messages for forges, sharing
> > proposed merge commit messages, maybe other things.
> 
> If this is about draft work, I would use an empty commit at the tip
> of the branch.

I think this was discussed a while back:
https://lore.kernel.org/git/xmqqilnr1hff.fsf@gitster.g/

I think it boiled down to having a merge commit at the tip that would indicate
the base-commit of the WIP range. I still think it's an awesome idea if
something like this was natively supported by git tools.

-K
