Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395F30CD82
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515784; cv=pass; b=JKYbz5CR0KmXCxijk16YEljQEEmOsUXe46VTwqBPz3qGX/xRKDnSdkIhdTvjbxg9ltpBxwZ4xhJIc9jJBg5NnqxZjFqKS9xUFvPbhF230oFZzpRo5cFBOuUdx6LWtnsM06IwqddY1tpFe4+FkzIEplDfd/+7Wc88xF4kHGON1+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515784; c=relaxed/simple;
	bh=SKLjBvRuUqQhZL4hK052jhFO4aDsl/yv+7v7V8+CdIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCAZnPnBg9xZQam2xvWrphpAZRzfRBK/xCCMRo4xnXhGVcqJC1Ijha0iLDK9f1wiEYDQWhjgPpws1Igpcg1dLdCnT4tAALuOcTUy5/VLxPb8VwXCCut8Qw//YYhonEABFtny8VggcNv2HSBDPNgeptPqovDcv44iA9MA/OoXtOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doXD3LS9; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doXD3LS9"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af81963f35so207449b6e.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 23:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786515782; cv=none;
        d=google.com; s=arc-20260327;
        b=pYHSd2mC/x4qBlU6AXyCxPbmRg4e1MjDBj2fwDEiPNXXV+6Iifxmj2Y6JoL/LrEQ+E
         rG4PoR+DGf3oPNLJU4h4Soj4zPpJOZ2lmdsguuslHxpDVXgwiwn2UiN3EsWtuuuDvR4g
         4z20URh3sUBc1vBxxX0ZZkpMS3MJnEk3EOFCr2chn47O9F0r5K3eeJdod7TcRe+aoLow
         XtrGDm8z8Z37OHDorL0rJhpXMsOezjX438DDkxADZ/1//JNRRr8fDTUsm6/wbasZg3Vi
         yJnLMhsCiP5n/SyVVkK61yyNWT2ePKf5BYFKh0k+CafuJ60F6J3XOYUDZfZFs3fkHS3X
         R3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wC+Y7uWjXYaFjub1F/qARJTEkBBo4a35y1i73xU9z+Y=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=PXkd5jPBoKHmsY3Hy6QMcRIdrR2fa8xfoRX91XWTsfocgC9XqyVqOspLWRjNwrxpKJ
         M4UQPdFd+6Hohe43RCQNmvMQnYGydbAYsvMacoJ01E4wX/rcWMlXqUy7bx1MifT0UE+N
         bt0by7f/nlhBQuxHzUrANwhternWnGDau+l4nH98qZt+IyDBHfiI+4n+0sbLIbePFVDQ
         /q7Y1o/1kWsXXuhMV14mukQevNh5q/x6lTjAjBGCOlJAQJV3fhwNegtgPrkzIdfeiEI6
         NP/PjojJ3wCmWdTSGTHwGCzMP80nbrKELCOsjqyDNh38uraJk14Gin2N+Nf81q8VAOrD
         8Pvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786515782; x=1787120582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wC+Y7uWjXYaFjub1F/qARJTEkBBo4a35y1i73xU9z+Y=;
        b=doXD3LS9kp+Ob0robIarpodhk5fUo1nIvA02+BsrbuYpMs3kx10zY/L36YJKeDUK76
         6PtgYDuznep4/+lNaDHR8ZyGGTlfW1OLw5G20CleXGeH6vF5f0Pk8WSV6o9o1xnegdRx
         13op7xilApYt54yQyeF8jFg8z5Xnn+Cz2OMwPIe1K6hr6fIlP8pkJDtTNAAga+GGhNBK
         090c5PIj+GldSCK1WPQFPf3gpkx3hoDINU8ofOny0uuIiZvCpkQepbcMh8q97ZFrD1bl
         1Q9ukhObKDEaKJDKA1s8KKbzqgi1xEmD9yRRBvbLITnfB/FzwAbEH2Q0gd+ajTWm6qVT
         oVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786515782; x=1787120582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wC+Y7uWjXYaFjub1F/qARJTEkBBo4a35y1i73xU9z+Y=;
        b=EKw0HNSXTBVUgu5lvai9QNUHvGaH3QWtLfrCbNfWoal2305fS0NpS+p/wmbycIlgo6
         ozIIQm1tCwAZvvDqsMKU3UNtrrGkxfVkdSmBU86q5lJCEiiJMlUVwK4D5FXRRJxzEUK8
         Pvo2NfCVqj19ureAVovwIH51G+mxoZHFkBlC74LT09rtNfKEiffV1HV6PsuHo/ohGokB
         n8E8bZCcC40/ANNYcPfWQ13TUVwr066Ue24coObv/VdxPuSwa4NNWJ85DvLKTDrRW7/5
         kIv5WCJ3kB/nflBvLGm2Diwa+CBnbDhgFnqMcajdutJxpV8//mKiq4EgjBL80mwnRWrO
         VdPA==
