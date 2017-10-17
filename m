Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA492046B
	for <e@80x24.org>; Tue, 17 Oct 2017 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762920AbdJQRny (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:43:54 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:47806 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757860AbdJQRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:43:53 -0400
Received: by mail-it0-f66.google.com with SMTP id p138so3518280itp.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UNEyg0MyI9cqaGoaw4F7VS/iWVXwVOOhpUQOL0JdkOA=;
        b=fcGTIVYxfP/nekBmVXIujyoSlghrlDAJWbMLfw8sPW/Gj4l/DeIODsy5tUMYKDCY2i
         sPn66dWleotf09MwiwY/lmGsmDOQf8FhROQRbCSsuxw2cJV97ycs+LxzuDwkYpARXJDF
         ravCytHHth7ks1m+riASoxpX5MkpupVgVuMiH/ky3HDcmhWLm9EWgAKEn2/aAgs65I06
         gvIOeak64p99CP9dM89WkAI/ZCNzD0w6RL/bwFnRl+m9C46Ybn+O+dplN5yvE+LKFQC3
         TCZzOa9/zUmexSAg5eGufXsRmWjE1JJsnQF48HdOSUKNuKMNLe9SYdZ5EvniS+E5CMRO
         ES1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UNEyg0MyI9cqaGoaw4F7VS/iWVXwVOOhpUQOL0JdkOA=;
        b=FqdHsqAxwnPisXDaAtBy+W8IXfkm5L81+fgPjplPCgDfrILvp2WeRvoJGHD4pGnGYv
         O6n7a2aMuLSBJKXSvshSUwriZ2SkQOeFn/DM62PcTaEvRtt0gu5Ps/h56wznUgHtLVlx
         mSfCztkR96aRiinYKKiiwFPd3BCTltjISohRp5Ygi2YQKJNKKBy3ReyAONqHN/DacIIW
         Ps0dMvfAuw39jwOUoUzgTFQLIHjlTPQg8mMYmdwX+NI1q88IbekBW8FVkRFcED8XsBXv
         tHKzKwDCfiI2f6xWQVpwh5+xTDcJomLizxGSPf764PzSKk0tneEswNCX1jQ9SmVl7iR7
         Si/Q==
X-Gm-Message-State: AMCzsaWBH0qnLZapCLnw9fYZf92wJJIqUglqMfXS9bspXjxPiKHJWjD4
        BuXsE5TieJD8qEBZjhVoHNI=
X-Google-Smtp-Source: ABhQp+QicySfF1eI1ljaqnYhSXypidzHa8d/wn6nMaQWSJegYD1aO3b+IdHYs5P1GEwq4/JTVkPHew==
X-Received: by 10.36.179.80 with SMTP id z16mr6974077iti.66.1508262232675;
        Tue, 17 Oct 2017 10:43:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r124sm5586024ita.13.2017.10.17.10.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 10:43:51 -0700 (PDT)
Date:   Tue, 17 Oct 2017 10:43:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
Message-ID: <20171017174350.4dnh3ydoagxgp6xj@aiede.mtv.corp.google.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:

> Stop advertising -h as the short equivalent of --heads, because it's
> used for showing a short help text for almost all other git commands.
> Since the ba5f28bf79 (ls-remote: use parse-options api) it has only
> been working when used together with other parameters anyway.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  Documentation/git-ls-remote.txt | 1 -
>  builtin/ls-remote.c             | 4 +++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Yes, I think this is a good step.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I would be tempted to go even further and make "git ls-remote -h"
print a warning to stderr to encourage people to update their scripts
to use --heads instead.

Thanks.
