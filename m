Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3216EB50
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667530; cv=none; b=YgvoGUO3NCnA1kx+jS0D9FcLJgTawN8jcuG7w6k+3YQj7SPoacJJawkmiVntzfJcc+1YFpU1qD6EEWFPcLeResEERhBzej3H2Ud4dwd07svWyjCcQWBgu3S4tLn/eRbiEZYgT6l131h0tPKU7OoWFIBIxgqT+tAnVcScelivK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667530; c=relaxed/simple;
	bh=NsPeRytIDcgYGtD3oFlpy2NhFf++N0xgsZngqRr4Dhs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mg/VjftatFhpOczKFCC5hEogu8+Zbz/ssrKKbax3ycOXkFK5e/YdorCwUTP4UxnsdApiyS5FM7L47KlgaoYUV3ffo00MHTjNjfkcqSR6ZfAFcxXCgiWqhjeXq513PAT1+hPxlu2RD27tQDG3WJ6Tiq19GAg9Q26CXsuQG7tiQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2tpvF6l; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2tpvF6l"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fda7fa60a9so6411225ad.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721667528; x=1722272328; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsPeRytIDcgYGtD3oFlpy2NhFf++N0xgsZngqRr4Dhs=;
        b=B2tpvF6ltCRSQHGew6QaGH6+fl4OBbLU8qJBDFtQqDPSFy9Gl9v2geKjkVLTgh2xdZ
         Xcgk1aglpbCEGnbnK3XIZSg0xrnutpkN3c+GWSJrUtu7piZuqLw1ZEiYiAZXfBeLqqcv
         Gq/EM33YMcgMc2/JryvROkV8gdXjSNnDxJXsH3NOAI0VzMmMrYMUm57vIvUAP7C6tGBY
         myk3bcEmFugUJht5hK2r+2yrMWLpbSqoLUFs4LqX+v+9rIg8w6h9DzpACcN6jQ+uDbty
         vsUC8741emzOQLrQmd9IXokosbesL5zmF+IkOIYU+z8Djs0YBSgGaP76oJp5YwYAnovk
         d9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667528; x=1722272328;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsPeRytIDcgYGtD3oFlpy2NhFf++N0xgsZngqRr4Dhs=;
        b=aJWIR4/LUrAbrvb8sOOOuV7jhTcBR3JvM0pBTvyPSm1KSv/+gt+3zZbpl7COzYp5Vd
         1+YZhq4exItVO1whl/KOuCw3UNovG+jJndSmUMg+AwyPYLTeqVZgBIfdCS255NCzHSOv
         kcGWC1bnSe33fwW1JbTd1+ht42eALi1OuIRoQLoDXDIubDKsa+5ff6mgZpsiOo9taVH2
         +iZHC/YXMs9zllu4bj86kyuzO74j2W3XgHu6pkx9mzvZUAHT8YC49lg0CEXKk2cKyZsj
         Yo4YuR+T5pDLte5ieTU4XUtYuA1/obyUanVawMQ1PUR9PRmt/3GQph4k+SKjmn2BvvgL
         clig==
X-Gm-Message-State: AOJu0YwMPUt7VDItj35UADB1ip2qkuk6AZRX2xfJSTIa/tMGNdYif2pX
	zcu1pIUAjQ0+QzT5PdC2PW/YnhqnYt5YICYhnOMS9IsiGTbm0pMOJDGZto/x82nta/Vpgb0f7PK
	Vxk7M0im9XpigUiz4eMbvH3x0hNuwv97Kdh0=
X-Google-Smtp-Source: AGHT+IHKGxUyW0vI2o+F7YAWSuw/1wxenqowMdS5vhjOr0Yi+b42AY0+emaKQ7bo8nudZANHaOlqZaahw0srorVpjQU=
X-Received: by 2002:a17:90b:4acc:b0:2cd:2992:e8e5 with SMTP id
 98e67ed59e1d1-2cd2992eb23mr6011394a91.33.1721667528203; Mon, 22 Jul 2024
 09:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Thaina Yu <thainayu@gmail.com>
Date: Mon, 22 Jul 2024 23:58:11 +0700
Message-ID: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com>
Subject: [feature request] Is it possible to have git tag can be sorted and
 filtered by semver?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently there is `ls-remote` and `tag` that has option to
--sort=version:refname which is really useful when we have tag as
version format and let it sort as numeric version

But it could be better if we can also sort and filter the version in
the range of semver format. So we can use git system as dependency
management system natively

So I would like to propose a new sort option semver:refname

`git ls-remote --sort=semver:refname myRepoUrl refs/tags/v{^0.*.*}`
where brace {} can be used to define semver versioning ranges for the
patterns in addition to glob filter
