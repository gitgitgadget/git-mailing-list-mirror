Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47691F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbeLTQZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:25:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54852 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732992AbeLTQZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:25:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so2662048wmh.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=croQXYHNHehpvuWiJZBef0uvwVh+XEOmDLPgUFZWnP0=;
        b=SWpdi2bAAUQCkKKR45+oUey/48lG/nIQqEo+VOt6V/rVD51dRVObQNDUGoZCNrgtsY
         xM2rklkf0or4uJmwUo8m0KMuhnEkfrAQcyTG9vYNWn35nGJwsUoa+7+vywUddtzPwPNY
         R/NtQpLuhJRDOeBJYw+EByBZzrxlbGO7ILnDVKRtNOoBY3Ja1SGHT1QXT0fR3M8MaDDP
         0iB2rZu/wyUS23y/lv/uKdAPkdZNG8ttxISSerglUxqhPtpqJsXrIttXTcY7RbHcheFD
         GiIwJwfWLStMxRZMU0520fV2nHFYK0jFC8namHXDeQcPdyNyw2Ev2JztsPtOFPzN1hOz
         rx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=croQXYHNHehpvuWiJZBef0uvwVh+XEOmDLPgUFZWnP0=;
        b=EygPyZAyM0OD4RLmfceHg1V4JImxcVanacJlooUL5qmQxClLIa805lVKer3q8R6j/4
         3Tv2L6fVjMogzjr8z748j2/qDqtt6bH88EoPqkaPSxBFBDdYl/scQcuJDbfl+vrHZ+1R
         BLl6m3HcFffEtSwjb5wLypbm7FYLFfOPPYSyRyBVz3SjtWusErMolyZaNnN3DgIaYsJQ
         +sjWEKECawEjMnGJ8NrhkpbfLeyCdXY3paemr7VHrVGY11OZa+SnUnWVikX5QDh35jTY
         GolHDeW4ue7KPSkcVTYeA1GsHpfBXFSWPv6KVWDF6Z0qYtoijtEe8foO08R48aI8edKO
         am2A==
X-Gm-Message-State: AA+aEWb7vNcmbfYdq2VXeKpVh4DFJL2khOxfBm+zpyKg1uqf6w75vfG9
        eLpBXxQhWvk1rk2mPDna+kPDBjo4
X-Google-Smtp-Source: AFSGD/V2lbamxihqrDKx5qfBCXcXxZTgQcUtg05R7VDr83NhzWhnM02fLgsI8YiSltL+qi9NVrgP7g==
X-Received: by 2002:a1c:ae88:: with SMTP id x130mr11495255wme.91.1545323121346;
        Thu, 20 Dec 2018 08:25:21 -0800 (PST)
Received: from localhost.localdomain (x4db1e5de.dyn.telefonica.de. [77.177.229.222])
        by smtp.gmail.com with ESMTPSA id 200sm8980566wmw.31.2018.12.20.08.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 08:25:20 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] travis-ci: switch to Xcode 10.1 macOS image
Date:   Thu, 20 Dec 2018 17:24:51 +0100
Message-Id: <20181220162452.17732-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181220162452.17732-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building something with GCC installed from Homebrew in the
default macOS (with Xcode 9.4) image on Travis CI, it errors out with
something like this:

  /usr/local/Cellar/gcc/8.1.0/lib/gcc/8/gcc/x86_64-apple-darwin17.5.0/8.1.0/include-fixed/stdio.h:78:10: fatal error: _stdio.h: No such file or directory
   #include <_stdio.h>
            ^~~~~~~~~~

This seems to be a common problem affecting several projects, and the
common solution is to use a Travis CI macOS image with more recent
Xcode version, e.g. 10 or 10.1.

While we don't use such a GCC yet, in the very next patch we will, so
switch our OSX build jobs to use the Xcode 10.1 image.  Compared to
the Xcode 10 image, this has the benefit that it comes with GCC (v8.2)
preinstalled from Homebrew.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 03c8e4c613..36cbdea7f4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -8,6 +8,8 @@ os:
   - linux
   - osx
 
+osx_image: xcode10.1
+
 compiler:
   - clang
   - gcc
-- 
2.20.1.151.gec613c4b75

