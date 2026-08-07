Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089462EC54A
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071739; cv=pass; b=Ie4tGrvaufWDXi5b3xc1CtLig7hXUGof2c7oOrt7/I5a47rk3EtB50PHb21KH/uayYwkjEQx3XlIzF7OAE086PMCrXL7UsrsfwPn7O8QWp1z+5FP6gtlBZxHN2iXXjW/xU9IfVwrOtvtpq4IPj5pwE1Rrerbdt3IkGZNTHH6/pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071739; c=relaxed/simple;
	bh=x/rExSLHLM3ZRbzcNfMBYgdlz8eAAmLojqpYk6DG3fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxCHMdPUeBDyYlIqml3u6PsDd7IC9fE0KUZZg1/sZr3OkPZMQyQEOp5eZjyGcn50Gue6PENiw5zZK8jeQ4iofZJjy1OON26XSATY4SJu8ct6d16bil5y+SIWvGBaDO2FPDVd4NtOOTMpy7fdVpPK1fP/+dBXsVBD/QddpQGbkTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZpno9/D; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZpno9/D"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-497e6956acfso1214242b6e.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071737; cv=none;
        d=google.com; s=arc-20260327;
        b=azaddI31sNqBU+XwvdOyksO31l4Ts2pP56C47W4X7VfyNN+u/1VlGro0DK/IMrFN5D
         6dC1iPt9kcC0zH/C3mHqP4wOwbxEI+pp8Arxm5r7OgUpBdYc6hSUrGWbvYKgVIkrRY67
         mmd8VropW5F5xhE2n0kr+1uFxynwU4Lp9UnABn2EbLhU7/H1Dtg0Xrp1qYFOB2OsNTL/
         iAfwzhf/mVEx2iBvQ42u+6Q/y378CVkG5bUz52TelaXsfErvfQLC3WDFrtNuhT1E9g0d
         ixbeTPiNnRkJQSpO8Cdp4s+Pa/U5aPUC/4bQr8HZZgMS/SBpSYCLr/+TR2Ui96KVnESP
         nvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZ+Ljgo7yeImKlW49lWJNcjK7yORaY4mIvvIvG5JvOM=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=daCNmxUv6hHhZ06mxu8UuM1IT/SVZQxrGVrUFlT03pwt/dm95zPZ0hfwB9uVhha2jD
         iV5QYVheM6QCA/sLwtwDwKao2Pg4phL3cB5fZreIJ4TtxdNB1O5uFPdK8MqhlUaWPZuU
         kaQbG+wtIs0x6iaLSoNcUVeDdhseBeqqcTvQ/kbIX+y5geu2B6eW3BHX1HclVCVv7MvS
         MymkP5ZQ6wDL3Sh0X2WWeIUWaosqFPpff9Hdd6bWhohCxRnxg/9NOCNq5QRK3Zyxblzl
         kbADW73azitWUoVL3x6HvqS/2oj2x8m6yEZAVGN19HeIUvktGHeldRNkW+nFh/U9S2wJ
         zYJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071737; x=1786676537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GZ+Ljgo7yeImKlW49lWJNcjK7yORaY4mIvvIvG5JvOM=;
        b=qZpno9/DL2bfuJO18nXfeZXgcKaWeg+xTTv2YrQHC3QJjZ+fdeexIxnnruIfqfWQY6
         qDbSoEfnKoOIWhqsA6GrgAUnGTk4N95ShwhCV7TTnPth1VuXfIbO/Ct0/b7HfHFmZXte
         PQFkszEQH2+1qIAL/r96uSHbirtRbUO9vHNi0FxV2WthwSsxaA6WLMTavHzUFCThSNpq
         0KzXKsW0wYaIUT7Pt7haqXPpSUm/UE7qZCem0/HxhVgEK0G43NWRQSZsx40c9bXXPjOB
         szjSt2UzlvCPk39MHCCImnNNg+yY1Fu1vmWqSgWSIkcS+EhXRYKq1j97QlDLGUQi8mdj
         p0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071737; x=1786676537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZ+Ljgo7yeImKlW49lWJNcjK7yORaY4mIvvIvG5JvOM=;
        b=fTGftCHQ9rVzDcpW8OUmkGjmK46qTwzHp4D3IMWltMZ8aGzGvdLcuzlmJZ4mUhYnNj
         JyWxnSgXHekrw0GvwIoh9Yfass8TGdlZFIc/xPAcgxDe4tr4hrsVIuWpOgksxzt5r7A0
         267YaFGTm/zoEfunGJvXZACRdf1nbzfJzNo8tBuWe4JgKSbdWAcVU128BXX4oOsvTxtE
         NbhCSRJmdAFWaILurf2Kt89y0tksm2q/ihijJRk8f89hM6jIYnmp5/FDFnLv1PY0ukKa
         rJRAom2NKsFvgQMAEDh4yW5+D5A2Xs18NLVgsHc2uzKtGx2hssk88QWt3sIGGP79eAxn
         WI6Q==
