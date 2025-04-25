Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E17E9
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606529; cv=none; b=lv68Km0ZJFyLC5/mvMG9pgTqxdkdgQuyFEDQHlzSMuES4NagzLBbbsXG6MnAJeP8ZaiFsoFwYRtqvueSmNd4zkOrouHGNIl/Yxg7c8xvWBNH7ZqO4NNTnQefU90lf35bRfGwKVd8yfc2lR/P2EKCOJX14ohYsrmlbbb0360+dBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606529; c=relaxed/simple;
	bh=5GTCWHe305vhmi375HF+c7oMgq5rIpmMOyt5O6muaYg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LqGS0zIbQkruEeHyAyvoxE/jnx70173jcLU9Oc8DameKox21pzsXhBHKVGLRkglHUD9baka0LSpXRx9rU653SgqLUA7S9UOTng0PPoU+9fgCV1WnbsE14kLEHqXjtMf1FFCf7r1NfRQfDhvoAwM5vd90MO/sCkblJT79si4jw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loq8CPh9; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loq8CPh9"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7082e46880eso25407967b3.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745606526; x=1746211326; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qj7KPAcPmxFW/GHTu7RCNZna9sS/LsZDcycX2Wqjw3E=;
        b=loq8CPh9P+/a/eUbHz4DSdDR4teEu5bd9A5o8HrNzmAISF3RiQL3JyhZZMQlvNu6n5
         vAW1wUteLY/pmYqBDM9rZ54kTQ45ZwYo/vXfwCnJuc3l9e4RLCAUnkZ8trbBRVA9116w
         mfgd0OYamtVyM6cqY0EQeVokL0mjHaFPi04NQC76hIQOTDDdnpP30vrK88xKuEbEOhMb
         mJdGSZREgy7G5CgfWqVr7Y6wBGYgrAxZ0YA963gW0TTRRiPCWM5qhNdmHSV6g/eUyqKA
         jsW83niiIDZYUwq5hyeqecojEZ0GAvBBtC5RKXxJ8QvLV5IDNVort56aiqzV81OGoCYb
         laaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745606526; x=1746211326;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qj7KPAcPmxFW/GHTu7RCNZna9sS/LsZDcycX2Wqjw3E=;
        b=m9T1l06e9qpOE86hLjtZyvJXy/zJynvVYPG6QqBpx2pP+0o5JzktmBt27LJFZD15jj
         VrUXWDAqicAVUaVsfVI3Nw7SRdnyx9B58MEqSWR1p04kMxJgy5UAq5wvy3YsmTcOoCnl
         h0+9ckefMeDj42SOGAncKh6pUCRHshSL8Gx/nxX2NS2HjgysYVe3PdDdB6Y+q+s69SL9
         wsGS1mvyx2bVP7eMZ6SF9RT211QNMLRWtJ9LBfMGikEW3JkIYXx2arWte5yR1gceY9VV
         LLPt12wXCZtlJ/buzut+Qp6YMRDlCFLIIIQ7tLGER+gonTO/ETptBU6eTBiWrjp1JNBU
         nSDw==
X-Gm-Message-State: AOJu0YwDvD+NZGGlXLqnPTviPEjHthH8+l3Qz2A71E30sLWgMXZSfuDE
	09BGIi1WHv5ZUU4XsZHXcXMaa9/6XEgPoixV4ZmcMSd/Qfx5cv0CBL19F84wEYTv+PCUaZDoG0P
	QtI/RcYRHr689O/TvIjHXfvuGSajLWW7acTU=
X-Gm-Gg: ASbGnctQIHY6XPdA5qvaa4SRzlIG3hAVoW2/74CD5LkY8PrT6u15mmlQ9nf5EnsAfB1
	pW5N7uPfiwpDoLGX19VXpVwsOvT4D4QFk0GgsCrAk/benYEm/m3AGTkmSabVMAfe3EcY6dEQYl2
	aTOZHNIXwJaHgCheHTf+0qOVnwOUzmzTw6VEQ=
X-Google-Smtp-Source: AGHT+IEL+aPL+6JS+oSHdGPj2iaDXXJ2Fd8AlNa4qq34BPf9q47sKL5Tca6PHFzlm1ZWOzJsF6S0Hjvqo2/Xk1ra2do=
X-Received: by 2002:a05:690c:744a:b0:6f9:b12b:8953 with SMTP id
 00721157ae682-7085412f30emr51425237b3.20.1745606526407; Fri, 25 Apr 2025
 11:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Grosser <grosser.michael@gmail.com>
Date: Fri, 25 Apr 2025 11:41:30 -0700
X-Gm-Features: ATxdqUH8aVigU_HSk3aKRDP-jyXDh-uSIcB74NHnZL4zFDvR8XXtNrO0t1pZbMk
Message-ID: <CAAms34P=fuow0kvxvQKxbr0jhqjnBu=VsP=xAxDieG-QA2ocVQ@mail.gmail.com>
Subject: Feature request: automatically read .git-blame-ignore-revs or allow
 global optional config
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have many repos where I use .git-blame-ignore-revs,
but I cannot set it globally because then I get
```
fatal: could not open object name list: .git-blame-ignore-revs
```
so please make it either the default for `git blame` to check that file,
or add a "blame: ignoreMissingFile: true" option so I an set
```
[blame]
  ignoreRevsFile = .git-blame-ignore-revs
  ignoreMissingFile: true
```
and can use this feature without constantly having to think about it
