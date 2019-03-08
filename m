Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5EFD20248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCHKRw (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36406 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfCHKRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so13807248pgr.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBIj5mKfXxHwKmcmljghJVzH2ZCtQfxyK9TDIuka+/k=;
        b=gBMWei7LmXvWnWyYEO0ktCAGUrynS9JtbD9SlWl9O7m88chbKZV5SSCrWaBO6MaGf6
         XRjZUsHG5D6iLoKXHBejwa/fsPuy3usg7FcQR1PxtSVSuzrDvrO2/G24lE6DlfKDYcom
         +2rzkB+Yb2NsQQ9k4eVjxrrY8t+kUicdWi2MKHuLohHAUHuiiXn0VBeRXruUunpGZL1U
         s3hrMpu3fV8dJnbiZ8+69dpbrpOrU1MiLYHgO5+GudglwIi82MhXvBdYIioi9fzp6WEk
         PmBLWKPTFB7Iy6xc3b1cJOn8IiCzHbzogTtvQThvNfChBASwaygK0ZyrjWL15XXiK678
         5J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBIj5mKfXxHwKmcmljghJVzH2ZCtQfxyK9TDIuka+/k=;
        b=n++3NEgMjc3sRVtJwv7r0MKs+PnaFbUyBcrJwbP1r5HyC7per5PTdDRhHyPsvuONtu
         R/odqoDeTUyp0nBMVhTw2I9dwitEN2x96qs6Lak1Ibg2s1V2GURAjYwOnpDdLUNFwRVc
         VngdK2p/6qlk13prT5vG4zifHqtlKWSnikEOxLJvOZfwnVxeQHcG3V+ubwAQwpTHFB8+
         VrUPTG4I4WrXEvek6hE5hWp/8hLq04v2Tz+a2YLLjZkEut6tfFkItb9F4ePjWvKpRxZx
         8qhESau/MqbjNSWOM93iLwmWVcqdl8xI9hPGONPYIEkgltakDwnkvdIQ7qf1lwu86i/b
         0ugg==
X-Gm-Message-State: APjAAAV1ESIDw9R94v5qr5DL8zs9wgWXBy39UiDFrbnc7nPtZNJs0Y/e
        oAlea0eQZH8KgQhklL3Wzw09hNlX
X-Google-Smtp-Source: APXvYqxqX71YIDSwXsnKHTKyKfVmACCR1b9hEiMT9rN4AUpvC4X0QsesqwoQZxa2r6GW2g1wxFIVtw==
X-Received: by 2002:a17:902:d88c:: with SMTP id b12mr18190957plz.339.1552040271855;
        Fri, 08 Mar 2019 02:17:51 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h64sm11330314pfj.40.2019.03.08.02.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 10/11] completion: support restore
Date:   Fri,  8 Mar 2019 17:16:54 +0700
Message-Id: <20190308101655.9767-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion for restore is straightforward. We could still do better
though by give the list of just tracked files instead of all present
ones. But let's leave it for later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7fcf28d437..0b22e68187 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2483,6 +2483,21 @@ _git_reset ()
 	__git_complete_refs
 }
 
+_git_restore ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--source=*)
+		__git_complete_refs --cur="${cur##--source=}"
+		;;
+	--*)
+		__gitcomp_builtin restore
+		;;
+	esac
+}
+
 __git_revert_inprogress_options="--continue --quit --abort"
 
 _git_revert ()
-- 
2.21.0.rc1.337.gdf7f8d0522

