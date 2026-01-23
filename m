Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6692BE7D2
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174651; cv=pass; b=nv5ttLVfuApTwCuCZUa7AK1zk7R2EN2tisfZHeCc50glC/tpB6PniJ/n5zDzsoSpGWTvpvlZyI/r1wceBTGZIYw2vKngjFUVPdFBZJwIzWtajHyk95Hk64uCF3LGxjXNXAjFD8o29xu4/mtzY6ap795f3fldIevOXbUUygxPcd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174651; c=relaxed/simple;
	bh=29vaIA85qQtbWoI9qxNUZJoenu40WeJwKyLOpKXZKvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxDcTZKDRFUY00zoeWHrei61UBAt9jM9qfA/a/JoWbU2TtaVGAjJPuTdfegQnm2vcWUyDDLm1TIglvpErIVFXDupI3ruMLTzbRnJO0l50Dh8DQECKgC7S9cpDfe+IEfqcL83lNR618zvPGMt45OknheQ8iWJ2704RLRaU5PD5e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5Y7JuB5; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5Y7JuB5"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12331482b8fso955557c88.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 05:24:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769174649; cv=none;
        d=google.com; s=arc-20240605;
        b=Q20i7bwBAG+4eekkbG8cV+UvTrDUO01Eja11VjVWLyNgGdWTwodPeKtp7J2W5ujUJY
         xbI/tqHb8MgM/l1WC1mLYMzy353/pKiVc6Pj3EOn3x1Pa28j9YZueO/IDHzIwNEDx+PZ
         f193Sv/lXE8CqiFLkmaHe2hmzZ061CwuLjCGdWaMzqs7uYvPONkevv0nr3mtmF6EI4Jy
         LTyrFuvdhX6VlyUdhsdVPkvmzQTEINxI0R8je5tktXa6jyvPGpP9AmUAGqJtb+5nqk37
         BIk3vGujLrWiGxA9Xfw3c1JVsBCtZRjx0q7hLN4TDASZY7vKbp7pOAy4bnR4lCPTa+V8
         98xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BSnkbFea7mrRPqy7mq7j2MgbxfxnpO8nLhfuZBdOvTQ=;
        fh=ioPiTHX9io0glcunIHp4ufrrRiD9gNN5fxpE+91QwBg=;
        b=fs6G5A67lgXM06+2O0ZxemXMNILEDhq7bVQNeNcQ6ckVE2+5HnA4gPCdjeLi3WwhV9
         0ddE4smLG6H3ixEXhTZIk7qCRUsxRoA/bQCdEKZYLeUWIi73nLR6TYFqJ/b2VFh5ld6M
         IgwLeCyuj7pXADDUYLij9pPQxdDSl5Fx6hmWShk6Ak0wwFmJv9GNBFEG/dE6c52tkDjw
         BQZXObxoeBNam1c5GMxR0pDuw3hgb/Vd0R4aFhhQT2YZpc3OxtQIpVb7MeuHVN7694ph
         1gf5utRzE3fQUw64NAs1uOs9flf8BRp/OhS1aPZaCgdx/QKwNCB1QWeQYsDdQCIA12Xg
         yjqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769174649; x=1769779449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSnkbFea7mrRPqy7mq7j2MgbxfxnpO8nLhfuZBdOvTQ=;
        b=Z5Y7JuB5gjgFMRnchDZ7zbzjC4TMN62QL3BMMAFo75+Vb++KkJ+os7Jfqtzl9ctVqn
         6q0+cokDNBpheuvj/ekpEF/OvYJsAM7/s+2GkYuuxeC5aWr4RQGdJPNCtANtLNsH6Jim
         Cotzkl/vSiwBG10L/z2mEmE+JdRC0ky8VHIXu+mV3f6+9gGbi11/nINs6J0ciEDDQU91
         yVXGgwCLeQcdAYzVZcHsUF1cER5Hr/OB6M3PtKwxWq6az+M8LzSkyRCDJd18A4cp0c4R
         56vKR9eUy3JeX4ix8OF8mNoX/jpbVbYAaFH6dJ/pRnfKk9GWuwsELiJtxRKym1nyRL1e
         hasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769174649; x=1769779449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSnkbFea7mrRPqy7mq7j2MgbxfxnpO8nLhfuZBdOvTQ=;
        b=EcELVK6AKPsObRrxf1KuxO8U7iimadCR0olTbsX4Ghee8Ivz8x3U5gwFSuN1E5rs3e
         1a3iBR2Q2Saeq+Ez/7qn3cPsrjeRWmyQvPzPwAhf2BFxtNDEd4B6nVFcWIBA2FVDstaG
         9cX+BaIllJyLfrJPoX2nt9YPgcs2jfRfa0Z8JTZJ4I5xD96GoswB4AKCj/B5xh7VP5v5
         oBKxmbqlcghhx86mhwofyUjTU0hJpH/alqUxnSLuXkLJC2O1FD67VqKhs+Rst05s9aIA
         siI73cHrwIi+15Esg4M/oIIgkNRdW/6IF/16HmI2msOkJ8dv3QZ8LGRcKqBwHdB8Euww
         IBjQ==
