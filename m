Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2C30BBBA
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626825; cv=pass; b=kIOQ1iN16l51d27fjC+hpiA/e38Rdz4EqMaMWwO4KGUUharBItmEVJTTc8rA2uJgeXFFf6k6cpLZANytralfL3BmGrjcP7huAOp6w597g+2pDR7KHOZLQESD40tt5hIwWI+IaIGVgfXSpND7rPsWBnCx6h8k/r68/X751ZvwoqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626825; c=relaxed/simple;
	bh=PFEsHSSyNOAqDbCb0foP0N5YWVI5L7KiZa5vk+zRLoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvP8p5qhZILa1cF4qE8YQ0S50z28I7zA+BTHrN6/4DXFPd/HwzXAXX2VBorawGJ71ndh+oQG+Zqzl+ag62Ip3lhN+niXHDqJDUXfZkubk5gJOPR84X1y6t1UpydxapMp1+ulzRWY8USpig2d6XUG1Hyz/8Rfq6XfkyhySYrumzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+rMg81a; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+rMg81a"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so1415906c88.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 00:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770626825; cv=none;
        d=google.com; s=arc-20240605;
        b=V7EkOSLf3hDQR8v9rMnSgqgKakW8KY8fDXPZgsJzL+O+acmOsJ3bi3OrotzwpRZG35
         Mq7cX8o5RBE8YD5ZyLvHznezV67JQ6mj2GrXOnxXjXr+q86temP+QcoyQFNUADziwg0j
         JuPJpj3hUIaqIIxFvw8slzYG+09Jz7YtNVtuittFxxTAcZ1fdoYc9q71Yo/HPsxFvk1N
         669NBu6sswWAMiGtEoYdQq5c6SJDqRWAr+lpN6VF++tbT7UNn2h5Ntr6Y4ktKYgJB+Ux
         lxQfmzpxS1wyGizuGSE4Ld1+tpoCCx7k6/6an6AEBbhdLiA/uS/YIwQfpObN8R5xh222
         LSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vLLmqcSOSksK+bV+aA17i9PiyIs7S8SOTMUSmvCKWdo=;
        fh=+/BIGTbGi8YYiGT0Jxkq8sLozbzTo0iJIgcx+Hzmam8=;
        b=Osek6KfQUwLueQ1j+WAENitGZMUXNujfjMrGgtbGdWCwPd9iNlPYkRNOTekPYzlc/3
         KcPd9P37AwyrM3GNvk0f74DzpogZwME/7j1xC0tN32p9RYR9C4S7q0ueTNdlX6s3KPcl
         +7a1VlFwzdMxC9pPHBRp0uGI8fYBQ4Ieee++4HzvK7LIHyEl1Ekfev9ExCidiXN+GB8q
         d/DH0AuitViVqGNF8GBPG6FUO1r/BQ3AT99pB2DqD65iK9d2Gvv3wdcfKkRwW/zoZj0Y
         seV+9hdNPZOjtJEbz5W0jYgBhqVwkdl96D0oDUk0BB8t3IckRc/+bM2nfCj4qkznCK4C
         AbUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770626825; x=1771231625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLLmqcSOSksK+bV+aA17i9PiyIs7S8SOTMUSmvCKWdo=;
        b=g+rMg81aPIiOJVVCabhJ9fqdHZ823yhdmSAjfstJ1j6ArP+tAEGHEf79qaci1kzQoH
         uXfU9RVsOTNqZrPYCYkGOwbkNBInvdti0xu5ndEK2U8fj4e8fU5uW3USTVKbOC+fhBWx
         /mSn6BI3AegL5fsL579O9c7y/mk011sezY002J9NveB3/mO2OQWnx01cGiJBZKdnE0fl
         JsBzBGA1x9/XxABlhhGJDcdefllNErh4IUyPeDifIcMaEnSyT4e8m3tcBmmKGMFKJFRF
         lfiRlf8fjNfsewaEql8GvADKhCr5nFlNrM2H1IkQ38s5Io26MrmaNRQehWGrSmt2vHsN
         slcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770626825; x=1771231625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLLmqcSOSksK+bV+aA17i9PiyIs7S8SOTMUSmvCKWdo=;
        b=u7KdZqEudBgf36JIQTB50iJlVOLZydLrnHa6YG7f0tgX7Xp4xgBaWTwQ+YaNRnIaFq
         F4W2yBaAMTLG5ggNQ6RVOSpu2CsUwZkcmmeysMGMLFdjtkZ/piWR6Dx9XavFJYfj5SZp
         KvVcR5f6tCZGihQdq7IM79NoN144J+GTDT9e2n6FLAX8UXQ5LoAxc1OsKGAQI3rCAUye
         jb5SCxTkOt7yxq0reOk+sVKa2wjAXx/umYT9fZsL7O9EssGViDZjbUH8yYVOQyKO5SaW
         MQ9sMPfBP7Jr6mfE5Pns97WGlI0J/pvBbW3x8Lybli3KKroJ4kleolyvhzKC+Mtv8z0a
         wAqg==
