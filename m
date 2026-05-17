Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67E1B808
	for <git@vger.kernel.org>; Sun, 17 May 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034735; cv=none; b=pl9jBhGfiDpGdvA4FP/XoNaruQiZmzbkOe7OXjkqRdivC/B4bOms3uPvxsrVEGfvvgELpvd4xknaGRXydGjQKJ0zkDK5FX3cPkcqZrvQr3GnX67dBtWRaMcsNCHAI17XRseDg80nvAB/6lUwf5s/tCwh48+XGA0HhUE+72hOtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034735; c=relaxed/simple;
	bh=+FmNIWRp+mYGk+4VOelNwrj1t5jR9n1wdhrxeCpIfOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFgtAsyWZVNZdtL8sKb+tI5w0jMoOrJ63UwEuGI+jC2G+LEb+1QZs0t331SqPriYMzViMMlwC5yaPkzORUPQvsqDs04kcMMZRbzC2Uat5f9sg49UoN0mCoOYxIMjmVDLQDeFQ25aLsTr+93giJZvFb2EOWgZOTZRZwmbxdAn8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=SaRidyw0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ZBZS2QjG; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="SaRidyw0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ZBZS2QjG"
DKIM-Signature: a=rsa-sha256; b=SaRidyw0ICa/zMmI6gerJuVs0qByS+78KIH/f9Rz2BnpN/jiFtcITZ7iq0DoWUPZmLZfLzbidkKE7D4cFTH+/LvN4GQmkqcwnJMxYwXz6L8rHu+GDtCRLXh8Y3z+4g4U5Px3ptp1ucTb4XC9DJiih6c4rKaTeCQNuXBEVZR0LzVDhqyfgj4pE2bG/wEmoOclL2NdHQV2hMm8T/rFvT+2QOaGKBOu3jp0PNGBYAVBSGcl0BBN4hFDVEarjiSn507cTifsAmMiKhn72wSY5TFi5agigmwzO+cHrctGnO9GbWl0cUPLCgJ2i6fWhMvNkKb/k/xpKjE0rtwIvd7IerO2aQ==; s=purelymail2; d=malon.dev; v=1; bh=+FmNIWRp+mYGk+4VOelNwrj1t5jR9n1wdhrxeCpIfOA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=ZBZS2QjGKSqeEg+3m1tJPvOQ8Q8C3+3v3wLMKwrWSKSw3T3QHdvW86yxPXQCPM5kMyrvi5Vtt9OH2LfyNkwLoNvrSS6zV1QXsFQvGN6eM2DadxO/of0duRiPsjEk8RZ/vlxVCJlL/MGPsPNxWmwaWuiLj7VjFldjk+lyaTtamhGxMGDxz76TURQEgu8yz5uA3YQjynQoVI/c7p2Evws6H5Yf2rxx5KFdJtlumnzhqjlOQh+29Hzx+fqo29zJ1jIsAjr+Dl13Wt+qvxRPXyoNLpXo3GNVYFwj1XUu588LAZ5f5GpHUW/UrHzsWovF1e3bA17qJP+ob+5aq6zxNKgToA==; s=purelymail2; d=purelymail.com; v=1; bh=+FmNIWRp+mYGk+4VOelNwrj1t5jR9n1wdhrxeCpIfOA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1610472988;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 17 May 2026 16:18:44 +0000 (UTC)
Message-ID: <4d9604e2-036b-485e-aa93-53c35d539bed@malon.dev>
Date: Mon, 18 May 2026 00:18:36 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
 <20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/26 16:22, Patrick Steinhardt wrote:

I've noticed something that does not entirely convince me:

> @@ -477,11 +476,13 @@ int is_inside_git_dir(void)
>  	return inside_git_dir;
>  }
>  
> -int is_inside_work_tree(void)
> +int is_inside_work_tree(struct repository *repo)
>  {
> -	if (inside_work_tree < 0)
> -		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
> -	return inside_work_tree;
> +	static struct strbuf buf = STRBUF_INIT;
> +	const char *worktree = repo_get_work_tree(repo);
> +	if (!worktree)
> +		return 0;
> +	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
>  }
> 

Is it correct to statically allocate memory for the cache here? Could 
this lead
to memory overwriting issues in a multi-threaded environment?

p.s. I'm not sure if this one is better:

> 
> int is_inside_work_tree(struct repository *repo)
> {
> 	struct strbuf buf = STRBUF_INIT;
> 	const char *worktree = repo_get_work_tree(repo);
> 	int ret;
> 
> 	if (!worktree)
> 		return 0;
> 
> 	ret = is_inside_dir(strbuf_realpath(&buf, worktree, 1));
> 	strbuf_release(&buf);
> 	return ret;
> }

Thanks! yuchen


