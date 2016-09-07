Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954B32070F
	for <e@80x24.org>; Wed,  7 Sep 2016 11:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757380AbcIGLVL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:21:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34742 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757366AbcIGLVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:21:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id g202so833232pfb.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfLf/d6Y2SyeyNS7QBNwzBelOTg6S5TbCzcTdyzSCmY=;
        b=JOuyvOm2Hx595mo3rq4WxekavZVYkds2uYgjoqQcuN0rCuwXMjjRrGXoBl/QpMDG45
         UQFLZN7yXbDfbAD2qwYLqhT0oGIz60Q0Dur32ChLC3YcQYIJtQiI0AaMEkP7OrS9Hc7i
         grIfYZ5/JEw5Pph28ugsT5wWZsrz68Tl1e4kQ3Rt1l3xkOcYzY5rxqlApmptJ6C7FrGG
         PFwTzGRndLu+gMQUOX8TcWg7EVWoT5qei/SApNXkWDsjQadb6NBpoIxwp+7D+rZudRnf
         6mE6R7BtM5UuX8u2dWlTw+Kp2g0EIE+z/Y+d5TuE9ujmz7XIlvTUeiDa8EL6Yh3A77wE
         zxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfLf/d6Y2SyeyNS7QBNwzBelOTg6S5TbCzcTdyzSCmY=;
        b=ggPMj8m5Xnzt64vP+zY9y8KTwXlGpI7foDBT66F6y31gduaE9YV0NxE1XnQK13c5hf
         wtQvFDTa1jVteKhAF6xHo7km/i+ePBfGd/xN9QGUSBgJEL62GL31n6nxkwELhkphmoqU
         Sw9eNi3VUUtuka2PF6F3j3tuYdpwK7gKmvWzCU2pCRmDAdYG+m6Yqy/tvk6m+DdPyPB/
         c2/BtgRrJ53a9QjLOc7xCkLH9eAIvcm+eByvqtov60/j/bwBYjYxUd0nOgTpwLHS2aYe
         2g8yWPArmIe2QZkJrkPoibNy1WCrQMsGaNubzunHBlW39wlGUu+KgZizpnDNWwH2As9m
         gihA==
X-Gm-Message-State: AE9vXwMxgW+Aeuxau3SblYZRwP3QmD+PJ+q+3vW4NfLkAvpgZqc5gRz36bFtCAese9UyGQ==
X-Received: by 10.98.27.11 with SMTP id b11mr81105582pfb.111.1473247253758;
        Wed, 07 Sep 2016 04:20:53 -0700 (PDT)
Received: from ash ([115.76.139.213])
        by smtp.gmail.com with ESMTPSA id e187sm39781161pfa.58.2016.09.07.04.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 04:20:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:20:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] checkout.txt: document a common case that ignores ambiguation rules
Date:   Wed,  7 Sep 2016 18:19:40 +0700
Message-Id: <20160907111941.2342-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160907111941.2342-1-pclouds@gmail.com>
References: <20160822123502.3521-1-pclouds@gmail.com>
 <20160907111941.2342-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally we err on the safe side: if something can be seen as both an
SHA1 and a pathspec, we stop and scream. In checkout, there is one
exception added in 859fdab (git-checkout: improve error messages, detect
ambiguities. - 2008-07-23), to allow the common case "git checkout
branch". Let's document this exception.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 7a2201b..94eb238 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -419,6 +419,15 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
 
+ARGUMENT AMBIGUATION
+--------------------
+
+When there is only one argument given and it is not `--` (e.g. "git
+checkout abc"), "abc" could be seen as either a `<tree-ish>` or a
+`<pathspec>`, but Git will assume the argument is a `<tree-ish>`, which is
+a common case for switching branches. Use `git checkout -- <pathspec>`
+form if you mean it to be a pathspec.
+
 EXAMPLES
 --------
 
-- 
2.8.2.524.g6ff3d78

