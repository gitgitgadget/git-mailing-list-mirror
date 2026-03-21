Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611925CC74
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774117975; cv=none; b=KWWi4zq8L+eqQ4tpsFN74O4nYncG4+kc2DfVdWYZq2w2wPnOZ/RUDZ+moaSE5yZpqAWpW04fZXNQ75LPAGubHlt7qtR/1kDE76/sZNAP2i5yz142MOyUroJwKYfoF59hVe5eSGzzkMfePgtgNWKFguOSPorlEMmfkYrQRmIikKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774117975; c=relaxed/simple;
	bh=+dY0eVvm/MqkC8pll17i4c/D+i8qKBKe1qOplrvQWOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ftwKX7ImJzc6oJVOx57j6eYlTuz3uzN5xvaQPzm0CRcyYsW1dB3C0OmUNI/ujk0cEA/gKD5IpiMvDbFfXhXQK6xAfpXIkCI4PDH3FTxgA4CblpYH9uhPTg5s1TJOBrRwTjUbGfXgdxvLeoUB7wfC6mFe4nFTCoCv2T9FJmirkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=USc6wmeA; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=P/i22b1g; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="USc6wmeA";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="P/i22b1g"
DKIM-Signature: a=rsa-sha256; b=USc6wmeAkUhCWELF4/lm89Kvl6Wk99tiYmZ8Um7GXVZ1X2ZnpwmqHy88CmoINd62H21rvzzjyNHvpe9MzPGpOUzrx49lyliqnu2gTB+U6dBA4gYt5lWEGWkz7Wt4duqloU/oPVkTk0pg/HroUjx1Zb7MYOGKVq4Wv216beYFKDZxstE+baKypWfDDU3O02PQIjYlL1S5A1Gso8kyUNOvu2qsq4uxT2BfavaDzAXAJyUx6GvdjaOnH8emTbf0suJmbV+olnLVOx68/KrVROgga4UPAJtFU+xk9y7Ec5imKI9njh1nnUL0B6h7ylaBUgxLNGOe0zNDdVKoosMbrElxRA==; s=purelymail3; d=malon.dev; v=1; bh=+dY0eVvm/MqkC8pll17i4c/D+i8qKBKe1qOplrvQWOU=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=P/i22b1gdRi+vcGAQGqfkDCCtKJuK0AQVrXZk9NuKO31LIBOI/Wiv+seECUeCIiDTswTBavVzNOVLQ7L9PAZplyNtdgMBjzya7l+RYIiTO7BqPc9MKGbh06Y5R2IDAdYtLZP75P4exTfQqZ11315AhauUQvXh0Jg5wOfjAXEPwCxbaFg/A5GXjBZfG9G86nK1n733Am51i/Vkio4z3WOyeCZnkmX8Q4/kpEm19kYOgFbJdhH0mAEgxAbwbiF03qJFeskWg4tX19AXR+4VCkokvDG7fRWudexLuAiLe4xigopNudGyao18fEi6Jz/JMa7FPDYpDVKLJG2sEkQ3qNlbw==; s=purelymail3; d=purelymail.com; v=1; bh=+dY0eVvm/MqkC8pll17i4c/D+i8qKBKe1qOplrvQWOU=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1017693761;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Mar 2026 18:32:50 +0000 (UTC)
Message-ID: <0b4dee1e-5a85-4863-9538-8c3bbf8e9aef@malon.dev>
Date: Sun, 22 Mar 2026 02:32:47 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t1900: cover linked worktrees and separate git dirs
Content-Language: en-US
To: Jialong Wang <jerrywang183@yahoo.com>, git@vger.kernel.org
References: <20260318203547.39972-1-jerrywang183.ref@yahoo.com>
 <20260318203547.39972-1-jerrywang183@yahoo.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260318203547.39972-1-jerrywang183@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jialong,

Thanks for the patch.

On 3/19/26 04:35, Jialong Wang wrote:
> Add repo-info coverage for repositories accessed through a linked\nworktree and through a worktree created with --separate-git-dir.\n\nThese layouts are already supported by the current implementation, but\nare not exercised by t1900-repo-info.sh yet. Cover both the lines and\nnul output formats for layout.bare and layout.shallow in these cases.
> 
> Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
> ---

I noticed that line breaks in the submitted data are escaped as \n 
characters. Even if you send the patch using a different tool, you 
should still check the mailing list to see how it looks, right? ;)

>   t/t1900-repo-info.sh | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index a9eb07abe8..f85ed232c2 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -69,6 +69,45 @@ test_repo_info 'object.format = sha1 is retrieved correctly' \
>   test_repo_info 'object.format = sha256 is retrieved correctly' \
>   	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
>   
> +test_expect_success 'setup linked worktree' '
> +	git init main &&
> +	git -C main worktree add ../linked
> +'
> +
> +test_expect_success 'linked worktree layout values are retrieved correctly in lines format' '
> +	cat >expect <<-\EOF &&
> +	layout.bare=false
> +	layout.shallow=false
> +	EOF
> +	git -C linked repo info layout.bare layout.shallow >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'linked worktree layout values are retrieved correctly in nul format' '
> +	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expect &&
> +	git -C linked repo info --format=nul layout.bare layout.shallow >actual &&
> +	test_cmp_bin expect actual
> +'
> +
> +test_expect_success 'setup repository created with --separate-git-dir' '
> +	git init --separate-git-dir=separate.git separate-worktree
> +'
> +
> +test_expect_success 'separate-git-dir layout values are retrieved correctly in lines format' '
> +	cat >expect <<-\EOF &&
> +	layout.bare=false
> +	layout.shallow=false
> +	EOF
> +	git -C separate-worktree repo info layout.bare layout.shallow >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'separate-git-dir layout values are retrieved correctly in nul format' '
> +	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expect &&
> +	git -C separate-worktree repo info --format=nul layout.bare layout.shallow >actual &&
> +	test_cmp_bin expect actual
> +'
> +
>   test_expect_success 'values returned in order requested' '
>   	cat >expect <<-\EOF &&
>   	layout.bare=false

The patch itself looks fine. The 'git repo info' command seems to be a 
relatively new one, so I think adding a test script is necessary...

...except one thing to mention:

 > +test_expect_success 'setup linked worktree' '
 > +	git init main &&
 > +	git -C main worktree add ../linked

Since the main repo here is an empty, can a linked worktree be created? 
Here, HEAD does not point to a valid object, and there is no commit 
available checkout. I think it would be better to create a commit using 
test_commit first.

Regards,

Yuchen