X-Gm-Message-State: AOJu0YydReH3EYZKWSA/+y2Fhy7BZPGW+CGkGdWhnjIWzA58EaKyWpIK
	jK4CaoVKK2852ojrgZ0x8B0Nh2mL+lSKkrn852FCD6q6ypPQAx15vZ5MHuZamabhY4+NxJE9yoV
	UMef+eQ0roagFGPyjNa0ddkCJJ7xc30Q=
X-Gm-Gg: AZuq6aJ4GdO4wUx3ahAiivXtrwPUt1Vr64l2LXj26ZQ0koe53VTNfZCSSXLHas/the7
	BSHkTvx2lUWm1CtAcwbjb0FYcxTubf83gs/wG/7ukWaH3QFS1nEAsAZ96w6vUFzMhULWIJCIzdj
	5yQvbSLHLpszQdm3Iz3IheUxIY/fAhBDkmZHOqp/m1QpFAw6EmTjoHoaui/4rDv0rpMcnUPo0PD
	eUkY689tLRAN53aNPi5LRhwW9oh2xeg7Yde6aDP5Ei4zQ2A7CkrnMlsKbriOzIA/K/ZY7YyzVg=
X-Received: by 2002:a05:7022:24a0:b0:11a:335d:80d3 with SMTP id
 a92af1059eb24-12703f9b5afmr5621227c88.22.1770626824373; Mon, 09 Feb 2026
 00:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770127568.git.belkid98@gmail.com> <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
 <c95a7730-7b14-4be0-a4e4-861b2f5430ea@gmail.com>
In-Reply-To: <c95a7730-7b14-4be0-a4e4-861b2f5430ea@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 9 Feb 2026 09:47:05 +0100
X-Gm-Features: AZwV_QiVMt8UFX0_F5KIIO0JoU3oWzcVpK6DCMyMxK6VLhc9H4L2L8eALBorXtk
Message-ID: <CAD=f0L9h-_pqak2tjjpASmt91mx2RPha2ZW7bsvmBNdhEv=VAw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 17:39, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 03/02/2026 15:42, Olamide Caleb Bello wrote:
> > The `core.attributeFile` config value is parsed in
> > git_default_core_config(), loaded eagerly and stored in the global
> > variable `git_attributes_file`. Storing this value in a global variable
> > can lead to it being overwritten by another repository when more than one
> > Git repository run in the same Git process.
> >
> > Create a new struct `repo_config_values` to hold this value and
> > other repository dependent values parsed by `git_default_config()`.
> > This will ensure the current behaviour remains the same while also
> > enabling the libification of Git.
> >
> > An accessor function 'repo_config_values()' is created and used to access
> > the new struct member of the repository struct.
> > This is to ensure that we detect if the struct repository has been
> > initialized and also prevent double initialization of the repository.
>
> Sounds sensible. This paragraph could be reflowed.

Okay

>
> > It is important to note that `git_default_config()` is a wrapper to other
> > `git_default_*_config()` functions such as `git_default_core_config()`.
> > Therefore to access and modify this global variable,
> > the change has to be made `git_default_core_config()`.
>
> I'm not sure what this paragraph is saying with regard to the changes in
> this patch.

Okay I will fix it.

>
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
> >       /* Add other config variables here and to Documentation/config.adoc. */
> >       return 0;
> >   }
> > +
> > +void repo_config_values_init(struct repo_config_values *cfg)
> > +{
> > +     cfg->attributes_file = NULL;
> > +}
>
> Should we be free()ing cfg->attributes_file when the repository instance
> is free()d? At the moment we're using "the_repository" which points to a
> static instance so it does not make any practical difference but once we
> start storing the config per-repository instance we will need to free
> the config when the repository instance is free()d.

Okay I will keep this in mind.

>
> > diff --git a/repository.c b/repository.c
> > index c7e75215ac..a9b727540f 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -50,13 +50,25 @@ static void set_default_hash_algo(struct repository *repo)
> >       repo_set_hash_algo(repo, algo);
> >   }
> >
> > +struct repo_config_values *repo_config_values(struct repository *repo)
> > +{
> > +     if(!repo->initialized)
> > +             BUG("config values from uninitialized repository");
>
> This check and the one in initialize_repository() below assume that the
> repository instance is zeroed out when it is created, that's a
> reasonable requirement but we should probably document it as our other
> data structures tend not to require that they're zeroed out before they
> are initialized. For example
>
>         struct strbuf buf;
>         strbuf_init(&buf, 0);
>
> is perfectly fine as strbuf_init() does not assume the instance passed
> to it has been zeroed out.
>
> As we only support retrieving values from "the_repository" at the moment
> we should perhaps add
>
>         if (repo != the_repository)
>                 BUG("trying to read config from wrong repository instance");

Okay noted

>
> Everything else looks fine to me
>

Thanks
