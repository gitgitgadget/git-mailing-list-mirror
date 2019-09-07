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
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7DE1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbfIGONW (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391011AbfIGONW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so8553993ljf.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDzSzenR+v+sxzP16dttcT2NQp/HszdbasAxKUqctcY=;
        b=KEctgQsQQxYisA2uD3Ty4LztpVm7QT3s0tR/wJm1V747K7AGUueSDXOtUfWd+bOZxi
         NWC1gsUulhiODb3S6wZpFjelaoIIAevfCE6T35epQL6EN/9vlADYwKBg5B2dfmkYYq5j
         +PK8B3WFsUNM6Pmfevy3pksH6TAug/kPjUbsc/rNwttTQ3eNEckcESjVEgUMkQlE1gVb
         zV6ILO1YZPJD/Y7kwQvNgJtC0uJVe5AJARMd5b3grFSfKvovdnVf/aZ5SS4yKTQAUp6o
         /6QNH/wpxiB976gbnHWieGPG7Tsm7eDxsOk2IK3TahPHA95nq7O3gYrhgDCw3/UgFsjp
         cCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDzSzenR+v+sxzP16dttcT2NQp/HszdbasAxKUqctcY=;
        b=i/GaaMjJyUW27lO9j+feA0W6mRTW9mj2NMRXZXnqmWdSJSWZeTRJ3OrKkPzbUAtYY9
         DdCjtX9xOeC8YkKwdU2KU2o6BdW67j2IdLhy8ET6VilFriFkml1Ct70dPVR/ULXWECNM
         h4yG00Epl40uceZ56Gpr+JF9xcO2StSc1vSHYDnkQP+l28wC0DJ5OFs2d78c8MCvR72g
         +dnjOORqagy1rDCpOm8nNzdyVd0orrMX5FgVJcOkNiAgYD4Pkn8WNdgVtRn7GGYmaSUg
         lzhnQxyCGbBrhAMUal3wy7dqM2uERfS/ayAzcQ7lgdAXnO4U95w4c73d//UgMaNkXset
         tIfQ==
X-Gm-Message-State: APjAAAVuO6qkypiVGpWdE17UuaM6MeFUYqJ+03ITvHXidNXGrsek7NLa
        OrMLuhaII2DVkBA0ZyKclHpGoqyT
X-Google-Smtp-Source: APXvYqyzT7kznNRjVU11ItLqS7T9dkdO89tOmcN5z1F8zLia2az7iAKXOM0vmq5MSb6Tp4ElIAIDVA==
X-Received: by 2002:a05:651c:113c:: with SMTP id e28mr8744891ljo.184.1567865600020;
        Sat, 07 Sep 2019 07:13:20 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 4/7] git-ls-remote.txt: wrap shell listing in "----"
Date:   Sat,  7 Sep 2019 16:12:50 +0200
Message-Id: <93df070965c1222d5e00909ed3930dce299e1541.1567707999.git.martin.agren@gmail.com>
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

The second "column" in the output of `git ls-remote` is typeset
differently by AsciiDoc and Asciidoctor, similar to various examples
touched by the last few commits.

Fix this by marking the example shell session as a code listing by
wrapping it in "----".  Because this gives us some extra indentation, we
can remove the one that we have been carrying explicitly. That is, drop
the first tab of indentation on each line. With AsciiDoc, this results
in identical rendering before and after this commit. Asciidoctor now
renders this the same as AsciiDoc does.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-ls-remote.txt | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 0b057cbb10..a2ea1fd687 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -92,21 +92,23 @@ OPTIONS
 EXAMPLES
 --------
 
-	$ git ls-remote --tags ./.
-	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-	f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
-	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
-	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-	0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
-	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
-	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
-	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
-	$ git remote add korg http://www.kernel.org/pub/scm/git/git.git
-	$ git ls-remote --tags korg v\*
-	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-	f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
-	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
+----
+$ git ls-remote --tags ./.
+d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
+f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
+7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
+c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
+0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
+$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
+5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
+c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
+$ git remote add korg http://www.kernel.org/pub/scm/git/git.git
+$ git ls-remote --tags korg v\*
+d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
+f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
+c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
+7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
+----
 
 SEE ALSO
 --------
-- 
2.23.0

