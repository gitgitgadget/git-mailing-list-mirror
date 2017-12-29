Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9652F1F406
	for <e@80x24.org>; Fri, 29 Dec 2017 00:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbdL2AQq (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 19:16:46 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:43153 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdL2AQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 19:16:45 -0500
Received: by mail-wm0-f53.google.com with SMTP id n138so46141899wmg.2
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 16:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ffng5LHrGLprxSqRc+FNe8V37IuHtbWNtohk+3KRTqg=;
        b=ssnOJKCA63GMobpzKhQxyteix8zUrkX3HUfmbnE2AlX1iANjCTcuQnS+1i8YuAxAT1
         Mj2nkBUnqPiNxUCqIC0xeuIyBXMZUfW7sAx27KqAjXJ3Fu3X0DkElrA/DI9q18P9yM3L
         CXNrWGOT3L6yqtJJOUaeDufqs1XYniVcgDEFthn8COOo0mdv6tHrZh8F/+Pi3MWGlR5P
         bfiGKv/KoVtXjZQPdFWgsVN5sKC2Ma6vL+ZWdXt929XvsB1WCLlO9EOKb+1JhVcHVC1y
         koXHk7ZYag6ZA9qBFfW7ZuVd+lrQn7b/xozIreWUh3jpGqoQ+Bs6fQPKkNdZKNuH4xK+
         CDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ffng5LHrGLprxSqRc+FNe8V37IuHtbWNtohk+3KRTqg=;
        b=r0RjGaCpcqJZ+eK6EP6x8C+QQgneRuRcNdmYrdFVA/yLeBzHce2HA8i1b7lcgTgWLl
         VKDexOV2jYMmqzW3KAV2UoFKTneTCkCBV2/NecBQo9vMFa0XIw8A107QrOiQvTWEG3nX
         8oDp5GE/XvWUexmmu9iON1XqnAzK0zktfEt67Alqe5JxWF0QZdjPk/TXsA5kivGDuT2L
         6OUyevYwkPbo2nZYsktSPa9244qtrzs+g2tmeRLDLxFvMgqI1ggD1UtR7Ew1Tvv63/0y
         TKttDpYIUseA/tICsxalO2lmjzStJMa5xb1p9W6QJG+PgpWLLAAoBcEtHAMq6mv/d9/j
         kbDg==
X-Gm-Message-State: AKGB3mI6y3w/sZ+fVpIUxauU8uojChGoKOAazkOH4mNtC19CdaMyQOJJ
        PxrznkJXVfwyV9g0UOVxhKY2BZQt
X-Google-Smtp-Source: ACJfBouttku+yOVdqeV/uNy+SjE3xykKScPuIo7cmyJ01dLYnG6yYwS3SFLgzGAguTZouPPxpXbXlg==
X-Received: by 10.80.188.20 with SMTP id j20mr41680378edh.243.1514506604449;
        Thu, 28 Dec 2017 16:16:44 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c30sm28025040edf.1.2017.12.28.16.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 16:16:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 7/7] wildmatch test: create & test files on disk in addition to in-memory
References: <20171228232823.14450-1-avarab@gmail.com> <20171228232823.14450-8-avarab@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171228232823.14450-8-avarab@gmail.com>
Date:   Fri, 29 Dec 2017 01:16:42 +0100
Message-ID: <878tdm8k2d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 28 2017, Ævar Arnfjörð Bjarmason jotted:

> +		pattern=$10

Junio, in lie of me spamming the list too much, do you mind squashing
this into this (if no further issues arise):

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index d7aa7eb5fe..f985139b6f 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -89,7 +89,7 @@ wildtest() {
                match_f_w_pathmatch=$7
                match_f_w_pathmatchi=$8
                text=$9
-               pattern=$10
+               pattern=${10}
        fi

        # $1: Case sensitive glob match: test-wildmatch

With this the tests pass on both bash & dash.
