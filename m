Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FDC6FA82
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIBSQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIBSQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:16:35 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D89F5486
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:16:34 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-33dce2d4bc8so24044757b3.4
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 11:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Fb+KpMZDEsgA8l6c7VjFUzeTKqjtQB7Kwo6vokQeIBg=;
        b=gPqz8qiy7q+zjrQkOoB/7wxCRK7TNxQbblzB44aY+pvW3Xqx/7exSBzbvA1JtafMki
         6VDmNAd8oxdJH8lPPfpI7+Jd8lBCueSPuT7IhLyO1o0LcJI83rOZoLZ4ggrHABtDupxX
         tA5Z2RPgQgiPMeLyisGw4lcV3/FakxWiuWc/v1T9R8oF5rSgSFGQUOh+3Eks1z0pdmkM
         GLfUH/PZEYflj7dnAEFoCC/5yjw1sxzGylliArc8YnwOcQjKuRZftKBrly6MGNLbOTWp
         jc0UYKNWtBJpYSIfiEuKo0LRHOcZ2QqaJVGS5riJJ9wKGobCNQPpKvOz9GJQJQajQLWA
         uVtQ==
X-Gm-Message-State: ACgBeo3qe/LAZTvkHEyX4OzC4kPwaa3xudigH/U+gTBkmNq4fAOLJBpe
        9X5ePSuZlCxgriw8eozwrlRWISbsKdOKSl2wGnQ=
X-Google-Smtp-Source: AA6agR7U1XOAlGn7RC+WiWDWs8j45ZG1HuRb6Qz/MouGr0djE+X5m0/soxW/WlagHS8dCp/6DJNy9k1M3gTqE2/3Gws=
X-Received: by 2002:a81:6d44:0:b0:33d:d115:e3f2 with SMTP id
 i65-20020a816d44000000b0033dd115e3f2mr28538066ywc.482.1662142593579; Fri, 02
 Sep 2022 11:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <f5dbcbf78db127d738c11a1aca416201298426cf.1661992197.git.gitgitgadget@gmail.com>
 <9on60586-rr40-onn0-907s-53816r61qn07@tzk.qr>
In-Reply-To: <9on60586-rr40-onn0-907s-53816r61qn07@tzk.qr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Sep 2022 14:16:21 -0400
Message-ID: <CAPig+cRCME=SYyV2bDNoAJjdnHUAWUqSP00aO_v-KWdNvasKpA@mail.gmail.com>
Subject: Re: several messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2022 at 8:42 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 1 Sep 2022, Eric Sunshine via GitGitGadget wrote:
> >  t/chainlint.pl                                | 730 ++++++++++++++++++
> >  t/chainlint.sed                               | 399 ----------
> >  t/chainlint/blank-line-before-esac.expect     |  18 +
> >  t/chainlint/blank-line-before-esac.test       |  19 +
> >  ...
>
> This looks like it was a lot of work. And that it would be a lot of work
> to review, too, and certainly even more work to maintain.
>
> Are we really sure that we want to burden the Git project with this much
> stuff that is not actually related to Git's core functionality?
>
> It would be one thing if we could use a well-maintained third-party tool
> to do this job. But adding this to our plate? I hope we can avoid that.

I understand your concerns about review and maintenance burden, and
you're not the first to make such observations; when chainlint.sed was
submitted, it was greeted with similar concerns[1,2], all very
understandable. The key takeaway[3] from that conversation, though,
was that, unlike user-facing features which must be reviewed in detail
and maintained in perpetuity, this is a mere developer aid which can
be easily ejected from the project if it ever becomes a maintenance
burden or shows itself to be unreliable. Potential maintenance burden
aside, a very real benefit of such a tool is that it should help
prevent bugs from slipping into the project going forward[4], which is
indeed the aim of all our developer-focused aids.

In more practical terms, despite initial concerns, in the 4+ years
since its introduction, the maintenance cost of chainlint.sed has been
nearly zero. Very early on, there was a report[5] that chainlint.sed
was showing a false-positive in a `contrib` test script; the developer
quickly responded with a fix[6]. The only other maintenance issues
were a couple dead-simple changes[7,8] to shorten "labels" to support
older versions of `sed`. (As for the chainlint self-tests, the
maintenance cost has been exactly zero). My hope is that chainlint.pl
should have a similar track-record, but it can easily be dropped from
the project if not.

[1]: https://lore.kernel.org/git/xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com/
[2]: https://lore.kernel.org/git/20180712165608.GA10515@sigill.intra.peff.net/
[3]: https://lore.kernel.org/git/CAPig+cRmAkiYqFXwRAkQALDoOo-79r2iAumdEJEZhBnETvL-fw@mail.gmail.com/
[4]: https://lore.kernel.org/git/xmqqin5kw7q3.fsf@gitster-ct.c.googlers.com/
[5]: https://lore.kernel.org/git/20180730181356.GA156463@aiede.svl.corp.google.com/
[6]: https://lore.kernel.org/git/20180807082135.60913-1-sunshine@sunshineco.com/
[7]: https://lore.kernel.org/git/20180824152016.20286-5-avarab@gmail.com/
[8]: https://lore.kernel.org/git/d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com/
