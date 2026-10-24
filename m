Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854537;
	b=Y24/9XSxvoI4JnrZcHjeUsL6y5sqf6xsJf2IlyLlB448tbqO7AHnrDu+ouI9nwo0C+tN
	 f+NoIg+ZWB+Zp2cQpXCRZS3EkGK8yehxwM/Uvce6YVng0MAIdjduVierTJzavGhzlzxHF
	 8O0VzsWJrSegwEBhPKn1yIhAMk3erNu2ajFOAt/4S1b/LfNQXNF2T0pSXQqOmToF8W6NZ
	 REd1yKvsK/WEZwM2dA3djMXa3CjFxkBUmwkoq9DST+xNroXVSadXcsCh2WXCyaBmCELKw
	 KyarhKQptn8xJi2BnyrBZcQ2dtGPtuXdMQU9t9Yxw5prsm6F2SoCZ2gDbF72NHvQe/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ChOCPE7EbcifWxs7gJqUxmYa2jrI52RrxX+4sBe1Sjc=;
	b=JAQssQS/itfjplYUk8w7EDu9k0TujP0vtGBgqTQfYsac8donHggdxIvOtUr947lxyTk/
	 UIIoHeDNSCFeY/UPGm/hZ++z0FcaptZjBVw9g73lukKBM6HI2Bq8ys2CQm5nCZVIu0kEW
	 0PCx0Vh2HWBcW6JakbUH2qf3Z676+FEZcpjNCx+D+VEbL1QGIrp7G1uOttENi2qCAaF3f
	 uG3Pl1Hj9rKOqbX9Xsxoc3lgL02IEG17Keo9dQ314uZRs32FuMNDuTmhqA+S+20LCO4jQ
	 Pm2vBMSJdkLwn7M7UiKQoMhcbwW6I5OuX5K0elYkYsvtHhENw4GN+2El30Wrv52aMMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m3gssKFV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C644606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C644606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m3gssKFV
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89d6bd67045so848551b3a.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854537; cv=none;
        d=google.com; s=arc-20260327;
        b=g7kRz//kgqa6kAX7fLhbjRMDty+dmpdv6vRO15GuExADlaIsDa5hJZj8WASMv9TRVb
         IwANisuGywhzK9/UemWBsLCL2Y9WXeBdThJNct/h7JFA9+q2qcaTipm/3RzbAsUbeJr+
         EaXuRWJZGtNfRXDru1c2+oYnkeEBx013AcajgPbCMxPItsjW1X5uGcrydsI/QJJ7X6K4
         KK9mxDmcjzQDNZ+Y7gj8HdGTY1GxAqdeAkoKbgQaAyhqiWkBGzTWW0HLNCK6Qys5NEtH
         HhxBHuHKrVw3rE4mob1ShswLBypbJW+gT3Uu3bgVKfJAcl/octDQoqwfAlh1DgKAchpn
         46Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ChOCPE7EbcifWxs7gJqUxmYa2jrI52RrxX+4sBe1Sjc=;
        fh=kV+AbbD2dx8Zvrt/D0Q7uj1KhZdY6IIWIpBTzKZxjpM=;
        b=Ut/Tg6g1wEBCgLX48QVkEM5VWlB3Ds1pBODCaZMdiZDtuVQHg0kGs1NrB7ZiTSTLVh
         X1DWcoyKDOtkOyYG20X6Ri6DqR5ULOA4+P4uaydFJNEbUfoCVaQjilHYB5GDSFMa4fer
         RfJcrndjEgKdQiAmXAvGvxWmfJShPbfPG0dZUTBJ6im3S0nrHik/+PsTy48Xh0AGOKt0
         ALMtmiFm2E3Cl3FEg/WpYS3+QPHuLA6qVEKZ72XT7afz6iwoQgaX9HKe3FUbvTHslw3u
         2SevJu9+bo5qIFqlR9lz8NVgzmBPva9ws7qKMG4UaxafBp7P5no4w1m+GlVKPd9zH1pp
         tLeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854537; x=1793459337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ChOCPE7EbcifWxs7gJqUxmYa2jrI52RrxX+4sBe1Sjc=;
        b=m3gssKFVG6XgSRhmIR2qmeENEv/vAQSaix/9zD41PfXh/dNtgur+gW4XQQxNeBasRU
         UMJEFunjwASSzpAmXIOtSgQkag1M7MiWyq/g8dfyWP0ym9Q5rP/76XuZ62qGGTYjeC8G
         4f9ifOUqXieU6EcIZ1aNQkqifmcmZdhoAqi64TtNtYlgTVyKqgxU0PUcs951hZ/aekzh
         kTiGzS9pPaIiKX7CAEhj9s1c5DS+Jryanie/39fRa88ZErAVCRXcZq0G233pMMmnCSOh
         zH0ywxDj03aRbwQecvdyU+v9Z96G5M2HnV2PoHIIdeWDFZD1rwS0v0EzTGw2KIlclTTq
         JMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854537; x=1793459337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChOCPE7EbcifWxs7gJqUxmYa2jrI52RrxX+4sBe1Sjc=;
        b=Msfk3QsoM59gd4Dzc9fT61k5S0f3JpcI+wvs/hm2nibxzshDxDDodiHW65Cx4WRJa/
         lwYHOQRR0tVVac7zCjVmk7tXAW7AYSZtNjFMEBQowtkoyUWoUnCmZRzM6g6hhASAobMJ
         tFrfVaHXLBlrvIhsVF8wCJWaB2fHd8L3gHrs0/tYDV2rmc+P/9mkaiRqAKcehW2WplBQ
         f9eCcHnO3wjl3bTWVc8CHQC9sObc1/jxGHc2Dv4IQ7lNW9V/3UtG/GBOikoiQ5wsX5qC
         IrJfS9hHsD2EDeOFkgmo6w5ytHnM7/6MMhMdPRzE2dt3oBN5n19sq7QBILBFWJ4go+81
         5HjA==
