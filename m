Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7103D75C3
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068913; cv=pass; b=j7jLQKU2Low2Jtu2ayo8dVq7Pm5h+k7YVMub0PIsXBoAD1Hr7duh5JY6CSuWf91eRC3zIF4bfqwm8gLoNSc/y21HtzJywLeH7srCZCh/d169qkAX87uvzAM4BSpMYYlyRtEnGgQRpDkfPCXn1qHUBMqdmAuTC/21Cb8XARRLPX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068913; c=relaxed/simple;
	bh=yH60iogH1B2bxQ/b0/kuFuPlVbHgFJGEifD7v1HKqnw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=W9UvwS58Ocif1gTeV3msyBqDrCSIJ1GnMBNd0OW121W9Hw3o9KyA57zlj//84y4r/Y2z49juXQA61ZaUcHwvMH6D4fc7seeqAzy7UUBm2g36/cQmZvnjPFKljCWqMGeGshOqyqeHwMHG+qhYGU6jUiaHXlwrv4cspUDijCM3568=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBQAAOp7; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBQAAOp7"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad8435f46so11387007d50.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 08:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068911; cv=none;
        d=google.com; s=arc-20240605;
        b=AC2lBEkiqcqkm7M6RBugTc0jea0FYNADgQ+YA/I+aYn/6FWPykqHK8TRDGkNcZJLmh
         5EeDbZbMimnKvate+q1Fxk6GIxD0k4eFaIZtVWTBBg5RlHlX6NyxTSm+ZcGcGz11HA29
         P0NuOisvG5xcOmiCw9YHge7hIg3AJYyc8j8qLaBr2jpJdGkXyNzXleSMYXUapqlGUWSz
         +81KfnJWLKGNZ5wjgqNGrn+8BnwUPvU5HLoMwoEqTKE8FOg1waULpLLKH6fXOHBXEJH0
         CcoEujtKOLZxrWsoe4fO44iAOVEgvSr2FK84JEsiNHUnqk6Xidud7CKdEV4hI+qqGY2K
         QxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yH60iogH1B2bxQ/b0/kuFuPlVbHgFJGEifD7v1HKqnw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Q718q9pWd7Cm1FV4rB8q5UhNl9E/eSnL5vCahj3O54x/gYeEBGjkbfm8uF4ENBL1ih
         4eKESald256xB9lcaety6LgQL13/TZXgp7HmFhh7tyq4U9U7C4Q+A5WUSUfx1AIMyljM
         X6WYQ6IGCGwWtZ0e5LjYHEhNre11qjD4FmSJvyCQds6Q84rCxxGpWzK6lcc+YMPuj5X0
         BsWHJfLWX4d4QWZnfjslmM1kFOgYSQasHIs8Wxb8JLcd2Y7gfgGfY7znpXc1WaZlwjUY
         q3tx4dtTQwJvraDKNSQp3xM3wa5i0XM1WhQ5BdCSJ6K4YMsUjtJRHFN3FX/+kCmnfPMa
         Cbsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773068911; x=1773673711; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yH60iogH1B2bxQ/b0/kuFuPlVbHgFJGEifD7v1HKqnw=;
        b=nBQAAOp7McmA4Vp9nA1JfZTd+1cU8SbOY44xg2etygdVjLyZqMWecakehkCJJKHUEv
         Qo5nUBxd93YCY7v/zw/mmA3Anyy2TrWOrt4huQ050AfUdDHnbaxO8dM8VqI4CfbfQBvD
         njpyQBPObPruATnY6XY+LGFiBi7+QjgGwmniFN41/jB77DrylaEPRYU9VypLtyxl8zxF
         OwwVBfqLLpAzNqB7/wNh3mMVAK5WofEvpEy5wu/JMYlbNXJy+aHunM4q17a7GeBvVJfD
         rl6Vz6/Uazv+2Lm1wOjiSUlcLxLA3BjrQzRNJY2SXysVI/EIIwvQS7+jwN4h94AkBXAZ
         nwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068911; x=1773673711;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH60iogH1B2bxQ/b0/kuFuPlVbHgFJGEifD7v1HKqnw=;
        b=mI0P4Ei0xsmrssc13vpTSCbUxlRGDKv2lvclMCZ8FNP5gbMSszVzeaO+jx6T4Cv59K
         q9sWvbyIBggIUNK5uU3rD5uSb38m/Z+ZDJHsGDE8BHGKudhDTnJ/q0lI92wbE4vqUzSn
         /wPacm38Gnf5dSL9PAa+13d2SRyDcEMdDYR5voypkHnx+EfSrLGgD9exjyNfn2cn8zRQ
         nBjtulQI2V7fBEr3J6pQnpbBHyaalk/Pk9/WtQLuRS5weVO31jGN7Y+MCbe7XkMd7Nwv
         Vxa26EgkGFLyAuF+StCaumkLzFWkZzTUGRSOSBAQNGas5/tneE4bvcQ63eB9g/WopZok
         DkLQ==
X-Gm-Message-State: AOJu0Yw6A60c3r8Ztcn/e/J3moF99lIEeRcrUHMr6R5j0DcUL/VY/zWk
	QmMizoaFG621Rp/l4HBwxFIhDFZhyEWoIaqBggzE3mhdWWRDL7S1FOw9CPq5lpl/eSVfwyY9sCA
	4Oe6qjHRZiMmKz0SpifxWj0Ut829j/dTi1EkEaW0=
X-Gm-Gg: ATEYQzzTtbPyu8EvsLISBb6VUXqat2kqoNPgl4W6zOxYLfjRdzKzgleSItsPTZJVofs
	usQ3ns1xneTgyR3oNVIT3wFKaanc/okU6LtYGAQ7zAwTiA/wnRa3Oh50X3LoPweBSdYjG6LHQf1
	Rn+jxYqTHJ3ilcb4j2o9nERxDNkQi/oLX2SJjcVNwpwXCxZfy35BECouy0BnE3IKYFP8tn9XBbq
	LI6bD8WiyC74GdiwHz601+RL4rQ4eXPY75KRwmGjYJpMTawVnydHkck/KBcEQCCwR7vQLeCYHod
	i2hXTOYTCyZu5nTBvDgsYQo9qB12GY/pqysT3a7m2bI77Z0thEevPL61zScRibVSCqMrHe+C0bO
	miPk5WaEIt9lnkVfkRnO3JJ8=
X-Received: by 2002:a05:690e:190b:b0:644:2e1b:c8bb with SMTP id
 956f58d0204a3-64d142fc61cmr10798796d50.59.1773068911119; Mon, 09 Mar 2026
 08:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 9 Mar 2026 16:08:15 +0100
X-Gm-Features: AaiRm51LSVXeMatKYIJmTPhXQ9ctVtgH7F8H-EMfN88XSdreWYM19utdmDEtqRQ
Message-ID: <CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi8YGA@mail.gmail.com>
Subject: [GSoC] Introduction Pablo Sabater
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!
I'm Pablo, I'm from Spain and I'm studying Computer Science at UMU.
I've recently heard about Google Summer of Code and I'd like to work
on a Git project, so far I've read the web and some documentation
files.
 I'm very excited about this and even if i'm not selected I hope I'll
learn a lot.
Thanks,
Pablo
