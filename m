Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C662DCBE6
	for <git@vger.kernel.org>; Fri, 23 May 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036208; cv=none; b=oDqomsFg4nxj4i7+pp1gyIQSkVtSIG7HmemMS7DAeLj1e5e9tNTnhMGz3LqS2MBJsZ59hNrhHvPJ6l3vQdXo2E36Eg9O8XHikXAa0jDqESNlf7+e1SI9FnkTJSYGkjzkCH0yJqAAMeqoYqVZOTgeqBm2ZeOF5OIOyKtmw54G1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036208; c=relaxed/simple;
	bh=57v4xHoTem05Hw7N+ReczKm/olsT7inmj4bPRpH/E9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzUFpg4ajgn2m2MG0/FG8LVhgk0fJAEE5fNVUg1PExwpoC3EBAW31gKAZTd0PQprocUj6yQxOwoCZ/EIXY0Y724yKwX4RQfyNYPJ31dMV9Qlkit3Deo/+QVCTHVjlQyyDNLw/80wTbRiK0C70QnFMfyEZsDoheiJXhNxSGd+Plo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7cd34b6ba10so3786285a.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 14:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748036205; x=1748641005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIPiE9fc4arXaz6BYnWbvMzVBjS2zEZf8KQ+aI6EgUU=;
        b=dpLdR615wJY09dmrWWEC5A+Xm7MPzZM7xTGVokHGBf/4qSIyJ0zwAmb9NrTfnVvOBQ
         tDLam69L0mDbL281qqWaCQizq6GU007nHQZMuDtibGk/hyfZMcU8ylIED2iKk9ohIjaO
         Bd7DL8mptTWZcNZBqVTYJjFe0wnX1L1KxUPpZgbZN/qwiqp6MRdfRuaq4AJyI+ivXg3c
         ww35laqJV7bPLNV0QiWlTWJhPrACOb774qoG2B1gqDHs2lAmFzN89M0r8k5jdf9LSbKB
         fu4vCL0DWVBdmZJlSi94PT1OQeDEbL8qE63+IS5aLKFKjigB19CJwHxE6K8YZ5EFT8zb
         ZZCA==
X-Gm-Message-State: AOJu0Yzu8zwrzFLDINbudvfJDqMh9J8QUWiFK5RNaHmmW9jqxtOBTJzd
	DRDgBLPVRi1cbx5rxjFfrgvvxZrTJC4lT5NJN8iVPkDzkoYBMsaQbv5nCHGgq8O2RUh0j2B3OZg
	dDY5atG5Zf9bwF3ZkRsq7ecbpIzDtAjM=
X-Gm-Gg: ASbGncvoEZICZaFaFIBxwWS+kOGionOpLlzrJMR6Fha39LIRCbnHJvAX3bRnMyO8hL2
	lkNqs/jBtJ0xh181vcP/ZL7pT03MrKBA5nOAdfNvhQnPXZNZsIyBQEe2JR7GbXEALK/Q5akAUDD
	0bkjb0KKryv0IOxtm8h26vy1bGf2l8gVPqsp4YVdZlBgfR/Bj4zzyKczklpzFSuKqI
X-Google-Smtp-Source: AGHT+IHZ8CLqfSA1lj5LnnIi7XJxvKGr+jk0moyCp5+YNmNIfg3IthrEOeFy8XNz9Db7fQ2INIlKlUX+u0aIIiDOvng=
X-Received: by 2002:a05:6214:2022:b0:6e8:f645:2639 with SMTP id
 6a1803df08f44-6fa9d30bfabmr5836516d6.5.1748036205490; Fri, 23 May 2025
 14:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523193722.68344-1-mark@chromium.org> <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
 <88e8231f-7c08-652d-f734-22c4632aa728@chromium.org>
In-Reply-To: <88e8231f-7c08-652d-f734-22c4632aa728@chromium.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 23 May 2025 17:36:34 -0400
X-Gm-Features: AX0GCFtf6YIHOoAUeW5xWpyPpuoANH2WsVL0y4RDkHbYeZX00y8OBcIFgJDvGUw
Message-ID: <CAPig+cQXdhT2R2_D7pYBRgCUPLtbmEK+ta+dd9EByk2i3yBkaw@mail.gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 4:43=E2=80=AFPM Mark Mentovai <mark@chromium.org> w=
rote:
> Eric Sunshine wrote:
> >    # t/test-lib.sh
> >    ...
> >    # git sees Windows-style pwd
> >    pwd () {
> >        builtin pwd -W
> >    }
>
> That MinGW fallback pwd ignores arguments, so any pwd in a test regardles=
s
> of whether it's specified as pwd or pwd -P will result in an underlying
> pwd -W. The t7900 test's behavior should not change as a result of this
> patch. If it's succeeding in some MinGW environment before this patch,
> it'll continue to succeed after.

You're right. I (stupidly) overlooked that the `pwd` function ignores
its arguments.

> > [*]: In the long run, a better fix would probably be for the tests to
> > sanitize the output of the Git command, replacing (via `sed`) the
> > actual emitted path with some placeholder, such as "%HOME%" or
> > something, and then have the tests look for (`grep` or whatnot)
> > needles using that literal placeholder rather than trying to perfectly
> > match the path emitted by Git. This approach makes sense since these
> > tests are about overall functionality of git-maintenance, not about
> > the specific path in which the person happens to be running the tests.
>
> The specific front of the path is not important, but the tail should be a=
s
> expected, and I suspect that it remains much less fragile and complex to
> perform this equality comparison than it would be to try to reason about
> the path's inner components.

`sed` in my suggestion was an afterthought. What I really had in mind
was perhaps augmenting the value of the GIT_TEST_MAINT_SCHEDULER
environment variable, which git-maintenance already specially
recognizes to tweak its behavior when being run by a test, such that
it instead emits the placeholder (literal "%HOME%" or whatever) as
prefix of the path rather than the actual prefix. Tests could then
just employ the same placeholder prefix rather than trying to exactly
match the real path prefix.

Such a change is, of course, well outside the scope of the patch under
discussion (hence my phrasing "in the long run"). The minimal fix you
presented should be perfectly satisfactory.
