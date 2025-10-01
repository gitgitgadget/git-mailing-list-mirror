Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B62153ED
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332738; cv=none; b=opeerYHvn6JVpXVVIdRCbUxw6k4oJ07PxtLfhu0aZ+pYB/fxywzYriXEoe+vCbM7kItYQwrwMHxDaTNYMjR6sj7W6TkS1IYclcgt0cJ+W6uzMc+HZZPZxbCWaMIS6ebw9IzGhi2EzYV8WlM9sFslnBTsBJGyUkRLMYuEY5oQvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332738; c=relaxed/simple;
	bh=9V8hmonQ72REPVJprEHnBljDHoSMlWTLDxtQALZWTFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWC4P+GdyzXZ8omH7KlouQcggbvE4+1bU8yPAKu3nrxRRDzNbar7XEjnTzkbIN95M6rGHRLHBwyo+yNVCMNtVfcnh5LyHe2HlFuD78NzdqQ+4Y6Qh+Tr17jQIs1zxq4aslu4/gwqjJTrTst+Bcp0BlPkkclzlsTHmqBTeUDt5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzlQnITB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzlQnITB"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63667e8069aso7500a12.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759332735; x=1759937535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V8hmonQ72REPVJprEHnBljDHoSMlWTLDxtQALZWTFE=;
        b=KzlQnITB1lj0crIFYYSEvI8s5N+g/cYoIFSOtFLfggW0l0Mdf9W0xnPf13PwNzg4R+
         utYU6zrqxkdwlutg+iGyyBt+R6nU5N62II7NZgx71s86pVwb0fieJEqm1T553aaIQIBC
         f9V1aiDbZalaZ8KiZFMes5qDsRi5pgBTNCHG+2oQcuonc9p0CEIKSDnfnBhXvxbDv1/q
         nppAcDfpMMM4sTlE8XlM4lgDce7jGFWc5LLht/5KBH5El8m/z/b+lbYLxtYc9V7B2/13
         iWtffOn3peLjermNwzLh1r0i7NhT2h0+RQdaawodb1Yc5W/mWcxER1xFLOaX/FVFAMXh
         nHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332735; x=1759937535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V8hmonQ72REPVJprEHnBljDHoSMlWTLDxtQALZWTFE=;
        b=GV7p92+rfk8YOVRMqFKnr6xDx7oClHn8WzihvYJ457o1oNPFh1k/ecjUjdwZ6DmzRP
         hcekOkKc4GT535wN8TMtLiIeSGsvPCKSAu353qqSyhRhmZdyb90avMPefo6i5ia+Bv4J
         Kev3R4kS3fWR0Eukwo2eYfDRGMsZ0U4rFyrvgZsbBvvSDNhCLMGxdjq4mrxxA3rAfv/1
         Dd078p/woRSiGIcAqRCa4YsLEhh/kLmgbeHZzQsy0BQihc9z0p717ktGrsFPzMEqpi9B
         63NaOx0Exaf+SJOfgLUIu7fyDuz7dKM8Olqd5b/6xLEOsEwIw0EXL7DIKXlXfEc/WbND
         +lFQ==
X-Gm-Message-State: AOJu0YywZo1b7ectPwPjIioGo7bEoDpSDDDkFWyS3a0cyyD/ma0VeXFy
	v28x4tPp6093ixXNhl7x1obBp+soQFrr9MBjYiY5Re94DUvQkSF52ysWraydY8WfDlURs1H1Pf7
	ssBK8x7pfXNWmiVWp4bOveC0IdCiBl+/T25Vqi4A=
X-Gm-Gg: ASbGnctvqYxuK8KeDTAFHUo53MUhyy8lKac/QI3XSRTZIxFNuaqsBosIl7U3eLNHrGD
	eMTI63avEme85dTudy86Za0vW99mnkApW5Wx/1gMBbOzyuSgnHZbHq0UK21bTtxDgoAO/Fh//5G
	GUwSfGf9Rby2eZj1wPf1wVDkRcqb0nhK636GIng1hx2j4t5qz7BhWWzKGasYEzHt+m+Ww01IWJy
	tOLJBJvx/W+3svncPKHDuF++cC+uZw=
