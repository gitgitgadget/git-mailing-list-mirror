Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E21A9FAA
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771063119; cv=none; b=A4KCGaE1kjkskOHNT+Wd3mgjaOdWgaslAelSVhpLvulTSzUttwj9ooXJQmIegDW4K0Wk1N5MPKUDZCECpbYFpA/QQDshTW5YznnTSHfCSut2l69WBAajNq9Pj/eb4sSyGivvRtyuJLMxyIGq/Ms3pmT99sojsRxDKQqtGMoHIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771063119; c=relaxed/simple;
	bh=Z1f1E9PgryxsDkoDVz7p2n/t3a9lnWXzKhEA2rKSmwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5njuObWltfZXnxkoVsxeXONbVDTYyIGU0kGkHUJqebijjQMKJucvDVlOSBNLkgPLiVaAQuXNLDuNeUTL9H04taZlhdwYLMURuERMNsTaJtjPN0jR1zsRgnzvXHnrzIXdfH+CftM+FuHABQPqJRkl37YNrENglmUj2dzeiizpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5KjyFXJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5KjyFXJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824af5e5c81so1600828b3a.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771063118; x=1771667918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gth+NF+ttQf7/Lc6PisbTP7Ica1ofOAJdolzv25j1gc=;
        b=N5KjyFXJZxuKEETo7cKWR0ttnnh8/2DpGI4ZrpAPcMPOQgkJg59H4O21LETPW/MFrM
         mW5ZUFefrKtoFnN3wlcKSBQqeKtPkL5+J84bEih9cAa9pZPUXKX+pSyBqtjPR8tBAXG1
         C8we8Di5KVwnMD3HrbZB5jNF/U6wqBGVc0GCY4Xn2wbS/0OXCbGdlcqqO2+acxLgWCBO
         gOCsPrSLyVgKZdatLhWNLRcu+1XHN7b1NUoaIKruQWnGM7CXq0z4oeNDT9JSAOEQkPxa
         K+IQQOKteACFaZWFP7BHglElOOBnzuSIuI9AYqQADP08UV1Iv5RMyI0nykwowUcy5YgK
         NvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771063118; x=1771667918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gth+NF+ttQf7/Lc6PisbTP7Ica1ofOAJdolzv25j1gc=;
        b=WscMaA4ZwQybKPieBy2quuZGWXP+Gsaa+Je6cAU+gifP2yXu1o9f3dGyQR0HaF94qU
         O/3LnMd7flkA9x29Hl4/26ERlK4WeIYJkPmqLO9tf9QB0i9PMY8uMf8kECQzHpKF8j8q
         XETesafD0rbdMUdcCZXgJcvtPi2uYzj9D7c6Vi/1+wxvOIfcth6GggLvO+4XfIgG9OWo
         0/8y1tqR7JU5lucvesS5ZbSOa4A7QRIT9q2ZT5fBRCle2SK/TM5ueXsC/dUssZ2FbNve
         ZnnXArZMLGTSHTCcE3b9AukjHF/J13KvRcBWGmJx7anCfP+DWjy4k8V7tWzB9SywliFd
         jh7g==
X-Gm-Message-State: AOJu0YywCqdgLC6X1n1nJyFmKAqrKHBzfx2Yo8Ozj4UZHD94I41ZAIQj
	d5UzEZuOo7tZlG34N+1rSofe2ynjghMcERQZB8995yLDTR2zeoTmIchFKiP+hg==
X-Gm-Gg: AZuq6aKDtfBdYB3mAbc3SGBwqutnxNpiYcfHKlJg+xFVFvmKnGgo9x2XqH6JWFTkL2f
	aqbdFT5pwnkhQHJ0P1HPmJOwjryUp/aP0YoGx0xQdY8H9A/6wohWPu64v+qJPAiWVtzD5TAo3oo
	uzry8PyHctGnlwBuauSoqezn4aMvDep5Pm98uqcTz2AY+2OUPzPtKWxYBkaw34oJ2/jNoWQx5w6
	UjiEm4+/V3qvAcT03R/EruaVQ95Y4zlfJLY4fFrQwAEPN0C3mSeoWTtvmYH9AZqvg/ZBx2UZdOf
	Hzt7FUnYX7FMl5iqdRAif7Rg+BmeJFDU+gygkWZ6aOxEYUanf2mj+VWko9YdPqduXUogqNVj5lk
	7/62vNX0z0p9e1xkRLb0lI5kjsBx6WNJPWHGFH/HUtAqga5jcuctmiMnwuE4N4NsL32Sy/darLT
	I9XBtDe2PI19fvBXlm32T5dDz522LtlYo2YKaWssybsd9y3UB3g8/pFHwe8gc=
