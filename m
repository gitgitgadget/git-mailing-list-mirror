Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436138DFA8
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804169; cv=pass; b=OMEcMMOTRcsU8fucYkwa73X8Jnebr+VzSff3KrDDefkjH+Q6NW9uQWDt7slmekX2B2RATk3aWi8k1osA/EaVjZZqRgrlfcIQhttXQd3D+50mWbDrDjV5GdGCfcETer7BCvhAT3lPf/8oH3rkwEzkGO29fJOI5NBAYnyZpy30izA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804169; c=relaxed/simple;
	bh=6QqgMwSpiX2MsqPytxBnN13UnF0xX5gDLgqDu4yTbao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGClivnUqMy6KVponkZPSEqKUv0jQvLOOTIV3GNjN8qy0ikeJRj1UkTt0LkMR5oboJewNcFDdZchcXSx8WSDpVBT0UQMEfQn/mIYmegVqS2SF5rCwcOyoEbmuOv3ev6ERzmB0z7DRI5uM0kFHIKMH2zDDqNGazN7ZWboNdPzWJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FqMR3M78; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FqMR3M78"
ARC-Seal: i=1; a=rsa-sha256; t=1767804144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rky2g0IfgetvluE7mf4GemXyU16jaAdDIVd59XTykTB8GeM0NARy9KIdL1CRwDiFFcdMLpSSg5CGNNmUhQE3lYljXMtP8KmJbV0yz0i1lHec2lATvsV3ofcUNqh2TUXeSpFvMPZAlW5DXvn2K/HRDLvL5gpU4TFqYnrzVx8emrw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767804144; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nHXNu2bZ8LIWpnusURJRE5xGJXuYJunRapSaYDu6v8E=; 
	b=WZxEv4TQ1lr+1tt/nbRLhK0DB1+y9L9M4Hi0wt4+0XOAUhhZ+Lc6DffxllZvsQSBLiuY7tV8EuTnZuJfzTvNvgnGBs4cLDI2TMi35xs6tqm91ag55IguIN9Jl4BlEz0DUvlGsM8HC6tGDQm1/Q1MBrwaCSjpIfagEJ4wDAMBYMA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767804143;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=nHXNu2bZ8LIWpnusURJRE5xGJXuYJunRapSaYDu6v8E=;
	b=FqMR3M78q6VnTH0v0yCPJje7x8kIx7Il6+Yu2MZCELzLY3ckCgnQgOPz43kzA9tT
	3qaSzbKRARuYD/mcsHc83wdOnridQFRsIBEEqze3AMP/xv60DN27f1jK1xTN5VC5B1I
	J0ukB95ui9BuAbrPPfqFN8KvWilJBTVzrW61KipQ=
Received: by mx.zohomail.com with SMTPS id 1767804142785875.3615348732055;
	Wed, 7 Jan 2026 08:42:22 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 06/11] submodule--helper: add gitdir migration command
In-Reply-To: <aVy5Ap7wX4aW-UL4@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-7-adrian.ratiu@collabora.com>
 <aVy5Ap7wX4aW-UL4@pks.im>
Date: Wed, 07 Jan 2026 18:42:17 +0200
Message-ID: <871pk1idcm.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 06 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 20, 2025 at 12:15:23PM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index f8cae345a5..5a6436f18f 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1266,6 +1266,63 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
>>  	return 0;
>>  }
>>  
>> +static int module_migrate(int argc UNUSED, const char **argv UNUSED,
>> +			  const char *prefix UNUSED, struct repository *repo)
>> +{
>> +	struct strbuf module_dir = STRBUF_INIT;
>> +	DIR *dir;
>> +	struct dirent *de;
>> +
>> +	repo_git_path_append(repo, &module_dir, "modules/");
>> +
>> +	dir = opendir(module_dir.buf);
>> +	if (!dir)
>> +		die(_("could not open '%s'"), module_dir.buf);
>> +
>> +	while ((de = readdir(dir))) {
>> +		struct strbuf gitdir_path = STRBUF_INIT;
>> +		char *key;
>> +		const char *value;
>> +
>> +		if (is_dot_or_dotdot(de->d_name))
>> +			continue;
>> +
>> +		strbuf_addf(&gitdir_path, "%s/%s", module_dir.buf, de->d_name);
>> +		if (!is_git_directory(gitdir_path.buf)) {
>> +			strbuf_release(&gitdir_path);
>> +			continue;
>> +		}
>> +		strbuf_release(&gitdir_path);
>> +
>> +		key = xstrfmt("submodule.%s.gitdir", de->d_name);
>> +		if (!repo_config_get_string_tmp(repo, key, &value)) {
>> +			/* Already has a gitdir config, nothing to do. */
>> +			free(key);
>> +			continue;
>> +		}
>> +		free(key);
>> +
>> +		create_default_gitdir_config(de->d_name);
>> +	}
>> +
>> +	closedir(dir);
>> +	strbuf_release(&module_dir);
>> +
>> +	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
>> +		die(_("could not set core.repositoryformatversion to 1. "
>> +		      "Please enable it for migration to work, for example: "
>> +		      "git config core.repositoryformatversion 1"));
>
> We should probably be careful here to not override the repository format
> version in case it's already greater than 0. We don't have version 2
> yet, but if we ever do this would otherwise need to be changed.

Ack, it's best to future proof this. Will do in v8.

>> diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
>> index 06ee1ff86b..6ca9f13a59 100755
>> --- a/t/t7425-submodule-gitdir-path-extension.sh
>> +++ b/t/t7425-submodule-gitdir-path-extension.sh
>> @@ -260,4 +260,71 @@ test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSub
>>  	git config --global --unset init.autoSetupSubmodulePathConfig
>>  '
>>  
>> +test_expect_success 'submodule--helper migrates legacy modules' '
>> +	(
>> +		cd upstream &&
>> +
>> +		# previous submodules exist and were not migrated yet
>> +		test_must_fail git config submodule.sub1.gitdir &&
>> +		test_must_fail git config submodule.sub2.gitdir &&
>> +		test_path_is_dir .git/modules/sub1 &&
>> +		test_path_is_dir .git/modules/sub2 &&
>> +
>> +		# run migration
>> +		git submodule--helper migrate-gitdir-configs &&
>> +
>> +		# test that migration worked
>> +		git config submodule.sub1.gitdir >actual &&
>> +		echo ".git/modules/sub1" >expect &&
>> +		test_cmp expect actual &&
>> +		git config submodule.sub2.gitdir >actual &&
>> +		echo ".git/modules/sub2" >expect &&
>> +		test_cmp expect actual &&
>> +
>> +		# repository extension is enabled after migration
>> +		git config extensions.submodulePathConfig > actual &&
>> +		echo "true" > expect &&
>
> Style nit: redirection operator strikes again :) Probably makes sense to
> scan through all commits for this style issue.

Ack, will do.
