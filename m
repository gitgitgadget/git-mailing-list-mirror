Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B748C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 06:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC2G3P convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 29 Mar 2023 02:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC2G3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 02:29:14 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DAB2D56
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 23:29:06 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so15179736pjb.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 23:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680071346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBt+IRkj0zlaYrHZqCGUI+ZrfkibiEo9I0F2Gbnh8M4=;
        b=dTsTX0glvsrB4JaRDdXkgfBjQLjKbXjNxXIfd3Wt1oPrDLbgx0quEWq71JNFf8lSDa
         gPTKpNJHqlZv+2C0nTvYjELIw2dCJhLJ9nMQMAr+Sek8/vloKmugRWzSKLGiRh8TEw2u
         mlFFFZhd19FmXg0hvBgYIS026aSMyM2am1mTe978+elEjN+7lGlcfG6NtACL3Uk+JU37
         CwbxC4+rHZ96NGzs+RCvPLTStlLyy2FJKTGivpsram1xY/H+kGxUMm2QCLUs7pDHM9oN
         hIB5gc6OkUxQVoZPXMjPkV6mz/QjjMVr5Y+ubpDiYrmWt2Rb4oLHJS4CgC7lkCvpFh0c
         7KVQ==
X-Gm-Message-State: AAQBX9d5gGYOg3x8YGb6Wgi3+fpRsQ/9yzrs18ZdYoBfXIvucaI9RqMg
        rnTVOY7cQT0JU+vURSC+11Z6Yp0hQ/wPOjxaxaY=
X-Google-Smtp-Source: AKy350b2t5BPwapdZO8mCrDeKdAtgKv45F8NovwzduXbOxV3gMvGGN9mNYS5G52BIrD0mGlq58ErvzjZZ3EWHmyvTLo=
X-Received: by 2002:a17:902:b195:b0:19f:3aa9:9ea1 with SMTP id
 s21-20020a170902b19500b0019f3aa99ea1mr7024517plr.8.1680071345842; Tue, 28 Mar
 2023 23:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net> <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net> <20230329030432.GA1801645@coredump.intra.peff.net>
 <CAPig+cQexJ9s1f6tLLaq7baeVCKhazPBi_xQ6uybkQcJQ97geg@mail.gmail.com>
 <CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com> <20230329060709.GB1793752@coredump.intra.peff.net>
In-Reply-To: <20230329060709.GB1793752@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Mar 2023 02:28:54 -0400
Message-ID: <CAPig+cRO7cDkn5XsRq+9OdkdGQL-UL12-i2Tm9jJFO0mbYJtEA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 2:07 AM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 28, 2023 at 11:46:37PM -0400, Eric Sunshine wrote:
> > The attached patch seems to do the job. Apologies for Gmail messing up
> > the whitespace. It's also attached to the email.
>
> Thanks! I was going to say "please don't consider this urgent", but I
> see that my nerd-snipe was successful. ;)

As always. My nerd-snipe armor is in failure mode.

> > This would probably make a good preparatory patch to your [3/4]. As
> > mentioned earlier in the thread, the changes to scan_heredoc_tag ()
> > capture the input-stream position of the here-doc tag itself, which is
> > necessary since it would be too late to do so by the time the error is
> > detected by swallow_heredocs(). I don't now when I'll get time to send
> > this as a proper patch, so feel free to write a commit message and
> > incorporate it into your series if you want to use it. And, of course,
> > you have my sign-off already in the patch. It should be easy to add a
> > test, as well, in t/chainlint, perhaps as
> > unclosed-here-doc.{text,expect}.
>
> Thanks, I can take it from here (and I agree doing it as prep for 3/4 is
> good, as I can then omit a bunch of explanations there). Here are the
> tests I'll squash in (along with your $indent fix):

Thanks for picking this up.

> diff --git a/t/chainlint/unclosed-here-doc-indent.expect b/t/chainlint/unclosed-here-doc-indent.expect
> diff --git a/t/chainlint/unclosed-here-doc-indent.test b/t/chainlint/unclosed-here-doc-indent.test
> diff --git a/t/chainlint/unclosed-here-doc.expect b/t/chainlint/unclosed-here-doc.expect
> diff --git a/t/chainlint/unclosed-here-doc.test b/t/chainlint/unclosed-here-doc.test

The new tests look fine.
