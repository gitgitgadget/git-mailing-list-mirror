Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4C320958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbdCWNGO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36787 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbdCWNGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id l37so31028561wrc.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovNHPNDIpXqVOzkBZH7SQ16oRbH/Dt/uvKWqUpfssfE=;
        b=VHQvvnCOChF+mflfte1klTYtrlA2nGNGV0st9bpOZbZLrZaBweh0saAH8qrfgXnKQW
         qQuYoL9Q6lOG5bkWYb04EmmpJld/3ec7GAbH5Qf7XwWfGtTVszIrdHIZfbYDxldzp+VU
         1S3iSJ4dB1G+FXpZ7Ah9OG+fbH6Yalnxzc7VvkCfA+uI3+SQC4pOIl+mKNRtfTNgIUSl
         0BNui9lLgT0pBi1/Zs2BJNctwOgTudLkqlqSSBecVlPvoIQSsfAU2qozEDb8NhJlJmHk
         3IXbz/zmgnwOVmkojfj9FndMve8/L+bTjq8cgJXCaC+svj7yPthEnYB+oXm4xBpgYoVF
         JaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovNHPNDIpXqVOzkBZH7SQ16oRbH/Dt/uvKWqUpfssfE=;
        b=F7G9UTLhwjdV2iOid5cdBUKB72lX4ca0pgjzkOgyJfttYA+u0WWe/dRbjGIFvXRBqI
         ehH4GoIS4KTGPmdjOJaPG+OtYpCVcTROzrJDWSFILeBcu2BiQAe3bwkbWscodqnd4Jvi
         tLn1ECdj1icPrn2SrEg2pYIGps2mGS8Y6mO5Je696bWbD0QgTZ55rFSwR6EGgpuv2zJC
         hDlepwxK8K3jtTEeyuIm3YYN2bwlpkmqXZ+9UR0S6iGYh9Wf7V1pJkc4netAbr2UT/MX
         L+U2MW0Vc6Ap2C7lv7WkXQHFedP66Gltau/Ex/KOJcnGnOjhOxhuYa7SaM9hllzP0iL9
         /Fog==
X-Gm-Message-State: AFeK/H0VGUxYMqYpQOkfGZML/BQsSuawtVhO6T0YMzXjvBgGboO1BsrGi22Df/T5ZWfIfQ==
X-Received: by 10.223.178.239 with SMTP id g102mr2433945wrd.126.1490274365349;
        Thu, 23 Mar 2017 06:06:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/16] tag doc: move the description of --[no-]merged earlier
Date:   Thu, 23 Mar 2017 13:05:14 +0000
Message-Id: <20170323130529.11361-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation for the --merged & --no-merged options earlier
in the documentation, to sit along the other switches, and right next
to the similar --contains and --points-at switches.

It makes more sense to group the options together, not have some
options after the like of <tagname>, <object>, <format> etc.

This was originally put there when the --merged & --no-merged options
were introduced in 5242860f54 ("tag.c: implement '--merged' and
'--no-merged' options", 2015-09-10). It's not apparent from that
commit that the documentation is being placed apart from other
options, rather than along with them, so this was likely missed in the
initial review.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..33f18ea5fb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -124,6 +124,11 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
+--[no-]merged [<commit>]::
+	Only list tags whose tips are reachable, or not reachable
+	if `--no-merged` is used, from the specified commit (`HEAD`
+	if not specified).
+
 --points-at <object>::
 	Only list tags of the given object.
 
@@ -173,11 +178,6 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
---[no-]merged [<commit>]::
-	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit (`HEAD`
-	if not specified).
-
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-- 
2.11.0