X-Gm-Message-State: AOJu0Yxxqro7C5lbTw7qW269ybOlVa/aEImLnVJoklN8Ae66e7pr1vAK
	gieNloMSHa433qMwKZMixq8DNtESiMNvFLZWk1CFl4bsueZyHzBKR/5xtO0sl5tm2h+Vn6WL2Ke
	nYzFT2DkgyJ9EaeIQRWK8cdyt1vTuewA=
X-Gm-Gg: AZuq6aIjTrBOHmEzNuEjnDzPLIBS/yAxduWgVzMJePlXILbLlTvc0BJbpl1BzkFNb4y
	rw2ELLPJsF0/3HEqRU+rb8eGNeoxRC/yS7I3bxbya+FC0zN5dm96pI/GncUn3kedIYwBLai+W5R
	vfXEGGSPQGlXsiUuLbiVtQxN/u4mgB4Cy6mGkQ6vhpZVKKOxi4hcEHwp1X0J9vKgr8dZE7h7tFo
	gd+UMvQ5vyDByTEsJ+C7dhgTtf27MwuF5Rx06I8q9Eka7nchzCxU/gkBg/nyXQI9XHXHMTP9g==
X-Received: by 2002:a05:7022:78f:b0:123:34e8:ae96 with SMTP id
 a92af1059eb24-1247dc0ae96mr1362005c88.37.1769174647697; Fri, 23 Jan 2026
 05:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768681947.git.belkid98@gmail.com> <fd95169de42891452b430814476d78c706e4a7e2.1768681947.git.belkid98@gmail.com>
 <18b5d932-8a5a-4f33-a803-ef6f0c7d2750@gmail.com> <CAD=f0L9JhJq95kV7oUsaN5FqmUAH2qeSTLPLYXKAHUtNiHK_WA@mail.gmail.com>
 <4f19e70f-8ab5-4322-ac71-76bc925b324a@gmail.com>
In-Reply-To: <4f19e70f-8ab5-4322-ac71-76bc925b324a@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 23 Jan 2026 14:24:09 +0100
X-Gm-Features: AZwV_Qgto3DMoYBSlPfZZtRi9TyTi6r1YGDLP_CdYNZFFLQHfRodBnJZkFkRWHk
Message-ID: <CAD=f0L_YMvWdzG=qNN1xSCFsu7RdnM+7TRNUKbH1_SJirHUOsA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 2/3] environment: environment: stop using
 core.sparseCheckout globally
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 11:43, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 22/01/2026 15:29, Bello Olamide wrote:
> > On Thu, 22 Jan 2026 at 15:41, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >>> diff --git a/builtin/backfill.c b/builtin/backfill.c
> >>> index e80fc1b694..5fc8c51ed1 100644
> >>> --- a/builtin/backfill.c
> >>> +++ b/builtin/backfill.c
> >>> @@ -139,7 +139,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
> >>>        repo_config(repo, git_default_config, NULL);
> >>>
> >>>        if (ctx.sparse < 0)
> >>> -             ctx.sparse = core_apply_sparse_checkout;
> >>> +             ctx.sparse = repo->config_values.sparse_checkout;
> >>
> >> Using "repo" rather than "the_repository" here is dangerous because only
> >> "the_repository" contains the parsed config. This applies throughout
> >> this patch.
> >
> > Okay noted...
> > Sorry but I have a question.
>
> You don't need to be sorry for having a question - it shows you have
> been thinking about the feedback you have received which is very good.

Thank you

>
> > I observed that the address of "repo" is passed to builtin/backfill.c,
> > is gotten from git.c:handle_builtin
> > which passed run_builtin "the_repository" as a parameter.
> >
> > Won't the address of "repo" and "the_repository be the same"?
>
> Yes, but I think it is safer to explicitly say "the_repository" so that
> if any of the functions you convert here are ever passed another
> repository instance the code will keep working as expected. It also
> documents that the config value is only stored in "the_repository". Once
> we make these config values per-repository then we can use the
> repository instance passed to the function.

Okay thank you for clarifying.
