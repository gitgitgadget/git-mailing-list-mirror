Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536555C1C2
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091478; cv=pass; b=B6GkeaDzIo8AoGlyW+RmTHByOA0yNe0hHw3FaSv2NBkdHNyX3/CzY84EBMFAaIHXWdNt/wMxVOzDw0ccDXY5VMRtUMqLsb8G4Wcx7sGUtGhUWuOy9hl16jkpoZZWVTyvQH4JxUP5Bs8HaF7J8NOgcOaup2jw+X1zCLCPdAfZGmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091478; c=relaxed/simple;
	bh=o1MHjJlU3rqVbNRGeN6pfTyDhW+hzypNsd1imMqiJSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHZtBbDTvTBElW2/fwGZOwK52ZpZLudmB1ja6vhaafchhmgg54F0o6EKPmtrNOAqTyUO70kcd3Tr0LQtFbUZklsMZG7zpiWU0LINmMkZX+J01GM791+cN8TkjQqWnY4a6sovi25BG8+NXQUvDwC46fYdypPzO0n1BsbHH2bmUHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InFz+W8d; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InFz+W8d"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso7343231a12.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 08:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790091475; cv=none;
        d=google.com; s=arc-20260327;
        b=M0WKx0aMfGynkm6pbojICU7qICb+hDb6cOvBmg9eLUXtO0BanCMxdvHJ0SNNEV865F
         0tIL6hTbkPqPwQHRHWtas9bDnnT8xYzNK9G+BVQ858S72UJ9PCTE8RP/HN99LRQTph4X
         l0li1WyrMTsnkxQlBZxPUWvXTwWGsDoL8MmhPSlfEFmsX9GmsUXjBh3Hsdc3PddKkSJr
         WlLp+tqGoO0ErpRfKO1ws3uX3NlJIPPV8ohkU0eZ7mwgSJn0DmnLez7LehXIoPPJcX0u
         bq9XMW+F3CAA9omlB/qDau0TgY9BrhFu0VPKPEvvbtKEnbJzlHwrAO2EcuXcaNaGlqrC
         qpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1MHjJlU3rqVbNRGeN6pfTyDhW+hzypNsd1imMqiJSs=;
        fh=1PAkmHkrSwpiO8LMvzUca4heKmwvLwPBPde7+rfPBKo=;
        b=BHYl9qG/M4GKZNMzyMbwTCXqD7NZuCvjcY++7aWfuLeRg9mojrK54P4Zvls92g3skx
         QRosqZr0YQBKMVp48m6nrzIpSZ9NtaoKO9JP9LyUZlbWqBzQ9CkjcsIJNf4hYjjrargv
         F3LWxBjQR26n8VvUiEHBLXOiZPae3+de0tcr2dtlX9pkgIzjIiZygG1c6J8a8bWD74XN
         r5lNnNb8AeHl6vf3WamqGg7vYP9/VIvO746Kwf1irdTfv07/BWEdeJa8/ZzpG6RYvPQX
         DRx+jKmJiII5t6dlPA1ytdn7qOs9q745I/OoBDsGWkpzcjX5B3LvE/xwqT6mnGJNPVIP
         8KRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790091475; x=1790696275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1MHjJlU3rqVbNRGeN6pfTyDhW+hzypNsd1imMqiJSs=;
        b=InFz+W8dLfNARXn/C6tcG8LwGM3R5VkAdTR0XhI9EmYbLMcNytp4yB5OWTtfkMxTGm
         Y88JwvenOfGov70UuAct+U+2mfe6Ap9osJbyfuxggL03XqyPOGDqxnQYRU8LZCs8xSP+
         rvYOCY+/WzEUAayEXh8lWfzrMtQBqMcNbqIoVhgLjt9L7sk2WTrWhRcpdKDwdfnxBVDv
         mZSBX2hdrB4o0IIml2pCVnpcTc4UMa33zRf6sOtkwWtqo3LcUGrN0j8EiFP2eW2Acw8K
         QhJTecMUyPfpqPl1NyIo/v2ry/akoiyuOLNahqqY87TmH5jhERff2dRgMUh2VSdDx6On
         VV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091475; x=1790696275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1MHjJlU3rqVbNRGeN6pfTyDhW+hzypNsd1imMqiJSs=;
        b=2GjYGRoV/EBYC29196bnTfFwvUOA9QYV1ITFACPgEm9yZKIBMdEvrOYRsGIw6JZkVr
         VukUI9gsB8Q2f+8r5Kv5m8Z8zBrqiqf5BDeeyrAArLpWy3fZMcY6V7uo2Spw7ui/HdJ9
         9EH50kQW0DYDv47+chTK08IPOBPIi875nYiUOgfQ26DJygMQUv5IfM9j1ObdWiD/GRk5
         Ux9ZxmRKF+bcTJSJ0Mek1j3xMNuw9Tc16Rqx3zhdo1tUf+KTEcQPtFEFoAGQaX8Yfb5t
         ec7kk/1xLNUAV7gAN6ZcxbMrZZ2mwEXGf5EVc3EIJQi0GmsfqR08n5yKrV/rEUY+GOeP
         PwEA==
