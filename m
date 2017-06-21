Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D947920401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbdFUTWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:22:12 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33187 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdFUTWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:22:11 -0400
Received: by mail-pg0-f50.google.com with SMTP id f127so4309404pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EwUthYamjbbGK7ayOcPKLwKBeASqckesUGPCWM+fv6Y=;
        b=CY6pw8WsA0YzAa+W2B+X5LujoYO1e0bNaWQQJMc/ODB/v8Ck99nhIWfx2zdVokVv/6
         M1P/9P0Z/KvaPaGYaHEirWHO8YymjDFndqZecVYZHo6SUqqGsimJYtk4iL7UP8bTGMwc
         CrO3+pVxT/3bhvuESHSWEoNDyK/VoPG1MeKfsC5QzmYgD1O0M4MWega4I0ktCoXiBlzE
         4LzA3B4NzI5Pc1a7r9WUjWOoFju5elt5mEwaSbD5LLbog1NtuLqORE6wXamEbQLy2Mru
         sTlc6eV8024JLLpnVYRsGZVpndOrsWbC6vEwvhHgFyuZCCbiPJq56RviSPO8HJbI7lOo
         +kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EwUthYamjbbGK7ayOcPKLwKBeASqckesUGPCWM+fv6Y=;
        b=ifkAXWcUGcZKDWWjs6B1WVEwxRn5S/vJCapVbHv79545e+XpJ0ufr4KQMZddtoW1wO
         XCkeekOnG5Y6eFBV//to9Ndz4BlmD8Blu3DGgQ0ve36crsTYRRRqEziUslAzsgUSjtwM
         UeeU2NU7fsD7EnUJUe5s4sZ4DdLCtWvsOe0ScOoQoYXGQ5+JxQyGO54vYLTshT0u0VbZ
         i/0FVhJtRSk7aGfBiRLkX+9uenILAjoEwSokrK4xifw4Ck4Kc7sjgxHSkwlBn/Sc22pG
         ajggIjejhtjby/bBmd5Gbo219j+eSALBs4gZJw2TCIqki/8PROm66pftjEW8uKNLeBdo
         X2TA==
X-Gm-Message-State: AKS2vOwpYCxftWixy7noveEm5rghiwGUiYMnsTCAyoYMk8MP0C8I/0tH
        pspzaZxRqmLYiQ==
X-Received: by 10.101.73.193 with SMTP id t1mr37938819pgs.115.1498072930226;
        Wed, 21 Jun 2017 12:22:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id 204sm33843919pfu.23.2017.06.21.12.22.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 12:22:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        David Turner <dturner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] docs: update 64-bit core.packedGitLimit default
References: <20170420204118.17856-1-dturner@twosigma.com>
        <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
        <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
        <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
        <20170621180618.6yc433nwpi4d5wof@sigill.intra.peff.net>
        <xmqqvanpp4n5.fsf@gitster.mtv.corp.google.com>
        <20170621185307.xu6rcnj2y3jvdati@sigill.intra.peff.net>
Date:   Wed, 21 Jun 2017 12:22:08 -0700
In-Reply-To: <20170621185307.xu6rcnj2y3jvdati@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 21 Jun 2017 14:53:07 -0400")
Message-ID: <xmqqefudp2n3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of course, the best alternative is retaining access to the packs, which
> is what typically happens now on 64-bit systems (it's just that the
> packedGitLimit was set pointlessly low). I'm not sure if you're asking
> in general, or as a last-ditch effort for 32-bit systems.

As the last-ditch effort for 32-bit boxen.  But at this point in
time we probably do not care about them too deeply?
