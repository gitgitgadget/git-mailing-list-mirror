Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88B14D457
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903905; cv=none; b=SKF0BTPWPQw61lA0VbRdQB6Go63zV/iKeHQKNtTWdp7K4mecPRB54Q9yUnzzWk7HvP3MKkXLG4Oe7KSqWpH6IQpWPJlrSGLT+VIuRCockQRln9ZxxvNSdbEjr3VlJAr3ETxr0AeCKu3IVrZyPW4+2N3eLxnC2JPQh+Hpv/iApOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903905; c=relaxed/simple;
	bh=2SUA/o3FxBM3YT6bCfjnu5HYaSIwN/GBcD+L5KMiR8c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=up46yELjZg7LMaLlXNbSvz+FRu0RdNL3gXS0U00kI5H7Dj5+FaDsi+4F64VXDWv8Gr0Ft0czvYVE0dccYJWFHCB68X1eeRvgxSJRo93G2qBY33EVIyw/YCSf2w/vm4Up0TJaRFA1T1kwlidm1qO2yIm8qUhY5tNjIU6+64DpxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzolH5I8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzolH5I8"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so797558a12.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903902; x=1722508702; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2SUA/o3FxBM3YT6bCfjnu5HYaSIwN/GBcD+L5KMiR8c=;
        b=bzolH5I8xhOd7y3b5O3qVBcmnHmUrKInZL4o7r/VaSz2mbAYWvu4Zn49+lW3542UTX
         PmXXQTT65Xz/X3Dz/a2ni7hqNBXXDJqbiRHNN7NEtauCbZqspHlX4NEVEuzJEVDs3q6p
         iStLGO7SlQu2EBnz7BFTwOY227QQNpxbM6z1Ti5aU2r4x9jRWZynIs57+LIImSuA3+jv
         176bYd6O/P2Y8T0PwAQNsqA9D7dRscBPpLUENeqccun510cJxrn/STyekamYDGeoEHSx
         7kKyaOmkXYkuziLr3W3U26tI0Gr+OZui3Xo+2Xm7t1Zbxi4f5i7j/FSMy/r1kQrlA8zN
         A54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903902; x=1722508702;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SUA/o3FxBM3YT6bCfjnu5HYaSIwN/GBcD+L5KMiR8c=;
        b=VCWj98XjqMlEAz/L9UPkpG21o5ZWiUSp2cMOAMK3nllcYCWL4qPIn31VJ9izchdkuj
         bRsI5IkepoNPFuGvgEX/KoH+inKm3LpYSFC8Ns/5pr3fMHmZflSyugByMnMhlBn5yN4t
         hVFgap042JnPlsFaZloS8CacVakA+/u1kGkBdCVoFtIlQdoW6YnD/wE3o7ePm3H781Ul
         m3wX445JTcyki0sR+w/E/a04jUuD7I1Tpc6i71EyQ8KGtJWE5J6/AsNpL30UAPw+6v+1
         9mRVvjVY6fxsfwTYG6SgDLUH+3Gt3+NujfLAqMo1kyxCRx1e8LCExhJK/ht+N3Bc3z5p
         KZYg==
X-Gm-Message-State: AOJu0YzrWFpfl+WrLEyUElJ9FRhEwi96u8jHtqj2mMcayupeuC0ddsOL
	DmKl+qudHyXgKI3LEOj7+2i0AVPYbFAnMhxC7+THQF8C1r4CtkyZUk0SjKfJtkButEDWcqogjta
	1J8nR9VSCZ5UwvoczvNp/Jk6owdDlR2h3bdc=
X-Google-Smtp-Source: AGHT+IGAbJX7XdynoNLpeVlPXNZHQjhNR5Lf0HDUDQORVZeIroUHdJsXa5u+5bcNdrlePoUG5TSgmH87gZaO/j/HacI=
X-Received: by 2002:a17:907:3f0a:b0:a7a:a3f7:38a1 with SMTP id
 a640c23a62f3a-a7acb4a7b32mr124832366b.29.1721903901908; Thu, 25 Jul 2024
 03:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve <steves.sk@gmail.com>
Date: Thu, 25 Jul 2024 12:37:44 +0200
Message-ID: <CAAQS9UL14d_LxTKFMghGvQQWS6dfj1RhTJYyKsz0PKoFot8v5w@mail.gmail.com>
Subject: Bug: Git GUI "No differences detected"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I want to ask you about a bug that Git has had for years. It's
tracked on pages like
https://stackoverflow.com/questions/57556917/git-gui-no-diffferences-detected
but I still haven't been able to find a solution to prevent this from
occurring.

Problem:
Git GUI shows a "No differences detected" popup when clicking on a
file, and it returns back to the same state after closing the popup.
When I do `git status`, the file is listed there, but `git diff` (with
any line-ending-related switches inspired by stackoverflow) doesn't
show anything for the file.

Cause:
I assume it's typically due to LF/CRLF changes.

Workaround:
Manually add the file, which makes the diff disappear.

Complaint:
It's extremely annoying to click so many times on GUI for every such
file. Files have to be frequently added just to satisfy the status
check, really disrupting your workflow when preparing commits and
reviewing diffs one by one.

Attempted settings:
I tried all the autocrlf options, and even fileMode (though I'm on
Windows); nothing helps to remove the file from status...

Reasons triggering the symptom:
I have some application that periodically modifies tracked files in
some way, causing this issue to regularly re-appear for the same set
of files. Over the years, I had it happen from various sources, it's
one of the issues that follows you the entire life...

Request:
It needs to be recognized as a frequently occurring bug that doesn't
have a permanent solution yet. It should be fixed either on the Git
GUI side by automatically hiding these files (or at least hiding the
annoying pop-up), or the git status itself could recognize that the
file has in fact not changed. If there is any actual change in the
line endings, its diff should be displayed, because that would be
definitely an actual modification to the file, which we may want to
review and push upstream. The current design of hiding CR/LF changes
from a user is flawed anyway.

Thanks, I'm really hoping this can be officially tracked and reported
on; a reliance on StackOverflow articles as an issue tracker is
insufficient and hides our sentiment of how many hours of productivity
we're wasting on it.
