Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106B18CC1C
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492683; cv=none; b=N48d/dbsem2Js7GpRlZcWoZpZetEXovBYpFEzjVfz3bZUB0Ef++UhkwrrPhdNYsxuElR5Qqgi8Cowm9DWSe9Gy170GUV/0jGJsbtIMargbtXwUJ2uY2QlODn5h6LZNoepndo46PsSqSkZZdqdOs/52KvMpAGaNElDFqbGbWP8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492683; c=relaxed/simple;
	bh=hdK9HvMPVHzbSEKx5fyFMHZdf0aRlEiu2PyKWJzmqSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUpFKI6ZH02VDC6dGGmJCE1JW5yNsr2dA4S4pNFjYga9wzYSSkWWYfe9CvJKgeFnvTUD3rdVmbpYPvrr3iqj0gOLVc48cHf/WhwLimuDjmGKP36UT1n4JoA3Wv6vj3pNM/fi6cLQ8tLfFe+QU8lTp3sMMPuCkQNnmfca5EwyJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HuUXJqFB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HuUXJqFB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 13ECC114011C;
	Sun, 24 Nov 2024 18:58:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 24 Nov 2024 18:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732492679; x=1732579079; bh=/Z/CmqKkZTM/fgFZbPnxM/oGxXvigVU0lq8
	PJZRn2To=; b=HuUXJqFBF4ou32j7Vo8Xq5Mr+4movff4UyQA7k9c/C1DRLG8pmN
	YH7yCqvzujVX884GzvuGLGVLIDxw8EQkjwzrbAy6nqxA3aGIQM7COnvHnNR09bIL
	3i+fWlO/3QaJjSAQ5AP2gskF5PmfHIqiAM7WLXoyPwFeuk1SINrQ32cdYyySRfKS
	phRS2hJhaGX3H2mueLjOyAsT+pnDZ/fxBzdCD8LR3Uukcz6ULi4Rp3t9YR2RYSB6
	dpP4JxGpEHFbNTRCC0U10uLyc2RmPZ9I5U3p9lAkVcA5uWsWBzDRvCynMEAbcYgX
	kZ+LWlofwmbZPgIAeNkJzB6eCJ2d4fVOcBg==
X-ME-Sender: <xms:h71DZxQjbyBDn6Bm1lE6zc9svQSAJkS5xdeycmjkIcSQdZJ8uO3igQ>
    <xme:h71DZ6wDPJ9M1Aju1jJgbhzuHk16NxAUukEpZM_rpVe6FaX1r0MnU1p4YB7sY-8gQ
    YCT25tsewmuq5N-NA>
X-ME-Received: <xmr:h71DZ21wyjlprJWX-BPeiOMaR_VNpqWodY0dR6SHMGReq_73nFPTwZlFhiLvSHiEy2VIuAerKYwQoasIG30iSE_X5cjHa340XXpEFKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:h71DZ5A4k-u_Bq-zn6JYIVu7hWH-ZiGJdTSEFiaxb5vN6htnxFWWXw>
    <xmx:h71DZ6g5hNOPJLnlZ4E7V_kjR2I_eq-vUwFjND_-f8yv3jcTKvIwfg>
    <xmx:h71DZ9oY4DK-1IVqqE-A1FHjsOp54WJRWK0pEOweCDO2Pym6r2ZjKQ>
    <xmx:h71DZ1gCVGelc2tnioB-Sgh9czuWxhQVIlOdI8pZXc7aAS9ADlnKsA>
    <xmx:h71DZxoWduyrFL40kaMMvIVjBtksnZBeLjbTZFCN4KuVmWz75OPevczI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 18:57:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  peff@peff.net,  ps@pks.im,  me@ttaylorr.com,
  johncai86@gmail.com,  newren@gmail.com
Subject: Re: [PATCH 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
In-Reply-To: <cd3df4d5-efa0-45cb-ab94-6c5c9f0ac695@gmail.com> (Derrick
	Stolee's message of "Fri, 22 Nov 2024 10:27:19 -0500")
References: <20241121235014.2554033-1-jonathantanmy@google.com>
	<xmqqiksgas54.fsf@gitster.g>
	<cd3df4d5-efa0-45cb-ab94-6c5c9f0ac695@gmail.com>
Date: Mon, 25 Nov 2024 08:57:57 +0900
Message-ID: <xmqqed309oca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>>   (1) it hashes each path component separetely and rotates the whole
>>       thing only at a directory boundary.  I'd imagine that this
>>       would make a big difference for languages that force overly
>>       long filenames at each level.
>
> I was confused by the "rotates the whole thing only at a directory
> boundary" statement.

Yeah, I guess it was confusing.  What I meant was that the entire
result is shifted down with new material from left to right, but
unlike the original, the outer thing (i.e. what is given to the
caller as the result) is shifted only at the directory boundary, so
we are not as aggressive to lose early bits by shifting them down to
the right, as we are not shifting as fast as before.

> I think one way to say what you mean is
>
>   Each path component is hashed similarly to the standard name-hash,
>   and parent path component hashes are contributed via XOR after a
>   down-shift of 6 bits per level.

Yes.
