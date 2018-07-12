Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114381F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeGLMrC (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:47:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37124 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeGLMrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:47:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so21766499edq.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/AbEmCXwP5x4ZABfmt0P59kiU3DTlMKbEIR5lSImNVE=;
        b=kGTkiNpsk4ODpRZpDulo6cB+WJQ98O+KQuLQ5LqVPSoDdeUSnxLq0XpqEDoESFphEy
         9zg/vJtCyHpX4TILBS4se+O2MiE4cR0YC+Main7BztOM9QWAReciWFa7pspt1pclTRfk
         ijZob3ZopI5z5sg6FJh23IQdhvarXH37yptppaG//2Y6ruUBga8jShzovbaS2DBIle1F
         uWcmHyXDrOj2k3oJ/V++sf+MVEDpq9k6GOVrSrjJF7lAcJrtz0PGuUGQrAiDj9aGbNz7
         5TqvEGmTla7sTiwwSE3eYeDiJJ+7K53sJbdVASVJWzd4L7cc5WgfgDvKeO2MwAXDejQR
         h6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AbEmCXwP5x4ZABfmt0P59kiU3DTlMKbEIR5lSImNVE=;
        b=LSy5Fqt5XU8nSs75D6SDU9pkpZNKOzE7ZkICDHEtsQoePLGYCaG8ChKdStJlhwS4NP
         qD8T9gjoijvBF0SuO60z0NLLyKbbk/y5NCoBmjxUqcQfm/jwSHaSLt5iMIjRnLlINYXH
         2d/3PAZt7ljCaIuMADHtwLTvjcFuTKAi0dMep5oP1+N6S6JE61OSDGdhaATb8Oe1aDqA
         mGyIfT1kUZtGmzpUMUak916oVnGVKOuKVyyL55k8XTxLUNEw77YFJhBi/eYvaEgKfKeG
         fUMEWLbhwtnwHxJazHY8XZStxpET7K+AEjWaosVf1b3DLKKp3fcWTiwLfiV1B2PEFAem
         NAAA==
X-Gm-Message-State: AOUpUlGK48rU1KQKA9y+PuhCdspjyuedX+jKX/P7mMdU9yA55Nrlx7Dp
        1nwiuL5+7WdkshgLQ5fZN7U=
X-Google-Smtp-Source: AAOMgpe2yWdxqAyEU6ROx6dvQ+QYrGebe8/32+qS3cDv+jX955xD9d+JIGBXiIDYBadlvBzsoJP+Mw==
X-Received: by 2002:a50:b4db:: with SMTP id x27-v6mr2399980edd.155.1531399058010;
        Thu, 12 Jul 2018 05:37:38 -0700 (PDT)
Received: from localhost.localdomain (x590d07e3.dyn.telefonica.de. [89.13.7.227])
        by smtp.gmail.com with ESMTPSA id d11-v6sm11604309edo.63.2018.07.12.05.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 05:37:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
Date:   Thu, 12 Jul 2018 14:37:29 +0200
Message-Id: <20180712123729.17861-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.305.g66e9e0a543
In-Reply-To: <20180702002405.3042-22-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-22-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t5300-pack-object.sh         |  2 +-
>  t/t5302-pack-index.sh          |  2 +-
>  t/t5401-update-hooks.sh        |  4 ++--
>  t/t5500-fetch-pack.sh          |  2 +-
>  t/t5505-remote.sh              |  2 +-
>  t/t5512-ls-remote.sh           |  4 ++--
>  t/t5516-fetch-push.sh          | 10 +++++-----
>  t/t5517-push-mirror.sh         | 10 +++++-----
>  t/t5526-fetch-submodules.sh    |  2 +-
>  t/t5531-deep-submodule-push.sh |  2 +-
>  t/t5543-atomic-push.sh         |  2 +-
>  t/t5601-clone.sh               |  2 +-
>  t/t5605-clone-local.sh         |  2 +-
>  t/t5801-remote-helpers.sh      |  2 +-
>  14 files changed, 24 insertions(+), 24 deletions(-)

The change below should be squashed into this patch to fix a
previously unnoticed broken &&-chain.  I think you missed it, because
this test script is rather expensive and you didn't run it with
GIT_TEST_CLONE_2GB=YesPlease.


diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index df822d9a3e..2c6bc07344 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
 		printf "blob\nmark :$i\ndata $blobsize\n" &&
 		#test-tool genrandom $i $blobsize &&
 		printf "%-${blobsize}s" $i &&
-		echo "M 100644 :$i $i" >> commit
+		echo "M 100644 :$i $i" >> commit &&
 		i=$(($i+1)) ||
 		echo $? > exit-status
 	 done &&

