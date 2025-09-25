Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399821A420
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767170; cv=none; b=O8PjHp1qZYlL3Jk64mK41/GZtjUL093Hq+qwXI/u4TcYpFKm0m1lqqFzLW4YhdN5GQgMYKH8+XEG+gMW2O3wUgCGNT2HzOVzosnHgD5J4uNu3M+OGui9Yay7us2rp34cQi6CgCZAKIEYKkuzRZbgZCDrzERpFIsN+XIDdmd4BhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767170; c=relaxed/simple;
	bh=CFUk/ip7BLyTNiYpqttofXieZPcbVwUWhmTHp8P45H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsUjS41ZMDFf+JxeZthS9oOSvQyPP4UU4rGy0eHcaCXsL71l6CDAezwRHv/j14kOglW80OR+/BYMlY/FJRTQm2HmDZ2+xRTR4ytnCGUSB+uJ1BHN5fmwHb11z0f5WXiQVoFSLH8pH+J5p/OyRUGVPZa2oI/ZwTWvV30Dfj7FeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WclHWXYF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WclHWXYF"
Received: (qmail 21981 invoked by uid 109); 25 Sep 2025 02:25:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CFUk/ip7BLyTNiYpqttofXieZPcbVwUWhmTHp8P45H8=; b=WclHWXYFi3E+PEs9XduQcWijxF0A1nONhOk6uxVKZ4/VlkYPlg3Gz4OCseafmP4IXNWIMOpxKsJhzi7BEDNTkwpuqHJgsY/LHuL4KrnC5tLAA/y3rLS2PwgErtn6ROKq51o+2YGpag9gkFpy0R69dACl1cC/x1C7MctRF0qUeXuLSnvKKie3SG33QNnDBN7G3UenmtORImh5Iw2TMgY/VQa7R3r+2mXNa9cHvUwytplz+KaE1BzOPRJYIrXzyqNeqjC3U8erT3puJmjU8VPifD74BS9ZJ1tVlRZHs0imJZCmXhJKIz/Pg/1qYncVZeBRKXC4ml6IspJ7fjAOOmh2FQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Sep 2025 02:25:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30737 invoked by uid 111); 25 Sep 2025 02:25:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Sep 2025 22:25:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Sep 2025 22:25:55 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
Message-ID: <20250925022555.GA3202669@coredump.intra.peff.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
 <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>

On Wed, Sep 24, 2025 at 02:48:26PM +0100, Phillip Wood wrote:

> Thanks for putting this so clearly, I agree with everything that you've
> written here. Another thing I'm concerned/confused about is how the
> exception for a single project works in practice. Does it mean that a third
> party that wants to re-use some code from GitOxide has to check if the code
> originally came from Git to determine which license it is under? Or does it
> mean that anyone who wants to use Git's code without the copyleft
> restrictions can do so if they launder it through GitOxide first? Neither of
> those seems like a great outcome.

If I understand the suggestion correctly, it's not to license it
specifically to GitOxide. It's to use a permissive license (like GPL
with linking exception) that would make it compatible with other
projects with similar licenses (like GitOxide).

-Peff
