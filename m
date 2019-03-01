Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DD520248
	for <e@80x24.org>; Fri,  1 Mar 2019 02:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfCACuh (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 21:50:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCACuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 21:50:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so24176248wrt.11
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Y31DX9DcDwoZ/Jd/73fAjvJqkngJEOssFMiklZ0LX80=;
        b=VKGOF3hwumED7Jqhduz4RBL1UprVw4IALrBiGD6dL4Mwl1LAN2XCJHwIDPOydk44MD
         eDPgVuzLZPZOoYkJg971oVDUgPjHpN6+/1YNa+DbrjQaLxKz4b9INBzKuuPWFyEJVKGA
         xeDjRZTVvnLNfsQcvK3oODriydI+nJCFe22qIG2DJ/WJiAI+jrgEoQQil/u1qU3A6bIJ
         BJIJLY+erxIS/GBfEJODrRSVfmQhz3v6Oymk11ZKnsBzlaxs1z44Hmk4eV0psWfFECUX
         9Il6zAwkSKKErBCQb9CHJ2RIXodbAyPZE19Msk9djekwDI4Bvg8vm6ioWspUcYSu7d1m
         uGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Y31DX9DcDwoZ/Jd/73fAjvJqkngJEOssFMiklZ0LX80=;
        b=IkvrYxSlHc5tAwk5XK2YwtLaeDPx18UN9wFECKZlqgfFA8yMuIw/AL8CYrWHSlPxDg
         Gbon4Ew6sWXXwv6im/gUw4Vl/iaHrWVT61n7z71xVecIxBGehpNWCJfRltpxel1kmwfd
         h9jnXXE5MWXLUNbBQ9KshgUoVBEkJLRg5W0u/pCgofseVTrOu7Pac7bKKtmMyIvYGG2R
         u22hmYcz3e6QuNPjj3LzEX4TDYzsNRFuLc2yiQuZwUL7SuWtQ/3SLbWF7kZsNfhEaAyS
         bR+i49uBGRPpu2I/Q3A7l5xudBXpodSePQzscd7Uc4nZ9cQCjy2TGWrMCYtWuxvglvdw
         RdsA==
X-Gm-Message-State: APjAAAUGgm5XTILGKUPi87saEJ8h/uF9ucvsEYwNADeBTfYgibO9pbwD
        5Fwxa3I1wzxXYcHJd5vXO7U0QbT+iuo=
X-Google-Smtp-Source: APXvYqyhPXkdk0zzhRdtfcTRgU7U5CNAGOnEgOWjrWU5uQh72Bu+h5CSWKmojufJ1AYY9MHkszEJKw==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr1666418wrg.156.1551408635426;
        Thu, 28 Feb 2019 18:50:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g24sm8485621wmh.45.2019.02.28.18.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 18:50:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/fsck: discuss mix of --connectivity-only and --dangling
References: <20190227145549.GA3255@sigill.intra.peff.net>
        <20190227145928.GA3727@sigill.intra.peff.net>
Date:   Fri, 01 Mar 2019 11:50:31 +0900
Message-ID: <xmqqlg1z9uko.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm actually a little torn on this. We could consider this a bug, and
> the "option" to disable it when you want things to go fast is to say
> "--no-dangling". That leaves no way to say "show me the list of
> unreachable objects, but don't bother spending extra time on dangling
> analysis". But I don't think I've ever really wanted that list of
> unreachable objects anyway (and besides, you could do it pretty easily
> with cat-file, rev-list, and comm).
>
> So I sketched up what it might look like to just fix the bug (but kick
> in only when needed), which is below.

[jch: I am still mostly offline til the next week, but I had a
chance to sit in front of my mailbox long enough, so...]

As the primariy purose of the --conn-only option being such, perhaps
we should have made --no-dangling the default when --conn-only is in
effect.

But if --conn-only is made to do the right thing while showing
dangling and unreachable properly sifted into their own bins, like
this patch does, what's the difference between that and the normal
--no-conn-only, other than performance and corrupt blobs left
unreported?  Perhaps if we are going that route, it might even make
sense to rename --conn-only to --skip-parsing-blobs or something.

Thanks.

