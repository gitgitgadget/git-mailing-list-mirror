Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D063F1F462
	for <e@80x24.org>; Fri, 31 May 2019 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEaUXE (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:23:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45004 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfEaUXE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 16:23:04 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so1932224iob.11
        for <git@vger.kernel.org>; Fri, 31 May 2019 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=y9KKRLhM+RXJlCyi0GAVd3B90o18SG3kEQmcg5Gjf7E=;
        b=jixxQp699Q8ni9x9Lf2ECaHdgvxASLMlmHvaFXo2faCE8+zsNU+imNEIeUht2+8s7J
         ClkRC2RdSgbVdUdUmiOcnmiqHl+Dz/jR8LyaJirqW0V/FdyBFUurQswKp4k5BmapvHNC
         bniMAFExJJILix3CdmNhc1CZFDgTpTTCzBnoX9i9Q+bjEkbtNRm7TX25+FineltL19SS
         tLsTNXgTtZ0cW/96gn9MDELEQ69MKYI+pUwCkulqyKLLjiSez8/tSkGIDfK6AkWitnRV
         JumFn0OULtfLo2IqXRDLGIcvGuPI3M4t1NWJ9qgMltTq94U3gj5sNRwNzHtFq89KJNL4
         fNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y9KKRLhM+RXJlCyi0GAVd3B90o18SG3kEQmcg5Gjf7E=;
        b=JSucEIASeGEeicucQeUQSxhwViP2Ub68OAc9T+9F1Yi16zXT+WXpY76xZlluwPqGEK
         qRwYlFwgxjEhsRaMRGmhBFbq0mRRyMNGtyxVuQOFLyzBJN0IJWrBqpyPxAdifz5Uy//P
         0Ui15Mqqiov+R0z3JgNccfjt3yGnBCClvL1Ce+5vPIF1UG7jvoOeCmwEhy/T7pWezrTA
         KKg93eXwfweTL7IbHdptGU1mfb3j2VzLX17b0t/76tNBgJyazWDjPcbf3LzFNPSxmKGl
         5BjYn066gqL8uiCxLBuG041kfP0dRQDVMOsRat3vlLO275dnn5184uyp/7WKvMtx2Ac8
         bmdg==
X-Gm-Message-State: APjAAAWvdLolUYFXlQ+5VnNqNy+C4cic2SwPKcjRMo3h1YMi6DhZwKfp
        3v0h65xuUdZJ4Y+SLJLrBg9UwEB4
X-Google-Smtp-Source: APXvYqyS96dBt5cT6ozf/GjjJaKtlX7AzJ7J2L5U82qrg5PD+Wb5AW03aw0qaTh9OcULm2opV0A3Hw==
X-Received: by 2002:a5d:8a0c:: with SMTP id w12mr6703649iod.68.1559334183644;
        Fri, 31 May 2019 13:23:03 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id u187sm2296827iod.37.2019.05.31.13.23.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 13:23:03 -0700 (PDT)
Date:   Fri, 31 May 2019 16:23:01 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] document alias accepting non-command first word
Message-ID: <cover.1559333840.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I first saw Johannes' email here[1], I was surprised that an alias
where the first-word is a command-line option to be passed into `git`
was permitted. I was only used to aliases where the first word is a
command.

Document this behaviour so that users will be able to discover that this
is a feature.

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1905281235280.44@tvgsbejvaqbjf.bet/



Denton Liu (2):
  config/alias.txt: change " and ' to `
  config/alias.txt: document alias accepting non-command first word

 Documentation/config/alias.txt | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.22.0.rc1.169.g49223abbf8

