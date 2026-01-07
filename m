Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709A3A0B19
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804041; cv=pass; b=CIK8D0wH5SL+QOdkdP/WjxazT2TDyHVe6vGUKr46ex/FmkosCnVwrPwwITCUHHYTjQFX4vU1EhyhP1kldB05z4mBVEVEXJufSZylKBzLQho2DOxaaLDYj5CaELiOqk43PC3mEYgMD2oQOjAXkMOUR+zqURLT9qxJVBYT+kmcd6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804041; c=relaxed/simple;
	bh=oCV70U0cvarIfBR99Gn1pUUMJtWaN1UKMX8aTVOQ9f8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxFqB1n1DcXWbnVxCdq+6Oq+KNPSf7x0xxbVcGKnl0NUKWTRIrfkq/AxcLBqxo4Te2z6g2AHxS0+dRF4nd8ETrtWsdY9ZamCgCDzYpFuUEtSUoNlfIyibiWwW6E3IaeK916khXQvLGWIy8uzGW+/acgCvEL942YZQzcBLsZCrAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hibFDVIB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hibFDVIB"
ARC-Seal: i=1; a=rsa-sha256; t=1767804018; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GKblLUKygayyYqcR10zLsOHYiYn40QLeEwjGHyUHDIHv1gXHjkTidyIDZgt/YbHisGAA+axR6ysBI+1iJNxcoiyKMn5ZgU/96TzDaPqcv26k6Wm+SxMFDO/BL8KG0Eki7j3Sn5NPM83OtvQLe7Pnesr7wkJsqPXFt3xofjl7TpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767804018; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WKNmKYcfnUNqihYW/p5eMoOgZi+F0xPlVkRyIfYqNgQ=; 
	b=GNCENyoTvCa+6PBP6Ne+1Eofbufz7T3n+gPVHs3k71mME0OpigKg7bPLhlCfTzWx3Nz7esF578T1PfWGR5T22NKfKWOeMahVRNf/CvD1RGtkNCPrrBuwxd8ikwHn++bKWOrPptO60IRR9oXYq1uSfOJIOKToDZwzLFAhTjyumrE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767804018;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=WKNmKYcfnUNqihYW/p5eMoOgZi+F0xPlVkRyIfYqNgQ=;
	b=hibFDVIBNsrSxkT2QR84SMNmesB14oGWRZ988LFTL0DNLAVv6C177oi4NEle5Oio
	GrOjlddZt5E/PPECSEVT6uRp1IkLYQqX1srSso5boUCHzysiOiCJZYWaHX4GJpZ8Ax8
	D43Wk7I3nidR2VtfbpStgs1VyBZd+1cpYAgEpm4g=
Received: by mx.zohomail.com with SMTPS id 1767804016225671.8790746320366;
	Wed, 7 Jan 2026 08:40:16 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 05/11] submodule: allow runtime enabling
 extensions.submodulePathConfig
In-Reply-To: <aVy4_vtbuYlyppXT@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-6-adrian.ratiu@collabora.com>
 <aVy4_vtbuYlyppXT@pks.im>
Date: Wed, 07 Jan 2026 18:40:11 +0200
Message-ID: <874ioxidg4.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 06 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 20, 2025 at 12:15:22PM +0200, Adrian Ratiu wrote:
>> diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
>> index e45b2a8121..293a2ddbdf 100644
>> --- a/Documentation/config/init.adoc
>> +++ b/Documentation/config/init.adoc
>> @@ -18,3 +18,9 @@ endif::[]
>>  	See `--ref-format=` in linkgit:git-init[1]. Both the command line
>>  	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
>>  	precedence over this config.
>> +
>> +init.autoSetupSubmodulePathConfig::
>> +	A boolean that specifies if `git init` and `git clone` should
>> +	automatically set `extensions.submodulePathConfig` to `true`. This
>> +	allows all new repositories to automatically use the submodule path
>> +	extension. Defaults to `false` when unset.
>
> Nit: I would have called this `init.defaultSubmodulePathConfig` so that
> it fits in better with the other configuration we have that impatcs how
> we set up repository extensions.

I'll rename it in v8.

>
>> diff --git a/setup.c b/setup.c
>> index 428427d689..3e05fe7c58 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -2712,6 +2712,16 @@ int init_db(const char *git_dir, const char *real_git_dir,
>>  					  initial_branch, flags & INIT_DB_QUIET);
>>  	create_object_directory();
>>  
>> +	repo_config_get_bool(the_repository, "init.autoSetupSubmodulePathConfig",
>> +			     &auto_setup_submodule_path_config);
>> +	if (auto_setup_submodule_path_config) {
>> +		int version = 0;
>> +		repo_config_get_int(the_repository, "core.repositoryformatversion", &version);
>> +		if (version < 1)
>> +			repo_config_set(the_repository, "core.repositoryformatversion", "1");
>> +		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
>> +	}
>> +
>>  	if (repo_settings_get_shared_repository(the_repository)) {
>>  		char buf[10];
>>  		/* We do not spell "group" and such, so that
>
> I think that this logic woudl be better located in
> `initialize_repository_version()`, which is also where we set up all the
> other extensions. Feel free to disregard though in case there's a good
> reason you don't do it there.

No specific reason from the top of my mind. I think we can move it
without issues. Will do it in v8 as well.

Thanks again,
Adrian
