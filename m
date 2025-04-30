Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C234545
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000302; cv=none; b=La358oGIJotK6A8ZnX03AQQ1RW4CCwQBQpzug830y4UKtY1NKuMygcJjJeMOphif/ilnhKBMdR1VtL2HRvhy3+WwnR6uj1WA9I1uzpn/iJo/IHjH3SozbjFVihNMTXtnoN6utokwQbd+nctR6hgE9nDKpWb6QmeFa/x1A/bXXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000302; c=relaxed/simple;
	bh=m4SesHQcq/mkv7+rE0pP9xLb7kxWdK9kXWLHl5otFBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNuAGvxwh/A+KmmHa5F3256WdymFWRKitoYlF7zMus5vWh1PhVVVQq2P54Cfjefs80T4okWTq21Ox2Ir6jo9biQr3ECbI3pgoN5blnzqSMPZ3KE8FbVSKhbuOQRzxKBLbFXhJsk9XG4jBnS7jF7OqLaQLbfKNvF5jHzR/WFsJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtO/atBT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtO/atBT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d98aa5981so8912690e87.0
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746000298; x=1746605098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XPV32n4IQutMh7QesAd1Nvpqwp0RCrBvay5CtQK5H+8=;
        b=WtO/atBTzdcLHEv80EpcotcJ39hvlVctJmE77XrGrCMngXvFIIrXFK9NQowoJIYjHJ
         IoRJO5s2Tk2iUh7H7RD6sjrQNYmgaq20HL8j/iB+IyX98fV0q11IipOIO4LfOZIrRick
         +9GCHn6MVfb1CHQD5mMRuHUuaUbLYaTLt0V9W9Nv1byqDtgSsOEg1zRrxfkJlRW/hmQf
         Zp16oY8aG0b68RFXYPdmG+QuD44uHcWeXPtqNng0lYFTWIZLQ8ZK3G0nqWtgMD3vw/WG
         K2pDOWT7MgzIvcRtgfeh8uSWHZl3d3Ed+fHrzI03KEv4XkKPYP2NGJbZIT1VO9kFU4NW
         YtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000298; x=1746605098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPV32n4IQutMh7QesAd1Nvpqwp0RCrBvay5CtQK5H+8=;
        b=L96SHhBKVYvxTQnzJs6VdUPlIVQmW7K0SeXLJl3gso8HYgAf2cE33jBl+PU9VBp+nW
         W/SHWPX41uli+cFl8+QcjrV+AUCkBslJPsfISjRbuNnPuXnn+MMkks+O+YQDWKLQCbvN
         S5PlRXvRKmSOR1/9t7L5K15viWYijBeXLmHwtOjY4Mv+87dWMeDraITyanzMI82HndfA
         BwnTIA2rq07Vr4BmmgtwLJ1Vs90Qxs05OsA7NiGQzeja99f2sl7n5c+BYrYJpKT9hnot
         fE3kXHhtZIhnIeL3M6Uy8cGKYSFSGdn6ByoQk94XFvBFljvQYxUmgKzAPBCmk6KG5VaW
         S8aA==
X-Gm-Message-State: AOJu0Yx26HSM3zmhrCyUEF701WcLboyTrZFkblXKhd6YeN1a81ZoVSj9
	oE/dKAz2hA7LdDe1ZC9Xhif2V96M97a3WRS7vnODtjSYHTgil/lwbVfEAZtNmZchRPXiYet8++y
	xcXUDmSyEKRJf65SDLiEjgTlRPqPUFL/3jTc=
X-Gm-Gg: ASbGnctD0cNs1GMdMAw9EA7GRaK0VrWi6iV+Y1Po94PFkBjDEk7NspseSTQNjrz9S1T
	HNgYITVsixJU46CyNl2DZdNKg7SkVLrcW5XU5arCQRb6SOgmbHwxmZxqQP0jdwV+odW94z08nl5
	J/qm5URmaun9Sv1kJJs6lDdWrY8P0mpNh8e8nkyQ+lk6SLpq8AI4wD
