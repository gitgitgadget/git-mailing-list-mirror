Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCA30C62E
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442598; cv=none; b=ctJ98EW8NRaGNcLczIIgG7a8vGsQsGIenMf8cJNYwqG9mY8CTfwsezKjr1NFiknVr6l9+qGG/vp1dInbtyKV19f6TyNC9E/vbpPToRA1jB3ny3uj4DmIwIXWMokWP2PfJeWlrFoncWlwCHT05sdaNIttDvDOEpkBYuFKCE7ZI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442598; c=relaxed/simple;
	bh=ghXSu88EYig5IwPYjYl+OpD4+I7ZSP8fPGGFHzGW1FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBz47RhHDGrIoM3X4zD0D/TZyX1HEep/WtjqUiA8tvdJya3tmsOjca1qyta4TgwAkejKuOPca385YT7EeWCodRtyUwM1JM3+6YuW9DBYrdHrkII5FkiwGoQLEJuQ7LnNYY3WG7hwQS5VuXT4m785NS/FbKO9GZn5ROmKocitb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=O1yoctxj; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="O1yoctxj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774442592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1qZJ7YY67Bk0cyPy0Jv2sSkwU47QUPAEijz6NgOjWU=;
	b=O1yoctxjRegHXY4rpM8bmFqwQjXf7KM1l02eke9QlUyCsuTK/0HLDNZZQeE2fzGX8l46E5
	3jJmaPyz4mZfc0/qw7mIr586C47KJ29q47zYA2JQl2VDjx2m5m+Petf7TXYoPkkwD9amPY
	wA55Ljsj94UnRoebkDKm5K0vwi4uhIw=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, Siddharth
 Asthana <siddharthasthana31@gmail.com>, Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH 1/3] t3650: use option with value consistenly with equal
 sign
In-Reply-To: <xmqqv7em48fw.fsf@gitster.g>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260323-toon-replay-arbitrary-ref-v1-1-5c7172f675ec@iotcl.com>
 <ccc995f1-4da2-468a-97d6-f20993ca4b4c@app.fastmail.com>
 <xmqqv7em48fw.fsf@gitster.g>
Date: Wed, 25 Mar 2026 13:43:00 +0100
Message-ID: <87mrzw13mz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if a patch whose purpose is only to make the CLI
> invocation "consistent" is a welcome change, though.  If we support
> two forms, exercising both forms and making sure they mean the same
> thing may even be better, but short of that, a random mixture of
> styles as if end-user human may have picked one form on this day and
> the other form on another day may be better than a complete
> monoculture.

Okay, I'll drop this commit.

-- 
Cheers,
Toon
