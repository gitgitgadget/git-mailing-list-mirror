Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377291FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbdJTSx1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 14:53:27 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44942 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdJTSx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 14:53:26 -0400
Received: by mail-qk0-f195.google.com with SMTP id r64so15504618qkc.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZdIhny98RXWNJWWd/jGoKQemm+J7yp+KBnfXq56BIo=;
        b=E3rRSUWg0HDR0hmcxLfYWiHgo1EAT1lAivafws7EO/r2AIKqxinPF7a1iHuyHSl2B2
         t+fokFQP+crt6/LKkqhSTR//YhWxb9FOQBSeqlJclDSvpo3qvNSkh+HfejZW4t98LIyB
         su8YdXbAEpde/MUnmRoScCO2eo1gVJWZz/iPxdSjpHFJz2kEwBKlYewbawmwKYv3L6Oy
         f+UvCZcI3zcDf47fMNYkFPTF1Q2B0BEpnQL1VsfSzK8h8D4XxXphumuDGrIxHxLHXjVy
         Qh1BWZBwoUH+imSTDdxMaY+KCRB48REYwU6BuFTn4Im7e4XNcvngTk6LF8iaSM56nnJZ
         hz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZdIhny98RXWNJWWd/jGoKQemm+J7yp+KBnfXq56BIo=;
        b=IHCGdqr/57K+QbY7rSCRb7gzEdTZV/n3hHNqK2Gfw0yr1+4t2z08lujkzOjOKg/G15
         aOHn1AXiHghCgPwmiJ8YgzqKnfJTfjRRkQ3uGIBdRPeGmjvXnBWU0lkfOh/H57wbn8R9
         YpcNwB7l+5xsEGghl1few42NUGUfgS9cWhDPGrml7CEnq1gZQx+r43XCFUfRO9i6gfu5
         TP4y1uiIY7/Y9VaqIW7mKlka/SI1tE9TAIfhfsJmJqV2zRozjO3BFD7vi81dWgk3/JO2
         P+dZkwxK5RTKKdMN/wZzmpsCrGenRYCUzLzZOVPGIFN4dDaXowFiJ3t6/lqq+Gh9MCDG
         UTAA==
X-Gm-Message-State: AMCzsaV47eumGWpmB4UbOXwiADykTdD2lOxKBfg3cNz/1k9KnbJaqaTm
        LskOSk6OmXH59jU4rx725bAIdFtTVqt9PKl2N35Gjw==
X-Google-Smtp-Source: ABhQp+SxCBi2oyK5UGEj4iz+YQFJieI4npy8Dq7op2nYFzwlxzF4QUAxv7YsAtQuW+fT4CIKw3mBf94V1pAtAD6GMGU=
X-Received: by 10.55.175.132 with SMTP id y126mr8776129qke.45.1508525605723;
 Fri, 20 Oct 2017 11:53:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 11:53:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710201444590.40514@virtualbox>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com> <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
 <CAGZ79kZfw7Cb8Qs4BKuESukBL8rCgmYh0=BcNYm9mXJ1LYCg0g@mail.gmail.com> <alpine.DEB.2.21.1.1710201444590.40514@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 11:53:25 -0700
Message-ID: <CAGZ79kZ_WjnH-vM84C8cE-jS=V=p4tGSiwXX3cKwbDOUvUs_dA@mail.gmail.com>
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache
 entry order to speed index loading
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ben's original mail talks about integrity checks of the index file, and
> how expensive they get when you talk about any decent-sized index (read:
> *a lot* larger than Git or even Linux developers will see regularly).

I am quite aware of your situation.

> The text you quoted talks about our talking out of our rear ends when we
> talk about typical user schenarios because we simply have no telemetry or
> otherwise reliable statistics.
>
> Now, I fail to see any relationship between Jonathan's mail and either of
> Ben's statements.
>
> Care to enlighten me?

There was a recent thread (which I assumed was the one I linked), that talked
about security implications as soon as we loose the rather strict "git
is to be used
in a posix world", e.g. sharing your repo over NFS/Dropbox. The
specific question
that Peff asked was how the internal formats can be exploited. (Can a malicious
index file be crafted such that it is not just a segfault, but a
'remote' code execution,
given that you deploy the maliciously crafted file via NFS. Removing checks that
we already have made me a bit suspicious that it *may* be helping an
attacker here,
though I have no hard data to show)

Sorry for the confusion,

Thanks,
Stefan
