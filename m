Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727223358D3
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678138; cv=none; b=CXWLkElH96cR4QDEYob//qBNBcydxJstigEB4xb/k3P/afTkvwSf92sT4nBRw3CiRZl+XiJVwPhngFgboJedujktW0ZViFw3jZ7VsjKYe045Up2uXBIWI1eqjcFBIRJdDe2lFseq9YcI6nTlBH27iYCP9wmAUFl7jnIVLfnIyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678138; c=relaxed/simple;
	bh=78u/ytrJW/qzjTWPGDtIv8O8Yn31Y0e9bpdrzag0KRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se4meCy2wzFYVrLEsaM5O/ZhPhK10dsMvo/Azl1BpbUSb3eKn1BsqcIL2SOcmOy8wSjIuOdSwEJWYd57h0ZXmSp/JsofXODtTfO7q67lj12dBaGq27aZiZgOAKMyGMvjrXfZ7NwMJnWxzfcomuWMik1Ky2VaEWIAAsFPtkTiHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dADEJTy4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dADEJTy4"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so7634228a12.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773678135; x=1774282935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kw5W651Da7adh5dDhrpvoKJIdEk27I9BGQa85zeqmAM=;
        b=dADEJTy40E2VT4NvDYsmvbF4tBCz15GauzNms1dh9O0UnRpo3WKccgpmOrvk+u5tgP
         UivJTAmhfIGW03KQDVoFYk6lkw8z+s9BprnRv3X0Ga7JFfaMrtFYBUvE1l+Aazjla9Y/
         ecPa6w84fBn+UI3FuYuZfanestgKyiF1AkT6MWsdYSoiQmjgHoAH8Rx7PI2laognmHMi
         UIDCynRVon1/x3ns+Z6JbSQASVcycmVYA2y7U3g5ZmDH1+dnEkqCTJWY1WI9iYJ1MJme
         7Pw4rWfXdGtRIWD/ENnJCrjyiWS6VQsTgrkyLO5DssXHaRlKGuknRKv18BezdZjKwxQB
         0s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678135; x=1774282935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw5W651Da7adh5dDhrpvoKJIdEk27I9BGQa85zeqmAM=;
        b=C7RLB0FFjJuRLwvZW0wUXIOEawWyvlrg7NHQg8vnegcGYAIbnJN2RNNxpxnXvZWrh1
         6h7Bk5u18AU2Oxzy0ZHqDd9sa5SNOpa/MPluTVLgSzF+Ry8GULRtuYMIStvrcrRjwxw7
         mv8olCkXbrSaVpGX4uUniRTN/dLK6Izpj8INA0cI+IXrthvGoAEQGftow8hDVQy1kRFh
         gYGx/EahG1JmDmr7QU3NllUHykAH22zORYlyXsrqeR7SC2qwhZq/sbS5A3ZPJc1mvREA
         xmlXTBIm2R/W4S9laQOUlQcvYax9ik7f1laVipHQ2m3Cfo0vaR26rxyIQNvr3pnZlgxi
         wiXQ==
X-Gm-Message-State: AOJu0YyR+yvLjOxnyZB2xyl6w/1nLzkFD1ZDZO+0Z2C/wQO9TkNl0Qs3
	A9jHu8JPkXMWlRdlMB3X85+z3uKLyd/kr3hOpfr30cez/Ybpr6k3Lr5fXiiPyA==
X-Gm-Gg: ATEYQzwj/TtJzIlz4Etl2Wi3/Bc3TKb5OS65/P8LSYsoQXxVfKVw3oMYGBQeoZiFB0I
	L/r28MZEJWuKEYzKRO1/BBnf2S1K+Lg2XMQbZOcH/7qCE0vsTIY+MVTWUKTxxak26SvPttp9IFv
	pBbHBnCf9KZ1UkkNDPzXJQpX2wkluXCOqJM2itNLD/MXIG5UPShXL6bHErgccpqoD87+Stm0KQR
	O59pPr8rb/+r99yAegosG9JTGvj6zLtWfz0EgQ478ieE4hO+fK9KNzcdXaAG9rG/uOrJeqMm3cK
	uwFo53exuJdEoXav0CVlqVYr4KbF5xQOVFDUc7KbNay0P3vfqXJicgXbI9kMF5RfD/Rj6B4OlVW
	1pMELMADWwbgVXxzZoTReAHd35UM20G7gifxDc3MCaImhiT5lz+kx0YaE3EfS+IJmCACK4LT73T
	sL/oGDLK6tYrP44XP2S1usq25z95rBrQypZ12ID71AtE8+AeGvtD5wzMmkVfpLifQJkMoy6KJT0
	/klYA==
