Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AD91F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfAQBgG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:36:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33487 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfAQBgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:36:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so2387021wmh.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wz5VCXgvg6gckvqD3GIk5UqcZ+rEBxaj6CeTEIijCvQ=;
        b=Rhh0eWABAaofzdMKPQ3lO/9sOofEzfLHWL+DgUmSEqb6HdEZkh7+h1HmPf0uHvg4Hk
         4eL5u0tyVBDjAF2+2WcscNYkI++7kgk7PWB/sFBlwDAaK63o0QKxe7pRz6DL+Twfr+SC
         VgR4r4pfmBRXFqkZC1SsgedMNBsPqaw4Yub0Z5gs0Ap6d2VbwptdpundOA8AoKa5dhsA
         OlIjv7lSaHUYcVURDWNGSwEs0r4w77S94uG+gQ95d4WahmKVs+3PDZrXUCSQzLgca+6q
         3ggIdrfTktpjIuUm7EDQnNxENDxbp8Jskc7nS0tWGsut+yVqE8CttAvnewCsXfNxmDDb
         VUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wz5VCXgvg6gckvqD3GIk5UqcZ+rEBxaj6CeTEIijCvQ=;
        b=g3N8qtB6K86rT628+naqgwnI/omPp9svJALiJ4MmtVzYhGZonEa0YUcIGiW93iT9FJ
         9XjI4n/5NvNK2SJLLtUVd7oxoqVbaakQNnh+KV8tBGJCOdCdaBUTfukxtV+TCv+EO6zN
         mAGP9Zpgm+mNGk5adxJ8sbHcURzgV528EjDjqlcCt9L2b8nH2+ZeOqsTIC2KOxQiP1e1
         KqZcBRPeWIP9rNIXFa0pTCzVEYsLSnoWexg2y00bXuDN4KWRT0BPxMU0LHQOccbQaj3u
         +L8nMxPHviCOf4ZQKHNLA1RGi+rNBKd08dG4Y3IL2uhlesKW6qSufgYE9+sWIKGSjvw4
         k8pg==
X-Gm-Message-State: AJcUukckc7ToFiYYGR4fvP88IeOUn0gYAreWCpCwI7+M8SD39o2VYbC5
        R2ejQJjvyHfx5IElehZHnf4=
X-Google-Smtp-Source: ALg8bN4I9QO9rl/OLqARfGBhUZnKwKm0vvIaA3nKN0sCm/MwWzL3s9OvzdmtE1ZxxddF7469GJx/3A==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr9577889wmy.92.1547688963944;
        Wed, 16 Jan 2019 17:36:03 -0800 (PST)
Received: from szeder.dev (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id o81sm61886530wmd.10.2019.01.16.17.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 17:36:03 -0800 (PST)
Date:   Thu, 17 Jan 2019 02:36:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
Message-ID: <20190117013601.GI840@szeder.dev>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20181220162452.17732-2-szeder.dev@gmail.com>
 <87zhszeqsr.fsf@evledraar.gmail.com>
 <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
 <20190111003743.GA840@szeder.dev>
 <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
 <20190111185118.GD840@szeder.dev>
 <20190115235546.GF840@szeder.dev>
 <20190116011311.GA8864@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116011311.GA8864@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 05:13:11PM -0800, Jonathan Nieder wrote:
> Hi,
> 
> SZEDER Gábor wrote:
> > gnulib's obstack.{c,h} doesn't fix the issues that we've fixed in
> > 3254310863 (obstack.c: Fix some sparse warnings, 2011-09-11) and
> > d190a0875f (obstack: Fix portability issues, 2011-08-28).  So if we
> > were to re-import from gnulib, then these two patches would have to be
> > applied on top yet again.
> 
> Thanks for looking into it.  The former looks applicable to upstream,
> while the latter appears to do some Git-specific things (e.g. relying
> on git-compat-util.h).
> 
> Mind if I send the former upstream?

That's not my patch, so it doesn't matter whether I mind :)  Cc-ing
Ramsay, to make sure.

> I believe gnulib upstream relies
> on copyright assignment, so it would help if you have a copyright
> assignment for the project on file, but if not, they may consider it a
> small enough change to take without.
> 
> Thanks,
> Jonathan
