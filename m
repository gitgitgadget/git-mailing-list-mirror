Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3124149C6F
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850928; cv=none; b=sz9xEm7qYkOg19Eg/HrHX4adoyOq8O4q2kspTHwiSgr8Euy9sv2KXPNUb8XtTj9LiVlWDQfHc4iDAhY9AaBTH4buV8kEM+b30Ru2nBzJ0DEo/lnvx50ER3UfT6wvs2hbz/WKbv366k3MItVd9CEQbXBhVpaGLvZvs0WeYnzz+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850928; c=relaxed/simple;
	bh=xxd9kZCOylZQLolcvC9suADv4qxzPSNyMNCDvwuNJCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6b9W0OW5gO+fB86ymHEKV1iE46Y1H7ecrx0Dw7c8JFyC9ulcqlbLjIC45/AbcTBowOo1GmaVNNwSPGTgzsvsE8y5Ol9XF37Oc+gXpvd7/t2yyAY+j6/T5htPuUqPCuRqic6wCzMpm4aeIvSibbIvt7MbMqmHYfhaa7XHJd+vOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Nq4T5Yot; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WlRtH+hH; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Nq4T5Yot";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WlRtH+hH"
DKIM-Signature: a=rsa-sha256; b=Nq4T5YotIV5HW2zCyaOvsEx/XCDK8Y6rl2NSfEMslZDzOYdcWwyou0pz5VAf+XivNsl4M0YkNRgxYwFoHdtcdh1lJnDp0NJMyP83+5AZ4TDepRCP6djRGzM0Qxl8EzrkswKYZLLujFbj4d9EBCHud2rd/rZSiy53Fq//VeOvTKb2PGZoqwvpzRCrA0Oe4lBOa9oDc+f9BVM24NrFqbUmpeTI5+Mf03YUbh9Wo6mzh6X6JvCnpDT2pNILhq/8vDOWqFHAO7PvCp3YhUYoh0/V+AYdZ9BdZnhPSuL3Cv7PoEhXDzcodVXdc9XV26qUtIzEvAz+ZwS38djC6IsGQQ83Hg==; s=purelymail1; d=malon.dev; v=1; bh=xxd9kZCOylZQLolcvC9suADv4qxzPSNyMNCDvwuNJCg=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=WlRtH+hHAjSiquCHDrSIoyc+BC69CP3lJC/kUKNyzJBRmSWK8C4p+e+A57WfkKmNjDSX1Psnx3CZ58IhtelGxr1aV2QCnD4M+DsA9/zS52awhJoif/lAauNLy3fEL5e3cwS09nJe7aDdhAwxu4Cw32erfkXTcl1CfaDZ9gM9nFVQA2utcgqtPD1U4LGmComoc+ydH5yKVPizNqGnY3zf8PoXBKczkyAJyWgk0JiGRrBdwWkmzgGbhASJbA062kli2DH91CWEigL45uYxQpq0602JyhY4fcLRjI2jIstfzrRXEfpmo+YGWr6SxKG2OqNrPn2MGPckQMseug/K4T6rrQ==; s=purelymail1; d=purelymail.com; v=1; bh=xxd9kZCOylZQLolcvC9suADv4qxzPSNyMNCDvwuNJCg=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -651071525;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 10:08:37 +0000 (UTC)
Message-ID: <8fe4f7ec-6eaf-4e11-8e6d-cdb6a9a3c347@malon.dev>
Date: Sun, 12 Jul 2026 18:08:31 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/9] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev> <20260709161145.13349-3-cat@malon.dev>
 <DJVY828NHN8O.22CRAQOF73S6D@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <DJVY828NHN8O.22CRAQOF73S6D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 02:21, Pablo Sabater wrote:
> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>> The global variable 'excludes_file' is used to track the path to the
>> global ignore file. If this variable is NULL,
>> 'setup_standard_excludes()'
> 
> Nit: Strange line break here.
> 
>> in 'dir.c' forcefully evaluates and assigns the XDG default path to it.
>>
>> Continue the libification effort by encapsulating this lazy-loading
>> fallback logic into a proper getter and moving the variable into
>> 'struct repo_config_values'.
>>
>> Since 'excludes_file' is a dynamically allocated string, it requires
>> proper heap memory management. It is safely freed using the newly
>> introduced `repo_config_values_clear()` function when the repository
>> is torn down.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>   dir.c         |  4 ++--
>>   environment.c | 15 ++++++++++++---
>>   environment.h |  4 +++-
>>   3 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 7a73690fbc..4f87a52b3c 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -3481,11 +3481,11 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info/exclude")
>>
>>   void setup_standard_excludes(struct dir_struct *dir)
>>   {
>> +	const char *excludes_file = repo_excludes_file(the_repository);
>> +
>>   	dir->exclude_per_dir = ".gitignore";
>>
>>   	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
>> -	if (!excludes_file)
>> -		excludes_file = xdg_config_home("ignore");
>>   	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
>>   		add_patterns_from_file_1(dir, excludes_file,
>>   					 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
>> diff --git a/environment.c b/environment.c
>> index 13677484de..5950592d63 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -57,7 +57,6 @@ enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
>>   enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
>>   char *editor_program;
>>   char *askpass_program;
>> -char *excludes_file;
>>   enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
>>   enum eol core_eol = EOL_UNSET;
>>   int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
>> @@ -134,6 +133,14 @@ int is_bare_repository(void)
>>   	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>>   }
>>
>> +const char *repo_excludes_file(struct repository *repo)
>> +{
>> +	if (!repo_config_values(repo)->excludes_file)
>> +		repo_config_values(repo)->excludes_file = xdg_config_home("ignore");
>> +
>> +	return repo_config_values(repo)->excludes_file;
>> +}
> 
> repo_config_values() returns a pointer so there should be no need to
> call the function 3 times.
> 
> We could have the function be called once and use it then:
> 
>    const char *repo_excludes_file(struct repository *repo)
>    {
> 	  struct repo_config_values *cfg = repo_config_values(repo);
> 
> 	  if (!cfg->excludes_file)
> 		  cfg->excludes_file = xdg_config_home("ignore");
> 
> 	  return cfg->excludes_file;
>    }
> 

Makes sense, thanks.

>> +
>>   int have_git_dir(void)
>>   {
>>   	return startup_info->have_repository
>> @@ -461,8 +468,8 @@ int git_default_core_config(const char *var, const char *value,
>>   	}
>>
>>   	if (!strcmp(var, "core.excludesfile")) {
>> -		FREE_AND_NULL(excludes_file);
>> -		return git_config_pathname(&excludes_file, var, value);
>> +		FREE_AND_NULL(cfg->excludes_file);
>> +		return git_config_pathname(&cfg->excludes_file, var, value);
>>   	}
>>
>>   	if (!strcmp(var, "core.whitespace")) {
>> @@ -715,6 +722,7 @@ int git_default_config(const char *var, const char *value,
>>   void repo_config_values_init(struct repo_config_values *cfg)
>>   {
>>   	cfg->attributes_file = NULL;
>> +	cfg->excludes_file = NULL;
>>   	cfg->apply_sparse_checkout = 0;
>>   	cfg->branch_track = BRANCH_TRACK_REMOTE;
>>   	cfg->trust_ctime = 1;
>> @@ -744,4 +752,5 @@ void repo_config_values_clear(struct repository *repo)
>>   	cfg = repo_config_values(repo);
>>
>>   	FREE_AND_NULL(cfg->attributes_file);
>> +	FREE_AND_NULL(cfg->excludes_file);
>>   }
>> diff --git a/environment.h b/environment.h
>> index c4a6a45704..2e8352de7f 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -90,6 +90,7 @@ struct repository;
>>   struct repo_config_values {
>>   	/* section "core" config values */
>>   	char *attributes_file;
>> +	char *excludes_file;
>>   	int apply_sparse_checkout;
>>   	int trust_ctime;
>>   	int check_stat;
>> @@ -133,6 +134,8 @@ int git_default_config(const char *, const char *,
>>   int git_default_core_config(const char *var, const char *value,
>>   			    const struct config_context *ctx, void *cb);
>>
>> +const char *repo_excludes_file(struct repository *repo);
>> +
>>   void repo_config_values_init(struct repo_config_values *cfg);
>>
>>   /*
>> @@ -217,7 +220,6 @@ extern char *git_log_output_encoding;
>>
>>   extern char *editor_program;
>>   extern char *askpass_program;
>> -extern char *excludes_file;
>>
>>   /*
>>    * The character that begins a commented line in user-editable file
> 
> The rest looks fine.
> 
> Regards,
> Pablo

Regards, yuchen

