Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF902441AF
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992862; cv=none; b=Qz3d4r91kV9mdlbhvMhUmJtzdaaZ7TbifBXlVddojlsIHHEUBvE0McxjausvGMMsbVfa+Vg9xVxuE6S5it+PEKGwbX25PjBS3NROr6/4OcD3FRW+fOOtcyiuQvtWbR5+reH15kclP6d25DlInmeXEBAe68j//aboj5mUSMJHCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992862; c=relaxed/simple;
	bh=By2Qp4jODwg9xEdWW+rPXuuYJSdGgYDVTETS43mpuTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLbp2CUzm6n9OuJv/9KArwWab3gH4+bdPkqJcmR3YIPHyWAEK2NrjmPB73PqY5dIINkfV/+a/NHqC9gQ/sYahdCPqCxaFxMBPG3NDGEQJPC2GzTheyQRk0GqPDVR+yveWLnmAyfPAeuIgXgOweARWOiH/j6YEAVFJ9iywxw0iBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7074a9e498bso1181886d6.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 13:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992860; x=1754597660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQyRmVnUYD6Q0dMcDzZiaWW+DIitMpj7CKDCtqZBn6c=;
        b=mxBjnZfR6+IrldIetMA+R9jijBGY86dberJkKnf25qFo4arr6yQ5+GXZVDquu9W+zq
         C8uKJsAhpEpnxMy9VIkLTK/8ShUyUqqCD7SwP8IpSRwOBVM4C+75Le9Dqhh/Qz3NXgCe
         9DbCdJ+zffI/JwOL7b1tWNvwDRLqximewfpdGtez3vXr4gRsn26oj6eRvw8HkqMC7HeE
         iRNyXAyPH+U1o+lG+ver1h3mgErkIhMVCCF9MhQryijJ1moDFQKc2lVM3Z3+t6Z/Zjd9
         aXkyFfx61+TD0GG1L2uFGYzLIc0wX4RO5od0P0JdealDp78pq+SrTbzv7wRSXL8SUOSa
         CJ/w==
X-Gm-Message-State: AOJu0YwvE4BrATnfNbZlVvIEdD5YQDI/Az5hpDMLMthbT0FvkpuN/Y+6
	GEHo/l9hWQHfU39gVdp3N8wsaPhn9m5v9rlv8yIl5MzBb7kKVyipn7qDIPmTnc8GZYySgq7EDVR
	BuY42N1OceuPMYdHE9R857XJj/mwgH+gYiQ==
X-Gm-Gg: ASbGncte3PHwZaLMso9jl+Ck0wo7l8Ocpc642JhWYoneJPVAMhTMHEKTdeU6edPoltr
	mBeDlNKc99OwknWJDruSdBkrKXkb3sP0shMm5vzD6TTa0xSrnH49HlzzuTxPv6WYTi0PStdDU0K
	z0V72J+NjcLB2tEOb2yERpj1qn71nsSTvHs5h2nCpNkyg5Qq6hM7D47mNBe4M/PHTGsJeZo+9zz
	EgNXvKCJOlaAquem5fLszgitYDd9t4JZInhxMc=
X-Google-Smtp-Source: AGHT+IE+d19AtM47t+gXbT38UFFOHaCXN1e1UBvVnFIlR9X/CGlZr3F3+gxAExQm7/gFtHyL9LTVBKN2s3sP/EQ4mLU=
X-Received: by 2002:a05:6214:c2d:b0:707:4aa0:2f3 with SMTP id
 6a1803df08f44-70766e19b54mr57604906d6.2.1753992860006; Thu, 31 Jul 2025
 13:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731074154.2835370-1-gitster@pobox.com> <20250731074154.2835370-7-gitster@pobox.com>
In-Reply-To: <20250731074154.2835370-7-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 31 Jul 2025 16:14:09 -0400
X-Gm-Features: Ac12FXxlji3oc-HplYwk5of704lR5z0fbDZ6Rb3G-OQl_dVyyFPIijudjtS0eY0
Message-ID: <CAPig+cQVo9diuwxqJZ-ippc65B2e_aFq6vEVZ2j-8ZYrVByZ9A@mail.gmail.com>
Subject: Re: [PATCH 6/9] notes: do not use strbuf_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> When reading the copy instruction from the standard input, the
> program reads a line, splits it into tokens at whitespace, and trims
> each of the tokens before using.  We no longer need to use strbuf
> just to be able to trimming, as string_list_split*() family now can
> trim while splitting a string.

s/trimming/trim/

> Retire the use of strbuf_split().
>
> Note that this loop is a bit sloppy in that it ensures at least
> there are two tokens on each line, but ignores if there are extra
> tokens on the line.  Tightening it is outside the scope of this
> series.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
