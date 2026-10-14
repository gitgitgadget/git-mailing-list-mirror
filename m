Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6973ACF0F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971831; cv=pass; b=THh8Rr/LcJayUCMUlPXQeMpYWwZXRkrN/FKpK9TlKQmz/hn/64ELQ6mkV6ntAsn1lBUWzQcw9CfbvKHKvE301yveHo2Dmlz2X3NI6qytJCBnZfW3XuasIKXDcauBcZTqM0tlJeDVj1FJZ/Tdghe2QJztR7pnweWz29aWNAuA1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971831; c=relaxed/simple;
	bh=E7Of84j9Rwi9hAVcz0gYYZjbOXRWOX3sAeFTzd8XIWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1sNicTTwbQLfjZyHmXOQaTOp3GIr2/6fopTqB0hw03/+zpo0HsFlYHTxJ+GZJG8o4YVNBGEvsdoqmZla8Z1gIzzzm3ZlEW0g8/G4Owq2pxLjF0p165OAAdUlBusdF/heNE3gWTlQp9g7ie95Le7TX5BSo9SwxJfM6zD+s7/LCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2CyFd8V; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2CyFd8V"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-679334baa1fso3261948d50.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 02:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791971827; cv=none;
        d=google.com; s=arc-20260327;
        b=ea66u+IXAW1JOtGGkzuVOqg3ZyGgPRE9p+avvANXTR5t1V3CSBYRrsKzIFNelmUMwr
         d4ziMIws1HYoE+NvSFcGv/zmjc93553bVu4If9MxlZv7ExwNZFj2ENI5VzhhUaXD0/fu
         WxbgYiXQEBa45vqlQWJOVDBqJJZmaIUFPnp55qsHmQxTFrR+jnjyxpHUjKVVz3eW0CE3
         sZ0Io9u4/c0WxmZM6HdE2dQhq2Als2c08Jsdj31/72L2Bd19KP7EQyjnJhtS1NBMb5pM
         8MPhHMyGPqavY0OHboS1bDRgDJKlzaJSiP8uuku7z4FnAKOurQuhzYIcIKk52wOvxCYW
         LGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7Of84j9Rwi9hAVcz0gYYZjbOXRWOX3sAeFTzd8XIWY=;
        fh=vSj9PFhPeljTYt/cuRUiB4FEthFjf/0nTmE6dJoyn0Q=;
        b=S3dX+cm1AEH+tvLzhYAaqiJH1BT2Mp1IZBpos5KaQyNdcGpRqfOD1VpCgXkqdboSDt
         gxpOufmrlQ8MFy+T+LrfddPEm4PqeMUvwdmUBVtJEDxQeOprvvakafKNrIxHZ8xPG6gQ
         NetQNHBIrS2F7zhryeCApSun6NOvcSkDhi46ZVXdiCG6AHn0bnz+3Oz10Sa6zxCqlJY+
         QB7hRjHKn/jkx8Mz3WbuyGMWJd3suadQbnPFWZ7AIedurVt8PJE8ckYtSPzHwm9lVmXk
         iVe1GcYmPfqCbVGr4P6CjR0vYTDwHpviDtxauvjgSkO2TWGUo5ERgoX/PCHipQdN2Y0/
         /eeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791971827; x=1792576627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7Of84j9Rwi9hAVcz0gYYZjbOXRWOX3sAeFTzd8XIWY=;
        b=i2CyFd8Vt3JOztFfhujVYlXrusu3Rm9l0a1b5WkBHL0ZQ8EiryF9V7Nl3tHiDESFSw
         lci7tdorR12V0EKmuegsX5whs+Ai34F3dgGe3RA4FWooHTCgbkXYZxBcsUN/kdNGZmIt
         +CoayFhIKFk49tf7U99L/T6AMEWCk47F5NCBUvqBS+cBXvH+jw9WDjs1eqJ8CEwVVCNZ
         zdtqMXjs/Dod4JmU2v5t+Oj5qzwNw1NXA/X4Bcgw1U+ZYshaNfgOCNSr9yQwkYEFJuh6
         +bf1aPEu4TIbiJao7xko+DO9l59zTzbDDdpqGe09C/C/MQKg3SThxVX8AangKTlZp9gY
         GzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971827; x=1792576627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7Of84j9Rwi9hAVcz0gYYZjbOXRWOX3sAeFTzd8XIWY=;
        b=1RbAhVlILIMYxglD/GEv/XVDCLbCxtSGxXyk64IIzFesooaxnbijh+152lVvFki7Nr
         AT7SsTyuYKoZQXPRDoFuqiSnaeHl3XRP61+EIHDWvo/eT+h4kWQeZA5H/JSf+OdPEYtU
         CPk8D3s+kV6mmuCWHqtCBZT4TtGGRmY7snko7oKFma7HgZ3i6rvhcaQf6oMHn7bBa86A
         4FFb7S0E7LjOMzgE946jxsnziRtkpbZTWg6DcMCWUfE+gxpaSUG9vwn9G7P7tz4tY2HX
         u3f0vTxvu14RYG1fuAtiR8gXbN3U+ZUslPIPkTgEDDaBjXzzDvNJeoXJTAXGIiTuypCh
         fTYA==
