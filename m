Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448C3D3492
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230896; cv=pass; b=h0TO7/Pyu+JGEkPCp1BxlSilHDV3oEVTWe6sUYNIoo2ZPxHARRJEPfAU1xqjrkaQATDr552qyuacTK1GVOF1PNvWYQLs3qb3St3HOvdOfwgVYaDlv08FonLLCObGVXPJM6ZT4ZV8Yj3Pv08N2BMiPuG3IHhChBw2jq/83F8MFKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230896; c=relaxed/simple;
	bh=fdGNo4D/LIBTE5KYXedgpShfGpTsfPf3SXGlZCdAnJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLeDAyIQsuFMBhqEgGrBH2Oackk0ho8/UZX+niCHGcV66b+S2UFRSAJ5S2Y8Wz1FBXaPzqqFoeVxgFj9P2MDzsVLhX0Lrb6eWreVGaLx0jSSyT5MbRxs5YZ8Q/StAEQzHvMDhVZdMtf73VBuE9tKn8nvcod9XA6qPUktijxa5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhrxtgcE; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhrxtgcE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso936055a12.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 02:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792230893; cv=none;
        d=google.com; s=arc-20260327;
        b=XEBRGr0NwMxUW2BhKiTpmYbC8lvUjLNsbsTY37P/dw8vjUSHZZHuCcVxngrsgUjUl5
         Dw+Ks6QIxREdIChZRcLL+THW8umBf7VnP+bVyLIyTizqnOC6cmZ6FyQD5odARafGsXz6
         KWkeV1RWOy5avOabPlyjWzv7/BG5vJG/v9XkpgDDa0D2JhGBwE37kvoYInN1Ho2VYi9V
         VR7IErTIepDIpgL+yRaDhfvcxB0xEZZOhj/DWDVRodlkxYjp9E3nmYTFfNCLprRvC34w
         wHIlFawVhZ3ZXm+tO3NK5f7jU04G+FRJTDrTzXlmI5kpRt5k0rJ2FX2OjKKg29z4uOnA
         Drrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IAZNXhpJ7fBGFbY0VAYMxcJDOJfzfn6RZe7qgrh4Ulg=;
        fh=GSq18hkr7iAJ8JItEZ59lA8cS5tjsvz+6wTQ3n0p6K0=;
        b=K2+x7bSEif9n2nnyBGz1OK9B3tpE6eLx3y9y//nescg8Sg3acF9MxxFzNkAvzPvNnv
         /gl5TcCR6CpkmxaY96WVapm52kgECyGbNdGYt/RHlyNhr26sSmTIvwR16uf/YT18dHMY
         t0j7tGtfvH/9+DAVIwmTkt3LcDRF6bks1BM6HZRCGaYxcdCZYkvv5Y5NJlLjPX3j9bnV
         sN2NoeTlJLxb8NMNHLfwDcE9ZpjFAARqs37EOqp9bGVgM0XZGpaST9Iy4bVYEz3YaiPH
         sWBwPgLzadQvGcQMw76TD7XHL/+xdUUGOEpQ8qwqKKny7bhSNbTRFknYNXhi1ti1mtRb
         4jdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792230893; x=1792835693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IAZNXhpJ7fBGFbY0VAYMxcJDOJfzfn6RZe7qgrh4Ulg=;
        b=IhrxtgcE6PEZIQq9Hu7cpCPvRN7Qspt3eSRRHvOApJRoh+tI9KBt+2wDE3eN7HQ4Hs
         tqVKE5ztEbXFuVVV9JI62Z4WAfhR9cBZuKHHylqHH+kUmxqJDGhRil4r7CZS710XGNr1
         NzfA/QLslWrxlpz9SWWCMpVz9zWbJXpBPPEAUc+RKAz2YpyIBWFAypMph0hUu3Ofv/Qr
         kmesNnWM+1Q0SWt4u/x2ERf/ZEw0YrMDDAm/AXeXOVV8pcTO7xmuvFRvzEQ82phPrIKN
         yjQOZY5THzCJb+i/1uazJKzfGuGOTR1Lxu1g0auevSVJdGTXnjKyvWbzmIApw0W6njTD
         qNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230893; x=1792835693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IAZNXhpJ7fBGFbY0VAYMxcJDOJfzfn6RZe7qgrh4Ulg=;
        b=ZmRUXIr42WbUrvT+dpV2wMeqxD4EWObG3N4eaRergkUPygPo4Tza9QbDPKR227NGgs
         NnqHK0eoRVWnXRBHElJazTwz8IvuX/VyhHxK8V7rkAPs+CycVOmcoQ8qc3WDALzvabk2
         /SFfj8KOFloVrJwEwcWqE8JmnOMBMWR9wVgungZBfQ2jhEtYuh1ZBGsTXtEUEbBB8Uvj
         K7/Urx3rIX4isPIA1rOcFXcPxmhI2iU23g8YUC/XXNPOd9jRM91gBZJ6rV6Y5ORFhEZh
         F6jAKGdeMeQoakKEUZX5GW2V0W4uFxnTTN1bakZJyg3gjCb0ovPPE5HwzszSorncVczd
         ctPg==
