Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08263FF1
	for <git@vger.kernel.org>; Tue, 12 May 2026 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620467; cv=none; b=cwTrHz+7g6tcEiFku7s9HHg7hyIGdwmbom2naTodzlK1cOIwra3QUrnUa76ghQXOebfOrgIHxyP0UzXeDKONliMgE1UcaUBe8sCxd9le7pAIhvmxh/PypmkVeTvrQqihVbIANV0VtnHZg6ZfUsHbFn2g/rvj+AQbguCuM9nHKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620467; c=relaxed/simple;
	bh=tdJgtqx9Hs6s1ERu8b8sdUgKkOMHU4sP77MY0K8v+R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCpED2PmcTk6kld0AFmdrbMWNiP8+dE14vO5KbBxpQStaAhJKByyays6XgnWGxLDsHYQaErpEGOottZsTrwNzKtZb0F+6ehWDvRilOWiy3mRtKWhLB45TOhoeC6u6NkK59Qyf0Mkpy0oCU59IZjLhwKdDPNHjo4nVMJOqeBMspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k8UMZRnu; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k8UMZRnu"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7c23248f3a3so31743167b3.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778620464; x=1779225264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fH6P3M3gU4iHG0TXHJ5JehIjyAtYcuHb5koShdXNfL8=;
        b=k8UMZRnulCzWdmMZrQlzLM8vSZ7cvFcIB2Mdz1ycyB7noFAmGBhgAgG0mVDI+s445B
         X8OgKRrOc8B2ZWRtlktSy49pKd1rbZkmFBmcfc/SQfPgFMdamnI+Rlm9ewplHuWaZkLn
         pghabROFPOmAxTBoNwkMLg0xiE7uF/75h4WM07/V2JbZS7z9jzL65O4jFzQBRWBHGw3g
         IpAFQ7v/JOXDEnqYfRJj+W3QxJZkfoKbDq4foYE+nMGF2nn4selp4BHx06iR4hcbuJYA
         xjeMQMNd0GpdKNrqapPCoSzKB+C6huxsyLFFYnOkgPx2FOkUp9S4mUapSp0ox1TQMgeC
         EltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620464; x=1779225264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH6P3M3gU4iHG0TXHJ5JehIjyAtYcuHb5koShdXNfL8=;
        b=pT9jE9z5IsC9BO1wtyyBESExQrceVd4XRtMoJH+hZbUynFiHRPOmefzTBblVbCu62Y
         jv3w9pVmc8M+0Evk0P9+fIqVpkqdfWIacWY0Jkm3/dQruWvGBERdIqBWKgxcFCdEu9g7
         4RpXurrGQNNx12tjfXnrYiG6Of6xFBI6gkv4a4VJK3K9rqJhjq8n2MwfYMOHng/W7cic
         H3VwgwI36gmF4srC8eGLdYSvWfAq4UwvZuhAjphai6xh7dAeou9jpQx8d7wkVoTtg6ww
         V9l2Sn3V7pXssZ0qVI6ENrgqermr8odcnO7QiuINVaMWT0GfhUlRIRt6VNR/Nf9dUooF
         rOdA==
X-Gm-Message-State: AOJu0YypbLF0m2txFzbpvE2R6gCRQeciEL+H4NakJINjxtdnviYRMG49
	E1+qDefYtvEQO1SclDMDhV+diCu3tD82Y/7CnxPwKuew6Q38ki5N0supV7kJcwrIgYE=
X-Gm-Gg: Acq92OETsQjcxIJ2jwqu4tgcCg803+IOE6XjK48O47my/kyllRaB15gAignshSV+i3i
	Uo6cJWJRTpHX5ZfYF4LnZrqodp8tRluMmM1FyZSBQtxczjgmz7ysgfYuwoEAATEQA7UAOK1l2+g
	ZAk43yhyRFQqZUHy86r10ve3FnHt9pYvU1gdwzpR4bFSUnQ9hrdmG9MJYv/xy7Lx8XUclpu6tM0
	aWIVsj/1YSW4S9yb/p6Ny3lnHM0L39mRxoVGwoQW/Gc6+H2yxdNVtbaE9d83ryvzEniu2VGGbu0
	E5RxUrmcMnUNDBuHfyIfwIKD/sjAxmZtL5TZCe6id/mpcs7ZkyVbSJBNDZP5oLmf7q+Hy2oeGZS
	V+GMMjQxiffTKtEnuGUWfGJw1D2TOZYAddQI16O2ZIRW999Hyh3QgCwLpGrWwczmSDldLzI0Q0I
	X+WHVKOn8r979td8Fx3bTQpQu0xfWGZm0PWU4W6lowLJPFQ/IoVFMZsF92HGmBKdk17bo3MB+9g
	3UxUFklFASnxZUA9QrJPLP0SAVq3kE5P1XAqJXZtcC0hs/3e9XpYnlOs+lSS7PSR8cfTrrmaHzt
	q++WtjMoulzkL385