X-Gm-Message-State: AFq9FYI+sxZvfCTCqUg64jfWgzNOdDD67bNoo5bBES3faf3EZAtYVZnF
	NoL7Up7jMSja7q0dqn3u3FzCKkE6/Xf7BCaKhtbX/i0ds4upl3h/0SaliAIr6juXumj1pPWzqfZ
	THO9BSY4WLQyK1XeOgXprQ4DK4/Rkb5g=
X-Gm-Gg: AYBFou3YBvBQA+Y1ResulyForvZ4S3Kx6+j+WlOuoLmU4wgfSTYrfTHHQoB02RN3a2Q
	AgwUaMab2b+7+ufzJaEbwdj/Qnep9l27P2zk07Zu8m3UCViDaVvyCp0nDcM0Bkjk0eu/7r2CsTw
	E+BsZcU7hf2NcuS0SKRjgwoFz9jqLDpmNjU7kC9C3g9Mj+LfH0CuZumRgLqO7NnbQcmqaodP0ES
	BAdxxjsHxAKHK3Wveg5L9sUkZMhFMefnfNCBnrMk362MhTB8sQrj41Fxjo7EiEtOfP6aE4Z0opO
	FPxBuAUz+XDUvqLpEG3RTdVguCXyDJifIkwV9IrOfRNyZg6SC5hVNWyTHMnzLMf8vqBjOtCVTez
	eXbGoO90J19g=
X-Received: by 2002:a05:690e:4399:b0:677:ceec:5eb8 with SMTP id
 956f58d0204a3-67936347021mr2506329d50.153.1791971827422; Wed, 14 Oct 2026
 02:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJoPjcM9s8s9+0Pgyw=dnQXcg=kXuHQ7dKZWx8OaJswo+a1viA@mail.gmail.com>
In-Reply-To: <CAJoPjcM9s8s9+0Pgyw=dnQXcg=kXuHQ7dKZWx8OaJswo+a1viA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 14 Oct 2026 10:56:52 +0100
X-Gm-Features: AclHuK-Spi31dY6Lb6ynBRzcF-I7xAzRxETleLSqh3_SNhIF3ElLqJxGjhUJw_E
Message-ID: <CAPSxiM-xssgWJaY+x0xgHDvWfTzw6Xgg3_YYiwh6XVerTxyG2g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Subject=3A_=5BOutreachy=5D_Interest_in_Modernize_Test_?=
	=?UTF-8?Q?Path_Checking_in_Git=E2=80=99s_Test_Suite?=
To: Victor Okafor <vua.okafor@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi everyone,
>
> My name is Victor, and I'd like to contribute to Git through Outreachy.
Hello Victor,

Thanks for your interest in contributing to the Git project.

>
> I've built Git from source and am starting to explore the codebase and
> its contribution process. I want to work on =E2=80=9CModernize Test Path
> Checking in Git=E2=80=99s Test Suite.=E2=80=9D
> I look forward to learning from the community and contributing to Git.
Looking forward to your learning and contribution.
>
> Best regards,
> Victor
>
Thanks.
Usman.
