Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20AAD1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHaAQw (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:16:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33976 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:16:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so9202945wrd.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v24ka9YFvWtPnhCebKr4yYIlq1cOwKXPtzTW/MuZLts=;
        b=Ic68o+Mt7sMub4QnC7oDf6ZhJQVrVAKpeVl+2QHsEQJdZnBiJShbOAozlfCrIfOyqe
         6SKWZxuqnwUlLfUU0l8l8Ig3odoEuaYR4yLkEt8GwRalfWlrI1C+JeSiKGeXG7KfUUHG
         eHope3OOprL9XrN1w4P+A19yVivIY9CRidWhCmq7fhe48W2evX+nxSoUFoDWUZsmQVeG
         Wr/bmxuLhgoEi+FwI5GBUq4VHPUrJMBKnseOS+xudv6NfWQFHOT4Dyj1tAmfjQausgCO
         95rRE3hXfgKV/eWeoKIms7s9J3olrJqdfzU+OBY2kv1H2hO7ArMn7uClNYvlSeX/USGM
         LA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v24ka9YFvWtPnhCebKr4yYIlq1cOwKXPtzTW/MuZLts=;
        b=iZa0+8OjoHK+qQpqPDe8oAnjesUpFcuinS2FWjITtoBtFymYp0xlN1DxXD88N31xsA
         A5PhacB8yRMPBlLeJQbJfH+VxP7U0xtXJEDltgVRlcD9vZPh/tuxXT4jyKZYTiZiPKQy
         xkMKtuF0wZ1HJzC9EFRdk7WcvzI6Qcny5rIjTZmH7WxcDdX31pAJeAqQDp1p3DHsPOsI
         N185nSoSeIZSmr1TrYyv3dX6C+AuU0/8VB95kUn40QTWz/5TanMOCbeR+LfASGsXN6UD
         HWFn6ateNS5qkGfEmnE+2zCZlOiYkE8c5e7pAIWGeUnQQBcx/uRQv5X6Yis+uuz3d3hA
         vIdQ==
X-Gm-Message-State: APzg51CU3NtVTcMPT998ivBiRdoXhq7nwz2PZ2Qy4tThZWxgnsuXXrRr
        cWSvfveoJBtv53TGS9U8JaIGJtd8
X-Google-Smtp-Source: ANB0VdZ+w1Rwgz+Iu5JFKSkbiTHQUthqWHS8cVC17me33WByJZ5XELz4RaZsNeXtFjGSXDaOzilMYg==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr9064784wri.221.1535659977670;
        Thu, 30 Aug 2018 13:12:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:12:57 -0700 (PDT)
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
Subject: [PATCH v4 2/6] push tests: correct quoting in interpolated string
Date:   Thu, 30 Aug 2018 20:12:40 +0000
Message-Id: <20180830201244.25759-3-avarab@gmail.com>
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

The quoted -m'msg' option is passed as a string to another function,
where due to interpolation it'll end up meaning the same as if we did
just did -m'msg' here.

In [1] this was pointed out to me, but in submitting [2] the patches I
missed this (since it was feedback on another patch I was holding
off), so this logic error landed in 380efb65df ("push tests: assert
re-pushing annotated tags", 2018-07-31).

Let's just remove the quotes, and use a string that doesn't need to be
quoted (-mtag.message is a bit less confusing than -mmsg). I could try
to chase after getting the quoting right here with multiple
backslashes, but I don't think it's worth it, and it makes things much
less readable.

1. https://public-inbox.org/git/xmqq4lgfcn5a.fsf@gitster-ct.c.googlers.com/
2. https://public-inbox.org/git/20180813192249.27585-1-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 539c25aada..69f7c9bfe6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1009,7 +1009,7 @@ test_force_push_tag () {
 }
 
 test_force_push_tag "lightweight tag" "-f"
-test_force_push_tag "annotated tag" "-f -a -m'msg'"
+test_force_push_tag "annotated tag" "-f -a -mtag.message"
 
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
-- 
2.19.0.rc1.350.ge57e33dbd1

