Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A63E3C4D
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780197; cv=none; b=gbZnwNw8kB0ywolwp9yTwYzwgtV5LPofxsDGzq6t930dER33AZQmY1o2efm4kTr5bSz7iGkZG/Rfh23pJWR7d9f2lUuiulRPBdCcg8mWnFERrNWqrr1mdEdwKPl0tMRibW2119GHkWtzOaew1ebBOG09jwjtItztMkXJOKZ/YMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780197; c=relaxed/simple;
	bh=GSYTYsu3TydslO1Mzq+kHPaonEVx1s3IDSraf4cwcWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVOBIT6vUENUKqu9qjepiIIRMcJRx270zt/JYks1jvwHXEycOonsrXZx3SpirwHntylVVgUDxw6CE6LgsG0yGTEwWBCII584m++u36L5rk9s66K5TjsnRrbn2KB8qZUiYYok4FFH0b99RZdT152fRuZxnwgGRRxEJujdw8e5Fp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=V3OZxrgf; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XrBUtdAU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="V3OZxrgf";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XrBUtdAU"
DKIM-Signature: a=rsa-sha256; b=V3OZxrgfTv+zCWbSeEwIXgcQgrQ0kiJzWWlWJEM8XVtWv2rafQa27x/yIUK80YrXg0H3es+rHHKcC4QZnLXqA+QefZ96Yt3MEZeZWZFN5ItXux4lJo2wGeHFTJkT0ZK1jyg7qNol9tI4NxAognrfAqOspbE+uFGoMRCUKG1nBQvZlTc3zARPQL79g4Glh/QxpoN491ARAJpLjlRheiJh0KMOQDC2wjfI7ROc2s1qUZwOPSE2rY+3QTyctTLDEIMMey8kNl0iFDVW/maO0jbj6RIyeaoX7zOVobkHbBeeY+GeRcBjAUBJkNih4Ubave7kT+YrgVMIuOqHZgvlOiKG4A==; s=purelymail1; d=malon.dev; v=1; bh=GSYTYsu3TydslO1Mzq+kHPaonEVx1s3IDSraf4cwcWs=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=XrBUtdAUt0lv7wfuAbINew32/PKKaK2cs5DrhkeN4ZGtcaCJMohn0BTtq06BAOv6yjoMVqxVY82bVeYIBoGz/hDHNGfI/ZmGQM/IaJ+Ot5QHm6Acf89bxQQcMouFktHLXrKgQ4VTEFZ53St1v50WxAqrkMGBSjYpu8W4Gxd4dh1REZk/pEQV6m3WzivukZZEDBxsy8iMDqk+yGElvzApIdMOclvYXTm5WVTl5Vemh/fybWS29tdaUZNifANr78W+EIomrIuWzfgKiIiAsR6uLTeDKsB4B8fiCjq5MqurkNzMpt4oXZMvMwkZlvjV+Q5F0hAdfc0KIM+vyhFIkpItPg==; s=purelymail1; d=purelymail.com; v=1; bh=GSYTYsu3TydslO1Mzq+kHPaonEVx1s3IDSraf4cwcWs=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1595915638;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 18 Jun 2026 10:56:31 +0000 (UTC)
Message-ID: <dcafaf9d-d422-46ae-96c3-26674ee70e3f@malon.dev>
Date: Thu, 18 Jun 2026 18:56:25 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] environment: move ignore_case into repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com,
 johannes.schindelin@gmx.de, stolee@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260617154929.564498-1-cat@malon.dev>
 <20260617154929.564498-2-cat@malon.dev> <xmqqh5n1w0i7.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqh5n1w0i7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/26 01:16, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Note that the newly introduced getter, 'repo_get_ignore_case()',
>> intentionally avoids checking 'repo->gitdir'. This could safely
>> accommodates early dynamic probing of the filesystem during
>> 'git init' or clone operations, where the 'gitdir' might not be fully
>> initialized but the filesystem capability must be recorded.
> 
> Why "could"?  It either "safely accommodates" or it doesn't.
> 

Okay, will change in the next reroll.

> I do not quite understand the logic behind this part.  Why is it OK
> to punt until .gitdir is ready for trust-executable-bit, like it is
> done in f951ed98 (environment: move trust_executable_bit into
> repo_config_values, 2026-06-13)
> 
> diff --git a/environment.c b/environment.c
> index fc3ed8bb1c..75069a884d 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -142,6 +141,13 @@ int is_bare_repository(void)
>   	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>   }
>   
> +int repo_trust_executable_bit(struct repository *repo)
> +{
> +	return repo->gitdir?
> +		repo_config_values(repo)->trust_executable_bit :
> +		1;
> +}
> +
> 
> or hfs/ntfs in 71386c21 (environment: move 'protect_hfs' and
> 'protect_ntfs' into 'repo_config_values', 2026-06-10)
> 
> diff --git a/environment.c b/environment.c
> index fc3ed8bb1c..683fe1b4d3 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -142,6 +140,20 @@ int is_bare_repository(void)
>   	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>   }
>   
> +int repo_protect_ntfs(struct repository *repo)
> +{
> +	return repo->gitdir ?
> +		repo_config_values(repo)->protect_ntfs :
> +		PROTECT_NTFS_DEFAULT;
> +}
> +
> +int repo_protect_hfs(struct repository *repo)
> +{
> +	return repo->gitdir ?
> +		repo_config_values(repo)->protect_hfs :
> +		PROTECT_HFS_DEFAULT;
> +}
> +
>   int have_git_dir(void)
>   {
>   	return startup_info->have_repository
> 
> but not for this bit?

You're right, I made a mistake.

Earlier, when I was testing using 'repo->gitdir', the CI tests failed, 
and I thought it was because the test script was forcing initial values 
too early. I just realized the error was somewhere else. I'll fix it.

> 
>> +int repo_get_ignore_case(struct repository *repo)
>> +{
>> +	if (repo)
>> +		return repo_config_values(repo)->ignore_case;
>> +	return 0;
>> +}
> 
> What makes ignore-case so special?  Doesn't the same logic apply to
> the other three bits?
> 
> Or use a more direct
> 
> 	if (repo && repo->initialized)
> 		...;
> 
> for all three, as repo_config_values(repo) barfs when repo is not
> initialized?
> 
> I dunno.

That makes some sense. The reasoning behind using 'repo->gitdir' is that 
"as long as I know where .git is, I assume the repository has been 
initialized," which may indeed be less precise than 'repo->initialized'.

Btw, I think it's better to change the getter's name from 
'repo_get_ignore_case()' to 'repo_ignore_case()'. This way, it will be 
consistent with the previous flags.

Thanks, yuchen
