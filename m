Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795193877;
	b=rhEJjSINMQBLYw6FDWAZKx8JVE4VywmYgPLNFIWIvRg83ZT63B/QMvYaWOv/Bj/zMso5
	 wQm5BpDiIGNph17BsOQBEQTPOJZIeyabjKPe1rIYcLWdJkm4IRltAI2eIn3BhdNjSCixX
	 9d2ygodbVpEFAVJDgi5K0TVgwKNb1763jDcc1u1P/GgfkOzVwq69Bu78kDMqbyXh+KhKM
	 qrTTvuZERpTaTKfvEhHeCWCKiMkCr72hKvaJAFu7B3y8W4itqhnR5A31L7gcclc42WwnO
	 peoB/N/W6Pk5DEcbnGeVbTAORmxmM4wpjU7RlHZSgv3qGJhhzF+Z8DpKdW/gTwgKxBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jRH9QVa4z7vXVZKofsJAhM5uY03YTqJqb9V/TWNTFZ8=;
	b=IjCF2+iYWApN2xbT2wy5YzUC0fe0xHSEP7iVypxSOBFGyUlDKl1Z5hdn+/yQCcsEkNua
	 drv63zVLiew3CjV3przy4VzL5wf8GX3RSFF87x62Skw28rgehQolpbz5iTPa0CcFPKb7D
	 4S7r0GtdKDIBiHqplQqWnvK7Ee1R1lhExW0SssZyXgJ9xkR8byITTa/OWz1LexuiB0YDR
	 uZ3iqsAR3CnD2dhDxw3VWr/oEUVdSCBhfl/mjRi7MWDGZeFnmBn60GUcP0gNpe7W9dYmw
	 7688DmhvvCRJtg5vANyLsewcDqiH0iB9tv+g56OqT4PEOPD2psnZi05FdjKHBphj2eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYGoT+uv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42E60A2602
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F42E60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYGoT+uv
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3b4944a0eso977826c88.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:57:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795193875; cv=none;
        d=google.com; s=arc-20260327;
        b=eU0IeUmFMGhxtAGRgxybj+h6xtZdmetPHKHisrFMSqXBWbBQnuINmMrTPyHwCqbWbf
         70L8H8+NvfLHKbdwod7VaN+EPi1JE/c7tvFcCklUGIItLTRPI5vpQ1JnW+7pHYX3EPYF
         /kzxug07Xx8Na1BR76SJpKOJYKCdKpNvSO3aA5SjIw5mRtxkWy+dV0FJ5BcbzzUBWxQ8
         xgiU76ccrFB7A11Q9ybzSM2bKI/LIkjWwXq20DF+7CgVjSM2xRB4xpP2I3vRJ9InHh7n
         iderpLw4PgY/RZ9R4qw6O9NvewxlA3/1BdaQzjwA1GiM8EzdV9IqhOaH1tbujKccXpO1
         aD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jRH9QVa4z7vXVZKofsJAhM5uY03YTqJqb9V/TWNTFZ8=;
        fh=9y5RHKSJjUxgzZUzNgdTktbm7UmuCP3+vb2XY/7eZhA=;
        b=YXG5attZ59pc41V6i6sr3CMByRZtOoT+VVt1E0aU6iv9e0xWETxGpZl4pSODuPe7nO
         rOUM5F1eE8PA87bwGhvTg5e3jA5UlE8fFAty9ynWKA8Sozyn54x6/VYpV+9QUBCXtXd/
         NdvUpjPCTkBzbA0YGFXXkO36E2nmzTKxIXYKcojwJnen8kYoD4OT7BXGnAjUqTxJ9P4o
         mb1f3wpVcwutQLNx0CQmzxI7IuWpvgz7cbNFLcfcvFbXm9iLZmN4y9alWQ3M7pvfGBzS
         cHmqxWpTVjMHAf7zqC2me5ACthWtliFPu1+2kntsOhXV0bnR7m4QqEhDsyHp9AhA+uZm
         G22A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193875; x=1795798675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jRH9QVa4z7vXVZKofsJAhM5uY03YTqJqb9V/TWNTFZ8=;
        b=bYGoT+uvfs04HpvGgFQJDiv2qiakAPX74Nx4pwWtQ7AjDEhgZS49kurULeJjW3Bcag
         1nBN0gjLzscCkSwkuAHC1jBOgxqw+4khwHZ56pLUO+/VPGXgSnM2O0MEfCXiLHv62q71
         n1KfTTGg1Kwdj3L9hiQfZt6BDtKLLeWrnRIruFH/KhveyYlI9XBx5zl4V0pFi/wJIF/M
         6XlLMS8vt5WX9bweBhFxNsrfzobO7CHrAw2TMlJrkYXVJ2WkBD4uaQx1Sq6u6pCIgyfk
         OE5hpMVRdpMTf4DYdWRaeIMLPtJe9xFPySaezULDDlyW5OzaEfFoM3ovw9ymLatY3Di+
         JFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193875; x=1795798675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRH9QVa4z7vXVZKofsJAhM5uY03YTqJqb9V/TWNTFZ8=;
        b=pYCnKjmPj84bBrmMeuOwZXn2Tm+WqZK+KJpLXFFleiUAJ5gvtyrICamamX0OAR30i/
         iP4LWEP4cpk+yr172qw6OBBhMYkC5AEeHMOUN2DfZhv9GbaKH0Hdbun8obnpZ2thWjzJ
         53vTrKwTkj66aOguxDeJ5o4Gyw32RbZSpmdsjpzfoCo8FhqRfV+aaGSpCGPjwCV1ax4a
         +HvQJ4vihs7delJygv2SFFLAdjVnHudteFmjhJAKl4Vxn7+8q6X8FCz6oyIhxvn0fTWZ
         NBe3G4NBLvn2XtVVK00pFN2l26NW29NerdjBElbYxyGv3GjQRvcVWSOCkLwYH4SZIitV
         GM+w==
