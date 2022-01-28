Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D9C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 09:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347739AbiA1Jv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiA1Jv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 04:51:27 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9900C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 01:51:27 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id g205so11317977oif.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jc5vGuGBKuGDG61hgzMeZaCAfGUDkyg7Ex7RWxrhFpc=;
        b=b11Y4WOh7TH3wCMh5baIsfBVHaMIzdXczIWDI0TlDNVcVS7LkRbtzg6+UXjXEDNYp5
         VuednSexBsyxeqnpIveBcbpI2rwHmkY6tq7kolXNnEcgzwhkRWqzkQajswOgxszP5HOa
         WYphy/ZVouVtrj2WwLu0rY8zXoaWlsD2J3qnIwwdakNDHiPn7GwBNaa0a/YK5W+QpzOJ
         Ey2ob5qaxcoqM5wD59ovCPWJg6eFFd1WDfMs/dDsQRwwJcuwgpmWPMYvzQdsfc9qPVeK
         67Un1cBNgBOI9DmVY9dYcuhpghVmdpo9RBunF17HB6hrYIvfClxOATPPCC3SOiUGNdIb
         t9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jc5vGuGBKuGDG61hgzMeZaCAfGUDkyg7Ex7RWxrhFpc=;
        b=b17Oz/9md+ZsBUdNFyiRMlghdwA5HQkwUStYxI+9cCDDCb9EXoWi3S8lQjvi8orAI6
         ZEr5dMaxPlZ11hiXkbghVD7cKioTwIXrYfUjIoNbZkvjElGpbrE+LbIiYHDSOJpcbx1R
         ab+M9nYoacO+m+TtZ1w6CZCY7n0geJ21QCDPRZqp8pfY62k1fHrJg/CYC1kq/CtMJyU0
         HLvJpMqeqG0v5bw9cpBQ1H8rYl/w1W4Uzoy8wjRYt26DwYfc41NIRKDWlwavMjjggrC6
         Zdt4Dy1RGjmCluexB1XuuYzT5772z7urZt4eDZZppSQ+DxSdA2KPBIBqiohG2Ek4XHLp
         bqjg==
X-Gm-Message-State: AOAM533NAdzENRnNhd+SUIHD9b1oqXbrpkBoWbbNcR1jtFQubAzXmPLJ
        oAPaSg9eRt18WvZ/KM/VwM1ofkZbHCf2HsjGpWq7P9lKSsQRDg==
X-Google-Smtp-Source: ABdhPJz/sqFbbwscb34yTYbSbw6hFGjFj9hShLr1jFRloWdUuLIBkZB7Y2BVq+fDYRvzthkN056QYdT+mo/mYXCCOX8=
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr9462339oik.78.1643363487187;
 Fri, 28 Jan 2022 01:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com> <CAPig+cS5tOr2NRJmAC1BNQPKYyeLXy0iy36q35-y7rFkrWewJw@mail.gmail.com>
In-Reply-To: <CAPig+cS5tOr2NRJmAC1BNQPKYyeLXy0iy36q35-y7rFkrWewJw@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 28 Jan 2022 17:51:16 +0800
Message-ID: <CAJyCBOSd7pVedwexMn7HGQfJeVcOUJ4VVgYKYt+7TjQz7QCf1Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH] lib-read-tree-m-3way: modernize a test script (style)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 4:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Jan 24, 2022 at 1:37 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> > lib-read-tree-m-3way: modernize a test script (style)
>
> Prefixing the subject with "t/" would help better explain which part
> of the project this patch is touching. Perhaps:
>
>     t/lib-read-tree-m-3way: modernize style

Thanks, this tip is really helpful and I forgot to add the directory prefix.

> > As a microproject, I found another small fix regarding styling to do.
>
> Everything above the "---" line below your sign-off will become part
> of the permanent project history; everything below the "---" is mere
> commentary for reviewers. Reviewers may be interested in knowing that
> this is a microproject, but it likely won't be meaningful to future
> readers of the project history. As such, place this sort of commentary
> below the "---" line.

Sure, I did not realize this. I should've put the comments below "---" instead.

> > I changed the old style '\' (backslash) to new style "'" (single
> > quotes).
>
> Not sure what this means. I _think_ you mean that you changed:
>
>     test_expect_success \
>         'title' \
>         'body'
>
> to:
>
>     test_expect_success 'title' '
>         body
>     '
>
> Sometimes you can convey such a meaning more clearly by a simple
> example as illustrated above.
>
> > And I also fixed some double quotes misuse.
>
> Again, it is unclear what this means. Providing an example can help
> readers understand what you changed.

Will do, definitely a helpful tip.

> > Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> > ---
> > Other than that, I forgot to introduce myself in the last patch and
> > here it goes:
> >
> > I'm Shaoxuan Yuan, currently a sophomore majors in Computer Science and Engineering
> > (CSE) @ University of California, Irvine.
> >
> > I have prior open-source experience in which I was [maintaining|contributing to] the
> > Casbin community. My main language is Python, and I'm a C newbie
> > because I'm quite interested in contributing to git (since it is in my main daily
> > toolkit and it is a charm to wield :-) ).
> >
> > And for now I'm still taking baby steps trying to crack some test script
> > styling issues. After getting more familiar with the git contribution
> > process, I will try something bigger (though not THAT big) to get a
> > firmer grasp of git.
>
> Welcome. Please understand that all review comments (above and below)
> are meant to be constructive and help familiarize you with the local
> customs of the Git project; they are not meant as any sort of
> criticism.

Thanks, I learned a lot from your review comments :)

> > diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
> > @@ -8,16 +8,16 @@ do
> >         echo This is Z/$p from the original tree. >Z/$p
> > -       test_expect_success \
> > -           "adding test file $p and Z/$p" \
> > -           'git update-index --add $p &&
> > -           git update-index --add Z/$p'
> > +       test_expect_success 'adding test file $p and Z/$p' '
> > +           git update-index --add $p &&
> > +           git update-index --add Z/$p
> > +    '
>
> Taking into consideration the difference in behavior of single-quoted
> strings and double-quoted strings, changing this test's title from
> double- to single-quoted is undesirable since `$p` is supposed to be
> interpolated into the title; the title should not contain a literal
> "$p". (Unlike the test title which is simply echo'd/print'd, the test
> body gets eval'd, which is why `$p` in the body is acceptable even
> though the body is in single-quotes.)

Agree, I didn't realize the difference between single and double
quotes in shell scripts
(I was just imitating other similar style fixes).

> > -test_expect_success \
> > -    'adding test file SS' \
> > -    'git update-index --add SS'
> > +test_expect_success 'adding test file SS' '
> > +    git update-index --add SS
> > +'
>
> Since you're touching this anyhow as part of fixing style issues, you
> should also fix the indentation to use tabs rather than spaces. The
> same comment applies to the rest of the patch, as well.

Sure.

> >  for p in M? Z/M?
> >  do
> >      echo This is modified $p in the branch A. >$p
> > -    test_expect_success \
> > -       'change in branch A (modification)' \
> > -        "git update-index $p"
> > +    test_expect_success 'change in branch A (modification)' '
> > +        git update-index $p
> > +    '
> >  done
>
> In this case, the indentation of the entire body of the for-loop needs
> to be fixed to use tabs rather than spaces, however, fixing all the
> indentation problems together with the other problems can make for a
> too-noisy patch for reviewers to really see what is going on. As such,
> it may be better to make this a multi-patch series in which one patch
> fixes indentation problems only.

> As mentioned above, changing the body of the test from double- to
> single-quoted string should (presumably) be okay since the body gets
> eval'd and `$p` will be visible at the time of `eval`, however, mixing
> this sort of change in with all the other changes being made makes it
> hard for reviewers to spot such little details, let alone reason about
> correctness. As such, switching of quote types is also probably the
> sort of change which should be split out into its own patch. The same
> comment applies to other changes following this one.

I think so. I was thinking fixing all the general styling issues in one
patch (since they are all style related), but now I realize that the general
style patch can be divided into sub-patches for clearer review experience.

And my question is, should I do this "multi-patch series" thing in the form of
"-v<n>" (all under this thread), e.g. "v2" or "v3"? Or I just submit
multiple patches
separately (a new thread for each one)?

> Overall, with the exception of the test title which needs to
> interpolate `$p`, the rest of the changes are probably reasonable and
> benign. It's important to understand that lengthy patches like this
> full of mechanical changes tend to be quite taxing on reviewers, so
> it's a good idea to help in any way you can to ease the review burden.
> This can be done, for instance, by making only a single type of change
> per patch (i.e. indentation fixes), or by limiting the scope or
> breadth of the changes, which is especially important for this sort of

I'm not quite sure what this means, and I quote, "limiting the scope or
breadth of the changes". Are you suggesting, for example,
fixing fewer occurrences of tab indentation issue in a patch; or, for
example, limiting the
fix to a specific "test_expect_success" block, and do multiple patches
sequentially?

> "noise" change -- a change just for the sake of change -- which
> doesn't have any immediate practical benefit.

Overall, thanks for the reply and it is really helpful! I did make a lot of
mistakes in this patch, but I'm learning a lot :)
And I will amend my patch base on these suggestions then submit a v2.

--
Thanks,
Shaoxuan
