Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32501F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdB0WTc (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:19:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33148 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdB0WT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:19:27 -0500
Received: by mail-pg0-f65.google.com with SMTP id x17so2305260pgi.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3S+05xqx5iQL5QwDGUCmdZuHx8TbS+51y4xI2BlmO2w=;
        b=l3vbC0qbRU6807/bqPgTgiarpDDiORvPWTsdEbfR18jWuk4U1fnhu4SVLV7OxcrrMB
         VqiC9KWst/vAfD69UvVr3/MC4vqhFHz6lDkwnYW+sMzXT6iFJOt+Mer9XvLb+9rY1n7n
         f+I25NzTeL6K/fCK6Q9ISzJ1KGL0ah+fjoHUl9rC1JVM+KIszIHT+ra6GSeJlFklJZa9
         OhcxdW3lemoDhpAF3EZXtJqqxT7uJE6yEo7BFGgP1TtTVBUmcjMTi1/fIsTmWpIgySda
         1Un3begYMWY6KK1pg7Y86obAcwHUUnvu1p6Du/9IFlBdbQs6/tHc85Ffux0uZ+XqvYmg
         yKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3S+05xqx5iQL5QwDGUCmdZuHx8TbS+51y4xI2BlmO2w=;
        b=BHyELsSW8CV7IT11/QANQEGlZC9UJ11ZiwoyJCN5s+idLnJzlxtGEedzt2ozKs3q3g
         xaxqCTXhrvtqzCHoEwmtKmXX42t701kVOoYnPnE16nXdI+oXccx4sAYA62/wOOXy4g64
         ij5r/YGueQSX8lnikN3f08O7PO5M+n13ajSx2R6b5NmUeZ8HqNPC70zVQw+BBi8zrS35
         A3oiRMgZ3Bo6XA4kcKB6pnKCCDTW2utbP2IZ4KWhp3reXdMhwhvkW/s+xzZZHL/7Efam
         Re/1xK6OBgW89FI5JDmyQgmGD/ehHrRHxrsHlFY39WT0JWtuJLEMSZ33+kxxu0iM17iB
         7G2A==
X-Gm-Message-State: AMke39lhUc3qOyGNvPpdH6OberdtKKvdOfgM0KKX1v6MTlFzzBVzYtztVpIbo2ciuo7KYA==
X-Received: by 10.98.134.142 with SMTP id x136mr16201743pfd.64.1488233916364;
        Mon, 27 Feb 2017 14:18:36 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id u75sm26907524pfk.3.2017.02.27.14.18.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:18:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
        <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
        <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net>
        <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com>
        <20170227214147.5ezxskhihi3cc77m@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 14:18:34 -0800
In-Reply-To: <20170227214147.5ezxskhihi3cc77m@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 27 Feb 2017 16:41:47 -0500")
Message-ID: <xmqqa897nupx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "other" stuff could sometimes be useful, I guess. It's not _always_
> wrong to do:
>
>   git branch -f @{upstream} foo
>
> It depends on what your @{upstream} resolves to. Switching to just using
> interpret_nth_prior_checkout() would break the case when it resolves to
> a local branch. I'm not sure if we're OK with that or not. If we want to
> keep all the existing cases working, I think we need something like the
> "not_in_refs_heads" patch I posted elsewhere.

I haven't seen that patch, but yes, telling the caller if the
returned value is meant to be used inside refs/heads/ is the right
approach and makes it possible for "@{upstream}" (and just "@") to
be handled sensibly in "git branch -m @{that at-mark thing}".

