Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69531B85F8
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372323; cv=pass; b=X+FvlvlUhvKt6/zT5PNZi55qt+PPdxTqjf6MjvqOGAK8McfL0m1CUniozJkvL7WmefPTmFq6+wXtnHnAZk0ZWjIdkbk9Rj5mrQLBw31ztg/BIK7HweaML4+hDsm/5pIHDyKbc66ruHRnWvWU6Td6iyCrztMgmq+T5NKCmFJeSSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372323; c=relaxed/simple;
	bh=RLCyuidZrBYVHB8lxnYtj0g7mR/5pTA7nlYng9Hx47s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUtAazs5w/uNO9G+kccRIOW1mVv/pMrOisVQMmGJhyseP7x5J2MCGuGZ2uM2P55zdkWH5VZQM5Q3tNmNB6d67jiFzd+6XXo5pRDaw8VoFD2Sn8c21EXang4OmvKKWUrZiYoGZTB/FyePkMQteIQbC1/kv2HSmMYUocP5g7/6S3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTRD+wgH; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTRD+wgH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so3077304a12.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 10:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781372320; cv=none;
        d=google.com; s=arc-20240605;
        b=EI2+dIIvWhRbUIh2tslRZo+GjqiS44jnerUAjdKbBigErb1JP08dYw2Q5loXqyeunw
         0BdSHyQe/8v/kBxRrsujdgTi35+8hvKemz00YCDoPBl+IJMjBduFeZTgRJPnLtEJKq/8
         8ghH5wKfNXdUCxHQEitYiHvI32Wk27ELcuv9xWQv7RE8zZHa4zOUHp1uEa6fO9Vt1ZNS
         hZ9zGRZe2kvdqdXKEF5OYCN777oak26Rua91yQYNb6/SY/81+uhVW4i2jBSMVNxVcikz
         3NqoKroZtneo3eISxgNjn76g0zOvqnlIiRa+g98zkYQ/k7ZFYy2ntF+GSvVendsM8KQh
         fucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JRATed705McTuGhd9XnjoXHH2z5wUFjeUmS+ZZaM2C4=;
        fh=SPfxruQQ1f27lPYRvN1VorW3RBbOqdL2smsJVvtUUAs=;
        b=BYL+hcogWaYXuFI8/DEI/JRwd8pPXvHrdqJPQIDW7Z8bSsyPgWxow/EhcXe8GKr7bJ
         +NAsl6bjWHswQXYuVlRyz3+SsLDsH+WssbEqTBstGNsqNuDTtkoKv9EnRpKara3eLydu
         nRHR67lnQxIcwuyKixE6cqBxUzPE79/Vbb+grGjcPQVgAHeDtXhJw3ES4V004HmOf3ob
         7ODPs1+S3A3PqgAIEf9TGXnhdCqiDXGPCH4Dy+Z7ltvC/Ev6WQZooAaKw9R4+26J5RVr
         db4vg1Euzpv4ZLWtbNOsBLPQypQwYy9yV85g1cMXJAEIufLL5sUneot/1c3qKGYcOEjY
         u0DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781372320; x=1781977120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRATed705McTuGhd9XnjoXHH2z5wUFjeUmS+ZZaM2C4=;
        b=eTRD+wgHHLcCtrIi7UFEN1nP14zugwBEQ69twc4EJ8FUnPif+UvoI5dxyUd3xHYJds
         Z9jyccXEromAmdBqZDCSUfYrB6TRACRBwRjpLUbx+YWyjN8i2tIwfOFZ6smOXLg83cfI
         koYbZ0rVgPP+EapQKImkPO7cszBqhPLzSU0UfpZFXRSN9N3NWT37ABgvhgU/4pb+K/vH
         +JzA97jh4iBO5v8awVQMm/CvoiS6lrDrCCuZ5Lr9SjB0n1Ke+yZSb2vpFS12NJcssRke
         9L0s6GO30GOLCS7hlUwbDd9k1ethBVrmJLXjADjbVKBTzIuHmUFR6J81/mX9SqVj+vGC
         1KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781372320; x=1781977120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRATed705McTuGhd9XnjoXHH2z5wUFjeUmS+ZZaM2C4=;
        b=H4KD2ERzaltUU+rqG7orZIj89LfSg5RedJecxDDrPR2630rHdSG/XpnFHfrCObjn7/
         8Sq35ZHkaTGRuEcPqMEgM5oYLkGANMVqxoalqLS9O/r5S0xEyT7KN1T2er/RyuY1vDxZ
         Lnkewhwn0H1+kuv5dwa4t5tITFMQUvGsjBsvT6apYZU6SUNN6haCWNQm3NSjsdwy07kK
         STArJpGi7bvwEqliN2sc4t5ECA9fSnC/DDX4NprsYvWo/m3DYZOUbnxwRvkNCIA1QF9Q
         m0L9rvy2wNChNORVH5P2D1450o6vDRpAZkVymO2bWCRFMm5N5QegyHnc307TU+JhpjQa
         4RlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iPTs/irQzAtH2e+PR2N6sGoAAKQFNOcmIcFsNpnr+J0vNKmZcbeeU1unliJ5ZVOI4XPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiueZ4kptZinxiIZUOLVVjVgQ0wf6d+OxS1zTRGD+QlBSu2Klk
	JVZBwwQOTigg9ApxRGlu9H/Q514Yn/+0yFVgmGe1m745G2NpunkGu0wK/6VEPCtC3wuYDlsskPh
	tk7GlSTEn6NxR42VL/2PMyoeNGLG/nEw=
