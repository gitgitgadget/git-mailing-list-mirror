Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E459C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 11:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376889AbiBEL7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 06:59:45 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:39756 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiBEL7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 06:59:44 -0500
Received: by mail-pl1-f179.google.com with SMTP id x11so7397838plg.6
        for <git@vger.kernel.org>; Sat, 05 Feb 2022 03:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kvSUG+A3OWVIUHLs5i4cxIE+vWMkZpRXrg3RLLFBcc=;
        b=gKXIxmhNxPl4CNtlFACQWnsUqvXGAljJdVI05RsvgC11qteOVHdUsMJK8qbVJdMS3I
         UvfC4MqyH0CEdOZzxaWMH5Zw4QjDsQaar5oaRHKxTD5NrfGJZDnM1S0yLnjogipQqLws
         /VIiuQQE4thGTgXjIvLt7X/ZFCsO2aGbp789deYbbpPBnSn29hZMgLNFPOgycTyM0vrK
         HwY9fP+Cgc1f4C2yVq+Xqqn+/fjy8BGwLP/sot4HBYGMV9shn8lC4xbRIaqXuVHNfBh3
         l7nxGQbWNwhFfsbHlizNO0uQW7QZ7idyiEd1jA8sOnjbTwDel2SqW/4zmvWvh6/Q9dTy
         xnpQ==
X-Gm-Message-State: AOAM533SN8UwXOj3DSR5jQamLKuWR4xISR/vzcpneyZlCQZtDMy8/PMk
        N3ajtMXm3GHICbc4dDv6+sNMP5I0pePrwRHN/fpiqsRYHzw=
X-Google-Smtp-Source: ABdhPJwG0H5NrJzxi8gjYO0D4FZx10xnQH+jS9O5ckdO2JGypwTxPrw+zF/CpjkO1GZ6TqfTjPluSKaQpm0lDMDls4c=
X-Received: by 2002:a17:903:249:: with SMTP id j9mr7802390plh.145.1644062383839;
 Sat, 05 Feb 2022 03:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <CAPig+cS5tOr2NRJmAC1BNQPKYyeLXy0iy36q35-y7rFkrWewJw@mail.gmail.com> <CAJyCBOSd7pVedwexMn7HGQfJeVcOUJ4VVgYKYt+7TjQz7QCf1Q@mail.gmail.com>
In-Reply-To: <CAJyCBOSd7pVedwexMn7HGQfJeVcOUJ4VVgYKYt+7TjQz7QCf1Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 Feb 2022 06:59:32 -0500
Message-ID: <CAPig+cQATBiwGMhXk+WFLGDKw6it9ZwTRxXO7+upy4Yk+M-crQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] lib-read-tree-m-3way: modernize a test script (style)
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 4:51 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> On Fri, Jan 28, 2022 at 4:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > In this case, the indentation of the entire body of the for-loop needs
> > to be fixed to use tabs rather than spaces, however, fixing all the
> > indentation problems together with the other problems can make for a
> > too-noisy patch for reviewers to really see what is going on. As such,
> > it may be better to make this a multi-patch series in which one patch
> > fixes indentation problems only.
>
> > As mentioned above, changing the body of the test from double- to
> > single-quoted string should (presumably) be okay since the body gets
> > eval'd and `$p` will be visible at the time of `eval`, however, mixing
> > this sort of change in with all the other changes being made makes it
> > hard for reviewers to spot such little details, let alone reason about
> > correctness. As such, switching of quote types is also probably the
> > sort of change which should be split out into its own patch. The same
> > comment applies to other changes following this one.
>
> I think so. I was thinking fixing all the general styling issues in one
> patch (since they are all style related), but now I realize that the general
> style patch can be divided into sub-patches for clearer review experience.
>
> And my question is, should I do this "multi-patch series" thing in the form of
> "-v<n>" (all under this thread), e.g. "v2" or "v3"? Or I just submit
> multiple patches separately (a new thread for each one)?

A multi-patch series as v2, v3, etc. would indeed be appropriate, as
you already figured out[1] before I got around to answering belatedly.

> > Overall, with the exception of the test title which needs to
> > interpolate `$p`, the rest of the changes are probably reasonable and
> > benign. It's important to understand that lengthy patches like this
> > full of mechanical changes tend to be quite taxing on reviewers, so
> > it's a good idea to help in any way you can to ease the review burden.
> > This can be done, for instance, by making only a single type of change
> > per patch (i.e. indentation fixes), or by limiting the scope or
> > breadth of the changes, which is especially important for this sort of
>
> I'm not quite sure what this means, and I quote, "limiting the scope or
> breadth of the changes". Are you suggesting, for example,
> fixing fewer occurrences of tab indentation issue in a patch; or, for
> example, limiting the
> fix to a specific "test_expect_success" block, and do multiple patches
> sequentially?

Sorry for being unclear. I just meant that as a microproject, it would
have worked equally well to pick a much smaller test script with style
problems (if you could find one) rather than a long script. After all,
the purpose of a microproject is to give you experience with the
submission-review process and to give reviewers and mentors an idea of
how you interact. It's the process which is important, in this case,
not the size of the submission.

Anyhow, it looks like Junio is happy with your v3 and will be merging
it down to "next", so it all worked out.

[1]: https://lore.kernel.org/git/20220202064300.3601-1-shaoxuan.yuan02@gmail.com/
[2]: https://lore.kernel.org/git/xmqqr18jnr2t.fsf@gitster.g/
