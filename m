Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA039022E
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612743; cv=none; b=Nppnkhp7/vPtFMF/e95xSUfXgBMaaSoKM5dHW+l/jestGELrUqVWrjZd+B8ATbi5tpk378nKJf8Q2son2lheHTANTibCPu4u9KJQN+dG7EfgJ8YZMV5OLhjbRq43cj4J5i6VQYxUOsSO1zt8+i9gtxx60bcoVDIaLGNWkeEw35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612743; c=relaxed/simple;
	bh=RMRIW0f7tsw9CR3dow4YXMPs/oSbpZ9w0FblLs+KWic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5tfTnMvUGhpGLxBJvVLjTXOAlW4mPmM+jN7J3clivpf6U/hoQgM9YzdAeediVRc65PuZJPFGgUwGOXmANIrCfNkVIDpVky+ELlCN8DBBNMqcak8rJSC3VBYPgUysetWBbmqD1qVvxj6OTjKvzR69r/v9K1QMNG+ky85dPxQEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTr/sa9c; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTr/sa9c"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52d7a3defe8so27793221cf.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612741; x=1788217541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuNGXekE0mtyUHyOi2aKqxvktPGXvpKgPzPf00iCrd0=;
        b=YTr/sa9cxobD9wBuSvQ+hrjNdnxwKCuwJp5jftMdg0AcBsWbsA7tSw2WTyP67lMjpR
         vjfOXqAqpHfnjTIvPVOqt/ujjyVG3fD4Wur4cQ0Y0j55nfjWNj0RQjt/oX4rJea5wa2k
         WDyhLxev/EiPrE453Fzq0zV1q8W2xZocDdtqU7kCll8xIFxQyGWsMvApYogQoNKaTpbk
         Es89TqmQJy6yNJGv0fccfufixwU0UjTBYpB5qd21DWmb9l9ARPqV7MKYs/CxWUA5hlMO
         gWfxS4/NiM5aJBO1fa0pKKlxvkWw+/yIZp0+S/dz8b7ot1tvu12npOunTD1Xub/pPNhv
         P8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612741; x=1788217541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuNGXekE0mtyUHyOi2aKqxvktPGXvpKgPzPf00iCrd0=;
        b=kevKe3L7SvzsYc6f2RFhlUrwVvAyUJtcaQEsFv5JSF/2Tp3QSUkCnZ6VqHxakyhH0i
         NdIrbpsT1aDfrQOtwGXdiyl8YkpR4gWnv0daIWePCEhSYdCtKgEYvXuI03TxUX0w7ME7
         Cjb2M6rIPCudMOi9RRXtFCweASHtPbOUF/ZuTAPDVIilPqiGDfrf6bWHOHkftpytVFuD
         BpTedRnpo/JE22MGvMvQrZwt/+Sk20iCr5vN37dudbpvPU7ip44ZugmjJn+p6s7N3boy
         amPrWaV3vAqoIYvwSifvXFqmA5AFOYVqaJkm0BR6BNPG7xk4TBDHX7w7uhqd/yBSBEhL
         YxkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoK2tAoiyJvek6zdzlJD57FtY8UAWc2O26EG3VyQCVEPwbW8r2KA8MoNvBTagwM1O1SDkY=@vger.kernel.org
X-Gm-Message-State: AFuF++l7wqOQR6evygr8sORB+mioDKOhCHinYtPBv7uC32HYDVxr7H/3
	KYGv3k8Dp/3xAnFE7VupP65GdKLYv6oNOi/eTpusz2n/vrYqK9fKCepr
X-Gm-Gg: AR+sD10bxWntHPCiPzFeLNJk01dMze03UBDRRU+GrinchqR34AvBBTL6nIAfMukLDlL
	qUvxGsa0UBvgAkGOWGCXwGqNKAym3sgnttNbRQc9nFnE59s/1iVGPJ24I/G9aMEIcd2io7If+4K
	tTXZE3HOn/XQN0SZVmPmq0LYXEQDLm6PIe36Nxmnq8klyDVhVt05ElXNqJ1AZkWnBGM32218DmR
	h4w8S15Jh3CxVgqCDSCHjlz7NQ9H6iuCt08RqVuwVTQBAnfiUKV0Py992a/ll3XWTnVAuxYrFx7
	H2ryvG6la5AGMbD9N6wjFPpOmV74Ouw+xDuAUG6WEnUOayRtSzxUELDdmuR5el/1+9okJFWpy13
	NCkxEglJJj+miBkJyTSMtSogtz6jBde6085NM10dSKi/018sW9+2PrqL5sV7BixRWqyK5gv6Fmg
	DCV1PSBhg4TjODaGPPMZ77pO/0uSDXPoC7G9O8p20cV1mTd08ULMRD7WJf+oFQm27wUmSnayXpS
	W7NEdR0VPrIeqo3KUfN8KiI7tgCKjq5VWlxpSTmlqToAKhDucmO0Zn605YfWiVWHq6vDRwWDclr
	kcjy/m3FCn0P/bIFAPU=
X-Received: by 2002:a05:622a:4108:b0:528:32b1:c202 with SMTP id d75a77b69052e-52e2f04ee3fmr33731021cf.7.1787612740574;
        Mon, 24 Aug 2026 16:05:40 -0700 (PDT)
Received: from niko.lan (pool-74-109-218-190.pitbpa.fios.verizon.net. [74.109.218.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09aecba0sm56497991cf.28.2026.08.24.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 16:05:38 -0700 (PDT)
From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] t1401: check symbolic-ref exit codes and --quiet silence
Date: Mon, 24 Aug 2026 18:05:27 -0500
Message-ID: <20260824230527.24163-1-nikolauspschuetz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqbjarqswj.fsf@gitster.g>
References: <pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com> <aoyBxOCdAq3qeAvW@pks.im> <xmqqbjarqswj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would favor continuing to not test for the exact error code, and
would rather not disturb anything scripts may already rely on.

In either case the git-symbolic-ref.adoc NOTES are out of sync with the
actual behavior:

  'git symbolic-ref' will exit with status 0 [...], with status 1 if the
  requested name is not a symbolic ref, or 128 if another error occurs.

To describe the actual behavior:

  'git symbolic-ref' will exit with status 0 if the contents of the
  symbolic ref were printed correctly, with status 1 if the requested
  name is not a symbolic ref and --quiet was given, or with status 128
  if it is not a symbolic ref and --quiet was not given, or another
  error occurs.

If that sounds OK I can update the adoc and call it good.

Thanks,
Nikolaus