X-Gm-Message-State: AOJu0Yxc4dJBWpb/6qO06hUDLsLyinoUPZ3ZQwm1ZaK+yAnC85DJMj8m
	uVnmjCkGKX5v3g4Wegp3IdiIJqluHPByUNedTMLTyOuUHJ1ecgTeQdFrsf2lt5JKFfJx2WcqPiY
	BDdtY9eNTrhlkbKV1SSxlT9bCN15Iszk=
X-Gm-Gg: AR+sD11Xng8irB7ZR/Q08uZy6YsRGngKdI5JygwZKSLVS1xmzgI/vzUtlp3/QCei2oL
	Auj8oyZUQe7yIYcptOXEyVsnVtrXUELXecdcBXI9YD3KGczHWdBw6C2ZmCpIvCn752C6G+os1a+
	Q+6vxtdBOLVF+6rpNNfbC2Sfxt5ngj25WQtgk99WPrXyz3XtD8/8FTWjLMJQGXRN5BBKMoYni87
	UU9YPlhj0xFHPxaAozQzUwgLk4s6ctRUxyInLpoH/Uq03h201OXB2S0dIWge2nreF37gdgQU1V1
	b9MuLLFrfgMRyTK8dCCz1QV+e+RSUAxBTWQd8xR3RPoBZ9FYBFY9YbDavig7b3Ju8dWtfSOdNIo
	y1aQsewW6yK/8Jx3juMy2Ou7dH9uWPqAAWXxYuz8OAwRh0IENq2I7lxBf0JLP4Q==
X-Received: by 2002:a05:6808:ec9:b0:4a4:cedc:6859 with SMTP id
 5614622812f47-4afc4df6419mr6847826b6e.4.1786071736718; Thu, 06 Aug 2026
 20:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <75d58639fc89f4f789b1b7befe8f0968bd841be0.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <75d58639fc89f4f789b1b7befe8f0968bd841be0.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:02:03 -0700
X-Gm-Features: AUfX_mxvV3e52My0j6-QVq9proSuDw24NXnj_bEoO-Ie9vDHGJ9UqXQDo8uFsaE
Message-ID: <CABPp-BF5SKi9GkCegvwzEU+DQB3pAcqtBSumWVbsFk4a2ABtew@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] t6600: add clock-skew topologies and step counts
 for edge cases
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:05=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add topologies and tests exercising paint_down_to_common() under
> clock skew, where commit-date ordering (v1 commit-graph without
> corrected commit dates) violates the topological invariant that
> children are dequeued before parents:

I love the care and attention being put in here to test all the edge
and corner cases.

>
>  - se-*: side-exhaustion fires too early when one paint side fully
>    drains from the queue while a low-date ancestor on the other
>    side is still queued
>
>  - se2-*: side-exhaustion returns a too-deep merge base because
>    the correct (closer) base never receives both paint sides
>
> Also add step counts to the edge-case tests from the previous
> commit, a mixed finite/INFINITY generation topology exercising
> the transition from INFINITY-generation commits to graph-backed
> commits, and step counts for the grid-based merge-base test.

Another nice addition.