X-Gm-Message-State: AOJu0Yxfjwh6eBw1Fw83d6BjOvLPmqH9LduRdQEiaTSVwpZ7t9UPY7PK
	eNPjrJTf7BjlN0GcOXGvXGdqhznCCIhHQI+TGdha9Zavcem+6E8XRO4y9aJTbPXVlffkxlHSrCi
	4ZUGayuBzSGGrg0VR82FtXgqqXvGwlQeNNA==
X-Gm-Gg: AR+sD13u/tQ+mih5x5HNtPjsEIV5dF7DzjbzT7xPz0TSYSnyvez+J1pgQawS8nJYgvN
	DiwOFFaNWcZ0eiDuPJwIbcmIpNA9h1pYnfRNuGevcfCa9TDC8YMOX7CsfhLIFwV3tLg6JzQS7/Y
	SppwMPeFeUdkpjq+AnEwCdhh5vd2GPDn5BfIzPTOSj1G1SMqZ3L2pV2lfhTcVmCegDaIoBLmGm1
	4jLYHpCtgnAgW5F37qLIPBrqntiASYrl7/eM/6Ny73M3BsR1iajCsG9qKJqIRgBU2nY0vsPuCXl
	vVnQannXQIvjJE3yJ7bqZQC58GyLPxqeWaU189/tqoc4zKbe00qNrIeKvnDuaAVhS4Zlpng88cg
	hJgJXvARgYsRSWY5M9IT0MkN/Ym+r19VbMAazKV4Nl4wHTWXQTf4xr2vdVBL5mdE=
X-Received: by 2002:a05:6808:180b:b0:4a3:ff0a:e407 with SMTP id
 5614622812f47-4b210bb8bc6mr2278829b6e.15.1786515781864; Tue, 11 Aug 2026
 23:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com> <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 11 Aug 2026 23:22:49 -0700
X-Gm-Features: AUfX_mwkEQR6Is3bLlOgt6ls0PIBLrQ2TARdOKn4qYF8jRVi6Box_ATC6VDlO8g
Message-ID: <CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:42=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Changes since v7:
>
>  * Moved topo_ceiling from patch 10 into patch 8 where the side-exhaustio=
n
>    gate first needs it, so V1_MAX saturation is handled correctly at ever=
y
>    commit in the series.
>
>  * Renamed "finite/INFINITY region" to "ordered/unordered region" in
>    documentation and in general tried to tighten up the documentation aro=
und
>    this.
>
>  * Added code comment explaining why termination conditions must be check=
ed
>    before decrementing counters in paint_queue_get().
>
>  * Minor wording and formatting fixes in commit messages, test comments, =
and
>    the t6099 ASCII graph.

I am quite pleased with how this series has turned out.  Not only does
it provide nice speedups, I think the structure of the series is
particularly nicely set up in a way that helps guide the discovery of
the idea behind the optimization for others to read, documents and
tests everything logically and thoroughly, and was a pleasant read.

