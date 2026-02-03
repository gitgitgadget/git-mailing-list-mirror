Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8143EBF36
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131813; cv=none; b=UeqVqOVDqFss8wJ0ImkTSRgqi+145kOsVBH3tIBocn0o14ZHzrQkUOvCDWMJtVGFTDbxjvY55J8S/S7q/G3DQzSK6tCCEybvkGbzSWYgK3W8dFzctKTGh1OwjvdiOoVqOTEq0a4cHgt++d4TJPPCe/rOxQYEJrIXhJNY9aWAYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131813; c=relaxed/simple;
	bh=S/CeKtbIfPGzjpWBjvhLdG+fjqsGPRjJ6FV9H8TnFZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhYxL3Z2rmDKpuIB4Y2vL+UczW0S/0ofJuRlYsLF8rC0YFfc+d/ZI2B0MTyhM91yJzUO0KyNVdkp2cjYOiPr6ubDIj7PgBRvx+21sc064ELX9o+/0eYtoItPs2wcbHpWZjPrt5DvUB7ZM7roeW6tmiIWez07/+sakNika2X4IBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC3cg72h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC3cg72h"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7bced39cfso60772845ad.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770131805; x=1770736605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx9BkMnyF4juV0FUKtOmpgjHIxZdtMfv418XdVd54IY=;
        b=PC3cg72hd4WodZg0jfr8GE8d12kV6AFbrfbVBo9TlO1Gv4HvtyWi3LAF5LOJftNu4+
         0Cd7y88XYM81MI+KwKNpMVYfPHLfHqokcVqueyqHOvIToKZPgV4uHFeT5hNYVZzbxKTq
         0yGCh4GxOjDaS2Dg9mmN81xS4UtWp7Dr5Mzjc50PmKeokzJi1RB2jXdlg+I3rK01gP7U
         qi15bL0iVSm5bPWlD4B8jjLFS+EmZSnA1+d/hBCF7/9/Kbd0b03a8RuUpURxgfKantB9
         oLj0p1VRHRtBf9XIBbJDzvLHNP66Ub+RPD5fu12Cd8rYY7lsZhr1xtLGJmIgnA6N5q2J
         sK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131805; x=1770736605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lx9BkMnyF4juV0FUKtOmpgjHIxZdtMfv418XdVd54IY=;
        b=VzA7KMvpn0lx4MNIAghCJ2ezh2UIq/G2H8vFActWWhVZxRRkqZreg52TZkdEd11jxj
         MSU3AjHfv8rF8kVjd2MmO4zCtOGVHYLjL+vAeUeSkx/B8mCiSXABJeuY9iYLYvTAPRQ4
         VlGbMmvL+P3kbzUbGCphpjKaIKjTmY9c44VJX4URCxGpGSMDhfwmkYwZW76Hl1J9wuAE
         gbsWOJYuAhyNe0SLcJ/F6vujgpsej02DFOVOSk01DLvyWy/yZzIqL4NHdFcJTS9otp6w
         PEJNqqgSORpQaYQVxvMTh3s8lmQl8L+IS0IkPEayHCe3562atKG49zK/7dTb9fj7PlAo
         SpUA==
X-Gm-Message-State: AOJu0YxbesW6Kxq2CMeNnqtoIoaFGKmLQpKNfadkuzP+juZREWQq2CDI
	sFkCOx3OejyTqhizJK9ssfMYAt7K2VfkPFr4i98QEQ4Lzmv2L/l4Jhqbr44rYw==
X-Gm-Gg: AZuq6aIxcj3AnxI90XTzxayLa+yz1Ff1KhVypca9LeD7Y23bUkFlRv0WzJI13tbbHYV
	BJ5In797lmcxr0ODQF3aYeub8cXjMF/u4AO/4uvNBMmcKszJHyu0S+5aFRL8+kkDnCBKqsZh79h
	Nak85wD9bnIsnu9F/kDAZ+xe5xEcve29AC38BklD3iOHV9/kSS64BWcsKqi96Pk7ec9sq9Zmp5C
	EfYY8j8G/ysQzh8PZjIqVmZYSr4LOBaxK0BAIokx7bJBCptmBYD4/qwOHOkLNZ5ojqQAhdpg675
	Y61SSVNzFDE+n+tCAKLKcLq6TJD34MwmKM33ctgBMEPr4Bfe3siGhxniflYV99EJ3dkYnSZpbTg
	AexIESudZo/fdIv+hwOn0vofcYNIEixiZKbI+do747gtiCMxXpzsFtOf1PHjnhLBKunyubGQhpC
	t+YlGY2QpquTwLn54IbJCJ99orYmvVVBnzCeLR0zInGyI7
X-Received: by 2002:a17:903:1786:b0:2a9:30d4:2af5 with SMTP id d9443c01a7336-2a930d42d7emr4588255ad.33.1770131804972;
        Tue, 03 Feb 2026 07:16:44 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3444:c9e4:e4a:f1df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm182902805ad.79.2026.02.03.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:16:44 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Tue,  3 Feb 2026 20:45:35 +0530
Message-ID: <20260203151613.36957-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <50791aed-c64b-48fe-8cc7-8cacaec9d295@gmail.com>
References: <50791aed-c64b-48fe-8cc7-8cacaec9d295@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > The replacement of all the_repository with s->repo in this patch are mostly
> > to cases where a repository instance is already available via struct wt_status.
> > 
> > In the current flow, all functions operating on struct wt_status *s
> > are called via commit.c. There, status_init_config() calls
> > wt_status_prepare(), which initializes the struct wt_status and
> > assigns s->repo from the repository instance passed in by the caller.
> > As a result, s->repo is guaranteed to be initialized whenever these
> > functions are invoked.
> > 
> > And commit.c itself still relies on the_repository, within wt-status.c,
> > the local repository pointer refers to the same underlying
> > repository object that the_repository would have pointed to, indirectly
> > until we make commit.c also free of the_repository.
> 
> Good explanation, that would be a very useful addition to the commit message

Sure I will include this in v2.

> >>> @@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
> >>>   {
> >>>	struct stat st;
> >>>
> >>> -	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
> >>> -		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
> >>> +	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
> >>> +		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {
> >>
> >> In the same file we make a call 'wt_status_check_rebase(NULL, state)',
> >> so wouldn't this break?
> > 
> > Yes my bad, it would throw a segfault error.
> > I think the best way to handle this is to explicitly check for the
> > wt to be valid like this,
> > 
> >      if (wt==NULL)
> >          return 0;
> 
> That would change the behavior of the function though as it will no 
> longer check if the rebase directories exist. You should pass the 
> repository down from the caller.

Yes agreed. 
I will pass s->repo as struct repository *r in this function. Thanks.

Best,
Shreyansh
