Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019201F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfBUVjt (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:39:49 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46855 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVjt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:39:49 -0500
Received: by mail-wr1-f42.google.com with SMTP id i16so73533wrs.13
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GE7XqaYx+gWZFtB+bBpsmTqRxUEVlnig2fiRkERJUEQ=;
        b=LfQT+TUOyqBc8YImPQRBddok+eH6f5r+4p69FDBY8cQlbjG3zeAyAonGS8x+thCHV5
         IfLKPt1EOIumq9P/5hM9EpGwVGaxbaRKY+D0sT4gKeuMOETXaQKC9tbzqvr02liRPNKV
         n08ruWiFxJMuqRct2L1WZfoIIn9JwNE5lbNNRKyBA9cf6dlG5/3FXmtT/Ki9kzzIjjLn
         FKMqZMVJJraA/4VCEf4boDQABdvwF43Oh9/CLaglccumgtnB4ZaGNtmGt7sVDm3pWDu8
         8QQkUl2VjYd3O53zXn6XeaLe6NURwC2pd+IEeCr8dspuUANKyi+0tjl2d6c1v0oKBuDg
         usRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GE7XqaYx+gWZFtB+bBpsmTqRxUEVlnig2fiRkERJUEQ=;
        b=H9zI42wXyfH0e2ueHp0Trnw5GO56+6rP1Fop5KCjp8nORfVqrxcxg0CPGq+4xCCkDq
         0IS9AVXk7psCxKNGg9gUIHg7JEUkGJBSq4le8aE4AkCyNeN6Oz4qsZFmAZ/h/3ONfNyV
         o/td0XbTbhHGfVwoccXgbFrftChDNwxyEbkAvQyBfSzrtlDBhvDW+KtWMl6ykn69Spa8
         c+ROqp5NcnDYZ0ebGQMaRK3OReie/Grf6GbDgUpx2zaYQ3VSQPES3oIEkEAQF4wfdKxM
         7pZPt6pzFoMjFp4iQnuxqzbKrSElpdKdTObvVyVfDhW7waPJwUGXzfBj9EygfR/475ox
         4abQ==
X-Gm-Message-State: AHQUAuYmPADE7zMYoBLVa2rtFzAe2dk0P9W3u9KtRNqlib8SZj4aASij
        cyoaYOwJwtuWNh9K76FdZB/bU1uN
X-Google-Smtp-Source: AHgI3IZ1TKDgO4zABuLqeLtebM6q1QHM29r3R313tDVjEi0FjzfpMbALA5mCD+3NXa/5TmQBPpzrmA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr430597wrc.168.1550785187342;
        Thu, 21 Feb 2019 13:39:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p16sm1009wro.25.2019.02.21.13.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 13:39:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bartosz Baranowski <bbaranow@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: git bisect - good vs bad output is different.
References: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
Date:   Thu, 21 Feb 2019 13:39:46 -0800
In-Reply-To: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
        (Bartosz Baranowski's message of "Thu, 21 Feb 2019 11:47:29 +0100")
Message-ID: <xmqq1s40u8gt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bartosz Baranowski <bbaranow@redhat.com> writes:

> Depending how you end bisecting, result/report is either one liner or
> dumps commit information:
>
>
> $ git bisect bad
> 77c044d8d66f9f9bebdb805853409e920e537d59 is the first bad commit
> commit 77c044d8d66f9f9bebdb805853409e920e537d59
> Author: XXXX
> Date:   Tue Jan 22 09:24:02 2019 -0500
>
>    ISSUE-11626 Bad fish in the sea of comment
>
> :040000 040000 ef2280aa5f7e0c23f8750c43a0bf05c0a9639fe3
> f63bea979784cade7dffd653d939f665ff6a53b7 M      clustering
> :040000 040000 6f4667c819106f6e9ddbb902253862212a2558f5
> 4d8c4dc85872c0665eb77957a6fd69c49c173188 M      triton
> :040000 040000 0400075b3d5f7cb9e68683b25b8ede93fb1b293b
> 35ba4c831c4834f9ce612e394621dde382bc72f1 M      web-common
>
> vs
>
>
> git bisect good
> 3a9388eef42efc87c78ce22158d55e69a278b4eb is the first bad commit
>
> git --version
> git version 2.14.1


Are you sure (and if so how did you reach that conclusion) that the
above difference comes from the last 'bad' vs 'good' you finished,
and not comes from the difference between 77c044d8 vs 3a9388ee?

At the end of the bisection session, bisect.c::show_diff_tree() is
called on that "culprit" commit.  Is it possible that 3a9388ee is a
simple and trivial merge that does not have anything worth reporting
for "git diff-tree"?


