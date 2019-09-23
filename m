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
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E0A1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392575AbfIWIdZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:33:25 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40258 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbfIWIdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:33:24 -0400
Received: by mail-wr1-f52.google.com with SMTP id l3so12857663wru.7
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bod1FpFujQemY4tdbiDIKeVUbtr7eOMXD4r3xG9Hv5g=;
        b=gUNdVKQ7rCE9NFKisQXoBwiYM4wStC8oV5/e2MoLlnuLfmfOoWEgz726Q8qaV0ckiR
         cEpla7yQR+OQay9Bcoc798tJt2M/kdT1uGTqq4++ZtVu0xg9x3CFzC0PJejDn5wDXOiL
         ivG33uPg1vATEEqZWg1pGUj6HKaBVT9XAhP6MlgutLS1HOojztgzRI3RtDT1uWaub9ZW
         nwcHMkRkUPjPdQ/XCFYKCwQySZlzmKYtAkzTSimiwx5jashwVs8SiTQUb3ExnNVtu/Bc
         +Yu8dnrclBG+5QuO2nf9FdVLkSEHVBHjSsltk5R8BwoXK/8r5LZvY9i0MI9Iyikc1tns
         bXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bod1FpFujQemY4tdbiDIKeVUbtr7eOMXD4r3xG9Hv5g=;
        b=RkOL3HCgc6CHRDE+Rpc/q+cCGYR5G1NPFU0cbkK8dDU+djBVOsaJdMrVgO/TVCfCMy
         B9PgJagbqcX6fV2Sg7ivSveQkM2An0Js6vmM24UH/XpWSJNzstqQhVrYSSIkp8SySRlY
         fDy1xAmkPeQ9kwZLviDHER4Xdcbngd/oYl4ND5MCp/ouDZSN5MGyKFYHu97LQPjUSKYt
         R9cZP5FRIz30UPgiRKczrOmRV0cEKAL7B1p8vwDd5++3+HSAgDh3Zg5MX7HVvxErAHvy
         E9WTkohJGAxsja2JFw5FZBImdjdHU4IcIo3tQQYDz/n18fXNzxVG+hQ6iV/Ziu9YpphW
         beqw==
X-Gm-Message-State: APjAAAWoo23WU8A6OcmHEQK69j1C5i+4flYpuZ7615/k9QetKlMSnWs3
        fdTZtUd5ntYdhNyJRwTpXkw+D6Qs
X-Google-Smtp-Source: APXvYqwWYhZuMGThFFb9QEizI9YD4c4kBzdy56M7nSGYi/ZiX69gUgk5EJQSZEOJqJV/zgXJw/CRKw==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr20149819wrt.280.1569227602693;
        Mon, 23 Sep 2019 01:33:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm9084503wmi.13.2019.09.23.01.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:33:22 -0700 (PDT)
Date:   Mon, 23 Sep 2019 01:33:22 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 08:33:19 GMT
Message-Id: <pull.347.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] t0028 fix test + more tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 1/2: t0028: fix test for UTF-16-LE-BOM Commit 2/2: t0028: add more
tests Please refer to individual commit messages for more information.

Alexandr Miloslavskiy (2):
  t0028: fix test for UTF-16-LE-BOM
  t0028: add more tests

 t/t0028-working-tree-encoding.sh | 41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-347%2FSyntevoAlex%2F%230189_t0028_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-347/SyntevoAlex/#0189_t0028_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/347
-- 
gitgitgadget
