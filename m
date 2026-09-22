Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9F53CA76
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077839; cv=none; b=ONYHW1fJeCGzk9TxIza/L3/W4x8JtGQadxfPLJPk8eANXPM1xfKQnyz2eZ6IBiHicuhH9NLgvuZtbYRmbeSPU+VHKe0IiIVK4kS9A5mvLaTMwC7IkMgqJWLDRYVyopn9l8vBcsMy7YJQgC1XKhbUOkvO5sLhawUFB907EpJV4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077839; c=relaxed/simple;
	bh=ZGWas6HXQCclGjbu/HTEcCc1SYoz+Xo1b7plWNggFRI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RRoxQTgla25BoZFTyEMp9YB7ekgoKf+y/AoMxueS8mZ1HDtrTWpQ7Sm28/zOPhV9n6RCdP1/mV7Thl3s9EaSu7HK0Ovf3RbP7hYIjL07EQfw8qU21IFFIfNLAM7+AuJoUYdj9qog+ocSRal+Z58E/dYzuHm0I69s6214rZbz6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=mHjwC1PF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="mHjwC1PF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790077835; x=1790682635;
	i=johannes.schindelin@gmx.de;
	bh=ZGWas6HXQCclGjbu/HTEcCc1SYoz+Xo1b7plWNggFRI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mHjwC1PF8YMRuAJVT0Sh2nAmXxGVNbzJ8KvT16rfZxmCdPRHDriQpVzzx8bgCkRR
	 TmaS2/1SF6ov7mifIlim/hKhnZgYlzzOC/783guunuagVlOs7Xm8ncR+EXMPyRnRl
	 /oXeYIBsX6/+m0okNOB3ZzOMF7xuAErSloRQ0QACTMVNoEJmLdiM6w4m4fvLuDfpB
	 9pFnspM3jOqni0+Hs6qP5KWntlqykQI+Wu0Pouw/VqpLzRswmi1I7B4RuGXs3K+Qi
	 h5TfVyIMPJj3olW/5tEjgS55G9/2uy54RTNanI0O7q859dKo1fbRbzWC7SVX9xtfE
	 J8G1v0n73mNaEMc8IQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1wPiuz3yWd-00fLAe; Tue, 22
 Sep 2026 13:50:35 +0200
Date: Tue, 22 Sep 2026 13:50:33 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karthik Nayak <karthik.188@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] gitlab-ci: fix the cargo invocation in the Windows
 job
In-Reply-To: <CAOLa=ZQkJui77Xz2HL4sAWsaYLAzU6EPvBk+RzKkKxoiY_8aKw@mail.gmail.com>
Message-ID: <cd4dc991-0791-c4b7-19d1-c45018ccc119@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com> <CAOLa=ZTgF+Qw_1FMUEF-YyBYo-gKnhPVk+qxd+gt1PMrt9GYqQ@mail.gmail.com> <6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de> <CAOLa=ZQkJui77Xz2HL4sAWsaYLAzU6EPvBk+RzKkKxoiY_8aKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:M0ghlD1lQvXi/0HORylQe2Sh4T+0awsGWF1t3XyCYumTMYhVO2p
 4/r9mvtMiGSi7h2XpBcfhBWog/Qp+E40C8CTeTV74zM59qDyCbRmuPzm4GJQjECSDDiAZwT
 OJQzWNMcRVzgQrtAvBqSjfHN5kqjs0sObkuTwxcOIhZf4OgqLrOQTpQru9WCxC5brd+IhJE
 GL/dLMKl9ZcYuN2acxuyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KHct5wODveA=;VPLxxu3CjK74YmF7kMfnJPsdbwd
 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
 IDyH/bHifeo4l
Content-Transfer-Encoding: quoted-printable

Hi Karthik,

On Mon, 21 Sep 2026, Karthik Nayak wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Sun, 20 Sep 2026, Karthik Nayak wrote:
> >
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> write=
s:
> >>
> >> > In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio m=
entioned
> >> > that the GitLab CI seems broken since I enabled Rust in the Windows=
-based CI
> >> > jobs. This patch series should fix it (lightly tested, but I don't =
have a
> >> > whole lot of build minutes on GitLab).
> >> >
> >>
> >> I've created an MR [1] on our team repo for testing, I'll try to upda=
te
> >> with newer versions (if any). The pipeline for this version is here [=
2].
> >>
> >> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/671
> >> [2]: https://gitlab.com/gitlab-org/git/-/pipelines/2863888081
> >
> > Thank you!
> >
> > It looks as if the `build:mingw64` job succeeded, as planned (although=
 it
> > should now probably say `build:ucrt64`?).
> >
> > The `build:msvc-meson` job seems to have timed out trying to do someth=
ing
> > with credentials, though...
>=20
> Re-ran the job and it seems to now run as expected.

Seems that now some `test:msvc-meson` jobs failed. I had a closer look:
the failures happened during the cleanup phase. Apparently there is a
problematic change in the Runner image:

All failing jobs used Runner 19.4.0~pre.2085.g4d3dddee. Its cleanup code
(https://gitlab.com/gitlab-org/gitlab-runner/-/blob/4d3dddee/shells/abstra=
ct.go#L2081)
calls `writeClearGitCredentials()`, which runs `git credential reject`:
https://gitlab.com/gitlab-org/gitlab-runner/-/blob/4d3dddee/shells/abstrac=
t.go#L758

However, this `git credential reject` then calls _Git Credential Manager_,
which assumes that it is running interactively. And that there is anything
to reject. And therefore it waits for the user to react to the open
dialog, but there is no user, so it times out after two hours.

The successfully-retried build
(https://gitlab.com/gitlab-org/git/-/jobs/16625727899) and the passing
test slice 3 (https://gitlab.com/gitlab-org/git/-/jobs/16604448474) used
Runner **18.8.0**, whose cleanup code
(https://gitlab.com/gitlab-org/gitlab-runner/-/blob/v18.8.0/shells/abstrac=
t.go#L1699)
lacks that credential-clearing call.

Might be worth pointing that out to your colleagues who are in charge of
that Runner image?

Ciao,
Johannes
