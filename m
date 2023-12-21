Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161876916
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5gTTcCk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4260dc2d828so794321cf.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703192344; x=1703797144; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:user-agent:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9KSbGMOAwVP3qokB6114pbfjOP7wuitmmwfgfsVQKE=;
        b=H5gTTcCkijgNLLVrth+TMvd7wEw2EjuAg0q+Y2F3SlLWvStv1UD+mbHOgvrtKBuDXC
         IHUqmTcYNA6DWxR9I/7m7PEcUvqQzSylZ4i9ZO/t0hhrDvdP5hc32Tf3j0gpH0bFToPj
         nvDsYhJxus8pVWyodf6zZ+kJljmXHVrL3C0y07rzjKhYhMF2UViP+rFwg7BrLcU2GoOS
         We0F98I72l3ZqICCY0AbT/so0/dI52h/pNk9F0Bhvhp5HOdU4Pk9g3hm+3Y68VsPFxs4
         goCUuShYAYUedqxsj7tWOftiaRuI1+M9/5IzhcNWZnI1bE5bP+4XzoQWYKuEz4FxW4+/
         jlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703192344; x=1703797144;
        h=mime-version:message-id:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9KSbGMOAwVP3qokB6114pbfjOP7wuitmmwfgfsVQKE=;
        b=Ea1qUQoZGal/lV8NVMy3aedzE0samlD4/6QQKJXO9af1L3lcj9dVzwiW/t5qZafY0z
         lvlaSw7CkyNUonfijIjjdTN1ZaJQ6tC1Jg7PS20fCUskTDH6keX/mF1cay8b8QhzOGna
         EIE+Vq/flfVwwS2ZseCXD3m4o+G1m825175e17gVTKdxhYmbTG9zuiFdCm5rrx/cIPet
         MtQyYaI5eoqEztqidlI4NAuIkaMve2wdN3Orjfknj3tx2yMda4VisX9FB59WUH5RixjP
         fMmFkR2k6cbygG4Slsf7zf7VsFb8oI74PcXn4BwD/9bg8gfJyupFoRrQGuSPA74RH2X3
         1v7w==
X-Gm-Message-State: AOJu0Yw0k2aXN245CV0auwA7Aqo2lF74Vdb7EaXJj0HKczcERpYBmnfr
	BtDyICQeCMLgZ9ysjs3n/9lIBEHS5Es=
X-Google-Smtp-Source: AGHT+IFAZnM7kU+pMyY/k3Wcw+jqHsKt4xjrhzLTKLHgVyUTVI+dCunZUJaysSBp91Weu73j5qU6Yg==
X-Received: by 2002:a05:620a:3188:b0:77d:c4eb:3d99 with SMTP id bi8-20020a05620a318800b0077dc4eb3d99mr965722qkb.0.1703192344166;
        Thu, 21 Dec 2023 12:59:04 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-j.epic.com. [199.204.56.215])
        by smtp.gmail.com with ESMTPSA id u10-20020ae9c00a000000b007759a81d88esm900181qkk.50.2023.12.21.12.59.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 12:59:03 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Git List <git@vger.kernel.org>
Subject: rebase invoking pre-commit
Date: Thu, 21 Dec 2023 14:58:35 -0600
Message-ID: <m0sf3vi86g.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Is there a current reason why pre-commit shouldn't be invoked during
rebase, or is this just waiting for a reviewable patch?

This was brought up before at [1] in 2015, but that thread so old at
this point that it seemed prudent to double-check before investing time
in a developing and testing a patch.

[1]: https://lore.kernel.org/git/1m55i3m.1fum4zo1fpnhncM%25lists@haller-berlin.de/

--
Sean Allred
