Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF321FF29
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114757; cv=pass; b=f9O0Vx0D0sxeOb32s1DZeiQWFhzOWpDM2lCKAUSMy48HweP4wl/d64diMqqoLubArTnegflLNvqak/bRTgFra2eEXz7rvgYfyXUNNlP8+vqiWbtBXFye17kL66zFUTzBUrFtRvbHOgaY0cyh18e69N9N+/I1HBZemaPVWsH9eNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114757; c=relaxed/simple;
	bh=4y2wfEK43bnn5qaGBBiKiEEs/Hnz3Fl557bluaB2QYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USB4ZNdrdlHoue/5+DpbmycTuY4XyRnI+MO6B1YIYXYZq03kaWXmCN/NS/xymM3cXr+LhPfcpWexl8unjgU7PaqNkIGPdKzQl424+BNHeFLA+trf1Hqntzy9uyqdpQdzaxY9th278M3S7NY0bTMFuQmiGvW5mkQl1P2REWX4Rvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wukrq83F; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wukrq83F"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso1221170a12.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 04:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791114754; cv=none;
        d=google.com; s=arc-20260327;
        b=BNl2hOAXbeObs6yLbG9trDTihsnT/f9ootFgXuktrd2DcypuB/N8HOEkUWNpw1xz8p
         RUNrjjT80ASeij9/L5v+X+8Okm9cOCVmiwx/eHeYaH71qe01Ol8ZcW/yjMKefyi3qlN+
         xZXReleMjR/DlRnCwZxKmFP3GIv9w8X2DWA1IemCP0Cc+dAX0lQbVuhIVNDecNacdPOJ
         VxUeTd7u8vXXs0KEficOYHulF93TU4Fcr2vskxaLJIpqblgYDmeVsEganKEE0Mu2EhUJ
         fVO3SVzSxbMLJkDvF9fwAsz4sEAApEgg8YMbTvVNLk/aMzGDZj/wHg0bWalWUXFAWOyI
         +wAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q5E7lhskPRI+586ZdmH6V11oEmBiSLm6Cs34W4RVjuc=;
        fh=Bl+YtnFZx5EI8RNI4EIxvEOv/oTZn3ux5MpTQ3WrDm0=;
        b=ULOWfsohJy8Gcfh+1nmYaM3BPK0AQ0bycuTyBa+0cWakeYt7L2W6M+DTKZ1IqX/sKu
         Zm3Rfh6BhYzmhGwr0MGkOUkllApfTM4h1o0aNnjcKtCZw+xLwuDtmg+vpdFsxyM+FqGR
         6L+neZsS1wce1iaXc5L4N3Tbm5QZ6BkAYX9hwkVBWuD+iv7JQXVP+D9lJUzJo4E9wJP2
         +4Y5BN37I1eWmUhkOoc8Rb0Gw3W/XVUtoL1YJXEnp9J8T92Ko8wGvlG/ovsSpcXcWXUp
         TwrX7++gTs166X43/P65CaXSjJ8Rho0oZUQp3rNXn02WLnjauSqAtnTO+WBHW+FkN/lg
         3vSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791114754; x=1791719554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5E7lhskPRI+586ZdmH6V11oEmBiSLm6Cs34W4RVjuc=;
        b=Wukrq83FgSxIFFFQZgvO+iSoGSHUVnymScMdUxpqBdWEuN7Cl5mX1iBAQFC6lBd19j
         kQtPxviauX8QDgQa4TKTH5cMg5QBytaeEWx5xv35bvk+0zWO9u0dpD5nQweRxsqU3IF5
         tKCzHu+N9nbsmfOXBnZrnWYFPXPvQQVDvVOr/zy7I8nKBx29YI8034Y64nAkN1UjCseV
         8MCEBsQF0sZSn+m/GTLW93KTmbZ6raIyQJmPVgaszjyVqzqlc5YILMvRZkHgp+5aINAp
         LqVQ62rfrOKcTxV8e793Fijn8NcX1fL5dfFvNCSBb2anJeMRaaebnL4TUH3LFItlo0wS
         eypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791114754; x=1791719554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5E7lhskPRI+586ZdmH6V11oEmBiSLm6Cs34W4RVjuc=;
        b=gBLKLQozAXwjGotaufTsTdNlszuZpf5JDbTrn+shxbV1C1t1W/Gxpmj2Nfj8l0nwx7
         3GLmojtdyby7nMXvpUWajCbVUARTCK82lGje4qEnWGlmHp7pvoJjAWcY/bgJotcN+q2l
         QWCM/1QEfhT8OaSL2diVRy8Ctwi8BOYn2Qs0PHfAQkjYqBE1Izngz3iCWzWP71w0e3h4
         tTn9GX3Tdmr2kE5cYof/MGn9uGruQJr2Sd/IBaMDtc8fyex37zvfGrkKQlas2mEgIpD8
         WzFh7iltRNFMkrjE0i6jVzamj9qHCK+B6WFscDsT1GCqEgmGThR2MzP1s9HT9HELdcnA
         6+yA==
