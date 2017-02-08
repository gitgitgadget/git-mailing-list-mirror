Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351351FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 06:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbdBHGGz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:06:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35857 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbdBHGGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:06:55 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so10890691pfo.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8cHG1ulKfgUeMTJYNkyzsnBNe4tH0j/4ChkhwOhNn4=;
        b=qr2rf1XV7IaNi2K7pJhmtGlubgYZN9R/XqoR3tralZXkuEjPKLVQf6BYwmJ9hVMFt/
         RkUbehTtwO2/xBhUMS9rDsdhL1zNIVHMi1sNUOKBgzL6+EzwggCXhBMJeg0BucdR9e8t
         vccsLvNZLMej3VtVIafoLTP2ZopZ53Z/37SnZ8LsaBCVb7KzqHEWM0ijNQHGs+3uNUNv
         UtYmNqATtgnl2CNtmH0eCD0kuT2J65W/jJ2iVIj7OovbSE03WNtoDcz/c6jyQSLku3Nw
         hyQEy0JkfYmidY4VrG3aBOMSDcFjvYIsns0GeWImJXNlh5Vz7wMcDvE1DPMrfDd1xbJm
         kBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8cHG1ulKfgUeMTJYNkyzsnBNe4tH0j/4ChkhwOhNn4=;
        b=ho5jvLWBPnP/MKOfEKdwNTKbr1YspRyD/ERu5fD4G/jCv9llKb/afbnXXsNA7NyHVT
         laHoJXmIeQlwdpZXGFB55+WiCxMah/5yrRJJjTWjZlUkrzzUEUm7X1W2hKJ4OwNqptgr
         zBhVuyyRe4pxLXb8/x7ayF0Pe66yBLlDic+KVMCYlO9kpDCnp4e7O4mgHzKyyPo6rjQI
         dNhU2wt1yCPWCFkIWKWCZkWsGP+I+ccVGZDPKztEDRLHbnJiSlRSZw3RfUwoCfRGOE5n
         zu0Bz/r8O8GCCV3v/c7vTgD+RGqBA+TSCszrY+rCcYXOxUxsg4DHmXbn9reQjJN/MojX
         Hotw==
X-Gm-Message-State: AIkVDXIORFsm95ya4ooVl46sjHlnA/PZf1NDyuULvwpD1EJmAR81v4fDa1JCdNlMC2iA0A==
X-Received: by 10.84.130.99 with SMTP id 90mr31694621plc.167.1486534008037;
        Tue, 07 Feb 2017 22:06:48 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id q19sm16263249pfl.21.2017.02.07.22.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 22:06:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 08 Feb 2017 13:06:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] rev-list-options.txt: update --all about HEAD
Date:   Wed,  8 Feb 2017 13:06:41 +0700
Message-Id: <20170208060641.13793-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170207133850.14056-1-pclouds@gmail.com>
References: <20170207133850.14056-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the document patch for f0298cf1c6 (revision walker: include a
detached HEAD in --all - 2009-01-16).

Even though that commit is about detached HEAD, as Jeff pointed out,
always adding HEAD in that case may have subtle differences with
--source or --exclude. So the document mentions nothing about the
detached-ness.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 drops "detached".

 Documentation/rev-list-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5da7cf5a8d..a02f7324c0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -133,8 +133,8 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	for all following revision specifiers, up to the next `--not`.
 
 --all::
-	Pretend as if all the refs in `refs/` are listed on the
-	command line as '<commit>'.
+	Pretend as if all the refs in `refs/`, along with `HEAD`, are
+	listed on the command line as '<commit>'.
 
 --branches[=<pattern>]::
 	Pretend as if all the refs in `refs/heads` are listed
-- 
2.11.0.157.gd943d85

