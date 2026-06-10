Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C2237713
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126963; cv=none; b=TOqOAihMFM8Fcm7VGDPX7UxmjLy0YpDmIdR/tEXjwAbZHl/Zrfo0cB3z6oWziVC0QzJ7bmJ1K5fFWLe+oQnkTc3/4SOu5aW4WdcljS1YUnpXbEE6tyKOl+x4DhKtiFqeCi0cOMRgoCGHCtEo+1WpBeEu3eKMjs/FvIrw8y2LjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126963; c=relaxed/simple;
	bh=RobjeaOmuN6EzgRlpijJkdeyoAUKLQvC52RTXUaxtLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWb5xUQQtDvPVz0UyU+hEib94Hs97a+y/VyGDPXSGkzRJcO3/tkoe/PeOygD7IRrFoxTz5VdbOnsCRoFGTRgFJ2aK3e22pBSszIAsIohKGaN3kQEELX0eDztel5okgzoIg9zptCyZac5MAnb4FF4BbmPkEBZApPu45XinBbETOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyBqC5Ps; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyBqC5Ps"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e701435806so5635199a34.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781126961; x=1781731761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWrZqLCaHmAPqO8NJn4YR74D4Y4MkhpAeM6xTrYnFGk=;
        b=WyBqC5Ps0Z1nTs7Q44T7Orisueifn+LNKoufHh/VjZWWFY8zSItoQ6MXfBgBF18n2o
         XcIGj0nGRNDlxt5nCKoSy7Xejkr8SNR91fnnKTXY8mta69o+r8lv2jZXeOqAtrvNkxbk
         0eycQbsoRT97n3kukuDBhDccM9XMRu71kvAcNVrVd/Lvzw3EhSituQseVYSTqZnOMKOD
         g8yI0k6oA+RhdFiuiRPbMBMZdk2tQ2cIKpV9RFckrOBsRIpk6Uhbc6ETJcRx2VdDvMgt
         8Tj2+8O3+mKMNPGfiu4helPJ/Cb+UO9m4YqKLtlqpqQZOwn7HDZ5ppayiLk9hohiiUHW
         oGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781126961; x=1781731761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWrZqLCaHmAPqO8NJn4YR74D4Y4MkhpAeM6xTrYnFGk=;
        b=XPgfnjzBItrfJc1slihemalpiedJoHbwc2IRsZvi9f0q5OkhEYpq1x8aM3YoCv71UF
         F0ZJay1Zs62WVqp2wrxPj/AS7jKcCXT+w2G3FTHvCb4HsFrM3RZ7KNT+7BxWqGVs9FBm
         0Kd0hTC/xsKDyL35lYvX4zZM6OTjDGr6g4IMosTqt0NnX5/xpJIh/nqOagXGFMvLqEmT
         DWd9KrQBStXWns/5jh4yHkaBjIWBFz/Iu4Mgh+EjG35kkSaO0qY83lOdt4jtlXYIOmga
         sS94kMiWnUB88SeItMDTBoTKbMAyBtKvGSHRXsWnyOI6/UnFIcWpqYLvYMULnQFQWXk6
         og3g==
X-Gm-Message-State: AOJu0YyYCsW9cWjBRXlqh21bht3pryDQSXJoi0MvvQ+9JoMnwJ3sy33z
	scli9a96F2K3lq32qrZoZOn95iqws5446Jlro65KOVN3fsnIei3lroxtcvWkRA==
X-Gm-Gg: Acq92OEfuiz5k9z4WxaKYfF+8im/aN80QjZqpb/7a+aKt+5CZoX4k1cwNR1aF0A4k/Y
	7uJD6NxIey3sKAeDDsdhPcheS5Kl7sRO0wFqtVaCdr+clw1vyMaXraSSKJ1cLBLM2vswDrccr9O
	D+CHNvhaNEwcK0HY1kXcFiy9paPRYgdUHD23V8cgZOFHUfPgCWPdEPAJ9ZgwdDNw1yxM1ILXvbT
	F+pTfFeTsO3OUjesT6RWq2tt8VNqzA7C66zXruzVGGoVd2JyHaleX4uFFKr2ABG0X8HI834qM1j
	dNDFAd6FCAia6RmICuxJ9o4uhm55ogeKjZeaBAiEHvxEDYeTcab+UNOGr3mP0m2F6KOHFqJJ+pp
	hJrfEe21saKTO8Azqce9o0OPdPF5PKMlY74FIKlT5RrfqV/m69tRCLrZ3MvggobwPJf6g6UA77n
	NyONfdG+FPiY3PyQTyB3Jqwys9CDk=
X-Received: by 2002:a05:6830:2643:b0:7e6:fed6:3c33 with SMTP id 46e09a7af769-7e70caa9215mr18070851a34.22.1781126961125;
        Wed, 10 Jun 2026 14:29:21 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e7f9csm17600992a34.17.2026.06.10.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:29:20 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:29:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] builtin/init: simplify logic to configure worktree
Message-ID: <ainT3CvCCM26-gb_@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-2-5dff3eec8f06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-2-5dff3eec8f06@pks.im>

On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> In the preceding commit we have stopped modifying the global
> `git_work_tree_cfg` variable. With this change there's now some code
> paths where we end up setting the local `git_work_tree_cfg` variable,
> but without actually using the value for anything.
> 
> Refactor the code a bit so that we only set the worktree configuration
> in case it's actually needed. Furthermore, reflow it a bit to make the
> code easier to follow.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/init-db.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 01bc27904e..b4343c2804 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -229,24 +229,29 @@ int cmd_init_db(int argc,
>  
>  	if (!is_bare_repository_cfg) {
>  		const char *git_dir_parent = strrchr(git_dir, '/');
> -		char *git_work_tree_cfg = NULL;
>  
> -		if (git_dir_parent) {
> -			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
> -			git_work_tree_cfg = real_pathdup(rel, 1);
> -			free(rel);
> -		}
> -		if (!git_work_tree_cfg)
> -			git_work_tree_cfg = xgetcwd();
> -		if (work_tree)
> +		if (work_tree) {
>  			set_git_work_tree(the_repository, work_tree);

Ok, if the worktree is already set via the GIT_WORK_TREE environment
variable, we can just apply it skip everything else.

> -		else
> -			set_git_work_tree(the_repository, git_work_tree_cfg);
> +		} else {
> +			char *work_tree_cfg = NULL;
> +
> +			if (git_dir_parent) {
> +				char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
> +				work_tree_cfg = real_pathdup(rel, 1);
> +				free(rel);
> +			}
> +
> +			if (!work_tree_cfg)
> +				work_tree_cfg = xgetcwd();

When the environment variable is not set, we try to derive the worktree
from the parent directory of the gitdir. If that doesn't work we
fallback to the current working directory.

This matches previous the previous behavior.

> +
> +			set_git_work_tree(the_repository, work_tree_cfg);
> +
> +			free(work_tree_cfg);
> +		}

Good cleanup. I think this is a bit easier to read too.

-Justin
