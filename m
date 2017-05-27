Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699E620D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFAVl7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:41:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34689 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAVl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:41:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id f14so3234408lfe.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rhk8YpmC1ymY7iz+rJrS+ET96KZNVBf315kdNGl0dj0=;
        b=WhKNu6u/OLgTuVS/HKaeqKXE2911ZyTfK28W0V+9oEgMJnG6CcPsGFlw3SuCHCA/SY
         SoYYX9l/LdKbSfLctJQRzOGFlY9RVdCtNJHSzusDu+0XvItBtcRaODRnmENhmM5ZNs7V
         GcOHhzjRNHePcIfsZC2v6b4syvIfiQVgf2q/Siy/APeu1QYZMPclYvwWkDt3KxpUVjMl
         9rIW4HQUpSCr2+9M/z9jZti62Byewqj/3qt53iDVrDKHw1gHL7HwHiUAliIc9DI3uurr
         oqgFY4v3SIqfr+oUi+n0BH7ytVBBOrPS/jRS1YH8QdG9UsAqRVKav1EqQrfj5NtjLPaO
         H3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rhk8YpmC1ymY7iz+rJrS+ET96KZNVBf315kdNGl0dj0=;
        b=qLTdr9DnN8z6EdPeqX5jlJbwTSeLohx0GXvG0YoHZnZ8nxV+XFBDmqkkVKfSFFzjM6
         bUHri3ui8OcsafzDA03Y3ilL63+Ia0cTiAVMoljWlbTYmpVVntsHNukyrOZgWx4IPaBW
         WTtdSzFsl2bN0clP1NaFcTfjnbtgBMcZbzLwZRsK4yt/TCEB4r8rDBKvFmBrl/IYwChz
         CwBjfGoa7QZC31Nfr48Uavvdl8TeG3TUzU0K+Wh8Om0Ahuxp/WKS4Ozi9NxLT9qXPc6O
         MDuDGiYQRNtJBRv5giVKHgFB84Vge6kPREFyn1NWURqr0CzDEoQFsdSLJnxr2EeWgWpR
         dFKw==
X-Gm-Message-State: AODbwcDy6HlrKbx7GWC0e3oJRGiTZ/ZO5ybZ7IKpkluZIpHxHS0+GTdE
        XrjyC0NM6NUX1BV5IE8=
X-Received: by 10.46.88.17 with SMTP id m17mr1171228ljb.26.1496353309927;
        Thu, 01 Jun 2017 14:41:49 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:48 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/6] completion: Add git config advice completions
Date:   Sat, 27 May 2017 08:25:50 +0200
Message-Id: <20170527062552.13996-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing completions for git config advice:

* advice.amWorkDir
* advice.pushAlreadyExists
* advice.pushFetchFirst
* advice.pushNeedsForce
* advice.pushNonFFCurrent
* advice.pushNonFFMatching
* advice.pushUpdateRejected
* advice.rmHints
* advice.statusUoption

Remove completion for git config advice.pushNonFastForward,
since it was renamed to pushUpdateRejected in 1184564eac8e.
The config still works, but is no longer part of the documentation.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3a630a230..7efcb2a79 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2336,12 +2336,20 @@ _git_config ()
 	esac
 	__gitcomp "
 		add.ignoreErrors
+		advice.amWorkDir
 		advice.commitBeforeMerge
 		advice.detachedHead
 		advice.implicitIdentity
-		advice.pushNonFastForward
+		advice.pushAlreadyExists
+		advice.pushFetchFirst
+		advice.pushNeedsForce
+		advice.pushNonFFCurrent
+		advice.pushNonFFMatching
+		advice.pushUpdateRejected
 		advice.resolveConflict
+		advice.rmHints
 		advice.statusHints
+		advice.statusUoption
 		alias.
 		am.keepcr
 		am.threeWay
-- 
2.13.0

