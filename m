Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E5242D79
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766952979; cv=none; b=uZJokcCu/cFtrTh+eFLecLCvMDe7I1mYtlaSQwPpY3C/do8nUcbnuzQeVXjrePFfkg1bBGrVQBWisII6qg4JPUgrQOxoLR68lhoVJLL/D/MZxu9EWgU+PAnhB+qZm+fn+VrqL+h2MN3n3t2X91Y6h5OYBmNksqaAjVzbFVUNEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766952979; c=relaxed/simple;
	bh=ed8xpDAUsLeaCRpDnjz1KIjAM0qxJz/vzInz8ozXasU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZooAqYGlalSgNiS9KByS8cFxSHsxEJfx7CUr8oWjA9mCP8HFHJxbSHvHY3QhwDq4FBUCdt6s1Cf2SOqdUVG6LUXKrH6ykJl0nw8YL1GYPX9con5KT1V4ZtmFO+gesVsraZFUjPAeq3eEFLnQQjyrU5AVRxHazfrI7IqCVUqLBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKggVgam; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKggVgam"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so54039971fa.1
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766952975; x=1767557775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed8xpDAUsLeaCRpDnjz1KIjAM0qxJz/vzInz8ozXasU=;
        b=OKggVgamn4g4BGVx6/hwaUfwXxF6LpMzNgCHLjSw0mzY8T8EUEy14nI3H5APX2DE0W
         0jrdBhZDdBaMPbzpJICZJXP6SgUB/o5hJ7Vz86Ffe0DpoMKBv5PyUdAH4XDx215gVZq1
         /SUhMxw5IYwNnMCJmglPtW74e/jVBf4HRkDwpb4wye8Rsw4xbTBLCOA/3XMk3kgmRg/9
         3WGGcPYeK07khojIN4MmTDCOoH04l7fSGFyPi2PhPzpvYDIfOo0PAAa4h7Js6P79W6Ik
         B/7yD1BRsdbjZEjX5Ke2iJgB5P5rexujz3Ri7yNWUHows9hxgB5I4tjWrB8Trt9s4wUR
         jIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766952975; x=1767557775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ed8xpDAUsLeaCRpDnjz1KIjAM0qxJz/vzInz8ozXasU=;
        b=lzWZLuqxbdbTq0g3G4vhO16hq/5eKmPA8sYknkp6ceCzItd51rDBU/BsnP/83byy+1
         UgLI3BZik237C7/gP0qVqtXGu9XfTYbm3WaAah/K6fvKGfeF0Ea5F3r+afjigLgPT1hT
         HxE435uCr7YLiq/Jtrofp8UuZrGi3gEFSMR3OTOyv0c8/foSP4DOwu8DbrGc2BRrMylX
         EJruC4SfI30u34CA3BaSWM1xthmOU+eqiPQmU6VWIoXHDM88p2yuQJm7YUe9XtSQygsG
         qbVObobyNeVj3V5PG7yJKYHVaxmkCWcL2sSEeBp1bTkVPjF8YuMnaTLWFL8PpLaDVcx5
         Q0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWmw4xMDrnr+6bkEjojhIsx5ltYnoTX49r8/eJA3M2lgd7AlunahiccG+a+T3pM+1kQqhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqLSdhF2OaJF4ySdXAgZtlv+hGjlzP/adAdTYRTJF+ziQZXuE
	EFli7psk2n8nRteJ7eccIdz+svtdAt4isJZNsPBzmxq8hpMP/wQR5y9/
X-Gm-Gg: AY/fxX49VzBRkrrlXMeB+ROFb9G8kadSqHRwscTM4Q7sn7iN5VzBNROGDxlXX0/pJyA
	OraZ8HYVr801otRBqvRq6GNqU8LV6U90PWyuusgNRkOH2IwcTRVmpatS6pn9EFzl4FjXhxh6nFP
	7tRh2IhTq7g8bxmLx+mY6qO3S9scdOD9seyZqN6vYBYG9EWV2xgvJz+yAr7KuhJ00y8Aq6NLK2+
	51fcobYEdXGN+FxhGK2/A6XQnezSegNc18QgbsWAnTcIJG8r6Gq+ou1XPezJPVc5AUZisgBxpCV
	MIBJluRukzgCL2c4IeEYXuo0MSBx5LrBSetWPvD9aqoYS7f4qyvJ7JgaQMaPVXrYrDWUPphdoEC
	QgzNKnNa8AGfXAUUruVM1AVDYyUB6lQf8TzSzijUHszvohLCK2MYgDleNb7EFc1cX3cdoQhYX9C
	Te9nceN/XWd7QWLJC6jz3Cnhfe7U3lnQ6mXYT0Pbcb7ssUqaNxuCq0wqGBGlVQED7RuBZMSmA=
X-Google-Smtp-Source: AGHT+IFuyVHuqUNlw5zG7ki9pHAm6DoxAYkNoICHxEFT6wl1OVW1bYEUojmZ26M9YGGI3CMfY99j1w==
X-Received: by 2002:a05:651c:1546:b0:37b:a664:acde with SMTP id 38308e7fff4ca-3812161c9bfmr93322201fa.32.1766952975267;
        Sun, 28 Dec 2025 12:16:15 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262ccfasm73301981fa.26.2025.12.28.12.16.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Dec 2025 12:16:14 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	sandals@crustytoothpaste.net,
	ychin.macvim@gmail.com
Subject: Code review?
Date: Sun, 28 Dec 2025 21:16:13 +0100
Message-Id: <20251228201613.83476-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqbjjijt2u.fsf@gitster.g>
References: <xmqqbjjijt2u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

The config variable solves to problem of finding which ”goal branch” to compare to, which I otherwise find unsolvable. I took it from the previous discussion that trying to extract the default branch from the remote is not a good idea.

Is the solution through using the remote/pushRemote?

If that’s the solution they are set per branch (as I understand it), so each time checking out a new branch this ”goal branch” comparison would be lost and has to be configured again. That ruins the feature.

Looking at the git repositories I have on my machine, none of them have pushRemote set up. And the remote setting is pointing to my fork, never to upstream, I think most people have it like that.

I appreciate all the help so far! Happy new year!


Harald
