Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC75720987
	for <e@80x24.org>; Thu, 29 Sep 2016 19:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbcI2TG0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:06:26 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36375 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932603AbcI2TGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:06:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id h186so1400568oia.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NCOtw2lSPg0dMsgGuepqXCjkhkP4hs6vHRbjggFi5R8=;
        b=aBD0d1nT/6ca37+CopAvqWqTqOv+biRvlMLiSrVWd+PNf0m/dichJx6jrBzI8KCcYj
         axaEkKyrrS9VeDe27yFx7CC18s+RmebWTWcSAC5NwqwWssWQUyjzjqzWJENXYrJk/7hW
         JSIEmk+boTqQUWlGDAQpckXqZIhdYPIp1W1gSgn45RqvOM3W6BlNGB1YF8x8dPuGSX5Q
         03/5AJ9648JkSNyFdUrcmAH+Ro9XR8uNjElAl7d4DET/irV3U0ujxguXOgc1oE4Dk3RO
         /j0q2HTmCn5aTx6+W6fG13BWUpTsaxu20LpJewT35vCrnnKvbuF7B6Z3RoV61uumOuqY
         T0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NCOtw2lSPg0dMsgGuepqXCjkhkP4hs6vHRbjggFi5R8=;
        b=JW1eSn09fk4m1f+E/d5q0CI78pFlh/FoQjyXOTTvAG6OmMDEJNoWWIrUlOH9U/gS06
         GF0BfOjEde+YIE4VGWCVJZhmGDIFnTi3SYC30F70Ew9kRGDRkrdfF5VGzXAaDOGYvW79
         fX+OVbIU8koXnNLkfH56DElVQjZTpbAAC/YL3J+SoK7xN+M2DQYNg4EdnjHETadGdqhk
         LpD2uRkF9cX00VYuDOsiOg6C7WuEwQY5rFo/qwnSR5kAr4pAWL9TL/WKn2dsO1IH1wAo
         AqGp+juOtAC2/yLQZCtqW8q8s9LLx/ZkKfXru3NBR76IwzQ3rV39RfVZTC8HG8y5Xsa3
         Fmcg==
X-Gm-Message-State: AA6/9RlvycB1bPyzmyHhuWIoITpdHU9m1Ltdw8/gHn4pcfmOOv1s5zsgpFD4Ew75yYwsUcHIyNLlJIKI0QDf5A==
X-Received: by 10.157.43.124 with SMTP id f57mr2344805otd.83.1475175984059;
 Thu, 29 Sep 2016 12:06:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 12:06:23 -0700 (PDT)
In-Reply-To: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com> <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 12:06:23 -0700
X-Google-Sender-Auth: 4jBW1HDkqqWZXKsvmjTxlEdJCSc
Message-ID: <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 11:55 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For the kernel, just the *math* right now actually gives 12
> characters. For current git it actually seems to say that 8 is the
> correct number. For small projects, you'll still see 7.

Sorry, the git number is 9, not 8. The reason is that git has roughly
212k objects, and 9 hex digits gets expected collisions at about 256k
objects.

So the logic means that we'll see 7 hex digits for projects with less
than 16k objects, 8 hex digits if there are less than 64k objects, and
9 hex digits for projects like git that currently have fewer than 256k
objects.

But git itself might not be *that* far from going to 10 hex digits
with my patch.

The kernel uses 12 he digits because the collision math says that's
the right thing for a project with between 4M and 16M objects (with
the kernel being at 5M).

So on the whole the patch really does seem to just do the right thing
automatically.

              Linus
