Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E83587BF
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029406; cv=none; b=cO0gTq5TqHr+UfGpKL9VV/o29tmEzIuB4W5xqLIV60gLlRvkM13/oMC0dGfzM+9oIYcK70gRJmqKkY05xEyVnOn9ZE4YnhmLPlva4K5hP1a3/I1Z5gFVupjv6yUipiGTt2w17Sd1GhyXo0Hd4Gc9pBoZwoRFstmu7tZe5YviHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029406; c=relaxed/simple;
	bh=9QisFYzD1DZrUf8/BjL+bGktDiJxxcILM7MddldmWvA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VmVhA6mES+ipTXPYYbBMj8mDZBVVzIf3Ly88ALWykIcflIxZX49Ep9dVsYN/BkGyUUWI0fW6fwk7CBMzwjQJNXO38TVu73b+JVXkJX+enCrQwPytpzSBGWVa2PFqFMZGtppbgcXo5+qLuzuWX8vd+Fs/uxUxEVZ1dndPIBwrrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7rLmsi5; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7rLmsi5"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12336f33098so366712c88.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769029402; x=1769634202; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sqxRO3NOaXV0wsoVrx0pDlGfaSwvE1qpdQ61QsKQrI=;
        b=P7rLmsi5bobPVuFiaivHPrCfNar1ddbV35IcKvcQtZS5wbdxwybNj+cA+40Np9PuDG
         QHMPb88rkZsz/ErdFlUcdUP9gVmUggYKa3jz+dk3Itwy8BBdOZVCSeTnkwJauMhPm2gr
         BVrq14f6aSr7WQ9KpxSHvXYPGVPRbMH3XXpYpujesn2RNMmKsGnM/6V5a905Nlrwt/Sj
         aXoYX3Py4if6AF++HptfJhqh0YEUlM7esSb4quAMW1i1E5uuMXn8Udo0S9vXq3T0nhWB
         AOO/xJoxVdTqrmm0gnjcD5BnnDlY45gWZLsLKqnRKMyKqDBBlTFSGq+SzXzHAAoGl//P
         wt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029402; x=1769634202;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sqxRO3NOaXV0wsoVrx0pDlGfaSwvE1qpdQ61QsKQrI=;
        b=dafbcZj2+pGycNJNqo60ITHTv4Qk3Q6YOWA2/6eeziw9kL5OSp/8tUJO4scaNhK2Hj
         kA8DXog6TTboRFg60C43q/lpJRj4rh79HUK5DhlkGua6TV0DxoXtUUwyFv95ZEfDIF+M
         vAEMSuCelnzmb+6oD9eoogVezUGten9nM4YWcAt6gmdelWrs2qFoej7qhrZe19xqwXGL
         Gpkg2IvVU3IMnXYILrz3V4EfZyQY6QF4mRUAEt9bu7oK+jqnLfamRNMuaW7UqNL23YNY
         gS/n+dGyQWX6sBtXQKDE2nGcufPrlikN7py4ZqfC6k9MStY9lEVpYGt/JddTqbCAyYVZ
         ZFBQ==
X-Gm-Message-State: AOJu0Yxmg+5MD5fdaWVS4ltPgAR1YwlCDiifr7TcbzZlpBKfSXcwe0KQ
	CJwgpB8/j1oai65G3aS0MvWHbH/VybW1xbWW1ExfrYFBMTVRkV+iV9fE
X-Gm-Gg: AZuq6aJH5SoNcQg9c/FyHWevJCM0c5v9q4i8HLhlehCfPWDnFOvbjfMIHHIr73ScrER
	7TghIqdHwVgAf1KjEeHZNaNzwmrNNVLZLLFD1RDrIgjzWMyFc4HATM1FjTrz9RAIg9+/F2L+wEB
	qI4v0RNBIr+xNMydKNdWDt3DSuSpPasPwoM8XrXIwds9lr2KNvvAl1iLtFqrjB+IbhYyG/M0j8P
	QUgp+6+Z8u6FFXeN1clP3wF0LLtEm3COPuXly3lpA+/tS3sI8CSa6TP99sKst3RNnqtzDy1W/Zt
	/eXEi+868ooVg1mfadgbu6Mkb+lX30ZjG2aUd358f6lg1zI4F+uRukdFfKMybTduzAIZfC2lOwE
	FSvpusi0NryitwLMJLG+Oct7HgLg44rGUYRtaGi21wBCuDp2CTcOobk/37ekrixRjrCv/dSkGzs
	J9lNiqvBh1t8zkS0yNGJ1mK3yqlo7IlwXpOwuWK5QO
X-Received: by 2002:a05:7300:2214:b0:2b0:4ae1:b4ae with SMTP id 5a478bee46e88-2b6b4e64b9bmr15533273eec.24.1769029402066;
        Wed, 21 Jan 2026 13:03:22 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm23123200eec.25.2026.01.21.13.03.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jan 2026 13:03:21 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: What's cooking in git.git (Jan 2026, #07)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq5x8uu6yk.fsf@gitster.g>
Date: Wed, 21 Jan 2026 18:03:06 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <69F44B0F-0780-4635-8685-704732FC4106@gmail.com>
References: <xmqq5x8uu6yk.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi, Junio

> "git repo info" learns "--keys" action to list known keys.
> 
> Will merge to 'next'?
> source: <20260119210932.68893-1-lucasseikioshiro@gmail.com>

Not yet. The last review by Patrick made me rethink the entire
series and I still need to iterate a little more on it.
