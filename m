Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345333F8C3
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070536; cv=pass; b=PPKOzd2DW2h6dRlA0eUIbJ+/p1aGD8wjVhjsDVtZ9E68E4MZkfHgcg5bW6bFxPQljsWTaB2TpakQsLtjLf2d+Y69MPxEMqGdz20noD6u8Tjy7ga7Shj08ZVixLB2cb6ybYe+6XYkY/cJ9QiWlLtnBGCT6Fk2DUJ47NAHC7VoYkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070536; c=relaxed/simple;
	bh=ykzQuYrIMTOvMD1+gzyl/X6KEiMdMhyiBZJ3TU411Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHnhLC9KMMwEbyMFpNXKUzy9cg0udwqMRyVJFGuPiVuAlCDiKcQ7IaYCAIJCm0tEjVKacyoP3D4xOQ+09l3KvBeeurW+Jboxjzzdq9ccKJk8SOQoKhL+nFGQ5TS64IbrCisVQtLRtpssZhMzvGAFT9ozrQI1pd/coK930J0MLnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEj5EO71; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEj5EO71"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2a8abac7dso127562e87.3
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 12:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775070531; cv=none;
        d=google.com; s=arc-20240605;
        b=WastrYILZc53u1/r4SivXWxUev2DxMjvDX0j9fOCC59+zS5yQymKisyNL2ntYuzYYs
         Jn8Uo7SGg4p26lVW6D0SS/HewdJnpQG80iDV6nkkA/kxdNWdokp/P1wpOR3yyh0hV44H
         Byl9tk9MJGOlaRJ+v41IYm6JkxxrUAO94ZHJumwof2HNg2UchBml/BepbJvH1/yUXK6o
         poEPAkxj58nd3EkURaTW/FxkmTkNYAVTFkjfUyx15mGX6q7Q/t7dmeeBtnJq1Jl2YLB8
         cczhu2J3wkotBS7gHKNNsgwOBOggTbQxSEMQ8bX6yJfzGesGuDthEygeYnRNVL8ekWUs
         vikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qwvtm0D3EjGvL+XPxmiGRH4rV/H1GZbCSXtJbmk+nA4=;
        fh=mKKDE1BltftIrVGBfZkLs5NTy7eSiPHLeuQL/NjyPzM=;
        b=HKeCcvbXHffWwDYQ6TAjYysrFgvRu8NZFfPEyM/EP2SaR2FVbVx+RNnNyAYEhsXOBe
         3Ah2JfVkwu6FPTl2j/iFM3GNy/dtqDoRiV4063PegARqbqhigZvDwsBjJddLK0ae+r7+
         iOEc6YWNoTJ4e+2G0mCCXcJIDKxer5FRQ1LVWxIYCIqzjnhYSIBy0oK6nrI7ivcN7eNK
         b9qFKoiHPvoselbTudR9NpTdZ97IZSs38o5rRibr5LT5AG3el/lXFvnoH1kt/Y7ZK82l
         olMJ/Z5LYRX55Ex4j0AxNQGxeSjPiWsPe4nia5zfzvU6lTCzlFIc4ZYD7eB9EiHsTILH
         UmMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775070531; x=1775675331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwvtm0D3EjGvL+XPxmiGRH4rV/H1GZbCSXtJbmk+nA4=;
        b=cEj5EO71N11XjKFhSPlE19RrE59X/ih6M9qzg8zyYDKLR2FsmHv4GLoM0PRXjj4TyO
         DhH8k3vYR3LKkWzoy6zs4VkBbfA3/bOQehO+PtLSGPewOdlFGqK7bYeA9bqpz/P+LqNw
         you08fVwsbBccez1/FX75sKk7LviBLgjg4HkQYc28ULYPP4wJdz+Kw/moSNykOC3Ec/x
         rpR3F+HcW8VEw68ufHRDZKMCzIO3T+dpkfH6Tn9KRt15vZiOR46XGWLdkgO1Ac9WdzhZ
         0V4O+33NTVkoGFzHGyjyrq0LCJRsq0clJ7WkMcLUrDGVi/TbPolbEFpmDo7khcxuOjrw
         Z/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070531; x=1775675331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qwvtm0D3EjGvL+XPxmiGRH4rV/H1GZbCSXtJbmk+nA4=;
        b=anADdZHhE9URnjJlsW9iB1mLOEQ2ZYRIWc1x3plofK8tsXxoItqZVojrR8LXJY+74g
         d0pERx7NBd08hXnaD2CBji8Xln1+uZhfWa/BhWNrahoGCplvvhh1SnitUG1/Y1QgcGqR
         T1RN+uKixqvX9stSliJauM/STniFffGjnIsu+HfzCENEcySIG2+B3M0P6zVIvwKdynWT
         OAWfUhyy9TDV6EaPe6w4Iu3D40pbZIgq4anFeGS8Cahj6tV+7SIif8EDHlqi0QWXS/S9
         KR1eo8lET4phpIRN6nYMq+CLBc3G6nrHmsn8HWEQk9L58gYHdET7wcZtFlIQGAR8XcJn
         V9aw==
X-Gm-Message-State: AOJu0Yx/UzEbRqoeIJDK+x/khX3RgTjx2QCIgOiMUhYT+LSqLmgPJ06j
	9XvYA9V/EaDdSrlPDm6DUoQsa4xD4+nzvXEb+T4IQlrCkwh/C6QqwYHKzo+GIgzO1Lx0M84yTDi
	sDgo1KdN2mgS/htqsXo0SZYsjEaQOLp7xcqXrl2o=