X-Google-Smtp-Source: AGHT+IHL2bHlb8zO41/Jxf2utTORupqxIi77U6O00YZIM/pWZADJ0s4fPawj9Y7p3sNFDHCrRD2I1qzjj1rQmU66C6E=
X-Received: by 2002:a05:6512:3c87:b0:54b:ed9:2d06 with SMTP id
 2adb3069b0e04-54ea33ab5a5mr588977e87.44.1746000297898; Wed, 30 Apr 2025
 01:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
 <20250429220933.GC36727@coredump.intra.peff.net>
In-Reply-To: <20250429220933.GC36727@coredump.intra.peff.net>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Wed, 30 Apr 2025 09:04:46 +0100
X-Gm-Features: ATxdqUEM_2U1Kgc2eg_pPxQQ1sN_KJjmrLBsML_jH2SYAJAnplgkCI78eVpJVRQ
Message-ID: <CAP9jKjF5suY6mx19knKwWAEHrTJ_meWhktOuMTFixq0hmFsjuA@mail.gmail.com>
Subject: Re: Discussion for interactive --patch commands to get --unified support
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

> If it is only to specify how many context lines to ask for the diff
> machinery when preparing the initial patch that is presented in the
> "add -p" UI, it should be fairly easy.

This is the intention, I personally don't have a need for changing
hunk context *during* an interactive add and as you say, this looks to
be a big task.

> I would expect that development of such a feature would progress
> roughly in the following order.

As someone who has never contributed to (or even very familiar with)
the codebase, this is very helpful and I really appreciate it!

> In my opinion it would be fine to respect diff.context (and probably
> diff.interhunkcontext[1]) by default.

I think this could work nicely and agree with this approach.

> Looking at git_diff_ui_config(), which are all the options read by
> porcelain git-diff but not by plumbing git-diff-files, etc, there
> may be other config in the same boat. E.g., I'd guess that people
> with diff.colormoved set would appreciate seeing that effect in the
> colorized versions we show.

Agreed. As you mention it, I recently discovered `diff.colormoved` and
I'd welcome this to the `--patch` functionality, although I also agree
that it would make sense to take things one step at a time and it's
not necessary to batch anything else into this change.

With all that being said, I propose the following:
- inheriting `diff.context` and `diff.interhunkcontext` as the
defaults for the various interactive/patch commands
- be able to override these defaults on the command line with
`-U<n>/--unified=<n>` and `--inter-hunk-context=<n>` respectively

These would cover both a "permanent" config that you wouldn't need to
specify every time when writing the command/s out, but also would
provide a way to override the individual built-ins as/when you want.

You guys obviously have better knowledge and experience with git
development so it would be great to hear your feedback on this.

Thanks!

On Tue, 29 Apr 2025 at 23:09, Jeff King <peff@peff.net> wrote:
>
> On Tue, Apr 29, 2025 at 10:16:15AM +0100, Leon Michalak wrote:
>
> > - make `diff.context` setting extend to the interactive patch commands
> > (not sure how a change like this would be welcomed considering it
> > could change users command outputs seemingly out of nowhere)
> > - add an `interactive.context` setting that would work like the
> > existing `diff.context` setting but apply only to the interactive
> > patch commands
>
> In my opinion it would be fine to respect diff.context (and probably
> diff.interhunkcontext[1]) by default. Though it does change the command
> output, the interactive output is by definition user-facing, so we
> shouldn't be breaking scripts. And we already respect other porcelain
> level config like colorizing.
>
> I think the only reason we don't already do so is that the interactive
> code is built around the plumbing commands, which conservatively avoid
> various config options. So the calling code has to explicitly check the
> config itself.
>
> -Peff
>
> [1] Looking at git_diff_ui_config(), which are all the options read by
>     porcelain git-diff but not by plumbing git-diff-files, etc, there
>     may be other config in the same boat. E.g., I'd guess that people
>     with diff.colormoved set would appreciate seeing that effect in the
>     colorized versions we show. But I think it is OK to just consider
>     diff.context for now, and see if anybody ever cares enough about
>     other options to look into them.
