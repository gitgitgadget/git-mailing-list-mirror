Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23926E71A
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617767; cv=none; b=hA0O1b7FUFIfakZpXO7d2kf/9VuE5/UkYwHW6brakJMoafYCCfC7a8PX0KkM2Mu3G45ljT14DRpQbFA1J2ljrm2KaZRcv8i4Npp76l/qPfY/9Bayg0XXIsBJJk/R9WFU9SipHq1d2opkT2YPIy57DbMMKqAGlSA08yehSXwSowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617767; c=relaxed/simple;
	bh=OxkaHVVqggV5jxzmd0ASRz0uWc3PtZj6K65/jU0Hqss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox8jD5X5cKxRet6qLvpkAfUfwYayRsmLBZj4SyNH+7M+4Ceco7AjCPSo47DElmkufYMadOVPIHMeBm0kLrZWn7WJUZ+5PBftDy2paMBwelUGQCwtmgcaQcvkFrNhOejXNihHPps3pY3G7WKrmWIcph/BVXFqG45CkVGCRDZkbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgIRvXU+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgIRvXU+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4966381a12.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617765; x=1753222565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdI6R7X2FT9Z57b4Nxtp9Ud9GbeDaOIwF5cotS03Ndw=;
        b=IgIRvXU+vYcPJZdzDx6gWIJ57U1qfNPW07/l+qSoQ089oygAiR0kkDltDjHsh7ODFv
         xcSOAC32gCdXK3xTDoDConTXU2mAo13bYMqwmKK+kkbYM/ZNy6gWvlq9Da2MNSfIXE23
         B6fm7p3QqmW5VTo4EOzHxBdPzUy2qHIux9iVt1t5ZKRQVCswAwLSbrNqIilg7BPZMbKL
         85QuwEXXg+JI+xm0w0GHucAPHSB7nR4NwazkK7byEaWev7diIJGh+h2ax8vyd1k3PtNP
         70zQHWffdtcJsRU07dBDLH98dY73TkHF2AZRjn0FAvG7cQ4l+XdgjGdY+jweMjFUm2c2
         WvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617765; x=1753222565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdI6R7X2FT9Z57b4Nxtp9Ud9GbeDaOIwF5cotS03Ndw=;
        b=BpyHKqTun0EVaL4njjn3EtWS2lYe/2HMIG8CFvFQqO5p3Br3F1G8HRjOju+/cb2uuX
         3Qx9kMrRNdtI0V00kvTa6zBeYWvLS//6RqmHUN8h3oiHvlmDi1dEf+Gq9M2mAgXoxkrf
         4zjVJK72LR/66JH8KLDe4sIP8BXbfY6lCCPVdFMBf60mZkoGRpLZYeFNByIk5r+ECNnK
         DCA321XQSYsM1eB55aOey/Wt+Ym+bOTrGa/XB3jH6XLQU7f6ZnRFvqndtVJ0pMKMzltU
         qyP2tZU1Avpfjo9iDuzLOlcclAibRNdZFW+MmaBoNh5fFwI5voO57V3RF+p6aOpvdgGp
         e3xg==
X-Forwarded-Encrypted: i=1; AJvYcCWCZ/mqGhwZQrGs9yqh9ZvOKiwcpAZLV+wbiZqYASDMtF+Qy0nGrXWOAgJscpeYa7go+aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjH/6LOpZsPr65JeTseHyJCNMFVNUTmrfBJkrdOKxW5WE3/jKh
	77dNgqFTR9/lbjFqw+SYHUELx6ebOA7hdX/YC7zjtF63LTpgDcKg4/Ct/ZfcEQLWTXTvMhFHQLx
	Wx/fPJayXWvItqr8SknKHjJbrr5MBYGA=
X-Gm-Gg: ASbGncvpQQMaxkg/28GfT90gbNmRtmtC3UNhDhodTXXqtpHE98yC2/yUUXcWUnIlaPk
	9+dzQg3WzQfnUbPFPulqeKl3ipXVKzo1FuhpipCEu+Q/wa0sp9FHvhmFoefbU7WJhdJBcjGy/SB
	fMlKTlnWfNrw5U8NZUf2Vy/NggWOQlEdQ9xhiEhMWUErwVr4gLt382+EOmrd0NbSmcaPZ784KT1
	ncXhhiO
X-Google-Smtp-Source: AGHT+IE5500u4Z7v5XAXxNk2TiNf+BxXZ4xSIisKIw24HhtLRjsTqe9tdyMkm2RxTtFoX30rUNdYdMmzYCHWYnOvOZE=
X-Received: by 2002:a17:90b:254d:b0:312:2bb:aa89 with SMTP id
 98e67ed59e1d1-31c9f4c46c8mr340933a91.20.1752617764739; Tue, 15 Jul 2025
 15:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752602474.git.ayu.chandekar@gmail.com> <2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
 <xmqq1pqhgnby.fsf@gitster.g>
In-Reply-To: <xmqq1pqhgnby.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 16 Jul 2025 03:45:52 +0530
X-Gm-Features: Ac12FXwCzK-NA2rmc8YbgwV_nHzRzx2TwtN1JnBjvK7qZoVFFPp-DMNN51PHTVU
Message-ID: <CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, phillip.wood123@gmail.com, 
	shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, Jul 16, 2025 at 2:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
[snip]
>
> This patch is exactly what Phillip suggested in
>
> https://lore.kernel.org/git/9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.co=
m/
>
> isn't it?  Makes sense to me.
>

Yes, you're right. I should add the suggested-by trailer for this patch.

Thanks
Ayush
