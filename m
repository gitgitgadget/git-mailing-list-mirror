Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5354E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeHOXaU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:30:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHOXaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:30:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so987896pgu.8
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=on7FTUgaw97CNMoSadIUGuo+xPGPRF9qU7d93SOYSNc=;
        b=TIfRlHE0bBW03c/nwepJbdeHG7eMGvL2DVKXBLPHKM2c6UwjGk4S0BIEcn1AebML1v
         zfGMSsi+3T20oELD3OB6PGyrEouGWY/u6U4DviAxG4Lz8Cq5LYi8zlN6Ba2PHX6K1xda
         rQMU81snWXRBz8a3CQoapbAlBeIShbrW0RqvoNWmaTzgwZLn/yuS4Bc9tp5IJTEDnX0W
         8NH0AXUlVVxqAA6RKVEFOhaUjW32XjCE1nTa1g0wupNj+rQlXRqnQpp4AtPSQl2jkrAU
         fcz0Vin0e63ltgK6vmiZhk1L7HTLnP273pKcMvZNsuFaeXLDYIxQZiMT7hwZKuZ/vKA6
         x3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=on7FTUgaw97CNMoSadIUGuo+xPGPRF9qU7d93SOYSNc=;
        b=rfi7H7PuWT5smJGDQGc0J7+XCIzECGmQU++WV2dBDygxE5VhKsXst/SEoAAETp2Px2
         BPIS+SDlhNnk8oZcsqGvkumkiLaL9t4IgNhLQlbFyWuoSCSM+TaBLB7YNJBqKCH9kgA8
         +F7/J8RFVAL1FGddbj2F8VwiLjMN9Agacad50Hi7wEM7UhBB6LZcb29ZwWuaFelibSUG
         z1vem0XDcj1Y84X330g3a6+P5iJxL3CRCIIATm5vrIHZwlxScwnO4BSS2FHdGqLz/kJ8
         ec//DN9UwdxBIT7VZ9DA1MA2fM2COaV3BoKPSf8NmNTc1DJzed6QTIqw2P+OgUd4O09b
         kGjA==
X-Gm-Message-State: AOUpUlEPsF98wvXb0YSbiZD85Do3930V4FDXX7QAa1jStUYw5j6DdK/j
        awng7xFYjCzHKFrGdJUOT8WRwV4f
X-Google-Smtp-Source: AA+uWPzJZB+76ZMUrcSWbHMgbcD5VWkq/pcfiSYigeFSKS/NZfpJ1Z+iObkGxSYYPtu9EAzB0nb5Tg==
X-Received: by 2002:a62:d1b:: with SMTP id v27-v6mr29538936pfi.87.1534365396376;
        Wed, 15 Aug 2018 13:36:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f11-v6sm43963893pfa.131.2018.08.15.13.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:36:35 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:36:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv4 1/6] Add missing includes and forward declarations
Message-ID: <20180815203634.GA181377@aiede.svl.corp.google.com>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
 <20180815175410.5726-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815175410.5726-2-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

[...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
[...]
>  55 files changed, 132 insertions(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
