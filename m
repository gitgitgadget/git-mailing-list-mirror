Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490C12018B
	for <e@80x24.org>; Wed, 29 Jun 2016 14:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbcF2OO4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:14:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:57700 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbcF2OOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:14:55 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mcxtm-1b02ci34Hi-00IErr; Wed, 29 Jun 2016 16:14:50
 +0200
Date:	Wed, 29 Jun 2016 16:14:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] reset --hard: skip blank lines when reporting the commit
 subject
In-Reply-To: <cover.1467209576.git.johannes.schindelin@gmx.de>
Message-ID: <fd3b5aee740e88ceff0fbe77c61a10767c4f8622.1467209576.git.johannes.schindelin@gmx.de>
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+XJ2P7i+sWYn2E1xuzwRG0mRnaiBDaYjepAIPNL2fO6o9KTyLP7
 8PWKtQXUGUZV72tZYqHXrZWg4ZSL9HXvZqYJBMjrscnbO58dGEaXhINlSLR/RXUHwNSfcXL
 MZX2HvGkNjlq5bSLvU28R22HZkFFOEgvvUmamfg11CyiiIkpiqeHS4r389Yvlmu6/0cqkXD
 Op2WdP2AYSRjS8U5b1TGA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9Nt5/f2bWh4=:H0+tjzLX8hseEitwI5yIDk
 pCWMQw9rSHHMPrawKareCOH5brCK2i0nIdpXWuL6AIT1OOrf2QipzSUOKDqrD3AzxEbfMYEFn
 Z2gSaVzJ9ewNDbH9UQVT5H1nkGqIJcLtAlYrO6ezmdxpfWSiK+geDb8d2kzjoL0qugHSAIb86
 PA2m/1hg9XSFNAgpvVCZ8YZwFBnRPGmXx43gd6OPKceBUa63ssyHrdVCgnvoWyu0kHh9Xqzrh
 fhacVzdfMnOwo1NKj5Nr7P5aengLDQ5ev+XBh32l/+Q6PUDY8tHwk7Y3nMt3h6oUEgh2mHwHn
 Ax9tHc16w1o66bcKfavro7DTEJN7ZF6CQaWtsP305O1PMeS58IK8ssjUcGl0iDGc85/K5XY4o
 fNExvn2ReKoKpQwcPCLzsRvGmAOH5Mtz1gZfd2dfPt5tXhpzqbZBhYmDfJr98aVqt3svTIqFQ
 h3KkAGCurQW4kTDi6+bVPj7znXvyhffpJ5ZWaSvOwbgqN1fFbMJ8UMHmM8JKYE0GBstnjqqvV
 8XsDAIyMgq+t2dI+nyW8HskkZ/MAaRMSjLIvRhCdB6DX7uVfbDdYPFZsynSr9WrVZAVQmEXv1
 A2lQJni6khUHv4xtd0FxqShWRvhL0+FdY5Np6ZZ7KhuH4tutKSWOaPPmx9Ih2fwLgliFKb9PI
 ocwcRf2CytdFJNOHea4Fl3yUoRMVtQvOKOfI4ilmbmc0YMVCwm0w3uVH5QxaoRcg0K6MhCqgX
 tT7yLnXv5FsSzkL8lh90wqoCnmWW2kUfmfIoN5OhNbdPDKsZ+j/Rr/naBri1EqXUTnjzXxqwj
 pP7eJU5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When there are blank lines at the beginning of a commit message, the
pretty printing machinery already skips them when showing a commit
subject (or the complete commit message). We shall henceforth do the
same when reporting the commit subject after the user called

	git reset --hard <commit>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index acd6278..5c6206b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -103,7 +103,7 @@ static void print_new_head_line(struct commit *commit)
 	if (body) {
 		const char *eol;
 		size_t len;
-		body += 2;
+		body = skip_blank_lines(body + 2);
 		eol = strchr(body, '\n');
 		len = eol ? eol - body : strlen(body);
 		printf(" %.*s\n", (int) len, body);
-- 
2.9.0.270.g810e421


