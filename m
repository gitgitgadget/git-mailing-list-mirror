Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671D1DA62E
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414917; cv=pass; b=uXxeRrVX4OK85S9kD/1trqgnD72UMl3SPn4+fikxrro86onrVe5rB8V/wgLgyMRoRn3W9sgs7L0eAxNUMVV7BIXV3elpdJSplfA+RttosiQK4wVfxt6nWdJa9+ie1/TLmwNJEUAJLLSYNmaFwZsIVF40AWfbShEzugDqipcwv/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414917; c=relaxed/simple;
	bh=6iKc2HoqvrlH4v1FQx6Zf9/gu0N9rHn6ow7wRW9fQcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI/101yY15m0NebjX6GONX5HHk8mq2Hjb7elzDkVxv2sVWbrMicHbHed+qm5xycTvSuT6Q7bGLimnPCzrGdk4byOIQxHj/IouQlx5nergy3JEjICiYjNzo8j6rbZxi2VFHLJCZo8KZDZDjF1MbrKbz34XI92cImSyd7LabWgcVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivP2LBn+; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivP2LBn+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dc2b658544so14658987b3.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 22:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781414915; cv=none;
        d=google.com; s=arc-20240605;
        b=ct8abwDbcFXBz1ogqP37xyc0cAzuoAwSCKzrc+dyOqFJom8u034A/764X3Fm1Xtkkt
         RBRrDiB7FUVYcyl0GA9fTSFv3PZDoMpBcam4haUQZUKbSIIxvcp3uZA1T4CZRmwsYCBy
         cNBTDxIjgZw5blIuJuaPyn3eXkHhZiPUocUTR4ftBPvE4AwucY2YsTWRFu/2Gnux1tQx
         o3kSOLB8Dngp2U/ly+cNql68Um/M+CQCgUNpnF3IpRczE5vjRC6y6gJ9nrBQnb3MrszX
         obOYVswFyNXVfLRXctiDelZHXW6WptdtioIbfGiNgZ/S1yvxA+IU1d5q2uhINzFdWUBd
         TFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfTxF5VEh3lmRvSI2470YEayy8+Fm/UK9RiTKpBAb3I=;
        fh=ZIHEkJc8NrS3mAtrUfW+o+ofcv53XvTfVPPKHvdZUDQ=;
        b=dKDFSkHOVIAhOEMfLayeIHTxg0Cs/oPrVIUnNuLfF1bXPtmqgUL0pjQISCJKGq9N6L
         EZa1eg+K4E4rA3yxLDdbKy70qCs9TH49Jp9RbARaJUQZTeFSrZpFfjE37mWE210X/0Ct
         OwBumnJwkhkXsO63rO5eAZm8iTiMktZFCiaMWnm1qAauc7prsSvJLtMPQ7/WPmc2ZJPH
         oj0wDeO3l88Or//TrEZ/6e2m3IWqB/yXQ0Sl+IIpgg4bAdRq0Bui8ggMob5zI0+bKrWi
         6fBTeIJEvGxT1wRnE14Q+/2rzH7v7EXgQgLosDXjhemntdnWgU+IxxXKSmnphoZLB+sM
         bHGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781414915; x=1782019715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfTxF5VEh3lmRvSI2470YEayy8+Fm/UK9RiTKpBAb3I=;
        b=ivP2LBn+jSj245T2h/ziSKjw28LYsuqhOR7RKYkzxkD5QuunOji5+eywZWwZDcPCUH
         7IAudqCPjcTQV6xfCIw6/sYPFL7jo69Zs5IzA+QX+PxFpb9CHzf/gW86lIVu63Lg1imb
         /eRSOKZTFJEGb62EQ05UETJdyNfVRJGKMUG9zy5QX6ToFYKLMnLYkKSIglTTKobkoWaF
         eLDD4+nAdEXu0ijcdjDW2bvgzuptjCEoI33xPxQMAT77l8nfGo8KeWND3vcPuF8CHLTr
         l9T5ZaJfcVIM9rUVuqNNdCfJES7LO6IeU2BB9pAtoe8C4ToEJYdaHNfoXZAy7pH5wqCl
         mHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414915; x=1782019715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wfTxF5VEh3lmRvSI2470YEayy8+Fm/UK9RiTKpBAb3I=;
        b=AFWZaAfglCHSKFjXqeEvLqXvB7oWtOLkNWXXOzJwm5haMwimO2lNLe96gT0s/6FRTT
         336xXwYEmqNTyGOHZXKpo9J7zzJdDAjLb+n5h6Yw2Br0fLF2eV3L1dOMxelK8Ti9myPT
         LDo8VMz0GzH/lzsY6pq4oEy7yg5s7M4aerErbNS1ygGtvY0Knr3JnTwVsiUhAeJyUe6s
         xL61WxcGyygg9dVNikWMXOv9x49bIGdHkbuJuREKVZmqN+aCtxV58EvbV9OiTg5xYvwv
         jOd+TwSVkOgKz1Kadq8tbXZNlvxJJvgZIaE3/WqN6kYNzbT3SFyR5MQsz4tEZZzKFRE4
         SjDg==
