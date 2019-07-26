Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A841F462
	for <e@80x24.org>; Fri, 26 Jul 2019 13:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbfGZNxY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 09:53:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54166 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfGZNxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 09:53:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so48101130wmj.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BP504LZG8ksHdbH+39JEtN4dTGMR/cikRN7UtYsbSds=;
        b=qS2NGVklq5l74t3LDBwtCozwtwE8LXQx5y34LND33bMTIc5hEN9/SEJ1A4ffdXxs8a
         i8y6w4DLOe+EgDeszSfpPUxyGuC2GYqmSJjTuHm/O92PYInh8ptRJ+QGtIu6Tp+BiniI
         01DjpzvSLIy8IB9WyDvIh+HOLRM1MIgjLquI0FxpnHFVT1uPDuLOhKmp3woxCokAUYLv
         b45k7RfOWgAZJQ8DFkGxNZVzK+A/LKJRqlEfyzZXiIsfJTaNnT56pAeYZFls7ObCWphc
         HtyIJIyvLqehTQIi5vbTuooUeQCr2/dFB4DMr8Z0o0k75MQuIbe3WUsJOOPgFh8ijVvL
         G1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BP504LZG8ksHdbH+39JEtN4dTGMR/cikRN7UtYsbSds=;
        b=dE7LHKHvTMSBqGm0UX72QeepkW//XHIk+wW/l7Iq4l71N1CRjvZMGEBxu/BTFgD9Ai
         OQv6JuLu/mXjAfG0Ap0pbl6Bz5LoknylSJy/HfYBIN3ZOQ1dj+K4jk3k7pNtawwEYKNa
         xEUBibCJHo6EFWQNzuU+fnUXhp68aQf3nyGB+TK2CPASqOtt1pSkuXxjDOtS+rzLQLG4
         F1777fbkzH/sPoYh7fBPCzah7HOFZbB9IOTR2eDJIat3a9nHUWxEjeLLDKIhxQEReucb
         hTYJv1GA2A8U4iPNNFPOMz7Viaw/VT9o5OJwSjSQkd412QuclcFA9WuIMnmaUY4Xfnt+
         AJVQ==
X-Gm-Message-State: APjAAAUo4HJGyS6AOuvPqwbTCuoLoZRfVEgn4/fZ+K8NiSUhSwPZPoL4
        JcWiR7CNr5rqgwstcq7RZ5Y=
X-Google-Smtp-Source: APXvYqxVXrmxXdHyvwqhyBxBGzGabG5dotQZL0AYPJ7AzH4UNmmcbprEW3IVAs9dXxd7YmKthcSnhw==
X-Received: by 2002:a05:600c:23d2:: with SMTP id p18mr13407365wmb.108.1564149201887;
        Fri, 26 Jul 2019 06:53:21 -0700 (PDT)
Received: from szeder.dev (x4dbd62e1.dyn.telefonica.de. [77.189.98.225])
        by smtp.gmail.com with ESMTPSA id c6sm53069982wma.25.2019.07.26.06.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 06:53:20 -0700 (PDT)
Date:   Fri, 26 Jul 2019 15:53:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190726135318.GN20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 02:12:39PM +0200, Johannes Schindelin wrote:
> I was wary about this patch series ever since I got aware that it
> refuses to use an already-available JSON schema validator (such as
> `ajv`, a seemingly well-established all-purpose validator that even
> claims to be the fastest validator) and instead tries to push down our
> throat the first Go-implemented thing in git.git.

Well, to be fair, the cover letters of all versions of this patch
series included the following bit:

  I am happy to rewrite this validator in some other language,
  provided that the language has a JSON-Schema library supporting at
  least draft-04.

Having said that, using an existing validator would make me happier,
too.  At the very least the commit message of the patch adding the
validator should argue convincingly why rolling our own is worth it.


> Besides, I have to admit that I am quite disheartened to see these lines
> in the log:
> 
> -- snip --
> 2019/07/26 11:39:28 Validated items: 0
> 2019/07/26 11:39:32 Validated items: 10000

These are necessary for Travis CI, which aborts the build if it
doesn't receive output for 10 minutes, thinking that the tests hang
somewhere.  Yeah, less lines like these would be sufficient to avoid
that timeout, but, of course, the real solution would be to not
validate all of 'make test'.

