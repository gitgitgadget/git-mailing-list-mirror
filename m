Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9217B50E
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458921; cv=none; b=oEFHwWhISEe0n0kGvVNiK5g0Q/skLCT96XsNoCejpV7PU3P0NtqlNWpG0XxJUt4LnoNdfRLOUYTFKY2n3O3XwrUyAwt8ybebVpj1MhS3//aC44jp9LjCXrSiupictdQ43CYako9sV6bocYxE+3g4DTQ6zbAWifNUvcFCnEuKev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458921; c=relaxed/simple;
	bh=POOqmQQtIgNvlmjGH9lJa/0WdvGEjwl25xu4XZRMa3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q57izynDmiafjYRMr40HXuFl6XRQEyxXPlVfN8L1HZocqf10JhvOOFsHMQjqt40VMuFawte4G3zJBkjTamDKrBTUR7Wa2OS6LCpHXvG2adLJZQDGTTftREm6dQs1cefYOqQmTLUGFHoVY7XsgsS9Tr27Q7qCiR+tdFlhrByvm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e8hkUu9+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZGLD7HN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e8hkUu9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZGLD7HN"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CDCED138064E;
	Wed,  9 Oct 2024 03:28:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Oct 2024 03:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728458918; x=1728545318; bh=YtFcGI1rQ7
	frhQBD3OZUKZIEJ1ta3RxN8xIeG+ff38E=; b=e8hkUu9+tnKz/yYV5G6ubRvjN4
	VTEuFDEeEBVNOJnrTGdpFY3IskjEHL8GGal08kW3/X2xxI33VULBw8t0nWie/s5L
	LtLzXls81+ZVw3aK9nGlnBWDJJIU1/VLwPnJm6CmI9HUoqVUDhizJ+FWBaKL+gNR
	c26jsb4cARWLpJpsSqnmGrgv8Q0wF37C0UwDgPgF+WRdA0fz+DlGI7kcfiXTRdsi
	P+NrxYcnCC8HlG41ooBHOI5lGa5GYY1EWl9s1zHJCywpCaI28S/svG0/Zk/2CmA0
	9fM9NCnrm6DMX0FcPC2vEBfGj9NF22kFws8/NM1MFHTetsRTzDpYTQ2JnhTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728458918; x=1728545318; bh=YtFcGI1rQ7frhQBD3OZUKZIEJ1ta
	3RxN8xIeG+ff38E=; b=QZGLD7HNaCypSo9xKJtu+PtwfPljWcseU6Wxz7ER6Oio
	4jVmRd58jlxdl452SCp4Y0dOqJmB2CTToyQEVdKtI7ASQUmSB5I0/TQjl0pGgLDL
	9v4mTBTNacVMNuHQ67+Cd0T10YcXy9kS5DyCq5oW6eWSkX2PgwM0oCeavGUepJ28
	aQRCqOb2FCP+n1W0wgmqkcIDOWLwTwFuwGmpDvTL2u3pA0lgJmCSfXLgAKcdQFfw
	/DZdGDtHVsAzG0Qv6wdxz6ldvrIJc5NkXYIzxqBMbtkQBw/IpH9yXAuQ5C/315qy
	8GqTXjxX7DKvTPxDFrnFt5cQNMLfVMjKHyaav8TwIA==
X-ME-Sender: <xms:pjAGZ0eS-CFvsxfn8wcY-P_It_KPvbneXQJQ1oOBrcc5ggnHp6TFXw>
    <xme:pjAGZ2MurH3Z08U6uyrVkotTCbBIM-CKEYXNph-l6N43DSUvT7FrNKCVUK8GPkBKS
    g9Yrz-wXhhcUO6Dpw>
X-ME-Received: <xmr:pjAGZ1gKocjr-L-WPJYlfgfd1htNNn-0xrIQq9rdF79-J7zxOeyNcCmgYS_U5CT9-4Pdd7Nw4CpEEuo9Ep6Sfvcv-SpYogTFdnvqjLrFT8InpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheptghhihiioh
    gsrghjrghmvghsvddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pjAGZ5_j3zm9nL0xBbrFfsWipiEpqUoU5j2YKO7W_YrCfcVo89XDUA>
    <xmx:pjAGZwuJrL8fKAIwLzjOx99e4zL7Dy6A-jhrUfdPTgYmb7CbvFyvNg>
    <xmx:pjAGZwHYoACPlAJ6MZEFjR0mgOypfE1bPE6N03nXEcmq_gDi3qg-Cw>
    <xmx:pjAGZ_NvFjgjN2E-HyjXCn9VCfR9SECpZX5syd-VuRJ_dAAgLod50w>
    <xmx:pjAGZ8Lcsbe0mK4RUKn3P7fZs1Y0XjklBhWuvIXr1-YtJXhwEEG43m8y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 03:28:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 021e1459 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 07:27:33 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:28:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH] t6050: avoid pipes in git related commands
Message-ID: <ZwYwm2-ixmyYVqo8@pks.im>
References: <20241008162117.6452-1-chizobajames21@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008162117.6452-1-chizobajames21@gmail.com>

On Tue, Oct 08, 2024 at 05:21:17PM +0100, chizobajames21@gmail.com wrote:
> From: Chizoba ODINAKA <chizobajames21@gmail.com>
> 
> In pipes, the exit code of a chain of commands is determined by
> the downstream command. For more accurate info on exit code tests,
> write output of upstreams into a file.

Nit: it isn't really about accuracy, but rather about losing the return
code entirely. I'd also mention as part of your observation that t6050
still contains this pattern, which isn't currently obvious from just
reading the commit message standalone.

I'd also propose the following subject: "t6050: avoid pipes with
downstream Git commands", which reflects the fact that Git commands can
be at the end of the pipe without much of an issue.

> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> ---
>  t/t6050-replace.sh | 86 +++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index d7702fc756..6b9811ed67 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -98,30 +98,30 @@ test_expect_success 'set up buggy branch' '
>  '
>  
>  test_expect_success 'replace the author' '
> -	git cat-file commit $HASH2 | grep "author A U Thor" &&
> -	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> -	git cat-file commit $R | grep "author O Thor" &&
> +	git cat-file commit $HASH2 >actual && grep "author A U Thor" actual &&
> +	R=$(git cat-file commit $HASH2 >actual && sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> +	git cat-file commit $R >actual && grep "author O Thor" actual &&
> 
>  	git update-ref refs/replace/$HASH2 $R &&
> -	git show HEAD~5 | grep "O Thor" &&
> -	git show $HASH2 | grep "O Thor"
> +	git show HEAD~5 >actual && grep "O Thor" actual &&
> +	git show $HASH2 >actual && grep "O Thor" actual
>  '

We don't typically chain multiple commands on the same line, as it
becomes hard to read very fast. So these should all be split across
multiple lines. The same is true for other tests you have converted.

Furthermore, I'd recommend to replace "grep" with "test_grep", which is
a convenience wrapper that provides more context in case the grep might
have failed. It would for example output the contents of "actual", which
helps quite a lot in the context of failing CI jobs.

Thanks!

Patrick
