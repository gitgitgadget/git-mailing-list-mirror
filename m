Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1D14F123
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016498; cv=none; b=Op2B7U75RRZzv4WAnFWnwn1a/ORptVPH5qCVPWQZFe3rEt5T8So4jeM0ZCsTlnZYydXH19obgnMxnZqKBzPXw8QpNtgwGq8JE2BrrTYR/qXcZTb7wirTIGyx8EuQ1nv1b5w7lwUx4giWj+dvoAsgZN8VwNSLFvtv+Gp9/o4/Xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016498; c=relaxed/simple;
	bh=ev910vA+ZqauNSuijob7ZMUNvzu2Wplqsmq6GkBam80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HcwrK5i6T1NykZDHyMIZLCgBF8XYUFOOW57r4k1hCBlZRYnRq8XHdy4RJXJuxDdEyBGxdNWCmpzODqtSOEkIRkbFcQ9bgZQJlDKhcZYWPYGqPRmYC2LrYnND7sx6TfzTiiupOWPwCDLUn1LwBEX7X/MeycTE66Q2FBfe5jtzVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lifewithalacrity.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=lifewithalacrity-com.20230601.gappssmtp.com header.i=@lifewithalacrity-com.20230601.gappssmtp.com header.b=hXUgq2gR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lifewithalacrity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lifewithalacrity-com.20230601.gappssmtp.com header.i=@lifewithalacrity-com.20230601.gappssmtp.com header.b="hXUgq2gR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so3255889b3a.2
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lifewithalacrity-com.20230601.gappssmtp.com; s=20230601; t=1744016495; x=1744621295; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eDiG9KFHd1RJdogeWANa0fYXbM5LkpyIR+9wZWUrn1g=;
        b=hXUgq2gRE/4SThiqYR3gNtdPUF2Jg9TgJP2WiBedLJ2xXSqA+RucrcVQlwgJjDW0JE
         e5MFTqp+KFXrvPt2a1HNLQAt7I90hGOuZzvHD1oA9dIypHdE8225g7XAgmzZASTXS+1T
         7FVTHDDWxjRvLARnosmEgySaNLLhi3PGIZpqv4Yndzlr4lZjwlpIVPXRdKsITDULDCSM
         WBbBRkSxfiFlOVisiwjp0TRpHIheIHICFoUCIvCexcyxKgKucHXLacfNNtTDfEe3Xkmf
         R2nvW0OU5ld0AoRNM2HLPSshmQlLJVZ0nyEBiNj/xbdoBAekw98SiheEMPEYsCU+JrLh
         F/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016495; x=1744621295;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDiG9KFHd1RJdogeWANa0fYXbM5LkpyIR+9wZWUrn1g=;
        b=LgtpyfUxbNUzhmE0R0zlyiXVVLPa9W7EIyQrjldeLjagp6ASW/p/QrvCyf50g5iJff
         /GhTHK2u+QPjUyr6kmPW9kH/ufWorfigcc1yz70eXgpzmlEcz4QzoTZtp3YnGsLqIYMn
         8sbGs1sOH6LtENBeTWfqJVNS/Lc8bAEedN5biIYl3LzeJhhFP+2fCxw61TyoTgD6FUwd
         QHLxFUXZr5JGUcv0aSjnkWgGOY7T/PEX/ANfyCAY757GhX6ozKGWFu68fla+alslx9ct
         jH/8Mbmy1PRCGIh7KhPXKKIUp6wodpn/MrH1x5e29vVNvEqa6yAx2D5w1u60gpEA1zn4
         U4yA==
X-Gm-Message-State: AOJu0YwLzl3VxZpIpAsh6c3AshhIRiNSi5cwX+KLB7faKa3EwrnNn7Jk
	evJm8rcIbTyXbVyn6n7x5b9ElM30a8C45XeSYX8q1A6U2Qi2nflpmZgLpJ1VmNNGRR4JIBzQTEW
	i+U8LfxnRvFXy/JLNQngjlbQIDU9qyUtA
