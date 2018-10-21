Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3771F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJUQWh (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46914 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeJUQWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id p143-v6so17033867lfp.13
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3NlXQApNvjvO4CGlOW1A6N96Ozt0nK0pUI7y3rSL24=;
        b=scfULQb06ArblhwSqNc6fnTd+A92xMVhYOAYpz4uzbLbm/Ke0V87BmuiSW0kGzgU+E
         Sx+S9FAj4cwEHqN4/UZHx8OYF3a5J8fmWQTD7fSulLgrXf1Na199cTIHhggwuudEkPSS
         ta58MIqupCYU9fNt6EtJ3cw2mpBrUepJr8XmE/qbgD/4rkwIGPY8CVLRaEbcOh3gZJS/
         Wj+BPJl7RHlY+y6Ots4U1FMwwMGAZ7KynMsT5Nb6YIacQfqPqqH4D0To+PQV29S8o8nB
         KwQPIfefm3VUFaT7MrQh437GsdxAGl2O63d4Nal3dOYz95MiyfFlPTMjaro24u4nPrcn
         aj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3NlXQApNvjvO4CGlOW1A6N96Ozt0nK0pUI7y3rSL24=;
        b=uMGf4LxJFDD2oEvU+l9hw659dZd3lKK4WLnrAsKsQ0rAUzp+ba2ZkTjcZ7Mq01vazf
         C7hkSQpzMJ3CClzpsndoplqFF88kI0WVbGQeo26reQYEhEWzR1La8vOz6q2fSliUzsv8
         oSGqul7LTn3x4lGNpESRHuWD5cgez+LuEATZPnmxE4KMx21gPSj+qKq2Xiy6OpzvCtpm
         roFTEAOIgqkcCgF5DDfFLEWtbt9rH3yXetFnF/0pqOz3YFnDERJil+pF+oTP/g4x4zdz
         I5jCpnI9zKrAx5/iV22uAHVFxC9NAUuGmUZtMKleq8xxzcsEtpqsJg1TAR9Gw7mJxYeL
         UQ5w==
X-Gm-Message-State: ABuFfohIX7hAluJCkQOlA5pk0PxeHU2GJHeD5oqgs8yTZV2Atv17W1lY
        O9Mg4Ar8uAZI+cDKmPR2R78=
X-Google-Smtp-Source: ACcGV61jWt0Srg3LLMft7EMIfa7fNSa+yxOxxq9zvE5t5lzYW756tSd+J8mnsD1rRPNE5ICYOMs4VA==
X-Received: by 2002:a19:cf8d:: with SMTP id f135-v6mr6524657lfg.53.1540109345574;
        Sun, 21 Oct 2018 01:09:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 1/8] refs.c: indent with tabs, not spaces
Date:   Sun, 21 Oct 2018 10:08:52 +0200
Message-Id: <20181021080859.3203-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181021080859.3203-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index bbcac921b6..f07c775b50 100644
--- a/refs.c
+++ b/refs.c
@@ -646,7 +646,7 @@ enum ref_type ref_type(const char *refname)
 		return REF_TYPE_PER_WORKTREE;
 	if (is_pseudoref_syntax(refname))
 		return REF_TYPE_PSEUDOREF;
-       return REF_TYPE_NORMAL;
+	return REF_TYPE_NORMAL;
 }
 
 long get_files_ref_lock_timeout_ms(void)
-- 
2.19.1.647.g708186aaf9

