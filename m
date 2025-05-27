Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242B156CA
	for <git@vger.kernel.org>; Tue, 27 May 2025 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390108; cv=none; b=FVbvTLnQLmmJTxSiK4N+gmLpcbbR19NEqHYoSDxsGnSOdOk6LqIwnYkqYBB6NtQiibBwvgHPdAzBSX/Gw2skhC7HxqPKdQwX+4/DEDOlL+ThlS+17xcmYp+HVFsVmWEFL8AP9yr5y+EztBoh6CeYHhm+v549gRVNe0zb/JDLpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390108; c=relaxed/simple;
	bh=UhdBYgh475G6Qt/f59gtwyDzbdf358gjiVnQQNoAhUA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Rlf6jUVNooyxna9wfINMC/WbRLS5vUr/uy5U8ia5Fihr6t3XbkabD9IvhHxe/h7vIQ2nqjVG8/vDZ1H1fPGFEDHriErWesSmRAY9FBmJXqSCAYI6vi44dXMivS+mCMCwz6m8NJ5xIc7oNan4MBs+5OeO/f0ezrPmBvmuG+d6wqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT9D+nBl; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT9D+nBl"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52f036ef186so735832e0c.1
        for <git@vger.kernel.org>; Tue, 27 May 2025 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748390106; x=1748994906; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UhdBYgh475G6Qt/f59gtwyDzbdf358gjiVnQQNoAhUA=;
        b=mT9D+nBl+mSmgWbDBcKeA5QE9zknADwESx3XIZvhvkYJEnda3HlPSCB6ccF2efSOEx
         A7gRQDWf2eO8JP3vmmD7Vb+h7/v+guGaaZc3aOMr71sKwM7BjMS5TPANYGNkbnIqFDaY
         4zZA0u+onL1ZozBByW0veY0K8RasSc4uigeOA2jHxx6XJ3lmBigvsTR+mBWlNNipFtRO
         2nAdsSmi/mc8Wse+Wwy0Afa6JOF6LNsdFexWPuFz6d9lAYP56MwzvadfHyTe6XxqaU4x
         3ySE0sd+3f/C17PN3fzRitnwpNQp0E0JgbF6ELiLdDaz3IPuNkdQAwrQqktV+GIRQPsD
         a8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390106; x=1748994906;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhdBYgh475G6Qt/f59gtwyDzbdf358gjiVnQQNoAhUA=;
        b=GTewNFgPKpR2O0LfahdAl4WtnqxgopliWCAOC5+lF2LQhiCGWhBbIAnIaNbKMn6PDC
         HAMXf55g7EybkslGHGydrht/HhaZGWAf0sn/QJNv0r6zQ99uDnf4qowY/aw1UO9ViMhO
         vKY/va+l1AC1ZtuDwC9VFWrnuMn7YzFtZh7nlK6M9ILip7KfzzvSMppOzx8ylGkoIR1j
         hG0jYUsj4l64QxRDe5Qqvm/WblnnxJxt98iny+I36CBfvXBHj8AzrdewDQ0fCBAOIrId
         KOK3e4ALENkPdlLn1B41P82jsemNibG6mBptGTwxg14/0ILWgU/siUO8H4sXXMO6I7X4
         R4HA==
X-Gm-Message-State: AOJu0YwPlbDSu0KYyBE+ee2EPHdFVYrI60sf1UerCBkCgt0aQu+C8lIP
	TeeZjjJJp3F6745G0GyOvJJoGU1xEKGwFrNKxD5gDBd3Q5HIvStzEKvAhkXBOrIsz8rTXQeB/eN
	RPR/qyDthcYOfFs2iKiRCFmTtVlSXXRHpWvXg
X-Gm-Gg: ASbGncvpWSGX4MdYlMEj8+uxYysooNWnbFgkBGza4TTw0Id4Kqqt9H9rMeOmD2cFago
	P5c5Er6VElEPYcfc9V8JM3QvUPlwfkL1pE/8EPLzi9gYI6CpqMqjoroGwPGygcu9GiN+Tc1iSsr
	c8n4ciVODG2jizaRyAYg6iUhV47iHXcai0Mw==
X-Google-Smtp-Source: AGHT+IHorQ4jkzVbmJZduGFWrZOaR3qALdWuXCMCMnPyNfIqOvG5Q7+U+laQqIJF+BcZhugN6CucOVimTxMYnHCDSYg=
X-Received: by 2002:a05:6122:3d06:b0:52a:ee1d:f7fd with SMTP id
 71dfb90a1353d-530669b69a0mr8820e0c.8.1748390105706; Tue, 27 May 2025 16:55:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jarrad Whitaker <jarrad.whitaker@gmail.com>
Date: Wed, 28 May 2025 09:54:54 +1000
X-Gm-Features: AX0GCFsnClmyH_ORSdCHPM7sgt2845PZx0KyWoQrLhgEZryyNthmoLl5mh-mv6k
Message-ID: <CAOWMAxwQacT=PcPrWiuEJzSH24ELDBxq2XMNX1X75KSp6cS6jw@mail.gmail.com>
Subject: Feature request - optionally include merge conflicts in `git add -p`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey all,

A small feature request (and hopefully not a small "tell me I misread
the docs"!) -

When fixing up conflicts from a rebase / cherry-pick / etc, files with
conflicts are excluded from `git add`. This is very sensible in almost
all cases.

However, would it make sense to make a special case for `git add -p` /
`git add --patch` / patch mode of `git add --interactive`? There seems
no reason to exclude potentially unmerged files in mode, which goes
through changes chunk by chunk.

Excluding these files means I need to manually go copy paste the
filename into `git add` (the horror), and additionally I don't get the
great chunk-by-chunk feedback from patch mode above.

Cheers!
Jarrad
