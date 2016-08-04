Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DDC20193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736AbcHDPEb (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:04:31 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35632 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbcHDPE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:04:29 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so17543993pad.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 08:03:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ajXcf2gTGWF34Qe8vl3nt868FYiOPhUXscBAI19nMs=;
        b=h17FzsJEMVFYaziv45XwxjV6sd2p5qqPOykwM1I53XXVlmwKPuqlmW/tF7pxO48Gpb
         nQK92xe7oL0MFcgC4bKJhu0i8tEWCfYTSv8DPRrWKGmwWeInVUGs7215cAeNXIfA5ueI
         gZnl7nThWe8ZIxc1VT87vkIP/vdLNtoMNGuOrs+Vdsv+RrNTj3tu6ZUoZx6ZTJxIeDxO
         wpNCOcBqDQxpN1GcE4+AQYnSNZoJN4lCgX7pPEcWS+FPa05wz1A49aZAuRKlToZuaA24
         IjN4KL3WnQ0IijfClho5A2aPiuIfpH06HOsgA0enx4jMrsy/xefo8e2NxWvj17S5ohBB
         ijPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ajXcf2gTGWF34Qe8vl3nt868FYiOPhUXscBAI19nMs=;
        b=OCJl6bj358hnlZJkFibW/Wv201BuBIeVHkQZs4eIKahJgBROZBTCsUx0V9dUZ7YoIu
         qRVKg6Ogh0KktwQxCtlpK2pFexlEd5ZmIR6Ir2ZqjUxz7Pf5npagR7lmYsQ5uYhb7Onh
         oQ+C5UKp2tGoaMKzv29l5Gz5O1FGenRrN4+OaMQsvfbRy6cicPZ8DnIrOOFPVHl1tQye
         t4X4PA4f69phsCcwWO8jjFGlz3sGee+pJ2WpIW/N3TIdBHHqrMZWx0Nc+pgv8Zg2+/op
         +ubB0KlI0hDJB8u+3UY57baRHZKBNtwqntz56I9t15WN65hAajsg4AvpGNw6q0g0AHI6
         Uv6Q==
X-Gm-Message-State: AEkooutM5dOoMzATdVcYzSGNDIeerA/4THI8xIilpKgzKRgKmgO9P4gKRZRmKOnabenfKA==
X-Received: by 10.66.142.43 with SMTP id rt11mr122854585pab.80.1470323011499;
        Thu, 04 Aug 2016 08:03:31 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id l191sm21126225pfc.91.2016.08.04.08.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 08:03:30 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com,
	Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH] diff-highlight: Add comment for our assumption about --graph output.
Date:	Thu,  4 Aug 2016 08:02:38 -0700
Message-Id: <20160804150238.26658-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <xmqqk2g0l8a6.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2g0l8a6.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 contrib/diff-highlight/diff-highlight | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ec31356..9364423 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -20,6 +20,9 @@ my @NEW_HIGHLIGHT = (
 my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
+
+# The patch portion of git log -p --graph should only ever have preceding | and
+# not / or \ as merge history only shows up on the commit line.
 my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
 
 my @removed;
-- 
2.9.0

