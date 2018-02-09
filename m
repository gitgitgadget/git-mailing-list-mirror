Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C8C1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeBIShI (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:37:08 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:41411 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBIShH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:37:07 -0500
Received: by mail-wr0-f177.google.com with SMTP id u60so6472431wrb.8
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=021D2+BYO9eBPif8cRDJUSLvLmPYBJUCiubRwhhOY+U=;
        b=sXXKHXfq8as/GwTUbFy2/rydV7E6Vu3F3Ht8NdOHyTBw1V1bQVgpvt5BLpvJqXLRLf
         gKnQ5/yL0ur1JaHE3Yi+Iv/TJRHNRNPbsS48OpxTZZ6NF+k7neTPq0hWZ5lhrVPKvauR
         rHZ9eQ6K43IFFQG3dkQWbI1XL+qY13vqElU+hXSB+KA8xrR0XHZOFLLXd3qeGpZZ4pEh
         ZjX75pYCa6Ta3Be5+Vcr7P9P/TeltGCKZ8R9hxRBSabRIATNHOAmbq0y1AN+Dh2zzR34
         Ym9pMyFJCMolOHnr3GJInnSa8xGIr2yzqrI6mSpp4zg3EUas2wEbtkRKBNQgnVBOeTwh
         ObLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=021D2+BYO9eBPif8cRDJUSLvLmPYBJUCiubRwhhOY+U=;
        b=MQNdHrxV26gUsX4DJCEtKKWjxHd1c2Qq/WMnAmSJGwAdGSHhG42lZf9p4KStW8pj50
         fzK5KtRsKxhBLNao7WtattrlwpRJeS6bVzbtDQZuT9LbBBdXkHvxvVNeyPXc2R0b8UKx
         pfCC/MubBWL3Y+zUC4oIxSWmWwoOGp14eYPcw7aEd1ilnX2BxacE6upKzp7FCjMH6wum
         wLmxzOaeAWvZVd4IHLsdYz2A1XYRvO3B8DX5jPexY9O3PQ6JGhmWSP6kKOiey9fHBgzL
         FRQhlvJMGc3YBpyNC0DRYJiZM50xZyF+TN3UTeePNd32uV6FiXckgwPOgpZzu8NG3Iqi
         BHLw==
X-Gm-Message-State: APf1xPA2XJwP6DgEJFxomfEjtRN8lyMQV+lWcSnJoqMhIbp5/FdsBe8e
        rAozjgCyXet1CdsgWAKuQkYIFfa4
X-Google-Smtp-Source: AH8x225n3uyx5FBAI1CgdMQjFQg453qTLRIQpwFhJRxCGR8XUzwE4kQ2/OvOERC28N8hcizrDijI5w==
X-Received: by 10.223.169.239 with SMTP id b102mr3519016wrd.232.1518201426663;
        Fri, 09 Feb 2018 10:37:06 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id s2sm3881596wmf.0.2018.02.09.10.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:37:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 19:37:03 +0100
Message-ID: <87372am2ls.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 01 2018, Junio C. Hamano jotted:

> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>  - update-index doc: note a fixed bug in the untracked cache
>  - dir.c: fix missing dir invalidation in untracked code
>  - dir.c: avoid stat() in valid_cached_dir()
>  - status: add a failing test showing a core.untrackedCache bug
>
>  Some bugs around "untracked cache" feature have been fixed.
>
>  Will merge to 'next'.

I think you / Nguyễn may not have seen my
<87d11omi2o.fsf@evledraar.gmail.com>
(https://public-inbox.org/git/87d11omi2o.fsf@evledraar.gmail.com/)

As noted there I think it's best to proceed without the "dir.c: stop
ignoring opendir[...]" patch.

It's going to be a bad regression in 2.17 if it ends up spewing pagefuls
of warnings in previously working repos if the UC is on.
