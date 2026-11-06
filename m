Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793973922;
	b=ThA4RDWta88bWCY7LCEpbh8nNnmNQxh0tZc5LmQVvlKp8KRwstGSUkPIMMUhJ81Dlw5S
	 mCd42b2mNpbZzhzw+34f1w9Z716T8c0hMMAOWBTeFaovk+OxrIQp7OSVLxK/IoauCNYuH
	 au1LTsNG9ocnqzMV9McWdl5OmZozFbWqrH7HFfx47qE2NY1+etM8eLJqcDW7u27QPW29T
	 g237HwvglJUDgf8ereShgG7bKevkB2lEd/RRN6nQmQ+kU7Y+3YrKhiYoagFCChM1Y03uY
	 gv6gUcXQBCesb/rYuqhaQTJI8NPyCI7SjOvLHz5ynTc07FJsVL9QnOwi9qVrJpynhag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RwN+7q+R3UWOMv8wsEaIqQb8LrMyyRfB9BvrdjmiDaE=;
	b=x6XXNatVIqdGpOjUB9IuGaxHgWrqLK2LDoBd5MqpR7r8ykwnAONMhUr6aEeJc4Bzff+l
	 MIYXIN0U3e33LV8QVhRVpY46rDQUTX5+gsLuSCQA+YNmdPRQJ/5TnqbIj531nAkGfwHiL
	 hDKmvOUICI/dc+yzDUFWCXS3fojNykjtIptAWtH3Yrb1z89+kb5YYSl61SY0+8gMHXXnh
	 xX6CH0cTavbbc2p7ITFpvBcC+gza3ZriRg1UienZFQobwQRUllJz3d/Emp1z2DeuqfwNV
	 hgh6PLYdwCEMhsIZRvPpFk135MxHSfDH5YzURHcKgGmf4hCdYqr9h8xc/jwzmrdph+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ekem/pta";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA26606A32D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA26606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ekem/pta
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so396216a91.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973921; cv=none;
        d=google.com; s=arc-20260327;
        b=ZzdAZ+gkBAWiMQF59hJZVaV55kHOWXj85D9v8RAaGClQUSAFiiOkaODR99m7VRi088
         DsR0z6+zyCzxc8EjHYhbH10rot7jynHhwXKIJpAHzYZVALatvvJA4iv5aI3llBqaTRDr
         GAPGvlyhoNR38F1ulSkUKKBzdvnemPCdZ8aRNPUeQS3Klw5TcaKBBx7a/71acHfUdKTr
         xoKoYVDpe1A3aBAJn/5+AZtdOiBlpSDhDH05pHIBV70JUGvAf11FOyN+vUrVMUWbYZxl
         RiczRApfgwCrwmZWamP1+ThVP5lSPObw1TJanxAgwQmEpBhRAFAUOJm5K4O7pjfcjBGw
         /z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwN+7q+R3UWOMv8wsEaIqQb8LrMyyRfB9BvrdjmiDaE=;
        fh=JqU+DcnW8xLP1sG9i35agVwSK7zaaVR11RHMOhyuXcM=;
        b=OypH5SjD5+0wBNtecz+asIt+VmilnCjkrJllijNPUw1F3Mwm2rRruYu2Qt/U2E6X7x
         Y5JrfzARHpx12BAlF+TYQ/At8sj0SArRZxloyBHbiy7ZkTdu5c+X3P943S2DVBWDU4BD
         cCgojUqQsoXbWIem9vxLCcF1Eh63y+IElFTugwGySTfW1b7mFnp5SncoKqcPko3q3iMe
         qpiL8N8TCnsMgVFnaYW5cEYW884eR/zcGGcocPR8L4/K4OTcPnTFCZdXnBEvnVicx2ir
         PSvLpDleRrOKeyx5KtxV8rdl1B5H4AZ1S8cNzp+vlK63gZTcEPKEQrAvXCKPMXseH3j3
         5rqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973921; x=1794578721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RwN+7q+R3UWOMv8wsEaIqQb8LrMyyRfB9BvrdjmiDaE=;
        b=Ekem/ptaJ2UGI3I09G02X6MIWrUKkY3+wa2hrGc8h1VJVoYYNlq6Xxsg5TFDzrkqsV
         uqOCcY/swrgxa7ypQGzwa6ard/D1YMbDZhFNGYHCpFJztdtgYJcrOrcNxhTKLZueC7U6
         75S62Er24NqSAFiaubkm4xslmyP/bsAb4bRjevm9danr7qE74Yva9290Nqsp2DPqFmXC
         HjKbf87SCvbzIUKYptw4Qexk8SXnyNWLCONxfsInr1BEEPFTfduFcq96tltMbJ+BG5Qu
         roFoz1wOsCe967syUT19Nu65njUNXDuHsQuDLZ8h/frVpvvcqpsrhPDIIfhdse0Wy8LB
         WE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973921; x=1794578721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwN+7q+R3UWOMv8wsEaIqQb8LrMyyRfB9BvrdjmiDaE=;
        b=MqarMajdxkWJ9QDMqwMDTLYSqYLXb5D3TD54Kyt3lY/0DCxo/AN9Psqx72k93NYgAG
         I7V5diDsgtoNJQ7uQ600kx3ufZocC+kYbNJHn+1DnnA7SjpMa8J74m+16I0PQQGZH6qO
         SRXDX4lI/o8/R1beuRukRNov+2nH4m89HSPgkllpaWk4p8r9UmABhBu3fWMaUMAKcjzp
         hpt1Uqtc3L14zwbP8Kt1oySF3gK5SLby3fBEicCR3NgV3jRPbDNUZzaGm/XeHalEyEgG
         u+HlH/uc/MgmKWh74/+sxnxryGlAOBqlSQXb3afqyNwb+jG2XH2VM+Dq0T1nCerYVFNC
         OL2w==
