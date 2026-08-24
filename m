Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359A3905EC
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610371; cv=pass; b=Glsq8o2li6cgX9tDyWai4cEs50d62ubGLbIx2Z5tXHiqhqI9JiDpT8gr7yeIeKIORIW0+HC0xd/qYdq0Ub919DhBWnPuPzVZIB29nKHcqtEf0N7uEo15AMmwrYbF40fmAJNZ+K/dJdzkLV+sDP2LOcY+TFO8pNa3mFvYD33jkfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610371; c=relaxed/simple;
	bh=MYOE3SvHrt5DNH3CfzRXX182ks0QUDgMkmX6jF7NvD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy2qisF6TVwZsW+NIc224JnW1cIUs28eLjoqF1WHFCp+bp/f3B1RKo4xL+MYln0nBtUrbcx4hj/fLpgTM7J7Wy5oXclkv4FuFsl2PhnbJQZdHKtaghS+y5whdHtO4z2PISXihVvOTrj7xXDQZGO1WbMKhmn6+XFaq720SiTaJzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSSxJZeZ; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSSxJZeZ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9061a795d76so44594526d6.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 15:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787610369; cv=none;
        d=google.com; s=arc-20260327;
        b=IizD25bPJAIvuvfabThvBwdX/JSVitimLrT8twL3QeYs2vLIY/QDVh/ojq2S+WkfD4
         xtmhvBK6gM1ydh1ECn1djX2d5/mheNGXzF4zaFD+tV6Uzx0Z063nQlSqJH0vp9DS8tjw
         MW1I1JNJKu5CNwu7aLP8VhS0DUyiumDqJd6efXwHyLHlBoS2Id/VQSIjUNAl493WxfPp
         Px8QQjHTCgosxP0DVtRBBFbSqJddvchuOTpeOjr1mXugUPZJsi7SjwzBhQTjX7ZAGiMH
         r+riaHzdsXMfITrUCLZ9oCWMOOhkosZPvDA5GLJ+IDwNr3Hbp3tqyBy1SXj89cBMjEO/
         x9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3IIeZyBoWmHzrUryk9C+ycyR9PnvuMUwFKfDHWRnZAE=;
        fh=uQBtnae+wNDXI3ZPeiO1RcBfQ8OpOnVQDeXL/xisg2Y=;
        b=p0qQ+/t2+ivT3WeqfkZFP+ZhHnmgAoZh2aVhfrEObVzJbL7PebmVGaqhss+gEDVotL
         Fdy3iMbWVkYQNH5VReSlhzuMqU2nsB4FaK7focBZnn5FsC7sMPgt/avPoZmBJx3zZ9GA
         7tQUNxJH7Q8PBN3NSH/YSI9g6EoODrV9UvQwZJKaRy3+a4J4Y6fnXKaRcjQIcmlNgt5q
         ObuShceG+krWtVpkYKO3EXfYkKo05dBP1feO3QlMqXcb3NgrXRRr48Orja3pX/UesuVn
         AwDHu2whBVeUKGF82mdwoqOeWY5qLL+Y9p3UlUHwh89vekBfcUwc/Ct/XIvHB9IhZW6L
         QIiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787610369; x=1788215169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3IIeZyBoWmHzrUryk9C+ycyR9PnvuMUwFKfDHWRnZAE=;
        b=JSSxJZeZx6BlRyXP7IP2+kbnOiAZzflr7cUx2uCZB9ie+fHt01VyUHcQFnry9Bu75g
         3lSnLyx0a6qxHXdaj3KWEqovuOu7SlFbD3xWDMsNTJl0EVqzufNab0D/vzv1tl4BxTXi
         wYcFRE37cSIGfYGfYlCCgRBgedqvMCtH15nLMAGT3GyQC2PFANGGCOTNuIJE60TovxIW
         QixugyNwbixpH+UG8hMq+Zc16iwLu/sxyxx89hZBD3bC9PS1JMNh+xdbaozJk38MEFHm
         ZV4IQZ3QxxC6+vwZExS+1ZDGIRKFq93S9UwfTO4Mp4tL7vQILgBXG2rZLzYYETD9BGTt
         w+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610369; x=1788215169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IIeZyBoWmHzrUryk9C+ycyR9PnvuMUwFKfDHWRnZAE=;
        b=nHaY/ZsWeNJ83h10J4IDGpxnsmP11U50kBe1yUnFkvdtXcVSCf6gErGLORz0+k7ST9
         G9QPm/dAWzduK1Tn5RwZX+zZaIUTm/af45+93tFCczDx0aYgqNltkaX/n+gW71C3CTPW
         kqpu08LXt2B0MAfJCm+3r+5nzdJmpgMQ36gGeMk5PK7Bk5/bqcCn0nvCtEEs9tL11DUM
         8SXlr4ynIhb2n+f4f1bjuBbXE0UqYoiXJmNw6VwGvf4RLlfESp84vvpBlkKJJ4Lr7UcL
         175nhKYY7z4YnY2cllgpwPRuzqFcxJ25IwhKkeBvGMGiKcHm4Fag+SkugfM3HfwFzq6P
         jwxQ==
