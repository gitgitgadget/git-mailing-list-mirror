Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D54C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 09:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjAJJdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbjAJJc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 04:32:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976ED15812
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:32:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v2so54606wrw.10
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TghVST/V+XBh6xTEOnjdxY4xvuY+PDNITGwUy3Hq7TU=;
        b=Wwssa4AAF7qjEf5/gpV4l2zrwPdfVICWiKW+7sG63NWpvgnfVsd1GUvCxAHlX8SkXS
         GiImIQQD/dy4RPBiUr5gZ4t+v/qeAwCzH+8Y/Gjf/irVCo8gailcQsY1MAlOf4m2li6c
         D8XOVSI1jkUkU54wrrkJiZa1fIEny1Pvgmi2lFG0VRqGefMSW7Iw1F0GV5k07zPkBggv
         bcb/EZ49xuuAETpBMVhXLvw3zQ+d1lUGvCSkRpAvkSArbS4u1UlHu/mEZMFagKJ8k6b7
         DorVHEUoTQjwKzNUAbqE3PAnzbxd+V17jBwVT0g2DdMVymBuMdY0mQTNe6B/06evzjyd
         Eifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TghVST/V+XBh6xTEOnjdxY4xvuY+PDNITGwUy3Hq7TU=;
        b=z04B+hIdUyTWZgfnohabwH0W0vk1cA8m6PafhVWhJdE2EID6QmuakxtSTTh0zjulIx
         APUC1CCHjIwvPp31mfEd03jiZ8MSkm1skO7qJbJVr5sa87IQcEf06nl3EJPYXxDCKzjs
         VOwoRRvCW42lq4PF1mm96xZtalb+Xtf59wUWrUItC5Gjgsxk4ksjCVg+XkYeVj8nSa5E
         1vKIbK/BtGohb5HHfqkuz7ToQYfm3UCaWmRJDizEUY8OQNBw7ayMnJOthBibu7zdnvEB
         KrSl/Bb44y9ADMI2FaPZHKPrwPHnQtPxBBmO/riKcF+70sDqTT8O15K5CBmTgCUkfdgm
         UhjQ==
X-Gm-Message-State: AFqh2kq7VjRCbIxuLhBPIbZ4bMDp2wt4Pm26syCToNf2rQikJOATUihn
        HPpMzWwTT0Sg7Pv8UVrVn/+l/MYa3QlrhPVl
X-Google-Smtp-Source: AMrXdXtisAh/sh0lq072oSnj5Pjz+hRIXAShY9IpEMDq3hANAYie37fkadY4GF1anLCpbwAI1mf7zg==
X-Received: by 2002:adf:eacb:0:b0:27b:7b34:5cb3 with SMTP id o11-20020adfeacb000000b0027b7b345cb3mr33829046wrn.51.1673343175749;
        Tue, 10 Jan 2023 01:32:55 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.75])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0023662245d3csm10729071wrb.95.2023.01.10.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:32:55 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] git-bisect-lk2009: update java code conventions link
Date:   Tue, 10 Jan 2023 10:32:50 +0100
Message-Id: <20230110093251.193552-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110093251.193552-1-rybak.a.v@gmail.com>
References: <20230110083801.186789-1-rybak.a.v@gmail.com>
 <20230110093251.193552-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reference to Java Code Conventions in git-bisect-lk2009.txt uses an
outdated URL that redirects to table of contents for the conventions.
The actual claim about "80%" that this reference backs up is on the
first page of the conventions:

  https://www.oracle.com/java/technologies/javase/codeconventions-introduction.html

Use this newer URL and its title in the reference.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-bisect-lk2009.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index f3d9566c89..36168792ee 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1348,7 +1348,7 @@ References
 ----------
 
 - [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
-- [[[2]]] http://www.oracle.com/technetwork/java/codeconvtoc-136057.html['Code Conventions for the Java Programming Language'. Sun Microsystems.]
+- [[[2]]] https://www.oracle.com/java/technologies/javase/codeconventions-introduction.html['Code Conventions for the Java Programming Language: 1. Introduction'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
 - [[[4]]] https://lore.kernel.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
-- 
2.38.1

