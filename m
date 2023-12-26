Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977EE1852
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIqN01A/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e80d40a41so845318e87.1
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 11:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703618385; x=1704223185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJKXkkUVnxXYMAQc9/W6vwdTRw1DyO7UhgO+092SbUA=;
        b=kIqN01A/K67n6CVlcQxES3odv4jH8E6d95WypnRpyhkbDB20V9ANkGa/WVYjAhPHn8
         T+1lPALM0R9xeESLWE2yjnhzYqFTMzutYLBix0nqAL9xU/TiS2s0x754Bwukul+1Pixe
         vfyjeM1TW96R3u/PaxjqtN+T/N0Pynl5pJU2s1nVf78C3sXRkPp6qPNLZ+D9aJtXILRs
         +w+IS6kUePhXl+b+egK1Pqfy8i56pa2WvAoguKft+/JwDtCnl4wKu1MNHIjHt53JFCHO
         UMT6RkD9ZgCPFlOe8QvQNiustOEWROm4rx7LVrmGzGawbjKKEWEX8qFJSWLT4wYVsIuG
         x0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618385; x=1704223185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJKXkkUVnxXYMAQc9/W6vwdTRw1DyO7UhgO+092SbUA=;
        b=HYM3lvDywD3btzSWGOuAhl2iqjHnXR9UsH6BBWG/wqsm8y2AFrpILVegIYYd280Bfs
         8eXCK8SLztLBgJAxfwDF8LoiCpqnU1UiaxXhQXW5je0nQdVBL8XxdXNVHvv3oK/f65jo
         nEieNwbxiUhpBs2Gnr1BSHWZ7pV0wcNCPkpsh0q6xEAaDz/s4H7QDq/39E5YtosKItxy
         PwaYXWptUu26tjL3X2IwdPfHweu3HHE7gaDC9UsqoPGk9ywwSvIS6Sy9Y2dkOJ4O8iTA
         fwnvrtJ9aALO9zCNYvc5O60rEJQnB/hMA505YjpMjQ/t0S2X8nT/ULAYd9iumWULivxk
         YhXw==
X-Gm-Message-State: AOJu0Yy+W1S8aL0H8/vqSGsvO8vsjuwO+EDMd46Rm8h8ktJDjsPKd9uY
	N7YzxxignFM924CA+LLE53l6EIHePhdQ6nsKb34=
X-Google-Smtp-Source: AGHT+IFkKQzqH0LMPZJcSD3yJLtWCt6LCoQLVF6VijaHCO0qfPBp8iiVlaw8ea2n5EC5R67vxIgg9F/6E876Xvymv5g=
X-Received: by 2002:ac2:4c0e:0:b0:50e:75e3:10f0 with SMTP id
 t14-20020ac24c0e000000b0050e75e310f0mr1539638lfq.62.1703618385012; Tue, 26
 Dec 2023 11:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com> <xmqq8r5gj2o3.fsf@gitster.g>
In-Reply-To: <xmqq8r5gj2o3.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Dec 2023 11:19:34 -0800
Message-ID: <CABPp-BGSUytAZ+mCWRsP7NoHbO3sBBtnbeAs=UZo6eVMa62XbQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: be consistent with end of options markers
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Randall S. Becker" <randall.becker@nexbridge.ca>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 26, 2023 at 9:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > 93851746 (parse-options: decouple "--end-of-options" and "--",
> > 2023-12-06) updated the world order to make callers of parse-options
> > that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
> > do with "--end-of-options" they may see after parse_options() returns.
> >
> > This made a previous bug in sparse-checkout more visible; namely,
> > that
> >
> >   git sparse-checkout [add|set] --[no-]cone --end-of-options ...
> >
> > would simply treat "--end-of-options" as one of the paths to include in
> > the sparse-checkout.  But this was already problematic before; namely,
> >
> >   git sparse-checkout [add|set| --[no-]cone --sikp-checks ...
> >
> > would not give an error on the mis-typed "--skip-checks" but instead
> > simply treat "--sikp-checks" as a path or pattern to include in the
> > sparse-checkout, which is highly unfriendly.
> >
> > This behavior begain when the command was converted to parse-options in
> > 7bffca95ea (sparse-checkout: add '--stdin' option to set subcommand,
> > 2019-11-21).  Back then it was just called KEEP_UNKNOWN. Later it was
> > renamed to KEEP_UNKNOWN_OPT in 99d86d60e5 (parse-options:
> > PARSE_OPT_KEEP_UNKNOWN only applies to --options, 2022-08-19) to clarif=
y
> > that it was only about dashed options; we always keep non-option
> > arguments.  Looking at that original patch, both Peff and I think that
> > the author was simply confused about the mis-named option, and really
> > just wanted to keep the non-option arguments.  We never should have use=
d
> > the flag all along (and the other cases were cargo-culted within the
> > file).
> >
> > Remove the erroneous PARSE_OPT_KEEP_UNKNOWN_OPT flag now to fix this
> > bug.  Note that this does mean that anyone who might have been using
> >
> >   git sparse-checkout [add|set] [--[no-]cone] --foo --bar
> >
> > to request paths or patterns '--foo' and '--bar' will now have to use
> >
> >   git sparse-checkout [add|set] [--[no-]cone] -- --foo --bar
> >
> > That makes sparse-checkout more consistent with other git commands,
> > provides users much friendlier error messages and behavior, and is
> > consistent with the all-capps warning in git-sparse-checkout.txt that
> > this command "is experimental...its behavior...will likely change".  :-=
)
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
>
> Nicely described.
>
> Apparently we do not have an existing test to cover the case of
> "misspelt options becoming a pattern" that this bugfix corrects;
> otherwise we would have a s/failure/success/ to update such an older
> expectation, and have to wonder if the existing behaviour is
> intentional.  Since there is no such test, we can feel a bit safer
> in "fixing" this odd behaviour.
>
> Also, this corrects "--end-of-options" that becomes one of the
> patterns.  Such a bug was not detected in our test suite.
>
> So we should at least have two new tests.
>
>  (1) Pass "--foo" without the end of options marker and make sure we
>      error out, instead of making it as one of the patterns.
>
>  (2) Pass "--end-of-options foo" and make sure the command succeeds,
>      and "--end-of-options" does not become one of the patterns.
>
> Thanks.

I did actually create two such tests last Saturday, but they obviously
somehow went missing from my submission (I guess even if the high
fevers from Wed-Fri last week were gone, I was still more affected
than I realized?)  Anyway, I'll resubmit with those test cases.
