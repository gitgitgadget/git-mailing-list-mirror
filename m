Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E3248F4E
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520481; cv=none; b=nyV4cZldg+Bom5+0003/ds7LNQl96bTFwjUaoMO5++KFOmB2tjsJes/ZNkz3WO+rPEUoLI9Zp75bmpF6gWgITGQ//w8uLEMJWXZUxnl4fZ3GuO47mg8DPkNmhYWSqRL/wVDOh+tfd7R0TCM69yadb6/qMqTCRX4yaRfZh7MGkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520481; c=relaxed/simple;
	bh=UWGTiSkGBmzC6rSbwb7xDTNfxSuwDGjbS17Ip2HE1Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ld708PKnjonHgdDFaz13vX7W3MJwoOmLni/03BT/S6Syxo4zJcpjDUqI0rX2rzsewU/HJUp6PHhhdjefLY/wNkcmvW54+uMEAsKYVhIeWtl32Sqg0lDDRd8lqOhWpZgxMboqOBDX6leVqeajsF5yH3R9FH3WyG1nbrZAinLtCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEqvN3F+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEqvN3F+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb2faa9f55so712460266b.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746520478; x=1747125278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBTCfMZcoepmggubt2SokIfzHbLlgYfLo6ssnvV2iSo=;
        b=HEqvN3F+xd8yYdCfCMpbYxbhQE3Tf2y4z2fycyAI+C84Jir5nFjD/JvgCV4EWUeiid
         XhDGGQaZyrmA5K6/+5miKJeD68vquala/jtiFGH24gmMRMNGd3oAN8e20cX/qbNINy3N
         cgSx6Bha7bqmgSlLudYQFQTUduHszHIP6OKRVnBJ2yRJihRTTzqyT0VlAU1+p+X/eZ9P
         fQXBybZPtLHNTH7x7W+2zurtSPFJ1eL6CV8HyZT0ZHxKYIT3FTecac/IcZCTbLVlpWiF
         2mL3cId+AM3/9EkP6M6QaObJKLEBrvrAsj2Bo0LD54RGFyLVXX5NJti3QusIwwdJQrU9
         zO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746520478; x=1747125278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBTCfMZcoepmggubt2SokIfzHbLlgYfLo6ssnvV2iSo=;
        b=T1r2x+lIpdDutJCXkvk/TWL07MO2JeKOugtPeNS9eZGDA6dYCo2qcWrQ6tRRD2IvA2
         juKIlewQ621nhU+DI7Lp41xcGvQgdWhsxR6Y9hGUvX3KnAAcTojDBWh9VoUv2XpKWAMK
         VgcxPs8VMkUDcJ5L/2Dd1CDM09bmsOysrgB8iJwutVmBky+iRELumkQu1Im6xtEGmrn2
         z4JhUnHLPZnOeC41QfBBgfl55zwskqcO1SrkFuzqb9zEpLMXxSNDxbZWGVGqvuRoNGDP
         sgWm0Q/8x1OnsPka3ZoOdF4fw4mbgac1fmjQjuRm5yP4uyXq5dVol63Q9Qa0kHZlMKk1
         WCfQ==
X-Gm-Message-State: AOJu0Yyl/k6rAH+8sO4BjPJLUhPycVeU71yHyLvyny9/mpmLWKiRkhXn
	ugKnemmSDUGIP/W/MQDSYIUYBjD0aTAVZ8YWEcpXav4bHyoakS/hURjEI702KopyrX6SN5p3WDv
	SkMRiLiZdXiDYhx+WyxQnA8+7A0k=
X-Gm-Gg: ASbGncuxXXPqbP/jjz05/NXtqadJHAnHqgF96TwWIgf/8tF24BoeEeyy6FsOHk73ofx
	/OPmlFbcfa0pknlJR5g00NfIAWj8Fuy1ed0LSnOcoHQyzzjpulLv5Pd0AwdvQLHBdPakkawcrcj
	x4GGxFzNdr1Pibm16NwwohQh70bO0FUIqO5bgtN2+SH2Gzuct7b+4fMQ8=
X-Google-Smtp-Source: AGHT+IH4NaUZHz4JIChgR+2uirVMdk+kPClQRzkBFb965rh0wu0IT2DqH0EuwssN+7X3DbtxfIkHXTABLGltaAZaoNY=
X-Received: by 2002:a17:906:99c2:b0:aca:d5e9:9ce with SMTP id
 a640c23a62f3a-ad1d346791cmr203043866b.9.1746520477976; Tue, 06 May 2025
 01:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcycmlelr.fsf@gitster.g>
In-Reply-To: <xmqqcycmlelr.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 10:34:25 +0200
X-Gm-Features: ATxdqUGXEtj5LSYN84Fd1mTV_60QdI9Z6H_YQxTQaS6x8mxOyscaYbLN8BsS5R8
Message-ID: <CAP8UFD3=SJp29+QaUZvqWhjx_53P9tOE05j9TgP-sEvNRZW-oA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #02; Mon, 5)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> * ps/maintenance-missing-tasks (2025-05-05) 7 commits
>  - builtin/maintenance: introduce "rerere-gc" task
>  - builtin/gc: move rerere garbage collection into separate function
>  - builtin/maintenance: introduce "worktree-prune" task
>  - worktree: expose function to retrieve worktree names
>  - builtin/gc: move pruning of worktrees into a separate function
>  - builtin/gc: remove global variables where it trivial to do
>  - builtin/gc: fix indentation of `cmd_gc()` parameters
>
>  Make repository clean-up tasks "gc" can do available to "git
>  maintenance" front-end.
>
>  Will merge to 'next'.
>  source: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im=
>

I am reviewing this series and it seems to me that it's possibly
missing a fix for a leak that Eric Sunshine had found in a previous
review round.
