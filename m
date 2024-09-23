Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C1A2567
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118368; cv=none; b=F47/nzcprDRSC5qelsAyT//2AJiWPVjW51FAy54Iwvs9AWXeI03kWh8jsM/AxmITW40JVqYUQMykFyxdrfMeiJj2x+bsCaV7pOWgYVllev5WYTXpdO9b3896Q6Qww1d/GBgWSzjqjuuU71AQKVh9wNA+Ob6wXUuV9wsnyHpvM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118368; c=relaxed/simple;
	bh=dztV/E3dLodb60uTRU5Ae1WHvLLxV4LTy0FgqJW21Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulwABon0tmQgPu1bN4UkxTwXkB6q7NrKhz5OZbwyO2yKRfyTK9PTgD8lxTrjglTD+AJGnLs3ZHEIH1lnTb+UJyUO3fGD4MBWilX1c5G1QcqWOymLc1ATJhwN0u1IMLfQV/h4WcGGQM7PFg92e/I5mBC7GZKYoz+X4LYo+l4saWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c354ee1eeeso5617016d6.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118366; x=1727723166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72ovH/vtEzPdzO47JtqKOGYyfF0phZuoduCEZDKPt5U=;
        b=P0j+L5xjg8BX9/y3SN+NzyFKREfhJA3iXCtIseIAWHtdykehcAzm08hetH/Bu+bQds
         rAbFUB8GyRNC2aqOFlMVx18u5fY6+9mOdYOnx1NDd7gwCsLQXwfVvK6QXB8diyeIYXyg
         +zrGsWvyUdQ4weyO4x36dT+/pH3L9iqR5D0irCbHNvDBM0Q7nujFVg8umQUZQA8mro/Z
         6y/aRcKCDuIgsK+jkueTXS0+fep4+8ab74hVf1GKhgVQQMvbXVRmmNgthucy9j84QlVF
         vigiaT2xG0AZMe3CW3VkadlXypG6M97NU99TajZSWGOXwTEZTVk1ew1bQsvPLhYTz2Pk
         LY4A==
X-Forwarded-Encrypted: i=1; AJvYcCUoc79YpHYdJnc0GMCePm6vHpt7kD8p0Z064gUfc3YYwlYScm3KxdFz7eTtNjm2OnGgQro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2+mtj1Vb4WF/9XJOz86n1OROvpY0z/c0Wf3Q8GKYjc6tviIB
	ZD/7BZRPjKIFhpUhmEMfGGNVzE5mLnX0vD7eg1o1NCvQCiKPE0H3XrO1CfFCbf5PJZnhjLJHgtA
	sovO077jm3MZGwfxDh4mVtbq7KzIKItda
X-Google-Smtp-Source: AGHT+IEcN7w5LF67DhRlkUymMpWLCQu9d6SzO5+CyC6dLBYcl3DINHPmhC1xlVYS8PUabVwuhi4Dv46a+OCiTMwoaI8=
X-Received: by 2002:a05:6214:d8f:b0:6c5:20da:485d with SMTP id
 6a1803df08f44-6cb0e7e7ae2mr974226d6.0.1727118365507; Mon, 23 Sep 2024
 12:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110343.12388-1-algonell@gmail.com> <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
 <85ed3ec6-fa4e-4ab8-872f-6bd500b2bb66@app.fastmail.com>
In-Reply-To: <85ed3ec6-fa4e-4ab8-872f-6bd500b2bb66@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Sep 2024 15:05:54 -0400
Message-ID: <CAPig+cSErj4ZB9bHB8mZfzNkiaN_EpjT6b4b=cfsf_+KMqytiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:44=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> On Mon, Sep 23, 2024, at 19:51, Eric Sunshine wrote:
> > Depending upon how dramatically the patch series changes from one
> > version to the next, the range-diff may end up being unreadable
> > gobbledygook, in which case you may instead want to include an
> > interdiff ("git format-patch --interdiff").
>
> What=E2=80=99s the benefit of interdiff in that case? Neither
> git-format-patch(1) nor git-range-diff(1) seems to discuss what the
> differences between these two are.

An interdiff is just a plain diff. If you have branch (or tag) "v1"
which is the original version of a patch series, and "v2" which is the
reroll of the series, then interdiff is simply:

    git diff v1 v2

Thus, it shows the difference between the final state of the code at
v1 and the state at v2. Interdiffs are easy to read because they are
just diffs. However, because they are only showing differences in file
content, they don't show changes to commit messages or new or removed
or reordered patches in a series.

A range-diff is a diff-of-diffs. It is very, very roughly similar to this:

    git format-patch -o v1-patches <common-base>..v1
    git format-patch -o v2-patches <common-base>..v2
    some-diff-dir-command v1-patches v2-patches

It shows the diff of the patches themselves, including changes to
commit messages and changes to changes, as well as inserted and
removed and reordered patches.

Range-diffs tend to be a good deal more difficult to read (at least at
first) but help show the evolution of the _patch series_ itself
between versions, whereas interdiffs show only the evolution of the
_code_ between versions. As a reviewer, if you're primarily interested
in how the code evolved, then interdiffs are much more easily
digested, but most reviewers are also interested in the holistic
aspects of a patch series for which range-diffs are more helpful. I
periodically include both range-diff and interdiffs in my rerolls.
