Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2E406273
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184618; cv=pass; b=Z6BwXu8K0lAkJcl5PQFRw/iliUkX47/HWtEp2qBLILioh7T3Pqn92+nL+xebq47VNqb0jOcdBbAdVZE6gpPZtzw+SsYo6CSZQtAlJZY9jq54vUwq071upnJx61WhXsEi/aiXAgAmFV5bR8WkGxmZHPAoBSL9fRKRejC1pHN54ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184618; c=relaxed/simple;
	bh=FR+k9UG4YVxX4lTVL4djABJ0NCaFZOvflAM04ynWHtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q12a8zc8LpJb68DEOPoN+aUrl1ZOFyPk8Qt+tIq/FV2aEhwqoFv90nFXOI/qU+6EON3s8JUuNpvlELw1pi5YzmjLLSJcjau24KE3bNxpOE1psjh2uRdxUIzCXYOeE6fRJnSkEfk6eNmJS5rn9CkFKANmX4BwFLoS1JID/Eq/kwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGhyAJQv; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGhyAJQv"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13817614cd3so4459722c88.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781184613; cv=none;
        d=google.com; s=arc-20240605;
        b=R1NpjiXgABRAjNiwcYM2U2/i1UcANrG39yAL9HA1TEkDDTGe3B2rpV03TLA37LW7eX
         UofUtCwgk6ulS+YrJZReY3ZLkx8hjbJLLQEc1vAX2Xf/9a5OaqV5QeENEpnpw963jAf/
         wxPA1cH+CyWrsTuw4FAZI0cindB+mCoM9xDtX8CRtuJSX0f3nfzzeLqj/yTVcLYAz4GT
         jlb57Dpw9efswsi16q5ZdAf9i5LCymIbcc6dYySRwlCt4+xT3o9pRqsIzPkDDQBShGyG
         plQbpAEAxZga8ADJmwfODoyJ8kZCj8KIei6tyaZjAf3Kc4PUykrbhmMoKFIACmFQ/5iZ
         AzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JjPKQHOzmAJVUgClcInqiV0SJs0Yj/UHLDkpGG1vAgg=;
        fh=fS5tLAl8/6suJ2lZqlRmbbuZKJ44gHLzg26abFIQ0cY=;
        b=HEPTfYJodd7os/UnvySZ3L4IC01UvRk8/G3p3nQCWAaRZa26SZpNTtO8J4kYNX2muH
         Vezwkt/Ph4jaOZU+7547V1sO/ewZj713yVjLPMmh7w9+ex39r8rCY10qaSWzJbHP8T6b
         17vUlqkop1CXFbjDkrenZfT9GZ/fbWODPzBDVb/XjGmo51i6NwSYNmdlq0nni5wYgvhq
         7y3X7hrWciFHX2JB5UpyMwbnT0/aTK6wvpFrkj2E6Xnr/F/2U5dTWJM3JndGFE+HjE5o
         H576X0PUhcuOY11d2mmsLrrmCGVLW8DHRzABqBaCQAUUjjlUjiL2kHUSO+qVRfxt+dA4
         I5Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184613; x=1781789413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjPKQHOzmAJVUgClcInqiV0SJs0Yj/UHLDkpGG1vAgg=;
        b=AGhyAJQvFh84GrttqvCEbd/p/BColYFYPsHpOc8bGYXJDyEhNK2MGxw69pPdfEljr+
         C87NE6yfiOXd/Kngm68MZW16pYR0r5lhCVOUaivR/4O0QlQJfmXyf6vcEiDq/WkhuaXq
         YLrzt6QDAkrXct+FCtIbt5ALzs72uBeJzqafuKOTV31+5zReiDk7wa2pL4SpTQxGGCWB
         wMzk+uQFT5NDmSoZrG2AcHT6A8zP/Jieizw1AeqqfDRvirk1BlRKHw2WlQN+ESuO6NfW
         v6N95ryOHjeD8gegBLb+zm+U2nFmK6TLF1al8J6tL/MIdKf2DCLRFdrMG1L5+6gNwA7x
         oXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184613; x=1781789413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjPKQHOzmAJVUgClcInqiV0SJs0Yj/UHLDkpGG1vAgg=;
        b=BMU0rCVARjEEuoWJTuzBkVHck8HNWSJi8BoXnNlifzzyVsT1gA2aKFRqMaBwVflgvQ
         P+s6xsAyqQDZ/53r+wtaaRp1X/0tHXb1as52RHcMC+5JKqf7YWzAQ9wV0RLbmMPJBVw+
         2nOU3BrMbE5qGF4HhL4Ain0HL2FGjCp5OaalGvpr8LWOKxBaQW1KDWKmK65t+iV7SATp
         6n3oT+HQKwUKJftJ+rMMTRlA2/MruJ6q3ZJ9kgKZNinaEGDWLuIktSSCao4kdQCsSoef
         R6/AqJfRu25q8HjWn9skuPzBmLk3dtmmH0pBUYNmmtd8qDrcXxLQrIXgJoqjMBsq+kS5
         5cfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oL9v1PdrssHkb3UebvErSaNdv+3MBmk49/RVjKPncCPyZMyzC163zgM6/1+sVncBbsSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5+46buP0yVCc/kpcifnJRIMMkBHPtWmmt+IkMptbJ+nScKM1
	FMNe4plvMJ9bu9OcugfS8aTmRboWegWxxh9+GAe5T0jlhC0gp0eYjq5rJ/CdaMgNuobuu9lVkPR
	eBz9wpqT5u6TJXYEPjZA2aTiS1CedHJw=
