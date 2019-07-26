Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB63E1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbfGZPJM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37560 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGZPI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:08:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so29721003wrr.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJsv2ZPcQ3cQgyt0ZpsJs6aD0X7nmtWlErGatxUzfMM=;
        b=c1eahldopWPuzBAjI9TTTvCQlJvL/KiwZp40NRvoeiM26D/gnl0qy9DZ4SboBnBZjY
         D0jlmX1MKXQ4ZyaSsEQ4zVMtkapFPeFCJRr6fo31GSvwaC5DtjdYe47NqEAOLnHNd/nu
         rQcNo8CxEQZL6t9gy3rz1Sa66ZVWfJx638ZgvnLLvwMurWzwzZxR8ZoIq8dZqq4pOcYn
         tir11LGQuONR5H/AwNB872DATFCN0ZVqJNM3IU4CV2j31Uwp2pF5aAxrc528hu3XSBH3
         fvrPBouMrAEoptURT0UleEkvv9Ae0TQAmWJX7XS05ao/FAPzdp0OPXwFHpKSSCMbBhwH
         Jj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJsv2ZPcQ3cQgyt0ZpsJs6aD0X7nmtWlErGatxUzfMM=;
        b=DfrtuC1q+o7jimVEWg0LfHkRPY2992eyd3KsO/RLczSEWyX8MeqKOD2s804D93cbwN
         cLWpLNwmYOfgo4JxcOWlOgyXOJqxhnXujDww+v1AOIwS0Ks5nAprd+vnDjFQSXZt9qzV
         jeyreY3EJI81YwS7T1mI3PJLfwYfb87TQ4Q6spn5BECVmCjb3nZkJIap8PCuWjlO0n2v
         +4ltHQAL5+VF+151AhxMk1IcgyOEzTu05NpeEMmIGzLNWNi80DpJTxC73ggv0njtvfOt
         qMrlUzTKur3Rz7JFxYsJ6uQbJxVLxMaZHUp58D+a0wxEVjaquZFj2CqvW/3NgNXoH6br
         LAWg==
X-Gm-Message-State: APjAAAX6rlN4fAjMMy3eBu3Hb7AkTteN5ZiYYhCGeKMOIcAze4kaW+TK
        ZrEgx6WzUfrRsRXAZ+qyHfNLyIOW
X-Google-Smtp-Source: APXvYqwP3Wf1e7RXHvUX/7yqyXWJQNlPssxw+X070EOsI89aYmTkS6EUgpuvohZ+lZKKHU/nuoSOrw==
X-Received: by 2002:adf:f450:: with SMTP id f16mr70556883wrp.335.1564153736888;
        Fri, 26 Jul 2019 08:08:56 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.08.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:08:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] grep: PCRE JIT fixes + ab/no-kwset fix
Date:   Fri, 26 Jul 2019 17:08:10 +0200
Message-Id: <20190726150818.6373-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com>
References: <20190724151415.3698-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1-3 here are a re-roll on "next". I figured that was easier for
everyone with the state of the in-flight patches, it certainly was for
me. Sorry Junio if this creates a mess for you.

4-8 are a "fix" for the UTF-8 matching error noted in Carlo's "grep:
skip UTF8 checks explicitally" in
https://public-inbox.org/git/20190721183115.14985-1-carenas@gmail.com/

As noted the bug isn't fully fixed until 8/8, and that patch relies on
unreleased PCRE v2 code. I'm hoping that with 7/8 we're in a good
enough state to limp forward as noted in the rationale of those
commits.

Ævar Arnfjörð Bjarmason (8):
  grep: remove overly paranoid BUG(...) code
  grep: stop "using" a custom JIT stack with PCRE v2
  grep: stop using a custom JIT stack with PCRE v1
  grep: consistently use "p->fixed" in compile_regexp()
  grep: create a "is_fixed" member in "grep_pat"
  grep: stess test PCRE v2 on invalid UTF-8 data
  grep: do not enter PCRE2_UTF mode on fixed matching
  grep: optimistically use PCRE2_MATCH_INVALID_UTF

 Makefile                        |  1 +
 grep.c                          | 68 +++++++++++----------------------
 grep.h                          | 13 ++-----
 t/helper/test-pcre2-config.c    | 12 ++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 39 +++++++++++++++++++
 7 files changed, 80 insertions(+), 55 deletions(-)
 create mode 100644 t/helper/test-pcre2-config.c

-- 
2.22.0.455.g172b71a6c5

