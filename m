Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210464;
	b=EnsWpXYhFVZo1CoFlO3//FD2SZHZVfZesm5/UdOLidmMeBvvk9sWEMP7czR2E8LFvrzh
	 fOmOWmpV65jtWFUvHPZ4OT3NXi7qVuikQLtOI7HD9UXXWUsY6N9Hkgjhq+0JKyuVs3uyo
	 kBNcasalNUQgtU0OgoFhMuzjsH3w1peCQjv4jEdWEq/tAPflUUKpj+aUcvhfI1kcf40Ch
	 qJWFnAls6HIYjiRrnxz6MCVUqbhGJje0HlZm1JzmaKfS2kJnrKcXrv+x8gIUCZK+keZDD
	 CmtlI4TgIpx1IRi8CrI5MYBgABBVNGSLnNBiY0kfjf40MA33x8D4iSmk6BjP+ehjNgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=MyHfkMpUOHnCcseIpKwg62x5syXuk1f4Opuzfqu6AMM=;
	b=3V4u9uk8tfRu1Gu1nasrY+aRa5JbqwE/zvZ671dG3iZLbl/4zxOUAngWCvh9fCOXQner
	 pLVUuqZIkMectWDdrwV6gL+5zn3veYR0AgISwEdeHDIEkhNCihtXTIQr6jkb6Bdb62LeK
	 kG2OBSHUsjPdx6nDZwUyWuzs92SEm+idD99ifVOOReE1LHBNlhGkFWAeHJFNwNdZadioo
	 XuCSfkG1q/ptp/A9C/VjvUhmGVwzSDsZCwZQH2kXu1xWioJWrXFq/q0DZDzu08N4XhcMZ
	 02HYB7zqtGyhyn3qq0ZiDqsZNipYJuPLyok+dau9wSv/Fli8eXOPkFZVIblQTInjERQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cY+i+FPY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256F606A324
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3256F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cY+i+FPY
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab37e44643so9590887b3.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793210463; cv=none;
        d=google.com; s=arc-20260327;
        b=UjuRF3022C1LVeix3Ec6/DrBn8k4RlSHcrQM0DTEw2XsxKmvSqMXc54/0E3DL7178b
         fTk6i2TOsp4stpUDNJzieLeMecOGpksVa5W+un2XHOpFXCo76HRVyXT88s85n24irRRv
         yInpP//QMCORKUXvwovatHajoExexsIaoHEShdJt02k65kLzAqwGAC1mzM3OqD1VjCL6
         3o1P3JUlIdLyMZfyalmvJxw1Fgse5UaNDoPN8JkO/0R6lKz+OTdX3SC6ki6aCn3lq7Ig
         H90Kn3/d1i8o/P7w8x060UISPMRKlKQOhatBGfNC6nlvzXHjlTkndLqfdCcAxnojjtLc
         uFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyHfkMpUOHnCcseIpKwg62x5syXuk1f4Opuzfqu6AMM=;
        fh=IT7Wa3qq5zbQPQjCwtBs56X3fIASTeZAD6I1TKYKsbw=;
        b=j7AjATDLo4RS6AJ8oVigII9R5gVlgnDR4KjB4uzpxNwNPzyCie3OTCrGYKtGMBfGxJ
         Xf1ZVwLBUwLiFnaQUqKSjBuLA+QZXh4u58Zlkfr10rSSL3S5CggwthWb+iAqOC29q3OZ
         HGwRUqC58hsIrr1b3uZnS5C50IVIRwiYj2cIj0eoHBbrcYLva75+xUcZJ/m8xgSQ1deq
         Vib3YU3cIB+w4317eT/4VUIFo2dvbphJ5f4K8o/9hwl29N56vkSfCFAmtXMjAHI7Y1Jd
         VsBIF7zNC9zaIIAQTm5kGD+ZAYroA8n9ymANCC5pclNRUeZxR/yLIiDPOlLS2Ni9tiwl
         PJOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793210463; x=1793815263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyHfkMpUOHnCcseIpKwg62x5syXuk1f4Opuzfqu6AMM=;
        b=cY+i+FPYz74/SwaSOebZkDqY4dMKi2IiQ524NP/hwGDGOXgTSyFgOzrpAhiII6kbFv
         Bt5oAlFNJc1Mg+LObSu670+f2ZrshuIjwodGYujFx2L6ljKTgB3dH9SPV0ohcwVUe80m
         prp/VI6FIFQhqPWOJafoBVY84Xu8YYdKPcPXM3pGuwItPwuoz8vniRIlPsdhDwYb7937
         QjaZIW7YguA9tt4D5thiX6aLW3P789peTJVXAH1mZ10FpI+rkTzenf9SP/EtniZL9Fcm
         ElErdNfOv35KqiX+1OTIBpDv5zhBGYmveptbYh3xxXSnsUc6R+HJzXHKQ89yV9ipd2dV
         k7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210463; x=1793815263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyHfkMpUOHnCcseIpKwg62x5syXuk1f4Opuzfqu6AMM=;
        b=IchTyaDGEEDS0ANXbb5oVLzcapwej1idqj70W36EI7Wd6DUKk3NtyWFV0qhqAchWBG
         G/pp6vs3vwKWqXzGlJ4Jz6WGH0pxna+zC/2AdFMD5I1wkOlGz2O2e/T6GQeuF0InM9DJ
         4AWW9bv/fHeP33vK4QbCbyCL+4/Wbk1XxvYkvg0vh0ZUSpB4Txe4cTaJhZEdqC6nOliP
         1fGmK1KVCmPaSTUrJ1uotyIj0BA5hlasUfukeYhSCLGs3QkcBSu34/K+7PuOK+yrV7F9
         CFXE3SflAmh5oDEHaqvlMBu0YR4sYvQZGZOxgFbWwScdY/ONE4/JQeh3egIBc4XkyfVo
         eJVg==
