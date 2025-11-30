Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B2125A9
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764485883; cv=none; b=tdaANltbozHyIpX2y29befYcAPzOP8YWuEArn6rYc8pjAhkYmtGoN0BGKG/wfW65NMi7PYz0U5c5P2kcQfwCySXN3265jZEjrA60GBeBmzuliwpg0N4saJMMvJMFHWKcJ3sXNQZiTn9KTmBoowjNP25T9ub9/p72BKUBcZl20IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764485883; c=relaxed/simple;
	bh=cSUnB+XYsPF2qBMolAli6G659aad8BSkJ1Px8XX3PK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZNHnS40pnZYZn7tp+4nrfjxb24DMAcmZDyAg9X11ypiryNfo35PboJUawzb0OGSqmYk2Tru6dMiVOsQBATKA8sl2BDr0bwsiN9XOXyVfpugLITQN0qV0YJYzOo+zSjS54sXSz1z2HfAyPvy3eFMjtUfmeN1JgWgm3UMDXM0DpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2df1e0c10so53239485a.0
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 22:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764485880; x=1765090680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cSUnB+XYsPF2qBMolAli6G659aad8BSkJ1Px8XX3PK8=;
        b=wFFFo5P6rpUonWNdL1Rg2ld6ZMofgbqdRnhWl6Xgj0HuUVIztAoZyzYtIGyJa8h13P
         qXrAahEOy1w0E8I+PMXScgB4rd2m4JUDtUc9JklGz2wSk6dUfxvCY8wXdbU9WBcXI6E0
         nWs6Ce/elxxz/VwMzEUmhLwkMGVn4F7PxCDvacn3THJzf/Ygmys3WWgKOD0w0nwYHXUn
         YWCoOEXjhnbR0cI/4TXP2EoLtgQCdzDp6eS7X6q2ZJ9VemFGGVbhwTPCtzG1BkVqaDwf
         ZrdkWpwnyjh6blwTwni9htB2E9KrS9TaghCdMHlvfQ/vmzukiHRx5SDMEPRB3523ciJH
         1svA==
X-Gm-Message-State: AOJu0Yx85R8Mgwr2MZpf2cXL2rJ3bNqcHG6DOGyFgbeJGyJGfV1KMbu+
	MhPOS+ZishHAts05adK3NQx7ps14AxZeACxOrK6coRhDvT6K514Ce/HawGdJyvtat+T/KV4lZBj
	z9lCpc1cI6q3pBNaYpIEysujzAo9GBkA=
X-Gm-Gg: ASbGncuwvGL234rqz1hyNYTWuOsO3NvXwmR5WttlZjT4tX408v9X+PxCwrOVCiv3TAk
	oSYrT5fWgPbG8KhntyJ5Bck/ZJAKo64DzBvUSyvQ13XtIDduzWIifjm+3cs14Z2h0ntIAoSEOvQ
	X389vSnjmqpFJpD9X+OBIpm5WtDCPJZFijZuTSwfLCKWfw3caMrDDs2/wCQeAXxUvvcT2OCwfMN
	ANsmOc2YXWa5ZULqyFvNf9jzibYQWmPjWbSk55x1X50t8aZko/TaIpvqRE4HTZaiPHgETkrv+Xm
	QhfRccLnwRAIG3PksQzwVn0lQcO76Yh1y4T8c/g=
X-Google-Smtp-Source: AGHT+IHra8r6YGvvxErw+G7okaph9QNTLfjvnZn4mvTJkEW1NauLPdtg/q8nTFNOdDssLs7tVK+RsAL3tgxwzcE6PKA=
X-Received: by 2002:ad4:5ec9:0:b0:797:1974:b824 with SMTP id
 6a1803df08f44-8847fa72a8fmr384900586d6.2.1764485880098; Sat, 29 Nov 2025
 22:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <f7f1e91cef81068f3572b745aebc33d1d2a26c06.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <f7f1e91cef81068f3572b745aebc33d1d2a26c06.1764440906.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 30 Nov 2025 01:57:48 -0500
X-Gm-Features: AWmQ_bnqCcdUhUneulU3I-z6x3cJLs5oinhaFKt175ICwmMTK3pr4XrrIGhoCgo
Message-ID: <CAPig+cSKmmSewLYp_zAk7y+y=STxPjvG9f5LzrmTbtvNt_AoPw@mail.gmail.com>
Subject: Re: [PATCH 10/10] t7800: work around the MSYS path conversion on Windows
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 1:29=E2=80=AFPM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> Git's test suite's relies on Unix shell scripting, which is
> understandable, of course, given Git's firm roots (and indeed, ongoing
> focus) on Linux.
>
> This fact, combined with Unix shell scripting's natural
> habitat -- which is, naturally... *drumroll*... Unix --
> often has unintended side effects, where developers expect the test
> suite to run in a Unix environment, which is an incorrect assumption.
>
> One instance of this problem can be observed in the 'difftool --dir-diff
> handles modified symlinks' test case in `t7800-difftool.sh`, which
> assumes that that all absolute paths start with a forward slash. That

s/that that/that/

> assumption is incorrect in general, e.g. on Windows, where absolute
> paths have many shapes and forms, none of which starts with a forward
> slash.
>
> The only saving grace is that this test case is currently not run on
> Windows because of the `SYMLINK` prerequisite. However, I am currently
> working towards upstreaming symbolic link support from Git for Windows
> to upstream Git, which will put a crack into that saving grace.
>
> Let's change that test case so that it does not rely on absolute paths
> (which are passed to the "external command" `ls` as parameters and are
> therefore part of its output, and which the test case wants to filter
> out before verifying that the output is as expected) starting with a
> forward slash. Let's instead rely on the much more reliable fact that
> `ls` will output the path in a line that ends in a colon, and simply
> filter out those lines by matching said colon instead.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
