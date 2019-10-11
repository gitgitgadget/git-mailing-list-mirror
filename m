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
	by dcvr.yhbt.net (Postfix) with ESMTP id D64DD1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 19:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfJKTXL (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 15:23:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42482 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfJKTXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 15:23:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so4886411pls.9
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmZZKPqBnzwmgiVttNY/y1ubM3JTmIyT4sXJ7fPr4t8=;
        b=UQijfL44vjIogh3YgsBbHM12z6J61YfYsOjUmAGjravS1cBWsroSkgU45At4KOsGl6
         4vaPHj3OTmt9rLcqhU8j0/T+drcCnTkxLj1XyMJYTIjA8wwifVXMy+xNP0iZ/wScK9VX
         zKLIsMViU2VSBCfX86KQz7S9I5w7yr0ZHMRvH5hlmDlrYAEZdGn48xvlTsHiHA9hmodx
         eL7KzgRoe4EW9i1qVLjkP7/RxLd2NaOJhATRMUSnZ2x6Lqvq++43RVx93zYn57CtH+vX
         bb5GB3LIHIzKdI2LEv0HleQtOIdy4VZYwrPlnTu6cce01RdlKbDbxYMs1nJvWKOnEdD8
         9jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmZZKPqBnzwmgiVttNY/y1ubM3JTmIyT4sXJ7fPr4t8=;
        b=Yn+sS983pkPhXMjDlNJMFyTmL2N/RZac/OU/rXpl78BLGK/Mq12bY4uhS9m55bnh/L
         JYArg+NY0rzxbmPKqdmD1WvsGoQrSZb+B9V5tcdF2l+K+b1GE8So88MeLi8XD9zNH2kx
         LNE6A2VBL6aNULeyyCvnBRUjtQFSqmP03/z2/Y2cDknJ2qAlHcueQ4MpZODZNtU99/U8
         Q9OgCZlqttAmf1vhgUy4QtczBFp0KYNGEbbarl5WXDlXWNrJl61OnuSCl4b8eiJ+b2fF
         G5EJ5PU3WIdn1101sSRvlC+mxX2pxN52l1PsqxACCtVHeZWSKeNJxerNKh/WaRVAZSdq
         mxFg==
X-Gm-Message-State: APjAAAXaUBRRLBgu+Avz0yInt6JZTPANeCi5BK4Qk9+Qsz2hAutB1n3/
        6wsw8YIzDqpXvn+qCFB3Ps7aGeyE
X-Google-Smtp-Source: APXvYqzSRDNch1pC96/SRhTNt04UoEDsQiiLAY68Ku+Y86Apm2eQqNDSKNuKuKeQAwdwY8yAjv592Q==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr16415254pls.23.1570821789910;
        Fri, 11 Oct 2019 12:23:09 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 22sm10412861pfj.139.2019.10.11.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 12:23:09 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:23:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 4/3] fixup! format-patch: teach --cover-from-description
 option
Message-ID: <d3d07c31a7c5d4db0b3efd1e7fa074966399254b.1570821731.git.liu.denton@gmail.com>
References: <cover.1570821015.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570821015.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 86114e4c22..4c652c97f5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -368,7 +368,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
-	inferCoverSubject = true
+	coverFromDescription = auto
 ------------
 
 
-- 
2.23.0.746.g72fc0fc0b9

