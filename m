Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F252035F
	for <e@80x24.org>; Fri, 28 Oct 2016 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756378AbcJ1QNq (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 12:13:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36841 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754973AbcJ1QNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 12:13:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id e12so1081671oib.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dyjOGtQAaC+GwZBuzeTaDHvFrIAZB2+nvUZP8Fi46Mo=;
        b=TEMj2oZX9UB3M5GajpB6hvxtE00z5uPgO96YKEsCqYqk6+OowUTPyZabs5sRzkpI0n
         6xBoBVD/EDqJTw82UukJyTEkcgm4a8KrV/QismICa0j43wOpvEBBYyH1132AN7HRP3d1
         zHac+4g45M1S/SAB1p1mBewPlmYU6kLvZf7TH8zaXwNLFjInBFlV/wz8byon137eW6Jx
         OIIchDmH+RsgtGVzHWHc+r2LjYZgXLn3uc0zazv+mxSKHtcS5dPW2+vQuSQ/6r2kGNtH
         AYt6Vjn7C/fftT7fA2YexgopYdowPzvurc39yA2gyvqeBZcgX1zY7qjVUS/FNgbTyx27
         cnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dyjOGtQAaC+GwZBuzeTaDHvFrIAZB2+nvUZP8Fi46Mo=;
        b=ljwsKuAPfltr1omucf1Eh+4X/kLLSVkVJpjduKuQ34SaWYgm6gqX/5MWHyyqLGPpKT
         VUBs+FaNMcKAE4rd/52snhMoxOBT+qGExrgaADsEKT6g875nHZnj04YKxtv/Sg/D2GTW
         WDVGtIirtpKRg50zaVb9bBK/RsLHkq617jLKOGaoYVMhvDAfHInsyrfO3LeBqImVL82h
         0YMYLJ+OtuDt0vvs7hTy+Me6NrnF6SrM0y5rQK9CMbHCZQ3ZBXKTsU4QS4+A5prFGcUi
         Yf285qHXjZtPs4keAlBxdfLK+AWj2y+7i/IFgv5qb1Pd4LYBwQIeT8dxlC+kzYB2Rml7
         aG2g==
X-Gm-Message-State: ABUngvdzNhOEeeZ5BNw8O4myuVjSOf1TQU0PvxwsL5G/x1Lcmks6ExYx0H1R0bMR8fskR9RCUmBk+NF8Wp5CwA==
X-Received: by 10.157.43.124 with SMTP id f57mr11945038otd.83.1477671222928;
 Fri, 28 Oct 2016 09:13:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Fri, 28 Oct 2016 09:13:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610281306320.3264@virtualbox>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com> <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
 <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com> <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610281306320.3264@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2016 09:13:41 -0700
X-Google-Sender-Auth: BgkujBz8Osdbj_vzLtqwxoCdN-w
Message-ID: <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 4:11 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> You guys. I mean: You guys! You sure make my life hard. A brief look at
> mingw.h could have answered your implicit question:

So here's what you guys should do:

 - leave O_NOATIME damn well alone. It works. It has worked for 10+
years. Stop arguing against it, people who do.

 - get rid of all O_CLOEXEC games. They don't work. If you want to
close file descriptors at execve(), you - gasp - close the file
descriptor before doing an execve.

So O_CLOEXEC or FD_CLOEXEC is broken.

DO NOT BREAK O_NOATIME JUST TO ADD COMPLETELY NEW BREAKAGE.

                 Linus
