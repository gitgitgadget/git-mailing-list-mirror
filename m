Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36035959
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754432573; cv=none; b=XrbDGuSmn0yD+P33M+BL1+qNqhjyabVIzlFQ4Z3ZaYgIDDTS+1AeTTJsrF/n23x5MDUti8vxg72gGZpsEVQQzGaOgXg/MeJT0xhjp0QMrWQAJXizSUER6Gw/4P6dZQQJ6PHcd1NE4XV073kHObFYaH5ZOC4SAs+8iJ9/Th6g+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754432573; c=relaxed/simple;
	bh=asUCL5JCflOx6cgC7bNg6ijY3xLYT0VHEp9Y5LL4JUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSGpQZfPM04CgUAzkmtvNObF86kc+t239fhqfzUN8cCVH3cL3xpEcOSXjzwmoQlG1E6FRlLODADHlLRNuhVKlzggwO+nBX9OfnNSSlj9C149CqHDbAGnL9GNX7mbr6ECWKUdEJKCXszTdi0CBseVawBQGALK2o7/DamVLg9Do8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkBqdvIB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkBqdvIB"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e3f1e69090so19214045ab.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754432571; x=1755037371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO9urNSoI2mVgnNzMasXJQmx+p18e0o1SVQ0nJ80a6M=;
        b=FkBqdvIBg+onFqopNIHU8vxoXpkRmEDULgFlr2LIE7aSy/sX6G43HU4nSDo79a1mSH
         ZvQIe8SL7xago+kQmAPYu7JzCHr9+LNSroWpWa/QL/k2Xh4ORq+8UYZTvoge+fHgJkXP
         WNlbn6Fvb7PIjzMD0KU9S7U+T6kGmKqQNXS2Wu6nrGdBGg+xeBAbJo8AKpJYx/aGJNa5
         YXFQVShTTWh3/zxfYRBRLLfQbx9oaryD2VBBHqqRfLYj9NvIQDsdYMlMqMdNjbPCU9yu
         HfphNyn6okivAp/tSo3BHVV//SX1gPfQ3wZbkYuQEot5lLoxHr7emMbyRRha6y/N+y8Y
         3Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754432571; x=1755037371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO9urNSoI2mVgnNzMasXJQmx+p18e0o1SVQ0nJ80a6M=;
        b=c6Izz4X8GhYbl35MjbpEZznpBJRSpIomevz/0jWMoXnyTB8hc2xn9BEsEXTWX9xGNP
         X/EtRYUluRadEIZKB9oAyIxJF04YO3f3ytjLffqmCEWdlunLweAI+IH0IjRhIQc6sy5v
         xoT1PTRF6SVnngg9dDvxXOQY9FxfRW2WYxZ0garJXAaVaAvTeZYc/jI+RUWPu5elrk7Z
         K1LiM6qeK56v30qC/UiZrmVb/Mj7dKzFnwc2tburoTtZhkKyZpIiDR3e0aHl347vh75o
         8tCLxV3gi3QUr4C1E1RFVP04rJ5h2+OEqmYhanrRzYygGWFWYbFYpjjXu/JCUZYT95OU
         Otpg==
X-Gm-Message-State: AOJu0YxVZi0BE3ZmwxW31VvDGo9UnXLXFv+7E5oGS/qxzqAbVV4vue2O
	cGDJC2pQgLalQW5yapxkufytCn7QLuH1Af0WKkBvqXlT8cpeyiL65ZkaGBrwxdgK5Mqm0EmKRLT
	n+R/fpRlaQ/xuyq3SMr1oYNcPOuir67nskQ==
X-Gm-Gg: ASbGncvb/FxGApw/l7g2ORPPJ3JNjqKdvfwCSNo6PH42+MeLrdcqVO7LC6GVdAm9Lsa
	M8gVNT4q/q/BiMMn5uNtHBmy965MbEN7hACKpdCwvpLGRfK/9u3LdA2oIV16n9QeWkG4Y0oJ+Sy
	NjG9HMScQsXmuGbZKfDE34rpTMRfpN2JYaf6X2m9o2vQhcUcNEJGxz1dHtfNEvb890OskrcrKwd
	fmn3U3whiT3j0C0ab0jMhP0/me8EaCPtmg5ub53