X-Received: by 2002:a05:6a00:800f:b0:823:52b6:1633 with SMTP id d2e1a72fcca58-824c61028e9mr4465912b3a.40.1771063117594;
        Sat, 14 Feb 2026 01:58:37 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:fdd2:ec18:ed48:b60d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b6a17fsm6543464b3a.34.2026.02.14.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 01:58:37 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [RFC][PATCH 1/2] worktree: represent the primary worktree with '/' instead of NULL
Date: Sat, 14 Feb 2026 15:24:21 +0530
Message-ID: <20260214095817.514765-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq7bsgl42j.fsf@gitster.g>
References: <xmqq7bsgl42j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > diff --git a/worktree.c b/worktree.c
> > index 9308389cb6..b29934407f 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -101,6 +101,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
> >
> >  	CALLOC_ARRAY(worktree, 1);
> >  	worktree->repo = the_repository;
> > +	worktree->id = xstrdup("/");
> >  	worktree->path = strbuf_detach(&worktree_path, NULL);
> >  	worktree->is_current = is_current_worktree(worktree);
> >  	worktree->is_bare = (is_bare_repository_cfg == 1) ||
>
> Presumably we left .id = NULL from CALLOC_ARRAY(), so this looks
> sensible.  When releasing resources from an instance of worktree,
> we'd blindly free(worktree->id) and in the old world, free(NULL)
> turned into no-op, and this xstrdup()'d copy will be freed in the
> new world, so there is nothing funny here, I hope?  This one, and
> the change to is_main_worktree() go together.

Hmm, I don't think free(worktree->id) should cause any issue in this case.

> > @@ -127,6 +128,8 @@ struct worktree *get_linked_worktree(const char *id
> >
> >  	if (!id)
> >  		die("Missing linked worktree name");
> > +	if (!strcmp(id, "/"))
> > +		die("'/' is reserved for primary worktree");
>
> Makes me wonder if this is a BUG not die; where does id come from?
>
> 	... goes and looks ...
>
> The only caller is worktree.c:get_worktrees_internal() and it is
> feeding d->d_name that came from readdir_skip_dot_and_dotdot(), so
> it cannot be "/".
>
> By the way, I suspect that get_linked_worktree() should become
> file-scope static, as there is no other caller.

Actually get_linked_worktee(), along with worktree.c: get_worktrees_internal()
is also called from builtin/worktree.c: add_worktree().
So at this point we should prefer die(), and if were to make
get_linked_worktree() static, then we can add a helper for external uses
maybe using a struct repository* instead of the_repository in the future.

> > @@ -629,6 +630,9 @@ static void repair_gitfile(struct worktree *wt,
> >  	char *path = NULL;
> >  	int err;
> >
> > +	if (is_main_worktree(wt))
> > +		goto done;
>
> This is a bit new.
>
> The original did not say
>
> 	if (!wt || !wt->id || !strcmp(wt->id, "/"))
> 		goto done;
>
> The only caller is iterating over the resulting list of worktrees
> returned from get_worktrees_internal(1) *BUT* it already skips the
> primary worktree (the function MUST return the primary one as the
> first one, and the callers MUST be aware of the convention).
>
> So I am not sure if the new check is even needed.  Or rather, this ...
>
> 	if (!wt || !wt->id || !strcmp(wt->id, "/"))
> 		BUG("why are you feeding me the primary worktree???");
>
> ... might be more appropriate, perhaps?  I dunno.

Actually this new check is to prevent accidently feeding '/' as wt->id in,

	path = repo_common_path(the_repository, "worktrees/%s", wt->id);

but you are right as of now its only caller skips the primary worktree
so we can just put a precautionary check, for the case if this function
is used somewhere in future like this,

    if(is_main_worktree(wt))
        BUG("repair_gitfile() called for the main worktree");
