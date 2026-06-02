Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E630FF2A
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385493; cv=pass; b=pwy+xE5CnOT0dIexeqqoh3t11DMpXrCasfnJOR86u+Z/N+mMHiyAmMyEtILvmZpn90EYRwAAq/HUpoDWGOfmhMvvy0A95faEfbVysN2CO08bL68RWadwAUnPhLoMFTNZmQtmB8lyHz1QK1vpbj+hz1lYiC7zxuN10U3ohLSpyQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385493; c=relaxed/simple;
	bh=Dc3WBjy2Z5l/vuxqHwiSQtfm4MMYOt2OLYfGjGZe9Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTBPV5dxhog4zywrV4e7GKEKLtum3ZB6VIp7amuP4zQ2vl+gF+q8RcZoDnJbSyjEZvUIumrNHfTtt7MC0In0dvFs5U3kFKZIyrQBgOgROW874xzNLk8wPsSAQMt1Rk2v2b3sf8lb9ZufCnCClTqgekxBNIOeanaYds3mUfnfD3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggA44r22; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggA44r22"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e3b2a435ecso20965827b3.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 00:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780385489; cv=none;
        d=google.com; s=arc-20240605;
        b=PZezEzfrXP9p24uR833HSIN9BoUYPEfUCdghxQVS/F5RH2nCjUVpVADogN1LGTyRt7
         8FEdlbUkLwjmaHBS4pjjLEZXbZBFlpwK9+PqAvSJ+Gp2l5VHKoj1VENvFy0VH2728GA2
         sWAPIL5sMPT/iffLQjs5kw22+FiwunLlISGhBsshCQ5HfhqOw+b+T+eHf4wFR/togpCx
         HyDsvAdRTtaWEP4DvFs/KMgP1EjG+gTcYmdCQhGUOfYFLYuXIbJH/p3ldy0wq+pX0uWH
         YCAZfegIR1NJ29oIAZq5s/Qnkqj9KiEu88HfgIYcdyC8WHb3B3JxZDyWZ7Hqz7o9ZOEF
         HnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cW9/Ots5yVYW2XT+iWzfLzDBplbh+qc6IwK7czNZZHc=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=G2PyUMv5HxaY46LPeSHulUhZARrZPpTOAjL8wu/vcK4FzKhdY8LJFW5BGXnueqsTk/
         oxpf2p3A4BBqLmAAC/3eCNH6NiaBmXM8W9bpxKyMpFxLu6CiAH9xYBsx33z7NAhYboGs
         Q111LMpbcNs5feC/ozoCe3ZIqO/jyRqm7vVYnY2Y9bW5C27Bjzl3H79urczsbT60lRYo
         pqA3AT4RQYth8xAd6FbLQ1q1YZaeFi4i5Lz/j48gve6Jx0YRHIgU12WOv0oMpz4Sqx5v
         LahaPUykq6j8y913fNrYyRi1i5wKxxZ9yPlsFqtSGjufLVGGQR+6QyRcBOV8RWHHu0ry
         eY9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780385489; x=1780990289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW9/Ots5yVYW2XT+iWzfLzDBplbh+qc6IwK7czNZZHc=;
        b=ggA44r22nd7+PGkg6Mfpf4Je5X/YFJsFCf1Xtd8sRF5vkHLm6VkxtF9KFroMQxSYwv
         qgEoNva3NeRJM0PV0BsePNQP4htNMOKEGnBg9rB94rB6K9Z2nWCp0pyT2hP/h3M8Pyhw
         CJZZomO9rKTDeBrl2dAWtruMnwZzg6PveYlpuhBmtCWEW7NRvzB6H/OhtrsdmuEBJkMJ
         njZ48WO+bqbsK5MmfC+3l4UUdDN/mZDlUJULj6t5Rx/6uO2K7as02IZmO3aaHBpYLp7j
         GUIYlKSA2LEGjtrpLBhITyuzQOft9Zm4HwBmfJKaOfOiYPVYKdJqiUJzMcR+XhiuQurP
         qyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385489; x=1780990289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cW9/Ots5yVYW2XT+iWzfLzDBplbh+qc6IwK7czNZZHc=;
        b=W3byvUPdMGg7wTgUowvBAzjZ/kMfumL5hIlQ9B5mH6SC6OFJR0t1QNZKwgNVd7DgV1
         IWMCsJR4/TGx4ZhNENmtJbtfL3XwyIutQ55OLIwtP/piuw1FB8nVgXy+9bpLVM5yk/H2
         2j47touZwRfa3ZgKsmfW1H/VqE00ABpDUQkSLsTNSo4yjpwndFdDGKB2YNLlxFuSMJNY
         l8tjStSEWXA2bBuLtvQvseo3PMIhIZ9rucrf9UZL+l/CwEfdKcETw+V0WIid5+Sc8ldj
         jHK7/eg4dh1N3zuEDFvdi5K6QUBQxx0hmsUCf7BVYoU9PRA0gjnCInbbYB1AF3Pu+ot8
         37GQ==
X-Gm-Message-State: AOJu0YyvSrziOoCK1JWmTtP0lhmjjTecjJw1E+r7UvJyY8XipehPdeN4
	kvNMBlS0XVIzgauHVhFge4MF8X/y2raGsOkX9dF8QhFuDmWaBStQQlsRs1eRZrDrfAGVcIzGN18
	VQvlSkrMKXd13p65FpHndeQA91A5UFm7JJI6gDho=
