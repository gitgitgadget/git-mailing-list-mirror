Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51551B808
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492020; cv=none; b=mNT4yXLoy1xGJH3htiaH9zlJHLB+9BeJ8mBToCMuRgadyPEuQftm5Ubw5P9v7hiWFevfZBLw1GH86JiMViuHHPJTfKovaJvUVlGClNqPFIA2cufWrgC+p3fbp0kf/vf1uKKWWhOKpC4xyO+eXOV1BnCDwYc5NkjxLhpKl6UOxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492020; c=relaxed/simple;
	bh=h9zWPw0dyF0CSohkgBCGhoccFmqVp/InF0hCTu3MHJY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QXfX6EkUU00LY7SWTiNr5KNfVH/kiLZcL4o/qBwbCnMM5Rl6EZLTadcZ/rUtrvZx1h4QzUzLKuVO5qj5U+Uz93HPpkI90CvtjLVtJeJ86FIwRSF63bVJ54lP8ARb/tGFmC/VlU8uaBR74A0de90IXqrOGUxmR0AFz0v/NuRRGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelayzells.com; spf=pass smtp.mailfrom=thelayzells.com; dkim=pass (2048-bit key) header.d=thelayzells-com.20230601.gappssmtp.com header.i=@thelayzells-com.20230601.gappssmtp.com header.b=C9dtzXDW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelayzells.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thelayzells.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thelayzells-com.20230601.gappssmtp.com header.i=@thelayzells-com.20230601.gappssmtp.com header.b="C9dtzXDW"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4679fc9b5f1so53384811cf.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 12:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thelayzells-com.20230601.gappssmtp.com; s=20230601; t=1737492016; x=1738096816; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/R/pNoscriki70ZlFIRQwJkW5f4HDEYH8z3osM8Dxv8=;
        b=C9dtzXDWcYYlUoD74LEuXevj0TTGm92MWFiCc+HUGoHKV+u+D1AeGnXs+43ZTNtbGz
         ogJLhwzBkMeeEKfzf187PvX5i1Mllop73jBd1LdrGlg2H+8ueKKVqtBFEGiC8k+8WxKk
         +cFb8h13LcUZFVNbpyoVpfDqSZ0RUfJBmgk4cKX1OA3++LjCNx9ZbKxGiz0NbOBqxu52
         sT4gRqaaIiE+bphkplyZuVthW6z4w9WZbb8bOZnN7sQU77Frj4gZmFw2iCe+YM207FNc
         AS6anJUsVOvBa87M7GTkiUEt2ti4LKizgoj7o+YOA7RA/g0G94sXcD0dUPk1HYFxfJLJ
         3dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737492016; x=1738096816;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/R/pNoscriki70ZlFIRQwJkW5f4HDEYH8z3osM8Dxv8=;
        b=MOEq+rKgyG/IkuQng+5M0sq6Nm3qLkKeLvMU/Jx2rTcKE+6KqHRRn2rXFifhFYWFqE
         ysT+9y9xubxWCWyeqBHfYFYquZj/RqtUMRMunhE9M56L/BzYz+caXqiagFc3PWo/geVF
         dwEuulxpdA6d0TZNHahG3sn2jvLdLH/ylMJun9V0Ax8PjLgKxp0LEN7G0MfG9Nu6lXUC
         8OGDESJg5jvXE44nOqWSONTsKRgIeX/EQgl3xmmtA1/NhrjrYTbk7+RuAHcyOf79rd0H
         P2FdeYMUqFZhePsMxxLDEufVLp9djo0GqN4O8nfEtPb4Nsg/L1DJvYzW10HMdcR3BcJx
         Lfdw==
X-Gm-Message-State: AOJu0Yz96oGdB/sJFHugdirF59pdXcy5Zna0OWM+hQhr2TosqneR3N8t
	hFhctymWUPtnwO0Xn62FfvOway3pxNaP3K32LiThmWS2z0VHdCkaP//RF8R1A71SWbYNWPOYZ6G
	Iwsw856tjKOy0ljMgbQKMwJ9Hyu6P+Xxvt88+F7oL2iP9uWl7RK8=