X-Forwarded-Encrypted: i=1; AHgh+RpW/5yNR7eNUesp3Z8kDB3DWg18Jsu/11Ze4iByQkS7X8OK7aCQmkc/cFHiuXsrwpIpC98=@vger.kernel.org
X-Gm-Message-State: AFuF++n+KO3OCHfOJNV7rwmlikDddtiALaOW990C1nH50tK8SWcfz+2X
	rVbcY/Hu51gsho9gEWPq9juFtTb5b9XZ8GmUSFk6LBZrThFW4R3z2u+/4v4Z28245qQltGwGoN+
	xotB63SuUtqT05xiiFcJhIJPht9MkvouPcAKA
X-Gm-Gg: AR+sD10IOSkGhIfSgRKITB795hk92aQyi02IRD0QX/h2A6O/BSgny9AMDdgcfufag7j
	79mnajziPQsdqZGRisYVFo2NeDGFWoR+yj0Zb8lvcfq17Rgsv3dPFpr44a1lMVVg7ojwOg4lg0U
	fMsabWoRb/viI2fTD8MS/jxtdwAjLtaO2/DcvZHqsrnqRZTsxLr0BQQFvdNcEcoTmOEze/ckkNI
	Mf1GY0R3J6VLoP7QexF28yH5hlXAl2PlSEswNsv8jbaDKqiJ86SYJKLFJwShiYJl1CU7CfogY3Y
	ZdX5GZ2blzLToJ9iXt70/WxQ9tpZfkXwqw4HI817nQ9lRz2zmUnulS7CZi2jS0nbcFaO8Lh/OYL
	ZFMU1/CYMu+kV3j8zXsxXtdpgegxBy9vtWQ==
X-Received: by 2002:a05:6214:234c:b0:90a:927f:8a9b with SMTP id
 6a1803df08f44-90cb77e8264mr23920966d6.7.1787610369022; Mon, 24 Aug 2026
 15:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com> <dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
 <xmqqa4qgruvj.fsf@gitster.g> <CAF5D8-vDzp9xhu96Tu0ScmWRHvVyi74MD0NhPMnQ9ayoy6h+wQ@mail.gmail.com>
 <xmqqzeyfxcdu.fsf@gitster.g> <CAF5D8-trxeMd8HYzy6kD4myf+bynkxOvxKDQrMdmqnvcdpdkEA@mail.gmail.com>
 <xmqqld9yvznl.fsf@gitster.g>
In-Reply-To: <xmqqld9yvznl.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Tue, 25 Aug 2026 07:25:57 +0900
X-Gm-Features: AcwNN1V-KRcLnD9C_O-kkoSy96A0Li5Mxd3xRhGye0_5SD2H75HLr0BKQEJqysw
Message-ID: <CAF5D8-uDROnfs9gZXm1gwQdsOr-xP5Ai3OG-w7eOSHos3_pa8Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] worktree add: improve message for ambiguous remote
 branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 2:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:
