Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DAC3624C9
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211306; cv=pass; b=qdyNQIDyjxUTHO74ajQQFhrhaPIB6yiVaDG+aS9SzJOJu2j5V6qVlC8G7WBWzzW6saIdv+x31BJqzk3BKEHWypNkC6/RJie9a89By11xQascDJ0Zin/EIlApb8iS/18eCpitFI9r7297Zl1TivJ+zUTyyxUdOOSRBU3bv/YdiOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211306; c=relaxed/simple;
	bh=cmeP37IwBp2lXb4KPXoA4VMgO0U5ewu/Rz572YER4rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbuNyMFNfw1Va6hHgZLbR6rCn9UUxXf63G5mC3a0Tb4dMzQAANB7l6vBVJuzdZ9zZj4JCQT053/JwSUxEaQyXNsGn+F7EM/AMnCiJLcC9Th6PGVlUQMYUIJXp+K5WexPgIyGd0jcFwcT06rPqJ+Am7Whz9qx++sv/3j2RnUdCvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af+spKyC; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af+spKyC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6974ef0c3b1so5626714a12.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 03:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782211303; cv=none;
        d=google.com; s=arc-20240605;
        b=eoje1x2lddxXEOyR6zwub1Eu/bu+hgqTvvwvKYHgDVy71diS3NHewfpQmee445fCDI
         APpAAFEc8wnEBlGwM8MiHJoFOpN8s7d00po1uZe59oxDz8wNz8j8N8OBbWnNzCO34qfO
         WLsBaVQacYhudDQ4BLbZAxcMV9c6sw0ph4Q5G6UR0DUbUatDnmZOHI0eZL/QwlydWsCP
         LJBq4rpo+gnTaG67KBhq/ZEN90RBwTJ0KQylCkwRfdbdlOT0B2NJrQjyTC2ksUjY1K93
         PRg1SbVvn3Ys+gRD7HgNyAv8z9Xn8xr7MW69iOe7KoepNiCjqvCRc3J8y+PXzy9AanTh
         r8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cmeP37IwBp2lXb4KPXoA4VMgO0U5ewu/Rz572YER4rM=;
        fh=0cdnsI/Ubgp1XYh0611s/ZxcwUEFgjrL0EoTDbBEl40=;
        b=ZgCITg2IIYAXOd8ItCfgp1P80GsLoImpBXDbGxoLjW9psO4DUBoXilmBpgzYTOP01M
         WZ2NQtxyjigEtqaUwBWZd9xCND55uRlPm1S86On6Z/VLDAOWHI1jtwIY3a+aB0ALH8Wh
         fnIHOm3BAuSAv8lbrV4vKb0jreBWysWRKvfmHmwa9YgsZUh/tOf1NKXPA6r4DKYV8w5K
         KhZXeqJ3a5nFMKoa1Bvs5eGk+O0TVHpmTDF7OO7kADjWicOa4EDzW9VKmDCdKIeQBtWY
         qpEtJ4Fy8da9YFwbwxWQMSez+N+ZchJrsFhVKSmDZnm+APjLefYn9Bnvv8B1IXv6WNcd
         p6YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782211303; x=1782816103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cmeP37IwBp2lXb4KPXoA4VMgO0U5ewu/Rz572YER4rM=;
        b=af+spKyC1IlexDt4iSdGTnhwN7dnOrPiie9CdZy0JiP+Q3tsqL5JNX981h/Eo+Mdcw
         olk6BpWjEI6JRybPoS8/2akcc3BAXZrq2o6njKOJPaT1mGJmHTFaAmJWs0/uyoYjvZXm
         zzyJW8CA59avIE8j7oGI+e2n+wAv7Tr0+aLLPWKTIu0dHAZewUa1XtBYPH96gON4b3ZK
         y/nx3DGgu0DagJmDPjd+CsYVIrR/FaKpFuUhRz06I2OdiqwXWIc03Dzs68S58Y5COMiQ
         DOP86dYmlCIGEl8ZdrYlYsa8ufv3Dz5Jp88RjEWB2fsR/l1zwUi6iE8cNpsol2nW+LDt
         xppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211303; x=1782816103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmeP37IwBp2lXb4KPXoA4VMgO0U5ewu/Rz572YER4rM=;
        b=lUzJGcrnQzL6Y14jAjyS4oWLm7jnovphRqbegEXmUoxBEbUxVjFcXxTf7Hp/71w6zs
         tQ2AatQriR74ogXvQqUOmAopB0lp+idjhowtBtb7yycLU+sEOiW216yDDgI+edDQ6bwd
         3b5Qjg6VxzaTZuF47qu6hOC22dciA0EXjuu99iJ83B4EmwunIvJuNMaFZ7DBSXEfOUah
         d9qdSuAS9lRdIQ/RgACDrWCyfBuc4FA3nnFRL4Ucgy7i4/1JlhYY1tPHavJevXou1XXR
         H4o9FvX16Kq0cW9U3dUWKKPP5uuM9cVyY2wt9/0DdwTo+iyeGtEyj2G+HdoArwGy5zV0
         SmJg==
X-Forwarded-Encrypted: i=1; AFNElJ+zmvSOq3T0VcYm/zp6BwCT7eXhme0ROfYK31rUSMCbRQ2DbWqTM64WRrEGPaVYceMGlgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIlqYuzO9ydX5NeFEPKGH8WOor/bx1V5mx/cn9S0TI0QV8ry2
	qwo5pjjNq6hBd2ftSBZUOYYm/ZLQdkHo77AkX0Ccg7NnO7a2fIM3WAcxPGvOUhDA2smNHJcm4xu
	pS+blDVKUQjBDd7FCY7FJcTbzSqgv1kxwvw==
X-Gm-Gg: AfdE7cngV4kt7vgnLGlSqD7grvBF33dNQvB2ywyMAWe/8Lx2Lb5oH3nycCQnmSP2iti
	7ytmouNuIyE4Uf31Qi0tnzI/JsxpSnrNrXdDjSKaYetyNXA1wYyYmFo2kFeh04Er8TAaKO80Wu2
	v93TZpic2GCtCaHbXMqoWWjo/LZdPSyu9G7ieSm8F8KkvNLbg8sTkCGBsFMkX7LUfpZzIU5ceBp
	JDfpOjeYGbyFPjupbeVHmKTBHbFphLPt9/7+dmdoURYnQ1xippbGb+LvGNV4PGHFrOlDzpG0yQv
	yO5pbNk=
X-Received: by 2002:a05:6402:2345:b0:662:ac7e:aac9 with SMTP id
 4fb4d7f45d1cf-697dbac9d99mr1081859a12.20.1782211303175; Tue, 23 Jun 2026
 03:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
 <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com> <ajkijomPo_kXSXul@pks.im>
In-Reply-To: <ajkijomPo_kXSXul@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 23 Jun 2026 12:41:05 +0200
X-Gm-Features: AVVi8CfDTWPeiqX6oycUU1qrUQPdz09_HfNzPv-SpBhtbW7ehPPrzjDcDszRLmQ
Message-ID: <CAHwyqnVV8NB3Njxat8shRi3K11O=Z-kP24rUxnTF3f9wK4BFmA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] history: add squash subcommand to fold a range
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry about that.

I skipped the ancestry question because I felt the implementation
would get too complex and was hoping we could do without it. Probably
would have been better to be explicit about that instead of just
skipping it. I don't want to balloon the code more than necessary, but
I'll take a look at it now.


Harald
