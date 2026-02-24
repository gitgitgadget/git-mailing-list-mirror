Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEB225403
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950001; cv=none; b=h0Ti3Kt63NkVTViPuQC0Mi6elou28tZ3bq6hHavCyR2Tw5rKOcNmjAsoaZm8vvzVmWXtkPcjSg5IjuVMZXz+81qLbncJpLx6JIWePm/F7dGvejEOD64fq/R+CZVo+Infb1JC36qu7RI1fS0EXeI6lvOVMuHs8ap1LNgIxBpp9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950001; c=relaxed/simple;
	bh=wewK0T/8N5xCDDg3DsRSXxH4frEovaKuvBS+XjDQubk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjTM7ZshusgQ/pm+bFjkKj1jAuOOa/3el7KKm+CTvNAKj9THXrEDPjeQvq5sh9THm/+N47Tg5+XBxeY6AWU0KzkwA5W3ccdwf+hSkM04JcXk7aLezjuQZGZKW3sKRBeo0uXvkNxX7Qp0KxBezsGGKEz9UrndSq0dPLJrTsT6GuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWqe0adX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWqe0adX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-823c56765fdso2602196b3a.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950000; x=1772554800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFtR0SqiTohHaQVqccuJfCXx470DsBfqYTn3WlAdQx0=;
        b=KWqe0adXT9ZJPe/RfDwr/P8WyqcU3zUdqI4GOkLOFJtK2nlWMXJ1coYpX+Dpzc2/i+
         aigW7gDyMqZW7QwLPe5y6+sFIRF+yOiYhXfW8KACS/zfSTd4SK/oMzPPp8YCcHJciYFr
         0+BHZb+UDivKjjR4V0+XAp63wwbw7TfiYJ8TgXCNnanMvgQWFHEUmUMLCCuecwySj+zD
         +wt2i0EGxX6RlepCTkqoY6U3EMhGgoSofyum48T0Y4ufNzIABOKBVksYmcDjhucQymaX
         +xGLtF19JA4PcdCdJZfsWpvgpzvsCcU1QpPU/9gtKjOdR4zEa7wN5B3Btij1Ff2NSsTE
         KyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950000; x=1772554800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFtR0SqiTohHaQVqccuJfCXx470DsBfqYTn3WlAdQx0=;
        b=FzT5uuSeBYY6sMF/kWPsPXTCRJpm81oPVHWTfUQT8/rqOBZ/q/RpnKQ7f53gWveKSc
         zoHKoF1Py/juo7u4t2XN4PL0T1jUr3Czv29F/smdGobjcGTKnCSAEkY1P3EqELVVI9CJ
         AtfafCY8dmTFhbJqtcS8iojmOj/uf1xo2rjI5/B7tTg+ftoskizFkDXt/cmXYfYxDXLk
         kxTvYAYY2eo96SA6mwcYPv2TzpSSw3q6lRRtN/DXKR+Bcz0E79I/R0ZUZ9g3x3N9JwTQ
         aXWwFOJTRVtMmSEiUNJlOvl8633PiDLNnOIoqcSyjqGXlMr1oh63g5M1MDOysTPaS1jk
         4HcQ==
X-Gm-Message-State: AOJu0Yy69Za7QvOA2cWEQc1Ves+YDNhFJ1PVFzWX3+SVM3HVSZ+CUTWU
	5tpdasmM++H0bNzbhWVkVECOZGtIAfkCP38dIJy9cCNrRR+Y+skD/a8FMtJXLw==
X-Gm-Gg: ATEYQzz5AHCdPxjT7w2FGpFPfOGLIDj073AMVnpeOk5TdDy+p2MnKmIcvcMzIKT9VQa
	54Eu0fplp33AImKRl6IVhtJn9hwbYdqMOgUpl8Oh7Y7AxR91jWGcCdXPYz3LalhIxMB4WdG/PP/
	G4K27gGrfLny8nlsMINRFA212WAVq/gVvnIZ/UO14ALDFstduIhTWxCaN4/hDxaCQddW0gYcBan
	Wufx+Mdc1Lek9Z7KZprPpbAG7qU4dzDnttUMmOCwNb1G3ApUxAtUkPOSY1UfIArTrIWjyYwJv0c
	Km2SwrW+fLLyO2DUedBieFVUgViR2keVgR7XO840gdH0uIa4tFHWR99bvEuVedWoYiv1mwAlZOS
	+IIcjEAQmwn56szBvSvTDVBnuJdFrhl2U0iVqVP70tSYTcUsHeU/ouflJVNbXEliHlOmulmzKEa
	vB5LCS/qLwvJfmb31PzttUFxpQsCAjqJz0eDOQZYOKVCbq4k+B7PbKt9auPLc=
