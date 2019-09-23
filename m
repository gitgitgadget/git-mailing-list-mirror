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
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C0C1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfIWSey (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:34:54 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:44914 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfIWSey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:34:54 -0400
Received: by mail-pl1-f179.google.com with SMTP id q15so6848244pll.11
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E/fML2BAI/iYAMXSwPiEccKg1xAK5b3yyTfCfyjO5lk=;
        b=hd/cNE8RDOiwqz5YqkblBALw2Rgb1E4EGSMLjiU6YojppLM3ze7H18hEjGTbrQQ7dH
         vIH49rG4JGi5FIHHCoq7jQcFnjYOFTWm3wc3kXieqTCCYb51lIQxl0V9To5974kfYmda
         oWqxw61540tAUc7Q+XZvZktqwBjdsNYol2yr5NUhpO5RfM7S6ciDNuych5wyjGWVWLQ8
         URRvpeaAuJ3kakFWKp8l5+MB0de1JyKuwqKSxifsZK5/2e5xOK0HRbvoqK8X6e/Rw5Yq
         ntdJQujuPxasTezMNtMF6FWTMkCibgjeh9mXUklfRCDB9PzvV7HFgV2dJEgxWvgIjhOs
         nUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E/fML2BAI/iYAMXSwPiEccKg1xAK5b3yyTfCfyjO5lk=;
        b=d9I5b1+DqjOPw6b43ApfvRWvjj+ineNdvCdLv46Fsiughz8jqcxF+bfYiv2yqCng+N
         jylfL+W/zlt5QiOkGN0V8Qb3+LuDmTbluBBim6106JOZ2VOWmcxwEnZ1DET+kGdEIk+I
         BGUkPb6QQZZToVObhYp6y3ktE1as96xaCDEk2aAgJNZkxe6iQt4DoO59iH4uvO9pAYeN
         AUN6QOr/+gAnrPwXDV51yrC9IbLNQEtBIUNXn5BXVoaOntrpkrpuXwBg8o5G6A4yfib6
         +deUvAyJ4nIHDZKWp93PTXRLNxju7NRJ+Aj6Xm3wX7dn/MUw1ljTKRUvfoDaEtXxznxw
         6mdA==
X-Gm-Message-State: APjAAAWJc3YRNf7mX/FGW6QOMKoNOWXIb7cKGNgNKgqCKzQE/ydqwSRq
        yCCkdzTHK7MaPEoWeUN/vdcwYvfy
X-Google-Smtp-Source: APXvYqwV7rO52iLI0tNbH+44+09LW3N3ZMRHtwZHlVnxbyIYYRg0Qhj1aIynmg+BEbLpCaac8PsqeQ==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr1207688pla.214.1569263693371;
        Mon, 23 Sep 2019 11:34:53 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id l12sm9693637pgs.44.2019.09.23.11.34.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:34:52 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:34:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] fixes related to `make hdr-check`
Message-ID: <cover.1569263631.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset relates to `make hdr-check`. The first patch addresses
getting it to run on platforms which require custom CFLAGS.

The other two patches address errors/warnings caught by actually running
`make hdr-check`.


Denton Liu (3):
  Makefile: use $(ALL_CFLAGS) in $(HCO) target
  apply.h: include missing header
  promisor-remote.h: include missing header

 Makefile          | 2 +-
 apply.h           | 1 +
 promisor-remote.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.23.0.565.g1cc52d20df

