Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6533C9
	for <git@vger.kernel.org>; Thu,  1 May 2025 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746080210; cv=none; b=DoNdbpPxmgm9XLD39gy/vRTnaQzUiraMjgC2gUq7NWLojDBDOu7VtF5iIeDzmMsFyF6K49U59fV8NmDXPXBKKZfqQSgxgfgfHly8SxJaVRrRmyBs8LKYDSSVSMkoIBcml1NUppIzrlXjyrMZkMGUm711h/9jVswkXaKTE0GNOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746080210; c=relaxed/simple;
	bh=u+cg4lLFfcta8LDCNTlV7fpBI7DIYhaAjttC3bEf3Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIor8stSPBn05NR+ygOuF9iENmeW+GnXnuPgnoqoNUiunS8TnLmnwQoRBhuPitENYaHTUIxFONDLF95OBNs2CLeYWkSXSraurlo3n+HRo03a0WRWK94CqOn3fC4OkYY+th5ZFNCB0VOu2zxEHqpeVyoGyLpOR5whLeIFhfap/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c55d853b54so9568485a.0
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 23:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746080207; x=1746685007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4oSfGOSrL4J8kFpgXcxYI8C1DQBNz+nfJruELPQqmA=;
        b=NBxt3IHNhZzVsiNyx+MJz3kUGjpCAt0nSccj6/qPdQDWbBtgghBev/EzUk1UT8hutr
         smOiYxg91xr17dMLNte/02lvbEOFqtcoezeJPMHREauAeoyLoUTP3qi7GQv8LXxo29Wb
         /MKhnpckb0bGjbJcIQChstghFAzLlUUiWBiEG/FVHjn8yohaAbSZmLWzDr9VB5j7cbis
         1tlyl/ymHXR1gTgivvzmZFEBwhv2sFLiHUX1tOPxcCaMGOzIzNiFWBSRzbcV9SFRwKqx
         Xr8LMoQLhKLx3G9vtKoGFT/ouhsM+TtnGnWC/IPm5kVXZNsxMdtxrnWCICBabNFgx2kH
         xOEQ==
X-Gm-Message-State: AOJu0Yz6yYRKqj7hBQC42tNoya4xCdfAYRpvDY0pkCirmaHzIL9njz1B
	SRTA0gMlDAFEGrf0wL6yqAn3huI71rchJT83wwNY6MhT/ylG3EPfCkEKKsn8BMxf8sLC1yua9bx
	JGNlNgzUjxNJ8+yFphzH2Q0T7d8k=
X-Gm-Gg: ASbGncu+KuYPTtlO+7DH0kOJoOX5shauLyGWzMGP2Y+fiHxY4oSFkwPJbXBS9BwTQC6
	84kLt/Cg8kTkuixjgl8scyDgC5vCVWcX1M8vVJQXa1mnzyCxkqP3iWetFPdSRrzuCEKehZDj3wt
	PgrkPBo7G09MMsEU5JnxAEv++wY4IYk6k=
X-Google-Smtp-Source: AGHT+IFFiC65D+cR9bVUgtMv9QNpstV0lp55sSI31QPnDLD/L3KyYBsbSaY7u7mQtFl0i0uZ+NqqMwQf36L1cNiw8/w=
X-Received: by 2002:a05:620a:390e:b0:7c0:bb63:5375 with SMTP id
 af79cd13be357-7cac85a5aacmr258951985a.4.1746080207114; Wed, 30 Apr 2025
 23:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108060151.7218-2-jakeroggenbuck2@gmail.com> <20250430185309.11197-1-jakeroggenbuck2@gmail.com>
In-Reply-To: <20250430185309.11197-1-jakeroggenbuck2@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 May 2025 02:16:36 -0400
X-Gm-Features: ATxdqUF_uI32pPQSSDDnn979aAKFK3fn1maGUyP7oTxdNqJxZSPeyDsNem5Oxa0
Message-ID: <CAPig+cRehhM-z0md_iV-VYCk_Qwv0A4zS1TfPqPxsrLZ3eYxvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Exit on invalid diff status of diff_filepair
To: Jake Roggenbuck <jakeroggenbuck2@gmail.com>
Cc: git@vger.kernel.org, roggenbuckjake@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:53=E2=80=AFPM Jake Roggenbuck
<jakeroggenbuck2@gmail.com> wrote:
> Has anyone gotten a chance to take a look at this simple fix?
> When git is built of the main branch, it still segfaults when there is an=
 invalid diff_filepair.
>
>     git (main) $ make
>     <make output omitted>
>     git (main) $ cd ~/Repos/ECS50-3/hw3-skeleton-broken/
>     hw3-skeleton-broken (main) $ ~/Build/git/git diff
>     Segmentation fault (core dumped)
>     hw3-skeleton-broken (main) $
>
> Let me know if you have any feedback or suggestions.

Do you have a reproduction recipe which demonstrates the problem which
your patch fixes? Including the recipe in the patch's commit message
would help reviewers better understand the circumstances under which
the crash occurs since the descriptions provided by both the original
problem report[1] and the submitted patch[2] seem rather nebulous[3].

More importantly, if you have a reproduction recipe, then it can be
used as the basis for creating a test which should accompany the patch
(and which should be added to one of the `t/t40xx-*.sh` files). We can
help you convert the reproduction recipe into a test if desired.

FOOTNOTES

[1]: https://lore.kernel.org/git/CAEUC8gmgq_yViedLGHOeSyvR9rQK+O-8Fh9wzds=
=3D2+326ngUjw@mail.gmail.com/

[2]: https://lore.kernel.org/git/20250108060151.7218-2-jakeroggenbuck2@gmai=
l.com/

[3]: It is not clear, for instance, what an "object file" is in the
provided description. Are you referring to one of the files under
`.git/objects/`?
