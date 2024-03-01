Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2109368
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251610; cv=none; b=Sr3P1JbP2k/GHgOUIALZQQLeeUBBbrxENgP+ZJGEO4w3h6n+/yiPu50En4vk3n7v/1zGDT3ISvxeZ9il3roz+1v86T/Dwmq/WE3y0IGlSWhC/uwSsaD99wx+pBxBoy7txgbXtjsntPCghcZlwbavBcPBu4qhkg8HD2uTH5HujtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251610; c=relaxed/simple;
	bh=H/vOhKa+7VdiNuOut4f9pymSHjASyJZX/vFC4Brpf/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgZ29Eet4WXM5PfT035jqWGVjik8V2lFWojKiWV11gVciDwGdozaldF6/nvAUfuX5jvqFTx4C72CErbD/vjFhh+o+Ha38SMVde7Mr99cNe4eR36EwghA9fpFrvLNp/bijF9ElKluNanHLJrGYWnFkMllXvWZoziZJR7MrTpSKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7872614af89so197859085a.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709251607; x=1709856407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg3cV5eRMyaIr8jM6qxuAEVmdmQbXqXiISIfpc4+AtA=;
        b=IkYa7gWF07q1RKcRD2Jve3Sk78pdNGF/vD0K/iohcIg7ipFICOEuDCBcib1TqYpeOW
         Bnta8PxB35noGH7FnSL5jfOgs1swwqHQva0NLCZAGom0dXtKZLQOqu1XmwMJ80u5yR3t
         3qybLWOOSr81WADf1kWmSiG2orpY+QmYA6OLE+uQ3AyHYKnDWovtXmFB+wGPzwxYaC11
         s34ua/RnlwzUOat+WTRdhis0yosiqhmd7IEMlPOVaaR33Z3PHPGj1WTCzDYPhtzcaWTQ
         tH0P68+8++ynCXeShi1/OZkc6k3eqDvGFc25jq/Qd062zqW4L6jx/Fww0BBir01rbFUO
         E16Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuCXwlnt93V4wT/YA0u1b+bukP2yWGiF4mXVviEai52oA/CW1Co6i6ptBUd1p6YnYdadMwNsGpAtaOuZbgplvQARcE
X-Gm-Message-State: AOJu0Yy2KA+htTL+7+KHGmgTQsCatGKTeu3XhTha29bV4DO8y6M/XpNj
	vtAeA0NyhuNv725ygbow01DoUlK/x8DLuMR4JonKLB+sEnFY24NRG95xMk5ixhXaVJfKdLowYF6
	NUSXn4Tn/6FjBKTNzi7c0Mb5dGds=
X-Google-Smtp-Source: AGHT+IECKWx0fCoYk1G2E6kzQBtImXipvMAUDwoUtki2zWpgevXq0wpSMYmuIZWdCUp6LNi06KaJLV0j4SAx/nAPbTo=
X-Received: by 2002:a05:6214:18e:b0:690:547d:3737 with SMTP id
 q14-20020a056214018e00b00690547d3737mr861389qvr.1.1709251607469; Thu, 29 Feb
 2024 16:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
 <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com> <xmqqle72c17i.fsf@gitster.g>
 <CAPig+cQ5m86=pLTpFrik0xS6XPyK4tZQx_wkc1xh2r9WDFkhuQ@mail.gmail.com>
 <xmqqa5nic06t.fsf@gitster.g> <CAPig+cSGtcA15aOmvj07Uv-pFZTE58+9gGsQh=8K4BL4KRieQA@mail.gmail.com>
In-Reply-To: <CAPig+cSGtcA15aOmvj07Uv-pFZTE58+9gGsQh=8K4BL4KRieQA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 19:06:36 -0500
Message-ID: <CAPig+cQ+JNBwydUq0CsTZGs8mHs3L3fJDuSosd+-WdKwWWw=gg@mail.gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
To: Junio C Hamano <gitster@pobox.com>
Cc: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Aryan Gupta <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:52=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> [*]: Admittedly, the double-negative in "'foo' is not a non-empty
> file." is more than a little confusing. It probably would have been
> better phrased as "'foo' should be empty but is not".

The double-negative confused me even when suggesting a replacement.
What I meant was that a better phrasing would perhaps have been:

    'foo' is empty but should not be
