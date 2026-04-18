Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0CA95E
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776475408; cv=pass; b=kE2IQYiB5ukxCfvRJqE25wDJXJaHxAvoJUyPaTVEnCSnPP+z485Qmr2gHDmQHvVGLg2aIDXNQbaUcUa7fC5yTRM5fOdsXn4AbQRS9VGc2OLWVQE3umKcDZdowFJCAdxgECZxgkcuQZ5xhLyZRyysqJUPIIc4pw4nEOqKSs3+cYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776475408; c=relaxed/simple;
	bh=LAOLAwnMXr4dhh+QKE++TN8J4vCs1giyRcN5LCzqEGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k48YzW+PUXaUA42WQi5k4RxftA+Bn9NmyGNRCDYV0EKx9YxAHIrU6t2+JPANtYfDF5fEa7g79vaTu4v5i+DFynrk4FacQaEIStYQi6oSuzGjWOSjGq70fP/1O/vEjOi5Ub8csqlUwuUu/eH/PGLOxctNmHiSUM77Ylsr+QDwKlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrFeomfX; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrFeomfX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab077e3f32so5732395ad.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 18:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776475406; cv=none;
        d=google.com; s=arc-20240605;
        b=QloQrPoWBdCFu1DrGCJO4cDvwOl2OCqCIsUEd+y2jO5ADpRe0APanLnUP3T1j0Gh0j
         7GtlPgkLmn0bd7b4bXxiLz8fEXjsKONsAr0eezyM/DBcPpiZhE4Lxbi9xZja0NV0TQMV
         Gey7LmAz7L1fPhFdsh5ZAptuFtbarb/lr9WOojkvrf+Fl7tl7yOzRAipoaX4ObIG2rep
         tMDJ2/I6TATTwa943gNQ7J2CyAV+/xiYSFda7wijyetWyOjg+XEtHBt3a44IKzd0QoaL
         4iI4rA6zoBk2jUaBZ7fmKVksMZrf8u32SXd+yMt1M/ojmNHQUEhlOZ/X06u6fdIjzuhV
         E7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNIXiVOJKx+6ZXbbjAfcWlzWRYHzmgWeMZqOkN162yA=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=QwMgSA2dP7zYB9fZ/pq0JUqANwJ6wAluiNdYznTLavFYkAQI8KTiE/L7OjsZS4Py/0
         Eqs1rEPHn14/YagAvUa7LD4pjkNy6ZADSMcfkXyJMKqULRoPxQQakfV67F/u4wx14d29
         DIslWye4xopJMWQF4Iguq0twsrZz12gl/HcQ6uCTMVkT8f4w6DHuhTIjCknkAO09a6P+
         s0FS9evh8L932Fmj1RprzI5qQ1XlRTCSgh67uGOWfbY5Rk21PHxI2qEh1DfuAIpzuTdu
         64uW9xLYS01Xxv9ITY1kFt1o0HYM/lJZbE7GsEwzlhbymy/Ht54cRd/RCTw93w3U55qy
         qD8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776475406; x=1777080206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNIXiVOJKx+6ZXbbjAfcWlzWRYHzmgWeMZqOkN162yA=;
        b=hrFeomfXURELD0OwC74ehEx5SKjPYZQVTxdT9sqEy8He2tKDl+TMWBGFFnC4QJRRib
         /f25O/skj+Ek7UsQSYMPGeeOcKSwgeC30GYX6fpQJt7Q7SGEgxBFlfqfZrk2pxIRbhyk
         xSULcBL5qrs2jEeCaqfsgZcTRKnz+r4RONiBYgxl7upFaI0fynbhaUdlcfP2BeqDv5I0
         2bVuKaFXPE87jJ1CkcRqLmDPAAbmzKUBh94pqlQM3B762J9kMGGVX8etCFHR6fHqsq1x
         xrOmqLk76t7xeOIQMUGnc/eEh+PgGPph9HD1pfFZ04nj0RVRqAIT2Ke6IpywY3mERXh/
         xs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776475406; x=1777080206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNIXiVOJKx+6ZXbbjAfcWlzWRYHzmgWeMZqOkN162yA=;
        b=AaAu3DOJJxuEH9HgrRMPAFINM/xMabJ0f2hDkcwMTs5a1E7riTtAkyyVSegMIYKLu6
         rxS5ogsqK8Typz8xNMmYC9ES9Ar4zK5eX9LmxbuXUNgugXVFHZI6FXYZcoyl+M2usLEE
         Jfg8JiW8uDVU9/wegJ6kaASHekM2HUlU/w8VW0ykQdHijFjiwqepWm0EwTZXRYwaJ3/s
         Wjv9uJU1PLkDijC9tEWBlsh1JwVqHMBRpU5/07j3gWuUmUQ4hDtXr0Zy0oSa+TOQyzT0
         Ti8VkaaqAkeDqXtwid/bD1o/QPAJPtFtXEtaSnOxuomvdSVmoqKYRQfmqf/Rpy7G3evy
         5AXw==
