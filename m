Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D767A139
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248990; cv=none; b=HAWjo9HJItW6nbCRA1AR7Ow9hGdAPn4wnqg7lIUvTGTY0cgSK0ypuH1BWbMUmgojPCzzB3D5UwUHY1AVVoJ3a8Xc9X6atKDILSwDVglpeCNmDnyTOqrcYf10oBdd8uEhlgVXfHhQ6AfhHh9lEQ+fJjJoISj0YtujgsebUfNOfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248990; c=relaxed/simple;
	bh=nGc5+i24MSB2LT66ayhvjyb2G+U0+wTFdRPA+VP9IdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o23/zMYyNniEBQggaCH3bXtVFGJjwdRj7WJA3UqSdy0KCbiCl1/o8IRFrBGTxbyo5nnHOMPl2914LMphGdQYt72Lx4CmM+2jfIbAy4/KHB9rqm9ncK51DBrSVC83Bdfsn0TyaiN1G28wbxvs0kd/H0WAumUZrHBPEerV9IZTDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690494d2e97so9003816d6.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248987; x=1709853787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgA75ZC2u1lp04vfpUve4PzX3rwvLkvWvEJ22vUhwag=;
        b=Q/E86pi2QhQOr3HkOneAJLtB+xOEHw+9L1GlcYTcxs6YUv3GMsAO7Q6AlPjxnyXxrK
         5J0N+gEVkjv1FotHLC76ECvepTf0LA8uPVGpuL1Lx73FJAVlRuVVqehCoGfjRMJzjR32
         Ne1UsJ7uXo6tNQEMZ5JT0+xv5/LDbH88gGLDeLc3xHQnMjnEBaPpMNiJR2wImcqfooUT
         YcuQVEgT1vLqp3Gnz+o0RfYe00lAJbIkSp/htq8PlH/w/Usp8oioOLCSJ4Z08fesMHem
         E2r/ySqW99c0y5opeJDQ139RhPqLja0qaay3bTSgpGMbVnyrX6HCK/Dte1vxq7qCu0DR
         zmbA==
X-Forwarded-Encrypted: i=1; AJvYcCVk33lI/Kq8HR0kCsCZmoA5MLkwwFFt0k9a4IjbLbKSMHdUDghmAL9+dv1PTYV5aQ7RLgrDs/UqYkx7okIVCSTnEwsQ
X-Gm-Message-State: AOJu0Yz+QiPheAVrKhd+pLOFj7YdwwucyxIvBRY2BXfmX1Ws0k/cJW9j
	qtJtgAsHJ2IHOVWeGiLOuS/LhvTBDL+mzNwfTrOujtkK+tND/0SzGfyNtN1n49JCXKCTpLL7xZu
	HzpRqphQNMUT5Xu1xkGC6imIvwLM=
X-Google-Smtp-Source: AGHT+IGmXSi10A3Z1IpoBkwo9UcK4XglQdSdeLPcO4rPlLgNBuCMB5DaiZ5ma2TpUr8DAUq0LUl/okTwnh8IGhajbsI=
X-Received: by 2002:ad4:51ca:0:b0:690:47dc:cb4d with SMTP id
 p10-20020ad451ca000000b0069047dccb4dmr5244193qvq.7.1709248986744; Thu, 29 Feb
 2024 15:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
 <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com> <xmqqle72c17i.fsf@gitster.g>
In-Reply-To: <xmqqle72c17i.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 18:22:55 -0500
Message-ID: <CAPig+cQ5m86=pLTpFrik0xS6XPyK4tZQx_wkc1xh2r9WDFkhuQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
To: Junio C Hamano <gitster@pobox.com>
Cc: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Aryan Gupta <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> So, we may want to do it more like this, perhaps?
>
>         test_expect_success "Racy GIT trial #$trial part A" '
>                 rm -f .git/index &&
>                 echo frotz >infocom &&
>                 git update-index --add infocom &&
>                 echo xyzzy >infocom &&
>
>                 files=3D$(git diff-files -p) &&
>                 test "" !=3D "$files"
>         '

If taking it to this extent, then the modernized version of the last
couple lines would be:

    git diff-files -p >out &&
    test_file_not_empty out
