Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57ED1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 11:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJDSXM (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 14:23:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34419 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 14:23:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so3044395pgs.1
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WZqlFp7MmMK7/G3AsiZmzYkLBeMu5rt5dtj3U2/OLi8=;
        b=eNRRaUowjWCBOZPGhfKnRw4JI6/VmVHbMtPAm+A6o+RJo7RpbR/RV2MqMSkCmHm1dp
         pREqVlDTGqHhe8Oi8iy/yRAHoq9OvXBJOjXIjX8djhHa8iC7rG1np/Nr9zsrd7vPvpT0
         csHVNp2rzhQtlkuI0rxqnA0lf+hGJYHWrbiH1Te7c2G5hWrmqY53oOdWHRjJKoNlYLZe
         pjomCl+iGBUqX2LCYzEfZIWmYyko+qYlszTDQqQhQWG6m2dp9Q5HdciqeC7WNuYj6rm/
         gf53lnMdrPVXZUHMksvp2v9BMFZTrmiR2Qid9oTZn8gVYnQROOEYInzwVgntehB1zIiL
         gZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WZqlFp7MmMK7/G3AsiZmzYkLBeMu5rt5dtj3U2/OLi8=;
        b=Vwtu5x0XZ99VYFyRTR/mNWWtvE/ACHWIcSrsyjuC7jsXet0FWiLXNWxNgcs1t1KhCI
         B74/GNCaU1U+fKYf9IebzSMolVsup1QY2ddDNTWi/GPOgSeZtIW1oUkEsKYGk6ErZmss
         BRbwzUkr8nu+0nFsHLfm8CI3btLlohdGTySJ1CRDMWsAOkGWMeP1XdjvVncFBUbXQBDJ
         /U8klp9g1rwcVDRpXGs3+Y2XZUTUI/1AboDPFxehvMS0HOD7vHOF6flhLe9jr4a4P4QA
         g3jqCjlPNpReqpelja1SzmYllcIihYu5NqQ5GGCLNNcz6NNGfr1ypwEAGqnMxILKOtp7
         B6Lw==
X-Gm-Message-State: ABuFfogpw5mYYBwk8WorL98Xs6Hzf5BAlfSq7VvouWZphQiAT1DNwz3v
        tCR0iRMwRH1bpGHfcgYcwOo=
X-Google-Smtp-Source: ACcGV62JDF5S4DZdOKAY2RaRCJlj2+ggqDC6MTPO8ZRo+kvZdIAoA+QDud+jQg2OI2lf5Eg85TP9zg==
X-Received: by 2002:a62:c60a:: with SMTP id m10-v6mr5501200pfg.15.1538652621601;
        Thu, 04 Oct 2018 04:30:21 -0700 (PDT)
Received: from manohar-ssh ([106.51.121.242])
        by smtp.gmail.com with ESMTPSA id d7-v6sm13458600pfm.23.2018.10.04.04.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 04:30:20 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:30:15 +0000
From:   Ananya Krishna Maram <ananyakittu1997@gmail.com>
To:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
Message-ID: <20181004113015.GA30901@manohar-ssh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the forward slash character should be escaped with backslash. Fix
Unescaped forward slash error in Python regex statements.

Signed-off-by: Ananya Krishna Maram<ananyakittu1997@gmail.com>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index f565f6731..f4ff9b9e5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -123,7 +123,7 @@ PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
+	 "|[-+*\/<>%&^|=!]=|\/\/=?|<<=?|>>=?|\\*\\*=?"),
 	 /* -- */
 PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 /* -- */
-- 
2.17.1

