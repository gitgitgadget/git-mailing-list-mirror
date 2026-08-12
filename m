Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D831A807
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556488; cv=pass; b=iJ8o4P6BMTyYzKwJtfG2IZAf3+n4qIiehIP3AYtgs+dL6u16lpS9N6rTJLg+MOs+vZgQbtDSmg+HCYTNytyussbkxBOxWm2U5f0pYB9ZXKj7ppuDdLJ76yF43pLaS/c5R/SlqNPQHB+ify7idopHWXcBE3ob+jfNU8R0I36W6wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556488; c=relaxed/simple;
	bh=+kFsc7VvXd23cus1PPxHEbZst0IX8sfZaSAG5Ch0FBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BztRhdoURr1kppABh8QEvXK8pPGKp0RmCLCYqRaq55nzeAc5zmBqXSSgCFwgJe5xD1TNp/IudnEk28DL6GChVl87fsNGpWRHEmsZ6octpjfhEMDbOpI/nup5Bup0LeCUxTQTUNdXRvs+eexC6xCM4J2ZonqQrP78YgEf4wbCrkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc6/gBR7; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc6/gBR7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1198171b3a.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786556487; cv=none;
        d=google.com; s=arc-20260327;
        b=WdhOZwPj9cyfSYuD5VQbNqoHTN0uUDpA3jV6TrueA61Fx2b2F0EajiEqsvP+ugt8hT
         FYzTKmEirsXQuRqe0oMD/iO81oXl0XWGJ9l+o6fRiCJ8HvHq5Dk5zdRSyBCr8wdZQyE6
         DPyxBFi3ABCBjtti+Tv1yNVMg2t3qCjXB3j6sFgi1kZyBFXVTXMTW6PHCcuh+6tXxzpZ
         4ULi+v6b3w4fLj0CsgR5pSTPqOHp2JtsddXjsJhlxkmNMrM7PHdIBQLg4q0d+iET0zLg
         4FgaSSc2Hr583IIAp00x394uKhcT0ELALxBlP9idjuhxF2P2PGczPxaOqTwEpKGXOBt4
         bPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A5kFl+fFqjctNxjAzG0Pfa8+orE7hA5oMwcqoiVHuCk=;
        fh=pN7wu1zwD+xcQsXWuh1aXLiVhMCtwuxgzoUDjuwgVME=;
        b=G7QJecuSzUvO0HJKLLPZI6BEULfpv4KXctX8gsQYp0cY1i245djcasHbwZHN04FXCw
         DKDtkODglsQMvrtpSKYTfgiTQnLaoaN3cSH1NjFm93TFzV3DiK9ThUjH2/vKhk465Ye7
         0yHZMu75joby9q4xKbwswjQBzSudj7Q7d3K/ZOK8eg3estMZuFd+cHe6HhjuI42MaABM
         BLaqCRG+g6WtGN4hoyQBpZg5ErUzFLxIT8kCnUxcRmoZaR17CR0ZDO7n4KvlyAxr0gbL
         SYkSRw0cmRQist/YYs0DTPrlj+Wsja4v1vmtAv2afjrc6mUDT9cW4uT9FRcxvP1K5bkJ
         AO2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786556487; x=1787161287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A5kFl+fFqjctNxjAzG0Pfa8+orE7hA5oMwcqoiVHuCk=;
        b=fc6/gBR7GBisPYrP4S9/WiBkH5UP5O83uj32Ns5ZgbTkKbxBjXEjh2pXxt30yalWFx
         LjHBCCzkBGJTe+RDXO3IbFyDXuGi+vwm01za5gCyoKctdxGSLAotNzRh0jgFJ+yx4/gw
         XkkEiYJU96LGdJyl9uUo8QpF/ah6YQ+Y92B8RcEWdnLCKlD3KvELBkVQJnkywA3o9n4e
         VXiEiZeNd0FIfDxSdvJGEklf6fWCNDrdvGWo2kloInNM8KT3CkHSyvJcqT+ebcXu9mLW
         BdfGs7smaI57oxLLF9jbAO/yNZSme06QylDmiAGGdN+jlnQXKCSWkGtK+3/w26LUfdIH
         dq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556487; x=1787161287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5kFl+fFqjctNxjAzG0Pfa8+orE7hA5oMwcqoiVHuCk=;
        b=LENLP2vJ+GmkkE+Z44Xh+bPHN/VhtqCf8d1EJbqhIpbIs5s+lsv0X98hmQFxcQhyG1
         zlJUo9B/DfzlOwONDwtm3EjUf7qKpmfXmOOGnkEIuI9ChJD3tJhp3lRU7z9pVg5oV5hL
         iL/RAprVwB48ceKeJKmgc1IbH1EUojtW0Q0sKAPl+xvz3v1jL3ocA8lwgcNzkmiRORye
         lTcB+T7MzEIaQnPhayxCfhWcE+w5kyGjAc44TxCicQZFbwj83L6/BlDrajPSf4n9ChNG
         8Qf8HJtt9ejOU/kaMBIZMZvTabGtMz5qXprazhPhSGgBOdYYlXCU8bmSNAEk5O8EYGAi
         rkUQ==
X-Gm-Message-State: AOJu0YwgNjTJ4ufb/SDie+O1R9T+cxxSIjXK3W/PLbYdtg3VVfyMREYb
	tP5aeD9mmt0KLKRCxjw5jsMoxMJ0KmheTldqOUYvhpdOVSNQ4oP+byHXLcuxxIWG1ObY3yM25md
	xoujiJQX8yGIXEsxPtHc3Cc4Z4OvOExKIADkY
