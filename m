Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0C91F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeIYDCb (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:02:31 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40925 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeIYDCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:02:31 -0400
Received: by mail-wm1-f54.google.com with SMTP id o2-v6so4827796wmh.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wawUIkrmE40V0fqz0buQ7eaZT/cL6fUwCRl3Kyt++ro=;
        b=jFWHEp++OGjtYY7hEje8BP4eXU4vXv9zSlVx4aLzIJlKOZhfmsxh2hVSSI13Rk2hTi
         dkfP+QNAz1zr8aPAuwedAdV/Wbc3H8aM+4DgnlgxNNChVmleZ7P5Fv/ZXHrqedtwSrm2
         Sdb1lb4pyInyR4XmfbrQZVaNieYV6V+RV0UCDewei5/HEPNSTWshTyEWhf/6vNwAdjOP
         o+DNxSFMXkeZ2UpLbzPRf/LQ1IFp0VF9y0Yfc0EvB3g/rllh9mwv/+9dFRCEQi3waIn4
         Br1oY8cSHG8E7Rbgu68ZFYcnhRrqNym8azaMB07/zUhjmRQFWxkvAh3qyEl4yMDmzCNa
         Qw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wawUIkrmE40V0fqz0buQ7eaZT/cL6fUwCRl3Kyt++ro=;
        b=IuJ6usbFU7Pk/1DpQ8pDmeRLMuIUas4mpUt5bZWYhs2xXDLKi2HReuytDEuIzPEJL0
         Nkkksxg9BMgZAv+Th/a+Tf1yLc3q2lPHlsZSYJIcwvL2XlagZPp9kFjUXCFkwRVwdjbw
         owxNJysjAbHuufbyhrx/AsrzGTUZ78ylQ/zb60RHvFUe9xakx7e428AGL1IIqroBjyKa
         0/YoD699pUS0sJ4FA5OF9a7OUAosKAdacg/gOnU2/+gIwIzLzeLdGjeSdmxS8AtDwZ8O
         SekQafwje6fFdjz+7M2BFAGX9q/iESxEk2GG0g7tnWXjYHQv96lKi83sPCm+4h9xXvz0
         qqZQ==
X-Gm-Message-State: ABuFfoh7QX4iqtbngkXy55qiHGhKS8k6CYEXmqGTvxCgbqTD+ZlBaH98
        wz/fpJ9uG0mcu3irpNdCQSxk/Fm9
X-Google-Smtp-Source: ACcGV61oiW3Ct61/eOT1bV48XgnjK3KlqFebKOOe0Xg8lNtu64VAmpHtMjS9k1VvwxMappPxhp/nFw==
X-Received: by 2002:a1c:9692:: with SMTP id y140-v6mr110490wmd.82.1537822705077;
        Mon, 24 Sep 2018 13:58:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g18-v6sm386290wrw.5.2018.09.24.13.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 13:58:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git help: promote 'git help -av'
References: <20180922174707.16498-1-pclouds@gmail.com>
        <20180924181927.GB25341@sigill.intra.peff.net>
Date:   Mon, 24 Sep 2018 13:58:23 -0700
In-Reply-To: <20180924181927.GB25341@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 24 Sep 2018 14:19:28 -0400")
Message-ID: <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that "help -av" is likely to be more friendly. I kind of wonder
> if it should just be the default for "-a". Do we have any obligation not
> to change the format of that output?

I know that at least older versions of git-completion.bash (I think
it was up to 2.17.x series, but do not quote me on that) have parsed
"git help -a" output to obtain the list of commands.  So such a
change would impact those minority users who keep stale completion
script in their $HOME/.bashrc without ever update it, thinking it is
good enough.

I personally find "help -av" a bit too loud to my taste than plain
"-a", and more importantly, I look at "help -a" primarily to check
the last section "avaialble from elsewhere on your $PATH" to find
things like "clang-format", which I do not think is available
anywhere in "help -av", so I do not think "-av" can be promoted as
an upward-compatible replacement in its current form.

I probably am not a part of the target audience, though.


