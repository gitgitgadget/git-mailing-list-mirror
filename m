Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795306626;
	b=c/cHTOGEztmJUNGxKodsvtyPwOkMvEOxV154VQW7LbEElYOKwq5cPNoqDlpm6qx7p6XD
	 rKzFH77U6TIFtIGDoSFb/FGehB4hwx0Zp1w8zFn0/Ba0ovjS11IsiTL89MDNXCwrNyhkb
	 lVcc4W81FqoG8mR6ciZQ6jqEojVFEr4hha7sYs9J4gCFD3filXoT6fh77xtRLCRQE5V7p
	 f6ZabUxaVhzniz4kCiimhBl6x6H5yo0Ylnp0wSbWs7tV8X41qpetyL9MAm0Fdb6B9d4xE
	 rW2GpM0Hx9Kwm32nmkO7d11Xq3AoTyKxiHq4uniat52x0IwqTYpLQ1/xJb1sWEKtadw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=IHysQCTwP/0xC36qVAAbpfHgh9t5w7M8llKL8Qaz4FE=;
	b=kpOEGLvKbJ2KCbrVzIk+sYcrBIirKOKQcv+KZY4o9e/ezqdGDDthPlsFlSRKWr/NYEgo
	 8PLri6kdgUc0/efW9k+vdZyp2c6soK37fv1fQVPMN1DUMCsk+IjFp28N6w5leZFM/Lp32
	 wWxwM0bVmaeWL8xIXwRzfjkFDMMR8iWCPfOiP7W5AdHwMYM7G6SsZjAhucVauRgrmaIbr
	 Naht9WIq1vj0WEBf7/MNDdFpWoDLENjCi8wUoyYhSFi1Ab0GMONoDMUL1YAzhYhmb7Cw3
	 0PY5dd6/2cS0hqUsAH9f3DnZqei7P7H6fHWvgXwuQ7PilOsOIM/wnT8PvpJyZesOLow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShRspHki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F7606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 00:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShRspHki
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-847ac7ccd85so1327849a34.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795306625; cv=none;
        d=google.com; s=arc-20260327;
        b=PFWku1FxXDgXW61CnvYDAHm4tiDlPhtEebmlUm9+Fx26gS1aJPDcedd2iNAj4xp9ys
         Cjl4TN0bBcndo42If0sCTz54yH9pMbSa5fa35KomHYaCFo+PIh9cUPoXN7E/zHOoGgEA
         x9zL8fd2Hycw+IL1EJ8T43VLtub90xXf2vwjla4h70ylg1a15XT26JlE6oo2/56yn8hH
         jyxMkZTJya990PtbOFZxacREuZEeUdEttlYE4D2qH9YCYvDcOahSOFyte9zrxz4Kzsgr
         RMSB0mLfm3yHIoPFe+W9CUIYYsM4zDUo2lg8m6VbfnLwaP9X4DgqvWyrBegbnaAEVcr/
         7A5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IHysQCTwP/0xC36qVAAbpfHgh9t5w7M8llKL8Qaz4FE=;
        fh=h9Y5/k+vfmNDV+e9u5AtGlOHsxkojnNQ/AMMDDaV+NQ=;
        b=sYafZ767Djo+ff/7jEt38Jds9lxjhcdtNY6H3oKTptF/hzViXE5+r0V2u+udIQtEXg
         0YQznUtqhyIAY6stlZRy6qambGUMPn2R5tB70VaTS14bdr4gVZ7EObGKBKexVJ/acKNq
         CSzXOIqoCnN7Y1+WJDOBymZftmEo45M3QkdHHwdEUEQOn1vKeSpQ4VZNRM3bInAeoBxO
         8Xqka7tZ9nq365Igd8k4axOJnL0na2CAcYmSVLibQpztrydIkCxagwV+QO5I8IP+LoHs
         cV4pW8IjzS3J8SsXq5sJV+uAAP1PgWd/naaoLlFe5VR2+kIQuwwJGZOb64XmCSDkbnqg
         UHOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795306625; x=1795911425; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IHysQCTwP/0xC36qVAAbpfHgh9t5w7M8llKL8Qaz4FE=;
        b=ShRspHkir9+qAVdJWUJyMyqPXgSByTga1WmGo6pQiPnkUJOZCtshrt8Acjzff1E/Z4
         aDxd88UgVsfz/8ZFigbGooiWXhVq3htAzgFZiOrbJfX2GbDOsk0abNRhkm/3TTUHZ0iK
         9Uv9ZLvHRe7VAn0E/i4BP/gag0P3DdJuTmGO80rsytdVKh/UooQqhQXWee5/N9qQmlf6
         rj9/xQ5UbEcMGikSVHLBgNHIiByj5gN4+oPefg6Ci0IwViwHc1uZUFk9Uigwc2dLYtqp
         Qe6W+N09A0LJl2v5EpGWerScDHAfWQQ6ohkPZX00258yafFSe+O5mWLosTfv4/EFwwwz
         Ti4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795306625; x=1795911425;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IHysQCTwP/0xC36qVAAbpfHgh9t5w7M8llKL8Qaz4FE=;
        b=L9UFyVSNXt+uji/1VENW51v3tbQ/i2KKk49ynNHxj4c3BEZgQlV/Aa2Z0kXCzgOBW+
         cCSbBZRdzifUVeYI36sHhwSPd+H4raWp8XHf5zr683DqgZkiEmPPom8ihK6AUyPGN7l5
         1PtiRq+Cr4b4IaASXJifSowg+pPUPPjxR0sgA2XtKx5A99mY7M46WbwYF7qa2rsS5Upw
         msczGWWtAQN60mWyUXNFIGvvzGMBjxzt09sS+6FnRt9TYJEBczAZaAm2R95madKdNiwl
         hL2tBBEQ2zzqH36Mf6+hGkt5THMUzPbaOxCfKY7/WCfryAlSIU/YcPWVoE7VGW0tTAcQ
         H85Q==
