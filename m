Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C801F4B9
	for <e@80x24.org>; Fri,  6 Sep 2019 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391833AbfIFMNe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 08:13:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfIFMNe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 08:13:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id p13so6861987wmh.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0yfZ/1pj0cmtZbv6Nbmw0g6f5GTXrQIbytkFPLLtRI=;
        b=GLMZfLUAMEVnfDI/9HGNBPqvCEqPkSslKb0k2uLvIj0i03vxTKHepsAACR0ajbCnIJ
         5XZ4c0GDukCeZ5t/X1gjhba/FcXlS3fDpZLvyJFx3WwD3uv9ujqQPsAYQ2Zfjg4f0clw
         6CohgohKtZhDbFHnFPJNLvMPfJEHHMiRgjJNUVNEuFAAqwzOJL56sfUhiwtC/0UHbMXj
         tkixa6Wqm9GnS2xSfsn6Mf6DGGRoUQTzGbWdNQxjubZp65AXwwwp+r//hqA7mCPFYOU6
         sRb5lucPHzvGMWilyRGFQAQ/FnTupnBlFRpPM7Vwbppp5+EkhKMV5Uf7XrNkiX/+SLig
         1Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0yfZ/1pj0cmtZbv6Nbmw0g6f5GTXrQIbytkFPLLtRI=;
        b=n11JAgxU8H+8QYH2q13kbXVvOcelP5a8z49WyyTBiTze4zLiHmnWPmC7+R2Q0YSuy9
         b1CJ9k9O5axNTHzQQiEvDJVwTqIP2uOqqroUEV1ZI5meEZkJJO+8t3QamM+Zu+RhNBxQ
         cnNcFp7M4WrPVVekrLTg7WFBFz1sa700YZGQK7gqtGDt87jEZjNfzJGLlq9r0Q7mQZcV
         qgtLmeTwMbECmg2m2rnfE0YRxDU6YwLEcMfNi7gvkRqTW0Pl33WoI9E6Ar47yMWrY0vA
         5JO94ls1jqZg/607JrbhC0t1RgAX2Q9EwooYP+eQsHsZ/vjgBE3MzNIXjz6f3XzP9vpf
         N6XA==
X-Gm-Message-State: APjAAAXl+Bc2l6kB9ijKR09LQ6FcT0onDo/Dx9ciQe5XsOKyv+K5DvCz
        XxnM9b4rwkBqvVDlvg7JErY=
X-Google-Smtp-Source: APXvYqwgj9XPuAMoYTkBHc78bdqEb+PC15pykKr5hkcZ4tjhNFsOzyW0C4e8umLvb2LEFJzfZYtnmg==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr7259613wmg.3.1567772012229;
        Fri, 06 Sep 2019 05:13:32 -0700 (PDT)
Received: from localhost.localdomain (x4db936a8.dyn.telefonica.de. [77.185.54.168])
        by smtp.gmail.com with ESMTPSA id e15sm4416826wru.93.2019.09.06.05.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 05:13:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] ci: restore running httpd tests
Date:   Fri,  6 Sep 2019 14:13:26 +0200
Message-Id: <20190906121326.23056-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190906121326.23056-1-szeder.dev@gmail.com>
References: <20190621101812.27300-8-avarab@gmail.com>
 <20190906121326.23056-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time GIT_TEST_HTTPD was a tristate variable and we
exported 'GIT_TEST_HTTPD=YesPlease' in our CI scripts to make sure
that we run the httpd tests in the Linux Clang and GCC build jobs, or
error out if they can't be run for any reason [1].

Then 3b072c577b (tests: replace test_tristate with "git env--helper",
2019-06-21) came along, turned GIT_TEST_HTTPD into a bool, but forgot
to update our CI scripts accordingly.  So, since GIT_TEST_HTTPD is set
explicitly, but its value is not one of the standardized true values,
our CI jobs have been simply skipping the httpd tests in the last
couple of weeks.

Set 'GIT_TEST_HTTPD=true' to restore running httpd tests in our CI
jobs.

[1] a1157b76eb (travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh',
    2017-12-12)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 44db2d5cbb..29dc740d40 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -160,7 +160,7 @@ linux-clang|linux-gcc)
 		export CC=gcc-8
 	fi
 
-	export GIT_TEST_HTTPD=YesPlease
+	export GIT_TEST_HTTPD=true
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever
-- 
2.23.0.331.g4e51dcdf11

