Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3313D504
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762966; cv=none; b=Dzo2HJCcqWWy/N+/e+yOBM1zkqoIpBLmW7THYbNAHaiHrLQQ/FFlHcT6/ZNyEUsd9sXH3+jyqNmyO48nfiB8wSRumIIxi8zjbisK2eb3uC5iSssevfagzcn2p8u71q3L4ZNo/g0/WWZJ2XnpIXxDOZ6pswy87iceMvhaB7BIqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762966; c=relaxed/simple;
	bh=wMZniObGMaAGo/VzJA+w9nyLcdLW8deqLgweWxthWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZ4gS61HcGRUgFzM8mLUV84o7mTcqop05cLabIiadYK+OSIeaGQfugeQLEbLipVWYbfE19igMGtBfvUnJmlJ3C6VCViICCrtiIjsDxPzqTt5yXJ1SDuqSu7Vz+CJTFObwyLmXqcJzQI4ewFs3FFwSePrudPwMkp0aaxojrIXCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Gd91J29D; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Gd91J29D"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id WLCBsxxEKItnuWLCDsNAti; Tue, 23 Jul 2024 20:29:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721762954; bh=16+DJnyVAGa2kuKTOlpK2eJGYTCZoJulJEFEExfS97A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gd91J29D5paVxm5KICti6/LKSN4fsHmsdDPiAfYjbYt3X9ifvsJkbd1zOkVgsJQl2
	 6GYsoevCCy6+RD2ZbRSTikGJjW+4+w8ysrmfisMxHQmvkAAhEDtIYq7dbEqNPXSBku
	 knLp8UMZmwMcdUwJUECHT+ZaRImeO4b7ZMCNAdh6PqPSPwouwX/SYqPfS+Ub2qPJve
	 d0uS4+IBC7BBGSW/Rmb7UYDW6ESM8QHeS+csi299sntYp9UBbuM1/haF0RBjWDBGrs
	 QqIZ52Ti8j4/hW43Sk5X728zxbNuWXjsRJ3etLPsQxDsDXl5s+00YV844toQ2rEl9B
	 t9kyrWcCBJ0bg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XMWTShhE c=1 sm=1 tr=0 ts=66a0048a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=PKzvZo6CAAAA:8 a=wFAsOzpzXQe0mcJ0-LEA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <6a4737df-16a0-4337-87ce-7ec11b40255d@ramsayjones.plus.com>
Date: Tue, 23 Jul 2024 20:29:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] refs: fix format migration on Cygwin
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Adam Dinwoodie <adam@dinwoodie.org>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <d031aef5552d894784650a8c6580925e877df794.1721731179.git.ps@pks.im>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <d031aef5552d894784650a8c6580925e877df794.1721731179.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEUvQun++cZfKVfYCWKf+ppF/qB5oVWnzGqkKkC/HFeBdiB8hu7Fc5vut6yNEbkZ0D0KNzoSChTVeIM0qlBiEA9dk+bS6ScoYWX+KykdlnHiE6QlDTuU
 mgDZ6Y5eeiX2eNM2EJI1zf1ZlzuhjaopJGcHYeKh1QL8UqbuHk5B979KKMWn+cyZKH8cDlrnF9FsjwPokl+MCaRs4/paNzWDxaQ=



On 23/07/2024 13:31, Patrick Steinhardt wrote:
> It was reported that t1460-refs-migrate.sh fails when using Cygwin with
> errors like the following:
> 
>     error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.git/reftable': Permission denied
> 
> As some debugging surfaced, the root cause of this is that some files of
> the newly-initialized ref store are still open when the target format is
> the "reftable" format, and Cygwin refuses to rename open files.
> 
> Fix this issue by closing the new ref store before renaming its files
> into place. This is a slight change in behaviour compared to before,
> where we kept the new ref store open and then updated the repository's
> ref store to point to it.
> 
> While we could re-open the new ref store after we have moved files
> around, this is ultimately unnecessary. We know that the only user of
> `repo_migrate_ref_storage_format()` is the git-refs(1) command, and it
> won't access the ref store after it has been migrated anyway. So
> reinitializing the ref store would be a waste of time. Regardless of
> that it is still sensible to leave the repository in a consistent state.
> But instead of reinitializing the ref store, we can simply unset the
> repo's ref store altogether and let `get_main_ref_store()` lazily
> initialize the new ref store as required.
> 
> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

I applied this patch on top of v2.46.0-rc1, on both Linux and cygwin, and
ran the tests (just t1460-*.sh on cygwin, complete test-suite in Linux).

I can confirm all 30 tests pass on cygwin! :)

Thanks all.

ATB,
Ramsay Jones


>  refs.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index bb90a18875..915aeb4d1d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2843,6 +2843,14 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  		goto done;
>  	}
>  
> +	/*
> +	 * Release the new ref store such that any potentially-open files will
> +	 * be closed. This is required for platforms like Cygwin, where
> +	 * renaming an open file results in EPERM.
> +	 */
> +	ref_store_release(new_refs);
> +	FREE_AND_NULL(new_refs);
> +
>  	/*
>  	 * Until now we were in the non-destructive phase, where we only
>  	 * populated the new ref store. From hereon though we are about
> @@ -2874,10 +2882,14 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	 */
>  	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
>  
> -	free(new_refs->gitdir);
> -	new_refs->gitdir = xstrdup(old_refs->gitdir);
> -	repo->refs_private = new_refs;
> +	/*
> +	 * Unset the old ref store and release it. `get_main_ref_store()` will
> +	 * make sure to lazily re-initialize the repository's ref store with
> +	 * the new format.
> +	 */
>  	ref_store_release(old_refs);
> +	FREE_AND_NULL(old_refs);
> +	repo->refs_private = NULL;
>  
>  	ret = 0;
>  
> @@ -2888,8 +2900,10 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  			    new_gitdir.buf);
>  	}
>  
> -	if (ret && new_refs)
> +	if (new_refs) {
>  		ref_store_release(new_refs);
> +		free(new_refs);
> +	}
>  	ref_transaction_free(transaction);
>  	strbuf_release(&new_gitdir);
>  	return ret;
