Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2297239E6C
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906010; cv=none; b=U5lXxK/LQ6hmuOmUbZHNg1WCX4X8CSR7o15v3bFttiey4YBfvMDcx1H9KX4RHNAur9hrWMTVH58cZdmFl8XWX378ESxK5/XON5JeKMF87K2rfTFr3PS0JqFMG4aE7MzGeXJFchEZ60+V8LWBgiT4MGLNj23D8UMZjYs2xYdiH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906010; c=relaxed/simple;
	bh=fUrCBN7gU40S9LfkzGoynd6ByIFCDjtuojxtVNxs5Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6ZHLEH0U3WB8P4nmZDs0Rki9ojDQxdmPcUVxM6rmgR6CBAQ47E/MuNqTqR5iDb3RVIx15VoqIT13bbe0CGModROzQb7bf5JS6smsPAH36nOl9JC2UgWVzJbojDbNs6/tvnmmKe9zUhrxjPZ+HQLjZroMeqv9tGRJ1q+NaRZvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4JIaXdL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4JIaXdL"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4f824de5dso2127352a34.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788906007; x=1789510807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Mj6eFiWM3gCnFGkyBGyf9yPXNLuCUNBJMaG5WSiLNU=;
        b=k4JIaXdLvaH3AsxrB6i1xJlq+isH7fKxWd1D/Z7Cbtms9axLtUT3lPaGx6m3wZfBku
         8155+g+Mat5eB7owjyMOlm3devfhdmBVbzwTdqk0u4Wh1pFFb9UqcIzukmen1sxH0L+p
         oqYH5EOGoUBd0CfPzkJrt3dX0tGtESZKhPw8ZUtl0LMn7JLXYGWSxm/J0WG1Q9Q9O6Ro
         XmtYwaCNXnbzzpGHnx6vGzSA65COfRQ+cqasdNagquku/xDgCqMbYPZzVljNmj0DmUiQ
         8u+HpNoD4T+RKt+ZgCepBdvcpqG/LVZhSnX9G8fT7v10G5WNQQFP+umgWFxZ050Oqnh5
         x73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906007; x=1789510807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Mj6eFiWM3gCnFGkyBGyf9yPXNLuCUNBJMaG5WSiLNU=;
        b=aG91ZK3KnvD/xKd8/Ok5p/qS6LbFoFfM7rWiFdCpeloQLJPpBnVS9B+A0fJeE/s0A5
         t27V5SyOwA/1f32kotTBqfb239vXc1LGCiXpcBqunuUNrDnFj3Lsk2E8kCMGTqtE+y50
         XtZUt7PyAsCLOVIX9Vg/KdxyWEjPjzkgqz3Ln+RP2XXpZP174BKGj/AohYK+EYWwovZ5
         zJmmz3sFhbeOP5zYG3tOcRqaZTbLcyObfLYnFC4riLy0ffjkPyruBvA0NqCH/2W1DaGh
         JRf9iSlsK16sjMeIJLCCpQ7KTvsJevrNwk2vdtQq/yqbjSBeoKeNMUPvVBSi6GO0m364
         RtpQ==
X-Gm-Message-State: AFuF++k5HzqZTy/CwjsLu+03PViwYKzKbXD4IhdXHlxpEd/JNC2T7nSC
	5+zHeK5FKDFwGJtO4Bq98aLoFoyZDnDM6mITAi64EHvYh5PvOPgowz9SQj5DNQ==
X-Gm-Gg: AYBFou37yzESW4YhnqsVW+3KfieWbaRL2CXqGaM6iFqGR0vGCLJXAg6CoMWrxpoZ9iY
	UpUaXKXKPqU4JQj0Owuv0+rSj4tqykEV8p3nz4YnKJAWepyPSQ8Qj7pd721Rdo01SUFNO+LAcWJ
	nUDQ5kMwCAcjnozKFVRbWPaRllU3x6R5p11USVwhmc+dUqrY7LhRUlgPfMMk4LsIi2uIyp2pTov
	KcHa4124sU/rA4fNlwJvvYxLOBZtj09b4K0Yr7c3XyLsGRipe0NKg9PDyKqLGQ+5Zrq7cZ1z2Wn
	iyKWsZQai45r/T9x4yoqcI+1LlpJXUn1og1e2tBcbahcvC2ZxppJaQnBHAEDv/KhLfaaUz1V4sc
	tRfJjpF1CWFj6KW0SLDBq7pt+SWzg23qmmbEtW/6RrshDKginUk36r/4QftN9nhEfHkN4ZilPqv
	dGXd9EN88u0s0BTppyiHbbCReamBhn48OTl1KFFBb22ojz36Jv5/2I+9k1LFsjrCoJ0gX5qy5IX
	8MOv1c2QeKzEQ==
