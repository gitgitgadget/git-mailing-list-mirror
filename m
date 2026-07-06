Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963653A641D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340336; cv=none; b=DEkLyZXmRKXnn9XJZI0giJfzoY8lTIqIT71suj908waXI4GDQQZYzHh/qXr0439Baveb/w2Wafs1oM5XcPzZArXYXFVFa2VxFld4whk2Lhg9wlc0eXgfFzFEb1DqI4FjjTI8lagS6vQQZ20shoqzsY9uimKGunHlCr85OYBZsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340336; c=relaxed/simple;
	bh=OemUN1X33E2StT3ockDTHeJKC49DClU2PhT8fmpZbxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGu80Kk35tZMZbTwCZVCaAnyrEe8pieGlyoDKh9kbF0u0gXSuuduza9TI6TmlyTQ/yeh2IZbIy3nPjMoE+zTnmo7+K1lphYMIYfcpCDkTPX5ifAR7LTVA6cPxg0JuSV+uoiU6cI7HqNxyutXyoUnw3dUFLWMZKBXdcYT3g8/tqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aebd77cbb4so2485410e87.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 05:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783340333; x=1783945133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qI7ncbsXIrrYM1I7qv6UzWpJDMVv/bLU7AFM41fp7UU=;
        b=Rh1CdCtVUnt+RfRHecEu1P7nW6pBxIXUo/HHOMrpC1yFxJdoqRCGy2U1FWVG0IH/IJ
         +EZXLr/ASFDU0tbvTC4Sg3e8IZS2ipdUbM1GOUFM+uDFUUeG42qrcSSjHhhssP4KFpwG
         BqFVui2l1poUmfrdR9h07A7SD6Am01YXze+LdZtLMNpRQb1fPtEyuIRACAY26FRP9A67
         EAKurneS9/zdAt40MjF8c14cFHl8fyQpkn9q9sdQxuRRtMTdLT/PSeBLs/9Wwjt17wK8
         5YXYrXWFaY0x5Ma4KJM2Fq4qld8HmFhAIplruLG1xsPtsV5Ftm0eQHQEeaEfdYvuiEyZ
         XPDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkUEei3XSsK/yPmyej0o77SOYnGtqsGuIJM+q3Fzq3sphwcYS5ngfT6srQEuBBIJfpSHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68y9UgqbKiVqq896h2RUpnW5LzbtwNlcmhkRJ7NqoJntARaS5
	4DOqdEqyzHawAoxyYtWxpvixCIgYA7n36toDeam8WgZshKYiziTGYb/Z9wHsu/H6+t4=
X-Gm-Gg: AfdE7cnwbXiuKLYZDkcSUwMfIqj6fneT30QKk91jfQ94IrFX4xilr7ips3sONt9uVfp
	Eb3quZrOay3aGEtBdZXyFQt0CSz+dnEYO8v6Srvb1vqUUz+D3Vl5zElWrCrHqJLHNePZVdWeVvC
	2oJYaEoYQ1HZNC9U7QgSSl8M0FfszVa0j5L6AlEv24w0+abF6Kl8tw4rqs9sjiK/UlZNvMDXzd3
	TPfHZYzQuRIILAIw8ORRpAN+kfFQvowV+LgXZ50vlpHOuMplse8rECYwIQ1A8qRVP8lERGijmRy
	XWuukna0b8gRJ4FtESea5lIEqRQ8uMCVkioSt9009AhFrONlY+NVWOWv1s2/boYPlBMxHxkCgQT
	39WGE4fj8/rg5tkdkHBnsohyIJrVqq9W0MLMrAC8iafUG4jpz4WenEwOD0dkws7MwQxkBlkIMd6
	5AhReb+w8hXR7xl78IHHLSfJKOPy418CxlHpAJuSYfqOyFZBTjfWb7iCwXewJdkSKJ2iqD8sQU/
	IVuD+Qm
X-Received: by 2002:a05:6512:144a:20b0:5ae:aa3d:7795 with SMTP id 2adb3069b0e04-5b007c69d19mr11563e87.43.1783340332522;
        Mon, 06 Jul 2026 05:18:52 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb4a6sm2782218e87.38.2026.07.06.05.18.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:18:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39b38d3c929so23344111fa.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 05:18:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrPIPp91QSKYBIUNMpLikmy/vcejan4eZSpuyf1UXwB93sBNauyQUjhM+PXlu/Fvw+vaUo=@vger.kernel.org
X-Received: by 2002:a05:6512:23a5:b0:5ae:b0ea:d32f with SMTP id
 2adb3069b0e04-5b007c1efddmr23135e87.7.1783340331297; Mon, 06 Jul 2026
 05:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
 <20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn> <akeW4yFC8uuu2o8a@pks.im>
