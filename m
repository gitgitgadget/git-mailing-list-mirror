Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3E333433
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048552; cv=none; b=YUFb2ElRWJHYNMCdpJXGAtbkUGDcHgFFFUMGgaQ2IHIr9mk8aloJ1rWPzw5aLMQVP88DBYNoolrSBM1ONkjycUnOXoPUPfzui7UfjMcMpIgpvsIIk3uUjyuQu5Y4J/GWyI4F3u2YscPTt96unKrTt5kQvYNCAWBDP5zPlLEZqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048552; c=relaxed/simple;
	bh=CwnrmoTiiLl4T2kPCFUMWeFe0FaiozH4KoJ4zRwXv0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB9oR4HIdu9MX+6faVg0ESUHmmJcZop/9jJ8K8IhnDb1U4PqG3bkWTnCj+9agNm+bogwx5p0w8/9E156KIfduNcrTtdgYDJaBsVx4tpxWjcXE9+4P4G31VFA5gry5YGtrdftYg5WIhK/7ubOXb2WBLfMa+NNSn1DAJlgcAXd9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710ff3ae81so19829455e9.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 05:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048549; x=1761653349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUd8Y25AxOXsgkziDoPVjD5ZxQpiYcQnknh2k/RMW2c=;
        b=qDEoFaYiynUlOFu9D7/XjtCdK/iTigA0wbjhtNU6xPVz0AnW9RwZc5Vysv/g0n7WqY
         C6S8WyXbludTW708lfYa9Rhi3JVM3AmfS5siJu75vlO1ThcGANanX02OOG1KAES+zyGZ
         a3j5ywNTJDGT/Z99OKj6SYS6LnqouEwfTILR6UWe/8irSGa2N8Vt/N1soeoMsa8JSIZd
         02uHsweudoHQy5L4U8PlCppPA2tYTHL+iR7EAbS3sSS+UWVZ4VeUXckPDZ7Mpz5OfRr6
         drEKZGoA5ZWGBqo/dq37WVyeKYP92dmL1f+/PBGpvNLrgW22eypqJZgYbbDnC5FGnRh+
         30TA==
X-Forwarded-Encrypted: i=1; AJvYcCX9/vHJgLVQhhb70uTf3or+r/yqJR8ILYA5DMjkTbba9kjVseRQYSTePbi8PcY0D2t3Sqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqdsg+VOSXO2d4wDUmgT/KBIv5HK8IiQC6yimRuEK4XH+F/Uj9
	gJaVHXx75TZ/Yshs5r2yXTo/056mU3VKYZCw6VAKJh3pZbxxizJJHJhL9/ONrfhDc93ElyZFRnU
	MqwbCX08NPe6TvdvJmNxCQLYcf8Oel2I=
X-Gm-Gg: ASbGncvVGxa7FIl8aYbXxYM54yemeC1r8KSsYfRgFTyntb/FWqFiYqtT7OZmc6+h17r
	+vvKEB5pVG33RM0+WW1sqlWkcnqFhZj0nRhSmVxBtYoli5Bd1UVjmxsFMhFZek1gkPc6SUAnyDH
	NfBEpTjeevAEeu215VStWRwRO5U0Yblj3mlGz10MDQvQ7S9sKSMu7wgpHxzQte48j/FcIwVEfwL
	DyitjfmOK1oiirWiWN/nXMCKuShA7tmU6tbx04V4caJotxtcTWVt8azUl/02Z94XjCI0+f6Gxhb
	QsDh83c=
X-Google-Smtp-Source: AGHT+IEm6/RhOnfcFyAabHQPbsXMfZQeeehIKja0EHQMZr/EeoN49qdlKYrIMt8Tkc+ClFpI6ULgCdH/n6umZYSscRQ=
X-Received: by 2002:a05:600c:8b66:b0:46e:32f7:98fc with SMTP id
 5b1f17b1804b1-47117911ac7mr120039565e9.21.1761048549094; Tue, 21 Oct 2025
 05:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BEzjk0PLEMjtk-0jQOAag-s_iJkKMbcU+o5vv8BzRVV2A@mail.gmail.com>
 <20250916145032.969133-1-phahn-oss@avm.de> <CABPp-BFxqJt+2HbY+d_qdZ0w=UDaL_u4MzO_3cpPpArQHREBJA@mail.gmail.com>
In-Reply-To: <CABPp-BFxqJt+2HbY+d_qdZ0w=UDaL_u4MzO_3cpPpArQHREBJA@mail.gmail.com>
From: Erik Cervin Edin <erik@cervined.in>
Date: Tue, 21 Oct 2025 14:08:33 +0200
X-Gm-Features: AS18NWAcZPmOrJycEMr6--eC9CfVgSZv42tqabKZ76CvTNK170S6a1Kc7xuQUY0
Message-ID: <CA+JQ7M9svLSV_CSu9OK8hO7rj3GtMQA953tTP=AOta40JTCNCQ@mail.gmail.com>
Subject: Re: --shallow-exclude=ref -> "ambiguous deepen-not" error
To: Elijah Newren <newren@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, bolide2005@163.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I just wanted to add some personal experiences to this thread.

On Tue, Sep 16, 2025 at 4:58=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> I have a use-case for this, where we use GitLab to run some linters on ou=
r
> merge requests (MRs): They examine the commits since the fork-point "E", =
for
> which they need access to the commits + trees + blobs. Some MRs are large=
r,
> some smaller, so there is no fixed maximum depth I can give to `--depth X=
` and
> be sure to have gotten all commits.
> Same for `--shallow-since=3D` as some are dormant for a year and many oth=
er MRs
> by-pass them.

I have a very similar use-case to Philipp. Except my forge is GitHub
and not quite the same challenges w. temporary merge commits.
Basically we run commitlinter on origin/master..HEAD in each PR. The
GitHub action does a shallow clone with depth=3D1 and it looks like
commitlinter uses git log under the hood, and as a consequence ends up
only running the linter on HEAD. I found --shallow-exclude and thought
I would give that a try (to make sure we have the commits
origin/master..HEAD). However I encounter a different issue when
running the command

  # Test 1: shallow-exclude=3Dmaster FAILS
  cd /tmp
  git clone --depth=3D1 https://github.com/git/git.git test-master
  cd test-master
  git rev-list --count --all  # Shows: 1 commit
  git fetch --shallow-exclude=3Dmaster origin
  # Result: fatal: the remote end hung up unexpectedly =E2=9D=8C

  # Test 2: shallow-exclude=3Dmaint WORKS
  cd /tmp
  git clone --depth=3D1 https://github.com/git/git.git test-maint
  cd test-maint
  git rev-list --count --all  # Shows: 1 commit
  git fetch --shallow-exclude=3Dmaint origin
  # Result: SUCCESS, now has 43 commits =E2=9C=85

Originally I thought deepen-not wasn't supported by the GitHub server
but I was very surprised seeing it work for maint. No idea of what's
going wrong here actually. Some searches pointed in the direction of
changing the postBuffer configuration (which seems odd).

I'll probably go a different route but I wanted to share my
experiences in the thread as there was not a lot of information around
which helped me understand what was going wrong.
