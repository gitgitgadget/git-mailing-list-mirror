Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B01E1DF0
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554032; cv=none; b=FxUSRCbNs2Esb4EV9swB/S2vs2zDERX998gCpskIf54DOEIfcHNRCnywnQX3dZrGQY45VnOtWu46AkC2eVZ7b6K1jxEkDJiwBxmArqN863kF+IgtTYG8/7OZLLB9Xn7Z2xcw+tWUNKZSpfSUc3DLkE0XdeCJnZe/J5k4gIq/CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554032; c=relaxed/simple;
	bh=4Aiw0Lp9+4klHZOyM6DlJ3gZy8E+TawFrlH37hc7clE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uws2fP8wQduo4U41fiU8LzisyKw6CPronaGImj2ktkQh9EWqBN71CEY+he3DEK2lMI9exhYJJb0lRFhNX3vFiZ5bdM49qTnIeHbN8Fg1wJaKdRt06ZqwZeKwi3pGW0WUvwHm0xvEtz2OOgOyaQWYR1Isotmmv4GQKfcC3GCr8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmVX/MK1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmVX/MK1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4767e969b94so64425851cf.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554030; x=1748158830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Aiw0Lp9+4klHZOyM6DlJ3gZy8E+TawFrlH37hc7clE=;
        b=OmVX/MK1ub4xzlF97NEy74uMVM4GpXjZpRmMFYaCBIXbIByaIf3ZSnI+APeLTp8Do3
         WCZxAV9NRE2bYYpKwETT9BHvjz31xO+axeL4JDsDGbhz7y18yYvP27xw10Y5QbslWe9H
         wQLENlQKFKYtZp6bZyxTRUFhePnP9uQpWV9WAU5QuJgUO7eI5/gw/tCMFkB9tqS/bST7
         TTdFyYyzlPOVvQ88TqTEhjloArtSDdrndAxaoAEwbmXgy728psZuSzjn3y9FTJjcVNdx
         eYzaLxroOjy3VwuQ+k1x5o0vLRDb1oFC7Mf/Hkd4AddGdQZ+bs8fYoYY2IjV9Fj5mgHH
         flJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554030; x=1748158830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Aiw0Lp9+4klHZOyM6DlJ3gZy8E+TawFrlH37hc7clE=;
        b=tI7WA0LOg5BaK6kWrcbuLckjnVk1B1DbM2UDCratiMq3yx8tXaFTZWkY/VeBYKEJFR
         nrjNzY076/qcM1KzkrvVd+q9igu9CE3S8AHKfdPPOWei0SEmHyJmkchJa0k1tLZk5Y74
         xbQ4ru0JNngdb0s3F+sqPDJyMbA7LjJG9yqiREE++r7by4x/uUV+DIMimAzZh5sTMjSc
         5naWF9+1UqSyn8/AMV8T6wg5g7CKWjaKMpIl6+Y4Ciql1J+M33SSyQmimV4J9jt563pl
         5t7HRiZ8ntr0q6J3lL3yRS2IANOexSzDECi8pX6anTJ8+vofDCOP7IvPA360Jpm6BfFB
         sdPw==
X-Gm-Message-State: AOJu0Yyyaknz5xyo1YZNCT9qu4IpYKrXA/ax0fcEk26FVx/zs0+j+skX
	5stVahSAoEvAYVifzQ3NzEdBG5MYmghPEjcTXRKIYsl+Cn0xVGB15rmMuSWF1EbvElNUCdH2jsl
	6a4PnZ4wA5WaUqpG9GqcbvCKhbFBOdEBEcOdx
X-Gm-Gg: ASbGncskGvjnurYYJWAmhedwTMOAvGowdJ6tHg/XsdbXW3+9udXtJCnZPctCegNyBJl
	Zm4ghrRJ+3QR8megYakCxdfoU2YnxBOzRniJu9yielJqeW0o1FvcYUVqr5WA9cyCU/RjKARFsFT
	AnlrN7DT72e0PJDl/yyTDuONH9YtkfF4ii23hJlZ5ubgFBxEGPjl5EOFsGFe0gtCUy
X-Google-Smtp-Source: AGHT+IHFpDcsWXNDy3ILskZ++OnHPvBE5Itqpq6tmGCJUn7nrgA22jblDqyxfL+XiYKKYaGW77i/6ubKZo62RMpVhj8=
X-Received: by 2002:a05:622a:610f:b0:48b:5789:34ac with SMTP id
 d75a77b69052e-494b075afc0mr110363601cf.3.1747554029784; Sun, 18 May 2025
 00:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa57bqdxt.fsf@gitster.g> <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
 <20250518073442.72666-4-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250518073442.72666-4-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 18 May 2025 13:10:18 +0530
X-Gm-Features: AX0GCFu42EP4L7LklJyOzxQnWclv9JzV2S0VmhKm4X6NxDWbFmfaD8jcIaRTEXM
Message-ID: <CA+rGoLerj9U9T+3RAzk2qO5QoTwJc6M9HqsX1zMAJSDHq9c4OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] docs: replace git_config to repo_config
To: gitster@pobox.com
Cc: git@vger.kernel.org, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"

Whoops : )

I think I did V3 again

I think I should really start a new thread because this thread has 2
different sets of conversations going on
Will send v4 in a new thread

-Jayatheerth
