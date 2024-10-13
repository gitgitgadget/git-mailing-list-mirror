Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0952907
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728812576; cv=none; b=ANk2BV35O+7uJHZxV/0I4TjSlBQkTICBMXUAUAWMCnvJHt7xYzY0rmec6S+yXZcSmqv1kS4Pm52QM7q4ZVjuaY93CiHSa7MPgy5e63Npg6gRKF3N1jRtKNKaWTAcFgbEvHnVWUDK84SFSIIc0zbO53SUTu9IMMaXLden2gWif1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728812576; c=relaxed/simple;
	bh=RyU8ci2R8ozZGYlunVe4kqDzKW5GiOONow0YRED7GeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppZo4xEHrRf5MthMX6bQCoEzkBFOJUdMCoAUw1grYrI+hrVZz9VS7C+fTHs//sQCizJ45wMYypFqxm3JVWDC9gqSMEnJ8PT4yuwtlYDxfES1ZsyuaOrCZ+V/woaCySXb4b4ilXLgeD0wL2ugzi5LWOGlY+Ic4WnK6IVcgNYAnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APzjrf/c; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APzjrf/c"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d4a333a87so116560e0c.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728812573; x=1729417373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irTZsnqWukThvTZaiSGo+eS51Y3E+DCy38F4y3IMUpY=;
        b=APzjrf/cLv9npsE86HAUFafF4D/FsZSvG5ygwyeqmoXgR/tLVGtyG76EyF4EJKyI52
         EQAp+nGCKNBsoiOTGl3ol1UWdPMjPha378UclrLRC7oCGPaQYypMWvL1x5NqWkyMEaMR
         ylnqmjbXvj2ErZ2J66jt1HRg+ncLe/+mobSSxwQZ0+nmDq3KmAVry+7GnfPTPNXM/8Df
         8PXGzXlXLePVlYQiA1DuleUMIPGJiTKIyJoiON8pfMQYwJMrCxd3TaEjkz99e7wFL/pW
         LIMPFD4zkKWokjzetUkUywIzBRVuT8nXV4EYcecg/2yHnz4kriPN6qbn0GIKm61V93Ma
         +QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728812573; x=1729417373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irTZsnqWukThvTZaiSGo+eS51Y3E+DCy38F4y3IMUpY=;
        b=M+hfG5WKzjK4luVX2CFY4rt55YYEoQt4OswNCSdwuckeecVCJx0FyfuqtdqQKZ2pFe
         sRQtl6fLa5jPmTylC7BKD9B1WehwvP7T6zwi5shPYdlRIO/YuYopSqBBXc+JbbOa8Rwd
         c7w0IG+cXdYEsig4xC74YhunRZirMlVwIAtoiq3NsFz+Y0qvvbASmcU2Mls+C98fu6fF
         PuruzCEGTytVkdaV3ObdHnYfcfhABMQaFbxZGKKVguOFOSxkFZ96jzTr40VyDNZVA+ai
         9GumfLS461ehcQrUYjvj7Lj18Reu40U7LD9ilD2IdG+ts/U7EoPniWU8hPWZFmGDjUli
         L68w==
X-Gm-Message-State: AOJu0YxRrJNVkuuc3Cd/5MvD08zmzc1wjp6NuaxC6K7QIpalvc999kpt
	u5syZJ0hOHUGRAvKNXoBIt0JmDD1PB6nWbzV9IkzVw6GQ5SmRKvbszOJO4Y0GNYjWgawtH7btJT
	M6zgH4tFDfv/bA6S9mJ+zxlpjCbvLKIzYGko=
X-Google-Smtp-Source: AGHT+IGbKoQF3jd+Sy3DYBAhk1ykTXt5dJXAs13SLdWdj46Ysed6FeBCxY8mk1u0WCgp4ki92jLOXQdL85qRZRdpy3Y=
X-Received: by 2002:a05:6102:1620:b0:4a3:cf4f:e19 with SMTP id
 ada2fe7eead31-4a475ff79edmr2841037137.24.1728812572887; Sun, 13 Oct 2024
 02:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com> <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
