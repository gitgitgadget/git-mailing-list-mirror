Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD034D934
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149249; cv=pass; b=EUkUbb4WRx6vnRpIKE2hOKxbwnZybjJdHiTPWaZ+dQ50eYdgyEv+KJeCTPsXSoUGBGZ5YHXlFIeK2ixOZoTbNsGy9djnut2Tohs1pCdvZHPtLj8NXqhQzm6ET72mxh24tpW1ZwDRrYRYJO+x/s9ehdqQOfw1/PlV0Hzb/rLh6sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149249; c=relaxed/simple;
	bh=WeMZMfJ0h0hHDc/7qAVCEeLDfNbioneqQIxzjorgmMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLj9LDgkWYbivrTDHRRmMtEmM/jG0D45gQBPEX+x87taPk48JYKY5CFMBt1BrSll9UcVJAShOKvpHNF/POd9/MiqZpVDb8wOmNo2aMVGU7ySZ4G+cZhITSRiMiYJ73GHJD7NjhbMUxo0dx0BtdtQvQsf8diDtWpFvw/7aZSxKdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew6mV7JH; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew6mV7JH"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-649bb5a0ba1so3325171d50.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 12:07:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770149247; cv=none;
        d=google.com; s=arc-20240605;
        b=ZW0RkLQznOdsExizTYE1rfZByfGejSq7A1SeAiM8/5qAmdJwehozGRKfLbgy5DKLMj
         V7JhWYtM1Kqd7yZB4m3hRX6VNq9LiLqTnBzaZyv4k4FLJTOSLddgoeCSy7Jwq56q24Ct
         JiuEnfAy9z8LsciupUkEuTCuexjxiDSGjQoEmZZu8WHEA5pZDn8u//E+TvaKTRqK1zKn
         VPT8L0KYumaMwY0bJLaGMnxrSmreu/WAnYPR0zhoICtaAofsCuwyvv2Ds/1ieTS79yW3
         8dtfX9XJHT6l+axIbN8X1YVGLgvAgpdCg9MmU9ObrgUYrXclmy7uZmlq+b6rcmMC1Xe2
         wZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WeMZMfJ0h0hHDc/7qAVCEeLDfNbioneqQIxzjorgmMg=;
        fh=pbmclLzekcSTUamlGqn11MMiEh3skPEnNHW8Ns9xW1M=;
        b=kNkhN/0xMarYFeExqpQp2PQw0xd4dBdS80I2QHJjchK76QaulyTlWXzJo3EvMGzBGO
         UoUj0J5jmnYYi2i/Do7P/1XD5Gve0IXRqW3PvznxWIF32M+vxusKjTyiSSxzgnLVYuqV
         czfE369mEg17Sx8VIIdAlhPnk6qPqQKlBht8KrIxJlBg8jG4OtRL+9TGuZlthlMabtqp
         HL4YkT2KjpBTLisWz2CrNz1CjaV1FtNm4dly3iS1BiJ1l7sy3zP51K8CyN24T6Mo+Obl
         IOwpPvDH5kZPl8O0YlGjIvwQVdWwEbi1ZiMm78V5dIcWQDCZYuOf3lREXQSmzhkmeGRW
         qsUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770149247; x=1770754047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeMZMfJ0h0hHDc/7qAVCEeLDfNbioneqQIxzjorgmMg=;
        b=Ew6mV7JHUIM42tCufnYpEFgFqJrN7H1tvZdgyAtsRrDM3tS6hEo2RORrWuz06/azzK
         LcOIO3ZXrPJyR5+ODJBj/1hwVNKfut4vr8E79ZZ7xYElLwZxyA7NLbOidXD577Hfly45
         o2hcsvVN4XHeHjIcXlALCHYfgjn/57NagWCHzkTwgOE7dBw9U1xRG73ZWbgV58neLUA7
         Dpat5hIGmP1ZZ0IY9s5efxGPq5thSjULE0teK73pcgQ/vGD2MpfQKsqnzmeMvtTOzf3d
         2MACBYvn+DIk6CqtsaAxEmBCmeF7mcYOdVWDq8vXYcQKk2/yEOpO4Qxz9AoMFOrHlpSt
         7Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149247; x=1770754047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WeMZMfJ0h0hHDc/7qAVCEeLDfNbioneqQIxzjorgmMg=;
        b=SkB44LtLe5rNdTeo9/Y+J3zyb7weRc62XqKKCskLm0wsm2PAn3B0paZtZT4bZ8JSvO
         zb+JYsvTYf1k+WMP5vTEt3jcVSrbYRGjG06+rMiS8OoFMdCIzXd8tJVRzsbkQLwPBTu/
         BUAuvWxldIyyqfJfQSsc5PccEIXGKX6btUpHXHdq9FFEhUwNsoYlg68NBT9bdy7J8Eq0
         2tQdhFYdmggZcFa9bZF+7s3q8+YrjwZbYfChqGUsuUGnPlPt/zox91bH7X7NeXOfdZ2F
         bpXtHCThgH2mupLFwumAAAM5K6Q1HoR99IENtmdRaX2aReGMq3SRCyIOL0MXdeEiC7sL
         ENnA==