X-Google-Smtp-Source: AGHT+IFkxtReNGvlmNDILuQPGVh4nnBskAohHMrTO1tWe2Mb6H/QngwaXYSKecUal8RG3ukOroSS9zmTEKRQEq734ZU=
X-Received: by 2002:a05:6e02:1887:b0:3e3:e75b:fd83 with SMTP id
 e9e14a558f8ab-3e51b8a2f34mr4879725ab.8.1754432570964; Tue, 05 Aug 2025
 15:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <fd9a20a392265a5aaed27301a3b324164bb0af86.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <fd9a20a392265a5aaed27301a3b324164bb0af86.1752716054.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 15:22:39 -0700
X-Gm-Features: Ac12FXx6QLtBCEsY43VTtyvLqn5M9IeuT7_dHsWPaWYhjdkMIzXhRV407yeY6XI
Message-ID: <CABPp-BEEr=pcF4ySreK4MeVUZ-L+HeCCKbZ=a0R+AkAVCqgFJw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dir: add generic "walk all files" helper
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:34=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> There is sometimes a need to visit every file within a directory,
> recursively. The main example is remove_dir_recursively(), though it has
> some extra flags that make it want to iterate over paths in a custom
> way. There is also the fill_directory() approach but that involves an
> index and a pathspec.
>
> This change adds a new for_each_file_in_dir() method that will be
> helpful in the next change.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  dir.c | 28 ++++++++++++++++++++++++++++
>  dir.h | 14 ++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index d2b0a5aef670..2e567ff92746 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -30,6 +30,7 @@
>  #include "read-cache-ll.h"
>  #include "setup.h"
>  #include "sparse-index.h"
> +#include "strbuf.h"
>  #include "submodule-config.h"
>  #include "symlinks.h"
>  #include "trace2.h"
> @@ -87,6 +88,33 @@ struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
>         return e;
>  }
>
> +int for_each_file_in_dir(struct strbuf *path, file_iterator fn, const vo=
id *data)
> +{
> +       struct dirent *e;
> +       int res =3D 0;
> +       size_t baselen =3D path->len;
> +       DIR *dir =3D opendir(path->buf);
> +
> +       if (!dir)
> +               return 0;
> +
> +       while (!res && (e =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL=
) {
> +               unsigned char dtype =3D get_dtype(e, path, 0);
> +               strbuf_setlen(path, baselen);
> +               strbuf_addstr(path, e->d_name);
> +
> +               if (dtype =3D=3D DT_REG) {
> +                       res =3D fn(path->buf, data);
> +               } else if (dtype =3D=3D DT_DIR) {
> +                       strbuf_addch(path, '/');
> +                       res =3D for_each_file_in_dir(path, fn, data);
> +               }
> +       }
> +
> +       closedir(dir);
> +       return res;
> +}
> +
>  int count_slashes(const char *s)
>  {
>         int cnt =3D 0;
> diff --git a/dir.h b/dir.h
> index d7e71aa8daa7..f4235cc12a2f 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -536,6 +536,20 @@ int get_sparse_checkout_patterns(struct pattern_list=
 *pl);
>   */
>  int remove_dir_recursively(struct strbuf *path, int flag);
>
> +/*
> + * This function pointer type is called on each file discovered in
> + * for_each_file_in_dir. The iteration stops if this method returns
> + * non-zero.
> + */
> +typedef int (*file_iterator)(const char *path, const void *data);
> +
> +struct strbuf;
> +/*
> + * Given a directory path, recursively visit each file within, including
> + * within subdirectories.
> + */
> +int for_each_file_in_dir(struct strbuf *path, file_iterator fn, const vo=
id *data);
> +
>  /*
>   * Tries to remove the path, along with leading empty directories so lon=
g as
>   * those empty directories are not startup_info->original_cwd.  Ignores
> --
> gitgitgadget

Looks reasonable.
