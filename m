Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3A71F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFTJzn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:55:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTJzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:55:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so1382144pfd.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1yrcLjzKtHQk9feIb+pcN1vEvD4BtiJjjmN3UHf5Do=;
        b=sGcphc2f1Syb+rDBaOK/KOYW/x+/MRAgalB5+59jxLXkojJhBlrGd33PGFcOmjTefk
         MQD3k9XU9Jh0kDrxbCunBFzIZEaUAM1/sqGbXTe1NEqNX6fTaHCT0qOHXo+jiMRQKmZl
         IvUrpqciQT4TBZ5+DiH7fn8EXb2BGwFABI5jCSwVOliJi6AWT6+viEuOPgc54jvR2OLw
         niZdesl2eby2dnR47uhmmUS50/0IBYXW5Hkx8XNLryetsgGbO4vVpGA/9OKefMkSLUWF
         SUukkDE8zgrWCAU++cQbGED24lcRFinPPQaEizkUPN84VmF7MeChqwQNhSJfF+dCOYzg
         VC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1yrcLjzKtHQk9feIb+pcN1vEvD4BtiJjjmN3UHf5Do=;
        b=jyQBuwg04k9+iCGujqvjLTUUru9hW29xNFSLgl/JjJ1O8BNLUmI/My0GcLBwg8rwA5
         BK4A3yufMlNEZe8BeI4KnVKrs9fU4reULx/5IvAdcWwTZFS1qib0AeJUsJCSfwngJlUp
         8a6BfarwM0Ekj8MnWnPifkd5PdQ3VP+yJM3+tADTWzNoowa+VnQCyJc1heYDqH03ss7i
         0s/sbGhjQ+Dm11FLGUo2QHTwfqlB0dFyXnVPSp3x4WT3WlMz9YLyUU9wFO3k+2w/wGJJ
         E/BCTlT8I6vF1H5rAt3THJ2JEr9vbQGV8NNHSJz27wG2zQgaFUBnlXyfF4ugaz2Wp3Kz
         fRIw==
X-Gm-Message-State: APjAAAWi23fteuqNO1D4D11noEEj7a0tZIxk5Eqh8cXqj921ADzrusnG
        aYzhShGYYE2ZqZD7HfYvNEyTugtk
X-Google-Smtp-Source: APXvYqyqT+8Gxil7skScRA1z2ONkATqKTFVSmh/XQ6WRcaKCF1CseKFpFSH10169xbuVyGUPvHXZaA==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr2229000pjq.89.1561024542654;
        Thu, 20 Jun 2019 02:55:42 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id l194sm21179758pga.57.2019.06.20.02.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:55:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 16:55:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/4] completion: disable dwim on "git switch -d"
Date:   Thu, 20 Jun 2019 16:55:22 +0700
Message-Id: <20190620095523.10003-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190620095523.10003-1-pclouds@gmail.com>
References: <20190620095523.10003-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though dwim is enabled by default, it will never be done when
--detached is specified. If you force "-d --guess" you will get an error
because --guess then implies -c which cannot be used with -d. So we can
disable dwim in "switch -d". It makes the completion list in this case a
bit shorter.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 58d18d41a2..656e49710e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2183,6 +2183,10 @@ _git_switch ()
 		fi
 		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
 			only_local_ref=y
+		else
+			# --guess --detach is invalid combination, no
+			# dwim will be done when --detach is specified
+			track_opt=
 		fi
 		if [ $only_local_ref = y -a -z "$track_opt" ]; then
 			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
-- 
2.22.0.rc0.322.g2b0371e29a

