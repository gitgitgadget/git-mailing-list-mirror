Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [80.237.132.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B4175D5A
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300809; cv=none; b=kmwM78uO66XN3H0JIccH1M2jz9Xb5sN1z9zMRfJPpAMtdDoqMgavtkD+oKPn9m7BsZwpTldKEfu38fJHELSmVE0Oq7dp4Q1fitQDJH/Ga0VIytRFU6+/Ov6H4QHTtzQMddHw2ajBwHt1nxQwloNNk+6PHI1khVY/kUlXvqPcNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300809; c=relaxed/simple;
	bh=LqbMVQOexLNnSvMfSxlSbeVEz6ZU2R7yMOC4lEtk+Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f7LwcmOrPoDexFx4oAaVPN/3vreQg47UuCDV9ADiYsQ59aMouHtQvGjCXk+MCkL8ZcuGn8GnOFZylcGZuzQ3FC4o7qb9ByLxJKtHEAMaGLu/h6IUqgAHyiCU9fM25waspOROVA1HryEsPWctbg5CPs/FHec1803fDXbtvy8tb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b=kG5zzNn8; arc=none smtp.client-ip=80.237.132.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b="kG5zzNn8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuell-zuhause.de; s=he130322; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZYhNkAnwq7rwWMVGBbbAF0RND+Ig92xaTVrtNgp5ibw=; t=1727300807;
	x=1727732807; b=kG5zzNn8+XdWHviPM898t+1YQf7nXnMkf8HM/CjYbijdovZnCHMwOIYp0b6fR
	GfuKVbxzDlEH8bGugiY0fySe2vh7YedBERuJyRKBBv7LM7WFXTI0UWuH/A2iDpg/SfF5IqOJRQ1b5
	Ap0mhSr9KXOExnUAvvWHSpptSRJ9SKKxr4DTGQMCYfkiI8RvBiSRRwz6lMBDHcaYsWHbTPYbVfEpM
	arY5CB4Qj6GzczF063NCt3cDe7ZJTxL1/UoDYqq1HDAeWWQYKFsrG4d+DerdYx87sXnORyeS2PVVa
	GFty8n2F0cjNE2qPkhF6w4IsZ05zg+7sLoH8XA0sJ9Tr7reBMA==;
Received: from [2003:a:77f:9249:d148:21c7:a41f:ed14]; authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stZUh-0000ts-SR; Wed, 25 Sep 2024 23:24:19 +0200
Message-ID: <3192d8f4-4c7f-4b32-b564-7e075132c41c@virtuell-zuhause.de>
Date: Wed, 25 Sep 2024 23:24:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: report modified binary files as changes in
 builtin_diff()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Kohei Shibata <shiba200712@gmail.com>, git@vger.kernel.org
References: <CACpkL8WsNqhQ7SP27-XQwp1bzKjyUT6m2idFarZ2Z5rLVYg4pQ@mail.gmail.com>
 <500a8e0a-9fbd-4b7b-b2f2-026a4293bc9f@web.de>
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
In-Reply-To: <500a8e0a-9fbd-4b7b-b2f2-026a4293bc9f@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1727300807;35407143;
X-HE-SMSGID: 1stZUh-0000ts-SR

Am 21.09.2024 um 17:09 schrieb René Scharfe:

Hi René,

> diff --git a/diff.c b/diff.c
> index 3be927b073..84a6bb0868 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3675,6 +3675,7 @@ static void builtin_diff(const char *name_a,
>   			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
>   					 sb.buf, sb.len, 0);
>   			strbuf_release(&sb);
> +			o->found_changes = 1;
>   			goto free_ab_and_return;
>   		}
>   		if (fill_mmfile(o->repo, &mf1, one) < 0 ||

I poked at the same issue in parallel and had the same fix, but ...

> diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
> index d644310e22..1cea73ef5a 100755
> --- a/t/t4017-diff-retval.sh
> +++ b/t/t4017-diff-retval.sh
> @@ -145,6 +145,14 @@ test_expect_success 'option errors are not confused by --exit-code' '
> 
>   for option in --exit-code --quiet
>   do
> +	test_expect_success "git diff $option returns 1 for changed binary file" "
> +		test_when_finished 'rm -f .gitattributes' &&
> +		git reset --hard &&
> +		echo a binary >.gitattributes &&
> +		echo 2 >>a &&
> +		test_expect_code 1 git diff $option
> +	"
> +
>   	test_expect_success "git diff $option returns 1 for copied file" "
>   		git reset --hard &&
>   		cp a copy &&

your test is nicer.

The patch works here locally.

For what it's worth:

Reviewed-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>

Thomas

