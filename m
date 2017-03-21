Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0B52095B
	for <e@80x24.org>; Tue, 21 Mar 2017 00:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755054AbdCUA41 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:56:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754140AbdCUA40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:56:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43D217FDD7;
        Mon, 20 Mar 2017 20:56:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=rFb+
        ZtAzyyMbLC7BdPh9xwWA6Jc=; b=cFNcV3YJ3i8V1Rpmqyf3SHFhwtpns8P0kC3e
        q3wI82Jp6ifAms8E4wPe6Ok1UUBpKEjZxcyXBZSDlvy6Jrbpfr01sEZ3HmuBA3+T
        E3wibc/L964KV/kQV5/Mv+r7LubGxLsR+VoC6aSIlJWczQDLa2fk6PSSFuihg54M
        FLF29yQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AB8B7FDD6;
        Mon, 20 Mar 2017 20:56:25 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3E897FDD3;
        Mon, 20 Mar 2017 20:56:23 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 1/5] t1400: rename test descriptions to be unique
Date:   Mon, 20 Mar 2017 20:56:12 -0400
Message-Id: <20170321005616.31324-2-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170321005616.31324-1-kyle@kyleam.com>
References: <20170321005616.31324-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 35113BE8-0DD1-11E7-B3EC-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=rFb+ZtAzyyMbLC7BdPh9xwWA6Jc=;
 b=ZZ3ZJ1LilCjpO6zbOOcHimMCvrPDjFp2y4Pfu7PW8qEtC/dkG7SqP8Odic0g/4AuyQoo/kEBjyvFZkj1NH8Xxad3gj9hdaqJ5SUChVw4ghBWRMv7zh3CDZ1uxvTQgLN9bM6x2E3+izIr9vKsW1CJy4mFhy+iZushUI5Vdk5HuXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few tests share their description with another test.  Extend the
descriptions to indicate how the tests differ.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t1400-update-ref.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 825422341..fde5b98af 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -40,7 +40,7 @@ test_expect_success \
 	"git update-ref $m $A &&
 	 test $A"' = $(cat .git/'"$m"')'
 test_expect_success \
-	"create $m" \
+	"create $m with oldvalue verification" \
 	"git update-ref $m $B $A &&
 	 test $B"' = $(cat .git/'"$m"')'
 test_expect_success "fail to delete $m with stale ref" '
@@ -72,7 +72,7 @@ test_expect_success \
 	"git update-ref HEAD $A &&
 	 test $A"' = $(cat .git/'"$m"')'
 test_expect_success \
-	"create $m (by HEAD)" \
+	"create $m (by HEAD) with oldvalue verification" \
 	"git update-ref HEAD $B $A &&
 	 test $B"' = $(cat .git/'"$m"')'
 test_expect_success "fail to delete $m (by HEAD) with stale ref" '
@@ -307,7 +307,7 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success \
-	"verifying $m's log" \
+	"verifying $m's log (logged by touch)" \
 	"test_cmp expect .git/logs/$m"
 rm -rf .git/$m .git/logs expect
 
@@ -338,7 +338,7 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
 test_expect_success \
-	"verifying $m's log" \
+	"verifying $m's log (logged by config)" \
 	'test_cmp expect .git/logs/$m'
 rm -f .git/$m .git/logs/$m expect
 
-- 
2.12.0

