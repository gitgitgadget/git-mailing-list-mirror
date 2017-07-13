Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7AA3202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdGMTfy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:35:54 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36209 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdGMTfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:35:53 -0400
Received: by mail-pf0-f179.google.com with SMTP id q86so34071250pfl.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=83RMwU1ulyJZnMMYz5S+V00dAP2g/YAlsH9T8be2TDQ=;
        b=L2p3N5piqfLHJAuRvCcZoIATiOuOxlit2b6EjD3wAmsH91BI2ahr6OmQsplLs2m/tz
         f6Ra5CV/yBKKHkoPtidG7fXoicGbt1U0SFZVD942jIUXsyoqcjkSftbR2XB8hv/QopAa
         Ne/1WjiNud3cy7nDWzM2v8A+0MTIUFm5w7p4+m80AwJ2z1sWpWD6ltwL81XdaOkk+PkM
         2QNacmxHnuYc+Xd0v+Ky6x0/NFYOdvtzYOAa6AucIrlmFvCDPQWuKf1UB97viTrCI4Bg
         Y1P8KUED5TgxxLPuD5i1idco915ucSsMEjJqCEmu+fbaFYIY9AGZyri3KxPMo9Z6oaqa
         Zwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=83RMwU1ulyJZnMMYz5S+V00dAP2g/YAlsH9T8be2TDQ=;
        b=l7I+8PsC8gjIUNXpcHx1SFxXIEhDutC3d/OUF+WhShMFyol3cE7hGD7GcDWUCAI/GV
         vWwGM+wOlAtyz44brqs2R8ODbd1y0jgujJRJlK5KJ5d36D9yA63UAGnjy7f2lDphyaGh
         a/1Eo5DfPJK70e5g1xaBpZ7rf1OyIATqLBFinPT1ZT15M6KL4Hy4sLTIVWvTnV8kI1/x
         IZsjyjXzDCSGFUNxxqyS4oABWvibPlLjStJA3PYMExwUrKwQVt/vIXv58gXbyljQV0v5
         I5ONLSa8NAQBRyfdVCyjL4kvqrJXo6JxdXrmF67WfsKJbCHjVaEO87zCMnbR2qXYQRG3
         S/zA==
X-Gm-Message-State: AIVw111bwRkbZVW0t8RgOHhm/NKJVbWSAkLhnzLjJlcbIkKqgGeekiTI
        LmcH/kHx1pzEBQ==
X-Received: by 10.84.129.132 with SMTP id b4mr2181269plb.12.1499974552427;
        Thu, 13 Jul 2017 12:35:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id p68sm15736503pfj.26.2017.07.13.12.35.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:35:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>, roeder.git@mailnull.com,
        git@vger.kernel.org
Subject: Re: Git on macOS shows committed files as untracked
References: <20170712222128.A2F7A246E3@outside.256stuff.com>
        <20170712231557.lu7ppj3bric2fahi@sigill.intra.peff.net>
        <130b338b-2e77-65d6-a3fa-f272ac43b81c@web.de>
Date:   Thu, 13 Jul 2017 12:35:50 -0700
In-Reply-To: <130b338b-2e77-65d6-a3fa-f272ac43b81c@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 13 Jul 2017 10:42:29
 +0200")
Message-ID: <xmqq60eww2nd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Thanks for the fast analyzes -
> in short:
> what does
> git -c core.precomposeunicode=true status
> say ?
>
> The easiest thing may be to set
> git config --global core.precomposeunicode true

Good suggestion.

I learned a new thing today.  I somehow thought that precompose
trick was only about argv[] when a program starts up and did not
apply to paths readdir(3) finds through dir.c, e.g.

    $ git add .

But apparently there is replacement readdir() used in compat/ for
MacOSX so the paths from the system are also covered by the
configuration.
