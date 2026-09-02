Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C32AD3C
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333064; cv=pass; b=XSVW+7kp/9zt3rlu7IGyvJkiUAI1EkBOpg0D4uKqh3EilJ0ByRU91K5SWYE9HmSb21jSsZmbihAQYx6Ced/o+znVZA+VVTkX8LcjLm3APl/KNiqCGbyJpPf9KjNYFmH4L8r869uEiUWmHbZU/DeU418pfACbx8eYvD/r4+/Kk+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333064; c=relaxed/simple;
	bh=sYwmEwhbRrOqSXPCMup605vTRWi9qV+kt4axCdSuwB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1yJJoeZp5Hf4MJtJH9nAIXk4u4T6Xljct3V6H2DMbwDva4PDte35pp0Z3uet9lgXMcImMp5LAYAzpGYC/NUrWjGfyvHu+AB6oxOVRnbEYgaEqTYb5QSWGKiDag7rMd4Ky2KTu5+QyYdtmvW2gSOaOpm6Pr4NaH1WiPoN1/aoZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/jmfSb5; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/jmfSb5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so574255b3a.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 00:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788333063; cv=none;
        d=google.com; s=arc-20260327;
        b=UqRxIKUgzgaDUeEgaMCurzNJ8SqRa8KA0HM1JagJ1p4OfwnvoCKLM/8JDYvK7uYOb6
         Fp2JdDLfo68bEbb3NBQBDwfgKgAhUNQpL8NYL/Yv2GuP+4O3/ihowdJruptnI5pdsb2r
         yQtnCisxz8d8qAL5Qwlm4S3AecNL9VVWt4lxOjizH7hZoIkiNHWxAJi95Yf3ev953/gv
         PuZUhwv7LPEhMmCUhkSvEn948XnJteg16SWuL1fW82SPKgskeTBlrEi1bjOghIw/aV/Z
         iwJcLZCFEtXXp+6O3LYibXOqSt4VnjblpE+ZJzuUbBD420fr2xn3B6osB67CVJSpQv8B
         i1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lMvpZ6X64M61odEfucG8/Dl9ZX6VeiBKPn13v7K8GI=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=VhwPd1eLMmSdnsRxgsb4Hs4OUbGbktGq3fwBKuB/Pj809sW9Nja3T+pvW9nYJx7z0/
         E6K5Hfa+vKwndGKMJJdxXrGAHKng0uM9JHuxDaizkxXoHKN7+U9+CbBxXJJJS1TTo31k
         7AwUTC5XhQHCWtxuPfCoyQiKZ+3MbqttFztyyI3woV1jVEAGFpNlrlrrauXDeGGVrr37
         V1G0am04A+w7hJss3sC6eQRozXnP6H2DqsAT9AxJLFcM/kQcVYgX8FOw/vZZknfcc4dK
         PFe8tkv477dvL17ueHdZFsmjRpnEY7OjlM0ITE+/pYk8fFWlvrdsst+A0ViymZ1lh20j
         r78g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788333063; x=1788937863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6lMvpZ6X64M61odEfucG8/Dl9ZX6VeiBKPn13v7K8GI=;
        b=j/jmfSb5OZMOWIsMIKNqxC2dL3DdKWxqp5DM2um1hVoqfOb2sw4axpU4EUfbf0M3cC
         KbYiWu3sNPUyElCMlGE+hh2EXM9Z/PXrAnBeXHLwIgBRxbtDnz2PZZ2xEuRa+qwfVdqG
         qL41P+i6mJksq4wgQtwQA73ZIgvXQl1A8FSyy6i+/X79iOeyUE55Ts02DyyuRw5acGxB
         UzcNUZQmV2BcrOvFBg3Njf3ytfuaOzonLLSM3rSvEp6Av6fGPAZVCbbu9tjbppwuaMNn
         T2Tm9UGb455iynjMP97FFjVGsWT7O4sYSKmRytYKUTbbqehN8r1grTn2mFq2b5LSBxox
         hw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788333063; x=1788937863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lMvpZ6X64M61odEfucG8/Dl9ZX6VeiBKPn13v7K8GI=;
        b=GHcjm2HCpDAYm3LP4zyO1NeTMY8X0jQpOf2kJg+I3OSEAG/y7dDyOue0um9Pi1bmZH
         MlYb0LiH6W7r1CGmFiGZPbhl5ajs8tkR8amjc1rN/h/uC24e73ZXfczvpbTrOuz8tgMo
         inc3izRvyDpRHbQMWJeKdz5auPSa59S4Kjcqxhd1WozPVN0gVoEVU4Xkyn6XgUIWa5qG
         GG/IWutA9/6RQbOcLAXVPLKQK4AcuNCIWqoCWMgzr4k3kjtKVZSIhmFD1yZSTsR9z21v
         MtJJobNJpHlL/7hDCtMSrGij8eUHJbZ2Mh+gO1KfF1HJrEhf1mLlU8LLauXwIkT72FcI
         LALQ==