X-Gm-Message-State: AOJu0YwRjftkCs8OgTGjyMekzS9NaVsYynLCj1D/U648KLhaTKkQfsch
	Tyv0U7NIR7MiaHh/4WF0tVwRq0x+L8i1U+q9YWaHsF3rlJ1WULqcsJ22yLAAC7wc+mI7AQS3TO0
	sWVv2Dwpvv6WieXWs34mhlmzIFSgaUQw=
X-Gm-Gg: AZuq6aJhC2Zd9EUH07nM1hcDZuJTg2nWAuXPwdim6gM4uWKjXpgizH52fZ/NprTwEun
	n0iSrrwdwNfevekDeC2thkaav42nA/TZX0NUirwK8TMqU8UTOS22zSOyCIX8OP5FFwFZV49ypDL
	+jBEbmu14P0hGhUKZnG+ed1124vY0nqR8W5OE/GN9yJecox3eREemle5Nq6Vr7ZujcJS6vqmALU
	Wn683P90V1undaMSxc0Dwu6f+uBx8SXb28SBHGCEuqp5fJ/C2vWXecLibooa3vknuRAxQM=
X-Received: by 2002:a05:690e:1247:b0:649:c512:1422 with SMTP id
 956f58d0204a3-649db3583famr713994d50.42.1770149246914; Tue, 03 Feb 2026
 12:07:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
 <20260203180359.602905-2-pushkarkumarsingh1970@gmail.com> <CABPp-BG6wM4p0wAizEppT7QdtY710xBJ8NwgfzrDpP3Oyg=a0w@mail.gmail.com>
In-Reply-To: <CABPp-BG6wM4p0wAizEppT7QdtY710xBJ8NwgfzrDpP3Oyg=a0w@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Wed, 4 Feb 2026 01:37:15 +0530
X-Gm-Features: AZwV_QhhNEQ2o9t3rZSQpagdq_Mexha0rUszWDIprrTyzvNa_EkZdXUvLpdo0yY
Message-ID: <CALE2CrSwN7AB05Qd7G7LOGjSNu3=BbLLVBfoNf5a95SMRBm5WQ@mail.gmail.com>
Subject: Re: [PATCH v3] stash: honor --no-overwrite-ignore with --all
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthiknayak@gmail.com, kh@pks.im, 
	peff@peff.net, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

Thank you for taking the time to explain this so clearly.

You are absolutely right. I misunderstood what you meant by =E2=80=9Cbasis=
=E2=80=9D
and also approached this patch from the implementation side instead of
starting from a concrete user problem.

I also realize now that I incorrectly stacked this on top of my local
changes instead of rebasing and editing the previous version, which
made the patch impossible to apply upstream. Sorry about that.

Given your feedback, I agree that I need to step back and rethink this
from a user perspective (what real workflow is broken today, how -a
should behave, and whether any new flags even make sense here), rather
than trying to force consistency at a low level.

I will drop this series for now, spend time understanding stash
behavior and the broader context you pointed out, and only resend if I
can clearly articulate a user-driven problem with a clean patch based
directly on upstream.

Thanks again for your patience and guidance.

Pushkar
