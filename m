Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFF17F7
	for <git@vger.kernel.org>; Sat,  3 May 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746309361; cv=none; b=p5gZzCMBaKdP+utmlP51qjDn2pJOXqOyEOjKLVFL1XP5epqj4E//GqfQyI9YeiNv+CYLSNb9qPWDWiUCgEjHj75wvjk38vDKu0hPjbM20gu3FS1GX5q9mjgtGt13lfpcAm+Fnwnart8DBEx/ASF0UWtN9cmkpZb+Nz2t9388kpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746309361; c=relaxed/simple;
	bh=XKx7iPfNqqCDHqB+JAbQftOv4syZXxZsGppuyzapS3M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BXv9TcaRzaAVd+LkWUVBqwIKpyjiMlsQSk0ftQfpVt9KgWGA9iKd1hoJmgBnrLJ/jfV6Zq+KBvX/vkBGx3Q6NW7mBRu9uzLrX1C623kLtHWgTMBsaQSQEb+6g5aKCv93qLI8omu9rt9W3/9DS2qhLSaZrmpf9wWUW3eNOpHCCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKULEjPH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKULEjPH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so37323075ad.1
        for <git@vger.kernel.org>; Sat, 03 May 2025 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746309358; x=1746914158; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LW+6ACYdS4y/dTk+rVetPcUqDs8ed3oG4fI+TRgvchs=;
        b=BKULEjPH8IpPUPOdkWjzajtkPHrV6PxZ62kZbx4u9lw6SlzsgWHM3hTIFmg5Y6c6Xh
         BoD3qV/b+Okk3bqAEawfbfAlj/Dp3YNCiGr0I+3vGGJfY0vIcLYsPIoiUBol5FStlo2m
         ygKlstwp5f56C6jczprwU0NqQ8rPO+1XR/igA/wOEfNLgjfSZQTFL1Z2a0N60r+c7zKs
         F0mPBMZTx1NIsUAo8MPu9/YcvumoYdO2biai9VeT4y1U5fw6wE2HwPhJRVfSkCxS1ChK
         dTeWLyYZUceAIoAlRJ0VdOkhIF+0vO/rVzpiTGhfAvZF2Iwr92L6phd320fEaxuq6nTL
         RYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746309358; x=1746914158;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LW+6ACYdS4y/dTk+rVetPcUqDs8ed3oG4fI+TRgvchs=;
        b=p1aiwsO/Y4YkUEeJymDEAmdWg3ZBVo2Czk6qZY5pZ8gs/Cli84tuWbhsL8/DwFZV3d
         YlgCNQaJ/SGvytm3GGEJtXc0rRCHOABCir8Y8UNusoFxVyHGp1yGo70Bb+ZHqoFsjWWO
         NvanJxL08NkpD9YKOx61E/DJ14mQt5OkwyUJmieRI3D/o0qdA9gMTH/KQ4mEmG6I8LoD
         VptXhiI6pJktMdqfVz8ZeqOwdosL7ooxmz3aPl339BtGziyQxBEtXCeZLP+UmFUtdncU
         XkEH/ABk1hjocEu/bVmjAExvRAGYUYv8+zM45MvB97p0LZL289BbsE0vMnIPvi3a6iAf
         bjGg==
X-Gm-Message-State: AOJu0Yyi3wTbjDw1e+cWWNZ6J59ehnHF/Wxr5KHjsnU7iWJ+chmQIy0m
	Vlg9xDS9B9GTSHURC6rQE3XcoR3AJA+T6bnikkWcPKC5CzHfwoVJ2AsM5gPW88ehibLoCfrjOwz
	FH3eg8Mn6MZ9wo5D9N8O0OOgKZFy3arxY
X-Gm-Gg: ASbGncsoSFXIx2OMjtTW4G24GeeOjz5ys+VCwRk/+3KlaVjX7wMLDqA3WOj/TWcwMfg
	HR51sF441jJysUM0ukaF5yjxeA4t0ZLFWL2CZ6DPmzfLPBxis82nT2yAsAXW1cWp0f5YGsJ9u03
	by9nlj+ky72mm09oKyuB2W6VUr/UPjupQk+2w=
X-Google-Smtp-Source: AGHT+IEmdr20v+z7u7Rmv4cSpSkMnt4yOnbuT4adWR7MM6Vj/cIUQ6wh6aieke2TIqCW8lsNohrxBLB77pSrGah4w/U=
X-Received: by 2002:a17:903:22d0:b0:229:1619:ab58 with SMTP id
 d9443c01a7336-22e1ea6705fmr29565375ad.43.1746309358491; Sat, 03 May 2025
 14:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Sat, 3 May 2025 13:55:46 -0800
X-Gm-Features: ATxdqUG_ApADAr5AMB4QYL2mf1gZEo2LjHvwoXxuiPhwXa0nnqnozeNlVTmOCh8
Message-ID: <CAC4O8c9OJQQn_22i0-bZUDtHoi+ti6aT6FwupnQBoBFg6BNK6w@mail.gmail.com>
Subject: easily use meld 3-pane view to review merge commits?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I like how git-mergetool can use meld with 3 pane view to see merge conflicts:

  git mergetool --tool=meld

I'd like to use the same sort of view to see already-committed merges,
but I didn't find an easy way to do it.  It seems like git-diff,
git-difftool and git-show are oriented entirely towards diff or 2-pane
view rather than diff3/3-pane that git-mergetool uses.  Did I miss the
existing functionality somehow?

I asked about this on stackoverflow and made an answer with a script also:

  https://stackoverflow.com/questions/79599180/show-a-git-merge-commit-in-three-panel-form-inimeld

If there isn't any existing automatic way to inspect merge commits in
this way I'd like to improve this script and turn it into git-meld3 or
something.  It's tempting to think it could be wedged into the
existing diff-oriented architecture of git-diff/difftool/show but the
result would probably be too confusing to be useful.

Britton
