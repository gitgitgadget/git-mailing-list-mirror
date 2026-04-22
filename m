Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB242AE8D
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817950; cv=pass; b=u/lrrj0RPBhnO/Fkj1djmcG5mg/4oSsJvcWc4VVVPidcoEg1e83ypWLlFPxL4r8YyM6HSj31XpFbxhUcMYIk7DX+X8D0eo5I840ZSCtXAuKR7RTvb18mqlURspajQ37zL0+W6K7tVaVeXb/zN4HFSy4HfmJGzrjT1hY2d4sT7kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817950; c=relaxed/simple;
	bh=JNyooS4YoHDRBLQKQYnBlXsk0/ujv4yiNPZiB7eKoWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdSxXrxdMJ8bNJCD/0gUZVuUJOw/b9GM2G7OMfxRKlLluzL2uxX0hsNVDrrl0yFej0Eh0jIl8ioQByStmTAIuoWWqunw3fYEpXL4QeiOHIYshaT4/0W0eIwgUUWZ70czOPzQGxiXqv0KX3mAaTawsBXirIMXEh1U+/ZHstrN3bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYOUOWgU; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYOUOWgU"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d55b97f358so3044996a34.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 17:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776817947; cv=none;
        d=google.com; s=arc-20240605;
        b=GD878j3FiaAsB12b5qxUVWw3/0nlO4Uy5SS9B/gzJPboZpR7zjRc0IJ5Jf9/b64h76
         0mOG7+3KfRcr+BK24TT9xiBqGgbYsNsb01g0+wTmF5kJWxp8m3N8uX3n2LsIONUaqu8l
         pFjE5qHds4/rBaSzg2+98BWcrHXgeKvspjXMe/xLNuGMyl4KQRX+TXLGmksE26ogfvVY
         mHcZPUAawMnV5FJZqUPPO4hxvtlXD2AkMKsLMJOovgpmbaivGUEXdarpPlFpXoKEQYAY
         ZXt6RpsgzS1RjJQL9A0kB6Aw/agU5p4d9MnTYzn3w45tSprMkz91FK7uD2CmnjPTvLbk
         zjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PKjvLBKQ7yERHEQ/ebstiK022Sj/W3x+fTmesS4mQU=;
        fh=SA66t81nxC4XQU/4vrl+WCXkowt3lMvgIejciFJn/Lw=;
        b=P5eMH5uoYz61o+440ONvTnsftavsWXpSCu5OrzT9qfsqFdWfsGQgV6G2rOerHjulPC
         YPoTHpwBpHEEaVytbIhtaOn3ng2Gj8XcagbL3ZukzMwaQXjAGcegXzo+oW9FmtELLtiK
         5ghdd+WMijCYOj5YOBcCmei1nVRR2928oXDJFqQ+iT7QPKnRnLpS/tLLjBb+mvt/Oijv
         yK82HPti0l8X+4Yf2MvtCklWkGAjry1PvHtCwpLanTxGQGjMyIZag/i3URUBGPaN+QPa
         e2ibYd9Z7/BvOjs535hijujiGuF3+Omuw77GIqvguv5/zLGltueTz36hC4ZO8m8gNvyG
         CrIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776817947; x=1777422747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PKjvLBKQ7yERHEQ/ebstiK022Sj/W3x+fTmesS4mQU=;
        b=AYOUOWgUv1ZaAxiHuroYsKUsdxoAs84cYjAFaAdP5036lzvqvX3KiSDoDDuNYxK0rc
         VUByGVsUxd9itH5qJlAWSWoS/7DaFusc7T77Ik0tIMgLeZwzCfsJIyLCiUnFPt2gZh4M
         nT8+hFL1paQQWxaxnmGeV9s4KehG/idjnPQe0HlP8yqOF7Set1zqr5EGg+0/i82tusf8
         cQCIbBGY7vQq3B+Y8vOA/y/o9yXDltqg1wKZo9/aynasDN9utwkOkcAJiD6jUuFGV3MQ
         aNEuxw4fz/SS02P3dR5GxV9ZU4MKeh4wQiIiWuvsmKYQPLZ5/nI96wKDPCwLPzjYedFx
         Y6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817947; x=1777422747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PKjvLBKQ7yERHEQ/ebstiK022Sj/W3x+fTmesS4mQU=;
        b=ZCW/Ntq84IkS6RMAZyiPWMTznEm8A0DGbHQs2YCNV7xy//SpWc4hkzEbso2ekcKmv2
         WV+nTRUmn+rtIWrVQ1W9Nvl7ZiRAQectu/iTTQNufUcDLui23NAbmjR14e9P79q0VwRq
         QuDP8tVSExSjOEcE33vyZAxNlmzVAqLN/VqqCy6U3v821kEec8daIbslOkSLN4E3JzxO
         YZfkyrybItVwB4SUuL92I407DANAvrkBaSKgpOE4ijMZeZ+vIVp5xl2NosNR39AETVQi
         uYvDGDjXqP7iC1M70n7q9fbD9AgfD7urZN96S0brixJT+Eiru5QsGq59/CDUpDX4pbBr
         V52w==
X-Gm-Message-State: AOJu0YwpOgkCahjcN23/Ce0WqLukfgs9tphqrPbjm85X7/W7NwW7zqeW
	Qr8eOkXEaZ1Gsr9Ielh0f1mGDLYEFMglmjSVgxbAebFYAgoS/6Crp3UU0jt6bEgg9xgaqv43Uk2
	liSbt/ReKzEz/r8DO9Xcvz21+AOA+Lvk=
