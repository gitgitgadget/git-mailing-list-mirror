Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C3E1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbdEPR3d (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:29:33 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36360 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbdEPR3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:29:32 -0400
Received: by mail-oi0-f47.google.com with SMTP id h4so34277079oib.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9/hXuMBoNYFBC6447Y/3vldWv+BvhGUHN3C9gNsZ05w=;
        b=rZufgT0P3ZLUyg0Is50ZELDpMhYtOVvmNAyL2SI9mpz54AAgwZXjMDVdplDW5a6DSP
         cjk34qjgbeG7WlowsiWT7I9XwnEvMVsyYaxCewdslbVu0LynLDfu5yWPw0j+qEAgqJu4
         ac9DzQXfsqylM1Mu3MKqfocshvpZfojuStEG6lCmScnytxM4bKobeAK7zM6FUnVnBwfn
         ozkkxq8rY9ksUCNfWYp4MJZCF7yuVP6zmG/VYOP6eeQRp9F5SmJp6aXm5PBIXToksxdA
         rP3N7oa5a5nh7tvYvfsq3wB+FOZAxFYzsKguu2iu7zxwiSZYizaJsA7npiOlMdFJNQFH
         jSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9/hXuMBoNYFBC6447Y/3vldWv+BvhGUHN3C9gNsZ05w=;
        b=moJDPkJDDUlfRGUgw8Sjk/MEnjUKogQP6hD8lXfIw97pji2XpzjVZ6iFPS2XUYq+yZ
         pqvo6LrJ+aRzXfPIJJhK9pUpnGAGBlmf5KzXr6bfGzqDwwufajSjg+D57ykvyow+FIfj
         uyAM5r/IlvtLSSad5SWobWY2kkh3afZaq2yEU9ZN9huvpQ44UN4Z+BWxZDOPMNwo5lZc
         Vy6foB23jh5FIuu6Px4kJ6U2J/JY/Z992IAca0kHoe3YAwir9Esp94PK9yrUDR04/Dxv
         JnWzAxzGr+wSt/Ehmss4mo/Xq0nri6OIOiABQyqCQm/oG7+/GtJfvTkdILdbBLyIXa2R
         OE8w==
X-Gm-Message-State: AODbwcC+zyA3TKCRvgQzbWP6mD7jiWyk1Xuhbbq1apZ4hO+7w/MKOyEN
        hfe33r18pJnIxR9rNWXKHe914YNn4Q==
X-Received: by 10.202.87.2 with SMTP id l2mr2228236oib.200.1494955771912; Tue,
 16 May 2017 10:29:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.54.53 with HTTP; Tue, 16 May 2017 10:29:31 -0700 (PDT)
In-Reply-To: <20170516171414.GC2169@alpha.vpn.ikke.info>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox> <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
 <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com> <20170516171414.GC2169@alpha.vpn.ikke.info>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Tue, 16 May 2017 10:29:31 -0700
Message-ID: <CA+zRj8WFuqaNV_6U5=VUrEmeQ_fNaRs8mKxdSd=Z0QMyGk4pHw@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Kevin Daudt <me@ikke.info>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:14 AM, Kevin Daudt <me@ikke.info> wrote:
>> A transparent optimization that tries execve() then falls back to the
>> user's shell sounds like a good idea.
>
> It does not really work that way. Git runs in a separate process that
> does not have access to your current shell. That's why you need to do
> 'export -f foo'.
>
> If you want git to be able to ecute the foo shell function, git needs to
> start a _new_ shell process, which reads the environment, recognize the
> exported function and run that.
>
> This is not the same as git executing the command in your shell. Not
> exported variables would not be available in this function (as it would
> be in your equivalent).

I'm sorry, I didn't mean (or say) "my shell process". Indeed, it
doesn't work that way. And to be clear, there is no problem with
having to "export -f foo". The only question is how should git run the
<cmd> passed to --exec: should it run directly or using a shell?
