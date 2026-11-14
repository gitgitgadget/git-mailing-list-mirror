Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794660114;
	b=mWLjGrDzHjT0kVVFVbMNC+wWNH6IHg/itl/epnfioB6m29ANYZOk3g6xi/DuwbpkPzGP
	 Id1PoFgmzOc9vcY0wgDr2zdf0nHqbAaVJv7BB6WD6pWU10GZI1o7IJhJcZ6y65GIQ5ByS
	 3oW85nN6m0Hc5EA9HC5XAMlC+VYVwBYnH/YfCzJdlkM8ibajfqkh8XZfk6yxxXJ6wscJW
	 1uSkuTvq2zu/wVPX+PlHXRKbuf3BkrCsY13rraxHL55YLCXeVOHTIvO958kPQQQztcFwF
	 u47SHrMjLXaAzTBSGSwKhG6xNNU42kjyrVxTSCFaZBpSAbZUN589XyWrpXkjNq3kEFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nlJfJHJemRun0F1I9BmBpFblMxCH/ieGm23kd6n65Xs=;
	b=EG1N+qQx9xj2hko3u3GTiGR8+E50RscofgSaHHpglIlXlZzrFr2I/0/VWaB3S5V83Wxs
	 SFGMInRnQhj5MHbVW3HtPgh+P2d/19MiuyqPnlxsGeVF9fsXQuLoA7uYoV9qGz1p7/IBL
	 uhqA+aT/j7w1pJmwQZNmzB27xJmUY+NznitLk+nUKEgfDoNk9b6Lo5q6Q01enf8rrMQqj
	 qZCJDvAaAvRMLXNeMwZV1UZUWaNovXq0TPderi8nWxDyoaDNn9nmML46vTZdGk3SFhyc3
	 56mBOvcJuo/sFQbUdkpijapXrCUq/80mPoP6T33H36h2AiTKvqfNYHR/Vfx7h1o2Hgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VreVM/p2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C67606A327
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 12:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C67606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VreVM/p2
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b6e8b6d424so3531438a12.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 04:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794660112; cv=none;
        d=google.com; s=arc-20260327;
        b=hQmdKX+dcEPFp1BmQssGok9Zp4go/LcG40uaR6OPyjZK8Niyjq4uey6EXIvushvVJd
         vV2hpqdndFgY/nuWBGcGcCrJtlAVY1IQANix4GDA3nWCTmO/L6lulj9Tnz5bCjqpS4ko
         APRFRQJZ8Jger/3PkVDazf+UZRiluTvQF3munYyq/radIaMDZWX0s4ej2JJ43Rb8Cebz
         aTK9Ljmx2rXpZcDIg4JKnScpk6lEuK95C5Fq8Mk0HZvnWCV7hYe69qAr2zrSJ1pa1+Jx
         XH5CZPKpzjkuApbIGFf2mK4VXDlGHdaUCjoPKSVaTMOlbaA7VoVTssmG1ubOPRsn5ax+
         JstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nlJfJHJemRun0F1I9BmBpFblMxCH/ieGm23kd6n65Xs=;
        fh=4taht92dzazhQDOjq8CsAaKR4Bsqe7vCuOP5jjEO90Y=;
        b=DPM/euxgSMQPfRRxJP5bbW2QEmWElYQP/23mLcGO5XMHkboUNhRxt9oL0Cny+Y7urD
         OS5RPU61s237MYDavxp7qk3q2mtiLOOFfZnpJujwK8Q0Tz50xLBB8kQxGcYHecc6K4E6
         70R0UJQkNCcbqoy1dl85PLpHQEye/gPO5nCHW0RKoZbwoIG46Fcp+1b5CEdDiMa3Vkfm
         2Aanb2l+NSISmoBQZdsXI6dYwg2+d+DpCt1uUYoIivP+4XTpiIHM+f8xCgJ806F7dZdL
         7bbg7aaxi3Vot99UK6sC1wLR8Dtq8QUkya2TtV+u3CWklkYHj4itwAj4bJVWWL/rkrVp
         P3+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794660112; x=1795264912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nlJfJHJemRun0F1I9BmBpFblMxCH/ieGm23kd6n65Xs=;
        b=VreVM/p28/D9mSnS9V+P8FcWf6Um8g1s8dj23zErnhi6eu2ETVzGzwP3WQq/MK/tyJ
         MbKTmAX6nIubSH0gfPhGs+7735EaOyy0VKWha/wxk7g0GSE2VeE/BW5QicmlMSf2tUKi
         FMKZDvyb8fqFf9xj/LO2pYGJ54IovZZ4tp9f0xuh3nxJiF0CJTjApMZ16rcYXOEElFPg
         Icw8l++4Ifj7j7k4Su1DCCUgd7hgOV8xOB2Plt52UZnGnsqxXIC7dmU8Ck3aJjjZY2Ew
         nJARgVieE74qOQU7iu1TBKSCrq/yh4WNDjNUJkb86oJ45NJxAucj/a5PC+31ppOQPPtL
         9KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660112; x=1795264912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlJfJHJemRun0F1I9BmBpFblMxCH/ieGm23kd6n65Xs=;
        b=RdoPKo0RvfsvFkZAFo3xvozKktjr4HARTaA0XyDl8t6gjX3z94VTH16SIQIDSy/Gb/
         pjcKw/+EWOTy0u9BtyM3eC51+9k2FV8auiAKdJdufx+DfJHwkVB2TC22h7j0LB+BHORg
         x2mFvKpOg8EEba5Bc2pKLlY+DpYbOq5vHOyBPdY5pF6a0B9Ucr7nzQrNgxKFd8ttmhGz
         m+/7z23kHBNM5kaO7z/F3Jg/HnNUMVZJ86D7JX9dpD7WBxqDEa0jJoYZvjrPynKNyAeh
         RjpXgcI76KqpxTN9WJDHtdArwreAZQMezdJCtrqpgzlk+qCq0mNM7vAkVgBmORRxkiQJ
         OoCw==
