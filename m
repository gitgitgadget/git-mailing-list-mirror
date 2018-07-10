Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68D11F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 22:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbeGJWVR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 18:21:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45559 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGJWVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 18:21:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id a17-v6so2382701plm.12
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ut9pgpb57yOJz5fbUXQzlRdJuoLePFJ0F2HiTr45YA=;
        b=O8zRRckZV7kr9XhAsovzi8/i/d4wB7jfIFgQa0hSp+IBIZV3jVEDVJpJ3kDgylEU+0
         v+Mf/7IAL1VXGf5p3QXRmvJTZvmj2pRbMQbJeGPqZ6oJHTcHligO9G6NcGQRNmWyhc2B
         2vHjIoXZCWmOfz9HRIbDUfQN1k4uTb8PLLttupB76kwUniPga6At2rnteZMpq/TC9Ems
         ZvdI3a7sZiaallO1ybb5um8Nq7TtK/X6MmiiYjztnBC1S43EOulxhKwt/X0dXuz7rTfc
         LBERuDbfAao5ea9mXX0LjLIs0ADJwDGFeaod2rl40DEa3RMdEjbIaovfSwJTCsmoFlO+
         BjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ut9pgpb57yOJz5fbUXQzlRdJuoLePFJ0F2HiTr45YA=;
        b=NGXU/iCSJ8yiJTfpW/t9NTm7yOpgCy6eVMwb66Z8jPethyPFW8vlMM3/rvmTABl4Dx
         2qBIAmqdmYdZQuSF9niie4ze8C699RvRjUyH/vceOgzUUhY2ahHy2am8fRcX54c6dhum
         RtN8mw6fZmWFIak5CnPoBQVkDncJPWVC8UYzDB3nzySyv3q8jTYOnWpCVYVjZr6+1yMh
         Te8f64Hv8sVyit1ET5yw6Gfn2Nvtkjmg36a7p7mpWKWXJpxzkXSinrFObd7JlXMRLreS
         dre9gchhHXr4F09BRHTZqT/R48Y5OpCEXIhP2bB8eDxjD4BU3YYSFYuzg9nGxYas+fJ/
         +ymQ==
X-Gm-Message-State: APt69E03iTVxwlYcPrsbWBYKwJ99OgUfGshezJUMFfdt+c/5a1psrrtT
        GFFl4e59WvGGfVZ59JoL8nQ=
X-Google-Smtp-Source: AAOMgpdOJuHpp39OQAI7UneyeeluHabJr/X1IXt59THeiwBXn4Xf/ReDpx7hLOkQhGGvk2yxxXUzXg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21-v6mr26433295plp.168.1531261207835;
        Tue, 10 Jul 2018 15:20:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g11-v6sm26014443pfh.63.2018.07.10.15.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 15:20:07 -0700 (PDT)
Date:   Tue, 10 Jul 2018 15:20:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Perry Hutchison <perryh@pluto.rain.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180710222005.GP14196@aiede.svl.corp.google.com>
References: <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
 <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
 <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710140310.GA9246@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> My point is that aside from RUNTIME_PREFIX, we don't need /proc. So
> somebody who currently builds Git with a static path like
> "/usr/libexec/git-core" and runs it inside a chroot will be just fine as
> long as /usr/libexec/git-core is available at that name inside the
> chroot. But if the build starts relying on RUNTIME_PREFIX, it's going to
> regress their case.
>
> I'm not sure how hypothetical this is. A lot of Debian tools use chroots
> to build packages for specific releases by basically installing the
> distro inside the chroot. I don't know whether /proc is available in
> those chroots or not. If not, then I suspect builds that rely on
> installing Git inside the chroot are going to break.
>
> +cc Jonathan, who maintains the Git package for Debian, and can probably
> say immediately whether I am way off base. ;)

The chroots typically have /proc.

Various libc features also count on /proc being mounted, though in
general libc tries to handle the case when it isn't mounted
gracefully.  Similarly, various features of other tools (like bash's
support for <(echo hi)) also rely on /proc.

If this is the main obstacle to enabling RUNTIME_PREFIX by default,
one option would be to make RUNTIME_PREFIX fall back to a hard-coded
path when and only when git is not able to find the path from which it
was run.  That would increase complexity, though, so I am not thrilled
with the idea.

I might try enabling RUNTIME_PREFIX in Debian experimental's git and
seeing what breaks. ;-)

Thanks,
Jonathan