>
> > No. The exit codes of the command 'git worktree add ../topic-branch'
> > are the same (=3D=3D 0). but the results are different.
> >
> > If there is a unique match found in dwim_branch(), it creates a local
> > branch named topic-branch which tracks <remote>/topic-branch.
> > In case of no match or multiple matches, it creates a local branch
> > named topic-branch from HEAD.
> >
> > Since Git treats both cases as successful, either can be considered
> > the intended behavior.
> > (Although, if there are multiple matches, there is a fair chance the
> > result might not be what was intended.)
> >
> > I am confident that it is appropriate to provide a hint when a command
> > fails, but it is difficult to decide what to do when a command succeeds=
.
>
> I actually think it falls into the same class of bug you are fixing
> in this topic, which was caused by not considering the possibility
> that there can be any case other than 0-match and 1-match, and not
> thinking through the ramifications of treating 2-match and 0-match
> the same way.
>
> It is of course OK to fix one bug and leave the other one
> unaddressed, to be fixed in a later follow-up effort.
>
> The rest of this message is only for those who will tackle the
> "later follow-up effort" part after the dust settles once the
> current topic lands (aka #leftoverbits).
>
> In the beginning, before Thomas Gummerer started his topic in
> November 2017 [*1*], 'git worktree add <path> [<branch>]' created a
> new branch from the checked-out HEAD, without looking at any
> remote.
>
>  - 'git worktree add <path> <branch>' before Thomas's effort errored
>    out if <branch> did not exist.  It was safe to add DWIM from
>    remote-tracking branches without requiring any option.
>
>  - 'git worktree add <path>' used to create a new branch whose name
>    is derived from basename(path) that points at the current HEAD,
>    without erroring out.  Enabling DWIM from remote-tracking
>    branches unconditionally would have meant a silent behavior
>    change.  So DWIM was added to this case to require the
>    '--guess-remote' option to enable [*2*].
>
> Back then, unique_tracking_name() did not let the callers
> distinguish between 0-match and multiple-match cases, so when you
> had multiple matches, 'git worktree add <path> [<branch>]' triggered
> the same code path as 0-matches.  When the DWIM feature was
> designed, handling the multiple-match case correctly was on nobody's
> radar.
>
> Even when =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason updated unique_tracking_=
name() in
> 3c87aa946a (checkout: pass the "num_matches" up to callers,
> 2018-06-05), in a topic that ends at 8d7b558bae (checkout &
> worktree: introduce checkout.defaultRemote, 2018-06-05), to allow
> callers to distinguish between 0-match and ambiguous multi-match
> cases, this work unfortunately concentrated on improving "git
> checkout", and callers of unique_tracking_name() in "git worktree"
> were updated to pass NULL, i.e., teaching them to count how many
> matches they got was postponed.
>
> We know that the update to unique_tracking_name() in this work back
> then was not complete on the "git worktree" side.  After all, that
> is how this topic arose to fix one of the two code paths that call
> the function so that we react differently between 0-match and
> multiple-match cases.
>
> Now that we are aware of the issue, I think the code should error
> out, instead of creating the new branch out of HEAD, when there are
> multiple remotes with the name of the branch.  In other words, the
> existing code that behaves the same way in 0-match and 2-match cases
> is buggy, and we should eventually fix it.
>
>
> [Footnotes]
>
>  *1* https://lore.kernel.org/git/20171112134305.3949-1-t.gummerer@gmail.c=
om/
>  *2* https://lore.kernel.org/git/20171126194356.16187-1-t.gummerer@gmail.=
com/

Thank you for the analysis. I believe the behavior of treating multiple mat=
ches
as an error is appropriate.

I feel that now is the time to implement the fix that had been postponed.
I'll make another commit for it.

Thanks,
--=20
Yoichi NAKAYAMA
