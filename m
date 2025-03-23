Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8117E
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742737026; cv=none; b=Q7GPR3dZuXwuYKf1ck5Nr3Iy+kR/4/OQXoTTWMCSAfPR8czSvEEKQZLVcKov2Qk4YWZC1cZfWRUHeWcube7MKc3jhdF33cU7NxwRGd9Fjp1ABorkSj4KJ7cp99mJNQUxcM7pSxWuEALOsKaVvz40H9WhD/bP3x6UIqYQvquLaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742737026; c=relaxed/simple;
	bh=PksrTAnrQUf7G6aqfz5gPM19ORIvlxudlQ1sdDuOM24=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UZk/Yes50r72tR4wiEpV/JZbkrhEFmbY+lE1TLzTHudY5PIcy6lgeC6oDHvWSliB4gNBknJs0g8lj8yVtrgzi/6eYzQdQSqhtZdEN9daWbMhNt/hn2nkwtnNrlao6pBLzPDLxhKtZ8K6C63rr9VRWIKe3SGkOUdJLhT3ODRap3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Modt1tRR; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Modt1tRR"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54957f0c657so3728416e87.0
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742737023; x=1743341823; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PksrTAnrQUf7G6aqfz5gPM19ORIvlxudlQ1sdDuOM24=;
        b=Modt1tRR6QOYF0yyp7+b418rGhtIQpBtjTogm5nyV/g5AKd/VeMCCk+R1NFqAwGZaf
         EWPhmQUyWYsCcxOcrkiJjTWGEqngGbDc1E6XUmU1OzcJ+mvC8fXxHciLkqSaPWjVmVJ4
         6JBVqHewIivC2BwpNwy1dzlBjEf4/aKp/1MVX7BxZAeDLKfmo6mMbvDnIuQ4eBkwbE6Y
         fP1RrjFKbY8GKPehsfaKHCj4p+QwDNtnUupr/25/0RckLNgm7FLCKNfd+BEAMwqnGYGh
         bDDL4qKxIUhT/7BJsppA1eX58eSpdLtSJSQypUDzMFWjk8zCiMwo0lEsK9I/oBccZ+tk
         oohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742737023; x=1743341823;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PksrTAnrQUf7G6aqfz5gPM19ORIvlxudlQ1sdDuOM24=;
        b=b/LBlEkl/2xPDzCxEhCLlqaTiK2wcjbbdH2XUd28kA8ioiatjLAPz7Zic/RvG2QAcH
         xTMwJY0BnIc2b9lutPpEnIZJCTsC7yIz0vTz/2DpbNYpaxCmd97NnT8LC7B5YQnvIrRY
         T59e5Gix2HLGZdcCMvRvtWuPU49BfTN5Zggimf7Pw75FJZgp/fJbFPe2z6pc44FhOmAY
         Za8XK+T0rLyH81EsfVnn7rk9IdkKbbZqdqx7yx+xpaPdRmIkC/uWszuUJZYsQCnpgMvF
         SUBrcRdoAtXoyDN2/iSkLxdRlqRWJog3/bPW8izGVfjdb/d7ojSKJEMrRtUN9DXksIBJ
         s+tg==
X-Gm-Message-State: AOJu0Yy8j5N3m6WsWm194nb3w0q8kTlDGHU39NDlyuSpCUqhdXAICPMn
	WlNb1EAuR5IP6renA34VFM/QB8rBXa5A88R80iShnPVq/4yz5Bj7Y2+rfH0hs/IrzYKzruluxZX
	jajV9bPhw1UjNv+IqZx9Ld30NQAD1tEAKGgY=
X-Gm-Gg: ASbGncvPGU7Savh/h/mFS1G11WlUAKWw2neZXxdwFa2iLRy1dO9GMQoEcQIL1iW+Ng5
	ZUXz+Op0gumV4n6Wipjei2MVaRFVImW5s78JYrqsmEQstE8VNMrv68z/BRTMQqm9EqzqCD6Kg4k
	kvIUChDX+F2rWw22OLQRcDaPrrBPPksZurjisX9UJGpdDGq+v07yqSh83GaUZg
X-Google-Smtp-Source: AGHT+IEw0bWjRJm5DHyF7eFpHiyVi61hxS9BNEMdTnc4Rd7c/60wbTh+7T9G+rWA02eITjo6SDivoqNR8BNfiLbQ4Jg=
X-Received: by 2002:a05:6512:1092:b0:548:878b:ccb3 with SMTP id
 2adb3069b0e04-54ad609dd6fmr3015028e87.25.1742737022440; Sun, 23 Mar 2025
 06:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuting Zheng <05zyt30@gmail.com>
Date: Sun, 23 Mar 2025 21:36:51 +0800
X-Gm-Features: AQ5f1JrRx5Tk9nZiAMj0uxwj-ZyBcAorHBKp06d9mACEC3CAC86S8PJM2UyxPNA
Message-ID: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
Subject: [GSoC] Proposal Discussion: git-refs Project
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Community,

I am very interested in applying for the GSoC 2025 project "Consolidate
ref-related functionality into git-refs". I have reviewed the relevant
code, documentation, and mailing lists, and as part of the application
prerequisites, I have submitted a microproject patch
(https://lore.kernel.org/git/20250323022111.20226-1-05ZYT30@gmail.com/).

My current idea is to extend the `git-refs` command=E2=80=94by calling into=
 the
existing code=E2=80=94to add subcommands. This approach would replace the
functionalities of the mentioned commands while ensuring that I do not
modify the code underlying them. This guarantees that the new `git-refs`
subcommand meets the new requirements without affecting the usage of the
existing commands.

However, when searching the mailing lists with keywords
=E2=80=9Cnq:consolidate ref=E2=80=9D and =E2=80=9Cs: refs=E2=80=9D, I did n=
ot find any discussion about
merging these commands. If anyone has come across any previous discussions
or could kindly provide additional insights on this matter, I would greatly
appreciate your help.

Thank you for your guidance.

Best regards,
Zheng Yuting