X-Gm-Message-State: AOJu0YzgOcuxFp7yHhiSSscE1AD/Airj0YpfQjao8FLRUIh/hzf8xMzp
	XoF63sJk5yh6aECyLF7GXDOr6ZIKVe53Hv9Mobox9c/SE30rpQOBJHSn49kv7LaPvSMRJP4tZX5
	X7k951zuT3oonTdnhZP73CWLOpXAnQ+0r3w==
X-Gm-Gg: AeBDievSP7PIz0cp29m/xSLilybzdnOsOI2ZZjRKhlnriure8igl0GGz6cnDY1W3cYs
	3nnye4vmsd7w9AuyyWddkAJ2VjZt4ruaj9d9fjP1YfgnRYFLsjv7saa40bVWkcDVHrbVA+S6TP1
	3LaNjJlna+ZAKTTnsn2WQUcWZWZcV7r99HIMGl5sJM4DzG4ZLIQfJlISgOYd8Vdjyhcj263FSrF
	oVagV7ipnUyxXKZNm0idsd2jVkROf2ekaty68HK3f59GyRoTYbyfdB09M0tII9zBHeCMOKVt9a3
	D8tjunKOHnGNVcALU0srcDZhRjEjR7Zqe9UAKDEumpoxROLpMPKyYSesD92Yw4xUPC2oWoISBdn
	Hz6pE54nsm33LDXnc3V4wROpofrA/jALMTOX5ouGVCbTm1Ac=
X-Received: by 2002:a17:903:124a:b0:2b2:5515:661c with SMTP id
 d9443c01a7336-2b5f9f61603mr55444205ad.31.1776475406294; Fri, 17 Apr 2026
 18:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im> <20260330-pks-setup-wo-the-repository-v1-15-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-15-0d2e822837aa@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 18:23:13 -0700
X-Gm-Features: AQROBzCEvvDAHAgiMwqKvAO038iT3BafnzngEFhXNKP_1wrmkVItD-ct3bh4hZc
Message-ID: <CABPp-BGHvWxX=g6hT_PKwAwjCAhiz3xOGh9vnWstWcEtyf4sHA@mail.gmail.com>
Subject: Re: [PATCH 15/18] setup: stop using `the_repository` in `check_repository_format()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:19=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Stop using `the_repository` in `check_repository_format()` and instead
> accept the repository as a parameter. The injection of `the_repository`
> is thus bumped one level higher, where callers now pass it in
> explicitly.
>
> Furthermore, the function is never used outside "setup.c". Drop its
> declaration in "setup.h" and make it static. Note that this requires us
> to reorder the function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 58 +++++++++++++++++++++++++++++++++-------------------------
>  setup.h | 10 ----------
>  2 files changed, 33 insertions(+), 35 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 6dbd096f20..c32d6e96bb 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1755,6 +1755,37 @@ enum discovery_result discover_git_directory_reaso=
n(struct strbuf *commondir,
>         return result;
>  }
>
> +/*
> + * Check the repository format version in the path found in repo_get_git=
_dir(the_repository),

Can we make the code comment match the code below, i.e.
   the_repository -> repo
?

> + * and die if it is a version we don't understand. Generally one would
> + * set_git_dir() before calling this, and use it only for "are we in a v=
alid
> + * repo?".
> + *
> + * If successful and fmt is not NULL, fill fmt with data.
> + */
> +static void check_repository_format(struct repository *repo, struct repo=
sitory_format *fmt)
> +{
> +       struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
> +       if (!fmt)
> +               fmt =3D &repo_fmt;
> +       check_repository_format_gently(repo, repo_get_git_dir(repo), fmt,=
 NULL);
