Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850C61F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbeCMSgf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:36:35 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:38623 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeCMSgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:36:33 -0400
Received: by mail-wr0-f175.google.com with SMTP id l8so1725643wrg.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kgJgbqGP5b+WZiKHfuvnjmFyLoJYa1tUgeQCmILpUpo=;
        b=r06YfqR5MrXNmm5U0uNRvX52yTmwIZuocxxiiwNTEKA5JvLJ4g3FrYWpD/tDWxm7c3
         dFzKGXgR+sQwr81kGuaC5W/Hg8wwhWHg36bcR3IywxcpJBgwrb7vMQ4rhgmesg7/JNgc
         g4GjWkHCwT5jlrXdMDJrcnnvF+3pBEvygyM0orD16WnuxThiy12bbYmCaaFK2DVT9bBF
         z0Nu5ORRXQvFzpHdqLZk9N0v0WHPP9s2UKI7I7y31/BpqnMKMJbKa4pVbxGXzSEmDICH
         LfMjYujAHK3lZ3nkAPtGdyXTd+5kOETe2FfE2HZHvBqKO54ag9XgsOS+ob52SDc9bgC5
         ND3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kgJgbqGP5b+WZiKHfuvnjmFyLoJYa1tUgeQCmILpUpo=;
        b=VYa1N2LwkcPRLzZnqKStfxouItGlaDCGAGA4FvYFqjDYkRQaumtI4ELPfBNqbiYLYl
         QTy3xl7umMVJh3gYGyKC/L2lr86No1aEDRsJwhm+xuydIqlzHrerBqF2vS+z8vy8fhhX
         abBm4zsHnfCKzC9+glMBAdsyk46d0a7pgKRmEqvcwwI8NHm1TY8YN8vIu073SMVmO91+
         vCESVKDPs5yZpMtyEyIBdB+C0BMmBr+KwWe4GkDD6GmZd2Kwsz7WkNxMLKr8eXlNulD2
         9z8OOBUhf3+kNWmuXQ2yvhWc2HvBGuAdSOwf8LLvOTbJsQw7tGaOroSjyVvyUVNbk9YQ
         rLaA==
X-Gm-Message-State: AElRT7HR/mp0ZvB409m4qjm8bfdanwL5QLfact/+RWqNMW05um7k5pnh
        5UznD/KR2TiAGBAf103dJAc=
X-Google-Smtp-Source: AG47ELtOV8JaBvzvEx1pGbhGK2LHI8jQi108k/CayGdr6VM3PGz+AGQXzYVvdifrwJzt2QYx0wMrUQ==
X-Received: by 10.28.143.148 with SMTP id r142mr1692630wmd.124.1520966192149;
        Tue, 13 Mar 2018 11:36:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y129sm929293wmg.5.2018.03.13.11.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 11:36:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Why don't we symlink libexec/git-core/* to bin/git?
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sguorb5.fsf@evledraar.gmail.com>
        <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
        <87y3iwp2z0.fsf@evledraar.gmail.com>
Date:   Tue, 13 Mar 2018 11:36:31 -0700
In-Reply-To: <87y3iwp2z0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Mar 2018 13:36:03 +0100")
Message-ID: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Related to this, I came across this bug report
> https://gitlab.com/gitlab-org/omnibus-gitlab/issues/3265 which is
> wondering why we're installing N copies of the git binary, presumably
> they're building with NO_INSTALL_HARDLINKS.
> ...
> But is there any reason anyone can think of for why we shouldn't be
> figuring out the relative path and symlinking the two?


There is no fundamental reason not to offer such an "install" method
as an option; unless you count a more philosophical aversion to use
symlinks due to (perceived) additional fragility, that is.

The resulting code may become messier than without, but as long as
it is without the reasonable range for usual price we would pay for
a new "feature", that would be tolerable, I guess.
