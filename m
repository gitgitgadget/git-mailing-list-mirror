Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0463A4515
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620234; cv=none; b=Lrk3ZkFtBoQnKZpOBLcRcvlC9UlL+VGaO0rhpWUD/OjSE3U7wJdl/bvtkHo+99ky09Zn/Vl++VHVMgnPJ3IkKEs8KUUSIQ3uCeRR91JIbbiffLDbx5yuGAs6z/QmOby8BsNZdmEMoeLJhKpHz8YteypnQpsC+q7zs97dz3oO1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620234; c=relaxed/simple;
	bh=la+rgTbSwP8F7pF3NO/CvNawry5eCy7+HXoJ1+982Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGs0WF8lRzKHeHmBlQVBJfrq3qSt5Xtw9iq4ulugElxWIaWMXWlm5IxB9ul/frFQkMyATlkt6ba+mSH8jeN4JRZeCclgkUzsc1/p6CBWPEsN0lzsbEYYYZ0uYnpzjGOce5qAyoXC4P3igZznUWQS7DJdLUvbnamvkFL+fw743bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvAsyE5a; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvAsyE5a"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870778358aso80593841fa.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 02:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772620231; x=1773225031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3YjFHRW4DaXXlALrlBiKWpJSmq+UajUcIk6XgLyhJ0=;
        b=FvAsyE5ayfz/S1xOSLeVukzS6kMCbwKmYi7RcHNYmP9jE0XCia+HSID7EOatYxA3Ca
         5fdteDhd4PV9g+eVjLhil3FgPYrR4Yz74JQhj+FFuY7YdoFoI0aGJdHv7t/MR2aDJLcR
         IX6zdkiqesGWVVoW2qxm1Vcdi1ybW0RpB2qho9fifuBsFLrazySIdku+R2dwgmGAwZo/
         aNGuUpaDiPyQ9ssuixrp5iaYOAbYENQdxpkIEd+qlwVwUFB9XmqmI+EP4SXQA55tNgL1
         yeBm3sQBy2UhVSRpZfUVB6taxg+bh2FGglCVDjj2yV44u2IRrScrJmoWQwQpOOeurLJG
         aDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620231; x=1773225031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3YjFHRW4DaXXlALrlBiKWpJSmq+UajUcIk6XgLyhJ0=;
        b=UV3KBB72Tbc2TqO0xVoceK7wWwDnXSkErhs8cmEetvIWE8mf77orx0WQRpdc/j3m5Y
         vjTAOsULbCCLAe+1bDrABOwsphfCnVi1QfjwQOVj9jrEhDwb6stAYkZTl9lXSTRgNF2H
         MxdQq/A7sHaET7959V7jquad2uCtHxaZsUom2K8eBi5eOp63fXskRMAXmyouLpyavD7J
         EpuAvW/PcTuC4o0ZFpVsjMs0x0csFQ7r7paztMzvJKSwll8xmG9xu4FBw6pNrDKhFvGY
         /t6pI7XGj640+lhaBciu0NzfHcMzggvo8huFkFyf5HBYb3uplbUD9MIPoOctuoFHazDK
         5hCw==
X-Gm-Message-State: AOJu0Yz8YPbT6BxYfyR3dp09mso89lFRnD1OgrwQVyvSD3BtKPJLyee8
	FZlxqVWij6VAa18rzpPRrdhmZYIIfTSoTbgU0F1pESpmwMhVzM3DNsIjy+g5lQ==
X-Gm-Gg: ATEYQzyNYrPnwZQ23BX2CWCAfFASpgURO5+/m3Zq+9PRvR3vnmozQguYQFLwrMqB4qQ
	Jogo/C9tuHhca9u8HT8vu8dVt5TuigGsGN/pLRr+pj6eGmkF3Dw8RLz8opOdHv8qLYVS0Y55Ctm
	h6rMFikHQMYQmZBIcA9DOOO4QBS0rG+uQ1cPylXL6gdqLZKVEuBWwdSMV3biWCDfpAd1kK0P9bx
	li+BuUzrq1dLJ5D2MszzMzVkFp6L5bTip9PKnfvzOCmvrA6vQKk1JuJEa1rUGC6gdR7WAErUFOX
	Jv80MlaaOb3tOsiUpf7mj/b/WmuBtJqaJZc19EQk/H0BH4aHhNt8vYNdKiP7ZZtFCe7PmbYz1We
	tl/QM/Qd00q5S/MK7V+eNELKGduEV2Yq9OqmbNnkLmlp/d/TtKqkP/s8ilOJXt3HoTsGmeEi+g0
	BIaWjLrmnA2ymuYkUL835+uu/qKrXgYEhlykzzl6ccoa7AzPRAC+woOvaB7NkwGSgSr8CmfHLHQ
	uEyS2bHaePHRA==
X-Received: by 2002:a05:651c:995:b0:389:f5b4:46cc with SMTP id 38308e7fff4ca-38a2c564858mr13042701fa.4.1772620230742;
        Wed, 04 Mar 2026 02:30:30 -0800 (PST)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1273cf021sm706544e87.4.2026.03.04.02.30.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 02:30:30 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v30 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Wed,  4 Mar 2026 11:30:29 +0100
Message-ID: <20260304103029.8273-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pi1wzzh.fsf@gitster.g>
References: <xmqq1pi1wzzh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The above two uses ( cd test && git $command ) to do what it can do
> with "git -C test $command", but the rest of the script seems to
> mostly stick to the latter.  Want to be a bit more consistent?

Good point, will fix!

> We see only one because... @{upstream} and @{push} are both
> origin/main and we can dedupe and there is no extra advice needed?
> If @{push} were missing and only @{upstream} existed, we would also
> see just one, so this test feels a bit under-explained.

Renaming this this now to clarify that it tests deduplicating. Also added
two new tests, for when reach of @{push} and @{upstream} are used alone.

> One thing the "advance" function does is to call "test_tick" to
> increment the mock timestamp, but the incremented mock timestamp
> would not survive beyond the end of a subshell.  Not that it matters
> too much to have commits with the same timestamp in these tests, as
> long as things are made more reproducible by use of the "advance"
> function.

Yeah, it's not great when used with subshells, I ended up differentiting
commits only by name like 'advance work2' because as you say, otherwise
they will get the same commit hash.

> I also am curious what should [jc: ditto] happen when @{upstream}
> and @{push} point at the same origin/main and our current branch is
> ahead by 1 commit.  The pull side would say "you are ahead of
> origin/main" and stop wile the push side would say the same thing
> with advice to push it out for publishing?  Or should they get
> deduped?

Jumping in altough the question was not directed to me:

When behind and ahead of the same branch we show the "diverged" message,
and since only one line is shown when deduped I think it works in a logical
way.

> So td;lr is that the tests in this step mostly look great.  It is
> just the semantics of "dedup" is a bit unclear, without a test that
> makes it clear (like the "@{push} @{upstream} @{push}" one), and
> perhaps a bit more documentation how having multiple tokens on the
> status.compareBranches variable affects the output.  A (n easier)
> half of that additional documentation could be as small as the
> following, but I didn't attempt to deal with the "dedup" part.

Will add documentation for the depuping and a new test case.


Harald
