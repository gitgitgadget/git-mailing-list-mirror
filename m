Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F521F428
	for <e@80x24.org>; Tue,  2 Jan 2018 22:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeABWRV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 17:17:21 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41481 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeABWRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 17:17:20 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so260895ita.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 14:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+yo4AMuj+tum8+kdZc+HQgl0AnOE1BLszZLYBQTFus4=;
        b=u6X01C6S1Hhkx4SjdLs2AiaI6QgnnHaAF6jIYq3wL2UtvmBNbQUYwNvyBxe9eTDXAl
         L2e+ye7TZbIkc9nmY06DC2KijQ8zsmm10Vf/vjZhOEa/vclRuGKj1KRa7z5zL8giV6m0
         JeGnM9HQwz/VnSw6B/IyDa1+fqanzdKQFihnpNgsgfweL+Lfk8CNkF9kHuVvpr06FHz5
         dYOeX6cvZLSnJJbvZ92yy2jrfiKOXdm7XjUIWVHZK/s8DCVVAoIODo6rgvAKLkAVOQqx
         4Xi7ZakUxk7kD57LEtDtVIIRcr3tBkNYrxxd6qCDEDt5A8kxkQfcm7Cr/l+UevNd3wNI
         CyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yo4AMuj+tum8+kdZc+HQgl0AnOE1BLszZLYBQTFus4=;
        b=fBp90HkQWaPjKNjybv11qllVumuEwCjYX2maRDqhiF4eQuPl84Ai20CdNOvHTEc2Cd
         Ff+lauP+/gGLyI+hueOn4tdw3Ct9e50Dcp6s99FlGso9TnfCAZtJdxWwIhTTeJvCjNBS
         DEM7l1U8nrlZwfBURzjmDJE858ztOBaX1lMdG6Z4w+iGw/H8Fc8BGxNJZz2VcWkDfbc7
         JXfpOkbmH8y/3x7qFMN2rAZtgpqUaqFBfpfIHS0pbbWcvWGV09JsAsujA1IajpBxyRrc
         m6JUrKsU9/APAy0YikksYkJCx1Hczmney7RcOFRCkLiZCCw/J81jsobWEHwErGPKWLJA
         iz/A==
X-Gm-Message-State: AKGB3mKyN/+zPJihZxU/DNZi54CWCI6naNxyOJ4QBDm5siQNyaRMb1Wk
        GGT9HYJ1deQZCwbz8kvhjgE=
X-Google-Smtp-Source: ACJfBov4fG3q2cEWmex9K2oP9cBWGNrP7dS4sxMiKF56Yu8WM9r/tL2PsFuzij25058DkwLvovyNTw==
X-Received: by 10.36.190.199 with SMTP id i190mr58873370itf.84.1514931440199;
        Tue, 02 Jan 2018 14:17:20 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q17sm13753607ioi.54.2018.01.02.14.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 14:17:19 -0800 (PST)
Date:   Tue, 2 Jan 2018 14:17:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
Message-ID: <20180102221717.GD131371@aiede.mtv.corp.google.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
 <20171221204356.GA58971@aiede.mtv.corp.google.com>
 <2a5eb18a-d1b4-da2d-c2c8-5798d8627617@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5eb18a-d1b4-da2d-c2c8-5798d8627617@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:
> On 12/21/2017 3:43 PM, Jonathan Nieder wrote:

>> I also wonder if there's a way to achieve the same benefit without
>> having it be configurable.  E.g. if a branch is way behind, couldn't
>> we terminate the walk early to get the same bounded cost per branch
>> without requiring configuration?
>
> I created a config setting because we don't want to force users to
> type "git status --no-ahead-behind" on every interactive command to
> get the benefit of it.  I guess we could ask them to alias it, if we
> don't want a config setting.
>
> Also, I didn't want to change the time-tested behavior that users see,
> so I didn't want to change the algorithm in any way -- just not call it.

I'm not too worried about people relying on the time-tested behavior
in this case.  It's a convenience feature for human users --- any
scripts looking for this information would be likely to use a more
convenient command like rev-list.

The one exception is "git status --porcelain=v2".  For that command,
scripts are likely to expect to be able to parse the "+<ahead>
-<behind>" line.  Alas, guarding it with a config doesn't help such
scripts --- they still need to be able to cope with the new behavior.

git-status(1) says:

	Parsers should ignore headers that they don't recognize.

so introducing a new line like "# branch.matchesupstream (true |
false)" like you did seems reasonable enough.  I *suspect* it should
be okay to omit the "# branch.ab" line as long as the script didn't
explicitly pass --ahead-behind but that depends on whether any scripts
in the wild were relying on the "# branch.ab" line being present.

> Would it make more sense to name this something like "status.aheadBehindLimit"
> where 0 would mean no limit and match existing behavior and a positive
> number be the number of commits we are allowed to search before giving up.

Sounds good to me.

Thanks,
Jonathan
