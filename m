Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D151F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfA1RtI (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:49:08 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46374 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfA1RtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 12:49:03 -0500
Received: by mail-wr1-f44.google.com with SMTP id l9so19004843wrt.13
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OyCbREPIJEEKJT6FmdaaSjav0P+0gCS/LoK6Ujs7gEQ=;
        b=UtALeKDrrNUk5wM3vfIRFtq60HE+M6YV1DJRphgGGIVQI5RW6jNrgnRoOYmRQiBGTI
         I4K2WM+8qEnpWPdeYPUJwPYnylwwrhSynaiR/xLHGJvMsfgtzg02qLAkFJaNM1qVcRmH
         kiihyKVJSNvOMnMqt2QYQvLeLQQgLJlK8iXQij8qBbQjm4pNXahind3Xf39bIvGq086k
         U1v2K3coIxYIKSt6CA2TS084AzEPvfNnACJz2iuyxDTeLGO1Cd0vgmgRZqJ6c6ALNwLW
         vEAXmEZ306Jq76Iz0MXrC1usMvMCJJ9kd2XWPhrr2S38tB9P51Eyk54GcmYzJJlCqTe/
         CrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OyCbREPIJEEKJT6FmdaaSjav0P+0gCS/LoK6Ujs7gEQ=;
        b=KcrBO484rDfNd+qOp92A5XJca1nOyJDCWoCLXAIdeiXvR8V2BGS2xBQ6cqNxvkooY4
         DB0V/KwNVBANMS+lJ0zDSNaFw02xpzSMSziJv0sDvS7eOuSYLDeQAVoUeqen6axAGyA1
         VFkqQo6wPiJLv1ok4vpDN7UqRJxjmMHF8S3tsqeAFhmpuPkKpXZ7d3r7FHMRafA2+yVr
         KeiPEmayy3rmQIS/qs2737hen/nFiwqQSrjiOHy6lPi5aFWOtTCO7p6RU/6Wlc8stDKc
         ZDBA44WTe5wLEQq+SYsEbE84o5isHIsOlVJjlfzyuQBdxu3WNqimJHrx0G3Ykky67zpg
         kSGg==
X-Gm-Message-State: AJcUukfmR2xO1rxouMv+Pn2oaWYzltv/kZTBj2At1ZbjL+TnSAuDIXYl
        EFAKY6aRYxG3AZVQ1zUHtg5MjIvgLrY=
X-Google-Smtp-Source: ALg8bN7+Wyf0APbsr2ub2mPnkaRX7nfj0frDgzttnbgrx4Cy1Kay1vQMCUYpsabGH8glWpd2YTD2SA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr22192570wrs.281.1548697741451;
        Mon, 28 Jan 2019 09:49:01 -0800 (PST)
Received: from sid (dhcp-18-250.cable.infonet.ee. [212.7.18.250])
        by smtp.googlemail.com with ESMTPSA id b13sm104243595wrn.28.2019.01.28.09.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 09:49:00 -0800 (PST)
Message-ID: <dcc7522f57ba4bd60412c7dec0528a879027824d.camel@gmail.com>
Subject: Re: [PATCH v2] git-instaweb: Add Python builtin http.server support
From:   Arti Zirk <arti.zirk@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, gitster@pobox.com
Date:   Mon, 28 Jan 2019 19:48:57 +0200
In-Reply-To: <20190128165236.GC423984@genre.crustytoothpaste.net>
References: <20190124161331.25945-1-arti.zirk@gmail.com>
         <20190128132458.31401-1-arti.zirk@gmail.com>
         <20190128165236.GC423984@genre.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I will point out, that despite what the PEPs say, on Debian and
> derivatives, "python" will always invoke Python 2, and never Python
> 3.
> 
> This is probably fine for now, but we'll need to reconsider it before
> 2020.

In this case it shouldn't be a problem because I have made sure that it
works in both cases.

