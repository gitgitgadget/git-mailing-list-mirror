Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DC1AED38
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735452; cv=none; b=NlSCINSBqsJzBcaOKMT0dL7UGpVP592bSp2Jbi/rjK6OFGb0fwkym3oKfJV6FpYWf8tbTYiMxY5sIfHDqDcL9Mk+jtdPzwkRYMaoKUYOvpQUQwMOuPcwsvvIP/jWqKPelp6rvm80+RkouaMnhHns87UDpuAElk5stfsuxw45ERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735452; c=relaxed/simple;
	bh=KEhoR1cfnCQ6zCX0CL4b/xbomAJ7Bu+TVrGgV39ao08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkEwDabl3dffKwCAXrG0PLb2F4lYriYPe7n3HgjcstnL5sSJ1D/QMixMYuKPqyMIJeHOY1K8bBxbSI8hhELMGavRGcX8s3AqKWWK0w7RIRlQ6/yOIOqjC7SheliXpPh0XdjGhJkbm2OtKUtNKp2+Wi2T/NC5DGniz18CkhjVYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNIMhjsA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNIMhjsA"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710d0995e21so816241b3a.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723735450; x=1724340250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qE4L2zdfBEEIHo1vznh1s+/ZUR+S1/puaMy0y1t6w9o=;
        b=SNIMhjsA60AgRBJPeugns14Eddj8zmt+fHYIvD3rf+2Z4nD2ce495r4BD6l+JPrnbW
         r42GrMGXyjTAZlJmFWXdTmGW6UjukBtlaD71o7eFlR4TAq0ItmneFJwyy4zCiHfTlAaT
         XVNjxITVKPPXYsjW++XGvF1UJbBSzvk2pdACgnMGmQLkSJhNSU43AUgWpMYl0MSwWb9d
         2Niqc5eoAMqUoIXzDCnvlwndB3guno9YoBuQ4u/Kcps9dhEtmV4LFKq05TR9xZM3LBuY
         v4sGhc8Qs9XuQvY4Qlew6FhYqE/RyaOO8A69YS/nzjXPOgj4i4ICHL8X7h2TvJL5OskI
         sh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735450; x=1724340250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE4L2zdfBEEIHo1vznh1s+/ZUR+S1/puaMy0y1t6w9o=;
        b=YKn1opZxizXxB9tF0rAPhuD6WSV1EFrCUTtVFt0L8TvL+iRkA8h5mpvkJ2am33TjrU
         oYsZqO/Go5Ra23XdBkQdfqyls/MGS9GcP9aJL2aAgezBPPvGcWLuTInyTxJUaDOIdRNB
         DD763HAbNzvUk7QRe/jQJEgZ/r3hlEcXidb5XuV8yN+5ic1py816F7ofB2pO5KpUaskP
         I/DJ/9buHrEcXaj75vF3mT5QpenEUsguJWtRNPPLfKG5yW6wGeAU+W29hDHBcbVdEqwF
         2WrfOkUk6D84ummvhB1bgWXMfdAMFhOilUKb3m5aGPnoiz3QCy9lTACpg1qLlusXMZqh
         n9Bw==
X-Gm-Message-State: AOJu0YxMHVMNMyk21felJNU9o1K672Bgu/tV2uElvcUx21634HhUh2tZ
	7kAxPZg9aGR998PLCQkJbjDOB2QhKQuP2PNOrpbfVxLguCJGSWrReUHNZw==
X-Google-Smtp-Source: AGHT+IGDhAIbiCy502gx3Ak89hlxhhUjnG3XjxstHSXYfaf9T4ZAh13a852efrMAXROnq8EBW9fODg==
X-Received: by 2002:a05:6a20:d493:b0:1c4:81ab:1f5e with SMTP id adf61e73a8af0-1c90503036amr52070637.38.1723735450367;
        Thu, 15 Aug 2024 08:24:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6e6bsm1152977b3a.18.2024.08.15.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:24:09 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:24:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/5] Introduce configs for default repo format
Message-ID: <Zr4dvybR6j6Ifyya@ArchLinux>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

On Thu, Aug 15, 2024 at 09:59:54AM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> to set up the default object and ref storage formats, users have to set
> up some environment variables. This is somewhat unwieldy and not really
> in line with how a user typically expects to configure Git, namely by
> using the config system. It makes it harder than necessary to globally
> default to the different formats and requires the user to munge with
> files like `.profile` to persist that setting. Needless to say, this is
> a bit of an awkward user experience.
> 
> This patch series thus introduces two new configs to set the default
> object hash and ref storage format for newly created repositories. Like
> this, folks can simply use the global- or system-level config to adapt
> to their needs. This also has the advantage of giving them the ability
> to adapt the default formats via guarded includes, such that e.g. repos
> in some filesystem hierarchy use format A, whereas others use format B.
> 
> This comes from a discussion with Sebastian (Cc'd) at the Git User Group
> in Berlin yesterday.
> 
> Thanks!
> 
> Patrick
> 

It's a good idea to make the user could set up the default object and
ref storage formats by "git-config(1)". I have read all the patches,
from my perspective, there is no major problems.

But I wanna ask a question here about the following code snippet:

  if (repo_fmt->version >= 0 && hash !=  GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
          die(_("..."));
  else if (hash != GIT_HASH_UNKNOWN)
          repo_fmt->hash_algo = hash;
  else if (env) {
          ...
          repo_fmt->hash_algo = env_algo;
  } else if (cfg.hash != GIT_HASH_UNKNOWN) {
          repo_fmt->hash_algo = cfg.hash;
  }

It's obvious that the precedence of "hash" is the top. We need to make
sure when users execute "git init --object-format=sha256" command, this
explicit info should be considered at the top. However, in the current
design, the precedence of the environment variable is higher than the
"git-config(1)".

If the user uses the following command:

  $ export GIT_DEFAULT_HASH_ENVIRONMENT=sha1
  $ git -c init.defaultObjectFormat=sha256 repo

The repo would be initialized with the sha1 algorithm. I think we should
think carefully which precedence should be higher. I cannot give an
answer here. I am not familiar with the whole database and do not the
concern. But from my own perspective, I think the precedence of the
config should be higher than the environment variable. This is a new
feature, the people who would like to use it, they will never use
environment variable and we should ignore the functionality of the
environment variable. But for people who do not know this feature, they
will continue to use the environment variable and they will never be
influenced by the configs.

Thanks,
Jialuo
