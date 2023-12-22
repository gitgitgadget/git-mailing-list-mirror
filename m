Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE21CA9C
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDPo246R"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-20400d5b54eso1223160fac.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703253909; x=1703858709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRk5tADCmPfly03RRpFfYJfa8YJSE7HpRBczSNoYbN8=;
        b=IDPo246RjjhhlyiDinML+AqK0Rfcf5iCA4nsDIAegpaJzK54eR6G8mjIMMGOYnvtpq
         CnqnqFg+BQl76XwsPURGRu8tgH4pBhvlnJrqrajWd8zKWQavj7oOs7TP4CmRFEYJigpr
         sDikKhhEb/BhoH5vz8hPWT5+2D4EYh17nUDvfgVOxC3Ssig9+BbGiMw7rfMTDXiEXgOJ
         pN8MhRXa5uP0MWRw+OBGqrqwxILEF2KH7VCDK7l1oHY7WTCfbE8nrTEteIIiAe4a4UQj
         PGnEthL2SHwJFJkGgLIoD58rTOECJB8GTJoVoHRxlqVOABk8rnbdikuEgiF1714/f3Os
         ClUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703253909; x=1703858709;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRk5tADCmPfly03RRpFfYJfa8YJSE7HpRBczSNoYbN8=;
        b=ljy+fkCp1Zy3BEjAWrIzucVa9EYVts+37so1kdiAPjVX3rSoGuqYv93TyUfjXLf8DW
         KUTo8racG6r/Ee1g2trK9ZBsbDOPua9epWQITsO42snRAcqvXlqJLeBBEz3WuXK0ZT7g
         NY5JGcpEi3P33dTev9UrC71ytWRuXEDYgdS00lUhUY6qZ7tI0FuoWE/ufKVge0xbUbRb
         fTfmbd1JqCwUA0ftxPNcUgWh1jzcvHKMTLHN5CTiTaGtoZ5/SCDNZ8Z1o0UfcZu8LRZs
         jse+9A0V1GGhuYoEw1plCCXfQQt3Ho08eHkcQdfLXavB8mjgy1nypFfEllyaN3szQgnc
         58mQ==
X-Gm-Message-State: AOJu0Yy5eBe/mWu2DvvRMvr1Q29QB8wdCLr7Rvqb4ghtJFNmdiLeWK3V
	Pf7vEe3r+N+TJEUDxB1PJGqnIpI964JZcilPCMk=
X-Google-Smtp-Source: AGHT+IEQGSbXzZyTeMDeZZn0/oKlImUyxCteSH/vezy3ZIWGnqJmbpyKtyu84hziTzc0JdiRfDf20Bk6d9B9S0yAZEI=
X-Received: by 2002:a05:6870:2326:b0:203:efb2:ee02 with SMTP id
 w38-20020a056870232600b00203efb2ee02mr1523789oao.11.1703253909187; Fri, 22
 Dec 2023 06:05:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 06:05:08 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqzfy3l270.fsf@gitster.g>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com> <xmqqzfy3l270.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 06:05:08 -0800
Message-ID: <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> We have pseudoref (those all caps files outside the refs/ hierarchy)
> as an official term defined in the glossary, and Patrick's reftable
> work based on Han-Wen's work revealed the need to treat FETCH_HEAD
> and MERGE_HEAD as "even more pecurilar than pseudorefs" that need
> different term (tentatively called "special refs").  Please avoid
> coming up with yet another random name "operational" without
> discussing.
>

I totally agree with the term usage and will switch to "pseudorefs".

> With a quick look at the table in this patch, "pseudorefs" appears
> to be the closest word that people are already familiar with, I
> think.  A lot more reasonable thing to do may be to scan the
> $GIT_DIR for files whose name satisfy refs.c:is_pseudoref_syntax()
> and list them, instead of having a hardcoded list of these special
> refs.  In addition, when reftable and other backends that can
> natively store things outside refs/ hierarchy is in use, they ought
> to know what they have so enumerating these would not be an issue
> for them without having such a hardcoded table of names.

Thanks for that, I did play around with trying to find files which
could be refs in the $GIT_DIR, but the issue is that there will be
false positives. e.g. `COMMIT_EDITMSG` could be confused for a
pseudoref (passes is_pseudoref_syntax()) and it could potentially also
contain a commit-ish value.

While you're here, I wonder if you have any thoughts on the last block
of my first mail.

> Over this, I'm also curious on what the mailing list thinks about
> exposing this to the client side. Would an `--all` option for
> git-for-each-ref(1) be sufficient?
>

Thanks
- Karthik
