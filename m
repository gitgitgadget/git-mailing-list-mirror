Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3072C11C6
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780862857; cv=none; b=cbFQtCW6NbVWcqsW6GlUUsFAt+Zxg13CWjff8UMaDrCj9mb4fRkI3ZVR2NaGBw4SvGNdARnCRX0gKf2Cdob7hnn4r5QWOfkP+SueXRkoZcGhtvBeUUZ3V1+tc4MyytVaivUrlEXoQEbflor1oW/+KNcNqOVaihqJOM2Nav5YxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780862857; c=relaxed/simple;
	bh=eBp6dyWtlCbKBmcXG5hApsBpRLkf13NNtW+XZot72kg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjnN9Cndsjvnzd/SFD3cHo4MjqvJN287dnz1T95K1JHJxcep6dzisHo6fBv8EAuxumREhHdONt5UJY7InWz/0ZZ9eNCoTEHH4rSZ9rxCResT1KSrISOKJrauyJeP1gv1bZJDX3ZycM+y/6UAKBJnpN4U4QHiugaRJrh0YbzLji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDrtgZQ6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDrtgZQ6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so2681584f8f.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780862854; x=1781467654; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUkEoBZALMRQVT3qEUBG2xEyIKFYf518S1icbF2VA1E=;
        b=qDrtgZQ6ldRPixjPWPe3iw7+Vqevp1BrR7E3TGO4eGKW6PCXnVR8kiYH0StBRC+Fqx
         GO6lGODDROAj3JzZd9jHZ21Q7V2KsKe2sXfl7GL5kx8BQwKuYKUjdm+B+vf7DxNZgPRz
         AKDJDPlSthOvLMtwk9eUY+6Cnq92GNj83bsZXOWnSyG8gYEFz3Fn8gUUhqIYPt2D5HLa
         pYOP+nXRfK50e+ksa8FC/ZYJeky0t/xexS/dqIsLLq3lhyVMOZr9iRVAzKsnwbHbmjA4
         VV7iPUPQ27P7T574M5Y6xAJaiS3b4/63X25nYuKPiCKSMXwfTP5zg/tgkYeBaw7VLlfe
         m5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780862854; x=1781467654;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUkEoBZALMRQVT3qEUBG2xEyIKFYf518S1icbF2VA1E=;
        b=pAO9NBai1JDpGcH05clXcwCRuE1lQZjxSl1FyCuwnv9iTLH/JdEY/yLx1jF1vydjtT
         gp39kFAo7ZThC97/7Fne4m0euQ6OMZzJf2UMDdS2L60sslDENExD7Y62TnTAZnKaa2sS
         kwhiu7tjKlYGTKQlWlTfMuEaVmSfxYnsQiom15DyuLE8/Oqct9p7JujFm7mElq5n8nz9
         U4pZVuyhG7R2fOBpji+lagOSNmrjdYiPJOZfEhJc7RSjl1KPrpb+0ROzQB87vN/um7yd
         352xfI7yOJ3EDA8YUduMTldXTACRBEeQRPIeB9nMiLGPxyKnt8R0KJk+8I68Dr5dwOGg
         sGmw==
X-Gm-Message-State: AOJu0YwIqIEbS3ZnS0rWx3rH/2KY0JxD9bmB2i4fqx5A3fefpGunCaSs
	9YMtYB8qs0ic/ct+x2YDWwS1tTxfgPHbdaPeSzpuD+GVvAaOS96G5Zz0
