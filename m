Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AA2F25F3
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047900; cv=pass; b=J74wJCtE8afFvdrC2qDgdkoZn+H6wyBtyRg2q7+f09upcfrQhK4bfYvT59FiOCLIXErqskEAq6tfNYDCle16pU7G0L2Bj6GLlbMysXE0A/95LLyWKLtHTqwYV5/RAFnByi2zxRRXaezTzhGY0GpHPVLGEeghfT43S8gWJjBXEJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047900; c=relaxed/simple;
	bh=qhV5VV8MXOLAktqFpvqGTjGjw3RVfY20/6iMxh7DMwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nju/e0LjwjC+qWArjPzzR8g6RSpklNTNUI65fevqRjHP0QKBog90Nv5XxsNNmD5sm+ozaX8CbXTMlwTUbXaaF1CkNt34LV9urYbep6TZ7MWfzxwbOenML+aX+hnVEosTbfZyA0ef+gsStKH4iNTFuDXo0vlCqAjVDvt28dYoW+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VKdWMvro; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VKdWMvro"
ARC-Seal: i=1; a=rsa-sha256; t=1761047883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZoxgeCZnBbFmXF7lql64vW/GhkxH6x/nWArpk7HZvqtb0mXiBKJx8gDfYjZXxraHQSqOshFholc2wpwl1GzGqBaxQ5fctI6+4e/3cDMRNzY8jxJBRITgzKg3TWiLULUoNOf5DyzSWvV0tBmy6yvV7F/aNBdyLpZIVmpnLytCTZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761047883; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g69YwjwNzDhoXanZqcx0HV/Fz38iNjTQITxJg8Hj5Vk=; 
	b=UIJbjZRmd4WjyC8X+zb6hvay3hUG9ggQvg/JM6xu/W8LStsMPQefdBRa+7ixWN1NH4AC7OtiNwRE1pLf4r2TyoXKQaDxHLpYL9/BuKkmm/6jrFkTYQuqQx6RwAOvfd2UQEJObUmPGW6iXRbsX88RKWIJLtgQ+jafOosTfDxk/UE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761047883;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=g69YwjwNzDhoXanZqcx0HV/Fz38iNjTQITxJg8Hj5Vk=;
	b=VKdWMvrocK0TDCDuCMMvIMf7IP14eKkq6N2zEaxlH7upTr3q2366exXkeNJQBrDB
	s6fyELWcAzfW5zr14b0UXVaiwze35JXGltn8MNshNn0HuCRFmJH2OudcuDsgqmXBhO+
	Jwh1JX1VpgT3dIOq0tg7g8DeoBGJTTWM1knJUdP4=
Received: by mx.zohomail.com with SMTPS id 176104787512699.63556097338187;
	Tue, 21 Oct 2025 04:57:55 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 2/5] submodule: add gitdir path config override
In-Reply-To: <aPc-4FHCpHYgQ9hs@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-3-adrian.ratiu@collabora.com>
 <aPc-4FHCpHYgQ9hs@pks.im>
Date: Tue, 21 Oct 2025 14:57:44 +0300
Message-ID: <875xc8qxfr.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Oct 06, 2025 at 02:25:15PM +0300, Adrian Ratiu wrote: 
>> diff --git a/submodule.c b/submodule.c index 
>> 35c55155f7..7a2d7cd592 100644 --- a/submodule.c +++ 
>> b/submodule.c @@ -2604,6 +2604,18 @@ void 
>> submodule_name_to_gitdir(struct strbuf *buf, struct repository 
>> *r, 
>>  	 * administrators can explicitly set. Nothing has been 
>>  decided, * so for now, just append the name at the end of the 
>>  path.  */ 
>> +	char *gitdir_path, *key; + +	/* Allow config 
>> override. */ +	key = xstrfmt("submodule.%s.gitdirpath", 
>> submodule_name); +	if (!repo_config_get_string(r, key, 
>> &gitdir_path)) { +		strbuf_addstr(buf, gitdir_path); + 
>> free(key); +		free(gitdir_path); +		return; + 
>> } +	free(key); + 
>>  	repo_git_path_append(r, buf, "modules/"); 
>>  strbuf_addstr(buf, submodule_name); } 
> 
> You can use `repo_config_get_string_tmp()` to avoid having to 
> manage the `gitdir_path` lifetime. 

Oh, sweet, I wasn't aware of that. Will do, thanks!
 
>> diff --git a/t/lib-verify-submodule-gitdir-path.sh 
>> b/t/lib-verify-submodule-gitdir-path.sh new file mode 100644 
>> index 0000000000..3a83f2d975 --- /dev/null +++ 
>> b/t/lib-verify-submodule-gitdir-path.sh @@ -0,0 +1,20 @@ +# 
>> Helper to verify if repo $1 contains a submodule named $2 with 
>> gitdir path $3 + +# This does not check filesystem 
>> existence. That is done in submodule.c via the +# 
>> submodule_name_to_gitdir() API which this helper ends up 
>> calling. The gitdirs +# might or might not exist (e.g. when 
>> adding a new submodule), so this only +# checks the expected 
>> configuration path, which might be overridden by the user.  + 
>> +verify_submodule_gitdir_path() { +	repo="$1" && +	name="$2" 
>> && +	path="$3" && +	( +		cd "$repo" && + 
>> cat >expect <<-EOF && +			$(git rev-parse 
>> --git-common-dir)/$path +		EOF 
> 
> Style nit: we typically don't indent the heredoc body.

Ack, will fix in v4. 
 
>> +		git submodule--helper gitdir "$name" >actual && + 
>> test_cmp expect actual +	) +} diff --git 
>> a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh index 
>> fd3e7e355e..11c84a7bdf 100755 --- a/t/t7400-submodule-basic.sh 
>> +++ b/t/t7400-submodule-basic.sh @@ -13,6 +13,7 @@ 
>> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main 
>>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME  . ./test-lib.sh 
>> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh 
>>   test_expect_success 'setup - enable local submodules' ' git 
>>  config --global protocol.file.allow always 
>> @@ -1505,4 +1506,12 @@ test_expect_success 'submodule add fails 
>> when name is reused' ' 
>>  	) '  
>> +test_expect_success 'submodule helper gitdir config overrides' 
>> ' +	verify_submodule_gitdir_path test-submodule child 
>> modules/child && +	test_config -C test-submodule 
>> submodule.child.gitdirpath ".git/modules/custom-child" && + 
>> verify_submodule_gitdir_path test-submodule child 
>> modules/custom-child && +	test_unconfig -C test-submodule 
>> submodule.child.gitdirpath && + 
>> verify_submodule_gitdir_path test-submodule child modules/child 
>> +' + 
>>  test_done 
> 
> I feel like it's a bit curious that we recognize the 
> configuration even though "extensions.submodulePath" hasn't been 
> introduced yet. I would expect that we ignore the config key if 
> that extension is not set, as the extension otherwise seems to 
> not be doing its job, does it? 

Good point.

In v3 the config wasn't as tied to the extension because it was 
just an optional override, however since we'll make it the 
centerpiece of the design, this 100% makes sense.

I will reorder the commits & rework this logic in v4 as you and 
Junio suggested.

Many thanks,
Adrian