X-Forwarded-Encrypted: i=1; AKwUvBz5nAMSZ1W2zg24hhJJUo+nIjewK3qBifJdutuGV1r/AMpD5fFGYbAF1c79T4HEk5/LlG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS8YN31x80MANGJUKvfrIxnT1rl9LcvqS8s4DXFsEH3LsXA/Qc
	opKKMxq67gC3jMzZcH7YsYxx4Y3//7L5s1gBgQ021tE1UvkfVeB1mWGGEYvxvuF4b9uB4oBB9lF
	6e5hAcSppHB7R3yxMAnEaAZ/yiShWb3APnw==
X-Gm-Gg: AYBFou20VbllEXCyWEQetILAKgULA+ugv8lST8BcAWussupQEji/DAmprpKxZpgUN+k
	WFSRfx8BZc1FFMcLp4zvkf+d2OXyX+VsX6ITOatINWni+YIGH0yY12WP5yXJzVfoccZ4U5sU/yM
	O/AQ1RiKjjkthHsbJLJ7cf/iWRC/TwybZ4Y7tqin/S9uGtg2CF8N/PTcJcO7ofB9AmuBthxUUgr
	8spulXwzSGeZn+UnEsmFBeQCsVl0PzEN5lukHJmatRwMwxbUNScWWebsFyE6iQRxECNPKdfUSit
	zQ5wlAvL3mcMPTeDeopn6PeEyL85V95d4gIN6GiIzrbFicgcUK15cSkH
X-Received: by 2002:a05:6402:4392:b0:6a9:93c7:ca57 with SMTP id
 4fb4d7f45d1cf-6af9e2e15demr5490823a12.22.1791114753707; Sun, 04 Oct 2026
 04:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com> <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
 <8b873f2e-b395-4044-ab15-f1eab4148447@gmail.com>
In-Reply-To: <8b873f2e-b395-4044-ab15-f1eab4148447@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 4 Oct 2026 13:51:56 +0200
X-Gm-Features: AclHuK89KO_ZLPFBOaEy-qc27eHuDMyRY-NDdXMTyD9dTdlV_65yNoXNU8MRYB8
Message-ID: <CAHwyqnXBLiAA+aX8uLA3UvsfD4zaMTcvj96H8DX8BhMVopwcfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test script
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 9:02=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 03/10/2026 14:03, Phillip Wood wrote:
> > After spending some time clicking around in Github I
> > think what that patch changes is not the test output of individual jobs
> > which you linked to above, but what is displayed on the summary page at
> >
> > https://github.com/git/git/actions/runs/36979818141?pr=3D2426
> >
> > That page shows a list of annotations with links to the changes in the
> > failed test file. That is a useful improvement
>
> But it seems it is only useful if the test changed is in that example.
> If I look at the summary for the CI run from v3 of this series [1] then
> I can see a test failure in t1022
>
>      linux-leaks(ubuntu-rolling): t/t1022-read-tree-partial-clone.sh#L8
>      failed: t1022.1 read-tree in partial clone prefetches in one batch
>
> If I click on the link [2] it does not take me to that test file though,
> because it was not changed.

Yes, unfortunately GitHub won't let us link to a line that was not
changed in that PR.

> That makes this somewhat less useful than I
> initially thought. The current behavior is that when you click on those
> links in the summary page it takes you to the test output for the job
> that failed which seems more useful. For example [3] is recent test run
> that had a leak and clicking on
>
>      linux-leaks:(ubuntu-rolling):
>      failed: t1092.58 submodule handling
>
> Takes me to [4] which where I can click to expand the output of the
> failing test.
> ...
> [1] https://github.com/git/git/actions/runs/36537917146?pr=3D2426
> [2] https://github.com/git/git/pull/2426/files#annotation_82189987516
> [3] https://github.com/benknoble/git/actions/runs/36033463504
> [4]
> https://github.com/benknoble/git/actions/runs/36033463504/job/10774774574=
1#step:9:5333

Is this enough to call this a regression? Then maybe it's not worth
doing this part at all.


Harald
