Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB49D207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbdEFSt4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35414 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdEFStx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so4880710qtb.2
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gqd/Me2GBEVK2M6W9C9uR5X1CmyAGpjMaIyCiZsc+YI=;
        b=Cfdijg9XnETW4AVI4WepnjmPCeFZu0a+6pAua/CMSy9nU9SGdqKDSr3H9AA7kvft7p
         2hBFSoGliLoMkTHD1VFxhw9HtDWl29TPNfGVKq9VQl2Eo1nByqXg4GotjLNsc1qgOpXc
         G/cdrJZnqBhutEeJxVUMqrosUXDAbrzLpdNbq431rEzLMAOm1i/DXy3L4Io15hce2pou
         O6cLFLszYxMYmDcsfP6fLjszLZo0N5aA48AOJDcMfZkyum7m+fJ4jji1MXdb6UtvIlaN
         82cW37XRCatrk8kdN+FliAXzrY/GJpXxVC/sfssY/uVS0k7nzoo/tiynoT+8tLU+utRZ
         BTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gqd/Me2GBEVK2M6W9C9uR5X1CmyAGpjMaIyCiZsc+YI=;
        b=Wux2U9/8UolauDZJ6Mj2sF+CkFzwEXqlXHScZCNGl7PoVwwevUzHvo+oHbK/CZiZMa
         aVrhazStwrAKjtGxIlpnmzNJiRcMn61g87XHozQpncLRY2hwQtCj0cJ3EdCctMWigGi7
         HdlRPCaYmQ4yKmqZHS0Y1JwBmab475ly2/QBH7K8BwjqYSn2si9u5gW8ZMMz9TifLH/7
         NzP0b2Ml7QewK/sPX6cXOR0jiykuIIVs1sRoIulOP4gvvH+146oPaJX8bbwi8/eCNkZl
         YBKCg/JaBxcSUSva6gQvg3p13YGrU2pgKlIaiYHG4AdZdz+C2/SwpK/gyZZfwiBnDJob
         Kdcw==
X-Gm-Message-State: AODbwcAqVscHfuJ/bY71NBIJGFBTmsSHBEaadTw499++ctM4jtTTnJ+s
        gDownDb044Z0RMrGmAQ=
X-Received: by 10.200.37.227 with SMTP id f32mr10303280qtf.221.1494096577344;
        Sat, 06 May 2017 11:49:37 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:36 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 9/9] t7061: expect ignored files in untracked dirs
Date:   Fri,  5 May 2017 05:46:11 -0500
Message-Id: <20170505104611.17845-10-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now expect `status --ignored` to list ignored files even if they are
in an untracked directory.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7061-wtstatus-ignore.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index dc3be92a2..fc6013ba3 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -9,9 +9,10 @@ cat >expected <<\EOF
 ?? actual
 ?? expected
 ?? untracked/
+!! untracked/ignored
 EOF
 
-test_expect_failure 'status untracked directory with --ignored' '
+test_expect_success 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
@@ -20,7 +21,7 @@ test_expect_failure 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'same with gitignore starting with BOM' '
+test_expect_success 'same with gitignore starting with BOM' '
 	printf "\357\273\277ignored\n" >.gitignore &&
 	mkdir -p untracked &&
 	: >untracked/ignored &&
-- 
2.12.2

