Received: from mail.hq6.me (hq6.me [104.236.142.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D451AF0CF
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.236.142.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013546; cv=none; b=B3uJkSBZQaWn9MVwSdgKijr+vt/Hfjo/x9pG27rlzbW1bwMRaYKfmO6MIUCfMFLraz3dwaphMb+f0VCMqAIAOsV+Nc98R6gN0ws9GEV0QovzoovIfhUFJkErb6Pko/03K+bc4FAP6u6qHWJ+PnvU7g0uIy+ScllSJ8otMmbbXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013546; c=relaxed/simple;
	bh=4xgeQ1tKtw1bWClCJYKyrtSnkiaOCMxrH72AIPuoT20=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NJIlDEORDncmBfXRh5AFsgYsDkaVPSJOkl9O+Q2fMQJA+gz7XebGhYR1fRy3rfk+lwPoyScYARSu+SyQSrCzAW8juMPiEW3xMieOBPKRya8KL0vEgv8liyIjLuJtn79YWNKhbjcWK4oOB/aL7SFWfD+MNH+vzKYue3jtJ89XLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me; spf=pass smtp.mailfrom=hq6.me; dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b=adSi/+vG; arc=none smtp.client-ip=104.236.142.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hq6.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b="adSi/+vG"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id 1412E120A37
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hq6.me; s=mail;
	t=1729013544; bh=4xgeQ1tKtw1bWClCJYKyrtSnkiaOCMxrH72AIPuoT20=;
	h=From:Date:Subject:To:From;
	b=adSi/+vGDfJusAabw+irsab9FttVH2tp/uX90C6oNmILmcNsE8fcXnJzarcYLZWl1
	 fboOfDX/VGqt5zkYZmtRBPO88y7AMjXBorV2C2MbBD79H4TcfVtaoHi9ER+4CaznhE
	 7xIDu9mOE+/PuXHVnCGv1gCnG8dF86tLHDJCgbMVWBeFdTlN4niWAX2qXAICUqRr0I
	 CeYi6DdXxjALf6fKnl0VXWIrHzp4e2kfWMKQ5psHNJ9VI4zDJrrg0fwyURzgo4VosT
	 vArdOzMV7NXaKpjtK4AwNTmwf2xqxPnNE/MNUX31MRQXzmTCaLTl+ZE6l+xBRqgJmO
	 ESQZ8wASE1EbQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288a6df82ebso307465fac.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 10:32:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YymR8I0ZinhxvnvS7DjTPzxklnZ2Vv604VsDGO6REmvtUCMRmhZ
	LtadLiRkhUm+g/yH+qomH0KYuEjcGxjoGc/LR+1ZHXFRLlV5FZznTzQ+jkK/4m2TQNiaiJdkmuB
	eatNSMKuqvnnNZiGuVakQFjKppXc=
X-Google-Smtp-Source: AGHT+IHbFE/Q1xuBGaHeDwI3g9C/NDU8dGAtm7imckyY0QFcfNjo4EiUz4hVaS42Nf1/ZMwcVPs7SDDP+lPUdzumvbE=
X-Received: by 2002:a05:6870:e2cd:b0:260:f1c4:2fdc with SMTP id
 586e51a60fabf-2886dfff2d6mr2986861fac.9.1729013543426; Tue, 15 Oct 2024
 10:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henry Qin <root@hq6.me>
Date: Tue, 15 Oct 2024 10:31:56 -0700
X-Gmail-Original-Message-ID: <CAO8bsPCWkqDFSqWwJ3gQt7O2g1okodb_Q-NbbkTq9bc7M=zU1A@mail.gmail.com>
Message-ID: <CAO8bsPCWkqDFSqWwJ3gQt7O2g1okodb_Q-NbbkTq9bc7M=zU1A@mail.gmail.com>
Subject: Feature Request: Document the log format string equivalent of
 built-in formats
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I think it is useful to be able to take any of the pre-existing
formats offered by `git log --format=<format>` and tweak it a little
bit.

In order to do this efficiently, it's helpful to have the format
string equivalent of each pretty format documented explicitly,
together with any limitations in being able to replicate them using a
format string..

The documentation in `man git-log` under PRETTY FORMATS is helpful but
insufficient.

For example, I tried to reproduce the format `medium` and have the following:

git log --format='%C(auto)commit %H%d%nAuthor: %an <%ae>%nDate:
%ad%n%n%w(0,4,4)%s%n%n%-b%-C()%n'

There are two differences I have observed, and I have not yet been
able to determine whether it's even possible to correct them.

1. In my output, the ref names output by %d are added unconditionally,
while git log will suppress them when the output is a file, and shows
them when the output is a terminal.
2. In my output, I sometimes see a raw ^M symbol in commit messages,
but git log output does not show raw CR characters in its output even
when CRLF is in the commit message.

Thanks,
~Henry