X-Google-Smtp-Source: AGHT+IFH5HREnEE2RSGuk/2oq5TGAYdp9aGT6xmYL49tByZzNUzUN2mAQxygsHWBlRpGfKPIv9hjtoDtgRcUW9ki88E=
X-Received: by 2002:a05:6402:26cb:b0:62e:dd2b:b700 with SMTP id
 4fb4d7f45d1cf-63678c06132mr4715217a12.2.1759332735005; Wed, 01 Oct 2025
 08:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNblfuTDdtxLdImC@nand.local>
In-Reply-To: <aNblfuTDdtxLdImC@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 1 Oct 2025 17:32:02 +0200
X-Gm-Features: AS18NWCqife6MXjaRlN7mGUtDdqq-OWm5yJIJpuPIATiF6XqF5p3J-QC23PpNe4
Message-ID: <CAP8UFD1jCRyhN3XH_-WxtCz7sixt+Js_XDFZxkxH9zX2-vZVNw@mail.gmail.com>
Subject: Re: Git / Software Freedom Conservancy status report (2025)
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:12=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:

> ## Expenses
>
> More interesting is where we spent money. Like last year, the biggest
> chunk of our expenses went towards conference travel. We spent more in
> that category than last year (where we spent only $675.96).

I think the $1,846.90 we spent towards conference travel was likely
compensated by Google giving to the project for mentors travelling to
the GSoC mentor Summit. It looks like what Google gives likely goes
into the "Donations" account, so it's not easy to match to the
corresponding expenses.

Outside of the GSoC Mentor Summit, I must say that we have tried to
sponsor people to come to the Git Merge 2025, but the effort we have
made, and we made significantly more effort than previous years on
this, have all failed due to visa issues.

> ## Future expenses?
>
> The project continues to take in a modest but quite healthy amount of
> money, and has very few expenses.
>
> I continue to wonder if there are other ways that we should be spending
> our money. If others have thoughts about what the project should do with
> its money, please feel free to share them.

It has been suggested several times (including last year and this year
during the Contributor's Summit) that we give a good chunk of what we
have (for example 50%) on our bank account to Outreachy's general
fund. This will soon fund contributions to other open source projects
(and perhaps one day to Git if the companies that are currently
donating for the Outreachy interns working on Git stop donating).

In https://lore.kernel.org/git/CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQ=
R7wR1EA@mail.gmail.com/
I have mentioned that Outreachy is navigating significant financial
challenges these days. Here are related links (again):

https://www.outreachy.org/blog/2025-08-14/december-2025-call-for-mentoring-=
organizations/
https://www.outreachy.org/blog/2024-08-14/outreachy-needs-your-help/

Outreachy is part of the Conservancy (https://sfconservancy.org/) like
Git, so I think we should help them as we have no need in the
foreseeable future for the $100k USD we have on our account.

> ### Outreachy
>
> The Git project participates in Outreachy, which is a program that
> provides internships in open-source to anyone from any background who
> faces under-representation, systemic bias, or discrimination in the
> technical industry where they are living.
>
> Outreachy suggests that companies to donate $10k USD per internship they
> want to sponsor (previously this was $8k USD).

On https://www.outreachy.org/docs/community/#funding-requirements they
say it's between $8k and $10k USD per internship:

- $7,000 USD donation towards the Outreachy internship stipend
- $1,000 to $3,000 USD donation towards the Outreachy program activities fu=
nd

> The Git project has
> historically benefited from GitHub and/or GitLab covering these costs
> for us. We may want to consider budgeting for this in the future
> ourselves, in case we want to take on more interns than those companies
> are willing to sponsor.

Let's try again to ask GitLab and GitHub. It has always worked in the
past, so it makes sense to try again. But yeah, if it doesn't work,
the Git project can then donate for the internships. And if we have
donated to the general fund, then we can always ask to benefit from it
instead of donating again.

Note that this year we are likely to have only at most one intern, as
it looks like few people are willing to mentor. This means the average
number of interns we mentor per year is likely to stay close to 1. So
the risk of Git running out of money in the long run due to Outreachy
interns is very low.

Thanks for your hard work on this report!