X-Gm-Gg: ASbGncs1C5pR482OF5TgZC0s1WzBbXHM5UNFhno+qSjnlm6aCHiHzIpt8RUrERHiweJ
	SjRbu/qn7ADt5tPWp5uzCZpsWYElkl5TX2LG6/gfjrG2IO6p9nV8=
X-Google-Smtp-Source: AGHT+IGeaSBJv1vvWLRzPynM3+CqIz/UvexS+Poom4pkrKh53MxQV9NgEQxl6ktiu9xdcgUwD+5dolCOx8ItM2YIctI=
X-Received: by 2002:ac8:7fd4:0:b0:467:5836:a98 with SMTP id
 d75a77b69052e-46e12a55e7emr274693831cf.19.1737492016549; Tue, 21 Jan 2025
 12:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nika Layzell <nika@thelayzells.com>
Date: Tue, 21 Jan 2025 15:40:06 -0500
X-Gm-Features: AbW1kvaF5MVG6iqRG7ttGyJY-Xba4u4dJAeC8GHeNQShKj4n7e3BhEbZYPuyIAI
Message-ID: <CACwGqKixQEGau8CZuLwJx02F4h8hxrf9e_7N1tHMU=Wvy8ViyQ@mail.gmail.com>
Subject: `git update-ref` fails to set reflog old_oid in 2.48
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In git 2.48.1, the `git update-ref` subcommand no longer correctly
updates the reflog in some cases. Specifically, it appears that the
`old_oid` field will not be updated when modifying a branch referenced
by another symbolic ref (e.g. HEAD). This doesn't break the `git
reflog` subcommand, but does break references like `HEAD@{1}`, which
appear to read the `old_oid` field.

STR (in a fresh directory):
```
git init -b main
git commit --allow-empty -m "A"
git commit --allow-empty -m "B"
git update-ref -m "reason" refs/heads/main HEAD~ HEAD
```

Expected Result:
```
$ git rev-parse HEAD@{1}
70d9116663eee9f01065c3a6d8984b1dea661f20

$ cat .git/logs/HEAD
0000000000000000000000000000000000000000
17dd31aaf89190a36b8d04136a1a0f83fb37da4c AUTHOR <EMAIL> TIME  commit
(initial): A
17dd31aaf89190a36b8d04136a1a0f83fb37da4c
70d9116663eee9f01065c3a6d8984b1dea661f20 AUTHOR <EMAIL> TIME  commit:
B
70d9116663eee9f01065c3a6d8984b1dea661f20
17dd31aaf89190a36b8d04136a1a0f83fb37da4c AUTHOR <EMAIL> TIME  reason
```

The `old_oid` field for the reflog entry added by `git update-ref` is
present, and correctly initialized. This was the case prior to git
2.48.

Actual Result:
```
$ git rev-parse HEAD@{1}
warning: log for ref HEAD unexpectedly ended on TIME
17dd31aaf89190a36b8d04136a1a0f83fb37da4c

$ cat .git/logs/HEAD
0000000000000000000000000000000000000000
17dd31aaf89190a36b8d04136a1a0f83fb37da4c AUTHOR <EMAIL> TIME  commit
(initial): A
17dd31aaf89190a36b8d04136a1a0f83fb37da4c
70d9116663eee9f01065c3a6d8984b1dea661f20 AUTHOR <EMAIL> TIME  commit:
B
0000000000000000000000000000000000000000
17dd31aaf89190a36b8d04136a1a0f83fb37da4c AUTHOR <EMAIL> TIME  reason
```

The `old_oid` field is empty (all zeroes). This is only the case in
derived reflogs (in this case .git/logs/HEAD). The reflog for
refs/heads/main appears to be updated correctly.
