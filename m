Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB2720193
	for <e@80x24.org>; Mon,  5 Sep 2016 10:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933375AbcIEKY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 06:24:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33099 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932444AbcIEKYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 06:24:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id w207so12568259wmw.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LAC6SAMKSsXSU78sXFB3s3la+7/ODC8TqN/vqYmA5/Y=;
        b=QMsg6XdxWntX39vOvWEbH6KmwBUR51CxK8BE+f2YD0tPGjPu4vWMreVLpXeEdmSB4S
         rZKhcbh9gPZhrk2J3uYLNHRgj5LMORhmEoOJkyDemHbMS6I9SM8uNGQiaik2LXwirWKS
         A92eaC92IHjMPfCFWWsZnGTc/oCJhG1V7yO2btOd3f2m9dWXagN0UFvXKfJrzCd+Z0T8
         iqGrfOYd/PPyuUn/yRuJ+nZ9jflPvrFcdNfRz1QT21KJuKEwr28dcnE/OHqUi47ZD8Ki
         oOFri6bQ7W+SKMGPQcnz+NxRhezDGArWsi6Qsz9L1Hi2wsQJQc3w2w0gY5MTLlToYgfw
         97xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LAC6SAMKSsXSU78sXFB3s3la+7/ODC8TqN/vqYmA5/Y=;
        b=GqUqNRqd0qdnmHStBtNLpwuil1QHGEzLT6fWyhZy1Q0ZrW4Ar3nApB22fzlxmLVSYn
         iW6hhRUwplbATgH6xfA+MBWLCyTsUe0IKETtVXHBjeI8XVBMYNIHE0cpFL72haIa33CV
         vVj3xMgZbi8TDvi5/k2e3yjRNFzWWgSopg6Mr/A/kRQQ+CpDFjnKGFc8NheIzLP/b88O
         ujfi+dast8gvpLIRaD8pU4xam70qiuDLA+TClfvZsCaEgZd9Nq+VUeEf+52f/322hOid
         T2R625URtwxUm87liN17uryjL1xLIpa0ZQaqX+k2SAXSkkGJLi+UaRHo+ZVP4BATrHAv
         kmgg==
X-Gm-Message-State: AE9vXwMZwsLI5JTzOeJfzUUv0lfmTHCC4X8Q+P7kS3EEU3AzGn+hXUPtiQRs969j5X8Vrg==
X-Received: by 10.194.116.38 with SMTP id jt6mr1230475wjb.83.1473071092020;
        Mon, 05 Sep 2016 03:24:52 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id gg10sm27001666wjd.4.2016.09.05.03.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 03:24:51 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 4/4] t5551-http-fetch-smart.sh: use the GIT_TRACE_CURL environment var
Date:   Mon,  5 Sep 2016 10:24:44 +0000
Message-Id: <20160905102444.3586-5-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.308.gf73994d
In-Reply-To: <20160905102444.3586-1-gitter.spiros@gmail.com>
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new GIT_TRACE_CURL environment variable instead
of the deprecated GIT_CURL_VERBOSE.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5551-http-fetch-smart.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 2f375eb..1ec5b27 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -43,12 +43,21 @@ cat >exp <<EOF
 < Content-Type: application/x-git-upload-pack-result
 EOF
 test_expect_success 'clone http repository' '
-	GIT_CURL_VERBOSE=1 git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
+	GIT_TRACE_CURL=true git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
 	sed -e "
 		s/Q\$//
 		/^[*] /d
+		/^== Info:/d
+		/^=> Send header, /d
+		/^=> Send header:$/d
+		/^<= Recv header, /d
+		/^<= Recv header:$/d
+		s/=> Send header: //
+		s/= Recv header://
+		/^<= Recv data/d
+		/^=> Send data/d
 		/^$/d
 		/^< $/d
 
@@ -261,9 +270,9 @@ test_expect_success CMDLINE_LIMIT \
 '
 
 test_expect_success 'large fetch-pack requests can be split across POSTs' '
-	GIT_CURL_VERBOSE=1 git -c http.postbuffer=65536 \
+	GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
 		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
-	grep "^> POST" err >posts &&
+	grep "^=> Send header: POST" err >posts &&
 	test_line_count = 2 posts
 '
 
-- 
2.10.0.308.gf73994d

