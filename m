Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D233B1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfIGONY (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:24 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41885 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404414AbfIGONY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:24 -0400
Received: by mail-lj1-f174.google.com with SMTP id a4so8594305ljk.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6GtHSFK5hov5882hvjwINPS7bsxG62UioRggNF2SLI=;
        b=m9R8bdvZL0/Wl9bSiYVXGK6aEwOxrlPxzJyJ87RLHjidizvhuTGVzdR30t2YnKwZlp
         rR5BgnWqqt7f/O7eesZXkjF34yDID+2W7ANClQP9zeCddBedbq28CLSvkp4M7WMtxAdE
         TY6ud2l2olAtCfLZPYKm3CVwMs0BHuU7aRJI+biGYwZ2dbgJZbHkr7IFro97nuVK9oYT
         gCiGeCYXH58lPuevpckOk4JedPpbg/BO9jt8yPJ1vt4qfHz5/Yh12TPCvjW++F/vtcAk
         mP7x4p2rf1RkKTZ4o67Xp+Ua60WiAPEenbtUSmtOvkcVxizb20ZZkuY1xtpYYrcohva6
         nuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6GtHSFK5hov5882hvjwINPS7bsxG62UioRggNF2SLI=;
        b=nS1JQBaMPU6A4O6xsV3jlqDoclBYXzNxHdrTRpYufAOg1CLAjVbDyqllXu5IQTdZXA
         eggX2DhDXWvvg36ciFar+P9jHL6KwzjAgrvPshcitzbEJyXcpNxd+DlenNhmxucgUNyy
         cdIzpsXRGwe+KdQ3mEoAg5sVtUBV9z8jkP8OS1aw1NIIUncb/y2dPvHwkLkOK+NDT7il
         0Qi+uPTRIEh6uXeWxZ/OL919WBswOsId0Xe/9bDVA+TnBxtMVu2JTaUfEI7wxJRdXkI7
         rF9I9zoUoCr2uow5U8znl4ufshA2vG4jMmTacO5IKN3yi9QUpCZqNPRXPNaER6V3wWXJ
         cZBQ==
X-Gm-Message-State: APjAAAWYk+uepwsirM51gt5sCc4nNsAhhxmYohr8l98/Xb/w7/axKdNl
        i777CnUMNohGVFmYYRjj/xo3M40c
X-Google-Smtp-Source: APXvYqxVCrOzSsWAPC5CiuhjVfROYIQvCWysOvHydmmo5MIXjce7h5OUWo/2BiQ6CCTLwbV3doU29A==
X-Received: by 2002:a05:651c:1135:: with SMTP id e21mr9264452ljo.83.1567865601922;
        Sat, 07 Sep 2019 07:13:21 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 5/7] git-receive-pack.txt: wrap shell [script] listing in "----"
Date:   Sat,  7 Sep 2019 16:12:51 +0200
Message-Id: <6632bbac8c1cf943a439b69252d948f1ecf1de5f.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The indented lines in the example shell script listing are indented
differently by AsciiDoc and Asciidoctor.

Fix this by marking the example shell script as a code listing by
wrapping it in "----".  Because this gives us some extra indentation, we
can remove the one that we have been carrying explicitly. That is, drop
the first tab of indentation on each line. For consistency, make the
same change to the short example shell session further down.

With AsciiDoc, this results in identical rendering before and after this
commit. Asciidoctor now renders this the same as AsciiDoc does.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-receive-pack.txt | 52 ++++++++++++++++--------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index dedf97efbb..25702ed730 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -165,29 +165,31 @@ ref listing the commits pushed to the repository, and logs the push
 certificates of signed pushes with good signatures to a logger
 service:
 
-	#!/bin/sh
-	# mail out commit update information.
-	while read oval nval ref
-	do
-		if expr "$oval" : '0*$' >/dev/null
-		then
-			echo "Created a new ref, with the following commits:"
-			git rev-list --pretty "$nval"
-		else
-			echo "New commits:"
-			git rev-list --pretty "$nval" "^$oval"
-		fi |
-		mail -s "Changes to ref $ref" commit-list@mydomain
-	done
-	# log signed push certificate, if any
-	if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
+----
+#!/bin/sh
+# mail out commit update information.
+while read oval nval ref
+do
+	if expr "$oval" : '0*$' >/dev/null
 	then
-		(
-			echo expected nonce is ${GIT_PUSH_NONCE}
-			git cat-file blob ${GIT_PUSH_CERT}
-		) | mail -s "push certificate from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
-	fi
-	exit 0
+		echo "Created a new ref, with the following commits:"
+		git rev-list --pretty "$nval"
+	else
+		echo "New commits:"
+		git rev-list --pretty "$nval" "^$oval"
+	fi |
+	mail -s "Changes to ref $ref" commit-list@mydomain
+done
+# log signed push certificate, if any
+if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
+then
+	(
+		echo expected nonce is ${GIT_PUSH_NONCE}
+		git cat-file blob ${GIT_PUSH_CERT}
+	) | mail -s "push certificate from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
+fi
+exit 0
+----
 
 The exit code from this hook invocation is ignored, however a
 non-zero exit code will generate an error message.
@@ -212,8 +214,10 @@ anyway.
 This hook can be used, for example, to run `git update-server-info`
 if the repository is packed and is served via a dumb transport.
 
-	#!/bin/sh
-	exec git update-server-info
+----
+#!/bin/sh
+exec git update-server-info
+----
 
 
 QUARANTINE ENVIRONMENT
-- 
2.23.0

