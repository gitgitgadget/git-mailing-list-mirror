Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2801CDA0E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036756; cv=none; b=lUk1isGd1S1OZJxkwewfdLa0ggjNsIxpPL03m/UD8fm+V14RVpqpYlbvDOcAiGdFtcDr0ZfN59tpRNZIa4q0qXel4Rb8rd8Oe8kPvuK8VkhkQ5IjywNoLLc4ZZDEs39EL1adi0OSDVwYrC4kYbKrwFNJ7dhrylMZcnL0MgYA4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036756; c=relaxed/simple;
	bh=Cwkmd0RRgHynp63VX8wD/xXxe3RZPqnsz6tSnshS+LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJvnW6djM4mKoAEIrRJySk3feidq7DM/wrLeJMZAI4ppgNdvF4zKLkZ7Fnwn5g62uefH9qnENEj+0tqk2XG+ScyADSOHkpWcf45arLfkBDwqWyPm5qC7XGqelw7KLpXK2vyAWwU0ZjCrzpJZsb8ZTY3g++onnDPdhAFegxJzuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARzLH+QL; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARzLH+QL"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-296c184ed6bso485436fac.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036753; x=1732641553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wT6tDYupnucPty/zb8OkAbvrMeJPmte0HQCZ8NrQymU=;
        b=ARzLH+QLYaJRqtjGmswADZmjgDHFyDkSrqE9ZO3Uu80jSDy5C650IWsejctBhtTywd
         JsHSX/dwnupobBbbvL+/1tLx3UyF6XsWA1FvImskXIwmlKNC83OkKDH4rRDhoNGSsVEd
         ub/Gvj7yNsf2303FM/GxDJ9YTtJDPs2PzwtGq+DoVK6D9RvnYJEvY3IqA+Ne0KVw7u72
         6IGp8eMTqWfngIpn9R+D7YzlEFKaCbJzW7DKtR/QVllvX3AZhmDdsRUX0Dl1c6EJ/deW
         joH8Mv37B1eg04YVxlIE0hl7AjxEoRftQllLJHIrsB3QcFAHbZGJBQjKSsTJff0ldimB
         hrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036753; x=1732641553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT6tDYupnucPty/zb8OkAbvrMeJPmte0HQCZ8NrQymU=;
        b=bLs5lCO5vAUrDoQ5uKk+cRqrZ3qgl2tOkCknZpg5vDJVpHGbXUp5QBufamx7FpxcJy
         2GsyWZPltrsN5h0JXcc8Jij1yCC3vzNFeg2Am1ETHosu+ny+rNWvanhz75MOyhVKKLVN
         kOWNKq4XVSkjJKvT4Zh7+3bVKMmfe8gSkb/riHN1FEAYO8GzcyUSvK5jN2P2jzs72Huh
         LrPbtLAclQw0Zd4fvmO7FfVN1i4O93d9a30r558pT3F12jv0FI5YDhorkPe1Zsr2f9n0
         9CyqyK23HvL6msBsAfQ03qYK60lbsqYzN5snSqD9wpQ382u9F6S/pTSWJqkG81n/8ijw
         Dngw==
X-Gm-Message-State: AOJu0YwuYBAmrlVvsRujAnLfuyghbCBSUbgONIFwvy6Xhj/F13Hm5A0d
	aN6wkpAW3gP82kOZwKV5gdk2yroDRSGsiIEoRRqNzocQe+VUhYmOCk9uxj3Z
X-Google-Smtp-Source: AGHT+IGWFElfs23OrOYyIHdcVTqnnUAn5yCuNYhnUyBdYKqmN+ukhYM33uDPaFYca68k2ptbKLQqeA==
X-Received: by 2002:a05:6871:5c9:b0:296:88d2:63d4 with SMTP id 586e51a60fabf-29688d27e76mr8587563fac.27.1732036753556;
        Tue, 19 Nov 2024 09:19:13 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ace569sm3617365fac.38.2024.11.19.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:19:12 -0800 (PST)
Date: Tue, 19 Nov 2024 11:17:24 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Miguel Rincon Barahona <mrincon@gitlab.com>, 
	Kev Kloss <kkloss@gitlab.com>
