Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E211FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755390AbdC1SRn (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:17:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35108 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbdC1SRm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:17:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so23062309pge.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dC4qp/5k2hiw+eA5LGU+efOc9O7WNi/20ifWetIOXJM=;
        b=ET0lGlKOf4zIi0Wxfo4kr//3rgyvnaMnDg57mGUXynH7puIBumO8H7I1lO64a5B/4o
         yaHs8uLDfTrIuK7jX6gnsg6fxuWf+X2m2avOC41rCpJVCoQG4YZtUmcfG357cX25/hNl
         nReuPzwF2HmtHV/a1TieKvcyMech+Y6rbUxacoyIpAVGsbwYYjRHhVWMrD69QJkKs7Tc
         F8xQHO0B4WcpoZig/cle9BbGXD6nh8YxkitlimTmKC7uX0gnuvqD2WFpt9Bh7NfBPp7Y
         yrIGf7sfcwryYIHnmJDlvnvg65oANR0lnt0Y0weaSmJCialuIarCKVica8Exv3zEIxgq
         VAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dC4qp/5k2hiw+eA5LGU+efOc9O7WNi/20ifWetIOXJM=;
        b=lWYnvbskQ91ez2it6wylD42Ewq7dwpsHg9kOA1hkbXrcSa0VRlx9rjlWgf8jCmoUK3
         e/1xbL3efM3bG1WOkQLqumd7W8V2K3NopPA1+A1EUZZM9+Q69yiqehRJci76YKIHKtXl
         QxdzLUYVBuQrRHgki9A2KdK6TLlWbMLUyYx/CGrs1i8FI+WEi2KZIB3y8zUu3U2fBxOc
         tdhLehS5eAKFkuX6hkQyp5LCgjAs1OoihD7Gx1hi0P7sEvtVK4iOxba8eN02v7CGIegk
         XrFDs165Szsarm3uI2cQYswdYEq68EvGcw7pKOlqDK4cmu7VP84F45tr07Z6HOb0VEir
         ijiw==
X-Gm-Message-State: AFeK/H2so6Pz76j4DIOYGr8PR+sR8huP3rz8aQGNjKChBwAT4YbTWEMgwv+o/4cuOnatWg==
X-Received: by 10.99.124.71 with SMTP id l7mr10572724pgn.14.1490725032211;
        Tue, 28 Mar 2017 11:17:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c52:4b14:15fb:ecda])
        by smtp.gmail.com with ESMTPSA id h25sm8741161pfk.119.2017.03.28.11.17.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 11:17:11 -0700 (PDT)
Date:   Tue, 28 Mar 2017 11:17:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: UNS: Re: cherry-pick --message?
Message-ID: <20170328181709.GR31294@aiede.mtv.corp.google.com>
References: <20170321160520.GA15550@inner.h.apk.li>
 <20170321170005.35ryjh4pr3jvvmx3@sigill.intra.peff.net>
 <20170321170734.GI28331@inner.h.apk.li>
 <20170321173335.n56veklbh4iginoa@sigill.intra.peff.net>
 <20170328113055.GA5269@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328113055.GA5269@inner.h.apk.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Krey wrote:
> On Tue, 21 Mar 2017 13:33:35 +0000, Jeff King wrote:

>> Probably "format-patch | sed | am -3" is your best bet if you want to
>> modify the patches in transit _and_ have the user just use normal git
>> tools.
>
> Except that 'git am' doesn't have --no-commit like cherry-pick does. :-(
> It's always something. (Perhaps I'm instead going to rewrite the commit
> before cherry-picking it.)

'git apply --index' can do that.  I agree that it would be sensible
for 'git am' to grow a --no-commit option to do that.

Thanks and hope that helps,
Jonathan