X-Forwarded-Encrypted: i=1; AKwUvBzY4pJc3hY5HzauDlFmnTcSI+wZPWRfsBLGctHMXGthClE/JMCPkjy/D+kSra20QWseSzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiSGaUZJKbd5vp/NcBBaT35xtiVWGpD7kamorZYzf1oRFrm152
	GTYEOKPTn66cM0425kj0+1kuWoperOAHMUgeivF6t4GCnLTRZ9EoyQP6hCCwUvVwyxqgrBs5Gw1
	qQ9RUi+ew9nzEbJgQDoggwccHDDlelno=
X-Gm-Gg: AYBFou1y3a6Shy6V+jYhT3kCx2e0P3OuI76iGsZ2Ldvx0OtKMSurENIiG+qqsZuekY5
	QQKxG0TKNkqEQBj3mPy03GsDANtNc6y7wsJT1mY5dFMGYm2DrP04z4aIo/gGxRNjA5Rv/CIP2Ol
	Wh+2CG3U/wUhJid+ZIe8MQCMP8+sqBOvhESgGEVc0DGWG6UrBPAWaUi4txy3eXYqU+4hNP4rFfp
	40etVRLHaLA5K+gUoqP1I/97L+QTQE0SYEL1T9xRdcZ09Qpn0nlgsHkTllf9r47d5wAcUCqZdLT
	7H0MNNXMpYPS4fG/gp3u4okLNT36FhlLjFqI2HAjJbENEzCSMgr8i0Y=
X-Received: by 2002:a05:6402:1ed4:b0:6a9:a3df:e4f1 with SMTP id
 4fb4d7f45d1cf-6b3a81a70ffmr1426906a12.25.1792230892810; Sat, 17 Oct 2026
 02:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2450.git.git.1792134165785.gitgitgadget@gmail.com> <xmqqcxt9h9g6.fsf@gitster.g>
In-Reply-To: <xmqqcxt9h9g6.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 17 Oct 2026 11:54:15 +0200
X-Gm-Features: AclHuK_mSRmp7gbO8cpxWdxjm_QndVTd-bNNRARiNql8y_ueTCNEYZzIJTRO9ug
Message-ID: <CAHwyqnVwnMi+DzQDvS6mgUzg-CWACUviVkYv-UiYJT+Yq83QLg@mail.gmail.com>
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 6:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  `inherit`;; if the starting point has a tracking configuration, it is =
copied to the new
> > -     branch
> > +     branch. A remote-tracking starting point is tracked directly, as =
with `true`.
>
> That is "A remote-tracking branch given as a starting point", not "A
> remote-tracking starting point".  Don't abbreviate and drop "branch".

Thanks!

> I am not sure if it is the users of `inherit` want that forking a
> new branch from something that they know is *not* tracking anything
> suddenly starts to track the starting point (whether it is a
> remote-tracking branch or something else).

For me it's simple, only tracking when the starting point is a remote branc=
h.

> Looking at the originating commit d3115660b4 (branch: add flags and
> config to inherit tracking, 2021-12-20), it only talks about what
> they want to do when the starting point does track something, and
> forgets to say what they want when it does not track anything (the
> author CC'ed in case he retains the memory of the motivation from 5
> years ago), but if you ask me _now_, not doing anything, i.e., the
> behaviour the old commit happened to have implemented without
> explanation does sound like the right thing to do.
>
> What we should do if this change of behaviour turns out to be
> undesirable?
>
> Perhaps `inherit` should gain a synonym `inherit-or-ignore` for
> those who prefer the current behaviour, and we want two extra
> behaviours, `inherit-or-fail` that complains and dies if the
> specified starting point does not have anything for the new branch
> to inherit, and `inherit-or-direct` that uses the fallback
> definition, or something?

Seems quite overkill for the relatively small problem this is solving.
But it would be interesting to hear the original author's POV.


Harald
