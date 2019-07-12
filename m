Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B061F461
	for <e@80x24.org>; Fri, 12 Jul 2019 16:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGLQR1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 12:17:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLQR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 12:17:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so4739273pgv.10
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8RRTnCSZ9ICqT4tLcL0tvkfsCBPQppjyU5Dbc6LUPs=;
        b=Dx5SvkgwJq3/HdHy/67RTicwaD97bB6pk9BEvYt1n0AQLrMyD3pGecrMNdfJ3W8ZXp
         QzQgH1K59UaJwlWDKL7Sn6ZvymeRQXbYTCxgfos52+4ExMs1qa/uuFe10lNA1Y4riFCO
         wR/xUJDXNVZzFrdDvWV4M3uMZ3FLuTW8FkoCTtU3mMZPHo4vycuIifinFq199uTJREgV
         FYoiHeLOO1c/Lt0xHtXEnuG/ECGA1CAHqzqBihMWCThnDXY6LTeR/nJFWXr59kiTPQUk
         1j7J3UwkpOmwE8AU7o4WhRN/58b1kLjyILCV4ZfO5FTh84tk4TPcEwcnxBjmt8O76GbU
         CJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8RRTnCSZ9ICqT4tLcL0tvkfsCBPQppjyU5Dbc6LUPs=;
        b=jiNZDHRnwy2rogO9tfuwD+wRSO49Jrq3EHx5HwZd5xWuiuKc3VWvrxkNSv3h4i79HO
         3rPLlTbDqWXrBAjY2VxxD1y4WlzDO7iVB0SUI3zmAEmd1aZ7I3R9wJY/HUucphWRYXmb
         6BZwYo0WNGUtY9TY73KOfRw5bOQ06ipWxE/raUQlhWSzhDznhCLmpId3EU96iGdVYsNa
         dc/n9xRn6EHQpoSKgiRLkLs3wZ5lr/SJxa6GPpzBGcYvp48AoBvee/tAanEzUtx16Q8X
         Xdi7IQcoBtpmY4drUpsGyxlDrxbXK4ctsHznQR8GvUTruRzY7p9CzdAq7kBRWxABScB3
         80IA==
X-Gm-Message-State: APjAAAVNN2A6LGyolb5OzNCtCup5DVOVd5PZFguvbwDOgZN/hQLWO1qN
        wsj+NBQf/h1n4+aWdQTSqgYwBM26WCO6bdbK4AIHgw==
X-Google-Smtp-Source: APXvYqzRK44ZkwVdK5F/lyQoBrAey9d4U+EBARuAc2txOLLefhdDEkqRoVhu1xFmx6hmTpfMOc39oLMpLyYF2FB7P6I=
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr12347521pjq.69.1562948246317;
 Fri, 12 Jul 2019 09:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190711183727.8058-1-ariadne@dereferenced.org>
 <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com> <xmqqtvbsqs9x.fsf@gitster-ct.c.googlers.com>
 <CAAOiGNwGqtSoG8vsy+3gb0=tDVvA1YcA3FcDP0KQMa0=xp5j9w@mail.gmail.com>
 <xmqqblxzqqw3.fsf@gitster-ct.c.googlers.com> <xmqq7e8nqpe1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e8nqpe1.fsf@gitster-ct.c.googlers.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Fri, 12 Jul 2019 11:17:15 -0500
Message-ID: <CAAOiGNzXqcNmLO6GSdoVWc0zjGKKxz7tvr_xds=HfPNBSYFUrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Jul 12, 2019 at 9:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I do not think we usually do this without having to say "at this
> > release" in such a warning.
>
> Sorry for horrible copy-editing that made the result say 100%
> opposite of what I meant.  I am bad at negations.
>
> But I hope the mistake and the message I wanted to convey were
> obvious enough ;-) We've done this without giving exact timeframe in
> the message.

Yes, I understood what you were proposing.  I believe I have added an
adequate deprecation warning in the patches I just sent.

Thanks for your guidance on this!

Ariadne
