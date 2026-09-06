Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651941D7E5C
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701439; cv=pass; b=rVHj2anFSwSgUbn9MFum3/wu/TqRJuEKKkaKvqL4dGCMtHC0DvjEeEs10Jh1mHhsq3oQs/gUKwci+abxSgvLuTVEa8GDlvu7WJVeNXrHTLKEkN71Rt/Ix3XPKvqS1nY3qZ+b2kSOnQ9JM8RixNSCVnDeR/ITCOlX8pREoQFKAW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701439; c=relaxed/simple;
	bh=IQzWSn6Pmx3ULqeqMDDDzjYMrd8MokUZbkoS4TcHlgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUEheOXrnlYZWGkQH3aknhpX6+LaoQSWIMGeIgauKz9G9Dj0nS5k7U/g9Uga4EUe+gGGWrCWXG1Dvr0WVeMWvef/W9HHGf6KApPsytc9+YinbRiVtkZzDcijUYXJl2n7NFxYiwubGmtQYh85BetnuG7RvjUOOszIkmJ/wePesXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G51Ce5LF; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G51Ce5LF"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so2465406b3a.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 06:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788701438; cv=none;
        d=google.com; s=arc-20260327;
        b=lqMlyeTDfVxGi6mdXzTg/JC44U/0V5Wo9F8xQJMuKnDQ+c4T/y0qr5My+ayfB28Zih
         b0Obsjs7yPGHR/UWTmcqPfn4EJGYgC4H7qTHA9Zk5nxRzSu2iP7+eBn60Bo5YlGT2yrX
         y+ZhC2xNBiyx1JFL+D4ReJJ+T5NHreLiGhp4PsyoOxjCLNT3QJrl7ioh9RqlUQMunkQ1
         nH8US1l5jk9lr3Gfweq0GcwdhFbBtD/jhsEzHXqGMHKRMKQEx54d1LCLdQjQ4Ft3brTf
         WOK+fSbHCkPKtVhq7xdk9chP14mR+XrZ4bXOvfkxVAr8QdbWezSCPRU+3ePhYU8shOmX
         /dyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goCs8ooVVK7sbeBst1TdPg+SktKNp8ElTVJ6d1eIyGM=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=XFP4aGYF46J15PFISGckSF0rTgVH7sH4tG7vxsoaO/pfMuuAKMRAy1511QtBUU4NXt
         zAbS2Y0+h/8oUpPOzBpsFadSi9wKqGjODgv2QGZk+117+9YqwhhPoF5SjGETy7JMZvx1
         bEkLhyXY19P4QGbxmFfGlLaNiKZpvomuar3lpkb6LPPMc8Ys6NiRRua0TZMBoz4BQ2a0
         1i45i/6u5vgN9dC67qQwVn/szdZ6TdjLgOKaGwqRtJ7mOVfFOhmdoUwZCGzuul+FNwHg
         989Lr7JPOTFPdqii0Eyd9sBi0+51lPKnoDwtwK/SmoLeWd9tqJvcN3QyCnfwzIC66mdF
         yC7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788701438; x=1789306238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goCs8ooVVK7sbeBst1TdPg+SktKNp8ElTVJ6d1eIyGM=;
        b=G51Ce5LFSGpg8H4vR1AgV+4koqeJn5JPrTjFj05gGuCwutFvvEnNu7TnNUYG0lcRR8
         3MDpCeV1wVIWOdgvbKT0fmLgKqHIq24gZUGu22hMY/FkabiHlQYD2aulsFQsW2+1Z48y
         AwTiGesPjN9z3653v7jPwAAVXbbjXunZ4Z2vPIQSJbdeYCZS6drPvjvF1+p0TiNPmb67
         /RtG3k8DRPAuvB6Z5h3jCux9p2WNbcbKi/I8IQIRnBX5jXD239Oe0jloPH1VIHojoCiB
         cqCg//ZaZx45/R0w+ynf40ACV2y7n491VJvHqJj/ZecLp1GDOj3cG5NZWpPIFQm0NubS
         sBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788701438; x=1789306238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goCs8ooVVK7sbeBst1TdPg+SktKNp8ElTVJ6d1eIyGM=;
        b=rJT18WTlWVAIphecHNtUQr7Ip24TdOJyLIWMxFGM2qyT2RzsOTVCBRJPyxmqq1wCUG
         bjCSE39n4D0nC9OzlycX6UX1YG8t4hJYsA/wT170vAugvTELJWA/GHF91+mlpvg6BrjV
         qXdt1/TlzM+bm4ep5OW/ceu8Biyajhq/J8Qh72K5YivVaYRdQS5e1QzbfU3F+Cq34a0J
         tmANyTsllRFFF4VL/vkxiOUeqfak/h3XnG5mo0OXdHRag8+vfWdL83WiaAZWPXTVfd9j
         sMPRrz+aAS9dlMa3hG2hRUEBzk+F4aXS5XqPLsAXvpaSGyWC0UPMD3Sv4N2P49Mcw+Lb
         LYwg==
