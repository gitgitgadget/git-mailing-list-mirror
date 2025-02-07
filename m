Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D401917D4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965755; cv=none; b=szdP1CAAtexV89SnUXU077Xk+fvH8iPdESA4XzBpcq9HqzpM/7gzIoy4VtWyDOURxlOkLV+0x1xKnmmgCyfBVRZ498yrgOizYQ05I0p9yln9XI8qPwV3d8JTSzFeXTYJPC0G829VkCcMzUVvbnE2znL+vOh/+kKMgG8iUqJnwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965755; c=relaxed/simple;
	bh=Qg75mbWzHpDvzRqlSkz5o1j1ACyaF+697R1ZtKtKC90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pEZuP9JFzQYEs1+blpBlS+tcREakmpEYdeVYuYD7pR4d2nIm03ujrlyv8FMixg5xL0dRa/7d03RrCkBiIdSfA/hwyDXYTCcMoxbbPoSUnbj7sgbfUT1dkt3Bg5Oet+TAE4MX7JG7CSkec9uTqz0B4R1D7NLQLSX9BY9Db9sgs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8DfsmYG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8DfsmYG"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543e47e93a3so2766011e87.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738965752; x=1739570552; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qg75mbWzHpDvzRqlSkz5o1j1ACyaF+697R1ZtKtKC90=;
        b=Q8DfsmYG0QE8aogfZdq4QEgTzLvy6uWC0gZGBFY3SCbCzQuskWG5h/LBhvcXlKlouj
         Me9x0IlQ+xUYXaOK4Kjci/lhnFAq88mrFa1+5zFJ9pR3R+0iV+2PAWJoZo85W5RGXy0u
         XEHkNR7dgOOy/dX6XDDhDauFv6j3jiMHB/JBkBaTEWxUbjUeZ/zJCyeNGokZYt0ny7ZW
         duFV4a4aoMNq60ukd1kkaPDPFXcvpw0qXl8keZE4uwPWNJJT5iFbZLlggC8cseh8aL0B
         BPNG2kK65GDi1y1dzGE6tiVdy3/Pka6yGz+Lm/SzUu5/B931bAoL7m8w+COSc/DDH9rM
         ksuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738965752; x=1739570552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qg75mbWzHpDvzRqlSkz5o1j1ACyaF+697R1ZtKtKC90=;
        b=mwA8wMJgpvydt8Y0hu86aqX7Ux+XdnfLjD9JRp//r3FxDLbV9nN28tITXmHXVTZtET
         kzWRywLzrJGfzJOzWLx7gtZ1ikbPIKTIIoFZ+UJAxMqADyzK761z0+XitLQO2JYz6qr+
         kj+GMiqJOsonToAURzH8k7AnsMRjceFTcut/O0jei/ht1FL47JWFJ0r95HcvJ+RLSDxM
         Cs2JGYO6rsFmkfi8v/JSrfd4yjTs4v8v/Hd3D2tcfsl3h1fi/YRC6qD07cwGB3swguMW
         wloghKERfu4Z/QC3hQW38zXoyeTG2vG9bWQ+5EaU2Ma+EYkw32d44IRPlGUNjYyD1vcw
         ofCg==
X-Gm-Message-State: AOJu0YwHizzJGzcNMxm6rJ+cLacaddIfxMGpKBETe0FCAgkBfayPD+Ry
	rBq+qccbAZs5aQmou58RUyXRsZ8qjWSiFy+AnquTAauCCCkIBQVd2PMU2JFtgujLLZHQKCtJJTf
	E/VtxAwEL7U2JjmHuT2amnaJlU/ZioE4F5/U=
X-Gm-Gg: ASbGncv75kjrrNIie0YroNI0cg2bKLMfrCtNWOYbAxiw1ZyEjFQXgHHPw7AC4FLLbv7
	YQ0/UluyXkLc45aD/Rmvvj2jn8T4j+bXJJYGpctgrZAnepaR9K1s1F6jximj85VT62QLdog==
X-Google-Smtp-Source: AGHT+IGrdX6IuTg6JB8tU8LwRwjKrnpKTNFJnJ6wSWOPHgY4FTLMMSJEn9VIzpYocgZJe/IRg3qvqMyB0zjKH1pokZs=
X-Received: by 2002:ac2:43db:0:b0:545:3dd:aa69 with SMTP id
 2adb3069b0e04-54503ddacf7mr205718e87.36.1738965751323; Fri, 07 Feb 2025
 14:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Fri, 7 Feb 2025 23:02:19 +0100
X-Gm-Features: AWEUYZnw99XOPzAiBKQFhx-DhAGu6sk1AYAj-ELWnn-BQB5ODfuQIH0DJzq5JF4
Message-ID: <CANM0SV3DXQeNinmy1Spj7n6G=5s3jMcFrAb0Ayun6ago7F3qWw@mail.gmail.com>
Subject: Config timezone to prevent chaos when DST/changing timezone
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Issue:
With DST or manual timezone changes (e.g. travelling) you can end up
with commits that are illogically sorted - newer commits have an
author/committer date that is older than older commits.

I found the discussion about user.hideTimezone
https://public-inbox.org/git/CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com/T/#u
and
https://git.github.io/rev_news/2023/08/31/edition-102/

While there are workarounds, these aren't possible in all cases (e.g.
"export TZ=UTC0" won't work with many IDEs since they run git in a
separate shell and has side-effects on non-git commands. Using
pre/post-commit/rewrite/merge hooks won't guarantee it's correct e.g.
if bypassing them if there checks in there that should be skipped)

There should be an easy way to force a specific timezone - or in
absence of that at least force UTC - to prevent this