X-Gm-Message-State: APuU4Z/z6inmOmcyoqh7oZQEpUY5kHEDT2wUJ8l3IjNX1L3mBqZFB56Q
	I2/dtTF0oFamtVKSjx2hbfBnE7CZ017DevLzYY16dPS1gQb/q/zpGmfYZ7SB0Asjs1CHoNN2BqW
	rLyhr8uy/UMgJf9/ecFqBE7fZ0seX2D2sehqA
X-Gm-Gg: AYBFou1rMKCf/Qawf0K+Y2Nq3wWOxG8OIhnQXP6/RPTFDoRRnZwXqEojbAjN5FjBcdk
	DWEiQyD2mzDkNJwfOcz0HjW5X13vrsT2oq8dlb+qGFwvLuFhGLZSpzQsmlA7RnvDCZPyuwzcQ/G
	Syl3j3Fj/81nzuFjfWLg9lIm00rGzc8TDQr3zLIlwHDmdEVCWt8cg1W4ArK+eSBVi2/1I9snYBE
	b5G7VOi8jVLG6ZevuXfSW7R6ysiJExKt7rHVQ1aKqRLuehUgC1EFni+SGRPN69X893niDJzhiHr
	Cw9iNG1jvJvD2ocx8IrtOOOesYkjgwFUwOzmxFAjnQErQmJjYNEc+3pmwfGMI1zL3ZBs333v0wH
	7F61/tPdAUBPukQZYmQvdMAvZX/z+EG8FrAkyVomP1DBDyreHnT9jaiawxA==
X-Received: by 2002:aa7:d587:0:b0:6b5:fb30:5651 with SMTP id
 4fb4d7f45d1cf-6b7c0be070fmr3153436a12.26.1794660112267; Sat, 14 Nov 2026
 04:41:52 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com> <78571ebf5fb578852f8bae35fbf7cb3eb3a0bd46.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <78571ebf5fb578852f8bae35fbf7cb3eb3a0bd46.1791270504.git.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 14 Nov 2026 13:41:15 +0100
X-Gm-Features: AclHuK_a7_y69KYxWqkOHNWiHtxCNy97TnE_Ov1Lgu0Bj24gTnmAb3Fw8PEIicw
Message-ID: <CAHwyqnXpTTmZxYLixfOrJtE0mcA2B+vib-DW8gX3dN82eaPhgg@mail.gmail.com>
Subject: Re: [PATCH 6/6] push: suggest a force push after a clean rebase
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I know this didn't get any attention, but I'm using it now via seen,
and it's such a nice feature to have:

```
On branch fetch-shallow-narrow-refspec
Your branch is ahead of 'upstream/master' by 6 commits.

Your branch and 'origin/fetch-shallow-narrow-refspec' have diverged,
and have 359 and 6 different commits each (rebased cleanly on
'upstream/master').
  (use "git push --force-with-lease" to publish your local commits)

nothing to commit, working tree clean
```


Harald

