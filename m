Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27EE1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeBILFp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:45 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34509 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeBILFo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:44 -0500
Received: by mail-pl0-f68.google.com with SMTP id q17so1327750pll.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnnT7jtUAgADZH2m1GgOnFykayWcF3xZUgKKvDPwKWI=;
        b=jA/ISBzdeBQDKhA4q3dymvqUDJmwLNVJ1dOK6K4GRdsT+YPq+md8ddmohHxBxeNU8V
         QWFu4qo0NiM2V+muj3cBBJ/a+4HUA6uqSH4Q34f3KBhsFamsr5aIwHwt0S0UwLMISNpQ
         UGmwoeHfo+nQ03abwxYaUPBgzWCGC1pO9MZyM5uJybgWtqrRH8YEUzxUp7ih4/GAB3By
         fbSVqG08stOAzam8BZNz3TGSDGnVpp/sGJfSirErI+BOGOP5Qfq+ptiFNSbEIUnujxV+
         PYU+GmjugeL04x+QwYXlxwTZBvFNFshWpgC6HOEnKWDFBTscy1Qz8k9o0ACZGo+Vq7Hp
         jCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnnT7jtUAgADZH2m1GgOnFykayWcF3xZUgKKvDPwKWI=;
        b=RX0WsDqFLA3oxTT+Wvls26+z40vj4JSXzRhDwE8d2FhwZ2oIOrDRM/v4+k21M+lHvx
         gNsB21+GCa5tBoI+zTTgrIUUh1Vxcrsb5kcn/zwudbLYoi/G0xbkS7SaHPhL6WM0ojhS
         hrI4qa/guxIJf7n4lLVBH9zvqedugTSUeWc777kHzhyQyCB7/eBIoQOb7O2iUmUQ9sCE
         iSOwxd4PIHaS+vBSULqV9OWhpDKDcBxwnuPbaNvo1SqWj2VvXsN9sIfuQjauu/mIDk8u
         vsR8b7rEF+k3tN0flyavnBSpX8Z/qAXvrZnRU5Lvc1xIBCt3tOxCJHrj/l2XJT6Z1aqN
         bCEg==
X-Gm-Message-State: APf1xPDrUhKTMYzGqrIyS9XFiUPc2l0diQ05H9+4iO28W1I3zzR0aDvE
        MhcRorSCHUJ+z22jGhfsvh1wWQ==
X-Google-Smtp-Source: AH8x225f03eaDMqRIKL2HuRZFP/NeAzgY1QH4Luhwy6I9lzdu68Q45/HILnyBV5grBCOv9rDqKJZRQ==
X-Received: by 2002:a17:902:a711:: with SMTP id w17-v6mr2158343plq.299.1518174343473;
        Fri, 09 Feb 2018 03:05:43 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 205sm3841585pfw.77.2018.02.09.03.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 35/42] completion: use __gitcomp_builtin in _git_reset
Date:   Fri,  9 Feb 2018 18:02:14 +0700
Message-Id: <20180209110221.27224-36-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--intent-to-add
--quiet
--recurse-submodules

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 18c2ccece9..9aca05d01e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2685,7 +2685,7 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch --keep"
+		__gitcomp_builtin reset
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

