Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3217B50E
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142019; cv=none; b=PtOK+zCUR6CYMLoS+1BItXEX+uQ6mgrqmTkWcLE3kfHJnaYGhUKQzJNKglS+df+8qRgfG4vEpHzmy23d8RmJtdeeyoXJ/gZnFSl+cC62xhGnl1gxBOfJhLOosHOONf8qngaUj28N+d9nc0h0Knu3NzxrsSZzMNJVp4+kq4q48ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142019; c=relaxed/simple;
	bh=XV4Ej+ZntCc9qa9OXUFcGL7heSeptLaprccGMF5vtLs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXslPSn8gRzmYjXrI/a4Fgb2MFNqp/EmLA638soE+UsdpO3j3u+/49g0kRg9IXB7ROK2UAOosRuZQPEh4BtBmTtezxKftS0l+ZvepIVetCuVhY7N8mNUKN/k2TuezsF8Wmqkwvg+OXCh/+bJtKyX/cYkbdzRjd1Jr9XdsHuix5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rceCoaPE; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rceCoaPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730142015; x=1730401215;
	bh=EGd6O+mh3w7LmGrIVoHv50522hPbr+2Qi4o2Azie20k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rceCoaPEQizkjh3A2sgo70Jtt2YEcntTIOHEs0XQ/VCePo2+yaLPsClB0iwf1d/UA
	 DgUCKiIq04H9f6N9970VPxtqnSgWbOXjQJyq9ARRMf83Io1M8E/5BBCyvMcgYHAckz
	 sanOzlGRIM12oTKiewguGDQBMW9LUZVgUkvwsJnB3djL5j+k37isOejik2f64e2omF
	 qYLxkHFHhZjK4hS0cXyTmzsPbjcmXATJ7yML6I9R83eMZQ8f0EQHGPxMTa1vKh7IFk
	 gwvIV5eH77ntGLP1E3fB5dDZZN9I5g3vFUr/vWGoZ15K1JzC07J3SVwn45xoIErDlk
	 JGDv9UtvIwDLQ==
Date: Mon, 28 Oct 2024 19:00:11 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/2] worktree: add `relativeWorktrees` extension
Message-ID: <D57O5LHGRN1M.WHYPYUEOUOFM@pm.me>
In-Reply-To: <Zx/FAoj2jcISsv0X@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me> <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me> <Zx7YxLPItxvFJK62@nand.local> <D571HWYAD4MM.28JAS7D0Y6OI3@pm.me> <Zx/FAoj2jcISsv0X@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 22419ff4445e4887097bc7861c39f7141d9d7767
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Oct 28, 2024 at 12:08 PM CDT, Taylor Blau wrote:
> OK, I think the mistake here is mine. I did not see
>
>   https://lore.kernel.org/git/xmqqfrp4onjd.fsf@gitster.g/
>
> when triaging the list after Junio went offline for vacation. Had I not
> lost that email, I would not have merged the earlier round without more
> discussion.
>
> That being said, it is still greatly appreciated when contributors can
> follow the WC reports when they have patches that are moving through the
> various integration branches. That way you can see my "Will merge to
> 'next'" comment and say "please hold, I am working on a new round that
> is substantially different / uncovers some backwards incompatibility /
> etc." and we can wait appropriately.
>
> Now we are in the rather unfortunate situation of having merged
> something to 'master' that (with the additional information that I
> missed earlier) it is not clear that I would have merged in its existing
> form at the time.
>
> But that's OK, and we can figure out a path forward here. I am just
> trying to say that this highlights the importance of following the WC
> reports regularly to catch cases where the maintainer missed some
> important piece of information.

My apologies, this was my first patch submission to Git and I was not
exactly the process by which topics progressed from `seen` to `next` to
`master`. I will be sure to follow the reports more closely in the future.

>> Adding the extension was the direction suggested by Junio in the
>> previous round. Git did not account for the possibility of the linking
>> files containing relative paths, so there's really no way to make this
>> change without breaking compatibility with older versions of Git. Git
>> had to be taught how to handle files that could contain either absolute
>> or relative paths.
>
> Yep, that makes sense. My preference here would be to make the new
> behavior opt *in*, rather than opt-out, so that:
>
>   - Users who do not experience problems with writing worktrees that
>     have absolute paths can continue to do so without any changes.
>
>   - Users who use worktrees *and* do not write relative paths can
>     upgrade between successive versions without requiring a new
>     repository extension that would break older Git versions.
>
>   - That we only add that extension to the repository's configuration if
>     and when the user has opted into the new behavior.
>
> Reading this new series, I *think* that is the behavior that you settled
> on, which seems quite reasonable to me. Can you confirm that I'm reading
> this all correctly? Assuming so, I think that we are in a reasonable
> position[^1] to review this series instead of having to back out the new
> behavior.

Yes this is correct. The new behavior is opt-in and the extension is
only added to the repository configuration if the user creates
a worktree with relative paths.

> Thanks for bearing with me here, I am quite embarrassed to have missed
> Junio's mail that I mentioned earlier, but I appreciate your patience
> while we sort this out together.

No worries! I appreciate your feedback and I'm glad we're able to
sort this out.

Best,
Caleb

