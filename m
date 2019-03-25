Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2663020248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfCYSoE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:44:04 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:37083 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfCYSoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:44:04 -0400
Received: by mail-io1-f48.google.com with SMTP id x7so8541035ioh.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyDDvwoTUqIBi0gmoc7byAevITr1SdGu8jJYQAdx7Ss=;
        b=hWDAk/BoNAnNDP7v7VmiMlQolpSf9qTJSzPPeQet2sD/vCjlBUkD0rWDuA9ton39XN
         qaW4rxsQCybMf08op0UGstApm0dkCsCVL+Q6mgCOSPgSwcqNr+XrpREA2JhCsBI6RtN8
         BGR3xKjUrcrEuTDfXfiDdYnBBYy5QOgGui7W6iCC9nixLI3ukYeCRJHSxDHVUIjFxSad
         dT7cqSHoNTnwLhJrpiTXnSKSazzywfbN+UOMtbzNP9MUS7K1PcH7iCjqXFpMnL9KfWKg
         GdxYINL54p5zS7+FRxkhEMiMeJxOL8SOwutJqRtHa96al36/rqhcrapxhzgmDUmCGd4v
         4ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyDDvwoTUqIBi0gmoc7byAevITr1SdGu8jJYQAdx7Ss=;
        b=OI8DEqMStW9tRHYb3X8pxcczoxo/ol9KUpCipmRFYvdDrxL2hLCrO4FJMiYGMoY7Z3
         kFlvs5VS+w+KQcMHLC1wAy5HKwA0ERCqDA3vz1f7DsAyFwa5i7SCPuKgPUeBqhB2SfE+
         SDs6KIZLA4gD4V4mtOOW2jH5A9kHq6sWHr+gNgAmTywOe/KpHHeT4qPGwRvtdNYugJcK
         A9ate1T5z0UDCoZK0wEJsgL/UdTbqljX8OiT2MlsYn18JHN9j8r//6TNq2QkUmCOp1T9
         F9HN9fcJb1BfnLZxCToHLr1UYtfiN2R25LIHvTqpsy0GgYuf76+D3j5fVR6y4KIv4CdA
         Eo8Q==
X-Gm-Message-State: APjAAAU9BJuW0ao/HFQJobwKIFh2CnMxF4HDPSSWs7UtnIIgmjsMxUjM
        9fXVDalZDvlAb5PPG4fWHy3zkwrFuIMkmVDs6TAxo7gB
X-Google-Smtp-Source: APXvYqyv5JDf4muKh5lmS7LrC5GUwUouv4fmDLawnOe2bkY4iW6+0FA+M76PX9FKgafyPjLi90cUdfK0NMEqkXRBSF4=
X-Received: by 2002:a5d:8757:: with SMTP id k23mr19352122iol.68.1553539443114;
 Mon, 25 Mar 2019 11:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <20190321192928.GA19427@sigill.intra.peff.net> <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
 <20190325144930.GA19929@sigill.intra.peff.net>
In-Reply-To: <20190325144930.GA19929@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 25 Mar 2019 11:43:52 -0700
Message-ID: <CAGyf7-EOrCgPY19jgwRd5H-0ADMX9WtLUuACmTAANnNVW-K-_Q@mail.gmail.com>
Subject: Re: Strange annotated tag issue
To:     Jeff King <peff@peff.net>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 7:49 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 25, 2019 at 08:50:14AM -0500, Robert Dailey wrote:
>
> > On Thu, Mar 21, 2019 at 2:29 PM Jeff King <peff@peff.net> wrote:
> > > Tags can point to any object, including another tag. It looks like
> > > somebody made an annotated tag of an annotated tag (probably by
> > > mistake, given that they have the same tag-name).
> > [..]
> > Thanks for explaining. This is very helpful. Am I naive to think that
> > this should be an error? I haven't seen a valid _pragmatic_ use for
> > tags pointing to tags. In 100% of cases (including this one), it is
> > done out of error. As per your example, users try to "correct" an
> > annotated tag pointing at a wrong tag or commit. What they expect is
> > the tag to point to the other tag's commit, but that's not what they
> > get.
>
> I don't think I've ever seen a tag-to-a-tag in the wild, but I wouldn't
> be surprised if somebody has found a use for it. For example, because
> tags can be signed, I can make a signature of your signature, showing a
> cryptographic chain of custody.

For a while the Atlassian Bamboo team followed a workflow where they
would do a build in CI, tag that build and then deploy it to a sandbox
environment for smoke testing. If it passed the smoke tests, it would
get "promoted" from the sandbox environment to internal instances used
by the various teams to do their builds. When a sandbox build was
"promoted", they'd create a tag of the sandbox build's tag to have
traceability between the two environments.

I'm not advocating for or judging that workflow one way or another,
and the Bamboo team has since moved on to a different workflow. I just
thought I'd share it as a tag-of-tag workflow that I've seen a real
team using. (There was one place in Bitbucket Server's code where we
didn't handle recursive tags correctly, so their workflow caused some
errors that I needed to make some adjustments for. As a result,
Bitbucket Server's test suite now includes tests that cover tag-of-tag
behaviors.)

Bryan
