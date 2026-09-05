Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52B3FB7C1
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634637; cv=none; b=GEuO8t9QcEogSdbrwVgnRxRCVQIYP+DbpuLb5Qi4u82tUNToWthjI7NnAAdswcw6V5Fj/lq7eWz+FwfxXn+vkseucjGG2OmGoV4qEYGpo0x+YsPJxPwzcU3dQFr71sHz4AO/LWiaMWy3KMXlNj09JDRWNknMxO3hr4tsUMHTxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634637; c=relaxed/simple;
	bh=9sgLQeawx9i4tYV+tltfOhWOo9fQkhFkYgrhqRdNRxo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=gbHI1OWxgLinvYPYRip/KJ7Z44N9N9kw3rM184eWtkot8aoap5tsfWeAqH944MKPu9HmrkRElsmxeOJqWY4BGTZ2qVjWcuL3+Iou/Ip5ZVd484gJQJ2EfYfv7Gi5++rt16cEH7QfMLWMW8JbtlmR6BR9TYkvxWaU+KjM0X3V0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN3wluDF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN3wluDF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-85b293528a9so30388537b3.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788634634; x=1789239434; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dp5SK0lfpK4Dgs+134wKsMdt7cxHA55BfyxAxOI8Wdg=;
        b=TN3wluDFNNbdSPZogU6KMcMc9ypC0u3FtHPYpE8I39lt14Dl4lrLfGav09hkTkidZ9
         /xGe7J0FHS6aYXZCq/3j+pwpOfDCg+BIOLgUoJkvmjNJLrqRo0a8sGFUj83APQtbUr9r
         IqoJ2/IARUNh//Z9uzmxnwfNM0tSd/XPa8hWxQuqKxvP820KrIrB+JdUEP46Ob80U8jg
         C1v3PocT6M8DYy35corXvJmE5eji4wL0nkAWG6m4huiwa3pDnLTSIDcxz0WdZ7XrzAOp
         OGXg3WDxgxOENj+Dodbsk3wU4nmNuFsBMkfKffZBAciMWj4EBqp2fnIIeCMJtJS5EAmd
         iDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788634634; x=1789239434;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dp5SK0lfpK4Dgs+134wKsMdt7cxHA55BfyxAxOI8Wdg=;
        b=etZlOTl9/PF+JhDurZwy5wbz0tIqB7lKR3ql66tPnzpHtBugK8Ygm28tcH6Xi2nhKo
         RbK5SmE3bw7+T0BzCxjxuxc4Ld2oeibQst2q5BFgTJT7OwQeaXEiRs7VpTjV60GNaxVR
         PdUlNGgCywH2wbI8sxEfjo5j5BgWqOZJbHyMA0myPtiAA58hSRmPbcGZ0XAVrGToD/cQ
         EmtXSyurIhEANg9iUEzwKQs1niG6KinxYzSJa4/mc1/BGfKKBGV2oIRUaZB2sNvEN0dW
         +B+OLHMp+FrkZQzLOFaS6KwRZhlrxQosyngPh7k9FeSqleUMCR1JJgz9BUHbAJA5mFio
         yURg==
X-Gm-Message-State: AFuF++ldNmK81Oo4TljT3H5E1vV51x6+fytNH/nEr1v3rdBl3HHTCs9H
	LQwKXzuwhTm3Z22qpeKJ4tocIOcaaZ4lxyeoxtlBlFrRrIqxCC2JR/kJl4RrGk0j