X-Gm-Gg: Acq92OEfJtRFzIynj4YEGVRWem5XQ4MhOoenGkgBiWzaQL8KSLox6uf7M86J10d9Vv5
	u6fH+65IXQ8rjkbfMnaKi8w77gdIwckZcsltQaqRBH3VpTaRvrEr16DK6vr7BhuXV7LMw+tjEhY
	JpMgnsPK6YfLQU6rqBfsQVNupmz3pQZE60iUT4x83VbrS0aBBUrHrfAz667cLP5RuRAZIoWl/Sn
	pBZ6iEUO+6Rb+dshebqhABg6QImstD/tzCY8EfXEBN2CAD9jojy69HZr6oi339H/0SnTLf4n1S/
	9LtkyiG3YzjDW9OvslpY961hyhxS0DHRIP0eVWMgaCob/Dfartt/HoQL9GSMWnR794YfkZ3MIJl
	SRIz+fq3zadrpfYUTwh0epJSJRFCaN36D7Vmvfv7JFtE9p5iIT+5nYOLDt4oOUFF32G17pEVepV
	lncYw3Q7DDWsCal2va5oXTkxdhffxsO0qsu4UexCMS+Ukdh9ZhggYF3UxZU8f53skQVL9wHJsNN
	fo44hh+j3Yri/5/n/C4O0IVrHlyz2O+1f/uciWvZLpIHGPEFrC8r7lvuBuEdrxg0LJSd2nX+ccy
	iPQEW5h07ZoI1PBdaN/u7FSWBjI/Vu1gswcRwFJsEKDVXKCH2fVcUVSAeIfvBgqC6CylzLaKixj
	RZdDxVBbhI6TDEobzW9Oj2e7/w9lqOZXj2ZPHj0hM/ExS5bEz1Yju/7jBiY62mwI+i59kDS+83y
	SzfpOh6nd4HH7qUxKctoEwnqmAbiPBaNyOpsg=
X-Received: by 2002:adf:e005:0:20b0:45e:6876:793b with SMTP id ffacd0b85a97d-46032dd4755mr11525744f8f.28.1780862854045;
        Sun, 07 Jun 2026 13:07:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (static-21-4-87-188.ipcom.comunitel.net. [188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm35511890f8f.10.2026.06.07.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:07:33 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH RFC 0/2] builtin/history: change git history reword
 behavior and feedback
Date: Sun, 07 Jun 2026 22:07:19 +0200
Message-Id: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQ6CQAwGX4V8Z5usxED0auIDeCUeylKkHljS4
 l8I7+6qx5lkZoGLqTgOxQKTh7qmMcN2UyAOPF6FtMuMMpRVqEJNk9OgPid7k8kzWUd9bOsgzDv
 mPXI3mfT6+j0bnE9HXP7S7+1N4vy9YV0/tsiDiXoAAAA=
X-Change-ID: 20260607-ps-history-reword-fcb70eaa4aa9
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

This small series contains two commits that aim to improve
`git history reword`:
1. Abort the reword when the original message and the new message are
   the same to avoid unnecessary history changes.
2. Print feedback after a successful reword so the user knows about it.

`git commit --amend` and `git rebase -i` with reword don't abort if
the commit message is the same as the original and they update as if
it was a new message in favor of changing this behavior for
`git history reword`:
- As noted in the `git history` documentation, the command by
  default updates all branches that contain the original commit [1]
  this makes `git history reword` more expensive than other options
  like `git rebase -i` that only updates the current branch.
- `git history` works in-memory without touching the worktree or index
  [2], because it doesn't use the sequencer and `git history reword`
  doesn't care about the staged files only about the commit message, it
  should have no problems.

About the last fact in favor of 1, I'm not completely sure if it's
because of staged files that's the reason why `git commit --amend` or
`git rebase -i` with reword still updates even if the commit message
is the same one. I'm not very up to sequencer.c to be sure but maybe
there's a historical reason about it that someone knows. Anyways I
believe that given this new command is a good idea to discuss it.

The commit message of 1 mentions staged files as a possible justification
for why --amend and rebase behave this way, but that's just an
assumption that I'll be happy to change if I'm wrong.

[1]: https://git-scm.com/docs/git-history#_description
[2]: https://lore.kernel.org/git/20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im/

To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (2):
      builtin/history: abort reword on unchanged message
      builtin/history: print feedback after successful reword

 builtin/history.c         | 14 ++++++++++++++
 t/t3451-history-reword.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ps-history-reword-fcb70eaa4aa9

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>

