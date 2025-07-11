Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64141DDA1E
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254029; cv=none; b=mISwqTbp/PJSOlT16BjMpDT7j4QgINlX+7eS2OMTwB9wyazX9YizYJXbWEXXeFRl5psQNDs0BeEDJKkwuLZR7uyYKSo75YNVomvnLSmy89RChcjkE0d6goGz6+zYyHxHQGp0DOTi4xlTIGIxuLcrBU9+qAM9fk7yEpfUHJo7wxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254029; c=relaxed/simple;
	bh=Cz9x1A+NuJ4l/ZE6UHhdMgh73DivuN8GaE0YbtjMTSg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C3R1OP1jZgM+v2u51hPW9Z4apYUQpU4lCuXS8LswlWBMdCPupgS8zN+Rcy/OBldGaLWGJ4R+Q0rrPUaUY3YinlYQ8pS0YM79divdKJ2juBdA0ep/fwmtbJ6lnlLoS/p+59xhh39LDIv5Jha5aO8TzZ1JacYPDP+X2Jvd9ERjdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbJvNNPC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbJvNNPC"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74924255af4so2070973b3a.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752254027; x=1752858827; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIAAi6qyxJzMAYcK4RXJ22Dyd+ZIfJmJ+SKNq3SU0Mc=;
        b=MbJvNNPCNpsLMV/0E1DUmPGmEFfAYMbY1IfqtiFl0zkIwsKriVyBD6W4s0s61jmC6R
         VVR8mWwosDDxdQoB1joGYN676G8qDsrwB8KtFfO+cyZiv7+dkos/1D1ZqcHkUOaSy3yK
         8PXdDl1WYPBScJwHmDrk3+W/K98joXnVXspbzccTst62mLifuRHmycmjSrt0xFswuHCW
         Cij40HVL8Iuvlya3PzBnWeVfo2j6jYWHFy9hwTXa6mzeiKkTgOTkgtB54UiZ+arrodEE
         pQZp12O2awYcAPuXL5XCQXXKQhfaVEZ2mY6gTEdfdUNrH2LBmIoMDQowF+ElJifivc9F
         2H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254027; x=1752858827;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIAAi6qyxJzMAYcK4RXJ22Dyd+ZIfJmJ+SKNq3SU0Mc=;
        b=iB5zOs5TJvGj+W+jlF9Ud1gAc9bNBAH2LPIh5at2ShsA0W+4JfoUk7WLkLYYwI6rIq
         ML2Pe5fbpeBPeTh22Pk8XJqdO06ZP/sg/OxMdjmSPb/YjTd9THivyzVP7mNoYWa1sALG
         nU3xWgRjgIrwS5dL1yWqHhaubcV8tUBek9l1+GexDyZZw0ZhFeq68sAKutvIGAxUYbXJ
         Rftpxd+Qvmaem4T1kLWZ+r4AOr6pCQsMm24wKFAvBVYz5bg6Uhz3y0q2unKOsuWWu4ZU
         4aF6yoXvQ1lqkhDVRUJ3/tYoa6hS90Tx2H3arR8ReDkWr+eqydmDLRjmtflERDD9S9wG
         LDTA==
X-Gm-Message-State: AOJu0YzP/HbRtEmDIk6YthZepQxgQmGcdyGzLex67KTxrZupmrnqRUZr
	rDzBEHxW6hGLlLeVPgSImrifvCgb7bjUD+uoQCVUf7VB+Go1WISRBf+I1fzMoA==
X-Gm-Gg: ASbGncs2EuOvsVqfWK/DZrj1svM/ziM52eo9EsiOFebMw/fmAZrkns7wLQ1osZzPqWV
	cvQRo8CI1kEtGvV6xmz44Da/Yy6A6VsMFglUc6qvlXTLmU5/GKegaMRg04sYkI2xn24kK5+hS2t
	O49UAr6G2NG+JdM8Q2ZfkkQCgYzO8Penb3fKTy36LNaWtQHx9qgyS5dqwCz3lHRZch1QsRipu/M
	2c9LnB2gNSeWA1G7np4jcugnP3uZH0/ExiQcKgpHycr5ZnGQ2YOrQWbegxDoweevTrB4xwrVwvk
	260DgoPlHB7BEPuCtk7xZTnpJCEVLSan1cN3Mrq1aS0pKkSn29RFG1DaZ1OghEHvukH3TUIFu0I
	arnHXlyz9z9H19xCNLiB8G03A8L4TRDfYcUB8G+7whSuDEiR/Ind0sZGTtSd7
X-Google-Smtp-Source: AGHT+IHqfogtlS6Y+QO01+y4vXXCNwqWHm/tRWiPEfNaZRdTvS0tSDG9AYud6SZ4n0IFbsq1UjnTaA==
X-Received: by 2002:a05:6a20:729b:b0:21a:ef2f:100b with SMTP id adf61e73a8af0-23137e8e678mr7293802637.24.1752254026471;
        Fri, 11 Jul 2025 10:13:46 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:934a:7d54:8e94:486b:47ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd71ffsm5952114b3a.23.2025.07.11.10.13.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:13:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v3 0/5] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
Date: Fri, 11 Jul 2025 14:13:31 -0300
Cc: ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 Justin Tobler <jltobler@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FEC4502-867F-4B9C-B752-376EF9464983@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hello again!

I just had a meeting with Justin, especially focused on joining this =
`repo-info`
command and his `survey` command [1] under the same command (perhaps =
called=20
`git repo`).

Some highlights of our discussion:

1. How would this integration be done? Making this `git repo` command =
only as a
   house for two different subcommands, or making it a common interface =
for our
   work. An argument for separated subcommands is that `repo-info` is a =
light
   command, while `survey` is more computationally expensive. An =
argument for
   having a common interface is having a standard format for requesting =
and
   retrieving data from both sources.

2. A solution for 1. would be keeping the idea of having `repo-info` and
   `survey` as two subcommands (perhaps `git repo info` and `git repo =
stats`),
   following the same output format. This would also make room for a =
third
   command which would return data from both commands. Then `git repo` =
would be
   a plumbing command (`git survey` is more porcelain-ish), and its =
machinery
   could be used by a separate porcelain command for formatting its =
output in a
   more human-readable way.

3. Justin asked me about "why JSON?". And yeah, to be honest I'm using =
JSON
   because it was listed in the GSoC idea of a machine-readable format =
that could
   be easily parsed by other applications. Given that this would be (as =
far as I
   remember) the only git command that outputs JSON, it would be out of =
place,
   while the other format (null-terminated) is easier to manipulate =
(e.g. JSON
   has Unicode issues mentioned by Phillip) and follows an already used =
syntax
   (the same as `git config --list -z`). This way, it seems to me that =
dropping
   JSON is the way to go.


To sum up, we'll end with a `git repo` command with two (or three) =
subcommands
that output their data in the same format (the null-terminated format).

Then, you can skip reviewing this v3. Instead, I would like to ask you =
for
comments about this new direction.

Thanks!

[1] https://gitlab.com/gitlab-org/git/-/issues/529#note_2585264408=
