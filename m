Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662C02021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757299AbcKCSpm (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:45:42 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35505 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcKCSpl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:45:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id i88so35809146pfk.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dmHGFYkWx9Z0mJZSJGYKBRJxyeS3Ll0JxJH+8xOmHbE=;
        b=I9HiEwCeTBQyuSu93pmfKyUFWGMquyHNU3Cct9+UO6npXWMGKE/ILmib36z7lx3aKY
         8crvOhDr/3nNDjb6GlGjhF8finyEgkSKPQ5h7HccKj9qz/ys+eTriZEuHFKnFQalqsXN
         g+IZcUS4oc2OxX0bs82OTanUmYkXFKcI2jrHwwSM+71edaazkBMbcjy5U6+wVwhzL/Up
         mejuBjC5wNXDCql/kacaNW1maKojbPcfhXratXW1OnFLHBPamkoWnkQ8dQ11K9tDnujF
         fMeLQw7leW1gycfI6AFTbTozpxAWXZrXbVlTxFAQkuApKh0zJJFo4GHbmLZGEibi5hHv
         mwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dmHGFYkWx9Z0mJZSJGYKBRJxyeS3Ll0JxJH+8xOmHbE=;
        b=W8GmkGCh6WTS8yWsYEC4Yvk7lmgsjENP5DtbdLmH3VD+ngXpwlERb3rL0YzMsqiCDv
         tk+mZ02R71Q4JU6Mhd4O1XbJBOvcekdbj2Em3fKMczzWgCDQMKm3wRRpa/h4ft/Cj4yC
         azvHQvpaOHOj5R+ItjN0UZqt6JnjudVXVE2E3oUJeAbS6zCbyMzkJ0K6/yZs+XHCcVF9
         6KA8OaypgLE68FcQBRREbCzbL9GWpfzUwir1sjK4q9eO1FoOY7GHGjemLzLRgqo4u/fL
         kUnhVaa8RysVRgv6dQMyi4hBGGxJPtQCLupxzSzdy11Kme1avvViAuHN6QQDfDQfu6bV
         Y7+A==
X-Gm-Message-State: ABUngvdsJvySF5UBXdWRLb9fYiZSIgqrVqu1nETFWsfoRaZ0N2F8o9bOQdwqPYJf+Ej0nDQo
X-Received: by 10.99.128.198 with SMTP id j189mr15900675pgd.151.1478198740695;
        Thu, 03 Nov 2016 11:45:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b42d:d807:c3e3:2b82])
        by smtp.gmail.com with ESMTPSA id t67sm14429822pfg.46.2016.11.03.11.45.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 11:45:39 -0700 (PDT)
Date:   Thu, 3 Nov 2016 11:45:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103184538.GE182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
 <20161103182428.j3r574evsk7ypfie@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103182428.j3r574evsk7ypfie@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03, Jeff King wrote:
> 
> So this seems like a reasonable direction to me. It obviously needs
> documentation and tests. Arguably there should be a fallback "allow"
> value when a protocol is not mentioned in the config so that you could
> convert the default from "user" to "never" if you wanted your config to
> specify a pure whitelist.

Yes I agree there should probably be a fallback value of 'never' maybe?
What you currently have preserves the behavior of what git does
now, if we did instead have a fallback of 'never' it would break current
users who don't already use GIT_ALLOW_PROTOCOL (well only if they use
crazy protocols).  We could ease into it though and start with default
to allow and then transition to a true whitelist sometime after this
change has been made?

> 
> Without that, I think we'd want to keep GIT_ALLOW_PROTOCOL for the truly
> paranoid (though we should keep it indefinitely either way for backwards
> compatibility).
> 
> Do you have interest in picking this up and running with it?

Yep! Thanks for the help in shaping this.

-- 
Brandon Williams