X-Gm-Message-State: AFuF++lKoSEVE6J5IOh53ZT40xaDgNX+ZamtQRgEsLSD5cLeGzyxKZN/
	fuaORUUSTqybMQ6n7jaKBrbNaSWtkHNTWkNUDADMdo92FRwxljUo3og/2blTd6kGnxAkt+rlqRu
	l4xx6IE2XvyVIEujXDIQKVzfLampruzyob3n1
X-Gm-Gg: AYBFou0ll9g6aRfh8oFddm9+J6ClNF/0zrULdmnsfpHcyhRFa5eTnhT9QyPx4h2ze/1
	9+MMvGiWN4kJ8LHu+uxzhyu/kj22XPvW3kq+ghFElG1VRt+NzVXvz7jp/TudjWY3w+XS491g3dN
	PNdC3uDUso3aoO1+Y6cXu7EvhxtWKO4qkLXLmlLVZTHqfSUnyme14+UHTtk6+gIlbTvNF+RSWix
	cFCg3v8XqNu1QOHX9L/SHIfJ1qmYbVPQW57tPzTWZbzR+qwNlemyn6mNnWMBXetIxmoaolHe3fr
	M4KcG1bhBfwTf8k0s15gSPvLdCLx3aKdGPRquC1T7+kZ84yj0buHKIjB4pZRkxJZa/AVLauHDDC
	QxJXT5qPt0Ja6f17k7t0dtl1qUQQ9LmEFOzlW8rOb7MeidA85o56g2w98WiEN2Enurfto3Eaxhn
	CUgHGN0W8=
X-Received: by 2002:a05:6a21:168d:b0:3d1:5c01:e6c0 with SMTP id
 adf61e73a8af0-3da39d1867bmr30187103637.11.1788701437567; Sun, 06 Sep 2026
 06:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7bl03723.fsf@gitster.g> <CALnO6CBALuJ2DTm3_NSH1=Q4DLEFWO1EKHQeHPCg+Luh9cY_qA@mail.gmail.com>
 <xmqqa4pv5k1e.fsf@gitster.g>
In-Reply-To: <xmqqa4pv5k1e.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 6 Sep 2026 09:30:26 -0400
X-Gm-Features: AcwNN1V_vsk6TZlWVxFaGqzpdVGmgOm-so-T22BvNqTGf6KKvvxLcicOv1RFQ7g
Message-ID: <CALnO6CDy-tLA4aN0-btkvS472RT5BCvE2xshp1-MekcO7v-wbQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2026, #02)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 7:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > On Fri, Sep 4, 2026 at 8:00=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >> * dk/use-nsec-runtime (2026-08-31) 3 commits
> >>  - core: convert build-time USE_NSEC into runtime core.useNanosec
> >>  - environment: align repo_config_values_init with struct declaration
> >>  - meson: expose knob for xmlto relative links in manuals
> >>
> >>  The build-time knob 'USE_NSEC' for nanosecond stat precision has been
> >>  converted to a runtime configuration 'core.useNanosec', allowing
> >>  distributions to bundle one binary that adapts to filesystem
> >>  capabilities dynamically.
> >>
> >>  Waiting for response.
> >>  cf. <xmqqbjaefhwo.fsf@gitster.g>
> >>  source: <cover.1788206466.git.ben.knoble@gmail.com>
> >
> > Reply is at <https://lore.kernel.org/git/D0BA1B32-1CAD-4328-A612-75A648=
413017@gmail.com/>
> > :)
>
> So, is
>
>     A prior reply of mine to Patrick specifically mentioned diff
>     with submodules, I believe. But I agree that positive evidence
>     is probably better than negative evidence.
>
> in that message a sign that we should expect a reroll?
>
> Thanks.

- From https://lore.kernel.org/git/an720tZnot07HYiK@pks.im/, we agreed
to "hold this series hostage" over the_repository, I think
- From https://lore.kernel.org/git/CALnO6CBejkZTgPM9tK6TEGeNYSRfi9r2-xi7R4c=
kTsRm4ZGaQw@mail.gmail.com/
(and replies), we don't currently have diff + recurse-submodules
(though we do have --submodule, we don't think it uses in-process
struct repository values).

And in the message you quoted, I wrote next

> All-in-all, I=E2=80=99m not inclined to change the shape of this series
> at the present point in this discussion, but if you (or others)
> feel strongly about this =C2=AB safe default =C2=BB being a requirement,
> I will find some time eventually.

So, I'm not planning on a reroll unless there's a strong demand for
it? In particular, absent guidance for creating positive evidence of
safety, which I've asked about a number of times, I'm not sure what
more to do.

--=20
D. Ben Knoble
