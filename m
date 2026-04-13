Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77E30BB9B
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097578; cv=none; b=ujnKBFhtUv94zbKdpqDh5h2IfbIPs9if0P4J4uyJGT6f+Q7DeGWhyEzKiCbeTQWEkxQDz5w5yILFq3NhwYzMescy5blXEO2UloYKJ3uSwR/dnGDU9XJVRaYnE7EgfbhHdz8HEpdqRql0t+/7a1w/EH6i9RLxIIT2fkhRpHSJcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097578; c=relaxed/simple;
	bh=nfQuedOrSbVg8PD4ynuR2zcHTaw1+bD7gq7dz/eC+Bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhACiBGIMYHnuKUs+zNBphBlg3yg7pML7BNCchZwrV/kzznOqygKVSULMZrO5bG+cWBdjc6dHzBcM/6cuVa8EyBlE1zn4ag24zSA0NwSjj/2sz45cWywGkjDLL+iYbuI8AOPvhj3rzWu1D5bfdI/PhCk3+ceeyaspW+N/KTjYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K2bsvSLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwjTFfYu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K2bsvSLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwjTFfYu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04B0F7A0267;
	Mon, 13 Apr 2026 12:26:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 12:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776097575; x=1776183975; bh=zRBM+Fqb0T
	a0u94gJ8FdAD7opCE/Pwvre0RqUdIycU0=; b=K2bsvSLkijTxG6viXHZ8BqOfa/
	NqdyhqVPVXEKJ+/NEhdHcxJnj1DmGe3Yj95KiyKcA+lJK35xwhn0P6v8PyF/j9WB
	+r0YJpX+LSzHRbM6vrGPnPIcwjY+1YNdnrKKXjTayFwwTSTvGarcRKvH8yoibU7S
	tgENhj4eMX1ufZ9AWU9tmIVqPtxZ2wS6ee4/tb23/pNb0+u73RgOt2ieH2RPrSXR
	XWIuvaTfFnC1VbftjJbJqMcnx6aIpptgEYeYMtpUp0yHxvL/msC/ho86f46nXjrg
	XRPmcDw78uTg52y+xAe/EiDbLoPORrzjQ5DxMTQc1v4q12jYrZgQvpVZ86aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776097575; x=1776183975; bh=zRBM+Fqb0Ta0u94gJ8FdAD7opCE/Pwvre0R
	qUdIycU0=; b=LwjTFfYuC5PblSt4wEQNXhB5eRxIkpfeFO03OtcTrpHXPLKfuQv
	3Oa2vm72nrGmvCzKd2DWLC+t7axJdya7JxE8+i/mQmoVRdcLcaTHuoRwVQw0TSXr
	zm8b4xKaF8mfdsGKNOt2cRnRTTRlbeCCw86GnRVebpHfdCq7CRRRcFvHfA7zqYWg
	YIlEsT827zKBivNd0Y5R6J0SKQzpXDfMVmiiN9T3dD76/d5bd4Ya/JIJyyZGaes0
	MSWj8oa5j3nykLO1b6sxlhoK+XXkWsdZPTKHCQZbmcpEBkUnzX3aVQvxoVfHooVu
	JdI5SHUKnLJ/iPYSJoq64NWa2+1vhVopmbg==
X-ME-Sender: <xms:JxndabjWy1tjDAGe8mD1r9kqRX8nmsfzGPTB1OKoHJfwSbcXyba-ww>
    <xme:JxndafezJWxo310Zx8rkxftoqfQCVrt1QiZ6BwM_abJAgBpv8u1GPQCI-M9ycFEZa
    sPxCiU304z22RzE5-XLb7LZ6eMDUmBz4l9vbOb2Dg7llqJi8bXTxg>
X-ME-Received: <xmr:JxndaYeS7zlr9P11gGYyMlnzU3dHZ1LgVeR03_vnz93iVnVhl61Nu-t7AOL2dlgdsPcPw9D249-aBv_AmsuRl-gYN_MlA46sww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:JxndaR8x5fd0IB_mFkN5swEOUxGrLUogN7-PbjKGmET_4t1CHAozyA>
    <xmx:Jxndack_rQvlMHpy3htHsqX7qi6yaA-VA_K-i-cR2xcC0qhRkJs5Sg>
    <xmx:Jxndab8_8MWhkuB8Zg63Nmt4myqF5ZolGvjwSntNavTArk7isG74HA>
    <xmx:JxndaSnId_RuOnUXLl609zWTY4eo8HKoxnvhNXhl332acjn9wNUXMQ>
    <xmx:JxndaXlp9ZYmwnew5iKzpuO7cI7oB235P3zZCuJjWCits8CIno7dJTai>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:26:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] t: prepare `test_match_signal ()` calls for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-1-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:22 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-1-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 09:26:13 -0700
Message-ID: <xmqqldeqkesa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have a couple of calls to `test_match_signal ()` where we execute a
> Git command and expect it to die with a specific signal. These calls
> will essentially execute the process in a subshell via `foo; echo $?`,
> but as we expect `foo` to fail this will cause the overall subshell to
> fail once we `set -e`.
>
> Fix this issue by using `foo || echo $?` instead.

Hmph, if the 'foo' command that is expected to fail succeeds by a
bug, we won't see 0 on the standard output anymore.  Comparing 13
with 0 or 13 with an empty string "" would fail either way, so that
may not give us a practical difference, but this somehow leaves a
foul small in my nose.

The technique used in <20260325062114.2067946-2-gitster@pobox.com>
would give us something ugly like

-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((st=0; large_git || st=$?; echo $st 1>&3) | :) 3>&1 ) &&

and it ensures that we give 0 when we succeed, but I am not sure if
this is worth doing.

Or perhaps

-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=${OUT:-0} &&

I dunno.

If "large_git" somehow writes into file descriptor #3, then OUT will
be contaminated with something other than $?, so the additional "if
empty substitute with 0" would not work without doing something like

-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git 3>/dev/null || echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=${OUT:-0} &&

I guess.  For that matter, if large_git spits out "13" to its file
descriptor #3, I do not know what would have happened ;-)

>  test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
> -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
>  	test_match_signal 13 "$OUT"
>  '
>  
>  test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
> -	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((trap "" PIPE && large_git || echo $? 1>&3) | :) 3>&1 ) &&
>  	test_match_signal 13 "$OUT"
>  '
>  
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 1f16e6b522..8e68a00dcb 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
>  
>  test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
>  	choke_git_rm_setup &&
> -	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" || echo $? 1>&3) | :) 3>&1 ) &&
>  	test_match_signal 13 "$OUT" &&
>  	test_path_is_missing .git/index.lock
>  '