X-Gm-Message-State: AFq9FYJtCuo7znGAYTt9Vt3jY1cspCgPP5KprUPOr/KwS1teAn0/4AhK
	OVjLt3QbTKN/g3wL2YYvQk5uQ44NaUgnlzC8JhziGxDtwbc/R8nKABQO57g/iKRQ8+9OXKFxE8N
	adOFJU1Or1XZlrxUwp4ZL9wktkC1DrLw=
X-Gm-Gg: AYBFou0c19EnZqd+wVbaXvtahe8rGOcRF5C51/SvVWWrBmWCPyrtXE/YWqSXZrxKabH
	j3K2PccKXzCyA5W+Rn1cNWbuLkAPfXqoP/cs12wsMixk+TJ8kzl9DgzB2/fydM+bB77RzYiN56Z
	Ld+bGlGMp7R46/ykHGQpnviBCkV63IkVQRxboA+k2+ATC47pS9BQ1RXAbGPbTXCyhRd0P22C/Nn
	0pjUUIk1/LHsn81WIazg/e75OVAobHxejC3MB66VHPbkQ1Iwf3DMkdXpbj7A+7RMyz8DKYlBwS1
	wvKm5fZ2XtdNDFEx6w+DEa1Q9X2vX/d8FKHHG8YLk/V7Ie2eHGWtYvsVHAGbkVI9QMsYiEvaovq
	vzL78eepvijsDS7/0yuhjKDKj2KVvNfS1unk922XnsKEIEZdm+Aefj/9e7xZVppRYDOqySWLv4v
	iZ7oppee2A6+8X1Mv0Cmk2B6q3WnH0/tVTCyYIL18niLDyk+ckmB1g
X-Received: by 2002:a05:6a00:418f:b0:888:cf3:e4b6 with SMTP id
 d2e1a72fcca58-8a36e5167bbmr1256667b3a.30.1792854536595; Sat, 24 Oct 2026
 08:08:56 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <aa20604144efdcc5ada00d65d538fdb42c2e31d3.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <aa20604144efdcc5ada00d65d538fdb42c2e31d3.1792503778.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:08:45 -0400
X-Gm-Features: AclHuK_E2nH0yl-WYMWpnHeAtmfuJd3zrSxU-nACdVeGD3WDlNRmluS6ZeUw5zs
Message-ID: <CALnO6CAgS3=ne1RkT-DioLmY6SqhnOZ8NH5kxxCZA_1QFx-dBg@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] fetch: extract collect_upstream_from_remote() helper
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:43=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When a fetch has no refspec to work from, we fall back to guessing
> what to fetch: the remote's configured fetch refspec if there is one,
> and separately, whether the current branch's upstream lives on this
> remote.

