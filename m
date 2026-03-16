Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB32DC767
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773630586; cv=pass; b=RN9u4GFvSyZMGCU7qfADhQ36kYtY2K7WFfFirgfHxQi1TSFfUO1t45l63EtyHV7W7jYI2BwrN/w9Tjs5iFmHTCuUVAY8C/imQ84XUzroTL56uWZz0k4XMtm8mYw/JcucFaS9u6KBK8v9q+a1/tllGoiPi0PouX6moacPNTKEp8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773630586; c=relaxed/simple;
	bh=C7edfEdPl4CGxiklauogEm9JhkHAmSS+HTwHLUnOX6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEeqh2jZaXPj0rkPr3aWWYeR5faQVYanhh2XQuWod2TzI0SMQKMwt7kq13PuCOP/gmK8pDBIevfvVVrPoK1c+ifkzH4KkaOoudRKvNjzRE1zbJn4yBIJVXtr9vIqMNeAXKb41GVmh+fgpI56EwprN1tQFDqtfRPqQwtQcMUyfMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UImUFQYq; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UImUFQYq"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79827d28fc4so34997457b3.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 20:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773630584; cv=none;
        d=google.com; s=arc-20240605;
        b=Vd+5mQv6/LYM/jI3oys1L9m2myuFffLziuhrvEGZwsrk0xn3emHXxbyP9rX5vhymeq
         Cxwl78+YaZzHCQ3reqLLRGezmCKIsG+yGgi0zo3S3cHdAwdGPkWqFdwKhIafxNHxMvjC
         p3+zo9Nr4hLmwVLXvUQGsMiF0fiHhHkoTOfV8QV0pxYVv1ypayGPuXtnAW25GnkWmfs4
         7+btdZEqFpXw3rr7Ekp//MGtQVpXpDlUvxwxSZnUKFdvy27FDm3mVEcVLuv8hFrP6x3l
         WGkqst/oB8aLN9unYiJKb1GwqSRUuRKzi9NvSfUifSO/2mpDD6fTnzUSWsxR3MT2JOxY
         bs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q7EFkPr7rfvR6cuj577rcMbAb+L6beHNCR+3j+erTu8=;
        fh=PgaA0fqNTk5rviSc7zC7N8pBlNYy/aa5K7C6WRU2gYQ=;
        b=Wo0LFklC9bogLWvjUdHsU5AQX6Esi5FDI6nd7BvvDAoQD6W9R3WI7LHiglBqKA/6hH
         +QQFoIajCptIKuJldBONQ/6PfjsVHHuxNctY2hcROjSqdo9Srrc0IjRE3oT/u1En9PsF
         vDSXsm/LzuadpUiR5GxyK7WK+8qtzFzkun4MeLEkZMK1ogJBq8WpPjX/IUe8Srms4VfS
         Plq8I69aWXPG4tQryFy3wRHNi3dTMKGt3vYtez2zIQA8BhHc46FQAMM/8H7pNyMH26XR
         snKRhNLcupR72uuteJueuoMSThvcacuZBfHN64Fybyhp3q4O5JNMLye0WgpFkuPL7frw
         bjEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773630584; x=1774235384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7EFkPr7rfvR6cuj577rcMbAb+L6beHNCR+3j+erTu8=;
        b=UImUFQYqJQTCO7ALlPwcj8j+W3N6mLhbNCfkhn3UsRJ/Zdus3pvTzE2/dBVLpzLON0
         cm0myHTatOifVKyhDxlGcK+hh5pol8Kd/9j+jIAV4jvCfe6j9HZA4mATNN1kSxjd1BR9
         c+OnhPrTZYWdYZ1KocusKeEU51B7JAJbx7x/BkyvwFDKLMHx7cTHhKHgOXJp7ueGvYSY
         2+ar8Uk4AFmvhBvj2/FK1tweKg0sQQUVoA+B9F5StdFBJNX0uvfkhZJzf5Wm63mYRGmW
         oN567AE+2yPzxkJlgZBE5cxCu4zFOYRvnVDiy7exD4R+OdnXCxuWSYdpYd7Wx8m2xH19
         YBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773630584; x=1774235384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7EFkPr7rfvR6cuj577rcMbAb+L6beHNCR+3j+erTu8=;
        b=FIxq0LrEhh4zbSIxzJhcerRIdLFwlKxI7iy6HBlLsndQLP0Wt5HmfvOhw8YoTYgu7D
         R45Lx+XzxC2Kvb/ay4+gzvEbgk5qjQBF6Yr0qQspNBsDCz1kz60HxfNQa10CQGHQ0li/
         O3myJY7y4WLt8B7zFIIibZtuE3mk0j42YuuQhS0Q5mu80Td2ghf3vIe9okaUIAXJKegb
         IRkA/QwNCPUOWToWWWZbTNSHGR8AmjiY20O2udW1c7awCgl7gnGuH0qt6+K8MVRVVdL2
         ArhJ/Y9pMlFwWtDoTafOWvHOv19EJllSpMWtEzjIi1jD+QU/MZz/B58IH6TnZWw2/VVQ
         Y0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXoH9WfshOUSV4Bz/Q/dYISGS35jjGUmMQHEk/nEfZyGc1vUDQjLnKyRbxHkS/9unmGT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJCwGof/JkQJg0sTMCrzByGK+WMly1HWqtU5gP0sFdY/lAk9R
	6E1ObVs2WC+W3KyjH+Q/Wrb6J1/hqhdhiY53n+w0bOEauPFO3L2rh2sXpvNFTccq7qydudGV88E
	DWdBAzkEqX0Hv9PqnXgz1lLXs+0SyhMK+3j3y
