Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6874C207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942406AbcJFRUT (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 13:20:19 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34545 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942018AbcJFRUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 13:20:17 -0400
Received: by mail-qt0-f175.google.com with SMTP id q7so10900244qtq.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K7eMIy5par+jk0dFoR9bW0A9dqUnOPUpc0wu7h/YFbE=;
        b=BWJNZ4xaoBIvQWyIxqj1F10S8nvvW+VDJB9gO/4ZRRSqus0r4oovhRm5lRnHroCdCw
         d8+3vGxlfQHJG2gRrXfngZUJWlWxrwaceQryGZyAeHiXf4SfKADfmObyR212sMd2/cZ4
         W5nc38ojtJpujyken8sx17dGsn5OcJynvC3bR/E4jKuiWwJdn5bQDPhU/yznqQTK7X1/
         ouoolg8+flM4XJ/+OxMoVM0bOHaesT5qBOa9ixr+hNinxPeujiNqhND7U+vHDy2noF5U
         /b8J+HmU7fW3KFENTGh5vFHXlTz1tPnYapJ+LvVw5PjkevNfJhzFqLW94hw8Bsf+71Fk
         wZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K7eMIy5par+jk0dFoR9bW0A9dqUnOPUpc0wu7h/YFbE=;
        b=G3k2hA91fV8l8ro5wqYYbaRRTT/zuyQM9pW/uPhVK5B8+PRA5GvTAwhUk8CrMQk0/A
         AP7TnQO3rvjtu2bWmS7UGRJkPdAGhHtS5PFyBEdDWwnOpW/sJcJ7sEVmWh0XhJ4kCbqM
         BBEbRh/1ocePvWQt5YUlh1BJIOOSewsciukX9CDlL780JTJPPcCGlMok5yO2imb4ePtc
         7xQtnLOZezS1QMhiw8kNDBeQLr0PnkclTfLXmdmnjEVcm6mlvvzCnSEAJFt2tuwXxxRn
         VQwm3doWawlGPv8g4QmXPgWwzgd2rGXRofllZkbFzX8PmlSAFCCkV8Oy4gC+SXamvH+C
         L1eA==
X-Gm-Message-State: AA6/9RnyYPMr1kInRfgdJJURfGM2WCrrQSmHMV54M3qDWLanYNSl5vrBnxJkZA0SRyxtMYCWFEUfjUJKfs3kJpbi
X-Received: by 10.237.55.232 with SMTP id j95mr16119646qtb.131.1475774416634;
 Thu, 06 Oct 2016 10:20:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 6 Oct 2016 10:20:16 -0700 (PDT)
In-Reply-To: <20161006092332.GB38550@book.hvoigt.net>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
 <20161004210359.15266-1-sbeller@google.com> <20161005135325.GC30930@book.hvoigt.net>
 <20161006092332.GB38550@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Oct 2016 10:20:16 -0700
Message-ID: <CAGZ79ka=bVX51wrSiz4u7xOy+54t+v7a-iU5dHtQoNnB7-NAkw@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] push: change submodule default to check when
 submodules exist
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2016 at 2:23 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Wed, Oct 05, 2016 at 03:53:25PM +0200, Heiko Voigt wrote:
>> On Tue, Oct 04, 2016 at 02:03:58PM -0700, Stefan Beller wrote:
>> > Jeff,
>> > thanks for the suggestions, both git_path(..) as well as checking the config,
>> > this seems quite readable to me:
>>
>> When reading the discussion I thought the same: What about the
>> "old-style" repositories. I like this one. Checking both locations
>> is nice.
>
> BTW, since it seems we all agree on the direction. Should we add some
> tests?
>

Good call. What do we want to test for?
* Correctness in case of submodules? (just push and get rejected)
  I think that is easy to do.
* Performance with [no, lots of] submodules? That seems harder to me.

I'll add a test for the correctness part and resend.

Thanks,
Stefan
