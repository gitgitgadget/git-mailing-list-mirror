Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD1F2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030230AbcKOXOj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:14:39 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36058 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030207AbcKOXOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:14:37 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so71432704pgc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tIcQWg/IS3o8odanq8z8CIFdcmwlKLb7GkkUZg8uzCw=;
        b=ij2BmVPgaUAP7O7C7y8znDiN45Lpbeuy+Geww8HHQDzTtt+FgGonU4AHgq1dLqF2n+
         YCFlKzwSfEzPS9T6lFAQf/w35P7cybFClGoqcYEBtsBMwAJrHBzmEnnhkwcuOIlQAhWU
         NU9jxnRyGQXgMMsmn21yFAFJwo92PUbKk65urJr6/n8m6Mm9lzEA/5duMEyN9mdc2myc
         0lptwK/GB09fF8PNMniGWjpRsj8LSOpyki5RkyhsF4CGpRyGo8wlALMpGDz4BPhzF2u3
         8KmF/hzLE4zNd9k5cDz2UABmWHl4D86mcIcuT8DMa0BJt3KrcJzEvZQD+ZqpyG0vDqYA
         Livg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIcQWg/IS3o8odanq8z8CIFdcmwlKLb7GkkUZg8uzCw=;
        b=VNtEw1o1RBwpLYWr3dXrcdgJZ2LBMK64YqmMtUfcgbZztkv6HWI/H8HZ1hAldJV7OW
         DSy9IWDFhhnLnpFSQtljLzg57rU3FLlD4H8MrTMGkw/5q8XaRY6R1BciEREZLkTTD4ut
         Cv80ycCy1CByc54hiyrwmDBjU8CqexUSYi4QoPmyVfJ5kG//T/fZy1/a9ExmTNkKwaop
         ct2JsRyQcZ3UK/g8Wf3jtdXT9gndgblJbC3eyhaPvtmH9SEvHfyWr6IMSCNXlKUnG+nf
         oxSHYFPpvEONgZ1ZlmUMf2FsSxhwMOtJCdUip6xNFlDPLT/9Vc9xWQ03zivCz/1dcJUL
         +jVQ==
X-Gm-Message-State: ABUngvcFsCwmiw5mNcKmkvkfABjVX9XDqZVd7TkYh0edKSyEGaZo0Gotg/odhOhEK3MtZG7D
X-Received: by 10.99.204.81 with SMTP id q17mr1152770pgi.168.1479251231884;
        Tue, 15 Nov 2016 15:07:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id g63sm21949596pfd.60.2016.11.15.15.07.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/16] completion: add '--recurse-submodules' to checkout
Date:   Tue, 15 Nov 2016 15:06:50 -0800
Message-Id: <20161115230651.23953-16-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/completion/git-completion.bash | 2 +-
 t/t9902-completion.sh                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf..28acfdb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1068,7 +1068,7 @@ _git_checkout ()
 	--*)
 		__gitcomp "
 			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch
+			--conflict= --orphan --patch --recurse-submodules
 			"
 		;;
 	*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2ba62fb..d2d1102 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -447,6 +447,7 @@ test_expect_success 'double dash "git checkout"' '
 	--conflict=
 	--orphan Z
 	--patch Z
+	--recurse-submodules Z
 	EOF
 '
 
-- 
2.10.1.469.g00a8914

