Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3847DD74
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070926; cv=pass; b=BocutP87b7sBvD0Y4MoRiWW3NnGUuAdh5oqtV0sLegyHr9K6tXEgVA9SgM9Rozqp+XINvcN92kf/14INrwPDPEzb67TGkr+9mncEUBsM7r0BneDCVHp2ZLz9K2UrnO2cTSMPjKEK4dhHKrTSLwDTJljAO2YqXIdbPnbLGse7QjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070926; c=relaxed/simple;
	bh=yAcnzVm0I/VhlP+DEueaZm+SjIO1kCBSAaImHUh/UNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJTwqQiCDGAqAd1my/bg6bhfG93wyKGI/GSTpMtcTuuCMsfl2b6tbZ93k26L0zkCc0NqgoD9ztHjQOJfijoua9H9ilcTaH3K7NBp4PBeLaeSJt4kvSh0+k0jCjpTIk5X6a9G41SH/YezpU68Fwh1RZy/gfp/HqgVp9l8xm5c0S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qETfqUb/; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qETfqUb/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso449915ad.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787070924; cv=none;
        d=google.com; s=arc-20260327;
        b=rg/q3P7bXp1gtmRNkQCz46D5NvXt0URQogdDp0Ex+DPNrZGMGjmK1GDWABIFOXPwsr
         +mtSMCttlxrdesICbDkyXbVqh6PjaQx42gcDFWObkeiopUFe7tsKRm9qRhV3w0RWVG2k
         HnIz9jAwU3iRhXpGRfeJl+D1VzPYz80o1XA6eGPpdOHe6Q+hOSmFCGqfW2Wj4KYTAzf2
         A5Ozf1oV/6OQomRAk0ZeWDO1aI4Dti5uuOwq62PfoN2PcEPnREYm06nOpQr2T3BcoqDi
         eXY1iTJwmyUZJYaAtKetgpqL5ZOlU6KstEXuj5r+qztmhvr7cxQSqtHbaTO0aZ8/iGaO
         VASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yAcnzVm0I/VhlP+DEueaZm+SjIO1kCBSAaImHUh/UNc=;
        fh=9YGDSDUqJndd9otP3OBEHwa3g4KRiS3VXDAGgzLO0Jk=;
        b=GSZTt724x5bOnQ2CQMkoXGTnBqFRLBd7Y7NxTgpg6BGLuXOa8x5UbMRnILUnUVDpCu
         nsVMUXqlvKOj2EOphc+/0cprhrLzo0av+oqEhmUqAwGSF3d75reFvV/PA4dZFNkQW5Wu
         XBPOVaNjE6Xj8SGFI6TLgEcgo5Nu8fBKAkaCJQNHUW0fXHBreiI7xHU7gyzGktV1Tt9v
         Rx9XnNbanMVbw4gxOCoWOjhqDr2onP18kPP4ogx/Elubw5K4QZMlvg3ZjFVQDjagmmt1
         SO5GY8256/tttK8R3I4AlL7FFx93tMwVbZOA602/2zPmA9o7gSmEsMXluu1PEegJoRmL
         HkbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787070924; x=1787675724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yAcnzVm0I/VhlP+DEueaZm+SjIO1kCBSAaImHUh/UNc=;
        b=qETfqUb/tou0wye6Ng/y2Wn2/caCHKtQuSy+PSDbKVmx0miWlas7tLnYqDk6/n93uS
         yUPWFKTAbMb6ch7DYtygvPyuCuVpDs2kGnZW1sAXY9M0pwW+I4Q2e5+sJlQQOYpXQN+F
         bPElSzu/pWnjlGeXensyIQCaYcfWJIDQ41wTaqEExT4pYk0jLgnh7ah3bBOci/CkZVw8
         dzNxKCcN4sRmWXtqqjy7GizgxQGFnnxs4au6Wf4IlJHXGpIZD5ip+z/OD44HBiExFQtN
         TNXcLRQ7CJh4RyqpelE74xMAC3RWTsklmSE1FDkl+gFxKKo0shzknCGxXGsYvqmEHmVz
         7aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070924; x=1787675724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yAcnzVm0I/VhlP+DEueaZm+SjIO1kCBSAaImHUh/UNc=;
        b=MjT1ekUv6aa92McdvJy+apd6SPKABKWaUJgUoM7gSTOOvVad3+RrFLLf75icbyEo1l
         8uEVeHlG+/xLUTiSn8xGcKA7+JzflbxhrjnJg5e3QYyeZu8RjlUcm5MVJVfPyxb8puUv
         FsVUJ5y9fdZE3KPO8FiG+moFRiQqUnnh87flDOBCtgxuxxtxOulRi5YZe38ErVJz1TFT
         AgWy514W+acwHAPRG3x2btijmWYsh/svQFzTfXgA8R3sik/7Oewqz/G0MUfsfF4uGkVP
         mEOzA6wZruEdoQ7eZ5OS+M2FWt9IoEg9Q556jdjRziUh5XsMCwTsBkkn7W8mggvlDYyR
         8S2A==
