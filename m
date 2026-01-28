Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37497E105
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609570; cv=pass; b=GYvF18G7Gte4dinFYa2wjwD6LKf8jMv79jgOjCGfwmZBP2A8Zimb6OHA2bOjZg8uIJi75V+0/UW7rBg5Fp01q2gFTDvbWp18MAOe0cqKbVFN5JymXERnbFsO/Co8oom1bFLAHsytlboH5lr2YQ2zZf6R2PmmyJ7ROZLESHHLrW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609570; c=relaxed/simple;
	bh=dpSeV2DXwljdtWcg8K4KPohRf4+6r5IMFjKzgzF4pQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=joUTwOkIOvSLAFG4MeWMU087TvZnv+PjBVT0792MWoCK53WsNb6taam85VppDF+hOa2AsO3Sgb5qq3UbVhiTTWMvptk5i4ruRfnYua0X9viNe56McTixex1GgvG5sumCPcUZ/GncgzoHmAhYAuyb1KK22shjBv79fLhzSp7RQhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9bbGWTC; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9bbGWTC"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64938fce805so6423332d50.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 06:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769609568; cv=none;
        d=google.com; s=arc-20240605;
        b=Kd3Hth33cYb6qqjWXLzkZA8NWWa7xiGLQdd8w2aHsDw2qRzpHIL0BaEQKgy7NbOU98
         kC4mruk893bPwvti5WDc8c6+U1cB3GHLx/fLnJkqPixcJHBb+vfoXWHcvk9TpgDKPsEp
         vvARBAm7NOkY5m8RNh35D5FPlIkpc6M1S2MAEVXFCltrltieLrfwIJ8F1p+YwaNSKQCI
         sA9HurgmvxcJvoV+itXLiWkCMyN3TXvAfMK9KEjh5FKyqgqGmToOE6CJjJWsobXEQKR4
         gPyLLQRhCWPMjhyC2eGyYncaZERPTSQHd+wPrvZwgl+Xfnz1Cjz5RTvFgtw81h2pBDE+
         jZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FGMjQWBqjXjzZ/Ql4rHbzlcgxWPddVQW/tLStD+Kf+Y=;
        fh=W5xr9cuwM2OpWRNobNUQzO2Q2SJDldIpJVIohgyAAlE=;
        b=Jpi8LH4xDG+KqypIgxVl137lDVoKZtZYT0uceJP0XZf1G3AL4iSigfZOyVuvrDzlYE
         UnhEuwlO9J2itNPFeAQ62C77rHNEKEVhzbqpUcw5XBzvPc0rnKSoCwi0Gcp1Qbn1BNWG
         BZYYwaTJtPXRZdKmpogszkXlmmp9QTgAzM0M1PZr3Ly+gPZ2YjvjOpAjG3jpobfkgwP6
         9bKoIw/OiuO6zwx+g2Ih2xLWF4mEi9VHP2K+jm/UC19boXn25k+OjlVkfFlqOTOVXdVc
         rdppZ1jrx71oDYVWuJqL22HpJ2YnH12fPzs63fGfTs3OobUKrEHz3vg8hXJ6gFaORJMl
         GuMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769609568; x=1770214368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FGMjQWBqjXjzZ/Ql4rHbzlcgxWPddVQW/tLStD+Kf+Y=;
        b=g9bbGWTCKHv5E7OWOX/8D3Gf4JIWa/FT9EnqEwh3L6jhlW8/20AAz8ldOkGw1YYs38
         DVNBwedTfiagILdswv29aZr+15PbpPNqk8fqqi4EEq/jaIMOmZ0a+DgPksyMNx6OaF6S
         7z06FtxfRLnfA7KaAZ47Mg9Y9JDGIUK3Uc99F3pCltxcZalz8W9wWjQIGXWwG90dr4q8
         QGjsB8MGBOStRYrz0mytPuUzvQJ0VFie9EjNe4JoOIW0RCh1v2fRTg1zbwfn+SIgby4G
         Tzjcf5ND69RwMHcfOzTrAUv8zo7twWznCAfSHfInDAi+ICf9XAwoyXQpe5wQtCNPlSPb
         E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769609568; x=1770214368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGMjQWBqjXjzZ/Ql4rHbzlcgxWPddVQW/tLStD+Kf+Y=;
        b=qyB65map8rIUTL9LRYhjDBsiet1j9AT2U4W9VafgOZmZOiwQcqv7aa2U/7se49RuJz
         CNPb2Rov+YzFayn9ali1mZZn7jdjG+FqXzfoarWQ48cp9U4yNftcSshFflD49SJWiYxW
         Lfc2QfVKo4hSCwH9qWXIoh8444ebcEfGoFlaqZCP9Xu1Uhbek1nQf0Z4moNoQaV54h02
         j3rsV2WN+vdnjByS7WDVzn4TOUya5jJC6FRrmGW4emzCFNfFzbzXpN/7mWf4tosFI/yX
         Pl0YbkKkePRXpVU0oL0qv1r7/PHnYkSw8sd4dUw2cp6djUuNBNXjemvGghbdlADWna7v
         OSmQ==
