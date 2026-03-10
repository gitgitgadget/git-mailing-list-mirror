Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91543C9EF9
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145901; cv=pass; b=rUzfItVM4Aho1Xs3hwuP+wyRQPrpkd0C2tqquCUzU225huri5UeEMQd0B2BbWaiqV9s0k+yv4DDetpNZXV14/01A2WI02oHXRLcqlEU6gZrE9MPpS0ItvcY+hWFFGKw87v7k03O5cJZV6vouY0AYFfTsTLZRclwxo0i3XhDiKpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145901; c=relaxed/simple;
	bh=ofasqmbatbsJaXuCZkbO1BiI9kACGo9OjAIqoHbt0Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeuWqySCkeI083auofhQi0YYroynvxhT0MkFMe7cRpSKhubEfLEXgK871f0Ku6a5+lNig7zO2Z0qd9Soid/ZeJLZgeFDFRkOKBYNShStt6A7m8zdwKNLwr6dSCPC60KyMh0be2L+htKNXqB7M2MVuo4/q8xrCBVWhG7nb0DOnts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Xu2InY; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Xu2InY"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128e3125372so171677c88.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773145900; cv=none;
        d=google.com; s=arc-20240605;
        b=bBloT17T/rgtMpFTT7CGjcCfqYXK/gUEVPpkXUmsbNL1IPkJijphJqXC5p5lXPs2yB
         XD0UGFYZLgdshtGCrEeGPwTEiK4vZO65oTxx87aceXbuBBL0A9nCsyi5Xp+C910IFBKz
         1U3TIO0qlbOBAjPxidAk2DDWcAXp+ShPIDEcVEpJ1IZ5CQ9lOKPN0XGN0eW7wISq06VP
         xLQVRjsIucEc4ssuHuhHYN0KA1nvkI2ZkAlM9OABZL+IPyaBRd7lud4/M0EEHciNiOcs
         r/XzViJBecRwuhJ8qzvX6hjR5tJRuhBa8jXK6c0EkdMQ9cn6qCj/A7CS53fDwIPSD8BP
         3kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N/miCCqVVG2B1CJePoc1BgN70Ur42Xdb/B9doklgNbU=;
        fh=d1OiLHDdPg0fo3w5ZN4iTzpH9FgWNOi2p7e6HPfuyEk=;
        b=kMQ35iYFzDr916PYOKg8VlFMWuPw+SSwqkoYlUjPL2tFa4C2Ype4x0XeAxLAffEPc7
         ToXMrs8dAZYV7SgTLIEElMj3NMD2ZuJmX0Pjt4ZrlT0QbNY9N/+2RtJfaoNfSDSDuhw+
         akugVVLic9G4K/DazeVGn7QA8k0VWK0ZThw/UqGdYj9d+9Aw89+JTSVXJlRdeIBN9VZj
         J86pPd7ZyZvKmH3t6DUiVG359ymYenV17b27HUt5CXZPnSPTKg67TlgNfYHITIwGiSIM
         dLtpCzKj2kDspbBk4pc1ZsqoMmIpujYIfD7ZfFT9umrQq0ITz7+44g7pugIFzhF2Va9N
         ylDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773145900; x=1773750700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/miCCqVVG2B1CJePoc1BgN70Ur42Xdb/B9doklgNbU=;
        b=O6Xu2InYNOBMdaTmllwQf/GfALeMVpA95JYxjkh0dalwzkY4bKc7z0v2EBdqmalkgU
         xmHLpo44IQI8X49Q2mVoxlIg2oZLoOSWmZvNt4NN90UEAB1c/4kEWcCmJnWnVwmfYxtL
         xv4+0MajcdYcgcFbPC7IAVCxbdwt62GnOmUxpzNm/LhgJJqJUuvA0T4si96CdJsDkNqB
         0ZiWTSZrra8U2xPfiJARuTtfPqCl8eSTuxGkAzxQAki5toi/1ZmN4LVGUS6KjfXbABHg
         n42X8g0sjhTsSjsJZ6sW1bysp6bf/8ST3z9lDyFRTk2pm0rfTVavlg8MMlwx+3JYZYS0
         yMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773145900; x=1773750700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/miCCqVVG2B1CJePoc1BgN70Ur42Xdb/B9doklgNbU=;
        b=ETUJ8SpOrcoyJrHJFxhNWME3LsxZuJVc94SSGX++RQ8z01WZwrbsWAOOGfiAmDd7gM
         1Dgs9QJNjrpuRmMqhV9QfRf41uYS10lIzQM4jpWANFTMXr8NcP0jTPF3BKzcYs8Bc1XP
         VYFZkSaW7omuhcBwG+FmfE0ai8bZqV8i+zJ8Qj9J1INd4+xF7/PJURcDNA45UN1KDoQt
         3n9UJB1nqOESsuTMZdFI60EjOsr0ZC+iX+cBDH8OhkcBFopcmTX0kTv6l4o0Nyjngr1J
         506N4JE+MIn1WANKXg1gvw1ktBJ/g2K0YzRiX+xxos5G1V7ObJ4IaP5BA4I9+f8drTLD
         FMeg==
X-Gm-Message-State: AOJu0YwW7tNGwop7yeIss6oMuCqJZU8tbaWEAox0fw9uaS3ZKQ5ZEGOK
	k7m9zo4ZfNif2l0scgxZv0vf/R2skEZqHYscqrxY8HlW+xAJdMu1rV0GyKoyQ5zHKWrOCMT99Nq
	Vx5G+IyJxjq5tElvyoeRIOkN7maY8LPU=
X-Gm-Gg: ATEYQzwCpU9+v++ZD1ToQTo58RKIy/4wj8Mh5NImSIMRPu4/8aqXo+UZwu9CHw1rrnv
	ZwrtF+i6RH6NEfgOVcZES+ZVzOAZB0eqpi6crdEvsc/oq+1buKnWSdXGO+/3g1pth3fr8YB1+qi
	uTnUmEhiUOYrMihHmm+5ipHwCzDCtUigL6qWQZyx2jwkmXrfQcJ2O+/c1xZKX9iFuJcNAfJeQFp
	KuJxYz41ImHlhzDP0hH4I3hAKIsrpnWVWTgzLRfCl9aFIMXbYwumYjMST5ekm9ws814nfnWEDY0
	CK8zLjnVMpw0g8jANqHfUMLFcgRUcoLtS5E0th6EkoBFOnOuGKCgmzk4YO/iINGmhz9P
X-Received: by 2002:a05:7022:238e:b0:11b:f271:835a with SMTP id
 a92af1059eb24-128dde07d15mr1435208c88.3.1773145898623; Tue, 10 Mar 2026
 05:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773127785.git.belkid98@gmail.com>
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Mar 2026 13:31:27 +0100
X-Gm-Features: AaiRm53Vaa__Kcip5m_PxNjakSY8bgfXpWp_0oq7Yk3X8loAs5kavlzQwpKSO2o
Message-ID: <CAP8UFD1t4Xs=xYW4uzqi7Ybc7Wz0nGMTkucCt5UxVnKTO1KE8w@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] repo_config_values: migrate more globals
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, 
	gitster@pobox.com, usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, 
	me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:07=E2=80=AFPM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:
>
> Base series
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This series builds on top of the merged series:
>   [PATCH v7 0/3] Move repo-specific globals into repo_config_values
>
> available at:
>   https://lore.kernel.org/git/<cover.1771258573.git.belkid98@gmail.com>
>
> It should be applied on top of that series.

The above was interesting when the "Move repo-specific globals into
repo_config_values" series wasn't merged to master. But now that it
has been merged, you can remove it.

Thanks.