Subject: Re: [PATCH] builtin/gc: provide hint when maintenance hits a stale
 schedule lock
Message-ID: <neuwazkp5ca3mumpqezxsgm3ypb4zron3azfyuzwwf4soivrqi@wun5mz4c7vrm>
References: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>

On 24/11/19 11:48AM, Patrick Steinhardt wrote:
> When running scheduled maintenance via `git maintenance start`, we
> acquire a lockfile to ensure that no other scheduled maintenance task is
> running in the repository concurrently. If so, we do provide an error to
> the user hinting that another process seems to be running in this repo.
> 
> There are two important cases why such a lockfile may exist:
> 
>   - An actual git-maintenance(1) process is still running in this
>     repository.
> 
>   - An earlier process may have crashed or was interrupted part way
>     through and has left a stale lockfile behind.
> 
> In c95547a394 (builtin/gc: fix crash when running `git maintenance
> start`, 2024-10-10), we have fixed an issue where git-maintenance(1)
> would crash with the "start" subcommand, and the underlying bug causes
> the second scenario to trigger quite often now.
> 
> Most users don't know how to get out of that situation again though.
> Ideally, we'd be removing the stale lock for our users automatically.
> But in the context of repository maintenance this is rather risky, as it
> can easily run for hours or even days. So finding a clear point where we
> know that the old process has exited is basically impossible.

Indeed, providing a hint to help affected users here make sense to me.

> 
> We have the same issue in other subsystems, e.g. when locking refs. Our
> lockfile interfaces thus provide the `unable_to_lock_message()` function
> for exactly this purpose: it provides a nice hint to the user that
> explains what is going on and how to get out of that situation again by
> manually removing the file.
> 
> Adapt git-maintenance(1) to print a similar hint. While we could use the
> above function, we can provide a bit more context as we know exactly
> what kind of process would create the lockfile.

The added context provided by having a more specific message seems
appropriate. Looking at the message provided through
`unable_to_lock_message()`, I could see the generic example it provides
being a bit confusing here.

> 
> Reported-by: Miguel Rincon Barahona <mrincon@gitlab.com>
> Reported-by: Kev Kloss <kkloss@gitlab.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
> 
> this issue was reported to me internally at GitLab with the suggestion
> of providing a hint for how to get out of the situation again.
> 
> Patrick
> ---
>  builtin/gc.c           | 11 ++++++++++-
>  t/t7900-maintenance.sh |  8 ++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index d52735354c9f87ba4e8acb593dd11aa0482223e1..34848626e47c777112994e5b5c558b65952ac8c2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2890,8 +2890,17 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
>  	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
>  
>  	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
> +		if (errno == EEXIST)
> +			error(_("unable to create '%s.lock': %s.\n\n"
> +			    "Another scheduled git-maintenance(1) process seems to be running in this\n"
> +			    "repository. Please make sure no other maintenance processes are running and\n"
> +			    "then try again. If it still fails, a git-maintenance(1) process may have\n"
> +			    "crashed in this repository earlier: remove the file manually to continue."),
> +			    absolute_path(lock_path), strerror(errno));
> +		else
> +			error_errno(_("cannot acquire lock for scheduled background maintenance"));
>  		free(lock_path);
> -		return error(_("another process is scheduling background maintenance"));
> +		return -1;
>  	}
>  
>  	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index c224c8450c85f567bc29258e18b4a59fe6682f0a..6d6ffaaf376bdbadecdb23a460994af1d218dc19 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -1011,4 +1011,12 @@ test_expect_success 'repacking loose objects is quiet' '
>  	)
>  '
>  
> +test_expect_success 'maintenance aborts with existing lock file' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	: >repo/.git/objects/schedule.lock &&
> +	test_must_fail git -C repo maintenance start 2>err &&
> +	test_grep "Another scheduled git-maintenance(1) process seems to be running" err
> +'
> +
>  test_done
> 
> ---
> base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
> change-id: 20241119-pks-maintenance-hint-with-stale-lock-35e5417d632b

The changes in this patch are straightforward and look good to me :)

-Justin
