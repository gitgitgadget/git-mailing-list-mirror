Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E103DFE0
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTbKcdJU"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D61B8
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:26:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso3912618a12.2
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698438373; x=1699043173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0hRJicWCi2UBqHFBzn0f8cMYYo0ShJfElCeiDf/V5U=;
        b=hTbKcdJUS/h9c9NphKD/9zxaHu19pR4VBn+Q4z0CvZ+/09BHlYyXElQUxSGGm6VPiV
         w20QrmSOiGYE4ToN0Gus6a2Xdoxq7SMf6K7HG0NSXkh+IUy1KL244dwj5UBzVOIwkTAI
         Ugv5JtD6ZAhHaR/gVsuICDVJqQkTxG5fql7+C7y46IaB393uLaNBh/ceX1b2Pj55Vfz5
         EpHPNRzeBqmJPXfqJCK0P3aoCw5Mcecxo5zJUQdPkCOE0HuTJImpihpO5UArZLQOIZpe
         CUVUez2F9JN01kG6nqqngyy8PIa2rJ2D09dUMN8bhEBmqUijBpzqLTzsNJZocaUKX58E
         0kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438373; x=1699043173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0hRJicWCi2UBqHFBzn0f8cMYYo0ShJfElCeiDf/V5U=;
        b=eK3OSOwwD8Pz6S/wi0FKNJnQFAU+oEfcKRUTdsiFC5cnCMcJ1Q2UDDkmB9xUHb6DE8
         NwTBRquJyRdcj2BlKQ7sFU0vQw16a6fXQX/HChanJnXdGMqcwhc/r7et1ju+OAv8ioJl
         520HdzMgaAVBCetRlni+K79QHOrvwVhJfNPoIJaM2DOFvkAJTR2C+5X4kI8w9kpT3ct8
         3F5T76KxhVT4hIDEmiHu/kQTLIKdlFt0TBqym7OXVGoXV7PE9loirtVLKwKM4JlF4Dpx
         DUD8RcpAZ68MFcVI5xDPxQKgt2vwZ9KFdblHl9L6IG58AFS9jfXn6ptu1IkGkLKm4UO2
         3UXw==
X-Gm-Message-State: AOJu0YwdzA867meqsaC7S+N4jS70Ge28/jIRca4k+UXPEWT8PMiJroEU
	IAf92P6PSD7cPK6K2+eROQ45AD4pqRKM+W9kFQo=
X-Google-Smtp-Source: AGHT+IHv/iWbdoe3q/cmlksnu4MWySypdLltkQOgJ2KL+fSs7+O8HfpNEoBGRYEfX4bF9ueqRLPWFQD+x88YrNI6OHc=
X-Received: by 2002:a50:d794:0:b0:540:97b5:3719 with SMTP id
 w20-20020a50d794000000b0054097b53719mr2923089edi.25.1698438373467; Fri, 27
 Oct 2023 13:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
In-Reply-To: <cover.1696889529.git.steadmon@google.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Oct 2023 22:26:01 +0200
Message-ID: <CAP8UFD0hBy=FufxiKfbUr=0M5H-oL4SDk=zKYRLw-vwq6+G05A@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Add unit test framework and project plan
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com, 
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 12:22=E2=80=AFAM Josh Steadmon <steadmon@google.com=
> wrote:
>
> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Unit tests additionally provide stability to the
> codebase and can simplify debugging through isolation. Turning parts of
> Git into libraries[1] gives us the ability to run unit tests on the
> libraries and to write unit tests in C. Writing unit tests in pure C,
> rather than with our current shell/test-tool helper setup, simplifies
> test setup, simplifies passing data around (no shell-isms required), and
> reduces testing runtime by not spawning a separate process for every
> test invocation.
>
> This series begins with a project document covering our goals for adding
> unit tests and a discussion of alternative frameworks considered, as
> well as the features used to evaluate them. A rendered preview of this
> doc can be found at [2]. It also adds Phillip Wood's TAP implemenation
> (with some slightly re-worked Makefile rules) and a sample strbuf unit
> test. Finally, we modify the configs for GitHub and Cirrus CI to run the
> unit tests. Sample runs showing successful CI runs can be found at [3],
> [4], and [5].

I took a look at this version and I like it very much. I left a few
comments. My only real wish would be to use something like "actual"
and "expected" instead of "left" and "right" in case of test failure
and perhaps in the argument names of functions and macros. Not sure it
is easy to do in the same way as in the shell framework though.

Thanks!
