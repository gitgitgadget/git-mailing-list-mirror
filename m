Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329A161326
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975746; cv=none; b=KN51tvuQJyEAc173beDiptUOs5qy5QLq1y6fTy8YrOUVSBAUhfdadtn0TUkUbwfVgzoLspF4GT2UOFlvJSTyEkBATegcqMzNpEauWMXyjpfJHEjS7lkmfGJ5ebFjWeNavPCLymATTrdfkOtWiyH7r/esq/2VY8vaST8I0fK6HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975746; c=relaxed/simple;
	bh=6axoFMs8DsAtp74LKkk6+OQny7tSVye48F2CTdkaxRA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L8tsapYCdvRcU6fK26zS25KiQO/EciMdcKhjq9M9XiPotP9pXcHhuFvBuNKgxNHmP9QsKnR1qvC/MUnSUAlnRI9hX6Td7RLuj4UJtAELVuMqhbYoQ0zAN6kJ1PSNZVVA2acxeW+466GAIYsW3cWJWk98V/jTmvMMmW+rPHtEMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ8lj+QA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ8lj+QA"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ac9e8e4e3dso78504a91.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975744; x=1714580544; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6axoFMs8DsAtp74LKkk6+OQny7tSVye48F2CTdkaxRA=;
        b=ZQ8lj+QAUyxN6dcGJxJQnbakCNMDQU9aRn1Ff+Vffpcu8XajlqOgS2CuFNRG2rm2Qo
         lUke4uLihtcF8yzgKibweIfuFuuOOMYt6gQk3LR2+KGjR5zjrF1GwP2MSF/h4Z63zNPA
         f9yA5Fhsgm5wN3nA5xcOnjFmd5XwVJeCWOGQYC8JsLxL5XZtPgB75GNGg0RysUN5klnA
         CaouOgoFRMLuVug32kCZJBwpGe8iw7d6oY6ul8gbq81GG+gaUAbDsehOa3b2EQ3EBfId
         vNh2Twx8R2Yiy8txsuhAIDpKR4IHBMHmb6F86SMuS/R4jfbKyTocpQVG7J8ut9QWMekk
         WJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975744; x=1714580544;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6axoFMs8DsAtp74LKkk6+OQny7tSVye48F2CTdkaxRA=;
        b=pK2AGuTaq1b1ONGwXs+ADh6KE4QWY5+OLHY66TOCi3fkr7vQEnpI4RfjzDoV770sYC
         SLFVs1C5bR2k+Vy54ueuu98LOO5qcFQ+8wKDdm7ASHF0lzKshdx+YZuCREuDRbcQ+mgo
         x6ZL8iKfJwKgiSYhiw45wFujzW8djPFiJt1OjwE6jXVevnJxEwMGZlDCfKYwyMFD3wr9
         5GyfELHQ+hKAnMGMN6vP8TivN/T2S13f6eCPMnB7AQ37mWqleSmAT0t7ftUFspTdoWD0
         ZcLtzdpzEt6rip4/3xXP5vMYJLZotWWz7LHAak4ZLlsiMXGaQVzS2DKKwh18Jer4xWL8
         nbTQ==
X-Gm-Message-State: AOJu0YyO43l+KFJHr8V4tdVcazHhYkC+mdQTySC1NV5DeaPRTmmMnTOB
	Q2TIKn2B5wBMEK7JcyogEiGKlKVQ+ospxewiKQ+YmS/xG7DCT8aUESMMdW1IgDbMSUDdwEHG8wV
	WBQjj0E4cUcQwuKKn+BcM83x8LEAXydpA
X-Google-Smtp-Source: AGHT+IHWP1sWYVO35ZcyPj7LN1Q7voyfz+daN8BpmutWTnGcSyurZVIDv54nim0JTjVTn4MJlmaKSq6IZuBacsuvUKY=
X-Received: by 2002:a17:90b:120e:b0:2a4:b831:5017 with SMTP id
 gl14-20020a17090b120e00b002a4b8315017mr1115656pjb.48.1713975743958; Wed, 24
 Apr 2024 09:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Demp <drdemp@gmail.com>
Date: Wed, 24 Apr 2024 11:22:12 -0500
Message-ID: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
Subject: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

When doing a git add --patch, I used the "e" option to edit a diff I
couldn't split sufficiently. This worked, however when it moved on to
the next diff, my keyboard became unresponsive.

What did you expect to happen? (Expected behavior)

Not make my keyboard unresponsive.

What happened instead? (Actual behavior)

I was unable to enter any option to proceed with the patch, and even
Ctrl+C failed to kill the git command. I ended up having to close my
Git Bash process and open a new one.

What's different between what you expected and what actually happened?

Keyboard unresponsive.

Anything else you want to add:

I've reproduced this every subsequent time I've tried this, and it's
specific to using the "e" option with --patch.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0.windows.2
cpu: x86_64
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