X-Received: by 2002:a17:907:7288:b0:b97:a0e3:3d92 with SMTP id a640c23a62f3a-b97a0e34485mr442028666b.51.1773678134339;
        Mon, 16 Mar 2026 09:22:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97d201082esm53600666b.63.2026.03.16.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:22:13 -0700 (PDT)
Message-ID: <9e3b59d1-58f3-476c-9c7a-3ceffbb71810@gmail.com>
Date: Mon, 16 Mar 2026 16:22:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] worktree: remove "the_repository" from
 is_current_worktree()
To: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <cover.1773591528.git.phillip.wood@dunelm.org.uk>
 <075700a22568913988c9fa8e1ff49db1a1a5b606.1773591528.git.phillip.wood@dunelm.org.uk>
 <abezeNELL9SU8v82@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <abezeNELL9SU8v82@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/03/2026 07:38, Patrick Steinhardt wrote:
> On Sun, Mar 15, 2026 at 04:18:50PM +0000, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> is_current_worktree() compares the gitdir of the worktree to the gitdir
>> of "the_repository" and returns true when they match. To get the gitdir
>> of the worktree it calls get_workree_git_dir() which also depends on
>> "the_repository". This has the effect that even if "wt->path" matches
>> "wt->repo->worktree" is_current_worktree(wt) will return false when
>> "wt->repo" is not "the_repository" which is confusing.
>>
>> The use of "the_repository" in is_current_wortree() comes from
>> replacing get_git_dir() with repo_get_git_dir() in 246deeac951
>> (environment: make `get_git_dir()` accept a repository, 2024-09-12). In
>> get_worktree_git_dir() it comes from replacing git_common_path() with
>> repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
>> in favor of `repo_common_path()`, 2025-02-07). In both cases we have
>> a repository instance available so use that instead. This means
>> that a worktree "wt" is always considered current when "wt->path"
>> matches "wt->repo->worktree" and so the worktree returned by
>> get_worktree_from_repository() is always considered current.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   worktree.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/worktree.c b/worktree.c
>> index e9ff6e6ef2e..344ad0c031b 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -58,7 +58,7 @@ static void add_head_info(struct worktree *wt)
>>   
>>   static int is_current_worktree(struct worktree *wt)
>>   {
>> -	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
>> +	char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
>>   	char *wt_git_dir = get_worktree_git_dir(wt);
>>   	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
>>   	free(wt_git_dir);
> 
> Hm, okay.
> 
>> @@ -78,7 +78,7 @@ struct worktree *get_worktree_from_repository(struct repository *repo)
>>   	wt->is_bare = !repo->worktree;
>>   	if (fspathcmp(gitdir, commondir))
>>   		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
>> -	wt->is_current = is_current_worktree(wt);
>> +	wt->is_current = true;
>>   	add_head_info(wt);
>>   
>>   	free(gitdir);
> 
> I have been staring at this code for longer than I want to admit, and I
> still haven't convinced myself that this is not a change in behaviour.
> I think what I'm wondering about is what `is_current_worktree()` is
> actually intended to do. In other words, what _do_ we consider to be
> "current"?

There was some discussion about that in [1] where reviewers were 
surprised that we needed to call is_current_worktree() here. This change 
is consistent with the rest of the patch but you're right that it is a 
change in behavior as at the moment the "current" worktree is set by the 
worktree that the process was started in. In practice we only ever have 
a single struct repository instance per process so there is no practical 
change in behavior here. At the moment, if you visit a set of submodules 
from the superproject by forking one process per submodule each 
submodule worktree is considered "current", but if you visit them by 
spinning up some threads in the current process they are not considered 
"current". That seems to me to be inconsistent as the process started by 
the user is in the superproject in both cases.

The "is_current" field was added in [1] without any discussion in the 
commit message. It seems to have been added to stop the same branch 
being checked out in multiple worktrees [2].

Thanks

Phillip

[1] 750e8a60d69 (worktree.c: mark current worktree, 2016-04-22)
[2] 
https://lore.kernel.org/git/CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com/


> I would consider the worktree "current" that the Git process
> has been invoked in. So if I pass a repo other than `the_repository`, or
> if I pass a worktree that is not the one that Git has been started in,
> then I would expect the function to return `false`. With that naive
> assumption your change would be breaking the existing logic.
> 
> But I have no idea whether my assumption is correct or not, as
> there is not really any documentation of what the function or of the
> `struct worktree::is_current` field. And having a look at a couple of
> callers doesn't really make me all the wiser.
> 
> It would be great if you could shine some light on this and then also
> add a bit of documentation to either the function, the field, or both :)
> 
> Thanks!
> 
> Patrick
> 

