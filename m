Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A021A23A1
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849256; cv=none; b=Ue2qe5oG8X7I0v/WxjYi0IQ1TEU46BJ9O0CAFJxMjqOqkJZNrQ9vns5yCqUMuMj7axaOBr5gJx4s7eOQo8Rf60ubsbrA6fzpUsMZiwbE5yyfKiHX6PXHDyYtmAHhr+wU79qF4kGERsq9JQOT6gJSv5hXOt2xTqOB1fYfSQASSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849256; c=relaxed/simple;
	bh=oysX+dBvhmJHOV2E/u6xqnmhajQVj9ZgK3ZRf7yOusU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CClRxdeJ3qSe02XnF6k1qNedloxcZu6NdlmfLnlHTVlM+HfW6qVomyoDwSENCEkBBrrS9w07JaTNoAAl01yoPtrxrdGWRdGooyyuTPjWt1vSffJozuJMhKDDUxhVMJiPTmtycfZG2wsGePBU1uHD6n4gz+3D0dswnji22gFRBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6eb2819468dso6139736d6.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849253; x=1743454053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oysX+dBvhmJHOV2E/u6xqnmhajQVj9ZgK3ZRf7yOusU=;
        b=vJlZkxVmf/3gxspsQS/cAOvmwuREUdEAv4gZaWUfgnZ5XIFzsR1KpK4UfRhbxU/SpZ
         oifSI1N1vDkoUf8e+GCXN9wnBILnl3SEy8BsTn2UNvTcENYvS5tigNj5BvLUYfmucwX2
         eMphbMrK3jg18mRQQNIVw3PjnfaYZ2Mk6mQlB95MqPhybsZ+r6DT+wI2EoL2u2UTwzzm
         KnXixvaT3+i8u7q8ATZlPfwq0mXmGiZtygJ36cEEbtXAW68a1kTu62dBEnJso3BkHR+a
         lxPpSc2Su3gSbkzxIzgHkvQZn2e5L+mNVwFlbuU/UP2tX93zJ5PgB03SHguy4m8Bm3H9
         JHkA==
X-Gm-Message-State: AOJu0YwRGsRYOLjAgx7+9pKh3v6/gMGFcpbsrK6W8Nwn3PP6xzXNaXaR
	i2kRm8nztyjx91TKZZcCyZ7chZp41nWJDo0l4tikIer5Dh/wTp4S1YhIw9M4n7FCMpka505UZh6
	vaUaLMWyUm98mmlhbUBdaMZ76hxY=
X-Gm-Gg: ASbGncvnDTahW+GfyoSObscIwBFPx6r88XOO40Plep81ApSJpdGdNRtDUMMLsNX1tLz
	+9B+ZoWPk+5+YNc4R0bdxC6YIhKpuDa8AvWGO28OnvcPbLsp7K6/PnXIHMs0exOWmETetAOVZYe
	FBt3sWWSxrVr9SY+5Q0txxk6DueY4vrHmj1kdLvV2A3+AQk8ojRtWxqSbkxQ==
X-Google-Smtp-Source: AGHT+IHv+Jy7F2rcN+jmxamYuVdLJJLX/En1Xgaur3hf+PaUZgoKPP0U/I0RTKG/VcWQ/QEzEHgwUE0sQd542gpznQc=
X-Received: by 2002:ad4:5aab:0:b0:6e6:60f6:56db with SMTP id
 6a1803df08f44-6eb3f2f19cdmr83285346d6.6.1742849252973; Mon, 24 Mar 2025
 13:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324204558.76145-1-ben.knoble+github@gmail.com>
In-Reply-To: <20250324204558.76145-1-ben.knoble+github@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 24 Mar 2025 16:47:22 -0400
X-Gm-Features: AQ5f1Jqfqu4fSzHdXd_uYh4e8R77fIpBD9ON6rMxADNOhImHWTWpQOmVyjKhHYs
Message-ID: <CAPig+cQg_VTN7Ug3FTdLdkVwSPZGiQHJZSpCkA2pTxwBiT29bw@mail.gmail.com>
Subject: Re: [PATCH] vimdiff: clarify the sigil used for marking the buffer to save
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:46=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> The original documentation from 7b5cf8be18 (vimdiff: add tool
> documentation, 2022-03-30) mistakenly described the marker as an
> asterisk, which is the character "*". The code and examples have always
> looked for an arobase ("@").
> ---

Missing sign-off.