X-Gm-Message-State: AFuF++n6vATJGU2bNaRdlpxXTP9mBwdWFnCTwyP/kAff2L0rwVKLXtE2
	rbqy/wbWUHgUjB+NCp0HeHIKGmG2uVmAmnGZaETA0odo54QB99LOOv82fL/kzv6DeRgYGg3UPMI
	oO3ClDpu1l10LE/HSm1HcjEc/4XgM92w=
X-Gm-Gg: AR+sD11NZJRALFG09GgxrxxphHSHgkIvgag+4jUZmduRhpmPk3YHSwLwhSxAn8qqX+B
	IlywzaaCubShKHoidAYXrELiUZJQLI4mRZeryqC4e01vRAlyBCVFCEaOVIWLxvkXwMtdXPLNta6
	ywwMNGH0NxN06tKMmTi7MgIcSrFV5nBxCAQ5g55xDwHVqKoi6bsrRrUcN8LThlvmrmCBK6w0oaP
	s5v18D+Ck7Vs3y4LwmytahrEy7LnJteF0y5VhuhL9FXIjTa26YCJQ+q0Kh1YZfBdwM9fdwyVtgt
	fLfIN3C96E/V+LC7+ye5Wk9MJ9XUddvPvg+uU6pxgAzaokj7R1G/oSfgHiKP5AfJXIDV1Xl1wc2
	sM1fg4YrbXUfZNCygevifhykxaRW0q2LkUMZVxwF1qodrnIf1/AtJMRc5pPd5uUxaBeHG3825S3
	E7UjtEevrN5j+pMASxaL857VZXPQcQ
X-Received: by 2002:a05:6a21:e0a6:b0:3cd:9f0b:f7a2 with SMTP id
 adf61e73a8af0-3d9adab2780mr4353460637.11.1788333062583; Wed, 02 Sep 2026
 00:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq33vuw0ht.fsf@gitster.g>
In-Reply-To: <xmqq33vuw0ht.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 2 Sep 2026 09:10:50 +0200
X-Gm-Features: AcwNN1WUuuW8bMX-3703s_1iGT8SjQMBxjcjDK5uQ9e5VZDZSFxKltTPREvoAQI
Message-ID: <CAP8UFD0iAvN2=j_15xUWiWuRMSJpBcS6WiYvOaB=wbdsdJyZ7w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2026, #13)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> * cc/lazy-fetch-trusted-bit (2026-08-13) 5 commits
>  - builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
>  - upload-pack: read uploadpack.lazyFetchTrusted
>  - setup: add 'allow_dot' arg to path_allowlist_apply()
>  - setup: extract path_allowlist_apply()
>  - promisor-remote: factor out lazy_fetch_objects()
>
>  A new 'uploadpack.lazyFetchTrusted' configuration variable has been
>  introduced to allow 'upload-pack' to lazily fetch missing objects from
>  configured promisor remotes when serving trusted repositories.
>
>  Waiting for response for too long, stalled.
>  cf. <xmqq1pc0mr5i.fsf@gitster.g>
>  cf. <xmqqecg0oabe.fsf@gitster.g>
>  cf. <xmqqy0e8mv0k.fsf@gitster.g>
>  cf. <xmqqjypsoami.fsf@gitster.g>
>  cf. <xmqq1pc0mr5i.fsf@gitster.g>
>  source: <20260813154748.2378747-1-christian.couder@gmail.com>

Sorry I had another vacation. I plan to reply and send a new version
in a few days.