X-Gm-Message-State: AOJu0YwqcblSxvjt/H4lUfzTmFVXpB74mcS9Wf2CY5Zhhf1xS/gfjjjq
	zsrc9FEoeq4Z4gs6hEvhIZqe3TtQSO/U+B2taxkpi3CZrUBs/9/wMaN5DNcE1auLOb5x6jSQkiL
	c2iAOuKyKESso4PAzKTkUNkfmwS9fXhi+PTMR
X-Gm-Gg: AZuq6aIGPw+Hs4RtgJzA95HVfmM+/BDtl/fQrmRNez+404rdYdxIQlO2lSbEyZNrTp9
	TIi4fLfj1PCI6OdL8BBZcV8SUXDy35dn5h77xPEpvZ8H6WadEf7BhWjYLSqqQl1Xm9JjQvFgIB+
	4bGVPbvJYcM/mhMlag50K3lLKlbD8bNFSDXQHLrmBvnk9eY0d9u1kDaZlaa/rYhkZmlVDNbekhm
	tznwDslLWPLaxOZYK5WI7X5n1uWjtxtgNSz1WnQxDFQorl1n/p2eYnI5Ay9CAj6T/MDPMA=
X-Received: by 2002:a05:690e:1301:b0:644:60d9:7519 with SMTP id
 956f58d0204a3-6498fc826c2mr3228568d50.93.1769609567553; Wed, 28 Jan 2026
 06:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Wed, 28 Jan 2026 19:42:34 +0530
X-Gm-Features: AZwV_QhuXRt6530vsl7VsUVaxI9aSWCHsb09cuS1wMIHxL3J5mqYUF79jdLOjL4
Message-ID: <CALE2CrQD11Qa+wGVhsF8JwkuwkLWkDf9kGvs1NM2dsYFuPgUKA@mail.gmail.com>
Subject: [RFC] config --get-regexp: avoid rewriting regex patterns; consider REG_ICASE
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

While looking at builtin/config.c I noticed the following NEEDSWORK comment
in get_value():

  /*
   * NEEDSWORK: this naive pattern lowercasing obviously does not
   * work for more complex patterns like "^[^.]*Foo.*".
   */

Currently, git config --get-regexp emulates case-insensitive matching by
lowercasing parts of the user-provided regex before compiling it. This
breaks valid regular expressions and makes it impossible to express more
complex patterns.

For example:

  git config --add Foo.Bar baz
  git config --add foo.Baz qux
  git config --get-regexp '^[^.]*Foo.*'

does not behave as expected because the pattern is rewritten before
regcomp().

POSIX regex also does not support inline modifiers like (?i), so users
currently have no way to explicitly request case-insensitive matching.

The documentation says matching is performed against a canonicalized
lowercase key, but the current implementation achieves this by modifying
the regex itself.

Would it make sense to stop rewriting the pattern and instead use REG_ICASE
when compiling the regex? This would preserve user-provided regexes, suppor=
t
more complex expressions, simplify the code, and eliminate the NEEDSWORK.

If this direction sounds reasonable, I=E2=80=99d be happy to follow up with=
 a patch.

Thanks,
Pushkar
