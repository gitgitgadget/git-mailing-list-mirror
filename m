Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1ED37189A
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562737; cv=pass; b=hXvjm4zFN1o+iBlzzvbGYtOUnVAyfGZCr+4By0OWfook7w7jjuQe+hTNkukX0wCZZH8+lUgint0QskSqg4D4nLxLBLLlUU4PmiegONM9mL72WTDpiTNMhmYPYGkLgh+mzKx1N7gmTGAaKHf+BfpR/9ZT1GrE2kBokLi5UhwLppM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562737; c=relaxed/simple;
	bh=GSlrbPm3/oB3nycZxV1DAyZpOjkHHmxk68uQjVYNg+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNUHSFaePy0PGdtmjcwl/Wosl8G1DH7fAi4wP+q/P/ftARrNNjivpox0Yq9oWm4fENsVOlpd+j1ULbviapAL5R5U93SI0FLgYvLk8mFbgvxjfAcRltjN2mieqOWFgqmx6rPZ7Xw2GJ84vbM0v1u9FonOIkeDjVOlCJWyMkOAhDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB781dKP; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB781dKP"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b0be561175so371174eaf.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786562734; cv=none;
        d=google.com; s=arc-20260327;
        b=MraVD5ROYKg+dle9yV/UGoNgFlp64D0iOC0IYXJ47+5FrvZ3yItLOHUlAq55QUcP+v
         oiH3sGgufc5HAMnDZ8dK36pzQza4GAvKVndmkOajHKH9UjFLRCY6Xx2A+Kb4NrRSOHJI
         mvtJU1E9Coojr32uYVr7GtV4cJS5ikl05OEv5P7Q9qBwI+dS570/cYzWurF8n9fq2o3k
         38oN1qZGTTYfMXhughvayX7vjYVi9dtE/PhW7jiw3yawVhiMqVreqy1uGQZwc+HX+oeg
         M5L9kZba6xGFgLc+PSD7u7oDQmuiegcKKsXDZUKa+I1vBiYWeSWVOqdJmEHzrHxECp1k
         Ycug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S4ND2espVvxfBvWjjkZJNeizzAdwlUU+6wX7aFseIaA=;
        fh=NQ1lijNvuCnfqicAybrOp8HnYnRhNIAgUvj45MapaQU=;
        b=juwePIzUqDrIVTXIGM90G9Fy8heUlUn/hL/L+n0xmJ9vXjsPJM1rqAZin56iF6aec1
         GQaF8Qqvq2Xy2wRetw7q7E2TFqtdH79TQDuZsAyzGg/XXhsR5euVJoKX17Jp/pei4qxs
         XvdkCEg/kjUOgzillTyR6c2lCLDYdIuznbMxnlb/PmaFHp5blGGO7lHj9gxe7X63JEf0
         9DyE+Qpc5Hwzr1Iuu4kkEVb1No7CHOBbWUzqtI5hbTflBMP1uQx32Qa2MyjdDkMq6oYs
         QE9JDYKex9Xo/fptfmfIv4o212yea8yzTK2lkDnUS2dNGVRRfg26kU58+5TGychiXoqR
         5APg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786562734; x=1787167534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S4ND2espVvxfBvWjjkZJNeizzAdwlUU+6wX7aFseIaA=;
        b=MB781dKPbhEVgh1CaT0TwG1i1bNxEf458yilMw+O7ULubMDLo0m8i7iCBe1I2g0sRo
         JItiPnJ6jRU8a7J6n8/B+ryEjeYofb9xF5RVtQ2G5JT8KKXgCBW7vYNEM9qzTACEk8ao
         K9BhyEe+W5sTDtM6G10V7xlwdxFuEbXY3XsWe/Ev0c7li9Z6lnBmbXWtHZS7qJNSBGfF
         RMtea2nGu0JiEVnEIafW6H6pqZwo1m9TegZAARFqL8X3AnPZ163kTvHb2j0Wg6IkGCQ4
         J5AW3MeyiChFTWb43Ge4qUF3uWbh5BalOJVJwWSYqVipQo684NyHiVj44OvK9fjFf0lV
         D+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786562734; x=1787167534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4ND2espVvxfBvWjjkZJNeizzAdwlUU+6wX7aFseIaA=;
        b=nCrnfF/H49gj9e0efPNinu2vav5Pj9p+Ag3gRJwNifsg1p99y3bichpZfkGi0IAvQk
         t8QgJMDsgin+yi2TM3gbJWVzQ2k65iEu4l/P1zuoq/kRrpK/5p9WbmVSJ8Z1wxNbFJgF
         BdknELxdaNkQst/+rmFx7kqa2d+A+9q2dC07UTKJPY9cdLnvEku/ueCfK/CuB7Ahq0Wk
         El9qessY5fUIw2EbVIXlfiGO+Sfg2eew9JA7IlocMff6sgbVZ+0jNHfNVXICDrCYCcia
         55YA2bD1OXGeJo0hGrZ3djXTH/HG3dVcQRO1fc4lxuItVps5YFJV0Gj3+eWDh8EgcAWS
         dE+w==
