Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74933D512
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204557; cv=none; b=MG8tOqbcE7dmDAiLodwmDueOFqOwzuObpERjZehortIglBgYiIbkHVgQq3gucrdQsBzeDgcuTwCrgLNyhnM09FtjI548v1gb2aTdLPe2afZFBRE/LCT0RFLjicCeid8g0KSefBmzuUYMdOgS1zdZZzT5YCA6oodWPHwjlNLesqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204557; c=relaxed/simple;
	bh=xOK492Ye1fBD9sl/zLpN8CGqxNBDzb6+G0KT/O83VQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lvMKq+rwYHEaWqPefXbsV/7olhSOWsxVCccbLKtGH/qfhTOqMceUSQPs3QVF1xa9G5aZk4oS51F7cBM0K+RoV3eOjQatWhE6MSz3jJY3dOKrpRS+dmqYG5/NVG10mxV10RALkSdj+vA1uwUpHWYLvk8bbzyuIJaUtrh+HBHUjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVPDq97c; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVPDq97c"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3333550a12.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204555; x=1788809355; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ee4FdhYoDgaivtxjX7BdRKC0+iY1NIqGQrl0gOLHW04=;
        b=UVPDq97cc3DrvFs+fIEzqNZU3sUlAis9vVghXJvMsgnVbownUQiGR7BgaCdPWEowGq
         L5DsVG8jR0taEff/i4+dMdeuFr93Pknb6v3/2Sioq+Fek/stGI6ePWf8HRQFTMR3tKNP
         gcZVAua/293NBTIJ/7mJHdSWUsRZ3SFS9AMNBgoviXt8PalRQSv7xLNzRnbhUPEXr2ZI
         FODM7f1h1+wTnH6jAHwbeF9VOdo/XXguoAuWBIaZzNUkoarClfcwzVdAcYc+zkREVrlW
         Ra4mYdQ67UCN0QonrjTr+wvXqPUuxHIY2b9f7ZAIrA7/g32/kimwCwRD9YurjNfA6vOU
         VgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204555; x=1788809355;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee4FdhYoDgaivtxjX7BdRKC0+iY1NIqGQrl0gOLHW04=;
        b=mnBgZg14YkSRM8es9x4uMAriBi4m7YLNnKVCRTenO1VTgq53ISrwJXzT0yFm/1qwS9
         4Fv2zkLZuJUyxQ2zbbaNs+TSRhR5gYf5AXhMREiS1XTrX6svQIjLUwxgS1dm70k++GSw
         gdxc+7yiCz46S4YEjG4ZEWLssAZpOJon1y93/4BdxAVVmYB9+a8TqVeaViz9TBoZrdxO
         aykMwOai4qUzNLoH/GSCRJN9PtEwKehxn7Js7YnWhCVnZK1rfafHO/zOxBjbjsR5GcoK
         pZGumy/RL7bDxjFToqyii7jVD6dtKgTYiP8GMOncR1Mg682/6RSdjrw6H4cUupbrrd2G
         A+Cg==
X-Gm-Message-State: AFuF++kMwkvsLyarYjEy7DnYu4Pd3FfgmbiLkGmLYmgccCjgxdxaaoTH
	NcnKr+1sd4DJMIs6BWYon4It6gARTgeR7bgDPCvQkjHDIicTZN3AhBtz
X-Gm-Gg: AR+sD13JZ8vlCXT5ZpDuOE1Od86lgorbDDHCBKZWQfSzTwI8OtKlHT9oY9E7hnH4dX2
	NYShjabbqobnmjz5/OER/zK8TJKHzIYQH0vckxiFWheVfHqkqbT0nOitfXBAI/ZwxMTYTIz48Jv
	eauvo7nF3rgeLAtCXE/2/F88ZrloCtwECDKdMhbMHY3M29WTzfB8SJjtD1LoB6UW2JBGydxQwZE
	5u8uYbOaCPuT/2/WbLHhqeeFG5gkNvabu9x9WshKIAFE34ApEORR+0h9ZILOwLAFIk7ZIveKvCe
	Z7Tt30Xxv+ChZuvwGdfaas20mTbWns8s+odoKpe6ILPEZUBv/tWIhapgtYlMcC+iM0yJkRWzv/B
	6AKNb1U4fj7NEqYkGAZ0Ts2gnfnZk2KwZCTDcR82EvlX1AyEKqvnLsPrLBTQVxxLL/5MoWKsrDu
	Dm+RnVEc+KzePO3p7SyFyYdAz27akmVMbdttVHmjj61MuajaZ2QDDfkrSSZeQ=
X-Received: by 2002:a05:6a20:748b:b0:3c3:9070:96b3 with SMTP id adf61e73a8af0-3d265a3ec4bmr34162914637.3.1788204555298;
        Mon, 31 Aug 2026 12:29:15 -0700 (PDT)
Received: from localhost ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d4b336sm31178362c88.8.2026.08.31.12.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 12:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 00:59:10 +0530
Message-Id: <DL3DLXQ84JNN.1S1CYS9JT8XOJ@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260901-typo-fix-v2-1-6aeafbae6389@gmail.com>
 <xmqq7bl6w1vh.fsf@gitster.g>
In-Reply-To: <xmqq7bl6w1vh.fsf@gitster.g>

On Tue Sep 1, 2026 at 12:31 AM IST, Junio C Hamano wrote:
> Hardik Kumar <hardikxk@gmail.com> writes:
>
>> The patch fixes two typos in two places.
>> versoncmp.c:            "fractionnal" -> "fractional"
>
> Verson???

Thats ironic. Fixed in follow up.

Thanks.

Hardik
