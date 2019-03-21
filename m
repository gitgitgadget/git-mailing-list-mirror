Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EED920248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCUUvX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55341 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCUUvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so137978wmf.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fvidnpx2kd9C0l90G3CSPCQ1QjH6VpBCqNX/YhKTwDg=;
        b=eMY5a/6dA4mWgITK4dZnqrs1fttmPFz3ms4HKsQ4Q9AUrpEMKGW3OdLO0HR5u77ml2
         TeLd5xhBm2egRuxnUbz36H3XnDZsv5yUgCx/qbX9KMr8i2cgPVtIhOW06oLzgHw6OOj/
         DVsxADI1uer5XDMTZXO7J5CC2z0W13VtPRCNw5vqOW51vbX/jum8uaywv0Ae3tro425W
         nM7aUuUTVWHnXttRRc3ADm8aZW63FJ9HA6cld457J+GsYOg2+bP1TnQI2SBTz5XbFvV8
         nmEXapcvkcY1OqTok4DyPok/K2kTnmUNt8vHBXty0KmdPFB/fCW99/LapShMLZtIcHu2
         zq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fvidnpx2kd9C0l90G3CSPCQ1QjH6VpBCqNX/YhKTwDg=;
        b=IKJo07hMKtwpAJGWocLod1dohQPMVGYdhlhm8v5qYAxaHfW0QJp2dju3Z3N4GMROit
         UmZMMShPHNiVilD3t5f/oshOzPQcsrJHVP3qBZzYFy++eNmI+wO82FF219cYgVQtuocF
         +U+KFI/spq/wkasypyMwkNDy4tOS80JyUZZmMG+1dJuS+Q3pv/eGY8ZlUFuho5Tef0ww
         iE8mWOI4a2DbjtU08IugHwyW2gMard/8VEenvHrCys7B5pSl50ifN4LJEaOuJVdwdRTg
         lquk2ViXo1NN6b0dB0uzyciFheZ4b8Dvg2EBxr9i/vVXdM8DjqTCBYCRt7yuziOIum09
         hX6A==
X-Gm-Message-State: APjAAAUCfWVzcDvjV+ZgsF5bjOD7NExdAccBW8g1cK+31sTTZv+Dua86
        Q72y3wvHUkQDZCD/gPhNN/N5JdIx+Aw=
X-Google-Smtp-Source: APXvYqzjSDaGsrHW+jocY9gaISp2GWZjFxWBO8wgRmG5fjomJVbFkE3dvPEHzN5bdcqn8kPs1C+uCg==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr754768wmh.128.1553201478678;
        Thu, 21 Mar 2019 13:51:18 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] gc docs: remove incorrect reference to gc.auto=0
Date:   Thu, 21 Mar 2019 21:50:54 +0100
Message-Id: <20190321205054.17109-11-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The chance of a repository being corrupted due to a "gc" has nothing
to do with whether or not that "gc" was invoked via "gc --auto", but
whether there's other concurrent operations happening.

This is already noted earlier in the paragraph, so there's no reason
to suggest this here. The user can infer from the rest of the
documentation that "gc" will run automatically unless gc.auto=0 is
set, and we shouldn't confuse the issue by implying that "gc --auto"
is somehow more prone to produce corruption than a normal "gc".

Well, it is in the sense that a blocking "gc" would stop you from
doing anything else in *that* particular terminal window, but users
are likely to have another window, or to be worried about how
concurrent "gc" on a server might cause corruption.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index dced7cde09..1826d7e3bb 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -141,8 +141,7 @@ mitigate this problem:
 
 However, these features fall short of a complete solution, so users who
 run commands concurrently have to live with some risk of corruption (which
-seems to be low in practice) unless they turn off automatic garbage
-collection with 'git config gc.auto 0'.
+seems to be low in practice).
 
 HOOKS
 -----
-- 
2.21.0.360.g471c308f928

