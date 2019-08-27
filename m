Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0961F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH0EFK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41553 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:09 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so42989345ioj.8
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7cvA63Mls7f/glzSnNwJN2P5f8JSKcVpFamqhfO42o=;
        b=ZfmWyP9OklezlXFwLz6fRwBDL/IQHa2ArWnRwcLmU3erIojVvlxdQHtnseLKjJMloc
         NKTq0wd9l6O9F4u4hBEg6mTaq0IVsjOK4SE6pEtpV0MCMNOh6RRd1X6l5If2ZWOlVMj9
         fHoygyEW5tl1TlfokoYQtV9QN3T3cE6MPknuW/tMXPJ5zac9yaFGS6u8VbI3CIHeqGp3
         RzjyXfpxfXVcWr7JPCsIYlmh1cyjLafdeUSdnSvhVsJ9xF5iMKt10++iPIKQ7ctLNl0b
         mbsg0Wb4mSEGK4ew2XdUkMPzhRFzuEM7zTG3ObBJGWoLOTKlWAFHIBGOFQ9lm/7amYv4
         Qvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7cvA63Mls7f/glzSnNwJN2P5f8JSKcVpFamqhfO42o=;
        b=AxgsDxkNC8YGznAPskNmXgy0CiPMl2An1eoHDPdeWRwGFA1zxxaEfnV7L0H0LC+OZF
         foEyLfXYSg2OODb6cyK9cv/4haFGFlWqEVzvTavmss1AWuNNXzY5IPzg9jJYxwnKE3JR
         PWoXQ04Hp/SvWG4+Hd+wTtumbAGR9AHgoKaC05IZvWQKqniYQZhNePzdL4zDLvhqVbK7
         eMOW+WcOPw5pzG1GhFW0M/WTJnmMuo1iWMAOraCbPw9KIltMmFr9GVYBwEyGYZwKcF8/
         PS6cdpU/OPqGAAFUoFXWE0f+GP76QB00iZmFqhx5Gl99/AKJr0GnCEPlMV/X3LOaQT89
         IE5A==
X-Gm-Message-State: APjAAAUQuX+xMdPdYEvn+WIhKHl1Ny433hkVMwEfBsHc86IMiVvE/XUp
        rCK9485rxX/IuXcLZCZMfEP3KwsP
X-Google-Smtp-Source: APXvYqwE3Z+m/WKRNtbG57OYLryNvV8QqKQDcquVs4ICwJeDgAugHE30y9GUS12EPjDZxNv+MOKVvw==
X-Received: by 2002:a6b:bcc4:: with SMTP id m187mr1834069iof.16.1566878707731;
        Mon, 26 Aug 2019 21:05:07 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id e19sm11576569ioe.78.2019.08.26.21.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:07 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:05 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 07/13] t4014: drop redirections to /dev/null
Message-ID: <804b3163f866cce0b8a928256b5009fc42dbc709.1566878373.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c07d868491..2048fb2008 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1502,42 +1502,42 @@ test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (2)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master.. >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (5)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 HEAD >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (6)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter with nothing' '
-- 
2.23.0.248.g3a9dd8fb08

