Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7CE20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCEXUm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:20:42 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36294 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEXUm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:20:42 -0500
Received: by mail-ed1-f54.google.com with SMTP id g9so8716984eds.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/I46OQjBni7o58yQjuKsqZb/qci9dUiwnxclQJmgaIE=;
        b=J1KZcxAR4Y0dUkpxvCfD5B89xlFNPBZTBgmIQuP+ZMB3b63VhFknqlhUeukKjEDKkb
         +gpihKTeForMRj+5W+7poB526IxcdcBrWvSX9TyKL1XhSrFVFhH2oagJA9bIZeN3awyO
         htwiB+0qxr7K2xnluLUH/r/EY14NimfL97UB6mQ6if3zN9wQWwsewbQGSk9etrRBNquB
         K+8Lj8+kogo5MPY0SnxdVT94hYNMD/ADneSABXmZ5OmrJoz2dvca5C5MIWnvxtHEif/X
         TWZA+lTEibJAl+1dx7NyFNR5imPQJ0HYfOea65NnwKnzm1nrNJUa9Lh8CLIHxDZCGPwx
         xgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/I46OQjBni7o58yQjuKsqZb/qci9dUiwnxclQJmgaIE=;
        b=Q3JNItq+fbrtvu2aBACGz8AH3qG2MaDEvR8MGLc4z9GaQHejf1SQbHkqRSQZOWaRo1
         ptdGQv3oTO65HBi7BibJO5by4QvUuZrAzhCiwlrb+OCcYSrZJkROj3zTS3CAFAGW2jnn
         4JpjXv3Bd6/rwWTqNVihmZxQLWyl5bL03RS9Ah6qTasOqzteLeTaU1rQMUD4K5QNYeZp
         sWL9qAOs/rNjyDrtReNTNokJpFOvlk8PB1Zqgspi835sgUZR3CT7Gcs3mnsufOlAqeiy
         Qpt84xIH0izsCfAk2ka+2JLwMNBKlBGWRsWE0r7TbXQu3hdCNcIIquLOllLS2gzMtVGF
         3jJw==
X-Gm-Message-State: APjAAAUqHR2Xap3cIa/CmFYLdi5deqhMnlqaab5cbvQo+sCZWqqFwrHh
        4f4tqD/DP8dYHgH7R+hyF07rnGZF
X-Google-Smtp-Source: APXvYqw6FQlUFegwrVcq1GxWXh7H+2qk3HyaVUeAnQzkTYLvim8JqFMf36jhL0Ez2yCFo0LduatG1g==
X-Received: by 2002:a17:906:b742:: with SMTP id fx2mr1827800ejb.199.1551828040051;
        Tue, 05 Mar 2019 15:20:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13sm19234ejb.17.2019.03.05.15.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:20:39 -0800 (PST)
Date:   Tue, 05 Mar 2019 15:20:39 -0800 (PST)
X-Google-Original-Date: Tue, 05 Mar 2019 23:20:38 GMT
Message-Id: <pull.157.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] remote-curl: mark all error messages for translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested by Jeff King in a nearby thread.

Johannes Schindelin (1):
  remote-curl: mark all error messages for translation

 remote-curl.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)


base-commit: c1284b21f2436de24c9559fcc5f4badb04f47773
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-157%2Fdscho%2Fl10n-remote-curl-diag-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-157/dscho/l10n-remote-curl-diag-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/157
-- 
gitgitgadget
