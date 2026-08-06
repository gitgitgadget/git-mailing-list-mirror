Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD73C819C
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005855; cv=none; b=RIibAHn/P8FbhkDLQhx/udQi6iyx6mVSm3gKgzAWKEwzsP+4Ag6SoHccnZY1C2a+zUd6fDgkpkCnI/ic2UcuWfBLTE3MeWltGw/64u1HtoSm6RdZqGLrZwJ85Oj+2ID8ufrgArbwecu4AOY3IhGAzqVOg6jP2UzRPeWm1QG5f9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005855; c=relaxed/simple;
	bh=cTmleWjavagWZqk9qTVKnpm4zqP2AV16I1tmR79+iYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6bT/EoDERzeKZmSLRsPsIvCYp142zkoMgUTOhhH9IrC0/x2H7L5wcPcCUxb8mzmZqr7dU0Kq/ZDhqEXbGxrMcqVeQ33KS7jEkLtHFjIaj1p6jNzRHjJReZoarNYThBSeJVOaU/7SYiR/wmekV1SmrI/z8BGsPP5aYT15CONJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=BuIkEsBm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=IyFyHKe2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="BuIkEsBm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="IyFyHKe2"
DKIM-Signature: a=rsa-sha256; b=BuIkEsBmtf2CsU5iD7+vYau1v432FJvhOrBoIqgEoT8oCsjOEHRAHxDi9D+S+jX18wjrbFBNQjPA8MDX1IoVBkIN0ql16rkc/ocKb2yTsAE5y91SvT4emox0f/lWdcIs+MEj94L320aIAkC6nKwWPN2KLGvYb03ijbX+jtdniMAlZhL/w0BbH4xM6ZSV9f2WAuLm0oPEbFY2czh+3q293bN51lrcuDNonGa+qwDegu/10THxg9MK4KNjKZqNY16A1/43o8bz89aJLOHtgyA+QdO2qHh/0qPwK2CzAgKHZL9lWVQ8fWIQSqVNtFOxYA9LHe7c/AEEtA0ABKNBoCsjfw==; s=purelymail2; d=malon.dev; v=1; bh=cTmleWjavagWZqk9qTVKnpm4zqP2AV16I1tmR79+iYY=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=IyFyHKe2obWhVQJjU2SOav2UFMyEprrgcAhV8BYpcujQK8JLoAtKB8V7vvyY52ZREYrKwJf3lue+omT/0mF0kINvGKE7SwQLmlJxmCOCbPP+Kd32su9DNzvFOLykAayEiYsT0qR+VyaaXbt05wBBcEmnryrv35JGeV7zvmu051/szFA5QomudrZeT3gXulJkfoR6EWteQ4eeoVOkYvjVA32m90fnine5vdQL8BmXdQAnfFeB10fujUWznbycXJllqhsgO91RzwOfa9PANFkT1CY240Wy/ldcEC3d8OaQ4QHshDeDyTqEcp/5RReg6dMStIwbbB+Hk6eSXNVsFUex9g==; s=purelymail2; d=purelymail.com; v=1; bh=cTmleWjavagWZqk9qTVKnpm4zqP2AV16I1tmR79+iYY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1736058855;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Aug 2026 08:44:09 +0000 (UTC)
Message-ID: <dbcbb042-5c50-4569-9b18-3edcc7b1ef4b@malon.dev>
Date: Thu, 6 Aug 2026 16:44:03 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] environment: reorder variables in repo_config_values
 structure
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260805115342.3939931-4-cat@malon.dev> <xmqqo6fgnssx.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqo6fgnssx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 05:47, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Reorder the fields in struct repo_config_values and its initialization
>> function to follow the order of configuration sections.
>>
>> Keeping the declaration and initialization order aligned makes the
>> structure easier to review and maintain.
> 
> Really?
> 
> Do you have some automated tool to make sure these initialization
> assignments in the environment.c file and declaration in the
> environment.h file match the order in Documentation/config/*.adoc or
> something else?  Have you designated some list as the authoritative
> source of truth to check these against?  Without such a list to
> check the code against and a mechanism to enforce the ordering, I
> find it hard to agree with such a claim that this makes it easier to
> maintain.

I see.

> 
> It is typical to list the structure members in the order of stricter
> to looser alignment requirement of their types.  I do not know how
> strictly it is followed for "struct repo_config_values", but by
> spreading pointer valued members more widely with smaller enums in
> between, the change certainly is making the overall structure size
> larger by requiring more padding between the members with different
> alignment requirements.  Not that we would have 100s of instances of
> these structures.
> 

Oh, I overlooked the size issue. Thanks for pointing out.


I think I will drop this commit. However, the original comments:

struct repo_config_values {
	/* section "core" config values */
	char *attributes_file;
	char *excludes_file;
	char *editor_program;
	char *pager_program;
	char *askpass_program;
	char *apply_default_whitespace;
	char *apply_default_ignorewhitespace;
	enum push_default_type push_default;
	enum rebase_setup_type autorebase;
	enum object_creation_mode object_creation_mode;
	int apply_sparse_checkout;
	int trust_ctime;
	int check_stat;
	int zlib_compression_level;
	int pack_compression_level;
	int precomposed_unicode;
	int core_sparse_checkout_cone;
	int warn_on_object_refname_ambiguity;
	int protect_hfs;
	int protect_ntfs;
	int ignore_case;
	int trust_executable_bit;
	int has_symlinks;

	/* section "sparse" config values */
	int sparse_expect_files_outside_of_patterns;

	/* section "branch" config values */
	enum branch_track branch_track;
};

