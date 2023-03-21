Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD9FC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCURRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCURRm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:17:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94ED188
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:17:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id bf15so7237264iob.7
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679419060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol+XzPWiw8Q4Ozn5PcSiGjJvP5X5Jv36cI/FlpK1tZs=;
        b=1UTfXN0JMNb3mn+4cXLaFXAq/C57dIcdboEJyU+5iCrhA+wEX5OUzwviraVbRgvFts
         D6dwBU3VM8II/J3KRLkWtb8TEofX3J0HBViCaqKQ8SDGUVDaLcLmyXSkJPXG/qJmmSmL
         Ds/bFX11DI51ppCga8Onqsvnswu0vsYOpGlaRlssMj8oMOmoJ8TI8/9oWZqiIIMdziX5
         a3StOk4Xkgk/VZsLsUduzJ3gnUWU3u5RryTSHpH9rVbuON9G3ehbanUodqBXSjagLL3G
         eiRqAB9Ocoqs3NdXVnNDIaERr+QIQTvAkygdpy0wWxUbn9fik9kdLXNfQTzOswWOOczt
         +PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol+XzPWiw8Q4Ozn5PcSiGjJvP5X5Jv36cI/FlpK1tZs=;
        b=X5MVD6DzrS5z/NDr7shYgKnVzQCiyIbqEYBZqcLUQ9EZ8g28iSuUBkslA40rhMuXz7
         CFdv4lO78OGvcfw9XEz24ZNAhslzZ6AGb+6wSS9fsj2r7ETEuAuK/Jtr7EmfSxqaQcw7
         GfN/m7QVtkIN823SsolSYMp370NjaBMkxhzrd0H5xLq9VQcfdbxUhtBKYGWWJsMUwXiL
         aDfO3U0MkForlifKXO4j2q7LxVvUnz+5iL8bBLhXh+VBdT4ZqG7as3RHfYJdsSnNgw9m
         ofq9K0CPAxqxdqGYh05LjCpXcSieKZyCwFMudLrn8VWArcTbgSpWq3D+RRHPt9BLms8P
         fAVw==
X-Gm-Message-State: AO0yUKWGX8I+uNLiseBFguQ8jpoTNm0pUvJwl+qVhmB/R+5jeaQ20WbV
        6Q024gfnBLj8d0Qe+G3fFct32KUBP1CbVWzJtGRHtA==
X-Google-Smtp-Source: AK7set83O8tXP1smcP3XjONKrPg4mYlIbNlBNK+LZ1d0xeHx35zSf8eRtcVmNL688OuSgkZpyJ+eSg==
X-Received: by 2002:a5d:81cd:0:b0:758:4909:fbd6 with SMTP id t13-20020a5d81cd000000b007584909fbd6mr1879460iol.12.1679419060101;
        Tue, 21 Mar 2023 10:17:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cd8-20020a0566381a0800b00406521ad090sm3320517jab.94.2023.03.21.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:17:39 -0700 (PDT)
Date:   Tue, 21 Mar 2023 13:17:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Edwin Fernando <edwinfernando734@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] Intro and Micro-project
Message-ID: <ZBnmsoRmQGKkQt+S@nand.local>
References: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Edwin!

On Tue, Mar 21, 2023 at 02:38:34PM +0000, Edwin Fernando wrote:
> Hello,
> I am Edwin, a first year undergrad in the department of computing,
> Imperial College London. This is my first message to this mailing
> list! I want to work on the micro-project "avoiding pipelines in test
> scripts".

That sounds great! I assume that you meant avoiding pipelines where the
'git' executable is in a non-terminal position of the pipe, e.g.:

    $ git blah | <something else>

Since if "git blah" exited with a non-zero code or crashed, etc., then
we wouldn't see the failure since the pipeline would suppress it.

That has been a long-standing goal within the test suite, and I think
that it's a great project to get you started. It'll ensure that you have
all of the bits in the right place to get Git running on your machine
and that you're able to run the tests.

> I'm really excited to work on such a massive project (ie, git, not the
> microproject) and be in contact with the people who put it all
> together. I'm curious about how software development works at this
> scale, since it feels quite different from the small projects I've
> used to work on. I use bash quite frequently for automating tasks, and
> I have experience in C, through a uni project of making an assembler.

:-).

> I found and looked at a few places with pipes. I have a few thoughts
> and questions on making a change. Firstly (if this is relevant), how
> do I ensure that the file I write the std output to doesn't have a
> name clash with other such files made during tests?

Each of the tests runs in their own "trash directory", which you can
keep around after the tests are finished running if you invoke them with
the '-d' flag. More information about each of those flags is available
in t/README, as is information about the test suite as a whole.

I would also recommend that you take a look through t/test-lib.sh and
t/test-lib-functions.sh, as those give a good overview of both (a) some
of the internals of our integration testing library, and (b) some of the
convenience functions available to you as a test author.

Looking at some example tests in the tree may be useful, too. You might
want to check out t/t5318-commit-graph.sh as an example of our modern
test-writing style.

Let us know if you have any questions or want any pointers on getting
started.

Thanks,
Taylor
