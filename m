Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06517F0
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473607; cv=none; b=eaKuZEXXTORZEt69BaP50+X7gUEdFHb9MGQM14QeukJvY+ISiOhA7IvfbvJbXXj51lisxmXrMOJpLRMxSKDdUTc1UyZfE1sKHG1R5OMQkioWX0pTxS0vJcad61fPiFWIMSSl33gxOXOFkTbb73SRqMzuLFkSyKoMv7u20GzwUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473607; c=relaxed/simple;
	bh=dPhNb/fizi2GdHygdKqVom671wJAWlLIEX+OqdSNkV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUv7hM5U9kihHqScl9v3K2LKoLBCEzn9pS5ozfsi+HXMwv05NinnHuEcUFGSzSwkcf6za5fT/fwLqfOFKiItOp00tWM/cd3lt3IG9nLuKj7K0hA3kAiqAVyGJflb24Pwk7rC3Jo4tBJEc1M2T+tS3WLJUulA/iNnD1bCYo/VPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZqU1PR/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZqU1PR/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-345600106d3so494916f8f.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712473605; x=1713078405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9/5tUCAvBhuKxufKNw+idrUTVmUe0RulD6l+VHjac8=;
        b=kZqU1PR/g7YRUbPsOUtYJJ4q+tuiZ188iYQ3E23euq4rplcga3wWJBHyB7B4us5s0X
         +N+trcD6d7XUprjLaaO2fxbvmYY0sz17xSnDwTNvlCb4E5el/yx1acUt4xngtQKSGI7I
         6+Px1ZdmaCzSR16UER5ZJ1TSXVbdoatL+xqkhy10b6QPnPhtoTGNMA0roPT8p1g+9aYh
         Vb6N+bmGW9qcMiwydywmix3XpliSzVHD0GL+rNKERqUqLTF/Mm19kLJamMfXiGHy6n6z
         wAmPg6D2mtUiVxYxzoTBF8wFE0bP803/SekMN8sNEe0h58Jssq8VZcz8poWL6OVAWrHN
         NbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712473605; x=1713078405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9/5tUCAvBhuKxufKNw+idrUTVmUe0RulD6l+VHjac8=;
        b=f/+V/pNLKzSzuD/n9bZKxIsodM6cJstEvi+gCHKT2yx+kpe+3DMaaUdgcnqRx9Q+rK
         8JrAwnBw9l9Cge4J2x7321WbQ1A1w7YtrTrNzo2mbJYvuFhUDtagTA9MJOfUIBvdCBU7
         KmfGfTo2OLg8pa1pKhD6XMCZXH6vLzIVdqwxluPDZV6Fs1F0jep83WokjCmF45snLV4N
         1luPugKqcXL1ss639I4rzDyV/QwsnA/cf4Y3rhSWMP2zam8z++4ZoD4yds1Pk86gb6+n
         AUFaRy9DU4MnpPJ943ifQcSf7/bd/YE6TIo52gjO1WQ7qfIGxWuuOkTCTRbAvo9nBi+k
         FAvg==
X-Gm-Message-State: AOJu0Yyvnt2YWx7VE1Lcz5NU4o5U7247/lBvdfLLCy3oX8nRriKpYQmR
	WWtoC/+B1VM8t6STExTfIipSsde5VGUx3jtfY5QO6iTDARe9fC1A6w35M/mqZ4NLo5oWl+8guyl
	zv9PiSCZCsnh4UgcvSIOe5IkSDKlZqPInwhCLAhw6
X-Google-Smtp-Source: AGHT+IFp16OwaReswjQXyRlnt9uwQp2YpDleE0H6bGUNm5+WIwXSRjzIZn/qCxRGI8KVXS3S9hugljbM0e6pXl8gJGw=
X-Received: by 2002:a5d:63ca:0:b0:343:7116:815e with SMTP id
 c10-20020a5d63ca000000b003437116815emr4347617wrw.67.1712473604469; Sun, 07
 Apr 2024 00:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <20240407051031.6018-2-leduyquang753@gmail.com> <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
 <CAPig+cSfpWaanknSqMGEza7rPhXwgQ0k3V9svfuBsZ_C2EaCmw@mail.gmail.com>
In-Reply-To: <CAPig+cSfpWaanknSqMGEza7rPhXwgQ0k3V9svfuBsZ_C2EaCmw@mail.gmail.com>
From: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Date: Sun, 7 Apr 2024 14:06:07 +0700
Message-ID: <CACXAH50uHNreqhK9hn9_SPARCCq2gfAOs4krGS-Xa0-5GKSvtg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 12:52=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> I forgot to mention that application of your patch results in some warnin=
gs:
>
>     % git am add-sep-lines.patch
>     Applying: Add separator lines into `git log --graph`.
>     .git/rebase-apply/patch:61: trailing whitespace.
>     .git/rebase-apply/patch:147: trailing whitespace.
>     .git/rebase-apply/patch:151: trailing whitespace.
>     .git/rebase-apply/patch:160: trailing whitespace.
>     warning: 4 lines add whitespace errors.

Indeed I failed to notice the whitespace `vim` added to the empty lines.
Appreciate your notice.