still do not accurately reflect the grouping of the members, right? Can 
we remove them directly instead?


Thanks, yuchen

>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>   environment.c | 31 +++++++++++++++++++++----------
>>   environment.h | 20 +++++++++++++-------
>>   2 files changed, 34 insertions(+), 17 deletions(-)
>>
>> diff --git a/environment.c b/environment.c
>> index f5628b6758..918d8b50b8 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -745,31 +745,42 @@ int git_default_config(const char *var, const char *value,
>>   
>>   void repo_config_values_init(struct repo_config_values *cfg)
>>   {
>> +	/* core */
>>   	cfg->attributes_file = NULL;
>>   	cfg->excludes_file = NULL;
>>   	cfg->editor_program = NULL;
>>   	cfg->pager_program = NULL;
>>   	cfg->askpass_program = NULL;
>> -	cfg->apply_default_whitespace = NULL;
>> -	cfg->apply_default_ignorewhitespace = NULL;
>> -	cfg->push_default = PUSH_DEFAULT_UNSPECIFIED;
>> -	cfg->autorebase = AUTOREBASE_NEVER;
>>   	cfg->object_creation_mode = OBJECT_CREATION_MODE;
>>   	cfg->apply_sparse_checkout = 0;
>> +	cfg->trust_ctime = 1;
>> +	cfg->check_stat = 1;
>> +	cfg->zlib_compression_level = Z_BEST_SPEED;
>> +	cfg->precomposed_unicode = -1;
>> +	cfg->core_sparse_checkout_cone = 0;
>> +	cfg->warn_on_object_refname_ambiguity = 1;
>>   	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
>>   	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
>>   	cfg->ignore_case = 0;
>>   	cfg->trust_executable_bit = 1;
>>   	cfg->has_symlinks = platform_has_symlinks();
>> +
>> +	/* apply */
>> +	cfg->apply_default_whitespace = NULL;
>> +	cfg->apply_default_ignorewhitespace = NULL;
>> +
>> +	/* branch */
>> +	cfg->autorebase = AUTOREBASE_NEVER;
>>   	cfg->branch_track = BRANCH_TRACK_REMOTE;
>> -	cfg->trust_ctime = 1;
>> -	cfg->check_stat = 1;
>> -	cfg->zlib_compression_level = Z_BEST_SPEED;
>> +
>> +	/* pack */
>>   	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
>> -	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>> -	cfg->core_sparse_checkout_cone = 0;
>> +
>> +	/* push */
>> +	cfg->push_default = PUSH_DEFAULT_UNSPECIFIED;
>> +
>> +	/* sparse */
>>   	cfg->sparse_expect_files_outside_of_patterns = 0;
>> -	cfg->warn_on_object_refname_ambiguity = 1;
>>   }
>>   
>>   void repo_config_values_clear(struct repo_config_values *cfg)
>> diff --git a/environment.h b/environment.h
>> index 30678257b5..52ed13c0fc 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -121,16 +121,11 @@ struct repo_config_values {
>>   	char *editor_program;
>>   	char *pager_program;
>>   	char *askpass_program;
>> -	char *apply_default_whitespace;
>> -	char *apply_default_ignorewhitespace;
>> -	enum push_default_type push_default;
>> -	enum rebase_setup_type autorebase;
>>   	enum object_creation_mode object_creation_mode;
>>   	int apply_sparse_checkout;
>>   	int trust_ctime;
>>   	int check_stat;
>>   	int zlib_compression_level;
>> -	int pack_compression_level;
>>   	int precomposed_unicode;
>>   	int core_sparse_checkout_cone;
>>   	int warn_on_object_refname_ambiguity;
>> @@ -140,11 +135,22 @@ struct repo_config_values {
>>   	int trust_executable_bit;
>>   	int has_symlinks;
>>   
>> -	/* section "sparse" config values */
>> -	int sparse_expect_files_outside_of_patterns;
>> +	/* section "apply" config values */
>> +	char *apply_default_whitespace;
>> +	char *apply_default_ignorewhitespace;
>>   
>>   	/* section "branch" config values */
>> +	enum rebase_setup_type autorebase;
>>   	enum branch_track branch_track;
>> +
>> +	/* section "pack" config values */
>> +	int pack_compression_level;
>> +
>> +	/* section "push" config values */
>> +	enum push_default_type push_default;
>> +
>> +	/* section "sparse" config values */
>> +	int sparse_expect_files_outside_of_patterns;
>>   };
>>   
>>   struct repo_config_values *repo_config_values(struct repository *repo);