X-Gm-Gg: ASbGncsvgf6Ov2uBdtiqNXycUgfSDxLOr62Pl+cdwETIYU9ttlb4NphTUgtwNmmOwUx
	PlIHtbNxjTyzLyeQi8vIhXspuiGwAnPYQvtfnZCemFsfn9/WZ2jhSQB73xo1xJ3z7eJZd1YeaR7
	jO0CPVxD6qPxAKzCBmrT05RbsXag==
X-Google-Smtp-Source: AGHT+IG45Svc1PHbiCrl0iZ0ILfpWbPRI5rs1fEBOS9yq0DNb4CKua1v/dGGGub/DqHfBlCihK5gdj8/rrB2s/hH7po=
X-Received: by 2002:a05:6a00:2e06:b0:736:2a73:675b with SMTP id
 d2e1a72fcca58-739e7102e92mr14737211b3a.19.1744016494789; Mon, 07 Apr 2025
 02:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christopher Allen <ChristopherA@lifewithalacrity.com>
Date: Mon, 7 Apr 2025 02:00:57 -0700
X-Gm-Features: ATxdqUHhV_rBjyuIV-OJmPN2zuhvJvAMMjJaCAFQs2_x1O0x_1z9wTvAB2Dvy18
Message-ID: <CACrqygB1Pga0w8VzXFGPAsHgYR_YiHKQXRnaaTokxEi2BMwRCg@mail.gmail.com>
Subject: [RFC] Exploring Trust and Provenance in Git: The Open Integrity Project
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Git developers,

Today marks Git's 20th anniversary=E2=80=94a remarkable milestone for a too=
l
that has become foundational to software development worldwide. First,
thank you. Git=E2=80=99s distributed model, flexibility, and robustness hav=
e
made it an essential pillar of modern open-source infrastructure.

As someone focused on digital trust architectures (I'm co-author of
the IETF TLS & W3C DID standards), I've been thinking deeply about how
trust is conveyed (or not) in Git repositories, especially over
long-lived, collaborative projects.

Over the past year, I've been developing a proof-of-concept called the
Open Integrity Project, which aims to layer trust and provenance on
top of Git, without altering its internals or requiring new binaries.
It uses a pattern of inception commits (to cryptographically assert
original control) and trust transition commits (to document changes in
maintainership or key rotation).

It builds directly on Git's existing capabilities, particularly commit
signing and SSH-based authentication, but adds some basic structure
for reasoning about ownership and accountability over time. All of
this is done through shell scripts and Git aliases=E2=80=94no new binarys,
patches, or daemons.

Some highlights:

=E2=80=A2 Musings on the concept:
https://www.blockchaincommons.com/musings/open-integrity/

=E2=80=A2 Problem statement:
https://github.com/OpenIntegrityProject/core/blob/main/docs/Open_Integrity_=
Problem_Statement.md

=E2=80=A2 GitHub repo (PoC implementation):
https://github.com/OpenIntegrityProject/core

=E2=80=A2 Example inception commit:
https://github.com/OpenIntegrityProject/core/commit/69c8659959f1a6aa281bdc1=
b8653b381e741b3f6

I=E2=80=99m sharing this here not as a proposal for upstream changes, but a=
s
an open invitation:

=E2=80=A2 If you think the problem space is worth discussing, I=E2=80=99d w=
elcome any
feedback, either on this list or in our new GitHub discussions area:
https://github.com/orgs/OpenIntegrityProject/discussions
=E2=80=A2 If you have thoughts on how Git=E2=80=99s existing tooling could =
better
support trust workflows (even non-normatively), I=E2=80=99d love to hear th=
em.
    - In particular, I've not made any decisions yet on the best
technique to preserve the git-author SSH signatures when a branch is
merged and then the branch is deleted.
=E2=80=A2 And if this overlaps with any ongoing or past discussions I shoul=
d
be aware of, I=E2=80=99d appreciate a pointer.

Thank you again for maintaining and evolving Git with such care over
the years. I hope Open Integrity is seen as a complementary experiment
in responsible stewardship of our shared infrastructure.

Warm regards,

Christopher Allen
Principal Architect, Blockchain Commons
https://github.com/ChristopherA
https://www.blockchaincommons.com
