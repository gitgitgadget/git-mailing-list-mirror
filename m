Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370032C94A
	for <git@vger.kernel.org>; Thu,  7 May 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140532; cv=pass; b=ee4GRVF/lbOx4UsaATOLkETjGQwGnXPQNiNcB0LP+vsHiORspdv5qot+4EDbw2NDnFxBSPtQR87dhxyD8rn0gcHY/PE0may+oyzgWa47PWmXoTVHHSdRif4mvxEk1zia7VBcXaiPcenhIJJWr1sMqsJS5hxSPlOXO2yrPekm5cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140532; c=relaxed/simple;
	bh=dzZJYK8+HS7IKnoJ8bN4y3O0iY5otrpqpCPUWSXG+xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGNF2+JY5bCb5zHijbc3iaC12vD+K6l38R2q/eJzzNQQ/sp5GQIiv2om3DMXbiUJC+gTwGV6Q/jq5YWO76dMLOKwPCVajV3G4PZyseoxg55NNVbQNk9n2NZG+CGBjgQxHa0avUxE8jVGNEsm6k58/2BPo+VkWTzLPZfmnWCocgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPaDtu6e; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPaDtu6e"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bd5c773ef3so5046837b3.1
        for <git@vger.kernel.org>; Thu, 07 May 2026 00:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778140530; cv=none;
        d=google.com; s=arc-20240605;
        b=NgmKPph5rpWRLb9iTNixjHd2kmY/DtjZP4sxKSgnBh3smZI9XuinZu3sAWBp4OETQR
         4HGfjJCTjNmtNfFtQeGzFdC7jjGV31YlWYnpqc4FjPF1uHBlZTuFt26aRf0VvlO/hVio
         TOlw6Hs/TQDfaeO+kG04CLsexc9ziEd4MmxNhX8/qc3Dwau+ALSG/tbXpnmTstBqsYrO
         3rFFFLs+UYGkZKnC98DuoRqx7xdzuhYxy0IP1T7cmWR1Mu9cpiByfWmW8nneSmQ2ZE5w
         UGA69mu9qICZZgmLe17WJ+zCul2lWFggG/UyHKE+1v6d7HVGvp2GijvuPV60y2yQykP4
         4H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PrbWZ7ANvDIHLowb9xPcwhlfmO6M7VC+5FVs2Kwd14A=;
        fh=RaGufr14fdidNjC/O5EE+Y+b/jS3G2/u8P9kuJrJncw=;
        b=bxCor8yBU6KRaRZnItLxu0alq7cBlbNoGMSbRMOVgPI1TmDC5WiONsyPzkhQeziZCE
         YReuKc/8BHNOhJyckg7hVPmlxjgZBsagYslL1wAor7XOw1XSSgYC+D/xe4vL/eTHmAOG
         Vc+lIxhgkiZ+RvoEhWWmiGGUlGPgxngOgOeq27DXVShimdMJbYI067IuD6RJshnSmSF0
         Lsb3MFhU7hqdFMP+uXQdvUIGjZx6x0wWWRZn1kMLtzGQxergyQxDQUwKFtuhdX4OJTov
         Q5/xMjjZm9wfYzN1BCTHArDgJ4kYIbl1ZWvB1WvFFcXOsOuzb6lo/PAMAx7aCuuuAy6R
         WoUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778140530; x=1778745330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrbWZ7ANvDIHLowb9xPcwhlfmO6M7VC+5FVs2Kwd14A=;
        b=pPaDtu6e5DWjdbd0ImY4rk7ENQG3cCQHYybJnNq3WD6xVkyPwC7gHxsxJg7QG9q/u1
         z+I1BzlsWjl62x5eK65tjP9tT5LxEKzeFs54RxeFup0tYC7X8YZKAnTZKIQ6aEoM9USL
         I+qOneuUGD5TYKEp5JXG/2ihysMBSvlzo402x0loGu9io3MAbglyOkTVU//LFP6ohMZr
         KBMJjnll7UNX6tZMNJjknfpU4y22U8EwPENxenTDH6QNZI/7NRwK7CcO1rKGLS4xd8/z
         fxMDPpwYMesApwLrKDFqLrMICQ06/w/LuRNy4QjpqH+3wMei/DDuCtK8mB2ZIYUHrFri
         fBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778140530; x=1778745330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PrbWZ7ANvDIHLowb9xPcwhlfmO6M7VC+5FVs2Kwd14A=;
        b=O18Hk5CTsfTbauL7DCaZgz6mStHU3WHILHKsGs6SBa5bzl4avqQDfnXCC37Rp1xD/l
         z9hYi61O6w6Ev2QUtooh6iqUsNA1hhAJqmUsLDf58sbTxLYxON7Zx84nX3kVnTSDpyUC
         5tRQbTKB7gVsY4XNqVlfWkz40aKE0IIf/A7c1il6xRj0uKXZ5i5l6bAnIUSXYA+E5+rp
         R/6tj1MM6HDR377F/6q4XPdAOiZwal9BFzZ4YIWQwvmXmM5KvEmAvrPMSLcvme4DjuX9
         9SaCL25C8plOvg4G3NNKC19blzgvTcI1ztqwk68bvBJHWm5oDT5irCqiaSOjoMKzDQII
         hkvQ==
