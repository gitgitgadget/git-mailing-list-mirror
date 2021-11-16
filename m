Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD2C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 02:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C7261B48
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 02:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbhKPCSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 21:18:04 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:43210 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346154AbhKPCP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 21:15:56 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AADCB5B462;
        Tue, 16 Nov 2021 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637028775;
        bh=OINAtM0etsz/43EKlvpy+RxKWGHPr+gF8obSbpDlVxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ARx7sstYnGLqc48EsaxX2JCG5riF94c6/Dd8TyQFSfHzHiRcAnqLixTr7/NplXlYl
         2JCCCCIytD8V5xG2nCsmdfVWfDJNHULBgntHTqYMZyP3dDPZAUIftxDRLg/nIGEjGC
         LPpn9UwLgxPbHSueDSdZ4rA7f/0eDDHDUrQvAq5MpKzh8AE/nDBpysfabKw6aO6XaD
         00o06xj2KF2P7GJkuNsGFgSBUgJOq0v2vl5gTxDBjf++lYsdWcYiNK3qOLB+6XsHQL
         YJlThJS1R/8Sqj+HHOo2yOyQiFtGIbW9Au0CIEEAD/1lTMKuNLcWtDWEzjxAb62bdD
         RcrXWs89cQBWU/UoUn6lyV4/d0RtSXA65bcqYrDCZe/aVdxR7JiX5tpAllFG/YFNu1
         NDJkIMp7VfgjMZ1Mqm3pH4vYUl46gr0bJZUtpg+BYDr52le74GMa7e0SvfLHrknICP
         gj5aDAJfEopCkA6RwDvJXanS5e84j0yyDh+30YVqMk71+PAFx3u
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/1] Add a test balloon for C99 support
Date:   Tue, 16 Nov 2021 02:12:40 +0000
Message-Id: <20211116021241.1565740-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There seems to be a decent amount of interest in moving to C99 as our
base level of C support due to the many features it provides.  Let's add
a test balloon to make sure we haven't accidentally excluded any
systems.

Changes from v1:
* Don't modify SPARSE_FLAGS since it's unnecessary.
* Improve commit message to explain why we use -std=gnu99.

brian m. carlson (1):
  git-compat-util: add a test balloon for C99 support

 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

