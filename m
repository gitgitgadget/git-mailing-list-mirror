Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34540249EB
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTADBQHF"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAC19D
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:49:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4276908a12.3
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699051740; x=1699656540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoJ4ktN+51miNHsJ5GbNbhle8F8ELq4ZkDgFO650qOU=;
        b=RTADBQHFmCo8s8pURAGtV8vGbpodEdGnGzdJT8AzfYT7Hm6ZaWsxqhmrLJo1we/3s6
         I9yHOsvfbejrUahfTYkw/BpPIUbx54dkwiXHtMlHTUFRbiymfKmyPv5ppqoA1uOnsT5e
         m+Pl+D3jF5DPNWWaugHcgT//pgs+WTcFDVtpr6YuUZ1kgtp/SrI02ixH6bF8S9nM0V/T
         +dNA1Ces1AP63wgwEj/A6SISy/VUyHHu5WN5mc4EHepW+3x/rZGKLX6ZPcYr/OIlPlCv
         PEXp/MZwX4FPLiaKARBZepVcduTdc+ICuWMlyAqfg/R0RWmWnvskUqSk6KPlKcD7zA3W
         VEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699051740; x=1699656540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoJ4ktN+51miNHsJ5GbNbhle8F8ELq4ZkDgFO650qOU=;
        b=sty41zN4812YQEHRvjurAZvkNT5vaLTAcoJBZaBLimRI0Jc4IWk34E6FdmnUCeMTB8
         BpPFlKcchQWbSMbo1q3HRiKAIqtytXnnHOQkyeDChhVwAa7aydDLLMqb7QaVbQsHnung
         IcZ2CvSFfR8uJd0PzDGN3ySUQrZiQ77CjhVhjDkEEMufH7PzQVxONdHlRZi6EaNJkVRV
         +/4gwRsxSY2EeHlGCbPp26veJtTV4JR3g6dQv0MP1NzxifE7/F4unzf8HU9GZNVb1ewi
         NMUtlo/mS/isa4txSx0MBEch3h7DVV2IparGuo/7nevyioUffMxqKXhrl2lqVATmqfKf
         zfug==
X-Gm-Message-State: AOJu0YxVAWMVUD1t+tdZMVxSdlRP42zn5R/xqjD5qy9p5ikw0SlgRFF5
	kXFWyeNydKSthtFYrEEFGaMniI6pGux1JNsf48WAgJ951rU=
X-Google-Smtp-Source: AGHT+IHjFDwseTgMPMHUZce8UYqhZswsl0sQn53+T0cIPNsjMdNqH+NauEmnIcD514tmV6UcsjHIN+lWFFgzLKZzRZM=
X-Received: by 2002:a50:e70f:0:b0:53e:6da7:72ba with SMTP id
 a15-20020a50e70f000000b0053e6da772bamr19016640edn.38.1699051739763; Fri, 03
 Nov 2023 15:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa5rwo7u7.fsf@gitster.g>
In-Reply-To: <xmqqa5rwo7u7.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Nov 2023 23:48:48 +0100
Message-ID: <CAP8UFD1fZX=0_odDWPAAU2VbZ5GNVYZgY31OPPGeQriSSweUqw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2023, #01; Thu, 2)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> * ps/ci-gitlab (2023-11-02) 8 commits
>  - ci: add support for GitLab CI
>  - ci: install test dependencies for linux-musl
>  - ci: squelch warnings when testing with unusable Git repo
>  - ci: unify setup of some environment variables
>  - ci: split out logic to set up failed test artifacts
>  - ci: group installation of Docker dependencies
>  - ci: make grouping setup more generic
>  - ci: reorder definitions for grouping functions
>
>  Add support for GitLab CI.
>
>  Comments?
>  source: <cover.1698843660.git.ps@pks.im>

I just took a look at this series and I like both the idea of having a
GitLab CI configuration in the code codebase and the implementation
which makes things as easy as possible to maintain.

> * cc/git-replay (2023-10-10) 14 commits
>  - replay: stop assuming replayed branches do not diverge
>  - replay: add --contained to rebase contained branches
>  - replay: add --advance or 'cherry-pick' mode
>  - replay: use standard revision ranges
>  - replay: make it a minimal server side command
>  - replay: remove HEAD related sanity check
>  - replay: remove progress and info output
>  - replay: add an important FIXME comment about gpg signing
>  - replay: change rev walking options
>  - replay: introduce pick_regular_commit()
>  - replay: die() instead of failing assert()
>  - replay: start using parse_options API
>  - replay: introduce new builtin
>  - t6429: remove switching aspects of fast-rebase
>
>  Introduce "git replay", a tool meant on the server side without
>  working tree to recreate a history.
>
>  Expectting a (hopefully final and quick) reroll.
>  cf. <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
>  source: <20231010123847.2777056-1-christian.couder@gmail.com>

Reroll sent yesterday
(https://lore.kernel.org/git/20231102135151.843758-1-christian.couder@gmail=
.com/).
A quick review of the latest changes would be nice.

> * js/doc-unit-tests (2023-11-02) 3 commits
>  - ci: run unit tests in CI
>  - unit tests: add TAP unit test framework
>  - unit tests: add a project plan document
>  (this branch is used by js/doc-unit-tests-with-cmake.)
>
>  Process to add some form of low-level unit tests has started.
>
>  Will merge to 'next'?
>  source: <cover.1698881249.git.steadmon@google.com>

I just took a look at the v9 of the series and it looks good despite a
small nit. Also I like the idea and implementation, so I agree with
merging it to 'next' and then 'master'.