X-Gm-Message-State: AOJu0YwizyeDRbeHV2wD+zLi6R97aLdqxm+TTMSgO1LgNBvhIgbZetZ0
	Khi+YySEBw44gUjDGIaZ2XlCx8R4W+yiyPM41r4YA2xnHXNP37S3CMvUwaQlh6Tpu2c/bKn/sj4
	OCWcn8dXPPZivsCfiD9kUiy7a45Y1TiQ=
X-Gm-Gg: AeBDieua5ItoiyraeKRUqL+5LU1OMdTboapKItm5K7HuXD6NTv1hr/LF74jgFIyoGgM
	aRlYel1xrOJMcLAE2MlUyN0y11CsdLwNzosO1PZ2Xz3BTHhEhuj+SKmkCEg9mH7a+In3j1GfdVu
	WR2jg3ES9zubuGxqhl6bBG17kQAgrK3G9v2jVVjETb9Vz3J1CpZhcbh149pvczB0seQ7+7lzDis
	4S06Ovj8szM8V0RMr51EkwB9LUHqjnUpn5i0Z74iyjYOz8BK1AQfLxO48Y46+3ExPNxc5PRlGIq
	XD/Nd8oz+WPzuUZI2oVNWg8+p/5BUrnk6GU3RyhqHfgZ710ubGD10KKgEHFy23V9pdVQxBQL2wN
	UbjM3SnsrV1w4UpE7tMNw0maW5uRKS0WiTCfDZNmInXPlxVQqQWwp12twwOEgciCB24bq21edDy
	N/64nG3raqzzdQ4FW/
X-Received: by 2002:a05:690c:d85:b0:7bd:6155:e7fd with SMTP id
 00721157ae682-7bdf5dc9b7fmr77458217b3.12.1778140529822; Thu, 07 May 2026
 00:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506235459.529862-1-javierbassi@gmail.com>
In-Reply-To: <20260506235459.529862-1-javierbassi@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 7 May 2026 09:55:18 +0200
X-Gm-Features: AVHnY4LlmKobVx6QDzO0DJX9zxdVAS0K3z446sBkxMcB54JHuPo5Um0vEWlEmKs
Message-ID: <CAN5EUNRT7V3BrtyU0UYwGVnJ51LWSsNi1OnzMB5WL=w8vhKmrw@mail.gmail.com>
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with --word-diff
To: Javier Bassi <javierbassi@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>, Rene Scharfe <l.s.r@web.de>, 
	Elijah Newren <newren@gmail.com>, Ruben Justo <rjusto@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 7 may 2026 a las 1:58, Javier Bassi (<javierbassi@gmail.com>) escri=