X-Forwarded-Encrypted: i=1; AHgh+RoccweJw4CyFgjjRsABfDvwkASmiQm6yEjDfHbiAv8YObJla6ZDwCmqgZDkgwoV8TUkICE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wmK9mKVjbZRhpPcL1T3v/N6HxlUzNbkCk3A8Ca6cBEtoT3/Z
	0nrNRR9P3ObZVLZEPjbKUHSf1Bu5X3Qhs1ua/AagNczF3d3FpO9+qAe4Upds/igWBmGJBqKZQpL
	Pj8pmsInVx25uq0sn5VB68t7Uis24aeo=
X-Gm-Gg: AR+sD12fCeejQxFPdDmY6OPAaRCcf+np5ndh2x5n30dVs8qmqItS6fWJiTLZWzMIxEU
	/ylDlRnKKviBAg773l+JJmCyvKWSifYCrArqHMm3G5Jlc1vRtKSV8hoeuI9YlokjtK260Ybgdo4
	fZbMT04je76kPBTmDPQOea7UANiuhxkNTdzSutADChAV67UHFp1O9bbAzta65Y3F/prxb6VmRSE
	4Ch7nrkMMrCIJ9d+QsUzH1qVDN82FCsqyV4Iw7qSG8flvPIHcAWIUr1iaviU587GZ9twa1f2YiN
	/uvM/LpEOOPm6rhMlTvd4jOAId/PCFqO0rFISTy8s/mllUXwx8lFY2iXvMCU+zOi49XSSM5MyFZ
	IG+uw4FhbBUobzFYvJp0ItLBwHnzNcpk/RZm2WDZtPb0u9EX2Wbe1W94z6r1kOqnmvDdxXt65Pm
	DNf7b77dkhXGWD6pda+4k=
X-Received: by 2002:a17:903:1b45:b0:2c9:deec:f564 with SMTP id
 d9443c01a7336-2d5c5381100mr142773175ad.13.1787070924127; Tue, 18 Aug 2026
 09:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
 <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
 <CALnO6CB1vJ7RtBzTUSJSfYtfH+W2MZCFEkqNWeBXbWJ2r3Pdyg@mail.gmail.com>
 <a6a9fe7c-e46d-462f-b3b0-7ae6c2d52fe4@app.fastmail.com> <CALnO6CCWADaQycF7XcCFLDgCVtkTAsndKykAWzNhPqVAKWYGzA@mail.gmail.com>
 <43bc34ae-451d-4270-84a6-bbbf8de80115@app.fastmail.com>
In-Reply-To: <43bc34ae-451d-4270-84a6-bbbf8de80115@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 18 Aug 2026 12:35:12 -0400
X-Gm-Features: AcwNN1VZqh-S__7cbi_egMwiEqAec6iiQPm-g1w5F2iS-RhygQvmqEamgz0qD3s
Message-ID: <CALnO6CCFRAOouPALFdGhN1HjRuPhDj_inRBaWhebwCiD68R9AQ@mail.gmail.com>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
To: Lutz Lengemann <lutz@lengemann.net>
Cc: Lutz Lengemann <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 8:41=E2=80=AFAM Lutz Lengemann <lutz@lengemann.net>=
 wrote:
>
> Hi
>
> On Tue, Aug 18, 2026, at 14:13, D. Ben Knoble wrote:
> > No worries! Hope you enjoyed. (I didn't see v2 come in anywhere, but
> > I'll keep my eye out.)
>
> I pushed the new change to my github repo, and then the PullRequest here =
was
> updated: https://github.com/gitgitgadget/git/pull/2155/changes

Ah, if you intended to send that to the mailing list, you'd need to
/submit again, I think.

> Would really love to see the change in git, makes me a bit proud that I
> added something to the one application almost all developers use.

Definitely understand that feeling ;)

--=20
D. Ben Knoble