X-Gm-Message-State: APuU4Z/DbNlpuU9to3I3fhJIr85LitFwvkBljz/J0mmWtYkC4Kyals4j
	7A07V88BVFSGKn+P9QoLOEzsI7K9BxPjB0wn5Aia310jGEyPFFhDKxrjvBmdJXzMDiwV4KBVeyN
	8pjUdX2YaQ3CV2nMSKVCFJNgoH2qTDnjSq5Egbsls/Q==
X-Gm-Gg: AZFdTZdSXo83CVPUVP/CB5d9dz56zYypCVkhZzoxeDHhY1h1FjYEbbPJ+l8VTclyL6l
	+xvUlNR8O7q7llr0gJ+SEex876FsA+CuwAf/l/DFrR1SHcaIQjxb+TJEt8gsrm0pGJpvXYwRCyz
	G1F7nVFavGorliVM4VYx7FpdoOPBW5sdVUtTlbHQIuHiZ4cUNgu172QKbfSO8SinLwKl8oDGAcg
	abHQOFCcWppjb9cIZluQynNox/6U3EsPqm17fE2XlCz+Cu0IXOXizZtyS+B9LREnEUrdLugtMwx
	dzzWi+4nggjT5MMWeYdlG1ZfoYpdlQst+0ISZfPaStrxS9bapIV3fDTLSP6yfP2aXSZNw57NePx
	O4VyW8KQCIwhZDLz+MrTc18Uw+mesuGCHnv+s0BIEwUJIKfVkYzdc8dT9nniS0a1AJB9CXxeKlh
	DCuOTPGCRrNsJA4q5CPSJZvCLBrW3k/Gfp89budKriCpvj8Uw68xeVZA==
X-Received: by 2002:a05:6830:268b:b0:822:27d6:c2ae with SMTP id
 46e09a7af769-863152f7046mr9037259a34.3.1795306625139; Sat, 21 Nov 2026
 16:17:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107121119.2995843-1-andy.koppe@gmail.com> <20261108234235.1594316-1-tangajoris@gmail.com>
In-Reply-To: <20261108234235.1594316-1-tangajoris@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sun, 22 Nov 2026 03:16:29 +0300
X-Gm-Features: Aa3M54qquHV-9DA10QN76XzzwuwQ6g08uk6bE7CZhTyFf1lJgesYFF6ipldPiJc
Message-ID: <CAKrRMNqd05XDF+j_FVtXE0YydUDfM_dsN5XnrCVcCSWn5Y57NQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] read-cache: do not skip the hash of the shared index
To: git@vger.kernel.org
Cc: andy.koppe@gmail.com, gitster@pobox.com, stolee@gmail.com, 
	github@paulisageek.com, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping on this one, Could someone check whether it fixes the
problem on their side?

Thanks,
Tanga