bi=C3=B3:
>
> When using `git add --patch`, reviewing changes in long lines can be
> difficult with the default line-based diff. This is particularly
> noticeable in formats such as JSONP, CSV, LaTeX, Markdown, or other
> plain text where small inline edits can be hard to spot.

Very good explanation. I think it's a good idea.

>
> Added `w - print the current hunk with word-diff` during hunk selection
  ^^^^^^^
Nit: following Documentation/SubmittingPatches, try to use an
imperative mood to write what has been done.

> to re-display the current hunk using `--word-diff`. This provides a
> clearer inline view of changes without modifying the hunk or affecting
> how patches are applied or staged.
>
> Signed-off-by: Javier Bassi <javierbassi@gmail.com>
> ---
>  Documentation/git-add.adoc |   1 +
>  add-patch.c                | 105 ++++++++++++++++++++++++++++++++++++-
>  t/t3701-add-interactive.sh |  59 +++++++++++++--------
>  3 files changed, 142 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 941135dc63..d2ee1cf9a9 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -351,6 +351,7 @@ patch::
>         K - go to the previous hunk, roll over at the top
>         s - split the current hunk into smaller hunks
>         e - manually edit the current hunk
> +       w - print the current hunk with word-diff
>         p - print the current hunk
>         P - print the current hunk using the pager
>         ? - print help
> diff --git a/add-patch.c b/add-patch.c
> index f27edcbe8d..0364f4bc97 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -7,6 +7,7 @@
>  #include "commit.h"
>  #include "config.h"
>  #include "diff.h"
> +#include "diffcore.h"
>  #include "editor.h"
>  #include "environment.h"
>  #include "gettext.h"
> @@ -1508,6 +1509,105 @@ static void summarize_hunk(struct add_p_state *s,=
 struct hunk *hunk,
>         strbuf_complete_line(out);
>  }
>
> +static void trim_trailing_lf(struct strbuf *buf)
> +{
> +       if (buf->len && buf->buf[buf->len - 1] =3D=3D '\n')
> +               strbuf_setlen(buf, buf->len - 1);
> +}
> +
> +static void add_word_diff_line(struct strbuf *old, struct strbuf *new,
> +                              const char *line, size_t len, char marker)
> +{
> +       if (marker =3D=3D '-' || marker =3D=3D '+' || *line =3D=3D ' ') {
> +               line++;
> +               len--;
> +       }

Maybe a tiny comment here would help, to know why '*line' is being
checked here instead of 'marker'. They seem the same and one has to go
to marker declaration and see the comment at 'normalize_marker()'

  /* Empty context lines may omit the leading ' ' */

> +
> +       if (marker !=3D '+')
> +               strbuf_add(old, line, len);
> +       if (marker !=3D '-')
> +               strbuf_add(new, line, len);
> +}
> +
> +static void build_word_diff_files(struct add_p_state *s, struct hunk *hu=
nk,
> +                                 struct strbuf *old, struct strbuf *new)
> +{
> +       size_t i;
> +       char last_marker =3D '\0';
> +
> +       for (i =3D hunk->start; i < hunk->end; i =3D find_next_line(&s->p=
lain, i)) {
> +               size_t next =3D find_next_line(&s->plain, i);
> +               char marker =3D normalize_marker(s->plain.buf + i);
> +
> +               if (marker =3D=3D '\\') {
> +                       if (last_marker !=3D '+')
> +                               trim_trailing_lf(old);
> +                       if (last_marker !=3D '-')
> +                               trim_trailing_lf(new);
> +                       continue;
> +               }

Here we check about "\No newline at end of file", after this point I
believe that 'buf->buf[buf->len - 1] =3D=3D '\n'' will always be true.
Same should be for 'buf->len' because "\No newline at end of file"
shouldn't come first and a '+' '-' line should have been added on a
previous iteration, but the check it's fine, just in case I'm wrong.

What I want to point out is, is the 'trim_trailing_lf' function
necessary? It's only called in the same place and it carries a check
that could be on the caller instead, leaving  the function only with
'strbuf_setlen(buf, buf->len - 1);" making sense to inline it at this
point.
You could keep the buf->len check:

  if (marker =3D=3D '\\') {
          if (last_marker !=3D '+' && old->len)
                   strbuf_setlen(old, old->len - 1);
          if (last_marker !=3D '-' && new->len)
                   strbuf_setlen(new, new->len - 1);
          continue;
  }

> +
> +               if (marker !=3D ' ' && marker !=3D '-' && marker !=3D '+'=
)
> +                       BUG("unhandled diff marker: '%c'", marker);
> +
> +               add_word_diff_line(old, new, s->plain.buf + i, next - i,
> +                                  marker);
> +               last_marker =3D marker;
> +       }
> +}
> +
> +static struct diff_filespec *word_diff_filespec(struct repository *r,
> +                                               const char *name,
> +                                               struct strbuf *buf)
> +{
> +       struct diff_filespec *spec =3D alloc_filespec(name);
> +       size_t size;
> +
> +       fill_filespec(spec, null_oid(r->hash_algo), 0, 0100644);
> +       spec->data =3D strbuf_detach(buf, &size);
> +       spec->size =3D size;
> +       spec->should_free =3D 1;
> +       spec->is_stdin =3D 1;
> +
> +       return spec;
> +}
> +
> +static void show_hunk_word_diff(struct add_p_state *s, struct hunk *hunk=
,
> +                               int colored)
> +{
> +       struct hunk_header *header =3D &hunk->header;
> +       struct strbuf old =3D STRBUF_INIT, new =3D STRBUF_INIT;
> +       struct diff_options opts;
> +       struct diff_queue_struct queue;
> +
> +       if (!header->old_offset && !header->new_offset) {

Nit: a comment here would help to understand this early return

> +               strbuf_reset(&s->buf);
> +               render_hunk(s, hunk, 0, colored, &s->buf);
> +               fputs(s->buf.buf, stdout);
> +               return;
> +       }
> +
> +       build_word_diff_files(s, hunk, &old, &new);
> +
> +       repo_diff_setup(s->r, &opts);
> +       opts.output_format =3D DIFF_FORMAT_PATCH;
> +       opts.use_color =3D colored ? s->cfg.use_color_diff : GIT_COLOR_NE=
VER;
> +       opts.word_diff =3D DIFF_WORDS_PLAIN;
> +       opts.context =3D header->old_count > header->new_count ?
> +               header->old_count : header->new_count;
> +       opts.flags.suppress_diff_headers =3D 1;
> +       diff_setup_done(&opts);
> +
> +       memcpy(&queue, &diff_queued_diff, sizeof(diff_queued_diff));
> +       diff_queue_init(&diff_queued_diff);
> +       diff_queue(&diff_queued_diff,
> +                  word_diff_filespec(s->r, "a", &old),
> +                  word_diff_filespec(s->r, "b", &new));
> +       diffcore_std(&opts);
> +       diff_flush(&opts);
> +       memcpy(&diff_queued_diff, &queue, sizeof(diff_queued_diff));
> +}
> +
>  #define DISPLAY_HUNKS_LINES 20
>  static size_t display_hunks(struct add_p_state *s,
>                             struct file_diff *file_diff, size_t start_ind=
ex)
> @@ -1540,6 +1640,7 @@ N_("j - go to the next undecided hunk, roll over at=
 the bottom\n"
>     "/ - search for a hunk matching the given regex\n"
>     "s - split the current hunk into smaller hunks\n"
>     "e - manually edit the current hunk\n"
> +   "w - print the current hunk with word-diff\n"
>     "p - print the current hunk\n"
>     "P - print the current hunk using the pager\n"
>     "> - go to the next file, roll over at the bottom\n"
> @@ -1731,7 +1832,7 @@ static size_t patch_update_file(struct add_p_state =
*s,
>                                 permitted |=3D ALLOW_GOTO_PREVIOUS_FILE;
>                                 strbuf_addstr(&s->buf, ",<");
>                         }
> -                       strbuf_addstr(&s->buf, ",p,P");
> +                       strbuf_addstr(&s->buf, ",w,p,P");
>                 }
>                 if (file_diff->deleted)
>                         prompt_mode_type =3D PROMPT_DELETION;
> @@ -1953,6 +2054,8 @@ static size_t patch_update_file(struct add_p_state =
*s,
>                                 hunk->use =3D USE_HUNK;
>                                 goto soft_increment;
>                         }
> +               } else if (s->answer.buf[0] =3D=3D 'w') {
> +                       show_hunk_word_diff(s, hunk, colored);
>                 } else if (ch =3D=3D 'p') {
>                         rendered_hunk_index =3D -1;
>                         use_pager =3D (s->answer.buf[0] =3D=3D 'P') ? 1 :=
 0;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 6e120a4001..e1ce98d62b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -48,8 +48,8 @@ test_expect_success 'unknown command' '
>         git add -N command &&
>         git diff command >expect &&
>         cat >>expect <<-EOF &&
> -       (1/1) Stage addition [y,n,q,a,d,e,p,P,?]? Unknown command ${SQ}W$=
{SQ} (use ${SQ}?${SQ} for help)
> -       (1/1) Stage addition [y,n,q,a,d,e,p,P,?]?$SP
> +       (1/1) Stage addition [y,n,q,a,d,e,w,p,P,?]? Unknown command ${SQ}=
W${SQ} (use ${SQ}?${SQ} for help)
> +       (1/1) Stage addition [y,n,q,a,d,e,w,p,P,?]?$SP
>         EOF
>         git add -p -- command <command >actual 2>&1 &&
>         test_cmp expect actual
> @@ -332,9 +332,9 @@ test_expect_success 'different prompts for mode chang=
e/deleted' '
>         git -c core.filemode=3Dtrue add -p >actual &&
>         sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtere=
d &&
>         cat >expect <<-\EOF &&
> -       (1/1) Stage deletion [y,n,q,a,d,p,P,?]?
> -       (1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,P,?]?
> -       (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]?
> +       (1/1) Stage deletion [y,n,q,a,d,w,p,P,?]?
> +       (1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,w,p,P,?]?
> +       (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]?
>         EOF
>         test_cmp expect actual.filtered
>  '
> @@ -521,13 +521,13 @@ test_expect_success 'split hunk setup' '
>  test_expect_success 'goto hunk 1 with "g 1"' '
>         test_when_finished "git reset" &&
>         tr _ " " >expect <<-EOF &&
> -       (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,=
3          +15
> +       (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? + 1:  -1,2 +=
1,3          +15
>         _ 2:  -2,4 +3,8          +21
>         go to which hunk? @@ -1,2 +1,3 @@
>         _10
>         +15
>         _20
> -       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?=
_
>         EOF
>         test_write_lines s y g 1 | git add -p >actual &&
>         tail -n 7 <actual >actual.trimmed &&
> @@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
>         _10
>         +15
>         _20
> -       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?=
_
>         EOF
>         test_write_lines s y g1 | git add -p >actual &&
>         tail -n 4 <actual >actual.trimmed &&
> @@ -550,11 +550,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
>  test_expect_success 'navigate to hunk via regex /pattern' '
>         test_when_finished "git reset" &&
>         tr _ " " >expect <<-EOF &&
> -       (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @=
@
> +       (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? @@ -1,2 +1,3=
 @@
>         _10
>         +15
>         _20
> -       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?=
_
>         EOF
>         test_write_lines s y /1,2 | git add -p >actual &&
>         tail -n 5 <actual >actual.trimmed &&
> @@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pat=
tern' '
>         _10
>         +15
>         _20
> -       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?=
_
>         EOF
>         test_write_lines s y / 1,2 | git add -p >actual &&
>         tail -n 4 <actual >actual.trimmed &&
> @@ -579,27 +579,42 @@ test_expect_success 'print again the hunk' '
>         tr _ " " >expect <<-EOF &&
>         +15
>          20
> -       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @=
@ -1,2 +1,3 @@
> +       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?=
 @@ -1,2 +1,3 @@
>          10
>         +15
>          20
> -       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +       (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?=
_
>         EOF
>         test_write_lines s y g 1 p | git add -p >actual &&
>         tail -n 7 <actual >actual.trimmed &&
>         test_cmp expect actual.trimmed
>  '
>
> +test_expect_success 'print hunk with word-diff' '
> +       test_when_finished "rm -rf word-diff-repo" &&
> +       git init word-diff-repo &&
> +       (
> +               cd word-diff-repo &&
> +               test_write_lines "alpha old beta" context >word-diff &&
> +               git add word-diff &&
> +               git commit -m word-diff &&
> +               test_write_lines "alpha new beta" context >word-diff &&
> +               test_write_lines w n | git add -p word-diff >actual &&
> +               test_grep "alpha \\[-old-\\]{+new+} beta" actual &&
> +               git diff --cached --exit-code
> +       )
> +'
> +
>  test_expect_success TTY 'print again the hunk (PAGER)' '
>         test_when_finished "git reset" &&
>         cat >expect <<-EOF &&
>         <GREEN>+<RESET><GREEN>15<RESET>
>          20<RESET>
> -       <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> +       <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,w,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
>         PAGER  10<RESET>
>         PAGER <GREEN>+<RESET><GREEN>15<RESET>
>         PAGER  20<RESET>
> -       <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,p,P,?]? <RESET>
> +       <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,w,p,P,?]? <RESET>
>         EOF
>         test_write_lines s y g 1 P |
>         (
> @@ -796,21 +811,21 @@ test_expect_success 'colors can be overridden' '
>         <BLUE>+<RESET><BLUE>new<RESET>
>         <CYAN> more-context<RESET>
>         <BLUE>+<RESET><BLUE>another-one<RESET>
> -       <YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD=
>Split into 2 hunks.<RESET>
> +       <YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,w,p,P,?]? <RESET><BO=
LD>Split into 2 hunks.<RESET>
>         <MAGENTA>@@ -1,3 +1,3 @@<RESET>
>         <CYAN> context<RESET>
>         <BOLD>-old<RESET>
>         <BLUE>+<RESET><BLUE>new<RESET>
>         <CYAN> more-context<RESET>
> -       <YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <R=
ESET><MAGENTA>@@ -3 +3,2 @@<RESET>
> +       <YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? =
<RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
>         <CYAN> more-context<RESET>
>         <BLUE>+<RESET><BLUE>another-one<RESET>
> -       <YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET=
><MAGENTA>@@ -1,3 +1,3 @@<RESET>
> +       <YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? <RES=
ET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
>         <CYAN> context<RESET>
>         <BOLD>-old<RESET>
>         <BLUE>+new<RESET>
>         <CYAN> more-context<RESET>
> -       <YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p=
,P,?]? <RESET>
> +       <YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w=
,p,P,?]? <RESET>
>         EOF
>         test_cmp expect actual
>  '
> @@ -1424,9 +1439,9 @@ test_expect_success 'invalid option s is rejected' =
'
>         test_write_lines j s q | git add -p >out &&
>         sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
>         cat >expect <<-EOF &&
> -       (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
> -       (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, can=
not split this hunk
> -       (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
> +       (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,w,p,P,?]?
> +       (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? Sorry, c=
annot split this hunk
> +       (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?
>         EOF
>         test_cmp expect actual
>  '
> --
> 2.54.0
>
>

I tried and found out that if a character is contiguous to a word diff
it will be carried as part of the diff. e.g.:

  diff --git a/file b/file
  index f33f47f..93dd39c 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -foo, bar
  +baz, bar
  (1/1) Stage this hunk [y,n,q,a,d,e,w,p,P,?]? w
  @@ -1 +1 @@
  [-foo,-]{+baz,+} bar

the ',' remains at the same place but became part of the diff which adds no=
ise.

Regards,
--
Pablo
