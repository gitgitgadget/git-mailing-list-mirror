Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850926;
	b=WmCTXyYpTrhxSGBXCf7hXDeRHzZ9oRKBbFtfrt+o0qRRm3suLDH1jzOwBdEYlnkgnL6p
	 SU+ljdXm1sD5bgXteHP+BwnO4eDPU0wZe+lTGNjudP/TGqngbSLSrB2kn7ocW7l21jl62
	 5eIf1qwlnMEiHlIcbtXIn6aVqZ8AnWtIpfquBFN7GyGLogUpVneaG3DaUZbfRBlym43/h
	 oX1vrQ+TEGSpjb2yxI7sV5af2ZWk7Za4ECKdGo7sCPv6YHpvHDaTS9dkIr/lD9mAqrtIP
	 E7wWfh/Ib+059qIY3BkbukF9IKO7Iy6Xy7GYZ7iwql5e5UoiyV28uAzgImvwL1665Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IiRUI1GnMzJZCfbcKh84guoOhQvsf+v7zMdXUggX7xY=;
	b=nrbo/5CcKYXQnezXnV8KPCqg/JVqJVSj085A+EAKwrX3uWMReNeDxy79JtPVUyM0VWhm
	 DpSPcKIGS48/KNpeNZ5dkA2MC6k2ldv6tdGdMG5R0yuRGhIVRoVEZEYW7yymaaGgQSjCK
	 8t5boD4t0az7I2V2lPfHGpHZkUzJ6RfDH6tUf4LHHDuIFnpNZM0p3uRH/F9pFsx6Ycpoo
	 DzSnQa0GFprvfYzleefwoTfEcjXhvtsrSX84BbRvrJuaVtRkcB9dxLG9nC2md0w3+SXvO
	 VViO/CuJYnVlOhfwita673TOfQnT1wvJ5kntLqQBe+PDY3Oc9Q4V3c3NHQ7KPH1t4eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XIfNbOfM;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F9606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 533F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XIfNbOfM
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so6283841b3a.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795850925; x=1796455725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiRUI1GnMzJZCfbcKh84guoOhQvsf+v7zMdXUggX7xY=;
        b=XIfNbOfMMJVauu4IUR5SZ0reLI5VYpZ3WZplzdeaWyNbwCtSKtZptKsnqU3XNAa/AP
         GHnGsQv7eC/6x714OK2qySzvPu0H/XRzSvBwVVsO/Uk/2rbyhQwJLWPdVBZRNnpAxGx8
         dWnjyjZfc96DqKMnvctrCy2nBpob43g+mt/5zHCtUm+2TXohTJ4KrLz8UriW3/qjrfzo
         TZ2bNh8Z3QGHDmsbYg7FrQ6+QhHRuVtup3Nuz0qzP++P62D1fJ4zdUsWKplcQRG3j3c4
         28W/Am584+Q3h+71+ZDplLIhs2/jEfP+dn1bWDPNfyHNmI4pQ7gn4DOOI1BOSlfBoObU
         BjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795850925; x=1796455725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiRUI1GnMzJZCfbcKh84guoOhQvsf+v7zMdXUggX7xY=;
        b=FpuLUpaJp21v5JJdLJy9TTR34if1dORP8I0WmSopWd/zNMnvEovz/aBB/9jcSXtLX7
         AgvK9wdTzVQQBW70gPgPHihPHVOb+835PgNwqkyRiW+h/F3sbBN2xD7qH9LAwTXbH18+
         lfgCXwcEqyKFjjetDxDJyHwmTn8Vq+UNb3e+gGpxLuNgFcgbprfbfewPf6EYncphRfkx
         WrD1Qtw0N7PIK+7SUGvgfVx5eQ0N1wcmCbmANoHnjTqL+D6SR6ZQA6+FcIhXptRKc8x2
         3t1nKvD9XzHIpXETehrmlZ8AVduNpwBOL1oTyZR2L6opA/8mOnOkZWsj38VC5nJomkcv
         FhbA==
