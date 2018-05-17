Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A941F51C
	for <e@80x24.org>; Thu, 17 May 2018 23:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeEQXAa (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 19:00:30 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40594 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQXA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 19:00:29 -0400
Received: by mail-wr0-f181.google.com with SMTP id v60-v6so7247473wrc.7
        for <git@vger.kernel.org>; Thu, 17 May 2018 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bcv5GInLamDyUg9UUqfoI7TpuELf4cWWMKmkl//U6dY=;
        b=gUWMsb0Xqq1CVsvqProxUW/9AY4c8FjxgnnbtUnVc5eoDFgNSDNawMSZNr0XDuMqMw
         g0EEpXxENco9D0yl3oLeO5teEDRTXaSFsZcoWTgoytFgoAVRw+xVKSAXFCACUM/nwC0+
         mygC68QRhEzEDQQYLqRZpyX4S+qcaG5mN6nFZWpko0CPEwEY7V/KK5atMNq2pjrPIBX/
         9BYhwHMnorW6pV5L2rB6pzWkKneVkNYoqyJcWt/TwQI+pVeI8xtgU6S0gAcFzCVbxZhy
         w4rfeK5RkdWXuCf8ZvyMLA3lauzqNyW6rcnENo7AZgar1R31XoCaBgM/Okug2hJjUknz
         U/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bcv5GInLamDyUg9UUqfoI7TpuELf4cWWMKmkl//U6dY=;
        b=nnPf04hN9NDXvSZg3ZmxHhhIqkjZsjgv7oii7IFjyqg1HIIhXiHzyeJ5urG8hnPphB
         IaaPREQSsKJU5J8Y2baWf0gdJHVNetNRM8W4/lJjyLk3S5nUj9ZaZr3dhBvJLNYadPw9
         p3RNQ010ax30ckBosMmn/sKbCkW9NWcY4pP1/IjP8E6fMD6YfEBBJvSZicQVnv9JtfpP
         B+9GzPnlBnvrVCDsIuH1HJ0k/sCgz5am1k1NSC2eiZXRZeT1TpnvdSN2hoifdv+fpLoW
         ze0yHtvDgPkfUiV0W+NtMpiAYEO08DfiZiEt4LAvet7VzR4nGwsCsz2cKTtHMlzQHFG3
         I+pQ==
X-Gm-Message-State: ALKqPwfqAHeiYEpGkE8yAPeMpS9WD7/rK7+Thi4wQ3CvVklPVRxJXmvE
        55rYpm1D56Sd0UZa5a5/gfg=
X-Google-Smtp-Source: AB8JxZokbuLxsWkkzgG1mrWrDOjHT1kzEpb3+nHeMKN4ZLj/DxLkG+OqjcynIEYfZxfQZBS+Y0iFRA==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr5998741wrb.145.1526598028023;
        Thu, 17 May 2018 16:00:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z2-v6sm6326907wmg.46.2018.05.17.16.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 16:00:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/1] Hot fix for js/empty-config-section-fix
References: <cover.1526593623.git.johannes.schindelin@gmx.de>
Date:   Fri, 18 May 2018 08:00:26 +0900
In-Reply-To: <cover.1526593623.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 17 May 2018 23:47:04 +0200")
Message-ID: <xmqqy3gh51md.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In https://public-inbox.org/git/20180508134248.GA25513@sigill.intra.peff.net/
> Jeff King pointed out that an invalid config section is not an indicator
> of a bug, as it is usually provided by the user.
>
> So we should not throw a fit and tell the user about a bug that they
> might even report.
>
> Instead, let's just error out.

Yeah, makes sense.  Thanks for a prompt fix-up.


>
>
> Johannes Schindelin (1):
>   config: a user-provided invalid section is not a BUG
>
>  config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: ccdcbd54c4475c2238b310f7113ab3075b5abc9c
> Published-As: https://github.com/dscho/git/releases/tag/empty-config-section-fix-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git empty-config-section-fix-v1