X-Gm-Gg: AeBDies7/IpDd0huK/AQikDwuJfHTpgeuiFLR/4MCTEuI2YpRU1xAti5V2q0ZNNibgD
	ShwYIrInUE3V5Wi4WZa/GUQoACNfsG6+QaphguTJiSvYAt40RUNEHcZmmTjFBnY8VoXrDZ5bozk
	XSxBN32LeI3FWWWOYxq9OyA/UQYMxCKU6KGZJmk2IYPYhfLpbGaUVoFPQHDENUiVKNECryw3LZf
	2FTpZBa75iUs0a6s/i8oAU3TRyfvGpXkxHSSsXEpwOWCKr0fT5ykzI6o8laoEJXrmKBW1kvfsno
	9rAjEVHCfkqL6YRx/OodIzuyo+Q0jrE/yjTUz6tj9QD0zhRgNhaOzMQYkXd4sZDQ5uXRORxGFKo
	73ViSv5IlTK54kLS+IjCJ5klebFYnvt3wN73tLA==
X-Received: by 2002:a05:6820:f0c:b0:694:a1d0:113b with SMTP id
 006d021491bc7-694a1d0157cmr1323221eaf.50.1776817947404; Tue, 21 Apr 2026
 17:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk> <3d5135a719221031e50ad8067ff42740a3bbce0c.1776697483.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <3d5135a719221031e50ad8067ff42740a3bbce0c.1776697483.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 21 Apr 2026 17:32:16 -0700
X-Gm-Features: AQROBzDEs07rahHKfpGxgcOxxNTCMvbA-qWd93uRfcg22q_9iahpUp-y5bFhNak
Message-ID: <CABPp-BGrRehYkox__=VYVqgViuyjRft_VGiaST+nrjbV7H8PPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out parsing of todo commands
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:41=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Move the code that parses todo commands into a separate function so that
> it can be shared with "git status" in the next commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 45 ++++++++++++++++++++++++++++++---------------
>  sequencer.h |  1 +
>  2 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..b8e860434a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2625,6 +2625,27 @@ static int is_command(enum todo_command command, c=
onst char **bol)
>                 return 1;
>         }
>         return 0;
> +}
> +
> +bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd=
)
> +{
> +       const char *s =3D *p;
> +
> +       for (int i =3D 0; i < TODO_COMMENT; i++)
> +               if (is_command(i, p)) {
> +                       *cmd =3D i;
> +                       return true;
> +               }
> +
> +       if (starts_with(s, comment_line_str)) {
> +               *cmd =3D TODO_COMMENT;
> +               return true;
> +       } else if (s[0] =3D=3D '\n' || (s[0] =3D=3D '\r' && s[1] =3D=3D '=
\n') || !s[0]) {
> +               *cmd =3D TODO_COMMENT;
> +               return true;
> +       }
> +
> +       return false;
>  }

Since *p will be advanced by this function, perhaps it's worth a quick
comment before the function explaining how it advances?

>
>  static int check_label_or_ref_arg(enum todo_command command, const char =
*arg)
> @@ -2716,29 +2737,23 @@ static int parse_insn_line(struct repository *r, =
struct replay_opts *opts,
>  {
>         struct object_id commit_oid;
>         char *end_of_object_name;
> -       int i, saved, status, padding;
> +       int saved, status, padding;
>
>         item->flags =3D 0;
>
>         /* left-trim */
>         bol +=3D strspn(bol, " \t");
>
> -       if (bol =3D=3D eol || *bol =3D=3D '\r' || starts_with_mem(bol, eo=
l - bol, comment_line_str)) {
> -               item->command =3D TODO_COMMENT;
> -               item->commit =3D NULL;
> -               item->arg_offset =3D bol - buf;
> -               item->arg_len =3D eol - bol;
> -               return 0;
> -       }
> -
> -       for (i =3D 0; i < TODO_COMMENT; i++)
> -               if (is_command(i, &bol)) {
> -                       item->command =3D i;
> -                       break;
> -               }
> -       if (i >=3D TODO_COMMENT)
> +       if (!sequencer_parse_todo_command(&bol, &item->command))
>                 return error(_("invalid command '%.*s'"),
>                              (int)strcspn(bol, " \t\r\n"), bol);
> +
> +       if (item->command =3D=3D TODO_COMMENT) {
> +               item->commit =3D NULL;
> +               item->arg_offset =3D bol - buf;
> +               item->arg_len =3D eol - bol;
> +               return 0;
> +       }

The commit message says it's just moving code, but are there some
subtle changes?  It switches the order of parsing commands and
comments, which I think doesn't matter.  I think the previous code
would treat a bare carriage return not immediately followed by a
newline as the start of a comment, whereas the new code only handles
carriage return immediately followed by a newline as the start of a
comment.  I don't think that matters in practice, and was potentially
buggy before, but feels like the commit message isn't quite telling
the whole story.  Maybe it's worth calling out the minor but harmless
tweaks in the commit message?


>         /* Eat up extra spaces/ tabs before object name */
>         padding =3D strspn(bol, " \t");
> diff --git a/sequencer.h b/sequencer.h
> index a6fa670c7c..20f6fac48a 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -262,6 +262,7 @@ int read_author_script(const char *path, char **name,=
 char **email, char **date,
>  int write_basic_state(struct replay_opts *opts, const char *head_name,
>                       struct commit *onto, const struct object_id *orig_h=
ead);
>  void sequencer_post_commit_cleanup(struct repository *r, int verbose);
> +bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd=
);
>  int sequencer_get_last_command(struct repository* r,
>                                enum replay_action *action);
>  int sequencer_determine_whence(struct repository *r, enum commit_whence =
*whence);
> --
> 2.54.0.rc1.174.gd833f386ac5.dirty

Otherwise, looks good.
