Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2ED3451A3
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207875; cv=none; b=ujfO6QDuC5Vly8G1x8eK+8ij4GUXtkEAVuFMm07drPcJtyC9QtRBeYxVo9PUgDAtWEzRyhrmsV2rmLON8daVURc3IhI8pW79Mj0obie/3SYyFr+Fwe+QUZ1L/GQ1n97DRWTYTqTPXaauzkR5nkSsmDH7EDZ6kz/jAsDjBlAB6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207875; c=relaxed/simple;
	bh=H5XsIMZpYtDxRH2BcjHusw5SDrCEZg3zOeGCa6Pzq/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBRAz1irqHnI6KbSSsjdL+4QtYC06ZytH+76Hm0PK9qemI8+XGEjjuVHc/Qt/imaBDncU53X5qiQ2n7H7btm0Zb0UUkq365BJ57hRmy84t00dI2iWeeujJcX3pTfVCztDXvlwgD32J18ouPX0yxaFeLqZhj38iBL+WO8ZH9nSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1tmjtAs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1tmjtAs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d67f1877so47903395ad.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768207873; x=1768812673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvdp5/3iAZ4xoghy5go7ukiB2joV3nqXTxbcKbeweZk=;
        b=h1tmjtAsJgzTF34NXj0PzpFmEfhkG3CtovqSU8Fm69fX+LVaqiPVVqrYXGSDeh8dsH
         yYrpwRs71x1VYrm+IzKT7qnvmSyWDclEUD5FIbQ7eP2V4I5QJaTsj+bBUxpVOGjwuId/
         4bfMbpCLTZcg2ckXNeEfPwAsjWrxClcCSSffJcqtgrEmKLe3m+lGeYzteVzt6AYQYsRg
         FvHSuIDqbEZho3HlujJgpupNirUMYmZxjWGC6wagPSkI+95ejjgSXocTRvwPdH3kG42a
         FE+BToZlHLQ7XaVPWXnFAzX7TN9Q1jx+jZSiScI1whMtFvWjQt3ENPypRfVrww3zWmW6
         ctjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207873; x=1768812673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yvdp5/3iAZ4xoghy5go7ukiB2joV3nqXTxbcKbeweZk=;
        b=A44PF4MN2zPuEfDWHmLIpsgrIUzF+RRaQS364jwKn+i2m0RguQHd1uUgwjlPK0jzNT
         4666i1YIrDS0cg7mqQoHMMqtoUaC3PjCF6pfpFIRt5DlY00bJ4/GNWOX44MeymuQ2Ym+
         ya5+2cPcr9OK86IiTpDpsSkUyOmacAMSeeG+mPcFgAx3I5Ea83pB7ZU5C2jyGP5fKLlp
         nY+sKFXp8cmaD2lY0QGaTZ8fTsHvbhMjOHKveEWh4MUHOIZqESd5O8L4oGfZvwh80g31
         cgIHQX3QPrTDEh/1bkpo+m8zAWYeQTs13eKraDen48PIt8uWZxVfvIh73XOoCPYVCZ4d
         BlTQ==
X-Gm-Message-State: AOJu0YyC08l6BdFnXbbbQo1iRJ8wroMR9DFf1PWmeMzKaZpwd7GpO/FC
	/j7nJJ+sDTc2/O4OjkMSZ7jO56YeJFjKddEOehuk85vRtBzOEjLppAdAXl17/w==
X-Gm-Gg: AY/fxX616tki8Woqm/ecqE6fdIxOPkaEldWVfCkx0kj8ZcYa8pTPIkR73L9ydS/dLZY
	Bv/pbI7t+c1Jfy8A93cQvg5JhLsdWSJVYGDQU5IYU2/NzKm5alr5ZZxxfHrz/yNwacCNLqc29yv
	4s9FS7tMB8KqJ/2aAp1L7ud0SyV5HcN/opi3bdx47VxcxyLGyOHOrfNZm8uy+ocjJ1lFkv1DqJK
	+2jDDjNhgRiWErk9LJ46b/T1KmXD3CdGzO/IWFVPEr0Na+2hk7C6RZtCR1B34XGBwhOo/i5CiLm
	y+eD0zOoO/M5vuMticJInjnWUCuFE3QV3B6AgUtFJo9oxASmUdWk4793sTG+/Xf2uCmhCT+X28k
	9ilo4m1hPabHlXx558O4cjHq0oPYUvpnyTUT1dyZCUej+Wb+hksjsj3v3y7fr6ygq4IZz9/g6pw
	se4F4/XhBBW08HNml9uyMdFyskJuTicbk0RmOmkdgmgWTe3g==
X-Google-Smtp-Source: AGHT+IEHtWqLLN/SuUs/fqbPTqxA/NS0NGmbRvhVAW2k3mYGYG+j2IqKwjbZOtLIZiBYoEaTUeLXtg==
X-Received: by 2002:a17:903:189:b0:2a1:388d:c084 with SMTP id d9443c01a7336-2a3ee4ca67fmr160377855ad.42.1768207872720;
        Mon, 12 Jan 2026 00:51:12 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2906sm167438545ad.87.2026.01.12.00.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:51:12 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit code in tests
Date: Mon, 12 Jan 2026 13:51:54 +0530
Message-ID: <20260112085024.299018-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqq8qe3pxvm.fsf@gitster.g>
References: <xmqq8qe3pxvm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> > +	test_oid algo >oid_algo &&
> > +	git rev-parse other >oid_other &&
> > +	git rev-parse main >oid_main &&
>
> It is unusual to take these to temporary files.  If you want to
> reuse the value more than once, it is more common to take them in
> variables.

Actually I referenced a previous patch [1] where temporary files were
used for similar values, so I followed the same pattern here,
but I agree that variables would make more sense.

> > 	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> >  	0012command=fetch
> > -	$(echo "object-format=$(test_oid algo)" | packetize)
> > +	$(echo "object-format=$(<oid_algo)" | packetize)
>
> The construct $(<file) is bashism, that does not work if your shell
> is not bash, isn't it?  If you used a variable, e.g.,
>
> 	$(echo "object-format=$oid_algo" | packetize)
>
> that would make the result more portable.

Right, agreed.

> In any case, since the output of "echo" is sent to "| packetize",
> the exit code of $(test_oid algo) would not affect the bigger
> picture, and so would a failure from $(<oid_algo).  I am not sure if
> this conversion has any value wrt to "suppression of exit code".  If
> $(<oid_algo) construct fails to read the oid_algo file, the upstream
> of "| packetize" may exit with non-zero code, but the downstream of
> the pipe would hide it.
>
> THe same comment applies to other two uses of $(<file) construct.

Yes, that makes sense now, sorry I hadn’t considered it this way.
I now get that since the output is piped into packetize,
failure in the command would still be hidden.

Now to fix this can we explicitly check the git commands beforehand,
like for e.g.,

	oid_other=$(git rev-parse other) || exit 1

I believe that would prevent the suppression.

Best,
Shreyansh

[1] - https://github.com/git/git/commit/c6f44e1da5e88e34
