Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13761FF6D
	for <e@80x24.org>; Sun, 27 Nov 2016 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbcK0QW4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 11:22:56 -0500
Received: from mout.web.de ([212.227.17.12]:50683 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbcK0QWz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 11:22:55 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MduIT-1cMwR813M5-00Pdsp; Sun, 27
 Nov 2016 17:22:47 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] New way to normalize the line endings
Date:   Sun, 27 Nov 2016 17:22:45 +0100
Message-Id: <20161127162245.11757-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <5502e894-bb22-e8b9-ab7a-49346d238283@web.de>
References: <5502e894-bb22-e8b9-ab7a-49346d238283@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:M0EfiDCsBX/HjGBEiUfF81dQ69Z3iy7BEZZTW4IXb3JNQ1M3EVZ
 firsb6H3756ySZlmNcaGXrAe7Pl4Hutfg1/QgFbk52wXY7WTqBLWgxxPJN1ozMYkfgI29El
 wSiKcdfCgc55c4x9v0MFB2EuZ/tBlzjAv6H1yqU2i3CQutvCacPAWGVRPMDkh8+dpydOomC
 EFP3f5dbKO78qAzpTCIHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vTMM0hc7FfI=:QOXs7Acl7vZ2E//urXDaB8
 ylqOYlLXiSWcV6sC3NqRabhpWWe2sx8r7mHZutJrOViVQpayDrh2fZldh+tvh+AmH1JfX2jnh
 Xo3P4gbez6mxFx4V6/hrJ2fs+7IFy4bUwJ6BI70Gm0oa/kZqwANvor61tWRjh5Cajqu4ZfGwm
 Ca6g4xisSD7tGboFjANYW+gW1Wkq/IgGB8hC4FpypyzLdEAM2hNxsUZjXEFVccBaG917iICyD
 uEW+LsB1EKI1SktiSg31EDfgurhgpCJFWnM0QJO7Ne3VJGcIQrjBVDY+S4PpIGHf/H1wY3Sl/
 Qp1UR9rYRs3cF6RLCvQ/W4RLu4Bq8/MHKWfOKnGBy8Zy14cIS0a+LpuAIBl7yyjdFcc0JRG1f
 8kNcSbZ2fnjfXnr3Iho6cML8tvmtv7GK/C49PnO8KsJznYIta2jUr/OZjEaMdOBTjogxjmFn3
 0EvMxQpPcXfYU6Xhf85/3Fa9wfbCpwUf6FhgpjuDh3+LVkcysLt3krZ47LRvom6dlQiT4vGUq
 fZZC0qzes2iSajeqGwfgoj+EiA5R1RVNeom90nAyRnh94zn/9+u9d0xmCROYYJCfTGayLqVd8
 sfGQqgbL1ZqmifFCCzvd87N2C6MmcsABJqmN8TLoYfp5wFNFWrlLeVHaju3ZCtTpsvO+36joE
 mLrxAJQoQ5fSgMnd8erbxsUcy3PlkuuSu1yzGWIuuzg9Vu997NTPx8lyh72Uv8nRdToMXvtxa
 iNZk5TEnhwF7Qqb2oZVPhCHszDfNvF3YqxUkNXZNZFNlDSgxSS37MoIZXlTjM3mCvBGFDzPyA
 mbanVJ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Sincec commit 6523728499e7 'convert: unify the "auto" handling of CRLF'
the normalization instruction in Documentation/gitattributes.txt
doesn't work any more.

Update the documentation and add a test case.

Reported by Kristian Adrup
https://github.com/git-for-windows/git/issues/954

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt |  7 +++----
 t/t0025-crlf-auto.sh            | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 976243a..1f7529a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -227,11 +227,10 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ rm .git/index     # Remove the index to force Git to
-$ git reset         # re-scan the working directory
+$ git ls-files --eol | egrep "i/(crlf|mixed)" # find not normalized files
+$ rm .git/index     # Remove the index to re-scan the working directory
+$ git add .
 $ git status        # Show files that will be normalized
-$ git add -u
-$ git add .gitattributes
 $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
 
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index d0bee08..4ad4d02 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -152,4 +152,33 @@ test_expect_success 'eol=crlf _does_ normalize binary files' '
 	test -z "$LFwithNULdiff"
 '
 
+test_expect_success 'prepare unnormalized' '
+
+	> .gitattributes &&
+	git config core.autocrlf false &&
+	printf "LINEONE\nLINETWO\r\n"     >mixed &&
+	git add mixed .gitattributes &&
+	git commit -m "Add mixed" &&
+	git ls-files --eol | egrep "i/crlf" &&
+	git ls-files --eol | egrep "i/mixed"
+
+'
+
+test_expect_success 'normalize unnormalized' '
+	echo "* text=auto" >.gitattributes &&
+	rm .git/index &&
+	git add . &&
+	git commit -m "Introduce end-of-line normalization" &&
+	git ls-files --eol | tr "\\t" " " | sort >act &&
+cat >exp <<EOF &&
+i/-text w/-text attr/text=auto         LFwithNUL
+i/lf    w/crlf  attr/text=auto         CRLFonly
+i/lf    w/crlf  attr/text=auto         LFonly
+i/lf    w/lf    attr/text=auto         .gitattributes
+i/lf    w/mixed attr/text=auto         mixed
+EOF
+	test_cmp exp act
+
+'
+
 test_done
-- 
2.10.0

