Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFC71F404
	for <e@80x24.org>; Fri,  7 Sep 2018 12:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIGRUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 13:20:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeIGRUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 13:20:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so14842294wrc.5
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=a98AATNQk/6XBBgSTVshdNBGf/yLOr35JFZ8gmDZ6XY=;
        b=e/hFGdZ0UapjT4iVdFEcsYlEoHVfjYpE0zimcMYaDz19NcBW7Dxh23LiZHk+46omD0
         YB2Sw+Be8zivZggrDj84ftUNHT/zFUKUezG3Y5gZJwcMGqapT734KPSWnzvpaE968GQc
         gZy3PZU4NmL52F5Q+R840u06eREBaV1TOHSpntt4DEOFP0pEFvqsEjUYtkXgCJtqIGm1
         /GR2tBbCNhuDWNpfaHiOL7MCSmLWzbBpofKbg2K4iBZLmaWD6GDkKgEx7MTrw4cej8ye
         GyEHsS2Ppgk8Xub0pUDbXG7BAyiOCaNNh/JkdO/mjbiaWy2ybZQSbJj8YFfDQ/zZ84nv
         MONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=a98AATNQk/6XBBgSTVshdNBGf/yLOr35JFZ8gmDZ6XY=;
        b=NkuirjvcYNNRZTsUt2ssRXCOgfEB9A7Sk8n8P0lXOm6Yc6OiViWLhBPd3UQIYDb/I6
         eX4eO8DdQh8g1KjguRKSdrUS+kbZ5Js0ue2ZykXjDuT14W0CRqxdtxWIo2PHwjRIAdmX
         Ax3oGTyU7uH+GaRWvRV54JyzoAEgo4ebK7Uv43EyR4GxRxIKm4snSykI9bCTR3Zj+zwX
         zVcyOV8+nCdufyM5esdVeUquMQGpFRJsYMr4e7AVE1UY1PSRWJwfSVusnEo8UKG4SeKE
         xCuq7+j9HwULY6tnpIVNGDitqtj5cVIS6Kzk59hf4vxpN7PK1Wvh1XxIiDKfR5jPHWa5
         Nt0g==
X-Gm-Message-State: APzg51BiphUG/DO1tpl1+KC4g3VujF7FkbvmkZaKJ/3zahtF9v8Tjj24
        jPwnuRLKllAx07488JU61caPMSm1
X-Google-Smtp-Source: ANB0VdbsfdPfTAYlsekfodHzXWp6gBnbwuQ1Ce+ljjgXoOQP4T6iwgQAH6XCj02r58t7A0rhw95m+w==
X-Received: by 2002:adf:9a21:: with SMTP id z30-v6mr5640259wrb.47.1536324004096;
        Fri, 07 Sep 2018 05:40:04 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id 144-v6sm11093063wma.19.2018.09.07.05.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 05:40:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com> <20180904202729.13900-2-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180904202729.13900-2-avarab@gmail.com>
Date:   Fri, 07 Sep 2018 14:40:02 +0200
Message-ID: <87h8j1qy59.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 04 2018, Ævar Arnfjörð Bjarmason wrote:

> Before this change the "commit-graph write" command didn't report any
> progress. On my machine this command takes more than 10 seconds to
> write the graph for linux.git, and around 1m30s on the
> 2015-04-03-1M-git.git[1] test repository, which is a test case for
> larger monorepos.

There's a fun issue with this code that I'll fix, but thought was
informative to send a mail about.

Because the graph verification happens in the main "git gc" process, as
opposed to everything else via external commands, so all this progress
output gets written to .git/gc.log.

Then next time we do a "gc --auto" we vomit out a couple of KB of
progress bar output at the user, since spot that the gc.log isn't empty.
