Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F42331FD99
	for <e@80x24.org>; Wed, 31 Aug 2016 07:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbcHaH2m (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 03:28:42 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38472 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758110AbcHaH2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 03:28:32 -0400
Received: by mail-wm0-f42.google.com with SMTP id 1so23929009wmz.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSo1uID0kSK6iDs/furTQoicwsaB7Earzigyl/DJrrQ=;
        b=MKn7pII8ePPOSlbWhhzJ56wqhvP3eU1WYDvVThM4D2acDp9Y/dcnedsMIpRbAnPsth
         prtSIZwYXHEUmqXDQW81OhtmZR8W43a2yOUeq90HFjgHNQ3RVD0Nsz08iHx+QK7A7odX
         Yv/7XLgHAJHAXQg5+MqL0AjL8tDPxL+lX5oxhwETei3C7ef+0ZL8zhr8S4vG3h7TF4OQ
         6z2uw3UGQkCXqjrNJ7r/Q/GzPgECGlRdqg8C02JUzb+A3JdtluzTU7MDWvoWn4bD2zK2
         SweV+aRbp2jnqDWWUlLtNKZl/570PV42kTRhAFzY3oGBil5vaaKa8yXw5fPhCR4kJR8H
         5cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSo1uID0kSK6iDs/furTQoicwsaB7Earzigyl/DJrrQ=;
        b=KMjUUWhqc1EbD7Bh0z56cRUo7tCYgvZjtROAjT3mqpSI51qs6z+q1ss5WFivV5NPR+
         hiSQ1M2WSngLaCzZEOk2kaJdKD3jo9jCXp2v5mNTG3Zpc66YEAEzXPq3QpahlQhJxap5
         nrtx9JrjREIyu0IIdNF8jwAU3w1wXgFpEfpaVuaH1ZSnKtEW2HrHtLTGu7tQVouSn347
         QQk5Bs+2PurgV1Cn/5Z8UsJ9+Wbtz05vD+ewJ8ga030nfhtZW0gL/LsN/xlpofIpqDEp
         HxmuhiDwiu7HecNIrHIAlbE0rJUBlLJSPf4vtEfFihf0vyY1HRahjUaYC1uEIgqLMHXS
         8iUQ==
X-Gm-Message-State: AE9vXwP8HAVZkjWIQRmBZtc+kal8ODiSuMKsyeFkrQxkAp5XQjDTPfCFh0egiN462TFJxQ==
X-Received: by 10.194.173.35 with SMTP id bh3mr6745948wjc.86.1472628510695;
        Wed, 31 Aug 2016 00:28:30 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id f4sm22200541wmf.8.2016.08.31.00.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 00:28:29 -0700 (PDT)
Message-ID: <1472628509.4265.43.camel@kaarsemaker.net>
Subject: Re: git blame <directory> [was: Reducing CPU load on git server]
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Date:   Wed, 31 Aug 2016 09:28:29 +0200
In-Reply-To: <20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
         <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
         <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
         <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
         <9fe5aa9b-5ba8-2b9a-7feb-58e115be3902@gmail.com>
         <20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 01:42 -0400, Jeff King wrote:
> On Tue, Aug 30, 2016 at 12:46:20PM +0200, Jakub Narębski wrote:
> 
> > I wonder if having support for 'git blame ' in Git core would
> > be something interesting to Git users.  I once tried to implement it,
> > but it went nowhere.  Would it be hard to implement?
> I think there's some interest; I have received a few off-list emails
> over the years about it. There was some preliminary discussion long ago:
> 
>8 <snip>
>
> Here's a snippet from an off-list conversation I had with Dennis (cc'd)
> in 2014 (I think he uses that blame-tree code as part of a custom git
> web interface):

I still do, but haven't worked on that webinterface in a while. I also
still build git with blame-tree merged in (which does occasionally
require a rebase with some tinkering).

> That's all I could dig out of my archives. I'd be happy if somebody> wanted to pick it up and run with it. Polishing for upstream has been on
> my list for several years now, but there's usually something more
> important (or interesting) to work on at any given moment.

Same here. I've been meaning to pick this up, but it touches some parts
of git I'm still not too familiar with and there are always other
things to do :)

D.
