Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2627B4E2
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720619; cv=none; b=Nsrn6ARieBJotu8C3qxQAM+0CU2myRJfxuVJ5lHTRVxapU9eOdbyyviKylL8/KwCxjYotzzDUDvcuC0TtIQF/LpZo2jpES7YkD+ecqy68B1FfK0wrsEUzdV9erjhL0SWBrPoUM1D4bgtGlmkS/77Gjp/ih+W2FOhQkXN0byN4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720619; c=relaxed/simple;
	bh=HVSm5Nr9hMuqqXwuPnXGty3fAJMsVrsDRT6rGh7Gktk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=m+2a6WH+sne+EoJIw3qThmVCxbkQhb+2G4bX/pcPe8b+Khr9iJM52S7mwNvha7zjizlwa4dlfDiaEP7AgXMZYnsfAXzi5iPw3aBcBRcqKCP9RklHhlJJdpP2QjUXCrbz9Px5iDTWcEktVM/qUG3gmQE0Z8cEI7bsZPQ4nGxxT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHKCJcFt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHKCJcFt"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fab81d6677so2153655a12.1
        for <git@vger.kernel.org>; Thu, 08 May 2025 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746720615; x=1747325415; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVSm5Nr9hMuqqXwuPnXGty3fAJMsVrsDRT6rGh7Gktk=;
        b=cHKCJcFtmrSxY6DsZhDWBnYS36UOiNtRVa9W1eyHqi2TodV2jJFyczz2wZOa/F+qek
         OOBX/v9P+FLRRRm3SeiGGrS7we1GfZptonROnP707HUxC77Xs/2QBFkxzl8yk19tW82s
         0q84HbXgF3JqKWN5FKlqGUgAB4fVeitBj+jYkMBjlO+ziB7VNBLgqq+CgXiTmw5iBR8i
         tJyibau3bcplcxmFqAqocXep/1KSqKF4DCNefvzN+OFjQjaGqClTC2AmAcRDer36Zb4l
         rwdGXKUPwdSLeX8YNM2llsuX2oyTTaO5k1YowPyS/Rgkrxl8Ijd+oAgbPbkRQyuZLbFM
         CvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746720615; x=1747325415;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVSm5Nr9hMuqqXwuPnXGty3fAJMsVrsDRT6rGh7Gktk=;
        b=FN3NtHXuLxy0DdokizllvsOobPsOdAGHvFqXaE5gXX7WkYXJikvX8OOXU/h2YvNRB9
         tlCWewdk+9jfTMwojWfpNka2sau4FLJgXHeTixesRnAF93ElKDO63ZpW4NQvxHrS6QFk
         pRD7UlXSvG9Yjdw/NHTR2siPUqyLpYSykx1Qphm8PsD3vc5EeqWzMS5v8tL5BWQfbkVK
         weZPWZ3oWcRNM+pmEH4oTauXNppH3XJBmou5JAYvzDRM3vdr2D586tgC8oES8bbrY4nK
         yUP96LeiU8YaWbgi0PAu89hxzOpfwYyGCMd0gUg6pRCLtrne5AMNzhn7hNw4P8LdBfDC
         mO2Q==
X-Gm-Message-State: AOJu0YxmHh8mZcs8YhFI8Nizo8JlIQT941cqu1zX6Q3wvzVy+dMqQX/X
	KZ78mooQN5gU5AQbp7Z2e9LfjugT6cj9dtZZmvSZLJuuZB5vVfXquVY8aw0Oj84IeJaytI9dQQJ
	vSui0e678CLBQzEaYyRWx/u9PZH3mDA==
X-Gm-Gg: ASbGncuLl9AXvR8U3dLcQivRaf7s3uQr1YcItfklIWsp26BwD8hSiMcKPzIFKnkZXA3
	HFcNRqeAzE0u8MsZst+xLRBixpzAUzjSGed0gEXXQoKJR8McWlN/0iqxM6AXVSTIcU+SLBTJWQN
	OxdGrepKX+IU+3u0rVyyYHqs5RdVZMWOsAuvAwntu7A8cSTbPM90i5PwU=
X-Google-Smtp-Source: AGHT+IEThG7rUxN0LlHZFx6CExSHhfl5uKXTv2NORKLnGzOkdblhn3uZ321yVMYlBn76C5yf7+cBz6t49xCumn33X0A=
X-Received: by 2002:a17:907:3fa9:b0:ad1:a87d:3de8 with SMTP id
 a640c23a62f3a-ad218eaa74emr24247466b.5.1746720603524; Thu, 08 May 2025
 09:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 May 2025 12:09:51 -0400
X-Gm-Features: ATxdqUGlW4yXwt2UsGgSQ9kC5thtX-AJQ_H-0qPcNuLX2-Rqrd83rFaHBi_xNLk
Message-ID: <CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
Subject: Can I avoid typing so much when --force-with-lease,
 --force-if-includes, detached HEAD, and no local branch?
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm trying to understand some confusing behavior with the interaction
of the situations mentioned in the subject line=E2=80=94in particular, I'm
trying to figure out if this is expected behavior and what I can do to
ease my own pain when I occasionally have reason for the following
workflow:

- Colleague pushes a branch; it needs some help to get merged, which
they don't have time for. I do.
- After "git fetch," since the cleanups are small, I "git switch
--detach origin/their-branch"
- Hack hack; "git commit --amend" or some other history-rewriting
command (e.g., also "git rebase origin" while I'm at it)
- (after copying the range-diff) "git pf origin @:refs/heads/their-branch"

Now, "pf" is an alias for "push --force --force-with-lease" (what I
think of as "safer force push"), and I have "push.useForceIfIncludes =3D
true" set globally.

I'm _expecting_ Git to push, since the remote-tracking branch I'd be
updating hasn't changed. Instead, I get a "remote ref updated since
checkout" rejection complete with advice about the tip having changed.
But the tip hasn't actually changed, which I'm able to verify in
several ways.

While writing this mail, it occurred to me that maybe the issue is
that the reflog behavior from --force-if-includes doesn't work in
detached HEAD mode? At any rate, doing "git pf
--force-with-lease=3Dtheir-branch:$(git rev-parse origin/their-branch)
origin @:refs/heads/their-branch" works, but omitting the
right-hand-side of the lease doesn't.

Should I stop using force-if-includes when in detached HEAD (aka,
start passing "--no-force-if-includes" in those rare circumstances)?
Or is there a shorter way to get where I want to go here?

--=20
D. Ben Knoble