>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  t/t6600-test-reach.sh | 98 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 45aa26cd44..55aa220bb3 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -140,6 +140,48 @@ test_expect_success 'setup' '
>         git branch -f pi-X-br "$pi_x" &&
>         git tag pi-X "$pi_x" &&
>
> +       # Clock-skew topology for side-exhaustion testing.
> +       # D is the correct merge base but has a higher committer date
> +       # than C (its child).  With date ordering, D would be dequeued
> +       # before C, causing side-exhaustion to fire too early.
> +       # Generation ordering prevents this by visiting children
> +       # before parents regardless of dates.
> +       #
> +       #   se-A (date 7000) --> se-C (date 3000) --> se-D (date 5000) --=
> se-root (date 4000)
> +       #   se-B (date 6000) --> se-D
> +       #
> +       se_root=3D$(skew_commit 4000 se-root) &&
> +       se_D=3D$(skew_commit 5000 se-D -p "$se_root") &&
> +       se_C=3D$(skew_commit 3000 se-C -p "$se_D") &&
> +       se_A=3D$(skew_commit 7000 se-A -p "$se_C") &&
> +       se_B=3D$(skew_commit 6000 se-B -p "$se_D") &&
> +       git branch -f se-A "$se_A" &&
> +       git branch -f se-B "$se_B" &&
> +       git tag se-D "$se_D" &&
> +
> +       # Clock-skew topology with redundant ancestor for
> +       # side-exhaustion testing.  MB1 is the correct merge base;
> +       # MB2 is its parent.  A reaches MB2 via E (high date) and
> +       # MB1 via C (low date).  B reaches MB1 via D.  With date
> +       # ordering, side-exhaustion would fire before C is dequeued,
> +       # missing MB1.  Generation ordering ensures both are found.
> +       #
> +       #   se2-A (date 8000) --> se2-C (date 2000) --> se2-MB1 (date 500=
0) --> se2-MB2 (date 4000) --> se2-root (date 1000)
> +       #   se2-A              --> se2-E (date 6500) --> se2-MB2
> +       #   se2-B (date 7000) --> se2-D (date 6000) --> se2-MB1
> +       #
> +       se2_root=3D$(skew_commit 1000 se2-root) &&
> +       se2_MB2=3D$(skew_commit 4000 se2-MB2 -p "$se2_root") &&
> +       se2_MB1=3D$(skew_commit 5000 se2-MB1 -p "$se2_MB2") &&
> +       se2_C=3D$(skew_commit 2000 se2-C -p "$se2_MB1") &&
> +       se2_D=3D$(skew_commit 6000 se2-D -p "$se2_MB1") &&
> +       se2_E=3D$(skew_commit 6500 se2-E -p "$se2_MB2") &&
> +       se2_A=3D$(skew_commit 8000 se2-A -p "$se2_C" -p "$se2_E") &&
> +       se2_B=3D$(skew_commit 7000 se2-B -p "$se2_D") &&
> +       git branch -f se2-A "$se2_A" &&
> +       git branch -f se2-B "$se2_B" &&
> +       git tag se2-MB1 "$se2_MB1" &&
> +
>         git commit-graph write --reachable &&
>         mv .git/objects/info/commit-graph commit-graph-full &&
>         chmod u+w commit-graph-full &&
> @@ -323,7 +365,8 @@ test_expect_success 'get_merge_bases_many:pending-sta=
le' '
>                 echo "get_merge_bases_many(A,X):" &&
>                 git rev-parse ps-B
>         } >expect &&
> -       test_all_modes get_merge_bases_many
> +       test_all_modes get_merge_bases_many &&
> +       test_paint_down_steps 6 6 6 6
>  '
>
>  test_expect_success 'get_merge_bases_many:infinity-both-sides' '
> @@ -337,7 +380,34 @@ test_expect_success 'get_merge_bases_many:infinity-b=
oth-sides' '
>                 echo "get_merge_bases_many(A,X):" &&
>                 git rev-parse pi-B
>         } >expect &&
> -       test_all_modes get_merge_bases_many
> +       test_all_modes get_merge_bases_many &&
> +       test_paint_down_steps 5 5 5 5
> +'
> +
> +test_expect_success 'setup mixed finite/INFINITY topology' '
> +       # Create a commit outside all saved commit-graph files so it alwa=
ys
> +       # has INFINITY generation, while its parent (ps-X) is in the grap=
h
> +       # with a finite generation. Use the ps-* orphan topology so we do
> +       # not pollute the grid-based rev-list tests.
> +       git checkout ps-X &&
> +       test_env GIT_TEST_COMMIT_GRAPH=3D test_commit pm-INF
> +'
> +
> +test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
> +       # One tip (pm-INF) is outside the commit-graph with INFINITY
> +       # generation; the other (ps-B) is in the graph with finite
> +       # generation. The walk starts in the INFINITY region and crosses
> +       # into the finite region where side-exhaustion can fire.
> +       cat >input <<-\EOF &&
> +       A:pm-INF
> +       X:ps-B
> +       EOF
> +       {
> +               echo "get_merge_bases_many(A,X):" &&
> +               git rev-parse ps-X
> +       } >expect &&
> +       test_all_modes get_merge_bases_many &&
> +       test_paint_down_steps 3 3 3 3
>  '
>
>  test_expect_success 'merge-base --all commit-walk steps' '
> @@ -347,6 +417,30 @@ test_expect_success 'merge-base --all commit-walk st=
eps' '
>         test_paint_down_steps 81 80 81 81
>  '
>
> +test_expect_success 'merge-base --all with clock skew (side-exhaustion)'=
 '
> +       # Verify correct merge base under clock skew.  se-D (the
> +       # merge base) has a higher date than its child se-C.
> +       # Generation ordering ensures se-C is visited before se-D,
> +       # so P1 paint propagates correctly and se-D is found.
> +       >input &&
> +       git rev-parse se-D >expect &&
> +       run_all_modes git merge-base --all se-A se-B &&
> +       test_paint_down_steps 6 4 6 6
> +'
> +
> +test_expect_success 'merge-base --all with clock skew and redundant ance=
stor (side-exhaustion)' '
> +       # Verify correct merge base when clock skew could cause a
> +       # too-deep result.  MB1 is the correct merge base; MB2 is
> +       # its ancestor.  A reaches MB2 via E (high date) and MB1
> +       # via C (low date).  Generation ordering ensures C is
> +       # visited before side-exhaustion fires, so MB1 is found
> +       # and remove_redundant correctly discards MB2.
> +       >input &&
> +       git rev-parse se2-MB1 >expect &&
> +       run_all_modes git merge-base --all se2-A se2-B &&
> +       test_paint_down_steps 8 7 8 8
> +'
> +
>  test_expect_success 'reduce_heads' ',
>         cat >input <<-\EOF &&
>         X:commit-1-10
> --
> gitgitgadget

Tests look like they match the commit message, and they look good to me.