X-Gm-Message-State: APuU4Z9K2b2n6stBO/QUv/VevMPZayXu4cref8zzYwmyJCOrI80FYH9g
	dUME5UhqZnnAD43JcX/nWN8F9pKvAUWD1NXgWtEyilF7HFEMnbxFSZ/f
X-Gm-Gg: AZFdTZezS5dpkaUyw74Kpxm92bn4QPfmcWf1deEW3aMCmOjJz0kwJ6VqrW5uvwREnNa
	RxfNnF5H7fXbicn2coURdmznmRAmT+v8NIK35LUlXlxvw0vc8IxNEK8BDBmyNKhBT2++l3JEuDq
	xC0+O9KK/cycZKpurqJY0AAdnPMz28gnb9cfci/DbzN1k4nqOO7MbZIDeX8I1YQB+g9BFvGkFls
	Fn5lLD8tS9iLmNcyTUKjP70jFXIP2xitK6p8/xKxLJsT5pwtN9J9B48A0hwdKwAD72rHaz43qYF
	al3FNWvj6bKKTU6KQCNqttKVPJFsRAVfeSTvVzBr3Mn5NdYdM/nRcndEhR9l6h1sDC/e4GytpAp
	55BPRZTywFc9BKzxJQ7mjq0RVJrh4FDJ5BfT2vZZrZPGHzCSGeYHMbaQgHhIuTWjxgh5Ylml43Q
	W6KqQ5EC9IPCgjH64YiWDlGpPsU3z4eYCrrilxQRt1nRqnahFEw8sF4cVR7V8WSMATUsDtectvK
	JMsDm+MaDTaiMR8mpVouw9COEGrw9ItxMr4wCTTjzW58zsmdqbVeSLVuIHTHRiw5O+WWWoMVetn
	71itz9duYAFPYiDJ4YgzfJpadEsUahLZOXBIi0QycidmkVQmZwVuaAmuSbcBnmysw+pXnSUQ4FD
	Ln0XbuGjXuMNntZd0O1fH
X-Received: by 2002:a05:6a00:340a:b0:89e:848a:fc97 with SMTP id d2e1a72fcca58-8c87c95be2bmr25386326b3a.35.1795850925491;
        Fri, 27 Nov 2026 23:28:45 -0800 (PST)
Received: from localhost.localdomain ([223.190.82.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4d7basm13470537b3a.21.2026.11.27.23.28.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:28:45 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Mike Beaton <mjsbeaton@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
Date: Sat, 28 Nov 2026 12:58:39 +0530
Message-ID: <20261128072839.75270-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq4id1xx7n.fsf@gitster.g>
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com> <20261106182945.1316297-1-aniketgupta3001@gmail.com> <xmqq4id1xx7n.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Well, isn't that the definition of an empty line?
>
> Or are you saying that a line with some whitespace characters on it is
> "a blank line" that should not match anything?  It is entirely possible

Yes, the latter. What I mean is a line that is empty once its trailing
spaces are trimmed. trim_trailing_spaces() reduces a line of only spaces
to "". add_pattern() registers that as empty pattern and an empty
pattern matches any path that ends in a slash. A line that is empty to
begin with is skipped already. It was wrong to write "blank" in the log
message.

> justify, as there won't be a way to match a file with a funny name,
> like three spaces, e.g.,

There still is, by quoting the spaces with backslashes. "\ \ \ " in an
ignore file ignores a file named with 3 spaces, with and without the
patch. An unquoted line of 3 spaces never matched it as it is trimmed to
nothing. Nothing is lost.

> "A line that holds just a CR in a file with CRLF line endings" is a
> confusing phrasing.  Do you mean a three-byte line "\r\r\n"?  That is
> hardly an empty line (it has a lone CR on it).  On the other hand, by
> definition, a line with two bytes "\r\n" in a file with CRLF line
> endings is an empty line.  Without making it clear which one you mean,

I meant the two byte "\r\n". By your definition it is an empty line but
add_patterns_from_buffer() tests "entry != buf + i" before it drops the
CR, so the line is not skipped and an empty pattern is added from it.
The three-byte "\r\r\n" is not involved.

I will describe it in these terms in the log message. Apologies if I was
unclear before.
