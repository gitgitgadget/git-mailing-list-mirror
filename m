Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E8C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKBWtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiKBWsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:48:55 -0400
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CD6598
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:48:53 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id qMXSo68vDLVi2qMXUojVpU; Wed, 02 Nov 2022 22:48:52 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=0vB4FWMyJPtoFGp3d6IA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [RFC/PoC 4/5] Doc Bundles: add t6102 rev-list simple and pulls examples
Date:   Wed,  2 Nov 2022 22:48:42 +0000
Message-Id: <20221102224843.2104-5-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221102224843.2104-1-philipoakley@iee.email>
References: <20221102224843.2104-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJAoomSHHEJArNnDNwgT61RA5NAOxdzeff1ytLl5cTL8EyLlOk/x5WfMU2WWGq2cxPJok4rzyCiVrKcb6AEPzNRAMYXYmgjM90/jsDG42u2V09z3AFFz
 O8aIJCypsTgB+JFx+D9DTcEUWHwXRYEVRxn5fDyTOY3nVQ2L51MAkZhJYallx+owDkpe5C2lYCvlfE7XrjLEsA/i+JRhURHgX1h5gfRMPK3I9XyuWyqvwtfn
 Yuequh3LziH08vc6bzxDO+0nLAi9bYQ9IX86cMAxAKY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The choice of the t6012-rev-list-simplify examples as the initial
examples is somewhat arbitrary, and based on having the example
available in my editor at the time.

The environment variable GIT_BUILD_DIR is expected to contain
the absolute path to that directory. Later commits will set that up
in the test-lib-setup.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 t/t6012-rev-list-simplify.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index de1e87f162..8931102392 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -101,6 +101,10 @@ test_expect_success setup '
 	note L
 '
 
+test_expect_success 'bundle simple repo' '
+	git bundle create ${GIT_BUNDLE_DIR}/t6102-rev-list-simple.bndl --all
+'
+
 FMT='tformat:%P 	%H | %s'
 
 check_outcome () {
@@ -240,6 +244,10 @@ test_expect_success 'setup rebuild repo' '
 	note P
 '
 
+test_expect_success 'bundle pulls repo' '
+	git bundle create ${GIT_BUNDLE_DIR}/t6102-rev-list-pulls.bndl --all
+'
+
 check_result 'X I' -- file
 check_result 'N R X I' --show-pulls -- file
 
-- 
2.38.1.281.g83ef3ded8d