X-Gm-Message-State: APuU4Z8+7U1QrUgEVY6K4brrNXI5OLV/djJeGdmvojKFJOvujeyKjIvG
	IVGFA7RrOU3Zlz4ClKPa+fyLlzFaO+fMrLg4Hw0O0zj76qXoL9MOLh6KlaT8m441iUw2Zhdq0Z6
	Lmp1qKOdHzVmjj5xxFSvnXdligUeJBOw=
X-Gm-Gg: AYBFou291mqctqhpMMq8uDAaSOTb/RKlLhtv6SNgsH00udY67snF3K305ChzH+2uK41
	vYmgoWm3gxsN1TROAvMn1ExPTnHwB7j/AQl2yUglvd8eRO6QzrrYubLbMmvIdbGoWCfconIKZ0A
	aFs3XYck9DqVQRdBKRpeduh6JljngAZoinD3L3aAQMwjUdTKMPRzHG2R9ymMUyjSCHXYJCcAIRt
	gDihXqBsXlO2Nh93GNcWfslKhjp8tGcFNl7ghZscDS3C1laDZACqv2pMc3YQBzdW3TH6gVbX+pL
	xW6R3tkjqMjLJpQUjbOuYEJIVKw1r3aVzaq+2FYXVnI9uiS1CWa6bHhw+itsDxf76ngCdkxG5Gn
	k8ApSMenV3E4D4qCdFBLwamMfV+eCiTVX3sPcs1plOBfzI470cpr5l3eG4E4F55ef1lkxKf//89
	1WTSKw+yykVNeVzfJhlTyKObEpE5QlOcX0OInlYtVPxwDgnbniSWk2cwj3vmUzetX/kHcJ4FdOi
	n3cTcaSMPzDUII=
X-Received: by 2002:a17:90b:4a92:b0:3ac:b6eb:e0de with SMTP id
 98e67ed59e1d1-3b0db6097a7mr1655420a91.4.1793973921000; Fri, 06 Nov 2026
 06:05:21 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
 <20260822-vv-branch-recurse-no-start-ref-v1-1-46dc140acaa8@zitro.id>
In-Reply-To: <20260822-vv-branch-recurse-no-start-ref-v1-1-46dc140acaa8@zitro.id>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 6 Nov 2026 09:05:09 -0500
X-Gm-Features: AclHuK9aIB38AQI0dkfHjlSvrDky2LyxTHVMo_B4UyHPAdkamDx2iVT7FPC9mhE
Message-ID: <CALnO6CAxSHWzvB+jvWw8rFXtWuj9Upv+i3g5EA_b2PkvZ=LV+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch: do not track a start point with no ref
To: Volodymyr Vriukalo <0@zitro.id>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jonathan Tan <jonathantanmy@fastmail.com>, Glen Choo <glencbz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 7:03=E2=80=AFPM Volodymyr Vriukalo <0@zitro.id> wro=
te:
>
> Forcing a branch to a commit that no ref points at aborts when both
>   `submodule.recurse` and `submodule.propagateBranches` are set and
>   the repository has a remote configured:
>
>     BUG: refspec.c:442: refspec_find_match: need either src or dst
>     Aborted (core dumped)
>
> `create_branches_recursively()` resolves the start point through
>   `dwim_branch_start()`, which leaves `branch_point` NULL when the
>   start point names no ref -- an object id, or a revision expression
>   such as `HEAD~0`.  That NULL becomes `tracking_name`, and the
>   `setup_tracking()` call below it is guarded on `track` alone.
>   `setup_tracking()` assigns it to `tracking.spec.dst` without
>   checking, then hands the spec to `for_each_remote()`, so
>   `refspec_find_match()` receives a query with neither src nor dst
>   and trips its assertion.
> `for_each_remote()` never reaches that callback where no remote is
>   configured, which is why the abort needs one.

I'm not sure this is quite easy to follow:

* for_each_remote() reads the config and calls its callback, so it's a
little less relevant (except to say that we need a remote to trigger
the bug)
* it's really find_tracked_branch() that passes along NULL
tracking.spec.dst to remote_find_tracking()

