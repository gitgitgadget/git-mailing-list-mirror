Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BE61F453
	for <e@80x24.org>; Tue, 12 Feb 2019 11:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfBLLPZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 06:15:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfBLLPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 06:15:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2215526wra.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=m+eODXweHTK4CzscaO/raLDaXr0CPPcyJ/1GDC43Lck=;
        b=fLRMqLguH2XEziOpt4H5xy5c2wNib+ceMVfiXALxfKwlR3vIm9nvk88zS71cwtvw2A
         OW/M5wSEIOO0s95w9kYyHAwLuwOORQwwKYgcj7HwqDNSioJ/ZXd9IPEj4xoJaeAHahXK
         /0Gj2Rlh8YHg0yMflUPWliV3gn5K9sNyI+6BWOXDDuXzaLFRTi20Jh//Esv65z0XEifh
         SSV773wmYJVbaPkQJflqq36JCawZCE3MbcE4CStmm3tNSuRWNLUZHuPWRQa9zaO7/l/F
         UF2I78znblgiKaFun7pU7F2yJhdooh7f+E3hLFTamfz/7FWw5A7OKFrrmxi83BQJqnCL
         Xj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=m+eODXweHTK4CzscaO/raLDaXr0CPPcyJ/1GDC43Lck=;
        b=JgYD7a7Qdd0pNhHYxsa1IRSPbp0tXOe/hdKc9Hjhx6+q0z2c1i7Ht55lHpblcyKvM2
         kclbJCPdcCkJnESrGxQHHXQebqXN3qOeOf0TYzBN/bp1cP0rlDwSz/fpzflc1IBAbJmS
         WFNa45lKjHpl+WhgfXi9+aAR1aVM8jiV/nZRr4MC/64tkqEGCaPEliP0nk5hLtPJ2ZRs
         VJWBIYHxGqG9r4q20a7eXpwBN/fpRlXbNxG1DgKi8F2weQgstZM3VWwoLKybDie74Rib
         D+2efiQq7+N3GSAGPC2X403vAk+oRKJOmsJi/rxIkKqX8Mxa0RW/FNqkw+s/v7BLDUme
         DWPA==
X-Gm-Message-State: AHQUAuZ4raJGzryezSszdlgnAduIGTP4VT/4H3zSLBYjN1PHN93ahAHk
        Vc4uh9Y4qcnuxd9sFwfJFTR8DcC+
X-Google-Smtp-Source: AHgI3IbYhKATHTb1Bn0tgSMGSbWXgUIhWL/gJMh+UWqlDw2hNtCwmig+jPMtv3HxsSokbFyIYtAqBQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr2528144wrn.187.1549970123508;
        Tue, 12 Feb 2019 03:15:23 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id x186sm5119825wmg.41.2019.02.12.03.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 03:15:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/31] Hash function transition part 16
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
Date:   Tue, 12 Feb 2019 12:15:22 +0100
Message-ID: <87tvh9jm0l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, brian m. carlson wrote:

> This is the sixteenth series of hash function transition patches. This
> series contains various fixes, mostly focused around the pack bitmap
> code, the HTTP code, the archive code, the index, and parts of our Perl
> code.
>
> This is the second to last series required for a "stage 0" Git; that is,

I skimmed most of this, but decided to stop when I came to "am" since I
was just going to start repeating the same question I had in other
patches, i.e. for the parts of this that deal with on-disk formats how
does just e.g. search-replacing s/40/64/ interact with needing to read
existing files (bitmaps, "am" patches, untracked cache etc.) which may
be in the "old" format.
