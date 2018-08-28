Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F6C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeH1Xbr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:31:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH1Xbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:31:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so2605104wrc.13
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iiFUCZkUSBi74/9gPfS+TN4D6ug8Sinx4dA/dUWmcvs=;
        b=KWr07K91AaAF+qv/Ev++0fUZMmpVxo3BU8WXMspxHdgwoB/9RYRZp71BGM+Qecw46U
         JdGIYGh8EbeAnobpqGwEf493V5G9rP58iHJXfa5OoS8LKxmkkaI3SLndYLc3+UtEr/aM
         p3aMAx5ZQxvX+ODTzV/FLzwviUcqC88r8yPXhGWinUy9MKBcZS3JUPvvD73CBHCpa+BD
         XgYgZtn4E3mNiwFyMb9Lto5A8N3dawsei5AedA88f1vOJz9Zp5oFcmYqoBaOZX1Ebleb
         PEXcfmoXnBfRfYCLO5jOWgn1rmLOHFWpJsPI6xCwAv47PLJbYp5Bp6/cxNIZGGxITqJe
         IIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iiFUCZkUSBi74/9gPfS+TN4D6ug8Sinx4dA/dUWmcvs=;
        b=VIurQUbMm5cl9dhL5RvFyp8xVdUA5R81MAwxiWufX9mjIkm7E3/gJFBYFmKHuMfVIK
         DnK6AJbkW6jgotebkSt5c4gHrx9j4CP08KoDwgpsxTHzgk8ltw8F/TM5/M5Ky4e8/jiC
         fp+U+huiZeP8qM3nq/YwWBQ0s7pxxlADxejXIwFHDii0bK19H5pRedIf5iMzfSrehamV
         dPKvp2jEFNyO22E5yCwKUpz3k22HJui2acFrtwDCRsV7MgnfDDaVnAa/VTDxambXhtu+
         LsMfFdvGdEkrRzOqhKFGFjQ5lKlsXGexlFdEBGGLsM2apkMfBwvzpLJLlPGDczWxxXIf
         vW9A==
X-Gm-Message-State: APzg51CdU65zaEgO7GcZ8sP4uolsDqlz+H9GNC18V4Hr7gBVsa3P5oBS
        yv4VYT8cNbLQuMi/os9UL9xh1Eyf6/8=
X-Google-Smtp-Source: ANB0VdaQp09PPWwStJUVjyhxYFpZqUtgQEWX/KH6pxqSY9ZPdcKpKkFA6KYkZIDZF1L8O3gLJ79LKQ==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr2179093wra.120.1535485117692;
        Tue, 28 Aug 2018 12:38:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 139-v6sm3436938wmp.4.2018.08.28.12.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:38:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ann T Ropea <bedhanger@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] FreeBSD & AIX test portability fixes
Date:   Tue, 28 Aug 2018 19:38:25 +0000
Message-Id: <20180828193827.8648-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the vanilla test suite pass without errors on the FreeBSD
system noted in the commit messages.

On AIX things are still horribly broken, but this fixes one more issue
that also affects that system.

Ævar Arnfjörð Bjarmason (2):
  tests: fix non-portable "${var:-"str"}" construct
  tests: fix non-portable iconv invocation

 t/t0028-working-tree-encoding.sh | 6 +++++-
 t/t4013-diff-various.sh          | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.19.0.rc0.228.g281dcd1b4d0