X-Gm-Gg: ATEYQzxvsylL8AvML65vd4ZuaWtAsoe1pmjW/XQOMWpS+NUj9Fku/hP82pjEAzSj1Tb
	wgHYrSR766oapK1FrdyK56VQhnCk/0lylkAhSh+sMLanMxQZEdbSqOVPEq8mOVOh3F8CGBrccUe
	IuOESc8lrA3JroIiHRZFF8vqLHpPWlNV6m/09Bneor0Nte4u8yFgddQZ+qvX0+lpWEhzOVBEgaD
	qDyqQM3iNkRBj5aX0v9Wd7GDvwrRwTw07+LIVrdZoi1L+bB4wMfq2YuS4vPYcJq5sQaYgBGSqgo
	UQIhwQ==
X-Received: by 2002:a05:690c:3482:b0:798:6f0b:86b4 with SMTP id
 00721157ae682-79a1c103f3amr124063537b3.25.1773630584457; Sun, 15 Mar 2026
 20:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260313193537.62827-2-eric.peijian@gmail.com> <abSWrcvm-smx92MY@denethor> <xmqq7brf1g3e.fsf@gitster.g>
In-Reply-To: <xmqq7brf1g3e.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Sun, 15 Mar 2026 23:09:33 -0400
X-Gm-Features: AaiRm53QkP-4-eEz-8mOQishfsUbW8huxTxVQPASDUD7IWw1kJANDBLygb6WgLk
Message-ID: <CAN2LT1A=yMpMSDZoHGEFL7T8fw5OC5vbgL3DJ7U8xP6tOfVudQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add preparing state to reference-transaction hook
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Justin Tobler <jltobler@gmail.com> writes:
>
> > On 26/03/13 03:35PM, eric.peijian@gmail.com wrote:
> >> diff --git a/refs.c b/refs.c
> >> index 6fb8f9d10c..f1439476d3 100644
> >> --- a/refs.c
> >> +++ b/refs.c
> >> @@ -2655,6 +2655,13 @@ int ref_transaction_prepare(struct ref_transact=
ion *transaction,
> >>      if (ref_update_reject_duplicates(&transaction->refnames, err))
> >>              return REF_TRANSACTION_ERROR_GENERIC;
> >>
> >> +    /* Preparing checks before locking references */
> >> +    ret =3D run_transaction_hook(transaction, "preparing");
> >> +    if (ret) {
> >> +            ref_transaction_abort(transaction, err);
> >> +            die(_("ref updates aborted by %s hook"), "preparing");
> >
> > Should "preparing" be marked for translation here?
>
> It literally is one of the possible tokens reference-transaction
> hook is given as its argument, so no, I do not think "preparing"
> should be translated.
>
> But the hook that interrupted the ref update is not "preparing"
> hook.  It is the "reference-transaction" hook.  So the message
> probably should say something like
>
>     the reference-transaction hook rejected ref updates at its
>     preparing phase
>
> or something.
>

Thanks for the clarification. Fixed, the message now reads: "ref
updates aborted by the reference-transaction hook at its preparing
phase" (and likewise for "prepared").


> >> +    }
> >> +
> >>      ret =3D refs->be->transaction_prepare(refs, transaction, err);
> >>      if (ret)
> >>              return ret;
> >> @@ -2662,7 +2669,7 @@ int ref_transaction_prepare(struct ref_transacti=
on *transaction,
> >>      ret =3D run_transaction_hook(transaction, "prepared");
> >>      if (ret) {
> >>              ref_transaction_abort(transaction, err);
> >> -            die(_("ref updates aborted by hook"));
> >> +            die(_("ref updates aborted by %s hook"), "prepared");
> >
> > Same question here for "prepared"?
>
> Ditto.

Ditto.

Thank you.
- Eric
