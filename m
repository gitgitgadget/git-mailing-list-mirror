Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26150399004
	for <git@vger.kernel.org>; Mon, 25 May 2026 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690069; cv=pass; b=anQog1m9BD8j86H3xs+XjB9o+BWerN9/nsSudxy0nKg+2ujpgXKYIHzZndyYabw/kxKhr4ZRW0wZmA8fls9nR3DP+/c+0E1nqHZMNt5GeeZLBkRV9JIfD0Waee1HzKIW/E3LOa6o4lRymOoWYgZaQn6rqyEqfJRDgkrlwBJK6xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690069; c=relaxed/simple;
	bh=nQIXrOKtBsghfk7xyrJ8AO4FOjzNgQJDNXVolwyESfw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=acBj4B+CubmK7hqioKy6q/BL7Q/n20/O+gYUv0QMwEk2pFbV3xbVVLqw8ECyNQXncp/m/XctED0hnGEjWlBE78PQZ8q6Uu61ZAdKgxkzwLHaVpSTHbUqpoDDQOIYGkfz+iqaNroNgUQWlLJ6CFQpAUu/RZ4Y1qt83CGJWBYN6QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX4zR4On; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX4zR4On"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de7dc85b74so9067113a34.2
        for <git@vger.kernel.org>; Sun, 24 May 2026 23:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779690066; cv=none;
        d=google.com; s=arc-20240605;
        b=Gr0nhs9/s9qlTJFCuX+W3qFOjZeLSLcC5cOPECwDL1ZZzL6bTcyWDOEJmgFnqkW078
         n84HKUX53j9yYiB4lwAr8jiGIuUXv0cJZbRBkeZ0v2QmZcKzJLv5FoZOjtZ6ugOGGi+r
         grO+LJ7fGQDZEDWsEDgfU0/qBRSo5DM+KVpPrq0ZVqFKMEp9JSuqZx1sV8YwnL01qGbv
         p4FbjyYBad001rGAMrPZUCpXYODHSgPwaup8FOfE4OZKUoWSasNPCNDSK8HnpQHgNGVd
         /8kl4QWFPZKLyZHxYixNym0DpHZ0cxXatfPqTwCOGQg8UKMCtgqhtp5HJumIWRoxTz/h
         8ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nQIXrOKtBsghfk7xyrJ8AO4FOjzNgQJDNXVolwyESfw=;
        fh=k+VVx7GfqcAVjUoSxqESyHHpOW9HZAxoAVyJ+h9u+g8=;
        b=LZVfVCy580iMOhyCNO9g0cYXjjEcmjKN91j4IU09xo9DtCwVd6Q8cbR8HdKIA5XnwM
         2wUZmnYj5cPDvIfborAU80mzI8BeQ4kUq6qgQmcxi+FIA/Vr868zYuUUP8XtqllhPNIA
         r3Ke1ZY0CRhgx21Ig6+pZSm6moLGYyd+LTyvNflq+Wdwt+4J7dkCn2TqtlPg6CVJyrFm
         LOjqX5hNIPU8PkraYEXod0jdlwbgnstf1ZZW6XHsd6+uqFV0VfLijipZagOcGFu6ZXZ8
         DuU3wvCugJhKoaG+SJxoIgTlQa8Zem0darmLV37qySzzzjVS4u55eUNm8ttq352Dnq0y
         bQhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779690066; x=1780294866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nQIXrOKtBsghfk7xyrJ8AO4FOjzNgQJDNXVolwyESfw=;
        b=YX4zR4OnHBiwHZSssiilb7BPtA5LNjueNbptuzRPN6AXcCV0Q6HdJfFGlET8ceeJaG
         NOHaW56EkhInu6GCZcPmZcMAwEqQ+OeAGLSTCRnvxkGGYsF6/k/v86W590NF6nI4Udsu
         +4w1HJXNiIm0u0CpjlCCUPESLKKgS4GGAZC9nRKgySaqahTkT2wn3ydGbZEGzAMbrAVN
         TZmFPRc/OLAU6mk8WOh3iEZW1piKco5rhFZy73XH/FKl7tEbvTQGanjmzqev1iEiMlqT
         jm/huqO5vNXwq5P8h7iT+ENDYs1xiEFHuUkFdv7CP+YUrs4AYT2lTgqiGv0oFmz6wAh9
         KSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779690066; x=1780294866;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQIXrOKtBsghfk7xyrJ8AO4FOjzNgQJDNXVolwyESfw=;
        b=p949Xl19Ymf2GwboWhebQaqL1I1k1LNqgaYmsXPm10BNTiUiz3JDoZLIsjPmtM5/TV
         NDEdMflNXpAi7+81cv7uAt+jEY3Vu6R2AIue8YJwYm9JQmL7KoBaNRUWgsjcArtEtjMS
         uVo5Ta+FFm7qLY/H9yypu8XfqZSLTThCkusPFWQjSoLJOu/O67/YXyAke9Uv3zKBk+rU
         2gdPeRfV518cB0AlqQ/Rl3tTKvwnA1k6s3j7Lo5GnZRBvfGJLMOUYe349uwM5rYL9wu/
         SKTTXQB/ga07NphM36dpiQUlCGAR+Z2BZkVU367KNpoOpFP+1eJk6V1/IgrDvtlvRs+2
         vD6w==
X-Gm-Message-State: AOJu0YywW72h+04Miy0kqTL6nkNd2cuesvqFXP2zbfdu4QkVXDyhSdyD
	WAhYmINjflVgYKbFpT0/hFnDuzJ0513Qqdzb3xCAC/yP0YXtTHw24srKlOOzqFhXta8ohM3qT9O
	2UXZkXilsEkT1rCdoYZ3oeu+hcKqfpg8=
X-Gm-Gg: Acq92OH8uPJUTqFg9+LBaKHTpMPgicff3jIctdXA5iscONPi0vIgZymvwZgkU5ojiI0
	D1b0t+piuzEi+BmwcBZIqNw8qfnOi8aKlZa+LdmFEzVQwInvE9g7cPcAxqEFafSUqgoJ7PfwPEc
	mWe11+0U3cLFgAIURhMQs1qjLnuuUq4yRhhk0iSsHnCd9BKd1BXskFC0Ev78RYb3aKRvNw3OzHA
	Mnk1jPdAgLyOiFx1GiowA++qHCCK+EJl+kLiE/8ZFYFl1DLOgaMwJJGNECVWmiiBU+/9kLuoLsF
	QCZ/EPoMhEoot1wzGLtMjqGnWpvOyV2I3aV2eIOhqjnk21t14y8mVN3PV8NpWQ==
X-Received: by 2002:a05:6820:1694:b0:69d:ad99:4467 with SMTP id
 006d021491bc7-69dad9946b3mr2665494eaf.54.1779690065708; Sun, 24 May 2026
 23:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 24 May 2026 23:20:54 -0700
X-Gm-Features: AVHnY4Kl8MgPvggAMoWlE8S9uwrug7dI-FM6UhtIMc0O_17ebhhmIaoXjSRXvRM
Message-ID: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
Subject: Re: Expected test suite behavior
To: amoghdambal1@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Amogh Dambal <amoghdambal1@gmail.com> writes:
> Hey folks,
>
> I wanted to get started hacking on/poking around the Git source, but I'm
> seeing some behavior with the tests that I can't quite figure out.
> [...]
> Is there a README/documentation I've missed reading that can help
> explain the behavior I'm seeing?
>

Hello. If you run `make test GIT_TEST_OPTS=--verbose` or uncomment
L16 of t/Makefile is there more information describing the issue?