In-Reply-To: <akeW4yFC8uuu2o8a@pks.im>
From: Chen Linxuan <me@black-desk.cn>
Date: Mon, 6 Jul 2026 20:18:39 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNBecLbmZwjfR5-CsNheF3rcbZ5=SQ+cwjzpFMjFr9KGQ@mail.gmail.com>
X-Gm-Features: AVVi8CcbRjpKHuF-m_YChIbk3Z7kCDPW_q_di5IB_lpByGHsCUoIBNrxgxMevNY
Message-ID: <CAC1kPDNBecLbmZwjfR5-CsNheF3rcbZ5=SQ+cwjzpFMjFr9KGQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] config: add "worktree" and "worktree/i" includeIf conditions
To: Patrick Steinhardt <ps@pks.im>
Cc: me@black-desk.cn, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 7:03=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Fri, Jul 03, 2026 at 11:13:18AM +0800, Chen Linxuan via B4 Relay wrote=
:
> > diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> > index f3892578e4ff..4e840dfdb35b 100755
> > --- a/t/t1305-config-include.sh
> > +++ b/t/t1305-config-include.sh
> > @@ -396,4 +396,132 @@ test_expect_success 'onbranch without repository =
but explicit nonexistent Git di
> [snip]
> > +test_expect_success SYMLINKS 'conditional include, worktree resolves s=
ymlinks' '
> > +     mkdir real-wt &&
> > +     ln -s real-wt link-wt &&
> > +     git init link-wt/repo &&
> > +     (
> > +             cd link-wt/repo &&
> > +             # repo->worktree resolves symlinks, so use real path in p=
attern
> > +             echo "[includeIf \"worktree:**/real-wt/repo\"]path=3Dbar-=
link" >>.git/config &&
> > +             echo "[test]wtlink=3D2" >.git/bar-link &&
> > +             echo 2 >expect &&
> > +             git config test.wtlink >actual &&
> > +             test_cmp expect actual
> > +     )
> > +'
>
> Okay, this covers one scenario. But with "gitdir:" we're actually able
> to use both the symlinked and the real location:
>
>     test_expect_success SYMLINKS 'conditional include, worktree matching =
symlink' '
>         mkdir sym-real &&
>         ln -s sym-real sym-link &&
>         git init sym-link/repo &&
>         (
>                 cd sym-link/repo &&
>                 link_path=3D"$(pwd)" &&
>                 real_path=3D"$(test-tool path-utils real_path "$link_path=
")" &&
>                 cat >>.git/config <<-EOF &&
>                 [includeIf "gitdir:$link_path/.git"]
>                         path =3D gitdir-link
>                 [includeIf "gitdir:$real_path/.git"]
>                         path =3D gitdir-real
>                 [includeIf "worktree:$link_path"]
>                         path =3D worktree-link
>                 [includeIf "worktree:$real_path"]
>                         path =3D worktree-real
>                 EOF
>                 echo "[test]gitdirlink=3D1" >.git/gitdir-link &&
>                 echo "[test]gitdirreal=3D1" >.git/gitdir-real &&
>                 echo "[test]worktreelink=3D1" >.git/worktree-link &&
>                 echo "[test]worktreereal=3D1" >.git/worktree-real &&
>
>                 git config get test.gitdirlink &&
>                 git config get test.gitdirreal &&
>                 git config get test.worktreereal &&
>                 test_must_fail git config test.worktreelink
>         )
>     '
>
> The last call to git-config(1) fails, which is inconsistent with how
> resolve the path for "gitdir".
>

I investigated the symlink mismatch.

`gitdir:` works because `opts->git_dir` still preserves the discovered or
user-provided spelling, and `include_by_path()` matches both its realpath
and its absolute non-realpath form.

`worktree:` is different: `repo_get_work_tree()` returns
`repo->worktree`, which is stored by `repo_set_worktree()` via
`real_pathdup(path, 1)`. So the symlink spelling is already lost before
we evaluate includeIf conditions.

Changing `repo->worktree` itself to preserve the original spelling looks
risky, because several users access `repo->worktree` directly, and setup
code appears to rely on it being canonical.

My current possible v7 approach is to keep `repo->worktree` canonical,
but store an additional absolute, normalized, non-realpath worktree path
for `includeIf.worktree`. For the ordinary discovered-repository case,
this has to be derived in `setup_discovered_git_dir()` from physical
`cwd`, the worktree-root offset, and a validated `$PWD`, because
`set_git_work_tree()` is otherwise only called with `"."`.

This makes your suggested test pass, but the plumbing is less trivial
than the original patch. Does this approach sound reasonable, or would
you prefer different semantics for symlinked worktree paths?

Chen Linxuan

> Other than that I didn't have anything to add, thanks!
>
> Patrick
>
