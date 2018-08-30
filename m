Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8791F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeHaAQs (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:16:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37940 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:16:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so3225769wmi.3
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AK6pcyjmKLxUlACkG+jGE2AE7YQ06gSgVexfTQAQ7S8=;
        b=XQ8vXO3IFjqhK+lyGiUmu8LrO0Vx6l92nX8SFqw+kJHQJwLcjiu3Y5Do7IrZMZYGNv
         1L8Qcc+bOd8dXxKoyzhiSLbuNwfX1mDohaYpn69sdIkIojx2E6n3/vM8P3n/VfpgW/7S
         j8NTLIdXWvuN7Q1yZJqMGLkdoZV+R0zKrYOr5a5hU5CKXc0bOPZ8Zpo34udhbwqIbnlS
         u4u+Z/xR1JJH4COH49/usZOyslh8rgUI32ir8nC1BvmDPvwTOesHakYaJDY+74Idz9TF
         JrpBkjO5J32GVGKLNssvlY9qjM2lIf8dytnRtvPag1z1/gGcnMPxEruQzQncLHlu7nRZ
         RDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AK6pcyjmKLxUlACkG+jGE2AE7YQ06gSgVexfTQAQ7S8=;
        b=s3ewbxnJtsQstl3yzoDkeplLgICkOPTEcw2q6TPIzYag8pRoRZ/wr9FFBrWkB0KNau
         G6BcnutuGkO7e6lAAL6/kGXFJ0ryo+vjVJ0tUP2Q34Cx7U1f+BJd0TZOlGdDVvjYHC8g
         /HNWxunOcJEV4byQk8hlSW41e/PkQjWIA26K5BwJUZ679zEIPloRBwwfU1JiQZVw8XFV
         LTLSesWSVAqZfzml0mRdOZaWg0lahwLRG3AqxD0oXTrJewGg8YRKLCp86NKNXhSoxwHH
         I2bqBvTGcifrIprPuSXhXXTMSCYdDO3y7X7d15mVeKY3jPf1vluUD7O5Y2BKj9gDbRCF
         Rvig==
X-Gm-Message-State: APzg51AF8iNTu9sGtkMZlkv7GGEzPAEJSfYoOHoVX76fNUSkRXqWWwKQ
        B+/3ehrFxUnqQpdoHvd+EI/OnaEQ
X-Google-Smtp-Source: ANB0VdbcKQ8b+yiITDG6/VsrV+Oso0ul0sViORCNJ0O5+1gddHNXGbHJ3n5ko5oYVDgTWQacdLN2vg==
X-Received: by 2002:a1c:40d5:: with SMTP id n204-v6mr2804915wma.44.1535659974361;
        Thu, 30 Aug 2018 13:12:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:12:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] "git fetch" should not clobber existing tags without --force
Date:   Thu, 30 Aug 2018 20:12:38 +0000
Message-Id: <20180830201244.25759-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com>
References: <20180813192249.27585-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the tests for this have landed in master (in v3), and because
I needed to rebase these for rolling out my own version based on
v2.19.0-rc1, here's a re-roll which should address the (mostly doc)
comments on the previous (v2) round.

Ævar Arnfjörð Bjarmason (6):
  fetch: change "branch" to "reference" in --force -h output
  push tests: correct quoting in interpolated string
  fetch tests: add a test for clobbering tag behavior
  push doc: correct lies about how push refspecs work
  fetch: document local ref updates with/without --force
  fetch: stop clobbering existing tags without --force

 Documentation/fetch-options.txt    | 15 +++++++----
 Documentation/git-push.txt         | 41 +++++++++++++++++++++++++-----
 Documentation/gitrevisions.txt     |  7 ++---
 Documentation/pull-fetch-param.txt | 35 +++++++++++++++++++++----
 builtin/fetch.c                    | 20 ++++++++++-----
 t/t5516-fetch-push.sh              | 27 +++++++++++++++++++-
 t/t5612-clone-refspec.sh           |  4 +--
 7 files changed, 120 insertions(+), 29 deletions(-)

-- 
2.19.0.rc1.350.ge57e33dbd1