X-Gm-Gg: AR+sD12MvM07+boxn5YzRzJXqVAY7j1cCF3zuWaDMiQYe88+rL3/rwDD4nJdbMwQ6Tj
	Dci+Ko5fxqD1/ygUmH9nCdRTcD7QEoC8zTWVqZg5YBjtfXrYaqnuA2/KaJ3X8hSxFtFjSOc+54g
	TJv3xGa/zPMXa66dpR9LZPC68kawWDjtyo6rFXurNWJg+aQvEfJG7D4Td+o/y21+7DVzWzC5cpX
	BG2yTeebvZA/DGRxv//WRLeQSL9MY5i0aJR7gKdTCo9LLwyOEeTMjoORm7F+++lOmIt06tuIaxN
	f2+n6iclhDs18LHU+8SOhlJPszkQGqyIqL3o9jz4sFibKxW8VvdDSAzGIlJPWWq6HSJoTSZ50tM
	R5RgpEc/LXJJ03eqW2aCSHibUmOBgXsduwlCeF1dVHzf7IHgm7mooBCrLAEtkLefIJPCESScz
X-Received: by 2002:a05:6a21:3a48:b0:3c3:7ecd:72df with SMTP id
 adf61e73a8af0-3cc5547c7d5mr24034637.30.1786556486740; Wed, 12 Aug 2026
 10:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260810174047.6524-7-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260810174047.6524-7-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Aug 2026 19:41:15 +0200
X-Gm-Features: AUfX_mysVyUBjHVSTvqqMXnEa9Ye1scU9D9Ec0R0uES9hZzcP0SJuCxNy001vEA
Message-ID: <CAP8UFD2ii8C77jWpyHRYG=H7y4t-PFtR5FQB3on4bmB5FQyG4A@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 6/7] builtin/repack: add guards for --drop-filtered
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	ttaylorr@openai.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:41=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:

[...]

> @@ -317,6 +319,30 @@ int cmd_repack(int argc,
>                 if (!repo_has_promisor_remote(repo))
>                         die(_("--drop-filtered requires a promisor remote=
"));
>
> +               /*
> +                * refuse to run while another operation is in progress. =
A

s/refuse/Refuse/

> +                * dropped object would just be lazily re-fetched when th=
e
> +                * operation resumes, but triggering a network fetch in t=
he
> +                * middle of a half-finished
> +                * merge/rebase/cherry-pick/revert/bisect is a poor
> +                * experience, so this is a UX convenience rather than a
> +                * safety measure. Bare repositories have no such state, =
so
> +                * the check is skipped there.
> +                */
> +               if (!is_bare_repository(repo)) {
> +                       struct wt_status_state state =3D { 0 };
> +
> +                       wt_status_get_state(repo, &state, 0);
> +                       if (state.merge_in_progress || state.revert_in_pr=
ogress ||
> +                           state.rebase_in_progress ||state.bisect_in_pr=
ogress ||
> +                           state.cherry_pick_in_progress ||state.am_in_p=
rogress||
> +                           state.rebase_interactive_in_progress) {
> +                               wt_status_state_free_buffers(&state);
> +                               die(_("--drop-filtered cannot be used whi=
le another operation is in progress"));

Nit: I wonder if something like die_if_some_operation_in_progress()
from builtin/checkout.c could be used to improve on the error message.

> +                       }
> +                       wt_status_state_free_buffers(&state);
> +               }
> +
>                 write_bitmaps =3D 0;
>
>                 /*
> @@ -332,6 +358,29 @@ int cmd_repack(int argc,
>                 if (ret)
>                         goto cleanup;
>
> +               /*
> +                * refuse to drop blobs that the current index references=
.

s/refuse/Refuse/

> +                * such a blob would only be lazily re-fetched by the nex=
t
> +                * command that touches the worktree, so dropping it recl=
aims
> +                * nothing. This guard just avoids that churn. bare

s/bare/Bare/

> +                * repositories have no index, so the check is skipped th=
ere.
> +                */
> +               if (!is_bare_repository(repo) && oidset_size(&drop_oids))=
 {
> +                       struct index_state *istate =3D repo->index;
> +                       unsigned int i;
> +
> +                       if (repo_read_index(repo) < 0)
> +                               die(_("could not read the index"));
> +
> +                       for (i =3D 0; i < istate->cache_nr; i++) {
> +                               const struct cache_entry *ce =3D istate->=
cache[i];
> +
> +                               if (oidset_contains(&drop_oids, &ce->oid)=
)
> +                                       die(_("cannot drop '%s' (%s): it =
is referenced by the current index"),
> +                                               ce->name, oid_to_hex(&ce-=
>oid));
> +                       }
> +               }
> +


> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filter=
ed.sh
> index ba00239c9d..05d58fa456 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -146,4 +146,40 @@ test_expect_success '--drop-filtered removes the pro=
misor blob locally' '
>         test_grep "$SMALL" present
>  '
>
> +test_expect_success '--drop-filtered refuses when a merge is in progress=
' '
> +       test_when_finished "git -C repo merge --abort || :" &&
> +
> +       # creat a conflicting merge so wt_status reports it

s/creat/Create/

> +       git -C repo checkout -B mergebase base &&
> +       echo one >repo/conflict.txt &&
> +       git -C repo add conflict.txt &&
> +       git -C repo commit -m one &&
> +
> +       git -C repo checkout -B mergeother base &&
> +       echo two >repo/conflict.txt &&
> +       git -C repo add conflict.txt &&
> +       git -C repo commit -m two &&
> +
> +       test_must_fail git -C repo merge mergebase &&
> +
> +       test_must_fail git -C repo -c repack.writeBitmaps=3Dfalse \
> +               repack --drop-filtered --filter=3Dblob:limit=3D1k --dry-r=
un -a 2>err &&
> +       test_grep "in progress" err
> +'
