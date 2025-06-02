Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3348149C41
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880289; cv=none; b=bGM52dFLuk0ZyTxfJUE8cduen/Sncquk/6Md+rbBnqetl5g1Vo1edqWkZNosvicGSN+k4jFOFeMsNHfxcdsbFhH3LXieoJa7COQCQrtrxlGYclx1KLyT1yeTuYAsHJNqZHWXwAbg9If5ocMwkJDwzZdRvSaI9NmcK6ULCt4IJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880289; c=relaxed/simple;
	bh=tGZMtwTEytNS7np6TS1CTtuVWI1J5Kf96mBeI6K9KxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjgJJiiEJUWvb0HMprCBeHYGXqkbwVRAuVwuAmZOGl2ieSzJkVi99HWoEdSSBEmYshyyxMWgJ8j4MMT/ca5ElvyvPgYxkxr1leb7RAxh8kIl0YIESndk8rma+oNPclHLYlljvYqlMfSuOUK+uXEqDOuUvNi4V74tXlXgPtI44a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5fqtcVc; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5fqtcVc"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-408d14c7e92so1178645b6e.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748880287; x=1749485087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vY7ZBZ2QaNDglRvQ00hNQuhqQ+pG2Sr5gDWLfMb50ZU=;
        b=e5fqtcVcNZsCg2+E+GgqqhC42ET+WpchVdXxbMkrHKIDdxI4AYS79gLginZdxvDK36
         pRUxBVjP9R6Qu4gTht6EinpvOvp22QecDjHuKY//P3lb4MPcwicbNt/9URXH4KBileUx
         2v5CoDho54tGrxc4fQDh88V1wBQ6rL8CkswdIMHWsoi4SDo89nth61mSeH++WU8MyExa
         4Sh/t+p45tGkxponZo5V9UMqtawMEcItFfee8BhiZl69TwaUqI+Ve2pcxH/lYhnsBcb5
         v9zY9kVSBc6J543wOd8IHZuFzxacn3bO6g1rnWkBmtvDjFDq4pyUyW3e3Avu5DgW4Pnz
         vXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748880287; x=1749485087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY7ZBZ2QaNDglRvQ00hNQuhqQ+pG2Sr5gDWLfMb50ZU=;
        b=xCermAlxOjD0yGip44Vuif4JqQctuQoPSOWS4Rjp6LCK8ku2L5sIKwc7rdAuWlmrEY
         JSI7t5FL8n1SPbHT24DDGsNi5J1aO18hNfW8+w5NBVwtFlk+O5LrYiRi1D7U+mAHNP/N
         lT7mHAmNxENky34JKWO4vRC1CRvTj6sXzIgaKhyZdq1VmVRgjFn89xE6yICWOkMRtyud
         oVbRYKRiCXhyqidr4nX6lJva5VbkuWg76BNmignsgR/PKJLsklYX2U+58e0he06LT4P9
         +NEWna4wEOqPV95evKUT7v3UcMRDxHkN3lXtUn9wKcpvjBtJmemzRMo1O3Rg0TvgMPZq
         bPzA==
X-Gm-Message-State: AOJu0YxDs/mweCF6tjMyHfODzOok1nxr9NDwNiPHrjaH8gBFsfWQdUJO
	/1X4WsF20o4oFPhcl4Z4uicxKSXkRJVvaKF656mrl5xxFX8lbOemzWIG
X-Gm-Gg: ASbGnctReGMjMJUwZvSsV97UYjNDM1dlmmd/PzRo1fuRRj8uMieir7zQCsUYtWnJvvG
	RQwMHc+6I0a1diRGZOsP+GEr5ymjw+y/mX2w+WKJ4OMZnSS1u4om/iHgLxij/60DA8mTmTy7bHa
	7zeR5ubB8IxF0POoRgPWQ0WvZm/9mAclzCCXv7VOHBhPzFeJIM6OxF9Sj5TWMQOTw82otjSSJ/x
	EKVFuSl4u23i0BKaGKzDXM9UkeH71GMJndXsonHckYy6WgLVjf6HWPXn/ppxBBjpcbxy5zR8RCg
	VrRrqWwNne4Oz91K+4UEtL/YBYokExF18B2CHRnkP92fntng+Lb4LbI=