X-Forwarded-Encrypted: i=1; AFNElJ8nQYFbUdviX6FssxPEJ/me+MDpgT2sJ0Ic0Z8KUjTHHNgG7r0j1EgB57w0fCkqq0rsdIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdwY6rLdF0ljOPnL82KJ7rywuotRO4q+PSpoD4BS7jdy/xrYS
	/jcQMGBgKDhQYqzpGUabZEns94HuzPCNEawS/Q4EGaHQEaBODxE37iy6jVDUus3hDvo00UCcKNE
	i9dlh+nbtXMVoAskdu055Vr7QHrU+ZYo=
X-Gm-Gg: Acq92OFo4aWroYubi1CkKJ1vGLTahQEclWh/F9HqFwUJkgnJMfHM1A3R1stBRb9j9WA
	KSVB7+IY+4HUjYzq0BNWcOUATECTHpbzbMqrSYg+JnLCzWm1OtSBC8DFP/FBKm/n9XLi/hjQM4P
	UrxLzOMevK43Xr/RbTpzTGH9yqg8BbFGiSltM7U4B3Jb/iNrcLHI6EUT4IIt9x5euV7hlHmTVyt
	ErNKaDumKVkfbpKMRCPOUNAtY3ZVaoNtwUQK/tfYciFjyKnuYD/0IU+/7gq8oD8DOJogM9gdeO4
	pL9wHpm78q9wI7GhzJvJac8aHB1v2WcWg6Fkd52qJzq/s+zFYlRL16cQVvMCcOiLqGxa/LJS0E8
	LNi3YZO8ELbYxyZeIHnr7Y5VZ+AISYEQsPaWmnLJcQGXr538KFbxBFORRAsZ1Np/a3VTmCudPAH
	0KoDU=
X-Received: by 2002:a05:690c:3a0:b0:7dc:a5a8:8a8 with SMTP id
 00721157ae682-7f7b5647e93mr100006347b3.5.1781414915120; Sat, 13 Jun 2026
 22:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com> <xmqqo6hdepgy.fsf@gitster.g>
In-Reply-To: <xmqqo6hdepgy.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sun, 14 Jun 2026 07:28:24 +0200
X-Gm-Features: AVVi8CdC6wlpndayAob8ipU6mt4iB3qjU5T3jMZiV4xE8xc07MBt0gU1RO61Pc8
Message-ID: <CAN5EUNQ193QyOeTLdu9aXzDeBhFpg38YYBbOLhZLgcg3qfd=uA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 14 jun 2026 a las 6:05, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> [jc: Taylor CC'ed for his expertise and opinion on the quoted part
> that mucks with commit-graph files during the test]
>
> > diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-inden=
tation.sh
> > new file mode 100755
> > index 0000000000..ccf15c0a52
> > --- /dev/null
> > +++ b/t/t4218-log-graph-indentation.sh
> > @@ -0,0 +1,467 @@
> > +#!/bin/sh
> > ...
> > +# disable commit-graph topo order to have the graph to render in diffe=
rent
> > +# ways (used in --first-parent tests to have multiple visual roots whi=
le a
> > +# column is active at the same time).
> > +unset_commit_graph() {
> > +     sane_unset GIT_TEST_COMMIT_GRAPH &&
> > +     rm -f .git/objects/info/commit-graph &&
> > +     rm -rf .git/objects/info/commit-graphs
> > +}
>
> I do not quite understand why having commit-graph makes the test
> result unpredictable here, but wouldn't we have a more stable way
> to disable use of commit-graph than going into filesystem and muck
> with the implementation detail like the above?
>
> Thanks.

Hi!

It does not make it unpredictable but it makes it not output what I
wanted to test, what I wanted to test is having an active column at
the same time that visual roots in different cases were being rendered
on another column. However having GIT_TEST_COMMIT_GRAPH in the last
text for example changes from:

* 41_octopus
| * 43_B
|  \
|   * 43_A
| * 42_B
| * 42_A
* 41_B
* 41_A

to:

* 41_octopus
* 41_B
 \
  * 41_A
* 43_B
 \
  * 43_A
* 42_B
* 42_A

While the output it's ok and the indentation works the excluded but
forced to be rendered parents are not being rendered at the same time
as an active column is.
On the unset_commit_graph function I had to remove those files because
even if it is GIT_TEST_COMMIT_GRAPH unset if there are files from
previous tests they still change the output.
Maybe there is a way to get this more cleanly but from what I tried it
didn't work as I wanted, sorry.

Thanks,
Pablo.
