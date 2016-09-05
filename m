Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE651FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934781AbcIETTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:19:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35766 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbcIETTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:19:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id a6so3685762wmc.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Rvf/iUs0ZOCnEBpwjjF0Z1Fm986vv4gL6NcJMQdZjeY=;
        b=aoyevFmCq40e1KYOUjkhC3tqWtUByuo1AsqWiv+SQKPpYOumc0TlBu0p4Izfg/oT+8
         F6673Uax3tJTNAWms123/VmHlTrSjkfrfLPGTT7Mzqc6U+Wu3n5fJPxb+oXVnuN3zB+3
         zL+VmiHPLGX+9B5CFXK8XnIX18Gs+3rDmPgd6Mnk1hk7PhJBCuOnowfVtcUrVxOPlOlD
         pMkVd58U966MK1SJi2klb7sGnQrvsvqaAhEq88TCwgKlwVbdyL4ad11mO8Z0TcXFxn83
         /tfhHcAjfZbVO2VmSQrQN0nlVS5jLwk4KRJ2VrW+6pGkph3oI0xlEO4oOuplz6Q9XTDz
         kJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rvf/iUs0ZOCnEBpwjjF0Z1Fm986vv4gL6NcJMQdZjeY=;
        b=b33aDYn2eXCVXRZoQwlLJLrKEVVpFj6v8hje3uBoM3XPzhr4OojlRnvoIXka1k+rc6
         8DBIKAcCZk6Oh0p7njJdWdk4mIXRY3o95PwtlzMByp0zvyqxtAVFbhk3cJIw882wvoPF
         ldpxOb7DlkRB6FSQXbv9lh6ICaQBN1zAq365IIDYY9uic75LIvBKrulIPrMmZ7zEeHYp
         EYAmWkMaXYD2Zp1dbtThLWLhaIfrBk6l/c9T770Qzd7rKFmflzxTUKcM+uXi5Nzh6JD1
         t4pbJ4jGbRV8bJ4p3sqAYNG1E8JnTIqiRXjMIpzMZ6BxEHlOquv/um2RcNcHBygGSbyz
         uYiA==
X-Gm-Message-State: AE9vXwP2wJtGtR65pU5B1q7pHmxkvB6nmOuYNUGZaRUI4AZrkoflYQZoMv5gqBkDqHY+DA==
X-Received: by 10.28.131.199 with SMTP id f190mr17315473wmd.30.1473103187253;
        Mon, 05 Sep 2016 12:19:47 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id g184sm22417038wme.15.2016.09.05.12.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 12:19:46 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv1 3/4] t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
Date:   Mon,  5 Sep 2016 19:19:40 +0000
Message-Id: <20160905191940.13152-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.308.gf73994d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new GIT_TRACE_CURL environment variable instead
of the deprecated GIT_CURL_VERBOSE.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Drop leftover debugging junk from previous patch

 t/t5550-http-fetch-dumb.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 3484b6f..dc9b87d 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -263,15 +263,15 @@ check_language () {
 		>expect
 		;;
 	?*)
-		echo "Accept-Language: $1" >expect
+		echo "=> Send header: Accept-Language: $1" >expect
 		;;
 	esac &&
-	GIT_CURL_VERBOSE=1 \
+	GIT_TRACE_CURL=true \
 	LANGUAGE=$2 \
 	git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
 	tr -d '\015' <output |
 	sort -u |
-	sed -ne '/^Accept-Language:/ p' >actual &&
+	sed -ne '/^=> Send header: Accept-Language:/ p' >actual &&
 	test_cmp expect actual
 }
 
@@ -295,8 +295,8 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
 '
 
 test_expect_success 'git client does not send an empty Accept-Language' '
-	GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
-	! grep "^Accept-Language:" stderr
+	GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
+	! grep "^=> Send header: Accept-Language:" stderr
 '
 
 stop_httpd
-- 
2.10.0.308.gf73994d