X-Gm-Gg: ATEYQzwDHInptAWid4efqxFg+3Acu8tXRLH7kIEEd5K0oO6roMOt3g7xHwQ9zWzIVNd
	1f7QXh8Igvsvpziu9p4V0DogwhKxPNYTUJmHGWaqkmLLEmRXomFhIIs4O4MkSe2WDahFCZIXEoK
	ZdkZUFXDr8HefNEAIhP5cnlyx/owRYoLJBl5lEq4h9hKqx5ztD7whscKypbVMZrwsC2s/HD07fN
	5GCAOciEkkLQibKiZcmwWHr8ZWPbPHWQUCoUjpqUtvAn4e3OlYQxKrBmDzzCI0hIPJ7yKxwil3w
	BYb6vOmrbaUgLBZpZ5GQyVDQOMSiJcC1r7aX0OFaXA==
X-Received: by 2002:a05:6512:2352:b0:5a2:5b88:a8a3 with SMTP id
 2adb3069b0e04-5a2c767ac34mr123750e87.31.1775070530913; Wed, 01 Apr 2026
 12:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
 <20260401190033.11325-1-blindmansion@gmail.com>
In-Reply-To: <20260401190033.11325-1-blindmansion@gmail.com>
From: Blind Mansion <blindmansion@gmail.com>
Date: Wed, 1 Apr 2026 15:08:38 -0400
X-Gm-Features: AQROBzA9CetscuOAXOSnHHSLgSfx6yNP32MjqTS9sDzgLuKO4wbSZMU794e-L6g
Message-ID: <CAEu6FALj=789M=gASYpWT9CGC4_802-X=9sGoF=YndFRCgcb1w@mail.gmail.com>
Subject: Re: [PATCH v2] read-cache: disable renames in add_files_to_cache
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I encountered this bug while doing differential
testing against another implementation, and enjoyed learning more about
this process. I have sent v2 with the metadata fix and test
cleanups you noted.

I also audited nearby callback-driven index refresh/staging paths and did
not find another obvious instance of this specific pattern outside
add_files_to_cache().


On Wed, Apr 1, 2026 at 3:00=E2=80=AFPM Nick Golden <blindmansion@gmail.com>=
 wrote:
>
> add_files_to_cache() refreshes the index from worktree changes and does
> not need rename detection. When unmerged entries and a deleted stage-0
> path are present together, rename detection can pair them and rewrite an
> unmerged diff pair to point at the deleted path.
>
> That later makes "git commit -a" and "git add -u" try to stat the
> deleted path and die with "unable to stat". Disable rename detection in
> this callback-driven staging path and add a regression test covering the
> crash.
>
> Signed-off-by: Nick Golden <blindmansion@gmail.com>
> ---
> Changes since v1:
> - use sed instead of perl in the regression test
> - shorten the sample line content
> - stop asserting that stderr is empty
> - simplify the final ls-files check
> - use real name and add Signed-off-by
>
>  read-cache.c          |  1 +
>  t/t2200-add-update.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 5049f9b..d938abc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -4049,6 +4049,7 @@ int add_files_to_cache(struct repository *repo, con=
st char *prefix,
>         rev.diffopt.format_callback =3D update_callback;
>         rev.diffopt.format_callback_data =3D &data;
>         rev.diffopt.flags.override_submodule_config =3D 1;
> +       rev.diffopt.detect_rename =3D 0; /* staging worktree changes does=
 not need renames */
>         rev.max_count =3D 0; /* do not compare unmerged paths with stage =
#2 */
>
>         /*
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index 06e83d3..0a96655 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -200,6 +200,44 @@ test_expect_success 'add -u resolves unmerged paths'=
 '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'add -u avoids rename pairing on unmerged paths' '
> +       test_create_repo rename-crash &&
> +       (
> +               cd rename-crash &&
> +               test_seq 1 100 |
> +               sed "s/.*/line &: same text/" >conflict.txt &&
> +               cp conflict.txt bystander.txt &&
> +               git add conflict.txt bystander.txt &&
> +               git commit -m "initial: two files with identical content"=
 &&
> +               main_branch=3D$(git symbolic-ref --short HEAD) &&
> +               git checkout -b feature &&
> +               sed "s/^line 50:.*/line 50: FEATURE/" \
> +                       conflict.txt >conflict.txt.tmp &&
> +               mv conflict.txt.tmp conflict.txt &&
> +               git add conflict.txt &&
> +               git commit -m "feature: modify line 50" &&
> +               git checkout "$main_branch" &&
> +               sed "s/^line 50:.*/line 50: MAIN/" \
> +                       conflict.txt >conflict.txt.tmp &&
> +               mv conflict.txt.tmp conflict.txt &&
> +               git add conflict.txt &&
> +               git commit -m "main: modify line 50 differently" &&
> +               test_must_fail git merge feature &&
> +               rm bystander.txt &&
> +               git add -u >out &&
> +               test_must_be_empty out &&
> +               git ls-files -u >actual &&
> +               test_must_be_empty actual &&
> +               git ls-files bystander.txt conflict.txt >actual &&
> +               cat >expect <<-\EOF &&
> +               conflict.txt
> +               EOF
> +               test_cmp expect actual &&
> +               git diff-files --name-only >actual &&
> +               test_must_be_empty actual
> +       )
> +'
> +
>  test_expect_success '"add -u non-existent" should fail' '
>         test_must_fail git add -u non-existent &&
>         git ls-files >actual &&
> --
> 2.53.0
>
