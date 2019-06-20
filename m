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
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E691F461
	for <e@80x24.org>; Thu, 20 Jun 2019 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFTUmj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:42:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43650 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFTUmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:42:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so4345575wru.10
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWcb2VHZLzikEXjvyUhsBcUpVPJEFhJUDjm8NEZTFDE=;
        b=XMW34WGdcUDDwraDUivl3a9hjGwrH6CZesxsK3wMHskPCqzK8tsqI7TBHSW+cbAgEN
         VqCp3DQClVyqR4xioHvo6s5WfoaFFo+iy5KmD6d3uJGjSS9daOGyea+HD2THtg5IKo4P
         0U8/7EFvgIanQ/9Oe+F7yfeCeTZiKP+KFum4PfGxI8TIJIhDtIPLieJytvxJeYIBeBbY
         4XCtc+EgjFlTEWlez3hhdzQpn04QwZuvk+IY2oBYWXZAuRakSgD6cZVr6QH8oNstXr2K
         FLmFpbkN5Bc6wNaaf1JKVMZWMeB20+/ZVMhaSUZGoyhs4q1UFnHe9BdD2lRfhIjVSz/l
         n4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWcb2VHZLzikEXjvyUhsBcUpVPJEFhJUDjm8NEZTFDE=;
        b=I7tYGImkg62pDWyTGPuglF+CErqebhIpVmTfW0+klRN6Dwq8j4IS37Mp3ByqgjKAIw
         H9giohCfK1lyj63/KL9auYj9Zr2q6cqloeelUBKsQDehgLwssR9qq/g1pnT2Rk44Xrsd
         O6ulxkaIpHWDg8umbqYH+0OlgX6DYlAJiQCrfSphZJZvF4diArQpOiy+I94LoTfSKjDM
         p06MbwuMVIU4QL73eNvRU8gGA1BEqEPcXQrGmvQTS+GofzRSOwuIQ8+IqRulZlb6rmNM
         eBMByL291y6hU0Kdgbbqvy5h+eLx7cfrx6DjKQ3ub0Ji+fJJKVUwx0XBCtvrrFXeAPoW
         0HwQ==
X-Gm-Message-State: APjAAAVbBkN62bySVu4Hp0MApsvrvrVvNh0T8bVu30vooNhY9QEzx3RG
        ecivG4Ag8STyBYavHnrnPTSiLHyHKBs=
X-Google-Smtp-Source: APXvYqzTY6ZD9ed7uB2XopZat99f+2D5DAp1pcEWoAj3dbLTSRnpIIMEMLP57sM0crHdV+5HmQu2HA==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr42901528wrv.157.1561063357051;
        Thu, 20 Jun 2019 13:42:37 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s63sm380458wme.17.2019.06.20.13.42.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:42:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: mark two failing tests under FAIL_PREREQS
Date:   Thu, 20 Jun 2019 22:42:27 +0200
Message-Id: <20190620204227.8947-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190513183242.10600-1-avarab@gmail.com>
References: <20190513183242.10600-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a couple of tests that would potentially fail under
GIT_TEST_FAIL_PREREQS=true.

I missed these when annotating other tests in dfe1a17df9 ("tests: add
a special setup where prerequisites fail", 2019-05-13) because on my
system I can only reproduce this failure when I run the tests as
"root", since the tests happen to depend on whether we can fall back
on GECOS info or not. I.e. they'd usually fail to look up the ident
info anyway, but not always.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0007-git-var.sh          | 2 +-
 t/t7502-commit-porcelain.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 5868a87352..1f600e2cae 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -17,7 +17,7 @@ test_expect_success 'get GIT_COMMITTER_IDENT' '
 	test_cmp expect actual
 '
 
-test_expect_success !AUTOIDENT 'requested identites are strict' '
+test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identites are strict' '
 	(
 		sane_unset GIT_COMMITTER_NAME &&
 		sane_unset GIT_COMMITTER_EMAIL &&
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 5733d9cd34..14c92e4c25 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -402,7 +402,7 @@ echo editor started >"$(pwd)/.git/result"
 exit 0
 EOF
 
-test_expect_success !AUTOIDENT 'do not fire editor when committer is bogus' '
+test_expect_success !FAIL_PREREQS,!AUTOIDENT 'do not fire editor when committer is bogus' '
 	>.git/result &&
 
 	echo >>negative &&
-- 
2.22.0.455.g172b71a6c5

