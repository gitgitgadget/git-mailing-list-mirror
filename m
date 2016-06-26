Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745B61F744
	for <e@80x24.org>; Sun, 26 Jun 2016 05:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbcFZF6Y (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 01:58:24 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35898 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcFZF6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 01:58:24 -0400
Received: by mail-lf0-f54.google.com with SMTP id q132so138086809lfe.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 22:58:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2Fw1nGlutmcxnnQ4Wyt7SCd5eHPkiFh96SI5m6be/c=;
        b=F4YFQyVbMcP+l3re4l3DS+E6r4LCyifMsB8f72/44QdrcoQTzHUD/X0uSXniLYvsfO
         GonjkfteL4mZqxL/qih0MvDdoArm4vlncOValuVhN1hdn2lw3Lu921vb1zeQWPG4wyYt
         rSKl5x4P/v17OmGgLveQjr3+eXO28cPVwYpebJFnitI/Ea3uMT+5D408QBippPww+/Ui
         gPYMCj3I1nrsxQdoFyzs1HWIQ9tSJdNTT7KEh5iL0SIkQQ549wPYm60TYCtvqiQNmS/6
         3mDsl/0AjUTNV+w2BJIJd0KW2OYUvqZo2FpJlol08K7hmc6LBmV2/fBVhxQQKTBJHgYd
         gPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2Fw1nGlutmcxnnQ4Wyt7SCd5eHPkiFh96SI5m6be/c=;
        b=SNAxn5vbZtLkC2gP2eNTAGja4dLrXdSh5eqwnuQ/z3Pzbs1IpYARMJGzJCSM8gbeS+
         +k2oRUHygNsutcsm7IXiQzAB//i99oEwsZK8QgS7PlDkocoT7VeTF81Hhs8iO438n8cl
         qWkMEPgs5DX3Xv4pv1/KwdSiy0M3FR/MtMBKJejyamZ/d+oOI9uUB6ow2fUxRuHaIe3X
         hoJdfLagQC5hlDiESJQFDJGGA8F9H+7At2fAyMGKTun3VthPqG86UWJITQUbv9EOb2KX
         X80Nunc/A0ohtYOLRzLENdagjBHz2S0XOngnQU0AZ95r4Kqcpt6wGyAb7BrWcgL6FxNw
         U+8w==
X-Gm-Message-State: ALyK8tKosLQ0xj5jU9+Mn5OdnbvCZ2SGVZRVgFZlpx5Pzz28u1ZWHi355ZR0yExE3uedJw==
X-Received: by 10.25.138.65 with SMTP id m62mr4000950lfd.16.1466920702633;
        Sat, 25 Jun 2016 22:58:22 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g24sm2123775ljg.20.2016.06.25.22.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 22:58:21 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/5] Better ref summary alignment in "git fetch"
Date:	Sun, 26 Jun 2016 07:58:05 +0200
Message-Id: <20160626055810.26960-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v4 is a cleaned up version of v3. Tests are added. Typos in
git-fetch.txt are corrected. The "{ -> origin/}master" format is
dropped.

Nguyễn Thái Ngọc Duy (5):
  git-fetch.txt: document fetch output
  fetch: refactor ref update status formatting code
  fetch: change flag code for displaying tag update and deleted ref
  fetch: align all "remote -> local" output
  fetch: reduce duplicate in ref update status lines with placeholder

 Documentation/config.txt    |   5 ++
 Documentation/git-fetch.txt |  51 ++++++++++++
 builtin/fetch.c             | 194 +++++++++++++++++++++++++++++++++++---------
 t/t5510-fetch.sh            |  30 +++++++
 4 files changed, 240 insertions(+), 40 deletions(-)
-- 
2.8.2.526.g02eed6d