X-Received: by 2002:a05:6a00:174c:b0:823:d2c:b167 with SMTP id d2e1a72fcca58-826da8f1ac0mr9361873b3a.18.1771949999738;
        Tue, 24 Feb 2026 08:19:59 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:22f3:c2b3:28a8:ba64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd64111csm10780895b3a.6.2026.02.24.08.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:19:59 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: =?UTF-8?q?Re=3A=20=5BGSOC=5D=20Discuss=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Tue, 24 Feb 2026 21:45:54 +0530
Message-ID: <20260224161932.33080-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g35e93594f7.dirty
In-Reply-To: <CAOLa=ZSxkgGbWjYCu4DP269LtOdtn7Tcbz+DJH1ASyrGVXvb2A@mail.gmail.com>
References: <CAOLa=ZSxkgGbWjYCu4DP269LtOdtn7Tcbz+DJH1ASyrGVXvb2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
> > Hi everyone,
> >
> > I have been around Git for some time and am interested in the “Refactoring
> > in order to reduce Git’s global state” project for GSoC 2026.
> >
> > So far I have built Git from source, completed a microproject, and explored
> > some related areas in worktree and wt-status. I have also gone through the
> > blog posts by Ayush and Bello Olamide, which were very helpful in getting
> > to know about the ongoing/previous related to this. From what I gathered,
> >
> > - In Outreachy, recent work has focused on moving core.attributesfile and
> >   core.sparseCheckout into local structs and also to handle the issue of
> >   lazy loading, but it is still a work in progress.
> >
> > - In last year’s GSoC work, the focus included removing uses of
> >   the_repository and other globals across areas such as
> >   preload-index:(core_preload_index), builtin/prune:
> >   (repository_format_precious_objects), builtin/fmt-merge-msg:
> >   (merge_log_config).
> >
> > Though I still have a few questions regarding the project for better clarity,
> >
> > - Should the primary focus be on core library code rather than builtin?
> >   (ref. [1])
> >
>
> Phillip does make a good point, replacing global variable usage in the
> library code is indeed more useful.
>
> However cleanup of some of the global config variables, could involve
> touching the builtin code.

Right, Got it.

> > - Is it preferable to approach the project file-wise (eg. cleanup of one
> >   file making it completely free of the_repository) or variable-wise (eg.
> >   identify one global state from environment.c and eliminate across the
> >   codebase)?
> >
>
> Depends, some variables (e.g. the_repository) are spread more broadly so
> trying to go variable wise might not make much sense for them.
>
> > - Are there any globals which are best not to be removed currently?
> >
> > For example, in editor.c there are mainly two globals,
> >
> > - editor_program, which appears to be only used within the file and is not
> >   dependant on repository. So would it be preferable to remove it from
> >   environment.c and localize it within editor.c, move it into struct
> >   repository_settings / repo_config_values, or keep it as is?
> >
>
> Makes sense to localize it within editor.c. What's more important is to
> understand that currently `editor_program` is setup inside
> `git_default_core_config()`. What would the new flow look like?
> Also with a global variable, its parsed once and available till
> execution ends. Will that still be the case?

Hmm. I will see how we can localize editor_program while keeping the parsing
and availability like the global. I think Junio also pointed out something
related to lazy loading of global variables in some recent discussion, I will
look into that as well and will follow-up by an rfc patch on this, maybe that
will clear more things out.

> > - the_repository, there is only one instance in the function
> >   git_sequence_editor() which is used in editor.c which can be modified to
> >   pass struct repository down the callers but is also used in
> >   builtin/var.c, where a local repository instance is not available. In
> >   that case, would it be feasible to pass the_repository or is there any
> >   other way?
> >
>
> Yes, that's how I would tackle it. Moving dependency to upper layers is
> a valid way to go about this, we do want to avoid this scenario if the
> upper layer is already cleared of such variables and has access to an
> alternative. In your case 'builtin/var.c' already uses 'the_repository',
> so this should be acceptable.

Understood. That makes sense.

Thanks for the guidance,
Shreyansh