I brought up several issues in previous versions, and this round
addresses them all.

Reviewed-by: Elijah Newren <newren@gmail.com>


But, I just have to comment on a few things individually...

>      @@ Documentation/technical/paint-down-to-common.adoc (new)
>       +
>       +When the commit-graph has generation numbers v1 and no
>       +generation floor is specified, topological ordering
>      -+(via generation numbers) is disabled.  Topological levels are
>      ++(via generation numbers) is disabled. Topological levels are
>       +correct but unbalanced -- ordering by such generation numbers
>       +can sometimes cause the walk to detour too far before finding
>      -+merge bases.  Commit-date ordering typically reaches them in
>      ++merge bases. Commit-date ordering typically reaches them in
>       +fewer steps -- see this change for more details:
>       +
>       +   091f4cf3 (commit: don't use generation numbers if not needed,
>      @@ Documentation/technical/paint-down-to-common.adoc (new)
>       +of both worlds and do not need this fallback.
>       +
>       +For v1, `paint_down_to_common()` falls back to pure commit-date
>      -+ordering via `compare_commits_by_commit_date`.  Because commit
>      ++ordering via `compare_commits_by_commit_date`. Because commit
>       +dates are not monotonic (clock skew, rebases, etc.), the queue
>       +may visit commits out of topological order.

Don't think for a second that I didn't notice you murdering these
double spaces.  You villain!  ;-)

>   3:  f857577e0c !  3:  6208bcf3b3 t6600: add test cases for side-exhaust=
ion edge cases
>      @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
>       + #   ps-T1   ps-T2
>       + #
>       + # where ps-T1=3Dmerge(ps-Z,ps-B), ps-T2=3Dmerge(ps-W,ps-B), so
>      -+ # merge-base(ps-T1,ps-T2) =3D ps-B. During the walk, ps-X transit=
ions
>      ++ # merge-base(ps-T1,ps-T2) =3D ps-B.  During the walk, ps-X transi=
tions
>       + # to (PARENT1|PARENT2) via ps-Z and ps-W before ps-B is dequeued;
>       + # then the STALE-walk from ps-B transitions ps-X to
>       + # (PARENT1|PARENT2|STALE).
>      @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
>       +
>       + # Build a side topology that lives entirely outside the half
>       + # commit-graph and has non-monotonic commit dates, to exercise th=
e
>      -+ # INFINITY-gate in paint_down_to_common. With both tips outside
>      ++ # INFINITY-gate in paint_down_to_common.  With both tips outside
>       + # the graph, generation is INFINITY and the queue falls back to
>       + # commit-date order, which here is non-monotonic.
>       + #
>      @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many'=
 '
>       +
>       +test_expect_success 'get_merge_bases_many:pending-stale' '
>       + # Exercises the (PARENT1|PARENT2) -> (...|STALE) transition path =
in
>      -+ # paint_down_to_common(). See the topology comment in the setup t=
est.
>      ++ # paint_down_to_common().  See the topology comment in the setup =
test.
>       + cat >input <<-\EOF &&
>       + A:ps-T1
>       + X:ps-T2
>      @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many'=
 '
>       +'
>       +
>       +test_expect_success 'get_merge_bases_many:infinity-both-sides' '
>      -+ # Exercises the push-time INFINITY-gate in paint_down_to_common()=
. See
>      ++ # Exercises the push-time INFINITY-gate in paint_down_to_common()=
.  See
>       + # the pi-* topology comment in the setup test.
>       + cat >input <<-\EOF &&
>       + A:pi-X

...and now you're just toying with us.  :-)

>   8:  391fa07783 !  8:  4a6603731c commit-reach: terminate merge-base wal=
k when one paint side is exhausted
[...]
>  10:  b655b24dc0 ! 10:  677e25077c commit-reach: remove commit-date order=
ing fallback
[...]

Okay, my last two range-diff comments were just jokes, but more
serious now: I think you did a nice job on the re-splitting.  Thanks
for doing that!
