Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E49463B73
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783550; cv=none; b=a5igeC6siFFK2dJRn8VZbv2X6I2+u8QxX/83Fi38aXYfe5DHx5Kvmf8niKwVhGHh6G1ZKNQkwiu4xJQRNunKuGBABbbcLs2BmmtBwZNo3T0PcArovWWmsE3PcIUgGi4FxSNEJbT6JUNTi2/7haZ6pnPWLV9zWos8+0DTeE5fNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783550; c=relaxed/simple;
	bh=qvJYNWHhPs5BBZz15vwQCHyh3aFn+JBD8OuJvP4dm9k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Na3biXichWsSsIxAjO+BoTOg0/du3V4ZzWBXS5CCcQlDb/hZuYdKEZ1bu2VnTfIZAk10zXnsy4zspG7Asj8j4/OOlmeNNUjVCFU5tleTjM7+IPJ2sYX426naCanyK754dayUUD8dBvlJxLGspQNuAbNv0Faaxlr3f+X62VN+mPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em58oRGa; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em58oRGa"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ad795d5205so1190321a12.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783544; x=1791388344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXlfOS6j9JAQLIflAPoTu361tdd3e+WYZY6mhRyfrVU=;
        b=Em58oRGaUpeU9dw6ZBgG8qkrSOHZOLRZ+Q0h3PZ2a9fMNe0icaWYCBqU6lLHULSBf9
         cVZpw9GIdKDEesa9813u81V0mI7gGf5pkjvpxEgwQwl/1ZEg1w7kWkuR9IbSjf8R2/5v
         dxh9nJgU6S1vlFra5aqD5mxNk2Sc1IvNWrAnsNN21fRKxwOavMfcnnc2c4ftLfKTrhUy
         NbJnZUxlGqLbxU2QiQPYSjNKFsZT7ARcTKGZ/GHV85c/RGqQxw7SQUGMaJsHsjyFaxog
         Qvn/SkiN0qvR+RLJePuQzenetwkNZoXo5+vE1F26gvmu+nmNQaYxuPGieIO3gjKtWLXH
         QSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783544; x=1791388344;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXlfOS6j9JAQLIflAPoTu361tdd3e+WYZY6mhRyfrVU=;
        b=dgYpygpWJCRo1hXdbspWREA64k6Jkj6TaNtuP+cwlzRf22G7s20MTXtVKnRlpvq5rO
         zSq9KGOERblQW/xW65SqWE7y9teLdE6eXzS8GEgxVPng1eozsHngONCdYdKVjz2aTJWT
         DHxtAIodZPzQQgBdeKCcDYUtYrXXPHWUQZLQyFIAMLLWe5G/3v6w27Q8tVaVYiB0ehMT
         0AgSCZjNAsEIGaL5To5vJoO0a/sQuX91fBPxZ1Fpx8TvMfgu3seguWx1UeWi5Gsw8Ly9
         nOH3FeeoD53s6QoasJfoAVcwOIIasO0Zt+OlfKqo8nuAtSUSTKgbBumSn5qOv1JUW97H
         cP8g==
X-Gm-Message-State: AFq9FYIb5UwT5O4veZFQ2VosCUFDw49PU4EOabnzzXP3z05OZH48r+WC
	BFAPFti8ioRvio0230lMhuCaRmUimx4d3ZxGPQ31GOUW0J/LKI25tMy2
X-Gm-Gg: AYBFou2F1Z6xpFldt8M5oWhYCY6kt4fFLXkJaU/cmjOkyw81gBxWd+3CJMWAKZ1tQ3b
	xg6j4YRsc2xEePXeQt9O0w11UmaqqziKOh5NZ5cVtCCrK51hcY2KMZR9r7TkXMW43SuAkqEec4E
	D/yGMXyiQkvJgo0oox3BDz75IdX9BITqHPRepo7jA1CA/Y/LmqIXhbVMKsHBLivg9Jh6/yxhFJ/
	srZ0u7G6AoYQHqn3eqtmQrpOdrZFcH0lfJi71PxIhU9y1zpP+C1XWXGpDkxIJqAAEEF+CSGP4lx
	WC0GYI3o67Cd5eQKgRlNiTEWUxDXlL7PMgF/7NdJATMLEtIvtvieM+NrWS3HHtzM5u+hTf4h6eH
	2IaFoEgzVm9DoqZ5oJg4hMHwoF5sKdDudsnL8C86Xm519GJwSKwLaygIE6inmPNWtDsSP+TV/+O
	w6LbyX+KzODHZGarxvMNR9r7vBtWu5qLgkpsQs7cPTWy0YhvgJyO8D9aHCqlV5H8No97oQbLRtR
	s66t3rYmzx5r9U8qYgn7byD90gdswyXagMJWMOoABMokX9Zm9i/Ig==
X-Received: by 2002:a05:6402:43c6:b0:6a7:ee56:6160 with SMTP id 4fb4d7f45d1cf-6ae19949dffmr1356157a12.34.1790783543409;
        Wed, 30 Sep 2026 08:52:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae156a04a9sm1018389a12.26.2026.09.30.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 08:52:23 -0700 (PDT)
Message-ID: <acc4ad5b-1ac7-4a63-b771-fc2e585a6ebf@gmail.com>
Date: Wed, 30 Sep 2026 16:52:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] ci: link failure and leak annotations to the test
 script
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
 <xmqqpkxudcva.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpkxudcva.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 15:37, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> With these updates, the patches look good to me.  Unless others
> spot problems I failed to see, let me mark the topic for 'next'.
I've left a couple of comments. This version is a nice improvement on 
the status quo, but I'd like some clarity on what the filename and line 
number annotations actually do, and why we selectively escape the 
annotations.

Thanks

Phillip