X-Gm-Message-State: APuU4Z+IfBq6FgBbfdwwlwkYSNOOaoO24rcj1bW6X5oF7SCMJi67QH5V
	w40q2UEQmX3HdghTQuZCc6R9x6nETMHiFzJcLO1xRJr6Q6t+uL1RnBcvoCScsdCS4zEBU2L5CM5
	rOfjr3g64ElQ+VqjiMRFUXq/Q2ZW+Gjk=
X-Gm-Gg: AYBFou3JjZanrW+LzO5QhQ8bzpG8U+SceV3tuOkCc2tWexvpIX3xq2alVp6AQb+5X6e
	3IGEPaLpsnIDYiuQraDY/hWJMXtWNf2I0Z0rLvtRMSKEckLqNcwcTEwP5abBYl2C3075gK/hzsG
	DP7Y+wGwb7FAZYKhg0QVPX9URF26zSaUHuiGrUPpMgGpEokTMlWCrI0DFyXaJS5N8AzCHUB86Fk
	OqQuL5LMRwuLGTMQBBj/mkjKI8cAoToZpWxsr+LGKpik4AHSLE28u18F9vqHYUPurRF98NRanQv
	JCor607c4c9P5uHa01UTB2LgswifkYgB/jsW6xEbmTBnKU+LvUDLQmVfyflsK+l5OpyRKM6mPn0
	6VciqwxySJav5vAdVES2FRNNNAZGC5RyoZzOwaRXpmQmCUIn0aqynZGQgEnBx9SYJkz1bxPUk6Z
	8xoHyA4nC6j1rrDB+ic7zDyWVneSFpKlK1Tqprl1JQKcrSdA5JEvOfkjsrOZNV67Wq6EMlrjaMr
	XylVvroEYrAysB2mFyCOJxM
X-Received: by 2002:a05:7022:290:b0:1b5:25e:958d with SMTP id
 a92af1059eb24-1b5567bb581mr3137118c88.5.1795193874983; Fri, 20 Nov 2026
 08:57:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112195858.53788-5-christian.couder@gmail.com>
 <20261112195858.53788-6-christian.couder@gmail.com> <xmqq8q2xhexs.fsf@gitster.g>
 <xmqq4idlhe69.fsf@gitster.g> <CAP8UFD18rTvM0mu9oSPMd3V+J9GBgc07RM91Pfh4RJqZg0s9aw@mail.gmail.com>
 <xmqqh5hkbl6t.fsf@gitster.g>
In-Reply-To: <xmqqh5hkbl6t.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 20 Nov 2026 17:57:43 +0100
X-Gm-Features: AclHuK87Nxcr1NvoH3Kw_h9Inv1jKUmW16O09V2fPAR5NtUL1-cFXhi4BmQFz0g
Message-ID: <CAP8UFD1ZDzDvYxF1TjTjBo0SFHfwPdpRrgixRQXN72RxpoJOxw@mail.gmail.com>
Subject: Re: [PATCH 1/3] connect: let write_command_and_capabilities() send a
 promisor-remote reply
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Matt Cote <mcote@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > They duplicate code for sending "server-option", "agent" and
> > "object-format", while each sends a different set of capabilities.
>
> That is all the more reason to clean them up before we pile more
> stuff on top, no?
>
> I do not know if that deserves to be called "significant"
> refactoring, though.  It would not take a series with 20 patches
> each of which weigh more than 30 lines touched, no?

As you can see in the v2 I just sent, it took 6 refactoring patches
instead of 1.

The diffstat is now:

 Documentation/gitprotocol-v2.adoc          |   7 ++
 connect.c                                  | 128 ++++++++++++---------
 connect.h                                  |  30 ++++-
 fetch-object-info.c                        |   7 +-
 fetch-pack.c                               |  23 ++--
 t/meson.build                              |   1 +
 t/t5705-session-id-in-capabilities.sh      |  26 +++++
 t/t5710-promisor-remote-capability.sh      |  40 +++++++
 t/t5711-promisor-remote-capability-http.sh | 126 ++++++++++++++++++++
 9 files changed, 322 insertions(+), 66 deletions(-)
 create mode 100755 t/t5711-promisor-remote-capability-http.sh

instead of:

 Documentation/gitprotocol-v2.adoc          |   6 +
 connect.c                                  |   6 +-
 connect.h                                  |   6 +-
 fetch-object-info.c                        |   3 +-
 fetch-pack.c                               |  17 ++-
 t/meson.build                              |   1 +
 t/t5710-promisor-remote-capability.sh      |  40 +++++++
 t/t5711-promisor-remote-capability-http.sh | 126 +++++++++++++++++++++
 8 files changed, 196 insertions(+), 9 deletions(-)
 create mode 100755 t/t5711-promisor-remote-capability-http.sh

Thanks.
