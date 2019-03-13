Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A9B20248
	for <e@80x24.org>; Wed, 13 Mar 2019 02:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCMCHL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 22:07:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39781 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfCMCHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 22:07:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id p8so213293wrq.6
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=orG/HopjD5vgaN8L35rW+gnyvlLBWjBjahqPb/IGOyg=;
        b=tBKF5FtgO3+Ll8RRrptIWf+Q37gEjfzu8DTevq9ADAyt7pXIfwCnEivrr5IZ4ubN4M
         8/oLkUXGfR512Xy17xhETEzwwy7ES4J/zrsdkBZqYVKm6HkgnWzH+amIpw97Q1lJWExz
         a09YscDe1DTnjkswLVYEhvAoCVglW2Wknt06IDi9DWGykr8PDS2+oNH1/UHX1RFcnr5j
         xxzIkfEEHNZpyY/0FsLKu22br+59/M1yxAiijIaMHQG0AEQKTAsLN9n4Qj/uvSh5Yf0w
         CRuiKdKOfkdtXaxNBUl9xlf5AW07DeH31ZTnMef32FBABWq75QK2wh1xcrKhsF++qLfy
         JZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=orG/HopjD5vgaN8L35rW+gnyvlLBWjBjahqPb/IGOyg=;
        b=JW6sxhiHKWtapBvpAEat1hiQpAawv/oFPnXld/g4K/nF5vXW1K7ny46NVtI1FSdDqw
         J54eFg63cNzrkJARc9JvQtIvZ4Tj5OMXOXqK93LFZgIU3ZIgviZ9DJw4SZ/Qc1sND9k1
         bmdKhMZr+qCQsjKN9fzTSRg3LYzUFK76wdhnOYBkK4tk7TuPbD9CGY8FE7u/ZqoIdmlS
         UhV90MIgRWLaMEZMTHefaPSvpk68NfgHbiEPZUf168tUZe1Isy0INPMRatrLR2xZOg4u
         2uZ03Yp1plwqip2ORB2e+f8/8YweI/rcY063ovMV6WyIBHEKqlCYquqLs8SRVOVkav6H
         rjDg==
X-Gm-Message-State: APjAAAUZjOu9FAWwh7hpvXt3FXOFxLbOrATTNWiOxp3O9/URqcTIwbjr
        tmyw18j9oxcaFg8nSzVxyQE=
X-Google-Smtp-Source: APXvYqyCGGAYVCMJRtZ/Z10umshvWWr3BOt4XtLqHTAzFTCOMNH0+BSMS8rKkPvTau5+SfY/5A+zfQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr25528299wrn.64.1552442829460;
        Tue, 12 Mar 2019 19:07:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n129sm630922wmf.21.2019.03.12.19.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:07:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net>
Date:   Wed, 13 Mar 2019 11:07:08 +0900
In-Reply-To: <20190312213246.GA6252@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 12 Mar 2019 17:32:46 -0400")
Message-ID: <xmqqef7bfrxv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> -Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
> +Nevertheless, you can use [Git Git Gadget](https://gitgitgadget.github.io/) to

The pointed-at page calls the tool a single word with three capital
Gs without SP in it.  We should match it here and in the other
document.

>  conveniently send your Pull Requests commits to our mailing list.
>  
>  Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
> index adba13e5ba..85911a44e2 100644
> --- a/.github/PULL_REQUEST_TEMPLATE.md
> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> @@ -1,7 +1,7 @@
>  Thanks for taking the time to contribute to Git! Please be advised that the
>  Git community does not use github.com for their contributions. Instead, we use
>  a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
> -bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
> -Requests commits to our mailing list.
> +bug reports. Nevertheless, you can use Git Git Gadget (https://gitgitgadget.github.io/)
> +to conveniently send your Pull Requests commits to our mailing list.
>  
>  Please read the "guidelines for contributing" linked above!
