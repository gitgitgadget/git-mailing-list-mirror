Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288DB13B7A4
	for <git@vger.kernel.org>; Fri, 10 May 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307415; cv=none; b=mB+ca2cVbyi+5uJSgZF0H9/vS0+LH1h1rXm+6c+m/ln08Qy79UUeBCm3x4xuL9HEuBzmfBZzGW2DMBGOYEzqdCq43eR0W7KpRCtY1xpr4PwxSQ72D8QScZmqz00wRPzk7VUa6gwxkdFYtHgdSpSM0let+W0P3MkMmHjvhGHtD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307415; c=relaxed/simple;
	bh=17wTGkgyWoJkNJ9uH/4pPRdE9HoteRjJNb/eGke+9Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGeEe1b7EKM0lVD7jxD4QxrKfNYolrIE5R1hK5CCmmM0g//cN/Ll3PkoR3zDMFmwsHFJGa1P/brj2O2Ofya02Ys5WDMp1Vu6lSD6VOU+8o5IFM5JniQZrzQ3V94m44YcSiwJd2Joizbk14nzMsXOcvw4nSvMGYw0XA7jRvHsn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el+NRpac; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el+NRpac"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c998aed0e0so84641b6e.0
        for <git@vger.kernel.org>; Thu, 09 May 2024 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715307413; x=1715912213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYTeyyF7QSdt6Gyy8r8IcwBYhGgK2CROmWPoENb6eOA=;
        b=el+NRpacdj1xnOlG+WViJE3CUE+KS6gLoYUNzmf+Fn1jGrZge5RLpL5PtoJzAYsZP9
         ehWN0Ht60UEGQLyBTxsUnpy68vjDe4t/mVnMDA/FcPz9fwxeyVFlpSlS+EE67c8xa+D2
         0XMvtN+IHhMhYFTuZFSiYg9RaPppFlyiWGHPkXXo0A1tfdj6pIRYJ89ChVNj0/qBYwoq
         drafcsUsBNFSdXRcJnr6cVNoETrDCYXQIiSFmDt6Y6YTHYRGX4hcQT37lIE3HYrfOlWA
         hiLeWg3w80OLgJWBGUvZorSvgUePyGTnet/OQHtWNZRaaPoB9KWtJ4WigX4fzgZyHKDq
         zuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715307413; x=1715912213;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYTeyyF7QSdt6Gyy8r8IcwBYhGgK2CROmWPoENb6eOA=;
        b=whZmpT1zHp66irHjZahpHk8F2aNIG21WjLHNzgh/CqjnkHBbwYLxIQWihVWegHqIKm
         tWGiX68PzRYkjk7/iBV+OMOU/WQCMN6snSJY1TKlh2HJb8f3fvQFL/rMWYD4GO3N3275
         IsBhuWN4kx/dgGylZxzD96fSVTBRCFBorynv+/bFKbgVkwokHJ0es9kADkm4bqTjPFKw
         lKl4buNPEHEECHrI4SGc/iRaBRURPrMO7ny1VQbABTix2o5O0Twtig3ginPUI+PH0fan
         yrXDFaaH6PnssghK3PoG4+QQEcRmF86C6HcoJRQ43NH0rxxdUPi76YLQRJFdMownb9om
         tRUQ==
X-Gm-Message-State: AOJu0Yw+mNC4AMCwSyHTK8s+aDfl+cZ2diu3KrWD0WINUldbwS9R7oc/
	mFhgQQ7ROp8V/IozdBWQC16Qd8OEojS0Qlhin5zAI8dnbCV+1qWD
X-Google-Smtp-Source: AGHT+IH5KmhwLJT+cGbQj46+m7QzMpXh1N20vcpe+A2nkeb9p1BFwUIobS0OYGSJ+OaR8KLy/lPWbA==
X-Received: by 2002:a05:6808:1707:b0:3c8:42ea:ec52 with SMTP id 5614622812f47-3c98d911c70mr2130320b6e.16.1715307413149;
        Thu, 09 May 2024 19:16:53 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fcaa3c8sm459034b6e.26.2024.05.09.19.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 19:16:52 -0700 (PDT)
Date: Thu, 9 May 2024 21:15:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <obsrinbe2uvemiq7q22zrbcln2lmfaukn6lqn7nagrassoicb4@ihwb6ifpjomc>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>

On 24/05/07 10:27AM, Patrick Steinhardt wrote:

+### Removals
> +
> + - git-config(1) has learned to use subcommands that replace implicit actions
> +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `git config
> +   --unset-all`). The actions will be removed in favor of subcommands.
> +   Prerequisite for this change is that the new subcommands have been out for at
> +   least for two years to give script authors time to migrate.
> +
> +   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.
> +
> + - git-http-push(1) can be used to push objects to a remote repository via
> +   HTTP/DAV. Support for write support via WebDAV is not in widespread use
> +   nowadays anymore and will be removed together with the command.
> +
> + - The dumb HTTP protocol can be used to serve repositories via a plain HTTP
> +   server like Apache. The protocol has not seen any updates recently and is
> +   neither compatible with alternative hash functions nor with alternative ref
> +   backends. It will thus be removed.
> +
> + - git-update-server-info(1) generates data required when serving data via the
> +   dumb HTTP protocol. Given the removal of that protocol, it serves no purpose
> +   anymore and will be removed together with the protocol. This includes the
> +   "receive.updateServerInfo" and "repack.updateServerInfo" config keys and the
> +   `git repack -n` flag.
> +
> + - `$GIT_DIR/branches/` and `$GIT_DIR/remotes/` can be used to specify
> +   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1). This
> +   concept has long been replaced by remotes and will thus be removed.
> +
> + - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. It will
> +   be removed in favor of git-blame(1).
> +
> + - "gitweb" and git-instaweb(1) can be used to browse Git repositories via an
> +   HTTP server. These scripts have been unmaintained for a significant amount of
> +   time and will be removed.
> +
> + - git-filter-branch(1) can be used to rewrite history of a repository. It is
> +   very slow, hard to use and has many gotchas. It will thus be removed in favor
> +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
> +
> + - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/`. This has
> +   been a source of multiple remote code execution vulnerabilities. The feature
> +   will be removed in favor of `core.hooksDirectory` and the new config-based
> +   hooks.

I would like to see the double dot and triple dot syntax (".." and "...")
removed from `git-diff(1)` as I think they get easily confused with
revision ranges.

-Justin
