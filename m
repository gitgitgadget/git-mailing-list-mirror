Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FF2D7BF
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472658; cv=none; b=GTxJD5vMCOLCjKtUWtX81GfqnVar178tZLusp12RGQeWP+T3OaJ8KZUngKbxClNZdGBucEPYhyAc3UL1qlD803quJhaOuuGjIaW3UC2I1ATddfvgMOubqhvhDtimr5JvNT0xDX1b8bOhbHByKGlCGAjTOgaD3riE8Qxnn60g1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472658; c=relaxed/simple;
	bh=PUG+MIfHFU/wMvOWvt74Qi/0hD3R0K8sosTBfwc9NHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCiUuJhmc8O6/Lu+8WPz1RQ8Et1XiZMnIMnOQd7NnclIaNjGy/rEJ8qOwEKqf+EjvCGrAqeWq/m7Y62wC3+gLlfpQ3NHQ0IuN6z0pm2mYeCXLqIS+51wpivjaWJPveK4EmtDmj/lh6DOzpbTtSy4BTZx+Vi7PIdVfIa4KtzJOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF/e2gJa; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF/e2gJa"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso188365e87.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758472655; x=1759077455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUG+MIfHFU/wMvOWvt74Qi/0hD3R0K8sosTBfwc9NHc=;
        b=UF/e2gJaqaQJb+V98eljp9w1ow+OseJtjRkmP37qoRtDpVbxdRRbSLcnLo/Wkshkq4
         AMT9Pgx4tmTyxCeuENnkuc6Iv+ZEr4tywZRFQsEhTCu38yFvSFCq33qc39OyC4/a1s/l
         qEsIEw7Dl49UHzr4qqXaRAReUzXSjcLQu7iVBoaALvPHUN8Ll4mX8i8TSR8Jr+eyNoUc
         dje/cybzv5jEKc4qJs+0HZp6grLs2c6r0w5IF17jjGYyd4yEf0u0YsdbHnPzAMbjrgwv
         ba0iCBztTV8CyfPmGfyM9XyMRBSK25YdrGxg2gsREVuB1nzXXr37Xgda7eBYsUokrUXK
         cuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758472655; x=1759077455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUG+MIfHFU/wMvOWvt74Qi/0hD3R0K8sosTBfwc9NHc=;
        b=aDGSEk8miEv/AKl8+uVVEt24LZzQlg1UIFQ+aNR+w8NZamAbOlGV62vpwO7SGkFx29
         CpNEife2HXIEzE2c5ARN1PnSvum/7cczb6ODEhpM3cbyN9IaqT8jd5lwuQA/T2qpVWk9
         Mf9NHD8d2spOSLKNjfU9i0TlvBkx503KGZ2AKtmqfxcHXESXJ7rX0pf6BvV4HZTV7tx1
         R++Z9kSlq8Um5r6YXpbp/9IPucxrfQwiGJSTVKv/BEO6HI9v/aZIrPB9rEme/YE/3ZpF
         YBaYDzOa0L/vIt2qBJvJCciZGq3ZqEILCX9/EnrgTwn43xO1LcEUI03VrYQ9VPSXG0IF
         /LQg==
X-Forwarded-Encrypted: i=1; AJvYcCXLsKz6rXCumaFwLulZp27yLC92vdU/VkZSfGWFiUI7cU5gN3oItRZtbaDSpA+EvSdyxlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQlM6FFIKzkEZ1lTIg+AQ0KBuhDAqdSdLgVjYIPl5sRG9RD7s
	moH7RgmGCU1sbhQy3k9FMb81d/o0xvl9vNYPLNPTtPvVYGCMpRiep9xxqXVWLh09l84eGXO0MFw
	3GeEyG7iqpUvI0qtlwOYvPvokLubiwns=
X-Gm-Gg: ASbGncuxJ0lQkctlhImwBsLsuORilsWcEt79wBXKWo/f3eDZwTE2s0a4ATfMK1yfNIQ
	xV7iUJzJEqJPSlHegUH66VE98rMSpWkKOpu6vc2CGDi/qCNJQY6Bq2BgRsgl79EH+IG2T3Ug3xg
	brYA5fkTivvbleT8P83YleXeGb0vsOyndAUMKg1WY8hAaqU4TI7RzGurEXGSshikpj2JDUKwSMn
	we87fFR
X-Google-Smtp-Source: AGHT+IH1ISs8N6ztoB3e3fQM5F/YyYforWYMgRqzgPSFbQVVmAvqYtlbCQG69vFq+QFDFlq/Ae0tyHvITe4Y+c47aEY=
X-Received: by 2002:a05:651c:f13:b0:36b:2fab:fa6f with SMTP id
 38308e7fff4ca-36b2fac0045mr3049351fa.3.1758472654964; Sun, 21 Sep 2025
 09:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <fd541355609b715ebe94f9e025450165bd91d170.1758294992.git.gitgitgadget@gmail.com>
 <daad78da-752b-40f4-9c69-d6f6597ca258@gmail.com>
In-Reply-To: <daad78da-752b-40f4-9c69-d6f6597ca258@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 10:37:23 -0600
X-Gm-Features: AS18NWBzUW0f4KmhhntEBtwv84jjLhaL84wKCHWuH1wflBnXertOVY5ReUY7LYQ
Message-ID: <CAH=ZcbCqnr_WteidXTETCFxO=NGuT84VRg-ZsU6Si6coP+Z2uQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] xdiff: delete rchg aliasing
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> What is the purpose of this change. On the face of it it makes the code
> more verbose and introduces an extra pointer dereference into the loop
> condition. The compiler may lift the dereference out of the loop but it
> would be helpful to know why this change is useful.

Most of Git directly accesses rchg, so changing this to also directly
access it makes the code more consistent. Also, usage tracking tools
like ctags or a modern IDE won't show all uses. This makes it harder
to refactor or audit. Dropping the aliases means every access is
visible and discoverable through the actual field name.