X-Gm-Gg: Acq92OEEYBQoWdI0EaQgnQuX+XCjpuDvk4yt0WBZhHY+EOS5dQJiGuuN8h1GlVMKuy7
	ajTT1DP91ZmB42ozz5kZn7Ydna/oNRDqwgAmouakoRQocjHi80YGuzFIyG7XdJWdaBf7DurhoWB
	Pyri+kqgOhbg+keoTVqk5cOljkbXTIjzRCSzzGoxpnzbrvqySkucSnYBlbFO9eCg5IFJdcgHGEt
	A6PFH07iqaA36Y3hwbGZw0p4HQrBcudu7Jx2M+tBFvauBzqYUaZM7JpIhQtFU6z2jmh4dPPmpw1
	hTuh3S9HdrDLVe1R8R4Sw3UJoX7eLnV5Ff8QK986C5dFtg3Swo/G4Nhek41iMaTLBU1rqU/vR+1
	Kw5MWLAAtXxwZbrTz7z6wj0wHOGJgAqIwcTiJ9XyIuBfgFcq533fyxrwLtmJzM8JDXvbAk0JF/l
	I1TGgfXMO5Azc1lQk=
X-Received: by 2002:a05:690c:e34b:b0:7d0:261a:6bd with SMTP id
 00721157ae682-7e05f11c4ffmr130997617b3.44.1780385488986; Tue, 02 Jun 2026
 00:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im> <20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im>
In-Reply-To: <20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 2 Jun 2026 09:31:17 +0200
X-Gm-Features: AVHnY4JdQCc2yIUHpiJNGhH3ibiGizg_jdMkg9jnhAipfFs4A1UCvfd1__1M4a8
Message-ID: <CAN5EUNQbSN7+SDWcrh3jTD7SXrnD=e-fQ9Qj9778R7cy2q4b1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/history: implement "drop" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

El mar, 2 jun 2026 a las 8:16, Patrick Steinhardt (<ps@pks.im>) escribi=C3=
=B3:

> +
> +static int cmd_history_drop(int argc,
> +                           const char **argv,
> +                           const char *prefix,
> +                           struct repository *repo)
> +{
> +       const char * const usage[] =3D {
> +               GIT_HISTORY_DROP_USAGE,
> +               NULL,
> +       };
> +       enum replay_empty_commit_action empty =3D REPLAY_EMPTY_COMMIT_DRO=
P;
> +       enum ref_action action =3D REF_ACTION_DEFAULT;
> +       int dry_run =3D 0;
> +       struct option options[] =3D {
> +               OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head=
)",
> +                              N_("control which refs should be updated")=
,
> +                              PARSE_OPT_NONEG, parse_ref_action),
> +               OPT_BOOL('n', "dry-run", &dry_run,
> +                        N_("perform a dry-run without updating any refs"=
)),
> +               OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
> +                              N_("how to handle descendants that become =
empty"),
> +                              PARSE_OPT_NONEG, parse_opt_empty),
> +               OPT_END(),
> +       };
> +       struct strbuf reflog_msg =3D STRBUF_INIT;
> +       struct commit *original, *rewritten;
> +       struct rev_info revs =3D { 0 };
> +       struct replay_result result =3D { 0 };
> +       struct commit *old_head, *new_head;
> +       bool head_moves =3D false;
> +       int ret;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +       if (argc !=3D 1) {
> +               ret =3D error(_("command expects a single revision"));
> +               goto out;
> +       }
> +       repo_config(repo, git_default_config, NULL);
> +
> +       if (action =3D=3D REF_ACTION_DEFAULT)
> +               action =3D REF_ACTION_BRANCHES;
> +
> +       original =3D lookup_commit_reference_by_name(argv[0]);
> +       if (!original) {
> +               ret =3D error(_("commit cannot be found: %s"), argv[0]);
> +               goto out;
> +       }
> +
> +       if (!original->parents) {
> +               ret =3D error(_("cannot drop root commit %s: "
> +                             "it has no parent to replay onto"),
> +                           argv[0]);
> +               goto out;
> +       } else if (original->parents->next) {
> +               ret =3D error(_("cannot drop merge commit"));

Why the if block adds which commit context, but not on the else if block?

> +               goto out;
> +       }

> diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
> new file mode 100755
> index 0000000000..b320ff09b3
> --- /dev/null
> +++ b/t/t3454-history-drop.sh
> @@ -0,0 +1,513 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history drop subcommand'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-log-graph.sh"
> +
> +expect_graph () {
> +       cat >expect &&
> +       lib_test_cmp_graph --graph --format=3D%s "$@"
> +}

This function appears exactly the same at t6016 and t4215 but named as
check_graph. I was gonna do a cleanup for a commit series I'm working
on to bring that function to `lib-log-graph.sh` because all these test
files share that they import graph functions from `lib-log-graph.c`,
maybe you could do it?

Also:

lib_test_cmp_graph () {
        git log --graph "$@" >output &&
        sed 's/ *$//' >output.sanitized <output &&
        test_cmp expect output.sanitized
}

Already uses `--graph` you can drop it from expect_graph()

I can't say much more, from what I tested it worked fine but I haven't
tested very exhaustively tho,

--
Pablo