X-Gm-Message-State: AFq9FYJCcviViMozmmdMPRuL3zoxQVu/AQLo09wmt4I0XMDjmrx48bJz
	xeArvzE3IwKXOY/185ipBwgUiTlc73LcTY9wVbgozoweUBqAyXGRK+y8G0kmgmPtLcVGHhSbWsH
	rsJywl+XlaIN1UqKSpnL62hU+4FQCBVI=
X-Gm-Gg: AYBFou0eSHxEuY0qglio3UV7TWhwGhKxrlBW0LAbh0LHb2NNPt9+/SEWdlK6D2mEp26
	6KTIpI9WDiYJGBQdlIBWbn66YttJHBZGbrVaqMdj7dfxpdUzkbZAfcK/z8VukNiHeFo9nCNev66
	gtH1VUazQgRepFzO/MHu8pWOXtC0sTCVV0LHks1ZpflAKRfxUqYPihFqX3rqJU1kJPeqh82/+HB
	92orcqp7odjQNBUHylaNYz3Qbh+WUf+i1IJPLMtI4UIys/+khX+foPD6QbxNHSWw6h4xZ6U/RxZ
	h3Gl6QxmWLxPXii7afLghHnPXngd7fWA7JU4FJBEXGB/6rUHlF0d8oGT5fYgpG0ab3+4SpGugKA
	oRwFFVSp2RAodvWJE2B+scih4KZDd8EUJ9ra68RCMQ498yDp+IwY1jusCA1ZgpjIhdgQIqAHRpY
	gEdiJy1K60543Dn4MhX6Q1HbRdURv92CtHnwBK6gS1rg2BybMf2yClPBVF7bjC7clbxAmo9BANY
	dRHgPfg3q2v+eVJ3hjJyY4U42XYDHJknP7Ui71+
X-Received: by 2002:a05:690c:8d13:b0:8b0:a224:374d with SMTP id
 00721157ae682-8b1b5c84592mr15356627b3.21.1793210462998; Wed, 28 Oct 2026
 11:01:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025190253.2207856-1-dorine.a.tipo@gmail.com>
In-Reply-To: <20261025190253.2207856-1-dorine.a.tipo@gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 28 Oct 2026 19:00:52 +0100
X-Gm-Features: AclHuK-s70Boct6FUbanglRIgOE6gqs6b0ICKt2tGV1vUFLWMyK8OHbwEB3wGk4
Message-ID: <CAFpMFfCu6JrUC8i453qBP=AktqcG_9sGX=1-1ekEDCYm_+pkUw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] list-objects-filter-options: pass repository to
 partial clone helpers
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, kaartic.sivaraam@gmail.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dorine,

On Sun, Oct 25, 2026 at 8:03=E2=80=AFPM Dorine Tipo <dorine.a.tipo@gmail.co=
m> wrote:
> The file no longer uses `the_repository` after this change. I left
> USE_THE_REPOSITORY_VARIABLE in place to keep this patch focused, and
> can drop it here or in a follow-up, whichever is preferred.

I applied the patch and tried removing the define;
list-objects-filter-options.c still builds without it, so I think it
can be dropped in this same patch.

Thanks.
Okhuomon
