Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019945234
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705486; cv=none; b=Jcrm6TvvR0lFkDvi8LWlZk8XAHaDQ5u5K1XS1SdjbGHod8OxrSV8ohYEXRyX7wkF4DMtK06uSvI4zf/RojKYiuwBNyu2MkPrmkxb2I+xNSkQg4UpiLFpfEWCx04iZHUSCNl2Y0Vn8Mrt+mciOymdm0roodI3FD69b9cz1TSbYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705486; c=relaxed/simple;
	bh=0Irg2Z3EkFxMwDaJDd8m/Y3s/jK0g4SmKrijg6yxCqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UG425zF3MlEJHidnVeYacRLbRxeb+CyEHVba577zatjBHAJs/6nvdciQmeEkzErN5TK1feElK5T9Z83r3ysEu4DUhsLR6kswFmkEVKHIRJW/16IhRP45XyxHwzq7RHBHFvezOKXfkgEyyTThn2dgGMi/dFkd+BuxyUKIFjK+w84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=njMshu9C; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njMshu9C"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF4FA11400C3;
	Sun,  8 Dec 2024 19:51:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 08 Dec 2024 19:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733705482; x=1733791882; bh=xY8vB5t9Jc/aQf/jhHPGNH7DDrrk+UgLPJB
	zfSNwPL8=; b=njMshu9Co6It+8B6LXUWRJhXiGM72gNy1LsV2wDAXGxh+9vVq5g
	h+SavhRi1pYgSACWTDBdpbxpR+tBkzbF1Aswkqj+f1UAkuG8v+QXOxQGb+zAW2PT
	IMvU4JE6sKsinYvxUApBoe02+4hnT514tq/11tkydTeBcS7VNKkTv+sU7S4n7ZyJ
	P7bZqbNJeaMd5PZsDMnK9ONWXAGRkdEUUY91rpn8viOHdrxHmwsnWE3BWLS5x1qA
	2zHyuM1ZxtWGmHxMxF9O966zJG7cCobDXEmCdV2wjv1di95QkD2t/cykQNjJtwJa
	IL9YkKXd71h/vjmZQTGieS1hr3n60Ga8JdA==
X-ME-Sender: <xms:Cj9WZwv5UYNsTt76JxBFBsnz_7lYT1BClrfGr2BUijezrb011rJqCw>
    <xme:Cj9WZ9cHwfeCabdajPr5uAKefFD_OA1dMKNBme7_suk5VVPmDQqAddJeXxcDjNGsy
    rL_DqO5k5LrqJHo3w>
X-ME-Received: <xmr:Cj9WZ7zYz40puzBny0iw5RYjYxRHQLjGAPPmWWDY3mLqPpnx9xFgaQAw881HqOsGPQ_2yGs7iKPD5WmOS4ISiSJs2zQVxlwYIhp4TRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheptggrlhhumhhlihhkvghsrghpphhlvghpihgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Cj9WZzOcazgc5_L32PDpbSZrmH97rjCxOWqc3IQWBX0Snbb4nU6jEQ>
    <xmx:Cj9WZw8Ybyl5eMUL4ExpnEeAN6CRg0nepu5xL4KKYwDE7IY4vy6GIw>
    <xmx:Cj9WZ7VUpSSmbkdV33gFPgztryiP3brAQ9MNd13M62fHQEs8fN3oPQ>
    <xmx:Cj9WZ5dA-aN-FvbSDxhHFMmHzh1KVBuBRd-ib8B9zmmkTF1uYaVbVw>
    <xmx:Cj9WZ_a7vfeuiaWZZ6hth5mVaxZdh7ToGSyV-PuyH7GJWpT2lLfvsVDq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 19:51:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Calum McConnell <calumlikesapplepie@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] verify-pack: Fix documentation of --stat-only to
 reflect behavior
In-Reply-To: <20241208204733.304109-2-calumlikesapplepie@gmail.com> (Calum
	McConnell's message of "Sun, 8 Dec 2024 15:47:17 -0500")
References: <1ee9f3ef2bffd148b6225138135462d2d4a5928d.camel@gmail.com>
	<20241208204733.304109-2-calumlikesapplepie@gmail.com>
Date: Mon, 09 Dec 2024 09:51:20 +0900
Message-ID: <xmqq7c89r853.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calum McConnell <calumlikesapplepie@gmail.com> writes:

> Ever since verify-pack was refactored to use `index-pack.c` in commit
> 3de89c9 (verify-pack: use index-pack --verify, 2011-06-06), the
> --stat-only option has been verifying the full pack, rather than just
> reading the index file, as it was originally documented to do.
>
> Allowing users to get details of packed objects rapidly without
> needing to hash all the objects in packfile is a useful ability.

Thanks for noticing.

> However, implementing that ability would require more changes to index-pack
> than the author is able to do at this time, and so a quick fix to simply
> update the documentation to reflect current behavior is done instead.

Wouldn't it etch the "wrong" behaviour even more strongly into
stone, making future fixes harder, though?

> This commit also re-orders the if-else block, to ensure that if both
> --stat-only and --verbose are specified, the verbose details are provided.
> This fixes another longstanding documentation bug with `verify-pack`.

This part is puzzling.  My understanding is that a documentation bug
would be fixed by adjusting the documentation to reality, so a
change to the code would not be involved.

Is this closer to what is happening?

 - There are two gotchas that the actual behaviour and the
   documentation do not match.

 - "--stat-only" being described as "quickly count without
   verifying" but doing a lot more than statistics gathering is one.
   This is "fixed" by updating the documentation to match the
   implemented behaviour.

 - "--verbose" is documented to be verbose even when given together
   with "--stat-only", but when "--stat-only" is given, it is
   ignored.  This is "fixed" by updating the behaviour to match the
   documentation.

But the thing is, the third point, the second "fix", to allow you to
treat "-v -s" or "-s -v" as if they were "-v" comes from the second
sentence in this paragraph:

        -s::
        --stat-only::
                Do not verify the pack contents; only show the histogram of delta
                chain length.  With `--verbose`, the list of objects is also shown.

But ...

>  -s::
>  --stat-only::
> -	Do not verify the pack contents; only show the histogram of delta
> -	chain length.  With `--verbose`, the list of objects is also shown.
> +	As --verbose, but only show the histogram of delta
> +	chain length.

... this change loses the "list of objects is also shown", which I
think is the justification for passing "--verify-stat" when both are
given.

So, I dunno.

> diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
> index 34e4ed7..5860a96 100644
> --- a/builtin/verify-pack.c
> +++ b/builtin/verify-pack.c
> @@ -20,10 +20,10 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
>  
>  	strvec_push(argv, "index-pack");
>  
> -	if (stat_only)
> -		strvec_push(argv, "--verify-stat-only");
> -	else if (verbose)
> +	if (verbose)
>  		strvec_push(argv, "--verify-stat");
> +	else if (stat_only)
> +		strvec_push(argv, "--verify-stat-only");
>  	else
>  		strvec_push(argv, "--verify");
