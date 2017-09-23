Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD5B2047F
	for <e@80x24.org>; Sat, 23 Sep 2017 07:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdIWHLO (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 03:11:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36573 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdIWHLN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 03:11:13 -0400
Received: by mail-it0-f67.google.com with SMTP id e134so1757362ite.3
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=/cvDnVr5rDsET18FlaWvcfNjY38VMervUoDuNs0PMYA=;
        b=Hn8J8D/wiOtKejZztXA6P82gpexAxz6TnyoSU7IU1VP5BJbYBMXZgwxk47qvIcXVjd
         gcdbqvrXI/HDAoLhXvtZtsbioC3zg1h2zouefxMcDx/tOhy3DHOiUzERtSBbS/yYrI9c
         BRt756FiOs2pCrYRcz7pI07Qicm5g3yElzUbaBH4BFENYwmJP1hD2qDpy6u4tgOQn84C
         4SutvcmUCKmLcRQDTfXwP3XCxNfQyowB35bJFEqti92d8XJyqiPKnb8B63lQe7FVO5fu
         cItM1cnTVsNUZeRobwnXvsGnWTb1O3EnTbEQv74P5Ze1A1jVDicGbalMyBtZYD7s3p6T
         rCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=/cvDnVr5rDsET18FlaWvcfNjY38VMervUoDuNs0PMYA=;
        b=QaLtE+owZnhdVXifcTDd0B9ZogULJgSD6Liv3xHqFA/T8qdZPjX2J9Mo6boXxFnbIe
         4/uU28NyWrL+7FHLRW+YUB8dA8DlOY33LAVIyLPVVGL6GKMNcF+oSDzRbbYYpr85wgs1
         stCXk/C1BLvq/RF9SAlietP10yZyztS5ANlkkXSZVUE1+4S3cPnY67x3nmoSvd2Qxotw
         /8Ffim4evAUSmoUeASqCMQxu9u90n4ymKaD+ed76d+OifkIADaRaslW8Q3Y975jSdzPn
         SikBSyZzxHNkaUJ91GG9hOIGWXEdqWL5RHApKO42V+J7zoOLVWgkqvSpxF3zcFogANTl
         INyA==
X-Gm-Message-State: AHPjjUhOSMNBaCyLBIuBPe8H1XWoVRlUgcsrKA0nU0Pr+SPXPhYGsL4v
        fUwbMcJ3iPm3xsAk+JSDX5m9iIGH
X-Google-Smtp-Source: AOwi7QAuLzlBL/lnNfSTUjSYOub+HSp1KG/UmLnGS5ncsxruo+rY+qUvKXj3naQ9/jo0H8unGiYSAA==
X-Received: by 10.36.37.194 with SMTP id g185mr10365465itg.14.1506150673214;
        Sat, 23 Sep 2017 00:11:13 -0700 (PDT)
Received: from unique-pc ([2405:204:70c5:34d4:d97c:af1b:33e7:ca29])
        by smtp.googlemail.com with ESMTPSA id k76sm1616025ita.4.2017.09.23.00.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Sep 2017 00:11:12 -0700 (PDT)
Message-ID: <1506150665.3877.7.camel@gmail.com>
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <20170921033152.4hbkctzxraww5rqo@sigill.intra.peff.net>
References: <1505626069.9625.6.camel@gmail.com>
         <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
         <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
         <xmqqpoakn8tj.fsf@gitster.mtv.corp.google.com>
         <20170921033152.4hbkctzxraww5rqo@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 23 Sep 2017 12:41:05 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-09-20 at 23:31 -0400, Jeff King wrote:
> But I have always been bothered how the saved state
> is a bit hidden from the user. It seems like a recipe for user confusion
> when they save something with "git stash" but then "stash show" doesn't
> even mention it.
> 

Yeah, I feel the same.

> I guess the nuclear option there is introducing "git stash info" or
> something, and marking "git stash show" as an alias for "git stash info
> --worktree".

Sounds good.

> but I'd be happy to review if anybody picked up the topic.
> 

I would be, too.

---
Kaartic