X-Gm-Gg: AYBFou3cdvWfLfJFpxJwykcT0yuHbSeJGVjpiJbJeNc6TpKBPzFRCTZniawNH0parHk
	GOyX1o+mf/El13IgLaJldrXehJNeKjSLPnGURoS6appU3M9Pf4A9IpqKVtc93RhXQTIN0xA+Z8B
	s4iyPa4qYs4R5tJ0IsMHmV3wFlHXpGzmRnq8VGAPW0qo6ZhM6FJYbUmAswuRJIasQPmu0Ba7J4l
	Az2HPs9RaFSMwddLKSdAg1XuNcVdKYgTuY8cZSfrBcQI0ZJY1boL38xD/eZ6yRdh+RgJPjq/NDo
	4MZfUWkjJuDelcBS2ZrVJL28rk+SRTsnyAPqI6T9SURFoL460dcyVEOMZnsBCKnIkIJlBtTBF7C
	pH2cRLFL3BWKCY5XlJ+v5Y0Snt2/AhEOB02D/S/NTt0DguKhePCWgzK0QyW+9t7tIt2YH9qacvq
	oVm8UliA2NXd9/yn7Z+a+bLC3o8Xg7KgW+2dvPSoPCFdY8BhI8KgjsMxzzwMZWGhaCCuMz/oRM1
	U5/chN8FdR2ukT630Z8iSU1SAMSyqM32bLHZJc9+YT3Gir/5SIfPWJEcv1dCOZaAFGacf+f22Az
	8lrCoeX9sUUimkZO+zdWD1vkGYSgj+OrFrOZDDtix/+gGu0=
X-Received: by 2002:a05:690e:4401:b0:66f:c1bc:4040 with SMTP id 956f58d0204a3-66fc1bc85d0mr875862d50.33.1788634634595;
        Sat, 05 Sep 2026 11:57:14 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1145:a589:6cad:356])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fc939d4edsm1487705d50.4.2026.09.05.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:57:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] push: check pushed ref for --force-if-includes
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20260904210122.431757-2-tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Tyler Cipriani <tyler@tylercipriani.com>
Date: Sat, 5 Sep 2026 14:57:03 -0400
Message-Id: <D37B05ED-1B23-4B05-8B4B-EA770C85E0F3@gmail.com>
References: <20260904210122.431757-2-tyler@tylercipriani.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
X-Mailer: iPhone Mail (23D8133)


> Le 4 sept. 2026 =C3=A0 17:01, Tyler Cipriani <tyler@tylercipriani.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"--force-if-includes" ensures, "tip of the remote-tracking ref is=

> reachable from one of the 'reflog' entries of the local branch."
>=20
> But check_if_includes_upstream() uses the local per-branch reflog based
> on the destination branch rather than the branch being pushed; using
> ref->name vs. ref->peer_ref->name.
>=20
> This can cause confusing rejections or unintended data loss.
>=20
> Using a command like:
>=20
>  git push --force-if-includes --force-with-lease origin src:main
>=20
> False rejections: when src is an up-to-date branch, but main is
> out-of-date or nonexistent, then the includes check will fail telling
> users the remote ref has been updated since the last checkout.
>=20
> Data loss: when src is an orphan/out-dated branch, but main is
> up-to-date, then the if-includes check will allow the push, clobbering
> the remote main.

Hm. This case *could* be by design, to rewind and potentially
modify a remote branch, discarding new work I=E2=80=99ve already checked.

But the includes check is about reminding to do such a check.
So failing and requiring me to bypass the check seems ok.

> Find local reflog using ref->peer_ref. When using a refspec like
> HEAD:refs/heads/main, we resolve HEAD to a branch and use that reflog.
> In a detached HEAD state, the reflog cannot tell us if the history
> being pushed includes the tip of the remote, so the push is rejected.

This seems to be what I reported in the mail your cover
letter cites. So, am I reading correctly that this is no change
from current behavior?

=E2=80=A6ah, patch 2 addresses that specifically. Which, I now
remember you said in the cover as well. Oops.

It *could* be worth clarifying in the proposed log message that we are only p=
reserving behavior here, but that=E2=80=99s a very small nit.