X-Received: by 2002:a05:690c:60c7:b0:7bd:6432:d9c with SMTP id 00721157ae682-7c6ac1bab07mr6145127b3.37.1778620464290;
        Tue, 12 May 2026 14:14:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm169964107b3.23.2026.05.12.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:14:23 -0700 (PDT)
Date: Tue, 12 May 2026 17:14:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] builtin/maintenance: fix locking with "--detach"
Message-ID: <agOYLsJF4rHESk9k@nand.local>
References: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
 <20260512-pks-maintenance-fix-lock-with-detach-v2-1-dc6f2d284b6d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512-pks-maintenance-fix-lock-with-detach-v2-1-dc6f2d284b6d@pks.im>

On Tue, May 12, 2026 at 10:30:30AM +0200, Patrick Steinhardt wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 3a71e314c9..d866c19b92 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1810,10 +1810,33 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  				   TASK_PHASE_FOREGROUND))
>  			result = 1;
>
> -	/* Failure to daemonize is ok, we'll continue in foreground. */
>  	if (opts->detach > 0) {
> +		pid_t child_pid;
> +
>  		trace2_region_enter("maintenance", "detach", the_repository);
> -		daemonize();
> +
> +		child_pid = daemonize_without_exit();
> +		if (!child_pid) {
> +			/*
> +			 * We're in the child process, so we take ownership of
> +			 * the lockfile.
> +			 */
> +			lock_file_reassign_owner(&lk, getpid());
> +		} else if (child_pid > 0) {
> +			/*
> +			 * We're in the parent process, so we drop ownership of
> +			 * the lockfile to prevent us from removing it upon
> +			 * exit.
> +			 */
> +			lock_file_reassign_owner(&lk, child_pid);
> +			exit(0);
> +		} else {
> +			/*
> +			 * Failure to daemonize is ok, we'll continue in
> +			 * foreground.
> +			 */
> +		}
> +

This works almost identically as the original implementation I shared[1]
original thread discussing this issue, but it takes a slightly different
approach.

Instead of doing this automatically as a part of daemonize(), this patch
only adjusts this singular call-site, and forces us to introduce a new
function daemonize_without_exit() in order to facilitate it.

I personally prefer the other approach, for many of the reasons that
Peff wrote about in [2, 3]. There are two questions in my mind that I
would be curious of your thoughts on:

 * Should we transfer ownership of all tempfiles, or a subset of them?

 * Should we perform that transfer automatically via daemonize(), or
   manually via its callers?

Judging from the other parts of the original thread, I think the answer
to the first question is an unambiguous "yes". The second question I
think there is less of a consensus on, but I'd like to advocate for
doing this automatically via daemonize().

To summarize some of my thoughts after reading [2], I think that because
daemonize() is about letting a process continue on in the background
rather than fork()-ing children and then continuing on ourselves, *not*
automatically handing those off feels like an accident waiting to
happen.

I can't think of a situation where someone would want to daemonize() but
not have the new process assume ownership of its locks and tempfiles. I
think an alternative approach here would be to document the behavior I'm
proposing above clearly in daemonize(). Should a caller arise in the
future that *doesn't* want to this behavior, then we could introduce a
function similar to your daemonize_without_exit() (maybe in this case it
would be daemonize_without_transfer(), since not exiting in a function
that is supposed to daemonize feels awkward).

I guess what I'm saying is that I feel that future daemonize() callers
are much more likely to want this behavior than not, and putting this in
daemonize() feels like the safer option between the two.

FWIW, I feel fairly strongly about ^ this, but I'm of course happy to
discuss more if you feel differently.

(If you do end up taking that approach, that makes the C changes
identical to the ones I shared in [1], so you are free to forge my
Co-authored-by and Signed-off-by lines if you want to take that approach
instead.)

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 4700beacc1..df0bbc1669 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -1438,6 +1438,64 @@ test_expect_success '--no-detach causes maintenance to not run in background' '
>  	)
>  '
>
> +test_expect_success PIPE '--detach holds maintenance lock until daemonized child exits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		git config maintenance.auto false &&
> +		git config core.lockfilepid true &&
> +
> +		git remote add origin /does/not/exist &&
> +		git config set remote.origin.uploadpack "cat fifo-uploadpack" &&
> +
> +		mkfifo fifo-uploadpack fifo-maint &&
> +
> +		# Open the maintenance FIFO, as otherwise spawning
> +		# git-maintenance(1) would block. Note that we need to open it
> +		# as read-write, as otherwise we would block here already.
> +		exec 9<>fifo-maint &&

Very nice. The fifo-maint idea is much more robust than what I was able
to come up with in my original sketch, and it is a nice compliment to
fifo-uploadpack.

The rest of the test is nearly identical to mine and looks good to me.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/af+snTGFeoUUyfPU@nand.local/
[2]: https://lore.kernel.org/git/20260511200112.GA22912@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/20260511202258.GD22912@coredump.intra.peff.net/
