Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AF182D2
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689935; cv=none; b=ANrmQOtKyzyVy6Bor0OhvbHx77WcxSciSeRXIAIS3Wun4hDgQla7ktCdSx0eog+hx1YiRcdblrZN0GXgKJIQm1tnDM8GdK6swYke275y754mwQv+cs55CqWVHQvPpYVyR6mTdOWSFkQOSqohuT9H5B8jhXZTGLLlnSDlW7Rywrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689935; c=relaxed/simple;
	bh=eGXcGm9x/TPSxk7OtAFXEhu/AkGocEtDHY77k+qZ5/Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Vg+6Y/8SxvlSZMNKIQfsxRXrYOIUEeQ2PKnY7jP/QdU68+4DP6MAtD9M/GmRVP8VFVqn+V2yzMYLqvbJokBYcy1SXFhN2dxzasI5vvk4DkkBTU2Bh0n/HEWW7wO+nAMPFV6GvO32JmBNumDBvk79huoy5nDh1hFc+xeKVXNPvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MzGQXcFs; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MzGQXcFs"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715689924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/QWW+FrMyNOaLx42n06gevoDyCGMe6i2KRb6HV05mk=;
	b=MzGQXcFsvDJTvrus7ezhM/KszW3cQpqIBi0VbMIMaxi7ba0BCrHvi+sgziI6VENPVppM7q
	V80hI+YRqU9Y+TtKtEwVjq7NaNVgBQClbndInr/s4yMie648VTBevhmpKYuRbpJy+ESyWd
	6jWgc3QUqRUjBvgCCBV5xGwJQtSOh/1hOzYIW+rGWax/rsC7lFIk4oblW/TNqBtT7Vd4Sd
	PFts4I8cE5BQq2MBwG11RFnki9T6MreUPRX/kakcIPCqTLQqUS8E13c7HERf8FTAZKpzNF
	31CiyPeoQcj4VNf0ZnCyaF3Dyz9SONio9Ibnz9GDKaz25tETUchmfmZqWScaqw==
Date: Tue, 14 May 2024 14:32:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>, Phillip Wood <phillip.wood123@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2] docs: document upcoming breaking changes
In-Reply-To: <CAOLa=ZRkLpi-DSNsTgVf5OCk6gEP7VTx2SeJRKT_Lv+pVu1Nyw@mail.gmail.com>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <2ef53ff98b12fe9373a15ec3a795235f040d9049.1715667067.git.ps@pks.im>
 <CAOLa=ZRkLpi-DSNsTgVf5OCk6gEP7VTx2SeJRKT_Lv+pVu1Nyw@mail.gmail.com>
Message-ID: <f7dbf46360104fe9110526acf19be755@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Karthik,

On 2024-05-14 12:48, Karthik Nayak wrote:
> I think it is worthwhile also looking at the number of commands we have
> and see that some of these could possibly be marked deprecated, maybe
> removal could follow too:
> 
> * log, whatchanged, shortlog
> Here `log` already handles what the other two commands do.

I haven't used "git shortlog" myself, but I think it sees a fair amount
of use in various project maintainer reports.  Thus, I don't think it 
should
be marked as deprecated.
