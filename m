Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9CF1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBILEd (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:33 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44180 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBILEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:32 -0500
Received: by mail-pl0-f65.google.com with SMTP id f8so1309731plk.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATHdXcAJS/CcJlqzwZaZ2/rXIligSusD1iHHwqU/0oo=;
        b=QeHmAK6raBLZz0qV62skwmGUR685GrZjIfWrBffAXsumw9Zw/XVfe2TGmS+bDLdHIz
         yrFnH+IyiLnQZj8MIfiUoSF44wsctd92h8cWQ5MRtTXJ/B32YVK268hgLhIqQZ649b5T
         vc4JFz75Ldm1DYR7kmpAzOKhcJGN3HnvtVZI+ukiBGvv6+4NrjcorI/SRoeMO+BRKtje
         5G9Hvabzq891UjGDHD5JjMBu3bqV23Z+WgnsXf0kSwcanSfjE1S8qGQWRhavNq1x6Pjs
         HO+3JGc5uaxq0EZ15pQc9VqgwlHSgCRnMF0EobVRAdJwpfteDFT6C1KshgkWySNYsYS1
         G1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATHdXcAJS/CcJlqzwZaZ2/rXIligSusD1iHHwqU/0oo=;
        b=Ke0aGEDRT6H4rmxvK/ptkQ3FxkWx+xAr/kmx+6baHrm/9JqJS9zu8qBf6e8+PBoBrJ
         H6h3a5OGinjrFQHaRUiG+NR2PmPwwigChVmStujnRmQvGNhq7BAB3FhHpD6n07yhLfyW
         sJRPWHjISqVyQQwSKqmIyWMth9Cv7izO/W6Z0S+VYk5f0jlTpvQK7tQ90gjRapbGJxJn
         xtm0l+0VtYm+Q1L+gXLpVFLo6jIWVt9sAqHDYu0mTVHXNYwq+4bnAjgUU5MhJ9Ma2Q56
         iBwX3mmVgbNKciPxkimybDL/0sNxfnqeR/l/+gByyzLk74uZJCXfgasxKSXdcbpV5UnY
         Ta0g==
X-Gm-Message-State: APf1xPDwxnyz6Nr9Ppi1vjHSKSeNwFOnOxA/ttzqS4te35ydhn9OxuJD
        sCJbdUyHE9vLM9xfhUEh2cMoUw==
X-Google-Smtp-Source: AH8x225xYCysQgW5vfjKRqjLzdz2OzcsMMG1xJ1QNdP1PewtD8ezvqpU7rklRaPi26XRTWxXzYskxg==
X-Received: by 2002:a17:902:824:: with SMTP id 33-v6mr2211760plk.258.1518174271414;
        Fri, 09 Feb 2018 03:04:31 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id i9sm5635719pfi.154.2018.02.09.03.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 21/42] completion: use __gitcomp_builtin in _git_help
Date:   Fri,  9 Feb 2018 18:02:00 +0700
Message-Id: <20180209110221.27224-22-pclouds@gmail.com>
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

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60d27253ee..08f024a0ba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1583,7 +1583,7 @@ _git_help ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--all --guides --info --man --web"
+		__gitcomp_builtin help
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

