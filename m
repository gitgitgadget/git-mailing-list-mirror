Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C92D1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 00:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFZADy (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 20:03:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZADy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 20:03:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so557842wrr.4
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNjP9AGq+86jPVEIBErv+YBp3pqGUdnspoVsRNxF/s8=;
        b=U9S6hIAxsxytiBtYYbLtSUwBt1Ar2v63A4YIz5jhDIEhL4lfms0wiGMQjbMNtws4hC
         jMVB/Jq5ackZg1YoJLKIAcfDuF+wF4lw+F2pPXXfOC8YEwfQh73kX2qkgOnmNb88osp/
         vjU2RbiRnWAGdELv7HfeCKN9ZgvgLW2nhj24CUzRznJPmLxaEhP7/wDykldSXMT5KC/w
         uH44E6FZ01TOuR1l2BEckdwR7D47N4uLQW/OQBOsYOLJBYXl/5RhLX3wp2ukBfA9vKLW
         Sxq12kbOU76kp/kaTIUVZeYBeMw4ytCygtQgJjv1itxYes0r9EhbRP/vcxUHczZM8b2t
         Ug3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNjP9AGq+86jPVEIBErv+YBp3pqGUdnspoVsRNxF/s8=;
        b=J3J3jsqaP5yVuRNURFcTSG87l3QzxlTZPjlDc0WqKWXbWBZYE8DqxF9BVMnLfp6+s8
         ajN+K5PatKPrk1LTMz+uLOf1ou+fCwfowBfGtR7kZnpvVFGxf+jL9bkeHGI8a66Ah/ot
         +ISPU2HVYYOP/5NDcObNUpSqcoAsGi/NGmr6y2xhiKaZGz1QdbqrXXm7T0AoRMBF0Uq6
         zVtnE8kYWa6rlQnsiDWD4ziSfEB60S26BtU4OvvI+fQi1og+Mm7SGM/mS7ItHpKm82vE
         IaE0EugtwOyXm8fzgOFlDDeGicE3Lv+rk2UCw4LGe+eWIHM5IYftQkevt3ToEYnIS+5u
         OlNw==
X-Gm-Message-State: APjAAAWLkaL5I2Q0SOPlg6xpITLyfm2sT8K3zSoa5mJSlPdLainQITrc
        K6OgxYKnl5tNksH8VE9mLgw5oIuhqss=
X-Google-Smtp-Source: APXvYqyhzM4vgvOxFttHdBkegudLB3/C/J68qIhU7tn2PAqtTVZnVqWnGa2zRkmVUGiBFk7x6vnqmw==
X-Received: by 2002:a05:6000:e:: with SMTP id h14mr539114wrx.112.1561507431582;
        Tue, 25 Jun 2019 17:03:51 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm33645982wrg.40.2019.06.25.17.03.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:03:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 0/7] grep: move from kwset to optional PCRE v2
Date:   Wed, 26 Jun 2019 02:03:22 +0200
Message-Id: <20190626000329.32475-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <87r27u8pie.fsf@evledraar.gmail.com>
References: <87r27u8pie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This speeds things up a lot, but as shown in the patches & tests
changed modifies the behavior where we have \0 in *patterns* (only
possible with 'grep -f <file>').

I'd like to go down this route because it makes dropping kwset a lot
easier, and I don't think bending over backwards to support these \0
patterns is worth it.

But maybe others disagree, so I wanted to send what I had before I
tried tackling the pickaxe code. There I figured I'd just make -G's
ERE be a PCRE if we had the PCRE v2 backend, since unlike "grep"'s
default BRE the ERE syntax is mostly a subset of PCRE, but again
others might thing that's too aggressive and would prefer to keep the
distinction, only using PCRE there in place of our current use of
kwset.

Ævar Arnfjörð Bjarmason (7):
  grep: inline the return value of a function call used only once
  grep tests: move "grep binary" alongside the rest
  grep tests: move binary pattern tests into their own file
  grep: make the behavior for \0 in patterns sane
  grep: drop support for \0 in --fixed-strings <pattern>
  grep: remove the kwset optimization
  grep: use PCRE v2 for optimized fixed-string search

 Documentation/git-grep.txt                    |  17 +++
 grep.c                                        | 103 ++++++--------
 grep.h                                        |   2 -
 ...a1.sh => t7008-filter-branch-null-sha1.sh} |   0
 ...08-grep-binary.sh => t7815-grep-binary.sh} | 101 --------------
 t/t7816-grep-binary-pattern.sh                | 127 ++++++++++++++++++
 6 files changed, 183 insertions(+), 167 deletions(-)
 rename t/{t7009-filter-branch-null-sha1.sh => t7008-filter-branch-null-sha1.sh} (100%)
 rename t/{t7008-grep-binary.sh => t7815-grep-binary.sh} (55%)
 create mode 100755 t/t7816-grep-binary-pattern.sh

-- 
2.22.0.455.g172b71a6c5