> Skip deletions:
>=20
>  git push --force-if-includes --force-with-lease origin :main
>=20
> ref->deletion is set after apply_push_cas (which triggers
> check_if_includes_upstream). The ref->peer_ref name is "(delete)".
> Instead check with is_null_oid to detect and allow deletion.
>=20
> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
> ---
> remote.c            | 24 ++++++++++++++++-
> t/t5533-push-cas.sh | 65 +++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 88 insertions(+), 1 deletion(-)
>=20
> diff --git a/remote.c b/remote.c
> index 00723b385e..326af76eeb 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2806,7 +2806,29 @@ static int is_reachable_in_reflog(const char *local=
, const struct ref *remote)
> */
> static void check_if_includes_upstream(struct ref *remote)
> {
> -    struct ref *local =3D get_local_ref(remote->name);
> +    struct ref *local;
> +    const char *name;
> +    int flag;
> +
> +    if (!remote->peer_ref)
> +        return;
> +
> +    /* A deletion has no local history to check against. */
> +    if (is_null_oid(&remote->peer_ref->new_oid))
> +        return;
> +
> +    name =3D remote->peer_ref->name;
> +    if (!strcmp(name, "HEAD")) {
> +        name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repositor=
y),
> +                           "HEAD", 0, NULL, &flag);
> +        if (!name || !(flag & REF_ISSYMREF)) {
> +            /* detached HEAD: no per-branch reflog to consult */
> +            remote->unreachable =3D 1;
> +            return;
> +        }
> +    }
> +
> +    local =3D get_local_ref(name);
>  if (!local)
>      return;
>=20
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index cba26a872d..0c02151747 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -396,4 +396,69 @@ test_expect_success '"--force-if-includes" should all=
ow deletes' '
>  )
> '
>=20
> +test_expect_success '"--force-if-includes" should allow forced update whe=
n using differently named branches' '
> +    setup_src_dup_dst &&
> +    test_when_finished "rm -fr dst src dup" &&
> +    (
> +        cd src &&
> +        git fetch &&
> +        git switch -c newbranch origin/main &&
> +        git rebase HEAD --onto HEAD^ &&
> +        git push --force-if-includes --force-with-lease origin newbranch:=
main
> +    )
> +'
> +test_expect_success '"--force-if-includes" should allow forced update fro=
m HEAD' '
> +    setup_src_dup_dst &&
> +    test_when_finished "rm -fr dst src dup" &&
> +    (
> +        cd src &&
> +        git fetch &&
> +        git switch -c newbranch origin/main &&
> +        git rebase HEAD --onto HEAD^ &&
> +        git push --force-if-includes --force-with-lease origin HEAD:main
> +    )
> +'
> +
> +test_expect_success '"--force-if-includes" should reject forced update fr=
om differently named branches when local lacks remote ref' '
> +    setup_src_dup_dst &&
> +    test_when_finished "rm -fr dst src dup" &&
> +    (
> +        cd src &&
> +        git fetch &&
> +        git switch main &&
> +        git reset --hard origin/main &&
> +        git switch --orphan orphan &&
> +        test_commit I &&
> +        test_must_fail git push --force-with-lease --force-if-includes or=
igin orphan:main
> +    )
> +'
> +
> +test_expect_success '"--force-if-includes" should reject forced update fr=
om HEAD when it lacks remote ref' '
> +    setup_src_dup_dst &&
> +    test_when_finished "rm -fr dst src dup" &&
> +    (
> +        cd src &&
> +        git fetch &&
> +        git switch main &&
> +        git reset --hard origin/main &&
> +        git switch --orphan orphan &&
> +        test_commit I &&
> +        test_must_fail git push --force-with-lease --force-if-includes or=
igin HEAD:main
> +    )
> +'
> +
> +test_expect_success '"--force-if-includes" should reject forced update fr=
om detached HEAD' '
> +    setup_src_dup_dst &&
> +    test_when_finished "rm -fr dst src dup" &&
> +    (
> +        cd src &&
> +        git fetch &&
> +        git switch main &&
> +        git reset --hard origin/main &&
> +        git switch -c newbranch origin/main &&
> +        git checkout HEAD^ &&
> +        test_must_fail git push --force-if-includes --force-with-lease or=
igin HEAD:main
> +    )
> +'
> +
> test_done
> --
> 2.47.3
