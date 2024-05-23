Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB11AD2C
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484193; cv=none; b=j9G7vqm4dLYb4Hpz4TgaOHqAvVe+hlB4eIh+wiO+cG2DvVdCJJYBuBEaREmveGhgEpXpLIsKvODoyuGI+Qrk8e8gCdmvEN6hActccqkNSbzgTsEmIOBQqonVoBHj3oqJWEcu5p8MivIkGQcyVwcWVyVKXXhBcz3Duxiv289RmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484193; c=relaxed/simple;
	bh=QrguL8SZr0IzwPA0CWL6Lqmg/rLG0gMaBL1vR0DF2Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCWfbsDJgreU5rOLqankCSui0BumKggvQ5X37+mP1+X1cy+lm709ZzYHW1EcAcES5GeHWHKeJvfaS5ztu4SxcZqcTMgUL+LUs0FGAGQ9BMUC947xGMakVkyBwr5qmlcVsi8ujYULgnWzgJRkarwcYXFDaX/uaBulcDpxJ6npPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b5254f9c32so2506795eaf.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716484191; x=1717088991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSLvsEn6X2FbWGFb2XAFiCcu4895QfG3lsznCDm3XZA=;
        b=rbsa1lzhnQYrniw+7HGARLq/ZvopBuyQA4J8HrdsXdH6LF0hJFu2C8F7nPIqCFL6Tj
         DikxHRclsLvPOlsNUvk00gwRy9ZHq/9EscdfwfOdQyxNE7xGkbQKwZVVrTK2ZVtl1f2O
         SwEMU06L3zC5eLXBv8DGgIDQ88WSDvAfomfsInAZh/wiggtNlgFIcHj6LgqnN3yO7zMI
         BqUsUQ0YKrPy3tuGABqKafaNULvakrPFMLBqrIbrV3lLOAD+KPRmnr7PD9z2kxX8B/my
         8S9uM3/kKusV3aRsPV4AHJ82CTHbpy3kjdHl61OATCWRHh2dDAfcjs1fAI5QxXVDycIr
         BWnw==
X-Gm-Message-State: AOJu0Yyskbg+4EC8JfYn0wq/MZMHLfvZgQtVEITuWMtcESjWO0g266kq
	5v2Jdwu0u73xzon5QF8tntqiZtGU/Y5JCx8vlc5ms6WohFCw98AZ/2R3MQunkAamMav4vCY2WaV
	mVToB/jbGQL7nL3s9xwg+bQSW2y/TGA==
X-Google-Smtp-Source: AGHT+IGH3BfjuCWrqxVoXjmiFzPa4hnqEDO6qwCzLClDbiA/6rTRZCvsg4UrYGOgnxtR40NkN9EqpU2LfCkMiRLRR8U=
X-Received: by 2002:a05:6358:5917:b0:186:29ce:3982 with SMTP id
 e5c5f4694b2df-197e5466632mr4543855d.24.1716484190689; Thu, 23 May 2024
 10:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716465556.git.ps@pks.im> <c43c93db3bdc0ea5283a6d5c71d37d6fe949dd8c.1716465556.git.ps@pks.im>
In-Reply-To: <c43c93db3bdc0ea5283a6d5c71d37d6fe949dd8c.1716465556.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 13:09:39 -0400
Message-ID: <CAPig+cTKrUL1AzY4Y+M130AvH5S=kSTdwo542T_GdFC=6JUu=Q@mail.gmail.com>
Subject: Re: [PATCH 16/20] strvec: add functions to replace and remove strings
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Add two functions that allow to replace and remove strings contained in
> the strvec. This will be used by a subsequent commit that refactors
> git-mv(1).
> [...]
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/strvec.c b/strvec.c
> @@ -56,6 +56,26 @@ void strvec_pushv(struct strvec *array, const char **i=
tems)
> +const char *strvec_replace(struct strvec *array, size_t idx, const char =
*replacement)
> +{
> +       char *to_free;
> +       if (idx >=3D array->nr)
> +               BUG("index outside of array boundary");
> +       to_free =3D (char *) array->v[idx];
> +       array->v[idx] =3D xstrdup(replacement);
> +       free(to_free);
> +       return array->v[idx];
> +}

The reason you delay calling free() until after xstrdup() is to
protect against the case when `replacement` is a substring of the
string already stored at `v[idx]`, correct?
