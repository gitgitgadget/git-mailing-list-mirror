Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FF219317
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012445; cv=none; b=EtAPeR3OEhUNyYfxpybfFHisY5jvVmNbwlCsD4wDvn0VeRp1RHu5GFsGTA7X+oQyZfh2diei4deRliqlReWdE1gp5u0gsBEdgyOjhTWw3P7/smPZ4bZcQPsFn6VVJn7T+dVp8hLjQuHJq4G1/e9jF2jrnqMN4Jn53EVWl5aKvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012445; c=relaxed/simple;
	bh=42xpaycIRb1U9sMkNkbiY1uwUh/TMQLQBjw2AV62WfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ookahYcZMvnambwiiTwly7E6iXWRAYRxfDlVR0jeWEbmXNwbSjNVXBboKpA9ld+NRVmUYkK6c4ZBFCjqnwT3+lH09y+y1U8b5WbClcfbUqJi4bM8fQ28IfVCaSd//ATtxTikTlfOeO5xnMWxs0fUepRkYCM+TBn7hR43X863WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f9c5b09dso90996d6.0
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 11:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743012441; x=1743617241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAciESwmdcW22gldsTF55CkUHW8EZMW+8rhbHXgJJz0=;
        b=QSmrAIysAVR+KqvtL/ErZyxrNE4B1HRRduUPoqNk0OJ4R/DUAMxtLJ7x3hkijg3iln
         CFnRrS4CPyndp5plcIOu+BshClPlMoiLa2C96L1e8uFCW+lVvw2Cn1W/DPy+MMSFuWwF
         h07sYTuDBJW4lBgEO328dRLrBpcDMUOnxuO/oU3rsCUhVwCxvdy/WwZTq57VQavAILX6
         gXxkTgpLyAzBO/j7SMyM1hfdHWcoUpbj1k9Dod9XoW9IR/hwHBhX5rbF1WEW/h2rjIMS
         ePbeNWDhIIfXlF7UQX76qWqwT7tXC7oyapJFfQhtz10YZ480s7QQM6aSnEiiO0Sj6YUd
         KsJA==
X-Forwarded-Encrypted: i=1; AJvYcCV1xUy/DYWpwRiRVaikvcBcWKapJP/7o/rqupwpcYGV4+93/1mD6ECtOqQnTGrlOE5kjss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuSnOEAf1KQTL1uzOocUsmSLM3cpZP4bTdtYVMLjcX979Muwv
	wETvIvcO/NAYdrH0xLbueVmpYRaOWqpk6bi8rwEpXNPIxBuooQWfl6VfKxml+NK9hEevp1kx90n
	ryIMHBdkAXYsYyVwjZ3DmlZngnh4=
X-Gm-Gg: ASbGnct2kUBAZM2q8AkKbU5rGtlZJReXJcqnuHfQAv1QzS6kCqpq7kGqYR2EeTSNEcg
	DCFJ+LzRDSenR/qtGTyDQXhLrcZwheeRbdLUBzgLl7lSCmsH5KRqA5osWuLnUpKN6Ml7+EQGORq
	qhfwAqHDsTdEQxgdu8N6YUDJn7mSU3awJ6V04PbtaEDUQ6CeJNx0u1l5JMjvU=
X-Google-Smtp-Source: AGHT+IHsfkFeefVJfDQbJ0FjHITyaPNy7v5r7AZZA5deUiV5mbEQmKI2sK563ML5RWAmJFaJYogqyxdsq5W6vq3rCfI=
X-Received: by 2002:ad4:5dea:0:b0:6e8:8f31:3120 with SMTP id
 6a1803df08f44-6ed238f629cmr1600926d6.8.1743012441058; Wed, 26 Mar 2025
 11:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>
 <20250326174127.GA2508080@coredump.intra.peff.net>
In-Reply-To: <20250326174127.GA2508080@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 26 Mar 2025 14:07:10 -0400
X-Gm-Features: AQ5f1Jq_DOed1DsVvyje11-V1pSA6-p0RwijMTchKI2La77pqMoEDOM-3qnqq6U
Message-ID: <CAPig+cR+ESNg4tV1G6jbKKeRKABD053qZcG0BoFuQ7aC+1tGYw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] detect-compiler: detect clang even if it found CUDA
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Philip Oakley <philipoakley@iee.email>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 1:44=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 25, 2025 at 11:32:14PM +0000, Johannes Schindelin via GitGitG=
adget wrote:
> > Let's unconfuse the script by letting it parse the first matching line
> > and ignore the rest.
>
> Makes sense. I wondered if this:
>
> >  get_version_line() {
> > -     LANG=3DC LC_ALL=3DC $CC -v 2>&1 | grep ' version '
> > +     LANG=3DC LC_ALL=3DC $CC -v 2>&1 | sed -n '/ version /{p;q}'
>
> might be more readable with "grep -m1", but it looks like "-m" is not in
> POSIX. So what you wrote is probably safer.

It's probably an indication that I've done too much `sed` programming,
but I find Dscho's version more obvious. That aside, your response
made me take a closer look at what Dscho wrote and I noticed that it
is syntactically flawed, at least for BSD-lineage `sed`. Testing on
macOS reveals that this is indeed so:

    % LANG=3DC LC_ALL=3DC cc -v 2>&1 | sed -n '/ version /{p;q}'
    sed: 1: "/ version /{p;q}": extra characters at the end of q command

The problem is that the `q` function takes no arguments, but
BSD-lineage `sed` thinks that the closing `}` is an argument rather
than a terminator. Fixing this requires inserting a terminator after
`q`, which will be either a newline character or a semicolon. So, the
correct form is:

    sed -n '/ version /{p;q;}
