Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432F191493
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256451; cv=none; b=MoYMCJES0lElTotu5HWT1dqd2k6ihZ5see9Fytb9nVkrAfSFSZEMWUTwHSokKqN+UreBX4bphnAwBOjRyVYWxyYSzfs3QF6ZWT3EsbJRB9fzY5GbZlvB7ITSDCstsQkJ722MMm8qk7n7B9sl04MQMZMStB2zHr/IC1ksWsBKNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256451; c=relaxed/simple;
	bh=DNF1/EtiHa3GleIMU9VXFif2eW0I/YyiNEjE/0fDX4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGZcpL775WGc9+16qQQmGZ1bnSwpEu0bRh6KU4VuFJ3h+CS08tSVHEkIxv4GyolQU2jToLrPJ5R+XLmoe7hkafXcJrven7ldt1cwbKSO3DuPSXyLxqSDi0AS3xfDc3ovTLGwiddudPf9KhbrMAcrwLXaaGRhw7QGZyLA2+kL5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fb0ac80aaaso1164816d6.3
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 00:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256448; x=1753861248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCdaPNTttqeK/2vSzENHeVcxL+6r6pQK5o/4b1XQXaA=;
        b=X7E7JZMwyX07vycjl7GCf+S6ulQkj3/mewTXJcUf5AQfi97RafeCGBmxLuWP2Sg/l6
         DL60bnmFBEBn2uCQKFqgInpw0WceltZy+2Ki3Sf8D0+cuMZGjdXQPQ2xXedMeEy5MMaA
         jGIh29ykez/r3lCmaFqPagoVGIalEv9WCbAifVKkxCnq3UItCJIJbJDE9bI/QFo0uvFq
         Aq2opiovQbw2DZR9K0dmHkQoK01MTuI6UkUIyUMUpWKF0M2ykjjDIhbN6DFrwBvtKgDT
         KfYx7LHLEYrmOta3VDFTLdKIQ+mpHJDFiaLMc9J5xJvkFTP06zjT8HTXHgymzv4hZd1w
         tEbg==
X-Gm-Message-State: AOJu0Yywb0vURt+Q+/5/eVinfFu4wKhn4TETTAna0gqBNHA3RfOHO3Sn
	umxngTDCt4vk6Bmc3/pmFkd+S+QkxKLkGC8B+kVejkXJD+h7w4iMDwJQPUHYOpX0OjZXGpsZ0Nc
	wkQNvCWunbZ0DnpLYhLrWxemPJ6/dx2E=
X-Gm-Gg: ASbGncvM45/RIx5w4qxCCy66x6SORnn7ELGKBQLUYXul6+ChZmood1IQL7/fEoxad8m
	3ifrghVp4sZSUAWVArbzHdgjHXBqjqu/4GrxbAUlD19Ij4n/w9UGlFj5eubBF6iS4gT52bDPdbV
	OJjNZWwSmEm5lFX+n8tMgX0UsSaAeE70aztp8es7+bZTljLCLmFJBhZHISNOKEWEUhGbEtDdZh+
	vCV2Phsn109g/9w77mecQOK+AmD4aaT74aGJqc=
X-Google-Smtp-Source: AGHT+IHegR004Ej6RghBKIMZvmeSq03uvkWf6/m5i7IJNqXgN4CqbvMaz/YlsMWobryfrYbbVFSDsoHZctpc6jVhmJc=
X-Received: by 2002:a05:6214:1c46:b0:702:c2b5:67e9 with SMTP id
 6a1803df08f44-70700212da2mr10918116d6.0.1753256448167; Wed, 23 Jul 2025
 00:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwm7zpxzc.fsf@gitster.g>
In-Reply-To: <xmqqwm7zpxzc.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 23 Jul 2025 03:40:37 -0400
X-Gm-Features: Ac12FXz5YWAr4sypUmBkDnfBK69AWnJWg7Fep2jabF1gr3pJLTU8Hj0cHU3iir4
Message-ID: <CAPig+cS_h8sC_hEp3zfsUOdP6aFOBucpOsa5TDGwoArHL85Wpg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #06; Tue, 22)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * hl/test-helper-fd-close (2025-07-22) 2 commits
>  - t/helper/test-delta: fix possible resource leak and ensure safe cleanu=
p
>  - t/helper/test-truncate: close file descriptor after truncation
>
>  A few file descriptors left unclosed upon program completion in a
>  few test helper programs are now closed.
>
>  Comments?
>  source: <20250722174102.1876197-1-lhywkd22@gmail.com>

I left comments[*] on patch [2/2]. Although the intention of the
change seems reasonable (patching holes in the existing "cleanup" of
`fd`), I have concerns that the commit message is misleading, and
(more importantly) that the patch itself is flawed. As such, I think a
reroll is warranted.

[*]: https://lore.kernel.org/git/CAPig+cR-r=3DCeEaSTeWsX00MLCSRJUUVXMUWS6Ui=
-HQcR_qMGJA@mail.gmail.com/