It took me a couple tries to parse this because the 2 halves ("[one],
and separately, [two]") are 2 different kinds of objects! I think what
you are trying to tell me is

    =E2=80=A6we fall back to guessing what to fetch: the remote's =E2=80=A6
separately, the current branch's upstream if it lives on the fetched
remote.

That way [two] is also a "thing to fetch" in the same class of objects
as [one]? Or have I misunderstood?

> The latter is independent of the former on purpose: a narrow
> refspec (for example from "git remote add -t") can leave the current
> branch's own upstream uncovered, and we still need to be able to fetch
> it.

I don't really understand the meaning here. I can guess that you mean
something like "A remote with a narrow refspec, like what you get from
'git remote add -t', can omit a branch's upstream from the remote's
fetch refspec, and we still want to fetch that upstream." But it's
taken me a while to put that together (after puzzling out the above)
after first not knowing what "uncovered" meant.

I think the whole thing would be clearer with an example:

"""
Imagine a remote with a narrow refspec:

    git remote add -t main colleague <remote>

and a branch whose upstream points at that remote, but isn't part of
the remote's refspec:

    git fetch colleague work:refs/remotes/colleague/work
    git switch -c work colleague/work

When we "git fetch colleague" without a refspec, we decide what to
fetch by combining the remote's refspec (main -> remote-tracking
branch, in this case) and the current branch's upstream, if it was
based on that remote (work -> remote-tracking branch, in this case).
"""

Note: we aren't "guessing" what to fetch!

> That "does this branch build on this remote" check was inlined for
> just the current branch. Move it into its own function,
> collect_upstream_from_remote(), so the same logic can be reused for
> branches other than just the current one.

And then this maybe comes next. Personally I appreciate the extra
explanation, but if it exists elsewhere we could also refer to the
implementing commit?

I've also made some assumptions about how that "current branch" check
works, since I'm not sure how to make sense of it without this
manually created remote-tracking branch?

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/fetch.c | 23 ++++++++++++++---------
>  remote.c        | 15 +++++++++++++++
>  remote.h        |  9 +++++++++
>  3 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ffcb5ba29a..136a59154a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1979,7 +1979,8 @@ static int do_fetch(struct transport *transport,
>         if (rs->nr) {
>                 refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_p=
refixes);
>         } else {
> -               struct branch *branch =3D branch_get(NULL);
> +               struct string_list tracked =3D STRING_LIST_INIT_DUP;
> +               struct string_list_item *item;
>
>                 if (transport->remote->fetch.nr) {
>                         refspec_ref_prefixes(&transport->remote->fetch,
> @@ -1995,14 +1996,18 @@ static int do_fetch(struct transport *transport,
>                         else
>                                 follow_remote_head =3D BUILTIN_FOLLOW_REM=
OTE_HEAD_DFLT;
>                 }
> -               if (branch && branch_has_merge_config(branch) &&
> -                   !strcmp(branch->remote_name, transport->remote->name)=
) {
> -                       int i;
> -                       for (i =3D 0; i < branch->merge_nr; i++) {
> -                               strvec_push(&transport_ls_refs_options.re=
f_prefixes,
> -                                           branch->merge[i]->src);
> -                       }
> -               }
> +
> +               /*
> +                * The configured refspec may not cover the current
> +                * branch's upstream (e.g. a narrowed -t refspec), so
> +                * make sure we can still fetch it regardless.
> +                */
> +               collect_upstream_from_remote(the_repository, &tracked,
> +                                             transport->remote, NULL);
> +               for_each_string_list_item(item, &tracked)
> +                       strvec_push(&transport_ls_refs_options.ref_prefix=
es,
> +                                   item->string);
> +               string_list_clear(&tracked, 0);
>
>                 /*
>                  * If there are no refs specified to fetch, then we just
> diff --git a/remote.c b/remote.c
> index c9252a90f4..965e42ff52 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1891,6 +1891,21 @@ int branch_merge_matches(struct branch *branch,
>         return refname_match(branch->merge[i]->src, refname);
>  }
>
> +void collect_upstream_from_remote(struct repository *repo,
> +                                  struct string_list *tracked,
> +                                  struct remote *remote,
> +                                  const char *refname)

I'm not sure if we have guidance about where in the parameter list
"out" parameters should go, but I would expect them to be last? Idk.

Should the "inputs" be const to better communicate that we aren't
going to modify them? I'm not really sure of the const semantics of C
anyway, and I know there have been topics in the recent past around
const-modifier lints and so on.

> +{
> +       struct branch *branch =3D repo_branch_get(repo, refname);
> +
> +       if (!branch_has_merge_config(branch) ||
> +           strcmp(branch->remote_name, remote->name))
> +               return;
> +
> +       for (int i =3D 0; i < branch->merge_nr; i++)
> +               string_list_insert(tracked, branch->merge[i]->src);
> +}

We do trade some performance now, right? We first collect a
string_list, then push them into a strvec, which has some overhead
relative to skipping the intermediate step. Plus, string_lists sort,
which the original didn't do. And the caller uses the DUP version of
string_list (and IIUC strvec_push strdup's as well), so we end up
copying twice?

If we used a strvec instead, we could use strvec_pushv, perhaps, being
a bit more efficient? (It would be nice if we had an ownership-taking
strvec_appendv or something?)

But stepping back, if the caller just provides a strvec instead of a
string_list, we can push to it directly, since that's what happens
anyway! We don't do any filtering or anything in the new caller.

>  __attribute__((format (printf,2,3)))
>  static char *error_buf(struct strbuf *err, const char *fmt, ...)
>  {
> diff --git a/remote.h b/remote.h
> index ac485a584d..7c86c529b6 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
>
>  int branch_merge_matches(struct branch *, int n, const char *);
>
> +/*
> + * If refname's branch builds on remote, add its upstream on remote to
> + * tracked. A NULL refname means the current branch.
> + */
> +void collect_upstream_from_remote(struct repository *repo,
> +                                  struct string_list *tracked,
> +                                  struct remote *remote,
> +                                  const char *refname);
> +
>  /* list of the remote in a group as configured */
>  struct remote_group_data {
>         const char *name;
> --
> gitgitgadget
>


--=20
D. Ben Knoble
