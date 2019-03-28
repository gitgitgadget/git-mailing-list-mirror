Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FD920248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfC1QOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37341 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1QOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so23643179wrm.4
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+9J3SVAVWhJiKXDaZ+gd7akPEjKvPC3FYgc0MNVYgo=;
        b=BUSkGMyujQ9kGLZ0IpCQRx9E/Uazu7Hde0IwgEuA6cZDjn8WzUIgJRgHhKdSTI9wQs
         SANgZZSaBiXEaASNHnwwPliBexZCCX7Ld3FrXlWb21yQIQKhxTRloOJGqivNKAMw0yTi
         9bRmSx9WOWwsYi47sR6VuJCd3aYPo/d82QXx60m09O5WSj18v5CS+ZYjZAFTb6eGNlah
         vMuXViaVqqdQ+sW8m39r2PgEPg9mDfLmselKY5SiX9PbDOEc6l/WiqYJT+5t7WLXh/kI
         WznEdp1W+0wcETqulAgahX0ilT9SsL884t6UQgsOLeJ3s+rPmTOL3eblNYYrZOqi30QT
         oUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+9J3SVAVWhJiKXDaZ+gd7akPEjKvPC3FYgc0MNVYgo=;
        b=mxVSVuJ9Eap7c/rGX+WiRs7TftKeb8PDjmhGXqDQcYrYYLjW5InraLAybOS8hRLm2n
         7EPsP2e7pnCAr/0L8+BazsJcJMSdW7apuj8iWtMZMctkwiiiZhsA8YAq8CR1vYuTJmX7
         Q70iAKXgCyZWgqOWA2qXpI3GFjOH51se4rmwWyr9rbfsDXVtNhozgjXjYKsU7rRjGLIk
         Gc+pVXK7sY357vu2vNg6Zp625hVe27bd/qYMdSrzhQKLViXmigriiaanYOcMNYC9XSXD
         FNrMyHpbkPo2IkFilW6/+BfldvkvH8qBo3aHZ+j2wBwLxn+RsKWK9rxCfuJRMPeY6IgT
         lGYw==
X-Gm-Message-State: APjAAAVymrORc+QjjkxvQMfr7Se59Yy/hYZONhe2czsV3jeMkskz58Du
        4X75dO5X5YMxULbw5KmNMFN/fl/g
X-Google-Smtp-Source: APXvYqyoqCzOJxRZccnJbJFYSMR5diXCJfNdSXKJBNNWJtT/sEpr2QV0qVPZEbtLlD6vAzLIMwqe2Q==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr28043257wrn.168.1553789684738;
        Thu, 28 Mar 2019 09:14:44 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] gc: tests and handle reflog expire config
Date:   Thu, 28 Mar 2019 17:14:27 +0100
Message-Id: <20190328161434.19200-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems the list software dislikes Michael Haggerty for some reason,
but as seen in my reply to his message my v4 has some unaddressed
issues in the previous 8/8 that I need to get to:
https://public-inbox.org/git/87pnqkco8v.fsf@evledraar.gmail.com/

I'll have limited time next week to get to that, so in the meantime
here's a re-send without that patch, but just the unrelated
cleanup/tests & gc "expire" fix up to v3's 7/8. The only other change
is fixing commit message nonsense (from an earlier version), which
Peff pointed out.

I'll then get to the issue mhaggerty noted & submit that independently
later, but this should be ready for queuing & moving down to next,
since (unlike the previous 8/8) none of it's tricky code we need to be
really careful with.

Ævar Arnfjörð Bjarmason (7):
  gc: remove redundant check for gc_auto_threshold
  gc: convert to using the_hash_algo
  gc: refactor a "call me once" pattern
  reflog tests: make use of "test_config" idiom
  reflog tests: test for the "points nowhere" warning
  reflog tests: assert lack of early exit with expiry="never"
  gc: handle & check gc.reflogExpire config

 builtin/gc.c      | 37 +++++++++++++++++++++++++++++--------
 t/t1410-reflog.sh | 25 +++++++++++++++++--------
 t/t6500-gc.sh     | 19 +++++++++++++++++++
 3 files changed, 65 insertions(+), 16 deletions(-)

Range-diff:
1:  81694c8213 = 1:  be889156db gc: remove redundant check for gc_auto_threshold
2:  4bdcf1d0be = 2:  764c9a7380 gc: convert to using the_hash_algo
3:  9444a1233a = 3:  d521c22103 gc: refactor a "call me once" pattern
4:  60a06ae618 = 4:  768aba9889 reflog tests: make use of "test_config" idiom
5:  52838fdc44 = 5:  2ddbee93a1 reflog tests: test for the "points nowhere" warning
6:  6063429f10 ! 6:  97e3d74371 reflog tests: assert lack of early exit with expiry="never"
    @@ -3,8 +3,7 @@
         reflog tests: assert lack of early exit with expiry="never"
     
         When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
    -    and --stale-fix isn't in effect (covered by the first part of the "if"
    -    statement being modified here) we *could* exit early without
    +    and --stale-fix isn't in effect we *could* exit early without
         pointlessly looping over all the reflogs.
     
         However, as an earlier change to add a test for the "points nowhere"
7:  6693d1d84d = 7:  48e5c234ae gc: handle & check gc.reflogExpire config
8:  e0814569ab < -:  ---------- reflog expire: don't assert the OID when locking refs
-- 
2.21.0.392.gf8f6787159e

