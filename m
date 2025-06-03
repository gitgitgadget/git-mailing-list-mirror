Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A822F01
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748925580; cv=none; b=WLjsHomBk/D8mbBURBSKPgFw7OXH3TYIdbvODWgDwyEnUBDi8rkHzuoYb4a+dN207TOLGChmXILVW0ESUlYYKwcP1cn+Gb8qyXZiYpmDBSd4nthmaKwGK31FyJg/P4kxLI5dkiObyzP6374o5kl5IV806e5S3ss22of/AfeL5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748925580; c=relaxed/simple;
	bh=9MQvuOixycb0AnHjTbfHB9g0LR2bHrE2GX2kjNarhIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5iTWwHG/zotptamxQ7sCf+Mml6nunpXXQe1ZZdgB9MvFkQMi/fpKE1onHaC+xRsOd0HIZBlj3EYZKHn50mSie1zhtFn7vqam6dObX6ccEDb7Xq+T2msRFw0r6UsFJuwJmEMzBnwQ5JYPyw+4InloYYLmM+KIAGT7NXkmWQNl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqBt7Xyd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqBt7Xyd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d2d914bcso36176825ad.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 21:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748925578; x=1749530378; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDxn7M7LvoxqT71Z/j3ECJH67j21so/mYdlc5l7DYWE=;
        b=MqBt7XydiNCuF56xoMrTjv66dK6VOn+n2LJ26eBIH+AG0cp87mX//eBAoKiFeLMpdn
         e3+oq3LPe6Mj+UbRquX3wbkm3CmxFmvHSJpvDLVOd3JQCTuOLeO0eVh2RtRphmYhfwps
         asfpq74SkeHrYWZtbkxP633OlDe80t8+u2G8u9xExDhxdEPU83+ybJTE3w9CzkHvFnkv
         MmKMnpGVF8vSg6pFuZgQA2pITm/Ng2UzyVF5/JkgiwN7ojXXsJYiRq62CKIUGeA4/dtW
         s2abVVZhNlerUTwK0zi+49qONYiCy/GQ3/y0bZZwcduMAd7v9t/xDBXouHkIr9cX+scU
         dyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748925578; x=1749530378;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDxn7M7LvoxqT71Z/j3ECJH67j21so/mYdlc5l7DYWE=;
        b=aNhMZhelyT8DZIWyE+qiUEaXl4W4DA6pR17a1hTEmu7EtHbicVsqVxbiCMEgaru86c
         YRYqwr8B9tc8benLQ7EmTkcunD+kDdKM8luFlfKMYJxh5i9O9dyZ5da3PbRLXqxxz+qo
         NJ2qiXRQhQhFFy85lvmwWmV/lfHTUERCvXPOMJEhlRqWLAGh0BOVDpJH6lOnu7rxgchZ
         3KcNEplXkYFP6z3aHsvuKafCEx7mnufhkkJDEqMIRgcR717DiIHrijEJeAKsIkZyLE5W
         CtjRjjnhEzTnWRON8/Mnoo3QS1RIoX5YXB+ZPtDYgVU7krDF8QLAeohVd+Ii9LkjlQ0x
         WF5g==
X-Gm-Message-State: AOJu0Yxh02ezv1IFtH9SQCBZsxQcHhIJpe1++DSkLyd/NptSN3c93mtp
	6ucYj3gb+iyuwJUrMiIsVc1TUK5eF/OxMysGT1hS4qtwq3SH7l0mh/uQipJwQA==
X-Gm-Gg: ASbGnct6tZIVRvMmJar0YBbcHwVFZlTqgXqndQSA1Z3yv/LEsJNxW8ZKSOSjAaYXxcK
	RpaW4QslxIt5cJjgB5YQ49hDzMOSj5xPrJKIXjnSBnfS5ktmRbQ42bCoDekyqfQUOuCxITI958h
	4hWxC76MGwxMX5VncggDJ2bFtyaTH5q3r9Nynqz7XpMeZOn6k4x/A0ENzY8+bh6cymHpUI1oy9k
	rmSXj1QU9dDJ783kl2TMXsf29SWBXbiCtDP/vEYYf1Zs6P6lxXTl/Vlwjdn9BLgq/lx63TVKsYm
	V+s/leEVh+7rZAgnV/T3kd5zLsrPJJ4m9IU411UXnw==
X-Google-Smtp-Source: AGHT+IEf1LuBEANWuDlzfsoR841zqsj4pJfn+fN+MlFqjhwMZZChq1fDX/Ebs2ItEq5GGCrWn6zygw==
X-Received: by 2002:a17:902:e848:b0:234:cf24:3be8 with SMTP id d9443c01a7336-235293f6990mr277838015ad.28.1748925578027;
        Mon, 02 Jun 2025 21:39:38 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14b9asm78853875ad.220.2025.06.02.21.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 21:39:37 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] compat: fixes for header handling with OpenBSD / NetBSD
In-Reply-To: <aD52RXZVAsXpimBG@humpty.home.comstyle.com>
References: <aD52RXZVAsXpimBG@humpty.home.comstyle.com>
Date: Mon, 02 Jun 2025 21:39:36 -0700
Message-ID: <87sekhqvzr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

> Handle OpenBSD and NetBSD as FreeBSD / DragonFly are. OpenBSD would
> need _XOPEN_SOURCE to be set to 700. Its simpler to just not set
> _XOPEN_SOURCE.
>
>     CC strbuf.o
> strbuf.c:645:6: warning: call to undeclared function 'getdelim'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>         r = getdelim(&sb->buf, &sb->alloc, term, fp);
>             ^
> 1 warning generated.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  compat/posix.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks!

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin
