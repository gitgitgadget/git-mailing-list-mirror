Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB6490BED
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730710; cv=pass; b=K9EKXyWrjrD0fnNOV3u1wq6KVVB336zb/jOEcPP1jIdrqG6X3jtgMTbHV9DsaAlE3se9xpxcPtjeu6VvorY19bt5ljM+OC6K4UoDALpod/65LPwvVdhjQBpJnVIqylWUNNM9oCmgMbCwRY1JgwWhMUFjjmx1QIjILAet2f1qXzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730710; c=relaxed/simple;
	bh=aLYvhSguYHVGngxif8IzGaZCrIbAaUHUdszUHWgfmrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj0+QkOU+JgXldesGIqLMuthOAfB31ZJvXYRaYWKJzFizV/2wgerc6Nhua2N3Q7LvUC6qedpFGsIvPOWgUIyKj3mveIB8FjrF4+lyO64HF+fbrBjo02aIhiwrxST8aMlrJGCFnUcRkR0IqSC7KiChQIEcT3DKnY4EHRYl3nftTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVM3F/XI; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVM3F/XI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso2574943a12.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 11:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786730707; cv=none;
        d=google.com; s=arc-20260327;
        b=lMekuFJb+5S5ZVpYrdkCmxKvfF3zQ49lj9dg2Me3uInakWhYRaFlIZQgR8UtAcK9j6
         PmlJtu9PQGuytYrgdddjx/QaY9iRWpj2Z6BkoScnuRp9xzA61FPKjyEWukuJWMWwd6vn
         D+zK3whHtCcaVc/Epn1ZGet4yoV+S3n1jld3rRbQaQb2SCUOd3w0O65Hi9VwdMHvqPao
         2G1A6ejoN84K5uPSsK9so9mJfTMXtomPUD15gpzYgYcxuukwCyhtDwrDDnVUxqshyZt1
         ez2dXXAI7RTlDKUkUeHxvGM/zG+H8pr/NSPJSV3hSUXv5g66zCz2a7L43zuGSxRvEwCG
         MD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x0ft5004KR8an4vhc5UvI4xDaJzKPohBRADu+LnEuVI=;
        fh=giuKAItk4ay+5J2MxJV7J+Zb3JR1zsrafAWmZXgy3xU=;
        b=FqZ5IgXmGQpu6kUaOOr8ghSWvVpcbg7hZLR1fNBZutxkSUm85j3WOkDewRjwDPtz5a
         94UyF+d61J9KPgvBds2L9ziiHFvW/2ibuTDVh8jEDN254NnP/RFKvuLeGNCGOmOUGNCg
         gU5V1r+lPKhCnfL5EuBr8E+n8yEWBOesgPbaTRAUlqCRlLSqmE981LEsTNde6HkzwF3P
         jR5sYjzAygeVRYCIcPRxNobaRIRDCXM7tS2vuT81Rd5wyb7EIyk+6gKsMzgcNqi/rVGl
         8Y6BJZqVWH4SGeDrdekCwK/QmtFUIj5QiwiAkWDGsuxQpAsFDuMLg2CJfpPcDw0HlTzP
         1/7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730707; x=1787335507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x0ft5004KR8an4vhc5UvI4xDaJzKPohBRADu+LnEuVI=;
        b=ZVM3F/XIOK9OdvjyIRJH2I3oXeGAkN18RCUrOI4oVMTv64t1yk3HkEbL70LO+xf+sR
         Q1uLwLxEkD8LaV0FVN/PWIMudIn7M/+Ui0ijLal8uphAzy7uEKSU2MS9Nc/aZRpc8mG+
         9FyO23aDyOGIXyFvhq4I6rFMLKlp1gTiEjh2fFi7ocT1cADn/fnZDiebm7tYmqy2iVpF
         iBKkax7V7MPZpRTqJlfH6qrIayYiaSh4/MQ9vJkTbp3Qy/CNaf9vx4kEjGMZOHd913OX
         7+5FTEEi1gbrJPIdTaMIQPGTiHBL48iCwmib8X21HQgsf9rdUscLRbiVz9O3L1Zj7Xl8
         ABsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730707; x=1787335507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0ft5004KR8an4vhc5UvI4xDaJzKPohBRADu+LnEuVI=;
        b=j8sxowCRu9uUk7I9PJbpKC8LQU3R8gC+YrdhblPIzokDBItW+V8FntdTZaXW4Wl5Xx
         jPvuvEKrJ92Wn5h522AwIRQa8Nx/QOFSHRi7boesjxCBnYjadJOQ2QwMZcoBb7/eG2Hu
         5/MO1RBIEDnFRB9Hz9JSkrwsKAquyrbO5jFStqeaoFRqyNdOUQMA1UCPXRwPjkzQKP5B
         KMAyPG4dY4bRcHvugd34RVaTPnb2vFAH0gQWJ7sOGhnzRxUjvuNCfFKsdHApjG3MhCyP
         FrFsRWnMWi4oYYli6v1wud25c4WfyQMW4JTCKWvszDujG6Q8pPy6eYclJd9PozkBlvcs
         7imw==
X-Gm-Message-State: AOJu0YxKghMyBlxN/Qx9bqo42S5BAzHkPhpf3nY6CqRNee4dv9mfN0ZG
	MJDJIonV+h/0DtxNWXZrI5kSSIQ67Uzze9RZ7db5nVrwiU+2Lb9yPE/mzejKl4kXK/n5b4xLT6z
	dyjF5BQowbJabRmjXdFNabGfeokaIIj6SKxFhGK8=
X-Gm-Gg: AR+sD12lpDjRdIafRFPZxm5D1MamSblJWhuZ/lDKx+TEgQWmkXAdbRAJ+E4/CjN7zrk
	HUioYP+2y/flIKGa+CAXxtLe9CGP8l0TP675g4G3n8tXFx3hYDE58Jt/QgGX73/LIDp5gf60WFH
	xEjLTp2qy0cLwSng/jDc0I+42Gi7lPSVP5RkyD/F+m54I76f0Fa0qVXc0NUu+yKZpi7JzJgP6FS
	GPSYX1M+HTqK7lq1bGi7Q79cXqVPL1oJiwloS4pNkZza9sOA2gGR0QwL1uTX9KVxY3wfCm/6Fgz
	9VNBImVqJ2aGl3nIrRRT0hwzYwXADDx8H1+To8ZKC/CwsVUTMugG4q4=
X-Received: by 2002:a05:6402:4513:b0:6a0:926e:f907 with SMTP id
 4fb4d7f45d1cf-6a38a8bea9fmr3813832a12.1.1786730706746; Fri, 14 Aug 2026
 11:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
 <an9W4XwY8X4ZFHpA@wyuan.org>
In-Reply-To: <an9W4XwY8X4ZFHpA@wyuan.org>
From: Tilak Raaz <raaztilak07@gmail.com>
Date: Fri, 14 Aug 2026 23:34:54 +0530
X-Gm-Features: AUfX_myRHZ6z6nOoiRKQBi1UGYU3glkDkq8pXeSQexqwc0Ph_nNZOWvZOovNDmc
Message-ID: <CABB4Jh1fUXKNn483FjD2S6U4cYVMEP6z+fjWMi8XRT+NQdNnYw@mail.gmail.com>
Subject: Re: [GSoC PATCH] submodule: warn on valueless active config
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 Weijie Yuan <wy@wyuan.org> wrote:
> Thanks!
>
> However, my suggestion is that it would be better to place your patch in
> the main body of the email text rather than in the attachment.
> Please take a look at Documentation/SubmittingPatches
>
> And it also seems that the automated program 'b4' is unable to recognize
> your patch, which may make the development process less convenient for
> the developers and the maintainer.

Hi Weijie,

Thank you for the quick feedback and for pointing me to the documentation!
I apologize for using an attachment; I am still getting my mailing list wor=
kflow
configured.

Here is the patch provided inline as plain text so that `b4` can parse
it correctly:

From 08a2f244efab6e4cf21638d87a721ca664ed9433 Mon Sep 17 00:00:00 2001
From: tilak-raaz <raaztilak07@gmail.com>
Date: Fri, 14 Aug 2026 22:50:11 +0530
Subject: [GSoC PATCH] submodule: warn on valueless active config

