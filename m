Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812291F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeKYV6A (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:58:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45720 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:58:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4822067pgc.12
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3MwsWKUbzIY+D8BhEfjvkk7U4DTZp8bYNy44sHZGjrU=;
        b=crks1vEMA2Xb7eV3q1bqe030If5OULPWn8BB4VUeTOWniFGwqEFzsT5q5bzpRPMEPr
         c+WiAkVAWvpqeodZYXqqRHolU5PYMjuIP7dxPn1L9KKc8ujciuZlSAC15KBgOF4KS520
         fBzFkTdh9VwMXRWXt8GqBkYqoX3qoCzx9rkgyeNJUbasm40OtWKPpJrFKBbMwgaeXfUZ
         KBO5X9RMdnqiUkln9O0aWVysIlCvDP36VjmNrl+AoCx5LimiElBTYs3OWMOuCz4o4eLw
         YoDxp/3N/eMrcI0SrLn/MkdNf2S6zTqbQxBort482Be9ASPl9yeD3FwRN628uWoNFIi5
         jcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MwsWKUbzIY+D8BhEfjvkk7U4DTZp8bYNy44sHZGjrU=;
        b=d1SFa9Cdzy5zF9xr1ZXibzocwpQtpXML6gkmap+YQWy6IYdGIKw0B9K3IrWFZd5Phg
         aLB03Ixh4ezAPAlaf5XMGMI9Q8WBqawxGqVWoak1MQNqmrWe7gstDBuPv3wO7FsC7pgp
         nE2xBDdHXq3a6a26lHhplAF6jhvkMwsif37LzzO42nXbkBsN1CnoNj8lnntoirEuhoA/
         AFFlXHIsJGuXVxW1KJ9SimQnJR7qt8IWSHDVfW2Rx1Az84SxYMHQle2a23LFuzO33sKd
         J4hSwX02VpAuNcfGwoM3A6Kn51eRTVA6pyFvpAvVNKDqJd5bmKbADtzX9gc9FvSfdPAm
         KcwQ==
X-Gm-Message-State: AA+aEWZ/+f4Wll4ex4BcVdTNmBH6kddFvZ0hbDe5W6qm+bcaerYsbAsE
        t/6/aI04SOc9d5sUjHlhD16KcfQn
X-Google-Smtp-Source: AFSGD/X+J+9DHn6qk+Hz+k5qvZE3DRtMEC+1xXIaUh4lnheh1EfGQMdO299c1suM0Mh8Ca3FrdVtTw==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr20372619pgk.241.1543144030021;
        Sun, 25 Nov 2018 03:07:10 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:09 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 5/7] test-lib: use pkgsrc provided unzip for NetBSD
Date:   Sun, 25 Nov 2018 03:06:48 -0800
Message-Id: <5fe64afa3d7cf9a46a527c47885e8e60dae2445c.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d98b2c5fce ("test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/",
2016-07-21) added an exception to the test suite for FreeBSD because the
tests assume functionality not provided by its base unzip tool.

NetBSD shares that limitation and provides a package that could be used
instead so all tests from t5003 succeed

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6c6c0af7a1..2acb35f277 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1244,6 +1244,7 @@ test_lazy_prereq SANITY '
 '
 
 test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-/usr/local/bin/unzip}
+test $uname_s = NetBSD && GIT_UNZIP=${GIT_UNZIP:-/usr/pkg/bin/unzip}
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v
-- 
2.20.0.rc1

