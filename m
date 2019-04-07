Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D21520248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDGTwx (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51734 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfDGTww (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so11911218wmf.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/+40r/vimG0IZF0D/JeEn+Au5jX5hAn9P5APcpH1/k=;
        b=a58qBavlRVTZPStvwlhk6L8abwI0xTsplpiSrnddAPuUsrMuDdK7wP/FeSaOQLTJVr
         nflK9YzSIEqatmj31otXN44jms1FDVGWP6zlUyY9cMq9hCoJwx1IcF6OTbrM17/dKAVP
         ZmZGTTpLZvrhmXx/w9jEX2+0QECto73DKOoVurdomJzScDp9j8hSYFZ40pHl3kjUyVLp
         sxyY4zsaDZ7ZvkZm6geHxxdFuWbwi15xF9kuTuazJchNNVMriogbS/DItITl6wRvC/M1
         di52GPAr62w53fs/8TuuKFH5e+xiXTa68x385VmKaupJVnIfnpQuTZru/IyHKvaYFj7q
         x0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/+40r/vimG0IZF0D/JeEn+Au5jX5hAn9P5APcpH1/k=;
        b=YCX9HaZxZF9jXlncV0Fr2nBqsoPFIBb8MWAwYeRzREyr10Werw4dXZfM3N6Llf7VGg
         SvHL9LmjXqSqJwwP1bCfwILt8AHcYbnWsjrjDjojznPYZXm5l0zGJXh9l6vn7VePjty2
         etV2G+VK01JXwU1Yp03L07JVY9n8KcOnR+GA0BHZ47EEYQRew+iIxMEV+xPnMKwQyGwk
         zhDN3/6Uh2o1EadV+nNWG/oJ7yqAa67yeZWrayL/bFAj132n5jcR387QcX/pzAQktIxT
         Z3o2GSdDjTj9HleRnE+4AmSkiWV74pG81WKZVS1p38fMaubm1X697In/ktGIxO/8DcDQ
         ANTA==
X-Gm-Message-State: APjAAAVi8qN78/xQT52sdarGCrnYYP8jzKj9dffjUqnmTamMw0FrV7Z6
        hm72VqUjDeH6v/hC22N72EEVIO/LR5k=
X-Google-Smtp-Source: APXvYqxWMyroSQvy043BS34LtbmWCUz16v+j6DkneIA6/AglP72AhtkQ6DAclKktHgUqgiofEBZ8Kg==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr16232951wmi.57.1554666770160;
        Sun, 07 Apr 2019 12:52:50 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:49 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/11] gc docs: remove incorrect reference to gc.auto=0
Date:   Sun,  7 Apr 2019 21:52:17 +0200
Message-Id: <20190407195217.3607-12-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
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
index 9cdae588fb..247f765604 100644
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
2.21.0.392.gf8f6787159e