> 961b130d20 (branch: add --recurse-submodules option for branch
>   creation, 2022-01-28) added the call with no guard at all.
> 75388bf5b4 (branch: support more tracking modes when recursing,
>   2022-03-29) added the guard on `track`.
>
> Updating the branch happens before the abort, so the command does
>   what was asked and then exits 134.
> Callers that check the exit status therefore see a failure that did
>   not happen, and one that rolls back on failure would undo a
>   successful update.
>
> `create_branch()` already declines this: it calls `setup_tracking()`
>   under `if (real_ref && track)`, leaving tracking unset when the
>   start point resolved to no ref.
> Make the recursive path agree.
> Checking for NULL inside `setup_tracking()` would also silence the
>   abort, but it would put the decision in the callee for one caller
>   that has the answer already, and leave the two creation paths
>   disagreeing about when tracking is set up.
>
> Reproducing it needs all four of:
>
>   - `submodule.recurse=3Dtrue`
>   - `submodule.propagateBranches=3Dtrue`
>   - a configured remote
>   - a start point that is not a ref name
>
> Submodules take no part, so the new test builds a repository with
>   neither a submodule nor a `.gitmodules`, where `propagateBranches`
>   is set and has nothing to propagate to.

Anyway, I think we can simplify the message to something like

    With submodule.propagateBranches, we recursively create branches in
    submodules. But when the target starting point is a commit instead of a
    branch name, we have no tracking information, yet we try to find some a=
nd
    bug:

        BUG: refspec.c:442: refspec_find_match: need either src or dst

    create_branches_recursively() resolves the start point through
    dwim_branch_start(), which is NULL when the start point is not a ref. T=
hat
    NULL becomes tracking_name, but the setup_tracking() call below it requ=
ires
    it to be valid. setup_tracking() assigns it to tracking.spec.dst withou=
t
    checking, which makes its way to find_tracked_branch() and
    remote_find_tracking() when there is a remote present.

    Make the recursive path agree with create_branch() and guard against bo=
gus
    setup_tracking() calls.

    Since submodules are not necessary to reproduce the BUG, omit them from=
 the
    test case. A remote configuration and recursing through submodules with
    branches are required.

perhaps?

> Assisted-by: An LLM.
> Signed-off-by: Volodymyr Vriukalo <0@zitro.id>
> ---
>  branch.c                    |  2 +-
>  t/t3207-branch-submodule.sh | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/branch.c b/branch.c
> index 243db7d0fc..182fc4a3dd 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -806,7 +806,7 @@ void create_branches_recursively(struct repository *r=
, const char *name,
>          * tedious to determine whether or not tracking was set up in the
>          * superproject.
>          */
> -       if (track)
> +       if (tracking_name && track)
>                 setup_tracking(name, tracking_name, track, quiet);
>
>         for (i =3D 0; i < submodule_entry_list.entry_nr; i++) {
> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
> index fe72b24716..54f7caeb2f 100755
> --- a/t/t3207-branch-submodule.sh
> +++ b/t/t3207-branch-submodule.sh
> @@ -98,6 +98,23 @@ test_expect_success 'should respect submodule.recurse =
when creating branches' '
>         )
>  '
>
> +test_expect_success 'should move a branch to a start point that names no=
 ref' '
> +       test_when_finished "rm -rf no-submodules" &&
> +       git init no-submodules &&
> +       (
> +               cd no-submodules &&
> +               test_commit one &&
> +               test_commit two &&
> +               git remote add origin . &&
> +               git config submodule.propagateBranches true &&
> +               git config submodule.recurse true &&
> +               git branch branch-a HEAD~1 &&
> +               oid=3D$(git rev-parse HEAD) &&
> +               git branch -f branch-a "$oid" &&
> +               test_cmp_rev HEAD branch-a

I'm having a hard time understanding this test.

We make a branch on HEAD~1, which is not a ref, so wouldn't it trip
the bug prior to this fix? Anyway, let's assume it didn't---then we
move the branch back to HEAD and check it. That part makes sense.

So as for the HEAD~1 business: the beginning of your mail did say
"forcing" a branch, which I missed in my rewrite. Does this bug not
trip when the creation is unforced? From the analysis you gave, I
don't see why forcing would be a requirement, so wouldn't "git branch
-f branch-a $oid" (where oid is resolved HEAD~1) do it? And then we
could still keep the test_cmp_rev against HEAD~1 and branch-a.

And indeed, I can provoke the BUG in a repo with just

    git -c submodule.propagateBranches=3Dtrue -c submodule.recurse=3Dtrue
branch t @~3

for example, although "t" is still created.

> +       )
> +'
> +
>  test_expect_success 'should ignore submodule.recurse when not creating b=
ranches' '
>         test_when_finished "reset_test" &&
>         (
>
> --
> 2.55.0.2.g927b4b9963

--=20
D. Ben Knoble