X-Received: by 2002:a05:6830:618a:b0:7fa:ab72:9df8 with SMTP id 46e09a7af769-7faab72a5a7mr17318504a34.16.1788906007518;
        Tue, 08 Sep 2026 15:20:07 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da949asm15214594a34.12.2026.09.08.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:20:07 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:20:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/9] builtin/clone: defer setup of the object database
Message-ID: <aqCI5pfM3AGtfQsJ@denethor>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
 <20260907-pks-odb-write-alternates-at-creation-time-v3-2-735d0b5b3e00@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-2-735d0b5b3e00@pks.im>

On 26/09/07 10:25AM, Patrick Steinhardt wrote:
> When cloning a repository we defer initialization of the reference
> database. This is because we don't yet know all details required for us
> to initialize the refdb in the first place. Most importantly, what we
> are missing is information about the object hash.
> 
> We don't do the same thing for the object database yet, but here we
> essentially have the same problem. While the "files" database does not
> need any information about the object format at creation time, alternate
> backends are likely to require that information so that they can
> properly set up their data structures.
> 
> Besides this forward-looking future proofing though, we also have a
> second use case for deferring initialization of the object database,
> namely alternates. When initializing the object database we do not yet
> know whether we'll need alternates or not because this depends on the
> repository we're about to clone from. If it is a local repository and
> the user has passed "--refernce{,-if-able}", then we will end up writing
> alternates into the object database.
> 
> The ugly part though is that we cannot determine where the repository is
> getting cloned from before it has been initialized. While we of course
> already have access to the user-provided URI, that URI can be very well
> rewritten via "url.<base>.insteadOf". We can of course read the global-
> and system-level configuration to resolve it. But we explicitly resolve
> the URI a second time after we have initialized the repository because
> it can happen that we copy a ".git/config" over from our templates, and
> that file may cause us to rewrite the path.
> 
> In a subsequent commit though we'll start to write alternates as part of
> the repository initialization, so we'll need to have the URI properly
> resolved before we can initialize the object database. This is ugly, but
> as mentioned above it makes sense for us to defer its initialization
> anyway so that we also know about the object hash already.
> 
> Defer creation of the object database until after we have resolved the
> URI.
> 
> Note that this also requires us to defer the call to `setup_reference()`
> until after we have created the object database. While you might think
> that this function has something to do with references ("refs/*"), it is
> in fact responsible for setting up alternates. Consequently, we can only
> call it after we have created the object database already.

Ah ok, so now that we are deferring ODB creation a bit further, we need
to also move ref DB creation to afterwards too. Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 904d2d859f..bdcbd7aa1b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1188,7 +1188,6 @@ int cmd_clone(int argc,
>  	create_repository(the_repository, git_dir, real_git_dir, work_tree,
>  			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
>  			  do_not_override_repo_unix_permissions, NULL);
> -	create_object_database(the_repository);
>  
>  	if (real_git_dir) {
>  		free((char *)git_dir);
> @@ -1311,9 +1310,6 @@ int cmd_clone(int argc,
>  		strbuf_reset(&key);
>  	}
>  
> -	if (option_required_reference.nr || option_optional_reference.nr)
> -		setup_reference();
> -
>  	remote = remote_get_early(remote_name);
>  
>  	if (!option_rev)
> @@ -1342,6 +1338,10 @@ int cmd_clone(int argc,
>  	if (option_local > 0 && !is_local)
>  		warning(_("--local is ignored"));
>  
> +	create_object_database(the_repository);
> +	if (option_required_reference.nr || option_optional_reference.nr)
> +		setup_reference();

Ok so the move here is really just in preparation for the alternates
setup being handled as part of ODB creation in a subsequent patch and
purely just structural. Looks good.

-Justin
