Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B498920248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDKNNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36324 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKNNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so3516431pgc.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwRO2z8kQeF3ksLZsr+v5KJ+1r6RYSnYKWnOkWZjHOQ=;
        b=F/qacjHoRgzm+BWFUEdVBR8Z54ez438KOwLNAL63KMmkriC2yxxQubzbLGD82GinZ7
         Gp0f3FLahZBblI7yFajI8hjHFI8xHxCBgK93wK3+4Lj1nu8UBT1fTCVnyNvi17oropXU
         Mbye2VlKNbSsu61AtyODv4q71KJp39KjkgmJJvcL6UcBY9BU4jo3tcmWJkKnLKEbOPNR
         KrDYCOYHgW0Fd0Q5Z3jqSwSeeONDfiiO+n3mH95vzChEkG1GEO7nf+jOxuAQLr/EsaTm
         LUOVH3WSucQKkxGkdDjjvoOVf94v5f7twZOW9X0F20CwP0p8WD3hUD9n7NY/Sq9oOMrG
         FszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwRO2z8kQeF3ksLZsr+v5KJ+1r6RYSnYKWnOkWZjHOQ=;
        b=eo09pLE9iAWK5CzCw8nsLuuC1ZOSLJBYKRD0ZlCCXUmOmmGbYvDDn4fdJQjRxjn2Cr
         C9Gp3jOWBr3Tt9TtZ4BbAHjg+9B1u8atxg5XYf7+oMIK/IPxg69Qf4nB7O3bORnlafOJ
         Xkt94SqgSD8uVO05dHjEj1wnfpmsIeJvXktmjzZuTf7Yhmdhlp19wETqv0DCQvx8HQW+
         4qFlh57BS3ssTHia1u4oxAjduso3VlvMS1x3JiIFJ/CcVn8jv4QiMNu3Hmbq4uRUnMH0
         iA/7dbhiL9lnT8KfE4r6WGw3r2Ny8YqU4/TfK6T+JSPUc0Aa+ZhaKhuKqNtQ8sMYZ9dO
         SitA==
X-Gm-Message-State: APjAAAWiWaBo8kelzUeSZNbwKeoxgnggx++gUrEQDmdRxRbHVTGHO3ya
        BOANIceQ1CCpp2ncZ0o8mo4=
X-Google-Smtp-Source: APXvYqy5Lcdp0VnBrXUxWkPgyOyrSzvjzAOVWcUk6HPrjvAiit9h8fEQerrxoZpcpeps6s+hj2iyBQ==
X-Received: by 2002:a63:1d5b:: with SMTP id d27mr45876786pgm.386.1554988433848;
        Thu, 11 Apr 2019 06:13:53 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id k9sm55145129pga.22.2019.04.11.06.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 13/16] user-manual.txt: prefer 'merge --abort' over 'reset --hard'
Date:   Thu, 11 Apr 2019 20:12:15 +0700
Message-Id: <20190411131218.19195-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the operation in progress is merge, stick to the 'git merge'
variant of aborting. 'git reset --hard' does not really tell you about
aborting the merge by just looking, longer to type, and even though I
know by heart what --hard do, I still dislike it when I need to consider
whether --hard, --mixed or --soft.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 94799faa2b..4e210970e1 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1408,7 +1408,7 @@ If you get stuck and decide to just give up and throw the whole mess
 away, you can always return to the pre-merge state with
 
 -------------------------------------------------
-$ git reset --hard HEAD
+$ git merge --abort
 -------------------------------------------------
 
 Or, if you've already committed the merge that you want to throw away,
-- 
2.21.0.682.g30d2204636

