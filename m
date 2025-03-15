Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5910F1
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741998795; cv=none; b=pzu6QhoZm43UwVPTe/UzSyjJkvotuZEXrP4nLhCOZ+WVfqy8rVphiOVIn2rlXgVdvFTwJDJxIXWLUVSgvcBU8YSlh27w6rVLScZW7X9YFX7Cu7xGgq+sMMR+58w1jl2fZdIWXmDao4JjtQ+pCSyeFIIAA1kxAwDuWA6hYa8NjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741998795; c=relaxed/simple;
	bh=esDANfG1XSw5iTeXfaqRl/9gSCdSF9OtbBCzr+ZCUeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUDFLBRcNzXWqzj/iDlHYtf9qqR8dhAnGUBk4Jx42o/Dgm5W5X6HyYgjLP5loFwbrDdnqSpFj1nohipLG86d1UqGRPKbIbh87infFRlEX9Xf6BLaXO3+cm1/SB7HrIRKClJB7a/JKR67CPozGjlCn2kRO9r59RYad+SyfpQvpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUonsQEV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUonsQEV"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so182721139f.3
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741998791; x=1742603591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZZlVwbLLdAlhLe0I+oN5VDWh5+qx0JOlL3Qcq3gnFY=;
        b=XUonsQEVWvQRp4qw75+VHXyHWqdloAHPRUqGsT8gCtFVXaElyWlmEcSPL5w6+kV5Rj
         3I03gIn51GGF9TSgbs17bC8L0Y1NeEYN09aeos/02+55D2It8yZtyE/TNPSM5ZHdrV8O
         gMqo+BH/qVaq4RGgGyL5uxCkjIabnt5U2lqW7b1Tlsc5IcdAXSiZapxp+v7mrdvc2WVJ
         6aMa0WXK2e4isEnUYhjeuXBkcSg192GH7gcv2/vpL2xce9tb8rTJ2pdh7C2oH/S10F/r
         FES8rLcrJ5J2NQ9Bk0KLPpg7AdfdHc0EmfWrgblZKHJeFdgPbpquUnbBoVk/CvuqFaQL
         AjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741998791; x=1742603591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZZlVwbLLdAlhLe0I+oN5VDWh5+qx0JOlL3Qcq3gnFY=;
        b=fyyRVqNe3Yz/InI1H2k+jll0m4LSunBkGQWj3ZWgYr+qPentZ9GiWdQiLFy1HLxh7j
         CCi5iE5yxjJJ4K+Sbzwp4v3cP6txkA4uELRCHrpZCk3qYv+rvcrsL7f+Ko/7otlb8cSY
         Ls/dliybQEImQO0srjF/tSpQvV71JDOuXO63TvqJijZ9JxdToGlu9vDJNjczJ7oLAgx+
         vLtwWB5c1TlIC9FMpH8gDmKb9kRN4FjgW7kcqa4PzkbgP65KSARufrNG/zgPsZwdkbL9
         sZUsotjZC1vM0zq53Q8jhH/BLAe/J1+R6z+jYATeIqpPuukd2L7fvDdAi1WnpcYO4XG6
         7G0g==
X-Gm-Message-State: AOJu0YxPybNDwop1YbudlINjJ+lqeRhMPqTcr8ctlRCkUJMdLiX5V0kl
	rb/ipc+yU2PzYWFSZzH26/RTr0ZsE5HNNByuJzB9ygP3J5TulzMc5RoikVzgXPUXLmwS3jOOR6p
	VCi4RXzZxx+MNVAKhC++2O2F0B6/ccw==
X-Gm-Gg: ASbGncv9uCee8ZbIbMOiYmXg+BTrHJRsdcoV+07n7crioKfINAPsY6S/mtk/UtJg/Xa
	0t5Am7vmrAg8ivZwdwnO5zn50vOu4UpqMVJEe6uWBNMFmBHIRj4cYqJgFfGaZeSkkLt4VNzErhC
	iSb9pRucRe+IWaZfGe/oCurfeyWbjbeNdlguC58g7hkhwnnYKBL9c/uRNanvo=
X-Google-Smtp-Source: AGHT+IGQOYVY2eJBoiwuzxWFJT1m8zIKaNsH0zFZ46w/+86ZINdjZ77gHSEIy+Z8OkY0obvtocexTQymLUuJn1R+IjE=
X-Received: by 2002:a05:6602:4a03:b0:85d:a077:e1c3 with SMTP id
 ca18e2360f4ac-85dc4789694mr570634739f.3.1741998791178; Fri, 14 Mar 2025
 17:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv7sbfra0.fsf@gitster.g>
In-Reply-To: <xmqqv7sbfra0.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Mar 2025 17:32:59 -0700
X-Gm-Features: AQ5f1JpSfyCdkzxSLsVqN5aC8m845W8__YzWW1AJ-C2SJKd-WurkRn0dkJCDR3E
Message-ID: <CABPp-BFZkiJgdMqTJCxAMkbA7c_S8Qx3aSRqiLAfqrY1Y3es2w@mail.gmail.com>
Subject: en/diff-rename-follow-fix (Was: Re: What's cooking in git.git (Mar
 2025, #04; Fri, 14))
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
[...]
> * en/diff-rename-follow-fix (2025-03-13) 1 commit
>  - diffcore-rename: fix BUG when break detection and --follow used togeth=
er
>
>  A corner-case bug in "git log --follow -B" has been fixed.
>
>  Will merge to 'next'.
>  source: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>

Thanks, but due to Peff's further questioning I dug a lot harder and
found another testcase that perhaps helps explain the issue a bit
more.  I added it and added a little bit more info to the commit
message to try to help answer his questions.  Could you wait to merge
until I send out v2?