X-Google-Smtp-Source: AGHT+IHKwd1jFxuasHzjSaRENPR08c5ETQwxQzmg6iE8CkJHVr4ID2HY18Xhivdp+k8WZXRWTAZwSQ==
X-Received: by 2002:a05:6808:3c4e:b0:3fe:ab15:5ed6 with SMTP id 5614622812f47-407a6564f39mr5349865b6e.12.1748880286475;
        Mon, 02 Jun 2025 09:04:46 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40678ce8498sm1472617b6e.35.2025.06.02.09.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:04:45 -0700 (PDT)
Date: Mon, 2 Jun 2025 10:59:53 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip
 connectivity check
Message-ID: <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
References: <20250520014920.201736-1-jltobler@gmail.com>
 <20250520163218.263921-1-jltobler@gmail.com>
 <20250520163218.263921-3-jltobler@gmail.com>
 <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>

On 25/06/02 05:01PM, Johannes Schindelin wrote:
> Hi Justin,
> 
> On Tue, 20 May 2025, Justin Tobler wrote:
> 
> > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > index 9afea54a26..f76a22943e 100755
> > --- a/t/t5410-receive-pack.sh
> > +++ b/t/t5410-receive-pack.sh
> > @@ -62,4 +62,26 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
> >  	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
> >  '
> >  
> > +test_expect_success 'receive-pack missing objects bypasses connectivity check' '
> > +	test_when_finished rm -rf repo remote.git setup.git &&
> > +
> > +	git init repo &&
> > +	git -C repo commit --allow-empty -m 1 &&
> > +	git clone --bare repo setup.git &&
> > +	git -C repo commit --allow-empty -m 2 &&
> > +
> > +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> > +	git -C repo send-pack ../setup.git --all \
> > +		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> > +
> > +	# Replay captured git-send-pack(1) output on new empty repository.
> > +	git init --bare remote.git &&
> > +	git receive-pack --skip-connectivity-check remote.git <out >actual 2>err &&
> > +
> > +	test_grep ! "missing necessary objects" actual &&
> > +	test_must_be_empty err &&
> > +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
> > +	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
> > +'
> > +
> >  test_done
> 
> This test case seems to hang occasionally in the "win+Meson test" jobs on
> GitHub (I tried to find the same failure at
> https://gitlab.com/gitlab-org/git/-/pipelines but couldn't find any). See
> for example
> https://github.com/gitgitgadget/git/actions/runs/15383915635/job/43279134837#step:6:627
> 
> Note that this problem afflicts only the "win+Meson test" jobs; The
> corresponding "win test" job seems not to hang.
> 
> Even in the Git for Windows project, where the `win+VS test` jobs are run,
> the t5410 test passes within a dozen seconds or so, see e.g.
> https://github.com/git-for-windows/git/actions/runs/15383945895/job/43279689086#step:5:143
> (confusingly, the subset of tests run in the matrix jobs differs between
> the `win+Meson test` jobs and the `win+VS test` jobs, but if you click
> through all of the `win+Meson test` jobs, expand the `test` step,
> patiently wait a few seconds for the log to be lazy loaded "enough" for
> the search to work, you will notice that t5410 is not mentioned in any of
> them, and the only one that times out after 4h37m11s is
> https://github.com/git-for-windows/git/actions/runs/15383945895/job/43279753911,
> likely while running 5410, too).
> 
> Do you have any idea why this particular test case, in conjunction with
> Windows and Meson (and only on GitHub) acts up like this?

Thanks Johannes for the report. I'm not quite sure yet what is going on
here, but I'll dig into this a bit and see what I can figure out. :)

-Justin
