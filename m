Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01869340DB8
	for <git@vger.kernel.org>; Fri, 22 May 2026 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451493; cv=none; b=Gl6wKJTS7BNt7HJi7Ufzo5rtMOoodF7L9OJfpfWOFy024ih/RECUOM67AqwQ7y/z/qnIsTnOgzBFhJNTqCdgARcFvto4VoMXVTvwOBhVjKDw1WUMijNnjKK1+FrgyOfl9R35U7mRZMXE+9WRyUp5ciP0mavpxt52Wp1Ngyx8p0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451493; c=relaxed/simple;
	bh=/GcenNb/MJYNLMLymXgJ28OVOe70zcH9VdoXinEVS8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6IIlnU/JLXDmINkFybJkV0j1bq/STVP5A2tKrRXTe/kWLFFx6Y5rcCfGRRv+hwMMrW5eZCvzMzkpT4Wzbyfu3K2aTpjU0NJRCEk0JQI3IlwpxQY133TpvYWY5M3EQBrs9/y8Sryz+/N5PVE1fYulLsOwcCA0i+8e5cg3pSWdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgCzpLx4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgCzpLx4"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5bea4045so55159751cf.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779451491; x=1780056291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GcenNb/MJYNLMLymXgJ28OVOe70zcH9VdoXinEVS8c=;
        b=mgCzpLx49tU5vZ7vDj8u2P8idBbPHkLmv2PTocOVeCRzUAnkhBtn2jAErTkTQLKOo8
         gfCo48Fj010VB+NRKeWWeFRFfMDbGpRnXoAp2PXU9C3dC6XCAXIltjcmyUWe5LLeDUAi
         icpKELQTa67hfBCiLjm0YEyPMaK+PVa3EP6u4i+hnSd00C190FfYcn+pCMfNQIra29DP
         jkBZzYpzrhCKFb4XuoTC4TegPno1DrYFQt3imoHFBgobNTTKr5VMWRoLoyhuzSwDE6y3
         JS4oNmD7DEOPIFH4ujvbq+e1YgbX+VFtDU9vfJXw8yrCOghjZWULTdRsZZhDLeAQessD
         84DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779451491; x=1780056291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GcenNb/MJYNLMLymXgJ28OVOe70zcH9VdoXinEVS8c=;
        b=YHYpe79/ZFtndaHazZr7jfGQecRRbrDkQq9Q8PLEdbUbPOlW8zt09f77BMLI8qSZz9
         6a2CptrE42ZYpj6o9bXnSwvssofQOQcKO8FMQLoyQVqkJHSoEp9uJZQlw8Q6Gho2IoxV
         boH+08XqPfsTQE0BiwZ+VoB7J6QzECuerfuDzPCxNIZIasKp2VETS7gk91pEIHj7knoe
         mIfaYV5kEwmV03RZwFiN+ip+if7J3/VRLLkgZTTkcySFOiIBDwyGpZUjnq/HUEvWG8kB
         6F2lmFrA4ifuJhHfFnZeMTVJuMD5i3jPKP+op5jd36q/ShiJMb/gKZ3715AYo7o1WSRz
         yMaw==
X-Forwarded-Encrypted: i=1; AFNElJ9WhMOEJcsHJkrIfndZFOvLWvKQcQC362O8lnCc8/S/GqjRlG4kXn4zWIMq3okV0uPa9P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bPHjfpTU2CMG9wLnXzQmtZdLlihHXQKkN2s3VASVLyNbeCPm
	YFwr2uGzoS7THCOEED5O/19Gl/Qp/V5SxydDOAOP7Kr6Mtt+zeq5VM/31gKO71Yi
X-Gm-Gg: Acq92OGccGptvOn5MnJgQYnO2mCExiabp1FrAXRwo4eJpO2tL0BwmmUpBkAe1Ei0pta
	uXDu2GayrB9p4I5RjHNVL4d25fqUxnTUM4WVSsoM8+NZ7PZtUjrThNkic1gtJkWFlOa0mNFt8D9
	JIbGfOFBV0224zDZp4OSypzqu4vsZ/VKRpVwvs39kkT1lWCvj72yn2jNreDFWEaTxXLy/v3ftxM
	7Jz+oMetw6dExQSEzysdwGnLq4h85q4u8Sr30DGDaOS8Y7XUo0d13b2A5v7mtRtq5cql7jZhHRh
	M4VSb2eoGoK3KL9NUMXRiDpAS32P5pBsVUR1Y9z6vCC7+T/2B/DTigNU22L9/xFA3g8XchkRA2q
	UXqi6afF18s0xSE/P2qcm2LU/JtzF2jpI8yP5UmNrsOnWp/HvmA212cal+WIN/6AIRSpjxFOeIx
	3i2xQyhuxT9kM5FqyW7h8Dqzh1UoHuaYIvefCDRKdYYQt/f+SL6bKGET5G4nUcIZ1Q3cv5/jI=
X-Received: by 2002:a05:622a:198e:b0:510:1543:31eb with SMTP id d75a77b69052e-516d460460dmr45780681cf.53.1779451490826;
        Fri, 22 May 2026 05:04:50 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b0065asm11872491cf.2.2026.05.22.05.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 05:04:50 -0700 (PDT)
Message-ID: <f54ea491-4165-43fa-b1ac-14d0fe63fc75@gmail.com>
Date: Fri, 22 May 2026 08:04:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] git-gui: use rev-parse exclusively to find a
 repository
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-5-mlevedahl@gmail.com>
 <8d1488ec-c4de-4ddd-b3cd-e1e8b4a343bf@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <8d1488ec-c4de-4ddd-b3cd-e1e8b4a343bf@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/26 4:46 AM, Johannes Sixt wrote:
> Sorry, but I cannot agree with "prefix is only known after the worktree
> is found". The prefix is a property that can be known even if we haven't
> asked where the top-level of the working tree is. See more below.
Rewording is necessary, but:
This patch already adds
set _prefix {}
to the globals init block.


_prefix can only be non-empty if normal gitdir / gitworktree discovery (without GIT_DIR)
runs and finds the current directory is a descendent of the worktree root. That step comes
later, even if the picker is run.

Mark
