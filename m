Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7E11F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeICTKP (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45953 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeICTKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so900923wrb.12
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5yqrUySfJ/7q0tO/8ynVOX+4OaQtGNYM7wHf4giKkE=;
        b=HyvI30DSpTP/PqtYt78hbV9qmyVpGuVOTqeWS+T0mMRxRjlVWRN3Cs1H0kGhBYlfp+
         ZfdcFGHIcnYjwbdZK6U4Ce3tghQQYP606Qq2Xkbj1DX+XqcpVr7z5hvEzZ2GmVietqUZ
         Ihc+CaWLdtans/Rxq+SgnXU32B+OxjeeUNMa7vNr6axSYul0ydfv/xoY6K4i/EnqVMR8
         HyobIRn+ZxC02Y+FThSurDxWgvgTwYG7Wmeu9+RiOSagK61fhclGRXvemHqbJkfc6X3+
         HNUrW9p03lZP9meQ94UZ+WY3qmkdPMQ/Yso+JBgFEpr7ItizTeY8E+NfIf0qEHWqpGNr
         5LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5yqrUySfJ/7q0tO/8ynVOX+4OaQtGNYM7wHf4giKkE=;
        b=ZqgxRLYky3hh5LbU6xwZQmA/FSiYPoW83ONHXBT1bWA+14GefbSsxvKLaVtwaUILjF
         /oBvyzIdGbTgQ/xhkEyVGLiLZLIBN3t1KPIzVgybuEbKgTLl/QMT6brldl9lyN2EOa+z
         4zAIG8mdH3ohA04Ogwxzqn6+lesYgBN5b1wOxZu6vmPoDQ4A5visnAATIRi26krC7m3z
         r6F4bhrjBxTkuuzf3dR9tNaVT3VC12ToUY/y2bUWNuIRxplfik+lyVI+IrLQe3lWU02S
         r0XwQ3HmBeZUzuBQYuKhTEPNajbtYjcPz5BUVh6CKU9Z8WU+gH4s4lN2vOPzvmtKOLUq
         STkg==
X-Gm-Message-State: APzg51CSfRITUxoimlBt/ik0qufLoDr9NQM0qoJK27xyXeXnITZYmto5
        yOiDSTESABCQsgSI44+8KP4byrvQ
X-Google-Smtp-Source: ANB0VdajCqqm7UvWxYRHv2kYXf0QCitFbAO62aD4AYDvZi26qGj8HzjPxpHhKxRRIpHuXgOF8IBCqg==
X-Received: by 2002:a5d:4152:: with SMTP id c18-v6mr8308407wrq.61.1535986181970;
        Mon, 03 Sep 2018 07:49:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/10] fsck tests: add a test for no skipList input
Date:   Mon,  3 Sep 2018 14:49:20 +0000
Message-Id: <20180903144928.30691-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent 65a836fa6b ("fsck: add stress tests for fsck.skipList",
2018-07-27) added various stress tests for odd invocations of
fsck.skipList, but didn't tests for some very simple ones, such as
asserting that providing to skipList with a bad commit causes fsck to
exit with a non-zero exit code. Add such a test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 6d268f3327..cbae31f330 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -137,6 +137,11 @@ test_expect_success 'setup bogus commit' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)"
 '
 
+test_expect_success 'fsck with no skipList input' '
+	test_must_fail git fsck 2>err &&
+	test_i18ngrep "missingEmail" err
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-- 
2.19.0.rc1.350.ge57e33dbd1