On Tue, Oct 6, 2026 at 9:08=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> After rebasing pushed work onto a newer upstream without changing it,
> "git status" says the branch was rebased cleanly, but a rejected
> "git push" still suggests pulling from the push branch, which would
> only bring back old copies of the same commits.
>
> When the commits outside the upstream carry the same changes on both
> sides, say what "git status" says and suggest only the force push:
>
>   hint: Updates were rejected because 'origin/topic' has diverged
>   hint: from your current branch, which was rebased cleanly on 'upstream/=
main'.
>   hint: Use 'git push --force-with-lease origin topic' to replace it.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/push.c           | 20 +++++++++++++++++---
>  remote.c                 | 17 +++++++++++++++++
>  remote.h                 |  6 ++++++
>  t/t6040-tracking-info.sh | 25 +++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index d918723d43..bf6e5386a0 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -301,6 +301,11 @@ static const char message_advice_pull_from_branch_be=
fore_push[] =3D
>            "from your current branch. Use 'git pull %s %s'\n"
>            "to integrate the remote changes.");
>
> +static const char message_advice_force_after_clean_rebase[] =3D
> +       N_("Updates were rejected because '%s' has diverged\n"
> +          "from your current branch, which was rebased cleanly on '%s'.\=
n"
> +          "Use 'git push --force-with-lease %s %s' to replace it.");
> +
>  static const char message_advice_pull_or_force_before_push[] =3D
>         N_("Updates were rejected because '%s' has diverged\n"
>            "from your current branch. Use 'git pull %s %s'\n"
> @@ -356,15 +361,24 @@ static void advise_pull_before_push(struct remote *=
push_remote,
>                 tracking_name =3D refs_shorten_unambiguous_ref(
>                         get_main_ref_store(the_repository), tracking, 0);
>
> -       if (tracking && (reject_reasons & REJECT_NON_FF_HEAD_REWRITE))
> +       if (tracking && branch_rebased_cleanly(branch, tracking)) {
> +               char *upstream_name =3D refs_shorten_unambiguous_ref(
> +                       get_main_ref_store(the_repository), upstream, 0);
> +
> +               advise(_(message_advice_force_after_clean_rebase),
> +                      tracking_name, upstream_name,
> +                      remote->name, branch->name);
> +               free(upstream_name);
> +       } else if (tracking && (reject_reasons & REJECT_NON_FF_HEAD_REWRI=
TE)) {
>                 advise(_(message_advice_pull_or_force_before_push),
>                        tracking_name, remote->name, branch->name,
>                        remote->name, branch->name);
> -       else if (tracking && (!upstream || strcmp(tracking, upstream)))
> +       } else if (tracking && (!upstream || strcmp(tracking, upstream)))=
 {
>                 advise(_(message_advice_pull_from_branch_before_push),
>                        tracking_name, remote->name, branch->name);
> -       else
> +       } else {
>                 advise(_(message_advice_pull_before_push));
> +       }
>
>         free(tracking_name);
>         free(tracking);
> diff --git a/remote.c b/remote.c
> index af8d026073..623ff98a01 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2391,6 +2391,23 @@ static bool stat_outside_upstream(const char *bran=
ch_name, const char *base,
>         return true;
>  }
>
> +bool branch_rebased_cleanly(struct branch *branch, const char *base)
> +{
> +       const char *upstream =3D branch_get_upstream(branch, NULL);
> +       int ours, theirs, ours_unmerged, theirs_unmerged;
> +       bool same_changes =3D false;
> +
> +       if (!upstream || !strcmp(upstream, base))
> +               return false;
> +       if (stat_branch_pair(branch->refname, base, NULL, &ours, &theirs,
> +                            NULL, AHEAD_BEHIND_FULL) <=3D 0 || !ours || =
!theirs)
> +               return false;
> +       return stat_outside_upstream(branch->refname, base, upstream,
> +                                    ours, theirs, &ours_unmerged,
> +                                    &theirs_unmerged, &same_changes) &&
> +              same_changes;
> +}
> +
>  static char *resolve_compare_branch(struct branch *branch, const char *n=
ame)
>  {
>         const char *resolved =3D NULL;
> diff --git a/remote.h b/remote.h
> index cca02033b9..dd8ef6c443 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -408,6 +408,12 @@ int format_tracking_info(struct branch *branch, stru=
ct strbuf *sb,
>                          enum ahead_behind_flags abf,
>                          int show_divergence_advice);
>
> +/*
> + * Return true when the branch has diverged from base only because the
> + * work on base was rebased cleanly on the upstream of the branch.
> + */
> +bool branch_rebased_cleanly(struct branch *branch, const char *base);
> +
>  struct ref *get_local_heads(void);
>
>  /*
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index b53034ba36..b5339e1452 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -804,6 +804,31 @@ test_expect_success 'status.compareBranches after a =
clean rebase of the push bra
>         and have 3 and 1 different commits each (rebased cleanly on ${SQ}=
origin/main${SQ}).
>           (use "git push --force-with-lease" to publish your local commit=
s)
>
> +       nothing to commit, working tree clean
> +       EOF
> +       test_cmp expect actual &&
> +       (
> +               cd test &&
> +               test_must_fail git push 2>../push.err &&
> +               git push --force-with-lease origin feature19 &&
> +               git status >../actual
> +       ) &&
> +       url=3D$(git -C test config remote.origin.url) &&
> +       cat >expect <<-EOF &&
> +       To $url
> +        ! [rejected]        feature19 -> feature19 (non-fast-forward)
> +       error: failed to push some refs to ${SQ}$url${SQ}
> +       hint: Updates were rejected because ${SQ}origin/feature19${SQ} ha=
s diverged
> +       hint: from your current branch, which was rebased cleanly on ${SQ=
}origin/main${SQ}.
> +       hint: Use ${SQ}git push --force-with-lease origin feature19${SQ} =
to replace it.
> +       EOF
> +       test_cmp expect push.err &&
> +       cat >expect <<-EOF &&
> +       On branch feature19
> +       Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +       Your branch is up to date with ${SQ}origin/feature19${SQ}.
> +
>         nothing to commit, working tree clean
>         EOF
>         test_cmp expect actual
> --
> gitgitgadget