X-Gm-Gg: Acq92OHlH7QHeGoZsCJX/NyYy9dwIPUNn9Ano7FyFrXTABCUu0uef1Y1y6um+RqcZnk
	S0TnFELlNyAl3gyrPXl6H2p3tgXEcOxs8RU36XtAmRQti2w3izhXvl0Likbqm9U6REiVPm11cW2
	sEjlCbRx8cjpI4gP69XR+sRgPmqB02AD+Cx9Gycc6HibxFmc1v7qTU+KwqU4VeMCNkMCMNZxB6l
	OqHXfkQE5RCxdnLvNRgude3poRjewPNqQRlMd4pLKrVE4icOQ5gz0vR6UbPl48aoy9pYaGbMjYn
	ewz0Orsam4WUXYO6GA==
X-Received: by 2002:a05:6402:2690:b0:688:1efa:2605 with SMTP id
 4fb4d7f45d1cf-693784f7f58mr3201795a12.6.1781372319974; Sat, 13 Jun 2026
 10:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
 <xmqq1pf77kml.fsf@gitster.g> <b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
 <xmqqtss02a2o.fsf@gitster.g> <01526f43-86aa-466f-a1e8-054284e1a2e1@gmail.com>
In-Reply-To: <01526f43-86aa-466f-a1e8-054284e1a2e1@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 13 Jun 2026 19:38:03 +0200
X-Gm-Features: AVVi8CcRBqks792Qk3Pq0H2PYDW6TtKeHXSi0VonFQkngcTbYyJlz-VymVoSIsA
Message-ID: <CAHwyqnVjmwakmb+TF0Eg-KZMrEHihXZbaVkkS3WVJao-So2SKA@mail.gmail.com>
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip and JCH!

Would it be possible to get another look here to know if it's worth
continuing with this topic. I think it's a useful feature, but the
feedback from this list has been a bit lukewarm.


Harald

On Thu, May 21, 2026 at 4:06=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 21/05/2026 13:58, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >>> One.  Have you considered the case where the remote-tracking refs
> >>> are overlapping, e.g., where "origin" and "upstream" point at
> >>> different URLs but they both store in "refs/remotes/upstream/*"?
> >>> Perhaps their URLs may textually be different but are pointing
> >>> logically at the same place (e.g., one ssh:// the other https:// for
> >>> example).
> >>>
> >>> What should happen?  What does happen after you apply this patch?
> >>
> >> It would be worth looking at what "git checkout --track" does in that
> >> case and seeing if we can share the code.
> >
> > It always is a good idea to think how we can share code for
> > different purposes to solve a new problem, but in this particular
> > one, I am not sure if "git checkout -t -b topic upstream/main"
> > codepath has much to offer to solve what the new "before the
> > checkout, update from the remote" feature wants to do.  To the
> > former, it does not matter how refs/remotes/upstream/* are updated
> > and by fetching which remote at all.
>
> Don't we want to avoid creating a branch with an ambiguous upstream so
> that a subsequent "git pull" works though? Looking at
> branch.c:setup_tracking() it seems to reject upstream branches that
> match more than one remote.
>
> Thanks
>
> Phillip
>
> >  The only thing it cares about
> > is to leave the record that this new "topic" branch works with
> > refs/remotes/upstrea/main.  But the latter needs to be able to
> > compute which remote it should fetch from.  It is a problem that
> > existing code had no need to solve.
> >
>
