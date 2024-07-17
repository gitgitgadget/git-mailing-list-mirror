Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C83186289
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239737; cv=none; b=gFIfR6fK++DWkSzDJUirv9wcfwfdOiwVEqfwDybHCMubu4g39Im/9374PgtONjJD3wPb+CMSs2/bu2RWakP8nI/woQbPAViZ7WdZU4/0KQtqhD3loC29AvGgxeOYQl3clEpwGX0ZOpscMBWTqjI6uaerARWLZM+43FAVXXEOAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239737; c=relaxed/simple;
	bh=JpsNe7rwKL7srJxawLlp4ZLHYpjG5w8+5T5ArcN9Wn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKF3LW6aBZrbWZRNbLw4QdSDKUfsOMLDMxJ3q0zje7jbk2a0hkKa2/v5vIJq9PR/F9BLSXtvyVPJDFvg1jRoBLJZr8qPuXuLN/10jVFtk7kDqiBAbKqGiCWXGfR6x4zUqTTwdze7uMsZI2UXqdRYjhSL7nvjmcRZQIilXZRfZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ke8duFIt; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ke8duFIt"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id U927s8AOxH4nFU928sEzHO; Wed, 17 Jul 2024 19:05:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721239545; bh=0ZAltQaDXkwTOsRL115cIbVIc5V57LyuYAAsgWkoFZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ke8duFItJz/+4mwtUrXwP0Uv0AEy0oymMxh1BGqKOGcEc/q2lTjR/jeftTdn/lDtg
	 5TJYYrffQquNCZAgqzru+iOPEabpcJbGvGrEHnaHUQ1XMOKkt2UTsOxMGsalI0y6h4
	 LTE/uWPwt5gupJNWGDk1bCdhw6INKNFocnd62YqS5pp2NSREMa7vicBu7CtoNtajUT
	 UCVX1Tqf0xSnwFgVc3eUgGH7M5hccEL5OqWNTKYsTPnJiZlKzq+2pB4WCSlFpcltzM
	 HJd6yVGXETRXrHzlsMqqzBkYeDxp3fmxhOGKAjotqaZoWdHPXOPisrFvNS+703W8A/
	 d6rsuMJKDx3Zg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=f5frB/yM c=1 sm=1 tr=0 ts=669807f9
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=c0QyLF2oPcprBvbjclwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 19:05:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.46.0-rc0 test failures on cygwin
To: Jeff King <peff@peff.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <adam@dinwoodie.org>, Junio C Hamano <gitster@pobox.com>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20240717064241.GF547635@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIYQm5nH44cXQLIOcXQSWa7R6/LaIMKU+ta/qpX4S63IMH0qZpSbnRviSV2v6Dnv6Aksti7+YtZg0WNhshacLKpIOoOLg9XNIVJ89loLDomUrNLf+x84
 Paqe6sbir+NplRLo7e8eV9tP5bKuuBx9G13IJpU01Yhk3HfkEolkIRFmqUbIiPsyLYCEfB05N2nU/Ut2MMPtfWox9TVCTOLWdXg=



On 17/07/2024 07:42, Jeff King wrote:
> On Tue, Jul 16, 2024 at 08:45:48PM +0100, Ramsay Jones wrote:
> 
>>   error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.git/reftable': Permission denied
>>   migrated refs can be found at '.git/ref_migration.sr9pEF'
>> [...]
>> Now try to finish the migration by hand:
>>
>>   $ mv .git/ref_migration.sr9pEF/reftable .git/reftable
>>
>> Hmm, note no error; of course, the mv command may well do much more than
>> the rename() library function, so they are not necessarily equivalent.
> 
> This is a shot in the dark, but: could the problem be an open file that
> cannot be moved? If I run a "ref migrate" on my Linux system in the
> debugger and stop at move_files(), checking /proc/<pid>/fd shows an open
> descriptor for .git/ref_migration.WnJ8TS/reftable/tables.list.

Heh, a very good shot in the dark! ;)

> Does the patch below fix things for you? I'm not too familiar with the
> code, so this is what I cobbled together.  The best response will be
> from Patrick, but I think he's offline for another week or so. In the
> meantime, this at least doesn't crash for me. ;) And I confirmed that
> the tables.list file is closed during the move_files() call.

The patch given below fixes the test for me! (I have only run t1460-refs-migrate.sh,
since the full test-suite takes 6 hours to run, but now all 30 tests pass!)

I also don't know the code well enough to answer your question regarding
the re-opening of the migrated ref-store, but it doesn't look like it would
cause any problems (famous last words).

Thanks!

ATB,
Ramsay Jones

> ---
> diff --git a/refs.c b/refs.c
> index bb90a18875..06a0fc5099 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2843,6 +2843,12 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  		goto done;
>  	}
>  
> +	/*
> +	 * Close the new ref store to avoid holding on to any open files
> +	 * which could interfere with moving things behind the scenes.
> +	 */
> +	ref_store_release(new_refs);
> +
>  	/*
>  	 * Until now we were in the non-destructive phase, where we only
>  	 * populated the new ref store. From hereon though we are about
> @@ -2874,8 +2880,13 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	 */
>  	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
>  
> -	free(new_refs->gitdir);
> -	new_refs->gitdir = xstrdup(old_refs->gitdir);
> +	/*
> +	 * Re-open the now-migrated ref store. I'm not sure if this is strictly
> +	 * needed or not. Perhaps it would also be a good time to check that
> +	 * we correctly opened it, it's in the expected format, etc?
> +	 */
> +	new_refs = ref_store_init(repo, format, old_refs->gitdir,
> +				  REF_STORE_ALL_CAPS);
>  	repo->refs_private = new_refs;
>  	ref_store_release(old_refs);
>  
> 