The config parser previously threw a hard error if 'submodule.active'
was provided without a value, causing commands to abort.

Swap repo_config_get_string_multi() to repo_config_get_value_multi()
to parse valueless keys safely, and emit a warning to the user rather
than crashing.

This resolves a NEEDSWORK comment in submodule.c.

Signed-off-by: tilak-raaz <raaztilak07@gmail.com>
---
 submodule.c                | 16 ++++++++--------
 t/t7400-submodule-basic.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5c92575888..b709c429ba 100644
--- a/submodule.c
+++ b/submodule.c
@@ -231,11 +231,7 @@ int
option_parse_recurse_submodules_worktree_updater(const struct option
*opt,
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
-/*
- * NEEDSWORK: Emit a warning if submodule.active exists, but is valueless,
- * ie, the config looks like: "[submodule] active\n".
- * Since that is an invalid pathspec, we should inform the user.
- */
+
 int is_tree_submodule_active(struct repository *repo,
      const struct object_id *treeish_name,
      const char *path)
@@ -261,14 +257,18 @@ int is_tree_submodule_active(struct repository *repo,
  free(key);

  /* submodule.active is set */
- if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
+ if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
  struct pathspec ps;
  struct strvec args =3D STRVEC_INIT;
  const struct string_list_item *item;

  for_each_string_list_item(item, sl) {
- strvec_push(&args, item->string);
- }
+                if (!item->string) {
+                        warning(_("submodule.active is present but
has no value"));
+                        continue;
+                }
+                strvec_push(&args, item->string);
+        }

  parse_pathspec(&ps, 0, 0, NULL, args.v);
  ret =3D match_pathspec(repo->index, &ps, path, strlen(path), 0, NULL, 1);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..afc62ffa0b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1549,4 +1549,15 @@ test_expect_success 'submodule add fails when
name is reused' '
  )
 '

+
+test_expect_success 'warn on valueless submodule.active' '
+        test_when_finished "rm -rf empty-active" &&
+        git init empty-active &&
+        test_commit -C empty-active initial &&
+        git -c protocol.file.allow=3Dalways -C empty-active submodule
add ../empty-active sub &&
+        git -C empty-active config --unset submodule.sub.active &&
+        printf "[submodule]\n\tactive\n" >>empty-active/.git/config &&
+        git -C empty-active submodule status 2>err &&
+        grep "submodule.active is present but has no value" err
+'
 test_done
--=20
2.50.1 (Apple Git-155)


On Fri, Aug 14, 2026 at 11:26=E2=80=AFPM Weijie Yuan <wy@wyuan.org> wrote:
>
> On Fri, Aug 14, 2026 at 11:07:29PM +0530, Tilak Raaz wrote:
> > Hi everyone,
> >
> > My name is Tilak  (he/him), and I am a second-year Electronics and
> > Instrumentation Engineering student at NIT Rourkela. I am preparing to
> > apply for GSoC 2027 and am starting my contributions to Git.
> >
> > Regarding my background with Git: I have built Git from source,
> > successfully
> > navigated the codebase, and tackled the NEEDSWORK comment regarding
> > valueless 'submodule.active' configurations in submodule.c.
> >
> > Below is my microproject patch resolving this issue by switching from
> > repo_config_get_string_multi() to repo_config_get_value_multi() and
> > adding an automated test case in t7400-submodule-basic.sh.
> >
> > I look forward to your feedback!
>
> Thanks!
>
> However, my suggestion is that it would be better to place your patch in
> the main body of the email text rather than in the attachment.
> Please take a look at Documentation/SubmittingPatches [[attachment]]
>
> And it also seems that the automated program 'b4' is unable to recognize
> your patch, which may make the development process less convenient for
> the developers and the maintainer.
>
> $ b4 am https://lore.kernel.org/git/CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8G=
kdhbA1BXe6Okdw@mail.gmail.com/
> Looking up CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail=
.com
> Analyzing 1 messages in the thread
> No patches found.
>
> Please correct me if I'm wrong.
>
> Thanks.
