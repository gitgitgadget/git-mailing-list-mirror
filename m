Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286E4594C
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661914; cv=none; b=I1lVx6zhhZfPpweMTL1a82WngpGUmsXaVFu2tZmJ+d53iWx13FV7l7Id70iAaZAJ1GXx+0LyI2CwnvMI3NbCj8LMMkzlUEBhPdvhjgid5texEtpP6gUKcIrgdhoc8/sP3dEfElmvOb36hNnqvNFRSHJC2BryVFFPU1Nq7P0iJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661914; c=relaxed/simple;
	bh=IrgpjfM3CpisggmqqGwjG4iLARoQnJ9h00UnZqt2nfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D54KW9bJO6113842sAtnvRjFWheVOo4z1TJTtsDhTfqP+BLMiRBSzXUx/G/tzLw9hnOoQbbQ8kAsARBikpPgG/SvUegL709erx3VbAhLis8Mbe0TDzvTYq8Fy7FWa9W9Tb9AJErrHB0yNmX1q4TBZXUzHdh+OdLQOr69fwe09lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-472967264e7so563465137.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 14:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711661911; x=1712266711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svCaVFOLkh/p/Qu204i0lEhfG7IatWQPVEFiBuZ5QAQ=;
        b=Zrp3nMgHjhbYUg/uWq6I4LXSu5hyxMCKffICTZSSb+4CJ9wsE1G4yAPQnDTcuHGaQ9
         P7pPDK86EDBzckMUooyPC1+Yf2xfYKqvoOVurhX+2cDinXnl1P6fbroI0uP963K7ggk2
         CAWxFdRAnrHpoa1rzVAsQpPxv6BE0LMxYdUMuMQgX+KfJJhmgCxTbXx5Qqa29I7r3c/T
         kirtRvwqRvTHnFrx0GD2OICKcc4KDxmhnRQg7sa3dsytBiDm0puuqbMT25hHE59w+s+r
         z9GRKSfz9kW41+tov2RmfSlFC/66tMjwInusKEAvt46ylmUHU/4KSd5AW1PnYEIBJ5XN
         m1mg==
X-Forwarded-Encrypted: i=1; AJvYcCW729W6yuIn1rFiql7H3txOckTNt0f0LIEnCUSJefGw5hdN5aNdkZUBnIAbSKGmOgeIs1s8fvBGqFLOgdwDKG0rilYZ
X-Gm-Message-State: AOJu0Yw+7Mx4qAXwsmFimXAYVoI5azI06G3roFsDGMtTfEKeoq+5Wl6L
	4vxUjfwAi0pB2sbPFej6bf37bCLz+inDKP6IoQW/fPxeOA/Hs2PJqku+nqMfG+C3Cpm3iXDXuig
	xrRaWAouydYabwuhlAGSw1KJd3y8=
X-Google-Smtp-Source: AGHT+IFQp9CrRtMf9Zz7d20Sst4tJUD89k2kSZ9FGlZdFmumpeygfwQKLSEmIfxGR+IK2MjlAFkRNFt7V+eGsUeMYTM=
X-Received: by 2002:a05:6102:c0a:b0:476:8eed:6737 with SMTP id
 x10-20020a0561020c0a00b004768eed6737mr587289vss.5.1711661909704; Thu, 28 Mar
 2024 14:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com>
 <xmqq7ci6c7mn.fsf@gitster.g> <4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com>
 <25d716fa-bd32-4ff0-20f2-05ff51750911@softwolves.pp.se> <xmqq1q7ygex1.fsf@gitster.g>
 <4727b78c-e45b-da7c-fa6e-85876b50dcde@softwolves.pp.se>
In-Reply-To: <4727b78c-e45b-da7c-fa6e-85876b50dcde@softwolves.pp.se>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Mar 2024 17:38:18 -0400
Message-ID: <CAPig+cSKbGW57dh13T6p20B_EY_C4K=LiQ3TP59wheMSi4qsQA@mail.gmail.com>
Subject: Re: [RFC PATCH] bisect: Honor log.date
To: Peter Krefting <peter@softwolves.pp.se>
Cc: Junio C Hamano <gitster@pobox.com>, 
	"Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:54=E2=80=AFPM Peter Krefting <peter@softwolves.pp=
.se> wrote:
> When bisect finds the target commit to display, it calls git diff-tree
> to do so. This is a plumbing command that is not affected by the user's
> log.date setting. Switch to instead use "git show", which does honor
> it.
>
> Reported-by: Michael Osipov <michael.osipov@innomotics.com>
> Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
> ---
> diff --git a/bisect.c b/bisect.c
> @@ -959,23 +959,19 @@ static enum bisect_error check_good_are_ancestors_o=
f_bad(struct repository *r,
> +       /* Invoke "git show --pretty=3Dmedium --shortstat --no-abbrev-com=
mit --no-patch $object" */
> +       strvec_pushl(&show.args, "show", "--pretty=3Dmedium", "--shortsta=
t", "--no-abbrev-commit", "--no-patch",
> +                    oid_to_hex(&commit->object.oid), NULL);
> +       show.git_cmd =3D 1;

Nit: The comment doesn't tell the reader anything that the code itself
isn't already clearly telling the reader, thus the comment is
redundant and unnecessary. Moreover, the comment is likely to become
outdated when people adjust the code but forget to update the comment.
As such, I'd recommend dropping the comment altogether.