X-Forwarded-Encrypted: i=1; AKwUvBw4GwVmKf22eLz7ATXkVly3lPsVwsGnThkuZqu9erptxJmHz7m+x94cL/O/AJ+NrmMZBEY=@vger.kernel.org
X-Gm-Message-State: AFuF++kPmdqKF6uUCcjDVXR5HaYJa4PGl/45Ssj6STNxMmpezdKlMTqm
	NqFITZu2CTktwqEdAQ6J16+uj1u2mNwb40zWTaxzMrbgo+G9FkqLV3HDc2GhxboyEb+e+j0pFcN
	NgNfDOTRwfzSYytEGKqTSwGqq8bpKaBI=
X-Gm-Gg: AYBFou13F0futQpx7YKjqCBfjNgtS422nVkfsOdINYgN9nHzVjAeeqVsDoD1gq2dxRl
	a4SLR5H9NVtOPBzkgjneaIp82NQ94iJQq6uZx+HX9yTSj1b82QFQ3mF/JAwnvla0p55O+jN/Mla
	3Lt8Du92GTibrSbzWVgNlEZWk6yFhhUrbFsqy9wS63y9+PGPuA0Y/ZovwY4BSPRSSZx8Mvsh6/c
	Bhy829jdI+7lV84JLu4HczrvkgfHr68SY0Bw9nvZkZkB148R9dDA2+/rzTnoeWnB5ztM8FZqlb1
	HcCjhdbvzreMuu5ShHP/nB0XiU5ag4LE9ePXr+PHZex5TIYhXpYOa/s=
X-Received: by 2002:a05:6402:4613:b0:6a5:d6b5:cf80 with SMTP id
 4fb4d7f45d1cf-6aa564ce523mr10875404a12.11.1790091474577; Tue, 22 Sep 2026
 08:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> <CAHwyqnWbbCK40qAU1vhCFmN86J-dCY3tv_N_nBYgK2Bxf3o1fg@mail.gmail.com>
 <CAHwyqnUVkVUjKCiN7YT3tkvHEVCQwb3jDGM0OTojPxptFKrsLQ@mail.gmail.com> <15c85d2d-4fb0-427d-b52e-8e4dd958dcb9@gmail.com>
In-Reply-To: <15c85d2d-4fb0-427d-b52e-8e4dd958dcb9@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 22 Sep 2026 17:37:17 +0200
X-Gm-Features: AcwNN1UcjGZS8sOxmNLz1HxrrZNLsmgXnVlXS6vnrfaR-NmWIK-Cca1RtgU0RPM
Message-ID: <CAHwyqnUjDJNjER2AxFXOR6G3sOJKpsXj-agzmm7410_QAFu8PQ@mail.gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:53=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 22/09/2026 14:00, Harald Nordgren wrote:
> >>> If it is the former then we should think
> >>> how we can improve the behavior of "git remote add" in a sparse
> >>> repository to prevent it adding a wildcard fetch refspec and instead
> >>> setup the new remote to fetch only the branch(es) we're interested in=
.
> >>
> >> I didn't even consider that, that sounds like an interesting idea!
> >
> > Would you suggest we do that instead of this, or in addition to this
> > fix?
>
> I'd say instead - if we can fix "git remote add" then the problem
> shouldn't arise in the first place which is better than having an opt-in
> config option that most users are probably unaware of.

That makes a lot of sense.

However, I think there is info missing on the local side that we can't
get without making a network call to the newly added remote, like its
branches (and default branch). How do we handle that?


Harald
