Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910417E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824553; cv=none; b=LV0+3rQ4anqQqvpfTJFjCGc7WXW2Sgpn5wEB+0cA+4mwEj4YBPOgj8zQwq+78rd1o2t3LlAcShPr5HE/sjg36IWwvjBN8ZgCh7/Lg5wx6ouk93PfSsCKMfxhhDWlkh7ob7msdbeC1riaYRpaWfZJ6XRY8NA9ycr5jJd317sJwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824553; c=relaxed/simple;
	bh=l39tM3pMr28QlFZEUvPZorF3bvui4yHJVk+Qz+IEm1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYeka4FmGH5TM4iH6rHweMYO8EPUMP61mzRFeo9GzX6vOTu3C+ruOwijcO5Wt4UlYY0elu0nQjYwgzz62GAjzXjUfolk3mR8B5UrofFrQMqIwtKLOKrgg0wv38MWJacencqT1Aa0Z1y5u+ZJhu0ePkTAacNSX36R7gDBYIAUkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaDGxFFr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaDGxFFr"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d439f01698so5371225ab.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741824551; x=1742429351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuH3ls6dLtRyh03I+1eY7H+il0xprKN7lqRFHp123CQ=;
        b=gaDGxFFr2xahyvi4qnZDsFr9Tz7VHXS+EMUd+SLVpNDU1hK6RiQmMpmkwuyysS94UQ
         E9SAkBVe9ThU56HOnqvGC8nczIuyld5RHEVXqLZ28Cmrit+F/VGF2FisRyPqnA34RctM
         kYeBcCUiQvSo1F7cRxxb+6sEyHvHUHk/+eMgyt8xXExPf2NhXslBjoZKiuytfaFODiAA
         ZOrOF95cK/3FZ57uoaNuajF5K8thKww6vP9v5Qeib1P2NhEIv9BHeUJ7EGxiABy+t8d/
         vI1nFoP/3HuqE9XUFzWM3M7OM7RI34BYe849PYJbT3JlMESGnz+3NRtjJnD+yc5JF2Tm
         DdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741824551; x=1742429351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuH3ls6dLtRyh03I+1eY7H+il0xprKN7lqRFHp123CQ=;
        b=uOrIXPFlnKeEexLt38H4GtMOenst/85IPO15XzN+lrOjgFhw2rDpT2lbwhP3jTYWmS
         wji/AwGPnCepfm1o0KAIZ1SbrJd5FSk9SD3+R8he+5QxpAIqivt9MlH9zLdOU3yyw2hR
         ABVnyL9ilrWpB4hWZ8yzqARl7pgpQajaJCAcoHUjLJkzJD1hOxz1RoVd0ZRtUWR95+nG
         0X0Ie6wtpuQsRv5xH6oBtj4c/Yf8DTNc0M+sJ6NXgYqLhdmLJCnS6+DgGvY99LYDnKfA
         WjZyySW1s2S1EpJKl+yT73Rl1NpgnkHe56+Txa9n864OGqo35BobvdcRfvo2+TLil3hL
         ftCQ==
X-Gm-Message-State: AOJu0YwgZolf65VPS5kXjdzOCMlkkLNHAtpTN2BLsVhONzunhvErwqo2
	cUtA5T9lrLyFGqdIDCctXoGO1X08q1NHbuQIonjao8oAj6aN/Bm+jvY2F6PRgdtV9Q5YfWt2YOO
	3mT78x6iPadipesajIcLjSNASsGw=
X-Gm-Gg: ASbGncvc2w3BRGQdty++NPCl9AoYOuH6BLVWDLLsAGx5lBAk5vKWWruBoEC0Rk1IkdI
	vy4Z7/g5DFulWvqibISRtaI3f7xUSG8Fmia8Qzu4GCu3gH78lmhYRnpEmKB0ImUPAly4WPI84HK
	wpdhw5TdE4VCK6euuZj35Y2BT/pCxQ7vyXkZjQvwZP/4qlcy9LAXdLD/XMXCI=
X-Google-Smtp-Source: AGHT+IEZYuiZTpEctQ6HwQH+zI7ELMOhh6S1DD+6WZR5qdAwOXTm9CsmehIDAeSWT6OkjbzPMhFR1X5E3IJ7T7L+9uw=
X-Received: by 2002:a05:6e02:b45:b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d479f817a4mr5798625ab.3.1741824550844; Wed, 12 Mar 2025
 17:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqh63xx23f.fsf@gitster.g>
In-Reply-To: <xmqqh63xx23f.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 17:08:59 -0700
X-Gm-Features: AQ5f1Jp1zCnx2jt0vC6hdIxe3yPgkoo7gxEj3W7y4VO20Umh4kphKstmsAzLtEM
Message-ID: <CABPp-BGfZ=onjJnCHEAqxFwKPYWPEV_qQNfTWdx6C8FBkuSyyQ@mail.gmail.com>
Subject: en/merge-ort-prepare-to-remove-recursive (Was: Re: What's cooking in
 git.git (Mar 2025, #03; Wed, 12))
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:


> * en/merge-ort-prepare-to-remove-recursive (2025-03-07) 3 commits
>  - merge-ort: support having merge verbosity be set to 0
>  - merge-ort: allow rename detection to be disabled
>  - merge-ort: add new merge_ort_generic() function
>
>  First step of deprecating and removing merge-recursive.
>
>  Will merge to 'next'.
>  source: <pull.1875.git.1741362522.gitgitgadget@gmail.com>


Can you hold off? Patrick and Taylor requested some changes, and I'm
about to submit v2.
