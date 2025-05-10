Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FED1D86F7
	for <git@vger.kernel.org>; Sat, 10 May 2025 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746856657; cv=none; b=BrFrRiZNDNffUF3iBcwcASxjHpLJlXeWsjjVeLyGLcKxF9P+g3U3lyQcwED8x+mvCZpJa4lalbFWNfzW/bg/J2SwfZRCNkj7XdFhc/iQr8O+L2tAC3gvuQK3FE5ZevEXcrgp133z+XJK0zzr3kjOSF1CvMVqFLIqyIOfExK6hyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746856657; c=relaxed/simple;
	bh=cnCUqZezqjneLENEA16HUckT2PhASDAZTUjQa6n/1eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=trfijbwfm1+CQmRK6y4lvrTiQc49gaNiTT7wADHfrzA1Kjw91OLaoVoXKHaRH9NMWL4C1Tk2qRiHnG6cha26RaKpGVT0ob6baCkpCyCpOTEHmX8SGdGl01JiGanY3dyNAFHWvh7kxQJ2l/m+TItaW/rRbXDPN5LuAFC3p46wGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsyJowMd; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsyJowMd"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-477282401b3so30881161cf.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746856654; x=1747461454; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POztq0kONasQcSvGhDDNfVrcA4Ec9PyBSae+112JuFA=;
        b=UsyJowMd7haMDd/NeKQlEFPD4IEAq37WuMfpBro2ey4o2Gm8W5M50L/VY/dqvwepJX
         cfk1W0QxB2N6Sh4vbqdXCfPp6DL9Eu8l4/y6LUjfEgJdHQjTnbCxdphvlV82oVWTYhFe
         /vV0MKFY24jm3UkljViwc1SP6yLwiCmudyBJsIBbD1POPLcs7QkAWZ8T662/rXe9XSkC
         D+GQKJcRLufhokysiKtst/ocns2RxUdXpkToZrxI/mMTDmji+wfnV+ogEtRSQtTdXmkV
         g25PJTTYc9QzE5eOiCfsfJJytHZJCSymbXceW8hV39Xaga/oC5pAyYpw7iiH4dTi3GUx
         DyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746856654; x=1747461454;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POztq0kONasQcSvGhDDNfVrcA4Ec9PyBSae+112JuFA=;
        b=TEqSoVnyQrL5a0TFptjQ6Vx2L9m7Qz6CVw1ydsC72b9dI+md9rTmV/98KoUldP9ZCn
         Sp42m8XxHYSwOLe0DdHalbZBHcyNVwYnk9pMsuOD4kNTF+YqY510S+XdEjsK2JK4wpxr
         6AnoBr2lOaguY6+fGs7m0+XbKTiBXWVl4CCbG6EzEreTRT4GS1O1oPZtIR4CY/3iYXAV
         GiM+0fkxEtDkVGcQzHqCdjgirH86Xve3izfHiS6Rsqidg6wTL7ueQvlFBdcQS04qC6qs
         d8BwijUzsRB/wStB5dJaPppwHWEPQ9kCWB3bZIvHI27wqyzcAsorUkzKf3mvIUexS2dr
         tJsA==
X-Gm-Message-State: AOJu0YxjsfXjlCaAdZzkA1Crqk0cPOnU6aOW9d3SvUjXCA5KC8lzK4a5
	YpgNAXspPxwYM1C5GaFdVwkKdn+U+jp6hO2kQB2tIt3gTLHgL8k9qu1tYe3/iabswb9bdn1hchM
	ca81nsa13z+o8VYjvBZ5RFKiY0tXz5llli9I=
X-Gm-Gg: ASbGnctl1HnJsaEcBI89ItFkYXSZGmWHM9IqnbAk7fHI0B+rLs8eLNLbf5hPK6MactV
	sHKUlQbBr5Vwlfeb/QOp4WtRQ5R5M2A6z82ZT5mVQLByQ+OOSdVGvrcf3KrKLI2XFHwFSEU8kkx
	R56qvFO7nIguiN/aOAGozvbKt+t9JFi7gjIs/wiOcJbObKJWXyAN5vfwEry2z//tC0mITjEsArr
	hs=
X-Google-Smtp-Source: AGHT+IHgmG+hx2aQ36rcgeftTdG3U/RXUxgZ9c8AdxRYZbsTHse8sxO+fJR8m6zzX2Hflte2Eb0aKLXjvrV/RPA7RWo=
X-Received: by 2002:ac8:5a4a:0:b0:48e:5cda:f73c with SMTP id
 d75a77b69052e-494527f3dd8mr71495501cf.48.1746856654320; Fri, 09 May 2025
 22:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510054542.556401-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250510054542.556401-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 10 May 2025 11:27:22 +0530
X-Gm-Features: ATxdqUH7Pf3jsj6UKK7b2RBnPGkH0whgEEk1IFCu75leNyi6E0gnItLAhPOt1u4
Message-ID: <CA+rGoLc=S44mHwc-ZpagwfAo=V-BjcX58HCaQDn1fBJcknQ4Vw@mail.gmail.com>
Subject: Re: [PATCH] submodule: prevent overwriting .gitmodules entry on path reuse
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +++ b/builtin/submodule--helper.c
> @@ -32,6 +32,8 @@
>  #include "advice.h"
>  #include "branch.h"
>  #include "list-objects-filter-options.h"
> +#include "wildmatch.h"
> +
>
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
> @@ -3323,6 +3325,23 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
>         return ret;
>  }
>
> +static int submodule_active_matches_path(const char *path)
> +{
> +       const struct string_list *values;
> +       size_t i;
> +
> +       if (git_config_get_string_multi("submodule.active", &values))
> +               return 0;
> +
> +       for (i = 0; i < values->nr; i++) {
> +               const char *pat = values->items[i].string;
> +               if (!wildmatch(pat, path, 0))
> +                       return 1;
> +       }
> +
> +       return 0;
> +}
> +
>


I added this change in the same patch because
t7413 was throwing errors at these specific lines of code
I don't really have full understanding of these files yet
but after this t7413 perfectly passed all the tests

I tried these changed because there was a comment about this in the file

/*
* NEEDSWORK: In a multi-working-tree world this needs to be
* set in the per-worktree config.
*/
/*
* NEEDSWORK: In the longer run, we need to get rid of this
* pattern of querying "submodule.active" before calling
* is_submodule_active(), since that function needs to find
* out the value of "submodule.active" again anyway.
*/


I can separate it into different patches if there is a requirement.
Or change based on the feedback.

-Jayatheerth
