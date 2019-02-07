Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18144211B5
	for <e@80x24.org>; Thu,  7 Feb 2019 06:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBGGdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 01:33:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43274 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBGGdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 01:33:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so4331773plb.10
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 22:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U7FgL/y2qmXuw5zzWD7t3Y6oBH9U6y8z7ZMPEBV9Tls=;
        b=alsrd1vf2FoEks9xpQ4DCZ6o6MIU1KWtEw5PcQDwL9htTJ1EntghthWH5YzwC+m+RG
         SZvUxHNpgQ/EX6hsaJlMIjGx2XMRlc5LpQAy86lhKg9uldwNn5hBF0aT53k+CJENlo3P
         RZNEQ/likD5/r78q9l+umdzqddM5kGvUxCAzL+U6bEAuvt3zjvWXnAzpDlxjkVC6oc21
         HqmhaMPFUSY4zixWxNo9HuX2Kc16Cez/QMKBnh7F/dWeA5eA4W4iN5wjFX4nkyZ0Nfm8
         mQ/8gPg/jA1AKnXx7GzK25N1rCVvHLJl+6KM3XxFzZap2P3Nd4ZvARn6ZMnKfydbDDR/
         pABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7FgL/y2qmXuw5zzWD7t3Y6oBH9U6y8z7ZMPEBV9Tls=;
        b=Ni889EUQ3MA2HSZ4C0jfMtqpePJssKRKNw4yDpWveSMCjOOLuWCFqzkvDFeMF0Q767
         0PLlzqXgSkcNe+rSnCVaXV8XoNHoHJJ9dhtN7LItf3mGrJ9wPmAsFgR1B7mizwG4PuNq
         gSXlkBSrMSh7Dfu2idEb9KaENlISp7VhdqQCz4dTYgX4qcUMnNcPFF2ZiBTbMAZkkMRd
         x6U2t+x+3UA2whhfYWFAvtr224eIlsehmtp2yEU96n9cMGV/08JFL8jjPjpXnNYUVzWj
         5W68KEvWbifKH29HAFp259mOXLANecBA1W2LamylqI8CADXAXQgZVIDmYbhxaLkZXFbv
         f5Rw==
X-Gm-Message-State: AHQUAubGGHiM0ZXnNnfuYDs5KTD07+B5h8HZsJcHDjEv2pFgox/W2Z2k
        G0Im3uGkcynnxmTU/+7HbPOoN+Mt
X-Google-Smtp-Source: AHgI3IZ1LYlWBsqQIEb5aWSNIOC5D52WvHMrhbNrmegSd+QYdkvQmTqlhsRTeQiAGlBPGrXPfR9pTA==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr14228174plq.278.1549521179138;
        Wed, 06 Feb 2019 22:32:59 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id h8sm9175700pgv.27.2019.02.06.22.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 22:32:58 -0800 (PST)
Date:   Wed, 6 Feb 2019 22:32:56 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 1/3] git-submodule.txt: document default behavior without
 --branch
Message-ID: <cf6e0d16ac0c0d521da98f5d9a53532b923a621c.1549521103.git.liu.denton@gmail.com>
References: <cover.1549450636.git.liu.denton@gmail.com>
 <cover.1549521103.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549521103.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behavior is mentioned in gitmodules.txt but not in
git-submodule.txt so we copy the information over so that it is not
missed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..9951c68744 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -261,7 +261,8 @@ OPTIONS
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
-	same name as the current branch in the current repository.
+	same name as the current branch in the current repository.  If the
+	option is not specified, it defaults to 'master'.
 
 -f::
 --force::
-- 
2.20.1.522.g5f42c252e9

