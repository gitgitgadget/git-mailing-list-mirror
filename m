Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA53624B7
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287650; cv=none; b=jjbqhl5MHsEaVUuQ7lB8nDUvpi7pTCUkd2+dwo/1YLXEdrsd9gLkuQ2azHa56I2NCrAD0psxcZ7zfFG49vgQ/mIq30vMke+JvYiluzDN6vaG+/69iyiWvUnWrtmPjyFsqWXnAFjXYqynmd5DU+VhmYUdtigviaD+hUmtLXuqdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287650; c=relaxed/simple;
	bh=JtMkHyRnfzrmW8J5LbfcPW1RyKZqRjSjtRhBymXjTNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEeVpR5sNiFVfbIrmDWg0KgwQWfOvSC34LryWP94WM1uDvVwceE4OP8WKT4Wl87srYOOngq5IjsSK5pDuK+OwNS8uF1H/qKclqUY8EWTscFMv8gUYjfzZqKpQhuNGUQX5mKqq/W+GzLdqdkHafZA77kGkBfIqtqYmGpnqEywUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=MHny42sN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=BwTat6RG; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="MHny42sN";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="BwTat6RG"
DKIM-Signature: a=rsa-sha256; b=MHny42sNRFW11I1LWyDjO1TKgAEm7M3CMA6WZ72LBJcn9JfVkYLSpvPnwBZyWA4tzDTVoTQMDsomTQx3TYJtrHDTKQSrXjALhwniN0ts71MVUBug6NYTGOzgaYZlsOiWqP6GHs9+T0pc/YBhZ8O8F1z2/3VmoSJxbO8tLiAgDaav5GMAnBNrFgQ54YWTY+h79Pv64Oev2UoMFlreZjJ2d4/Vt4iDuNLacE131+dnSN9wGQaaitgYk2BOBgnsxIv1ESifTfWjnH27qXvydCNfwe0AaNiaXF79rMmBYL9gMGLJS3QPbwJjFcoAjUkqqJvW0LWhypppIe8gANf3lFVnuw==; s=purelymail2; d=malon.dev; v=1; bh=JtMkHyRnfzrmW8J5LbfcPW1RyKZqRjSjtRhBymXjTNo=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=BwTat6RG3CAIMajyEySEOk4XI9EcCU7yYOjTOrxGyixgq4iQ74pjqGSxBEAZgt0/8LmVag0nshCeEpVjM6e7+k4F+QbjWaVkiSMVV0/ETopoHCDGCV/qtgxMOxSM19L+Lme1bHTLZFY5Aq3UpsCw/OTOQxwAgN1ux7rGM7dIEo67LwM2HI+0Wjt/lFiZZ4wJyecPbytYLsMTcCIeOY+y11d4GqiEJGWFXDheF4U8OjdewlhDps3/4rRbf6zWj5KwV4QPCjxruds3Ib1AKguin11evvo/BfgvnMNphCYE5ATIP6c0BrIkBGkNjmeTIwQup/TRZkzApf6hXtnlc7p40Q==; s=purelymail2; d=purelymail.com; v=1; bh=JtMkHyRnfzrmW8J5LbfcPW1RyKZqRjSjtRhBymXjTNo=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1530687445;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 09 Aug 2026 15:00:36 +0000 (UTC)
Message-ID: <2310939d-014f-483b-8ad3-241871b770d5@malon.dev>
Date: Sun, 9 Aug 2026 23:00:27 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] repository: move fetch_if_missing into struct
 repository
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260716072954.582235-1-cat@malon.dev>
 <20260807094132.806165-1-cat@malon.dev> <xmqqwlu1eubr.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqwlu1eubr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 01:03, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> The global variable 'fetch_if_missing' controls whether a missing
>> object check should prompt a lazy fetch from a promisor remote.
>> In order to continue the libification effort, move it into
>> 'struct repository' and initialize it to 1 by default to keep the
>> previous behavior.
>>
>> Note that in builtin/fsck.c and builtin/index-pack.c, when running
>> related commands with the '-h' parameter, the 'repo' pointer is not
>> passed in. To prevent null pointer dereferences, we defer
>> operations on the repo until after parameter parsing is complete.
>>
>> Additionally, update the partial clone documentation to reflect
>> that this is now a per-repository flag.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
> 
> Have you made a trial merge to 'seen' and 'next' to see how well
> this change plays with other topics in flight?
> 

> Also setup_git_env_internal() no longer exists in 'seen', if this
> topic wants to play well with cf1687a41c (setup: split up concerns
> of `setup_git_env_internal()`, 2026-07-07), you'd need to coordinate
> the other topics and their author(s) before relying on the presence
> of what they are removing.

Thanks for reminding. I did a trial merge and the dependency does exist. 
Since that topic is still in flight, I'd prefer to wait for it to settle 
before rerolling this patch. What do you think? ;-)

 >> diff --git a/setup.c b/setup.c
 >> index b4652651df..ce2a80ac31 100644
 >> --- a/setup.c
 >> +++ b/setup.c
 >> @@ -1064,7 +1064,7 @@ static void setup_git_env_internal(struct 
repository *repo,
 >>   		set_alternate_shallow_file(repo, shallow_file, 0);
 >>
 >>   	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
 >> -		fetch_if_missing = 0;
 >> +		the_repository->fetch_if_missing = 0;
 >>   }
 >
 > Pelease remind me the reason why we use the_repository here, even
 > though a few lines above we are already using the caller-supplied
 > repo.
 >

Interestingly, in Patrick's patch, setup_environment() doesn't have a 
'repo' passed in and is only called once by init_git(). So I think we'll 
have to use the_repository, though I never thought of this... Anyway, 
I'll pay more attention to it in the next reroll.


Regards, yuchen