X-Forwarded-Encrypted: i=1; AHgh+Ro9RsVancj/SEnvViCLpijjepGbP1pmfsRQjIxXJAjMh3rNt21dV1MSr8r9NKG78TIIWrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9B6ET3Pe5sB6siMUIwKBbqzvb3DQ+lJCfj+sWDm7zBBBBxLvX
	yCJacmbWIhtr7IaH7t3MluyPRfa6JMQ243T+11qJq5yuMFQmPGOSjRkayfiT00PvbVsfbplpHPA
	rIIuchCM/f2+mXjsq1C13DC1Rapsn0jjYqw==
X-Gm-Gg: AR+sD12Ugvjn4zXCcj249msH7JArNF1pNHuqPWNW8MxJTvM0pXuT2IaTpr5AnnoclgH
	AhiVSKQt9haSlyn/SaDnn6LTigidM7CCuwJTOoCaLR/K9YpAl4u6XAmZa9UuqRnx3LJwxYxJrbS
	2XIXwy+Njvm9EwB9RQ/A+GnOmoODQSHMhbi+l93i3OnmC99ZF3wI4vuobBjEBQkdPzaDfQKR8pA
	FueWnn+HWlm9s5tHHnTeIklxslm7kq+qNEA1qzM0YFsEXFYGPsAQwyH2P/E4f6rJFsDukb398jO
	3tZtyx2l9UJP67AE9YGYkswMlHuDuTlrRrdh8nMX7zNm19zNAgkYjQYTZMayyh7qaH46IMT2nZd
	hgEA03+6UDbSqjAPCY+8DxgLRhdOG2snVxG6GuqHioL9hYsJfcSv3Y7k3b3F2uJI=
X-Received: by 2002:a05:6820:4c82:b0:6a3:8738:410d with SMTP id
 006d021491bc7-6b0c4280ac5mr868634eaf.14.1786562734571; Wed, 12 Aug 2026
 12:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com> <CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
 <CAL71e4NMdOeL0Mwngpw9qn=sSctFEVMPiYEiWQ=LT+Ct-mP02Q@mail.gmail.com> <xmqqwltvw628.fsf@gitster.g>
In-Reply-To: <xmqqwltvw628.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Aug 2026 12:25:23 -0700
X-Gm-Features: AUfX_mzEX2D3VjgycBfQh_mt9DX8bIOI4f1jhW_PB1PgfNkVAW7S2t0u-EwAQ58
Message-ID: <CABPp-BHuh_8q6Hy2-Bk7H6Chdb4+eeW1f4LZU0szZ4zU9Eeo+w@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson <krka@spotify.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Good.  We can declare victory and mark the topic for 'next' now?

Yes, I believe it's ready now.
