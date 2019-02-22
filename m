Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5A820248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfBVOll (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:41 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45055 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVOll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:41 -0500
Received: by mail-wr1-f47.google.com with SMTP id w2so2611525wrt.11
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NK6R8n6R6c1ZisBkUksBDV6KF91mF4QH39BcqYKH4A=;
        b=E/Xzk7AZv/CD4Br9OiXTbM4JjSrZ9H3+CBVKBi/v6bHpbwpPvC25W9qmEFpb+YLmVJ
         wgwz/6H6S8vbTRZxd39of1XH1Qz72UapbyGByL/H1LhrexT3nt8Bg9KTijSAGK4DFRJR
         DnwgmJc5C2VcKQcMXXyd33umh6UzDUIVIUmk1cTzDQdXltB+RUypSAF/1iMZJcI5VNaD
         Lx4epNZzh/QXtTtsDiRJOkM7eEgezbcir9ONbwb3+Ta5gCwb8Z4w0JyUz0nZ3MnPZmfa
         aQdAQxtn6/fGtalE+VOB8izSxmoy6NP4GqAxX0Ht4iDW2vU0AacJl+YAHSCyZcjYrUvR
         cjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NK6R8n6R6c1ZisBkUksBDV6KF91mF4QH39BcqYKH4A=;
        b=XQCb9wHhfE8G/RUpjfKDp7dSOeeCSNhqp3YmvECMthhsR5tlNSo/AFTmRV0AANsoUI
         xGIRwGUrsqb0K9Gjy28BUqW4eCEK9E2zU33NtXhsZWN/pSSGu+gm7lovIjeK83vSnfKd
         H5dpKtmv3ql7Qwzjr/fF4nnJoGoyLgj/H/uxi7NpjHMg5jPGAxF9/sEeudN/pqm/aqEi
         dhXKQG3H+6SPHAWBJp0tKypij90JG75H3JlcI7D6bvsrlnxHSTfXPqkktXlP/bsw2kvp
         zPTDJTdJEJoXKmkmSavVcot/eq7RhrVMnRBp3EJUQMeL44RxxBKaxG8N6cnkHhYVxrYo
         gm9A==
X-Gm-Message-State: AHQUAubtbthATudLe7bcOXU0cBuXJZ6+wJUByvERtkQtQ+HnO+UZBNy2
        bfkrkAV/dAAzHME1896R1k2tjiguHPw=
X-Google-Smtp-Source: AHgI3IZ+TcC4Ev7RppdxD3isE806Z88mKd0jwRSop/lY8N1JoUjmcswzZFQh5Ws2DPOvvcI7NDD7Og==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr3092871wrn.193.1550846499375;
        Fri, 22 Feb 2019 06:41:39 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] Makefile: allow for combining DEVELOPER= and CFLAGS="..."
Date:   Fri, 22 Feb 2019 15:41:21 +0100
Message-Id: <20190222144127.32248-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a long-standing annoyance of mine of not being able to set
my own CFLAGS combined with DEVELOPER="...".

There *should* be no other functional changes, but I'm moving around
some core Makefile logic, so this needs to be carefully reviewed.

I've tried installing with this, setting flags involved etc. It works
as expected, but we have no tests for the Makefile itself, so I might
have missed something.

I sent a stand-alone "Makefile: remove an out-of-date comment"[1] a
bit too soon as it turns out. I thought it could be stand-alone, but
as it turns out I needed to move some code adjacent to it. It would
conflict with this, so it's now bundled up with it as a v2.

1. https://public-inbox.org/git/20190222105658.26831-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  Makefile: remove an out-of-date comment
  Makefile: move "strip" assignment down from flags
  Makefile: add/remove comments at top and tweak whitespace
  Makefile: Move *_LIBS assignment into its own section
  Makefile: move the setting of *FLAGS closer to "include"
  Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."

 Makefile       | 63 ++++++++++++++++++++++++++------------------------
 config.mak.dev | 44 +++++++++++++++++------------------
 2 files changed, 55 insertions(+), 52 deletions(-)

-- 
2.21.0.rc2.1.g2d5e20a900.dirty

