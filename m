Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D53563E9
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212080; cv=pass; b=T0LL9+h2DtH6AFDPcMF/D2w2bPFNJhGpufy2yPgrptg2KWZAW/YAxA408HknNoqLsMNNAbeu/IFicWDiIQ8w3VJj8BxZsQDB35NwA6cJLEPDAJLAyXPo++Ij8a/0+EMaG9D7G3l/ITOlRXcSHurx4l4a7a55pGDNMavfRzCHS4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212080; c=relaxed/simple;
	bh=f3PAryOLnQd983bmLgjEbvhl/NSKomQ3TljHU6zU2bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE1Ha5cdX9R89rBt1NB1Jto1aBioa7Mqy9yZKPsTblHqoxIkd281zp+ODKTMYqNxeVK1l/dbq3uGDziZfx12RLMIntfmS41TW0VfEREjGSjXNqHaRuPa4De1Q8avxlfx+eTJybO5YwB/8EuwWEIbhBB4Fp3sNg6XZJCiqjZWtyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy9z2FDk; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy9z2FDk"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a93ba42dso26012371cf.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 09:07:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212078; cv=none;
        d=google.com; s=arc-20240605;
        b=Kt1i1fLZo1H5gC8r6T/xQxm9WRJmg2qXe1u0O36RFiIkeNJbtGd775pkttEKBLQyQ+
         4/sfohnlRhWbsS8KTauAhVmAd8snalVzljp7wr/9naNaLuoayPCOMll1LGU2dUFIkIST
         jnqztop0piEHfdQywSv+r03zAdv/QnaO4a+I751e4ibpXJn3BqFQVLI8LSk+0XVjo3xB
         0QlegywgJ9+KTlrGcCW0HPsNYEEyRfakGHVG0z+2NfVORkizsM5PVR+MazlsXPj3+KSF
         RFuRv+TDTjAhwHe8LCyGb0k0ypxFSOeHD3rll8C39YrXx7AZMh+an6zPsLRAwfN1kr/W
         5AMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f3PAryOLnQd983bmLgjEbvhl/NSKomQ3TljHU6zU2bg=;
        fh=Fji4um2E3ydiKJWDsG5AXK5VWbBg2RiGBdOk5xuRjZA=;
        b=QVVPHyMOfhPEKdP7uLi99baBhFnKAsfkMkWBxcYwbPzPiDEV/Rsn23HXt1YamvEQcb
         Z3OXRk775jYVJcEm1/lAQgI7cimfyA3/vq8aWvW3zKxHxdffmk8W6rnptnDTrW2ksGyl
         +vNI3Gbbp+ABdwr7CZhEKQoribd2nNDoKn983ywZpic4EKTP10hT6iT6x//E4i7TePo5
         UXmkHGqzl1zSH04z/Uu9YxV/asVXWVK5v8yJtcpYuZBTRnm4Bo5wjWnFO28S0lgN5ocJ
         1eBVeWpn+JMLrmQJbWlf0oDIjU4BUpb8dHyJp1GjvrkxaJFkDvwTrMTnQu5HlmDlpUDq
         fFjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772212078; x=1772816878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f3PAryOLnQd983bmLgjEbvhl/NSKomQ3TljHU6zU2bg=;
        b=Wy9z2FDkUrTnuv47Y1JWARMVfgXY0XnLhx25HxtGhYInH34HkztAoYIoXCvUmQhRP2
         xP3nIGoq4deSre1JMb1VX/BZuIBOVoMWYXB1+QHiFs73turgB+fvnBxzihlE7AimMLPN
         Gag51aZ2WDzKpEGAllY4UDjse7uBrTaUBGJr1IP/itRhpSdWuoQtGHjqBXCwGhcfG0aX
         +z0GKie8f54NH7EdOhJu/zcxanpbXOggT17P92HnZ/6GcmMtgBJ/oJ4GaBhdtIZxrLSr
         kjKP4mAMoTCr2uVdMwDSR/lSud/ZllLnH0MdoQNh+hzI5Lhdbjcwuu5AppeJewe+u0YW
         W5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212078; x=1772816878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3PAryOLnQd983bmLgjEbvhl/NSKomQ3TljHU6zU2bg=;
        b=FgxGVkk+agn5qSAJQhJojy1g4WYW3fO6nPbvK53npXC7BxTuoShPMWqJei8TdjwwME
         o/XY7GNDrCAsSk/6FOzjf/g1PfYRdOE3a3z1HOnVNtqGzzeLD94jQy7ESD+2h0HS50wV
         dlObooiUEDpR7ezH235pxHtXYbSabVrMxqNflNajl60G6v1VYpetC/GXoLYfrf75mQdd
         +DcPNFGryVKxKgeDz4SizrtJohRQ2BzMJZdHDiKVdKmPDOJ+5jwU4mi3gj0o6LE/k/cl
         c/WG23KAx/74SL4U5q5RJvJw/VlaR+fiqQm5IDodK7t/ieq3wueMWEceCTcKCFg8c32j
         tf5A==
X-Gm-Message-State: AOJu0Yzk0ob1lgAku2mXB3s8AcrU1igDnYR29LV0EWC8yDiKECReUs1n
	oaotAlE/cqNUtAdPQ5K+tLqVYO/gtEi81qS5DxjoYcUF48sxGF5apzc1TYzvVTP3dXVoMr0xGqY
	WnKqdgeQVeQEj1x0lKgA1lA6ezEPEWnMR3NDS
X-Gm-Gg: ATEYQzyEEaPTuOwSaUXtKkAcm101GaHWlX08NhWctjgAeH4ln6dJwzfnw9eB/UD4StQ
	vVTbhRU++rFUDj6FOI+41ME0PC3XJQ7mFho2FAgE6rsDhOUSvi4rGyb60slZdhXQouJQEMJttQZ
	+x1XlPNYJ/811wg8HzN5yDbhAW/GKPr10S694RHsQJF3+D3ocjeEwUXFMHl9eNVR8pLeJH9vaq4
	8u3xZBvHvbukzt16VLzw+8YgnG/bJD4rPfXPgBRTWMXGE4OQDPEypNnX13Y8OsTBK+Qu7mmTQJq
	lx8ugzshIsF0OuVdEQgPX6JAp3997LGGW4+AB8xy1YFC44qD4nhZioVyCGUdyEynLkkAlFnNNk1
	fi8X/S6dFhrDDqMEAwWfK9DGbPg==
X-Received: by 2002:a05:622a:1923:b0:506:1edb:2cdc with SMTP id
 d75a77b69052e-50752726a8amr44252341cf.6.1772212077474; Fri, 27 Feb 2026
 09:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 27 Feb 2026 22:37:45 +0530
X-Gm-Features: AaiRm53UY6xNsFAGDlYp4yy_sOKg4vbK65slMzzBLm1Pih03WOGiE4UEtg7Pcmo
Message-ID: <CA+rGoLeppg4Xaoqg6+SZ=ET=ze6rXUbmjLm5UvmitmRGm9u6ag@mail.gmail.com>
Subject: Re: [PATCH GSoC] repo: Remove unnecessary variable shadow
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	lucasseikioshiro@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hey Junio,

I got a review on this patch,
if no one has an issue I wanted to remind it for the next cycle.

Regards
- Jayatheerth
