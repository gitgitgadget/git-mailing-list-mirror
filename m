Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5442A20954
	for <e@80x24.org>; Fri,  1 Dec 2017 23:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdLAXqB (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 18:46:01 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:46453 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbdLAXqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 18:46:00 -0500
Received: by mail-it0-f52.google.com with SMTP id t1so4298690ite.5
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 15:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kJy9ZVhXL3wGsrYSIuDhphShkyC4RzhnnAUzrV9ofFA=;
        b=F7AdE4FtjQPTTu8pwl6Rtxci39TxSzqBLwk40SLvVBnokex6RfQbXN7lSOoEIEYSdj
         bR+4orSv3IIMKRb6gATA6XfjSjrpXNiBoACpzPzJMgH4GrK0WElkF7PaOrvFXlp80o99
         csQ4nGJFIcKKz2yCIb7HMBoHNAcaT36qGe+XZPYvyntJmifMXe1QpcI6HHCC6j0IVMd7
         p9p2uB5czDd+TmTgK/muMF/sDS7SZqnIL4CdomYNtI227qR6/3SlX3/9Jf+nAlbK1w/k
         u+lWn80n3Qo2P77CNZw3fEW7lFO/qQKjhAb5Q5jQcY29GLQWXl/lmm6J7o0UA7/yH161
         wmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJy9ZVhXL3wGsrYSIuDhphShkyC4RzhnnAUzrV9ofFA=;
        b=O8w2I2rlgjevMpifV0DvJF+BA8funFk4RuxM8lRuuXRJpXbzJGPruGt6GAcnyhFqIL
         P0F4zkX9iUmyeg8N4teLzwD6PPVBid2huhFKtRpx8wry5v8Lvu/ZAMdk8YKPA2SJWB59
         mtZRZSUNIYL4JDOrxB8yPz/t1f0G+IUcODpXKAvIJWHJHuWjcqJZyUZZfaEnFA2XGNXb
         WMqmBIiXRO6AuNBlIHmX7j4d3woDG3ajkET38/Kuy1mhwYK+fyrNfS9Mq9N5GEKOtQul
         VVGd0YxhDlEQ7uV4bZ6ksS1nTo+5wQM3R+1s2UBco1HyiJajeLtIz2LU9+Q5voi7rVt5
         p19A==
X-Gm-Message-State: AKGB3mIGm9OPQn86UKzIzDOTlAQ0Z75gSHK+iptZi89B0+l0oQ7qbA7z
        TkjcVbJW3HDtKk7KcZBEHvg=
X-Google-Smtp-Source: AGs4zMYAKkz2cEbT/mpgt3pGEH9eeSTTi4aYNcxEpMLAwh912MdYHuDHTIPll4cl7t1XS4HJCr3m/Q==
X-Received: by 10.36.46.75 with SMTP id i72mr3881436ita.62.1512171959528;
        Fri, 01 Dec 2017 15:45:59 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z8sm1109786itc.41.2017.12.01.15.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2017 15:45:58 -0800 (PST)
Date:   Fri, 1 Dec 2017 15:45:56 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Timon <timon37@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: allow Ctrl+T to toggle multiple paths (Re:
 [BUG] git gui can't commit multiple files)
Message-ID: <20171201234556.GE18220@aiede.mtv.corp.google.com>
References: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
 <20161204204057.32dnkjx6ixv3swez@gmail.com>
 <CANtxn9K9tzmbea1Dx9Z37GNfA9QfCX0gm-XHjJxieJN6bc6D-A@mail.gmail.com>
 <CANtxn9KjTToqXKeO1mM8c6kD+jLf8QcAVXF46tX61uQB7YdKYA@mail.gmail.com>
 <20171201234013.GD18220@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201234013.GD18220@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: git-gui: allow Ctrl+T to toggle multiple paths
>
> In the Unstaged Changes panel, selecting multiple lines (using
> shift+click) and pressing ctrl+t to stage them causes one file to be
> staged instead of all of the selected files.  The same also happens
> when unstaging files.
>
> This regression appears to have been introduced by gitgui-0.21.0~7^2~1
> (Allow keyboard control to work in the staging widgets, 2016-10-01).
>
> Also reported by zosrothko as a Git-for-Windows issue:
> https://github.com/git-for-windows/git/issues/1012
>
> [jn: fleshed out commit message]
>
> Reported-by: Timon <timon37@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jonathan Nieder <jrn@google.com>

Gah, this should say:

Signed-off-by; Jonathan Nieder <jrnieder@gmail.com>

[...]
>> I applied it locally to git-2.15.0 and can confirm it fixed the problem for me.
>> If you need any more info/help from me, or would like me to test
>> anything, feel free to ask.
>
> Thanks for this pointer.  I'm including the patch here so the project
> can consider applying it (it doesn't appear to have been sent upstream
> before).  I have not tested it or verified the claim it makes about
> what change introduced this regression --- if you're able to help with
> that, that would be welcome.

Can you bisect?  That is:

 git clone git://repo.or.cz/git-gui
 cd git-gui
 git bisect start
 git bisect good gitgui-0.20.0
 git bisect bad gitgui-0.21.0

Then cut to the chase:

 git checkout gitgui-0.21.0~7^2~1
 ... test test test ...
 git bisect (good|bad)

 git checkout gitgui-0.21.0~7^2~1^
 ... test test test ...
 git bisect (good|bad)

and follow the instructions if it suggests testing additional versions.

Then I'll be happy to re-send the patch with the results from your
testing.

Thanks again,
Jonathan