X-Gm-Gg: Acq92OEttOp0xw98VmTZU8pECxAS7/6w+vpDCUxtjsk2dqMjAtaLyedob+mGDvHuUwI
	cKoMQ5yDRrlmBshSxGcsD3BTTGoFbZL8m4hXjbjg7k5gbJvAURQnV5HPjYD5B6UKCASEOtsLtRb
	gduNHGFJvidEIC9wb4UnmOC5SiPe1Bj+Fn/mSdW76chHWk7gr7vVfhlAhMnXu2wsb5OLz97MN8H
	ZZbiB2sBr83ZsxQ4G6WreVpSlexMMpp/ykdRxwnxZn8r5nJd0eaiEKZSVNyF3A9msgn90Ujd+/2
	ipC1Mp7rhdQwNzQQA/wgJpZPkPWgcBCBIYLDOthghcecBqCOynJi3JnWMjSXjSxLJiqDVlvyLdE
	T7AE=
X-Received: by 2002:a05:7022:49c:b0:134:def6:e70b with SMTP id
 a92af1059eb24-13842171514mr1616914c88.6.1781184608320; Thu, 11 Jun 2026
 06:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com> <87ik7s16sg.fsf@emacs.iotcl.com>
 <CAP8UFD0r96KxU3kW2khJ_MySgtv0ZpU26KR1vNimp_FwigQfXA@mail.gmail.com>
 <877bo7294j.fsf@emacs.iotcl.com> <xmqqh5naxwfc.fsf@gitster.g>
In-Reply-To: <xmqqh5naxwfc.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 11 Jun 2026 15:29:56 +0200
X-Gm-Features: AVVi8CdInxzff67FXLOCwJx5oT28FkV9uxgY5qgSmTcv6evLorsOvSvGTu0GsKw
Message-ID: <CAP8UFD1gNGHXKufTK-Vwc7qgpcW3tJDq1ovV0WhhSAuPsGEVwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Auto-configure advertised remotes via URL allowlist
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Toon Claes <toon@iotcl.com> writes:

> > Thanks for explaining, I still agree moving on like this.
>
> Sounds good.  Shall we mark the topic for 'next' then?

Yes please. I think it's ready.

Thanks.