In-Reply-To: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 13 Oct 2024 09:42:41 +0000
Message-ID: <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 11:09=E2=80=AFPM Usman Akinyemi via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> and strtol_i() for signed integers across multiple files. This change
> improves error handling and prevents potential integer overflow issues.
>
> The following files were updated:
> - daemon.c: Update parsing of --timeout, --init-timeout, and
>   --max-connections
> - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
>   tags
> - merge-ll.c: Enhance parsing of marker size in ll_merge and
>   ll_merge_marker_size
>
> This change allows for better error detection when parsing integer
> values from command-line arguments and IMAP responses, making the code
> more robust and secure.
>
> This is a #leftoverbit discussed here:
>  https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzdAaa5=
CGTNGFE7hQ@mail.gmail.com/
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Cc: gitster@pobox.com
> Cc: Patrick Steinhardt <ps@pks.im>
> Cc: phillip.wood123@gmail.com
> Cc: Christian Couder <christian.couder@gmail.com>
> Cc: Eric Sunshine <sunshine@sunshineco.com>
> Cc: Taylor Blau <me@ttaylorr.com>
> ---
>  daemon.c    | 14 +++++++++-----
>  imap-send.c | 13 ++++++++-----
>  merge-ll.c  |  6 ++----
>  3 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index cb946e3c95f..3fdb6e83c40 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
>                         continue;
>                 }
>                 if (skip_prefix(arg, "--timeout=3D", &v)) {
> -                       timeout =3D atoi(v);
> +                       if (strtoul_ui(v, 10, &timeout) < 0) {
> +                               die("'%s': not a valid integer for --time=
out", v);
> +                       }
>                         continue;
>                 }
>                 if (skip_prefix(arg, "--init-timeout=3D", &v)) {
> -                       init_timeout =3D atoi(v);
> +                       if (strtoul_ui(v, 10, &init_timeout) < 0) {
> +                               die("'%s': not a valid integer for --init=
-timeout", v);
> +                       }
>                         continue;
>                 }
>                 if (skip_prefix(arg, "--max-connections=3D", &v)) {
> -                       max_connections =3D atoi(v);
> -                       if (max_connections < 0)
> -                               max_connections =3D 0;            /* unli=
mited */
> +                       if (strtol_i(v, 10, &max_connections) !=3D 0 || m=
ax_connections < 0) {
> +                               max_connections =3D 0;  /* unlimited */
> +                       }
>                         continue;
>                 }
>                 if (!strcmp(arg, "--strict-paths")) {
> diff --git a/imap-send.c b/imap-send.c
> index ec68a066877..33b74dfded7 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *c=
tx, struct imap_cmd_cb *cb,
>                 return RESP_BAD;
>         }
>         if (!strcmp("UIDVALIDITY", arg)) {
> -               if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg))) {
> +               if (!(arg =3D next_arg(&s)) || strtol_i(arg, 10, &ctx->ui=
dvalidity) !=3D 0) {
>                         fprintf(stderr, "IMAP error: malformed UIDVALIDIT=
Y status\n");
>                         return RESP_BAD;
>                 }
>         } else if (!strcmp("UIDNEXT", arg)) {
> -               if (!(arg =3D next_arg(&s)) || !(imap->uidnext =3D atoi(a=
rg))) {
> +               if (!(arg =3D next_arg(&s)) || strtol_i(arg, 10, &imap->u=
idnext) !=3D 0) {
>                         fprintf(stderr, "IMAP error: malformed NEXTUID st=
atus\n");
>                         return RESP_BAD;
>                 }
> @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx=
, struct imap_cmd_cb *cb,
>                 for (; isspace((unsigned char)*p); p++);
>                 fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
>         } else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
> -               if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg)) ||
> -                   !(arg =3D next_arg(&s)) || !(*(int *)cb->ctx =3D atoi=
(arg))) {
> +               if (!(arg =3D next_arg(&s)) || (strtol_i(arg, 10, &ctx->u=
idvalidity) !=3D 0) ||
> +                       !(arg =3D next_arg(&s)) || (strtol_i(arg, 10, (in=
t *)cb->ctx) !=3D 0)) {
>                         fprintf(stderr, "IMAP error: malformed APPENDUID =
status\n");
>                         return RESP_BAD;
>                 }
> @@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, st=
ruct imap_cmd *tcmd)
>                         if (!tcmd)
>                                 return DRV_OK;
>                 } else {
> -                       tag =3D atoi(arg);
> +                       if (strtol_i(arg, 10, &tag) !=3D 0) {
> +                               fprintf(stderr, "IMAP error: malformed ta=
g %s\n", arg);
> +                               return RESP_BAD;
> +                       }
>                         for (pcmdp =3D &imap->in_progress; (cmdp =3D *pcm=
dp); pcmdp =3D &cmdp->next)
>                                 if (cmdp->tag =3D=3D tag)
>                                         goto gottag;
> diff --git a/merge-ll.c b/merge-ll.c
> index 8e63071922b..2bfee0f2c6b 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -427,8 +427,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>         git_check_attr(istate, path, check);
>         ll_driver_name =3D check->items[0].value;
>         if (check->items[1].value) {
> -               marker_size =3D atoi(check->items[1].value);
> -               if (marker_size <=3D 0)
> +               if (strtol_i(check->items[1].value, 10, &marker_size) !=
=3D 0 || marker_size <=3D 0)
>                         marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE;
>         }
>         driver =3D find_ll_merge_driver(ll_driver_name);
> @@ -454,8 +453,7 @@ int ll_merge_marker_size(struct index_state *istate, =
const char *path)
>                 check =3D attr_check_initl("conflict-marker-size", NULL);
>         git_check_attr(istate, path, check);
>         if (check->items[0].value) {
> -               marker_size =3D atoi(check->items[0].value);
> -               if (marker_size <=3D 0)
> +               if (strtol_i(check->items[0].value, 10, &marker_size) !=
=3D 0 || marker_size <=3D 0)
>                         marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE;
>         }
>         return marker_size;
> --
> gitgitgadget

I also want to ask if this is the right way to send another patch as I
noticed that it is showing my previous patch which is not related to
this. Thank you.
