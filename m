Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2231F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755143AbdKJWoa (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:44:30 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:51441 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755137AbdKJWo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 17:44:29 -0500
Received: by mail-io0-f193.google.com with SMTP id b186so15119710iof.8
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TZRfE1zUKU6PL8wppywHPmjIll3gX1KlLmr/sLHsYU=;
        b=REe7HtbOKYLVU5W/M5PJWePHmauTnsKGC+g8CdMj99zGPRGafuhXbJ0hju03K++MNq
         4DR0rJHeiNYqEqBbI0WBvRD2MePudmrIOvtU8rVozGs2aUyNsORqTIEW7Q7DtJZzYhv0
         LISXs5MZ2dLItf0CuMiAf78ZDo2+4a3nWiuHl5fqpE+Tv009FjV0WEK3+FBS2ZJntnIz
         fDBNj6qyNuyqXJW+a9lIm258lhq0lAdaknJqUv3cYDr306YoLIyV5U/oBSwj9tH4Nl/J
         rg1jMLBPvkeh9ci/EgKZVVHGVAI3jppezFGxnODPhAewQG4lXZYhR3bTazV2grzJQNqi
         Ax8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TZRfE1zUKU6PL8wppywHPmjIll3gX1KlLmr/sLHsYU=;
        b=l1HLL6MgS1BsBA0PHucw7nBsZTLywMZ+6/J+vdcdIHxwN8DAdtQQF3JM5XZ4Dgj1ty
         KxlybWbwrPlXFdBKfNuJbIyzyt5Ja3YTt/M6g4B5BHE7VJCinqMzXqozejaA8ppGKfh0
         M+3CWRd7JY1mupuXdQr/B+l64koUYZ8BMBPQQR7sVEYm+qNevwYs4fP3xsFm5hrKO39x
         LcJuoadvitrc80R39B7tcErOOp+8w5guv8xti7kYrrRIDcA8ECu5q+cuUeA8N0IMHNGT
         Zolqaid9mz3wSKie3i0NjnCbitAzH57phM081pFfaN29e0BqqC/I28Zo8rciclWx6CeH
         lc3g==
X-Gm-Message-State: AJaThX5X5X+t+aQW68sGGK7/fFiHmY2KYv5fH0sA34MxmcNErjGWQV/g
        Atdij45SEv7UfNFrbOHP1ZwoQg==
X-Google-Smtp-Source: AGs4zMYKmBL9JZAK/2BexdxyWVDiSTLGmWRIS5W3hd9GL9D4Sn/yJKj4ZckFY+gdG6bgqQ3+oveoGg==
X-Received: by 10.107.180.199 with SMTP id d190mr2206968iof.114.1510353868658;
        Fri, 10 Nov 2017 14:44:28 -0800 (PST)
Received: from localhost ([2620:0:100e:422:3816:f49a:2bf0:e33c])
        by smtp.gmail.com with ESMTPSA id x137sm1446221itb.37.2017.11.10.14.44.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 14:44:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, philipoakley@iee.org,
        sbeller@google.com
Subject: [PATCH 0/1] describe a blob: with better docs
Date:   Fri, 10 Nov 2017 14:44:24 -0800
Message-Id: <20171110224425.15299-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <xmqqo9obhqo0.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9obhqo0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces the last patch of origin/sb/describe-blob.
Interdiff is below.

I chose to not mention options at all, as currently none are applicable;
Check for options and tell the user by die()ing that we don't know about
the options for blobs.

Thanks,
Stefan

  builtin/describe.c: describe a blob

 Documentation/git-describe.txt | 13 +++++++-
 builtin/describe.c             | 71 ++++++++++++++++++++++++++++++++++++++----
 t/t6120-describe.sh            | 15 +++++++++
 3 files changed, 92 insertions(+), 7 deletions(-)

-- 
2.15.0.128.gcadd42da22
diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
index 79ec0be62a..a25443ca91 100644
--- c/Documentation/git-describe.txt
+++ w/Documentation/git-describe.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
-'git describe' [<options>] <blob>
+'git describe' <blob>
 
 DESCRIPTION
 -----------
diff --git c/builtin/describe.c w/builtin/describe.c
index cf08bef344..acfd853a30 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -501,9 +501,13 @@ static void describe(const char *arg, int last_one)
 
 	if (cmit)
 		describe_commit(&oid, &sb);
-	else if (lookup_blob(&oid))
+	else if (lookup_blob(&oid)) {
+		if (all || tags || longformat || first_parent ||
+		    patterns.nr || exclude_patterns.nr ||
+		    always || dirty || broken)
+			die(_("options not available for describing blobs"));
 		describe_blob(oid, &sb);
-	else
+	} else
 		die(_("%s is neither a commit nor blob"), arg);
 
 	puts(sb.buf);
