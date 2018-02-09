Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC361F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBILD5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38739 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBILD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id l18so3396838pgc.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCCJjTIiZbXh5jNzSqiRWXnP9N9eBXiYXmqaXk7agUo=;
        b=rJWtAL4DORIAuKRo4GdYB7EkkyMsdzJ2eUxnI2h1u/VEkKx5FSDWbtY19ZFlsV/y+Y
         7ndsw04vEbooSSHxzXN0YlO/fwdKIVo3O6vZhor+j4IuzSSuiHWIaXHLEotyLgan3kN3
         saSAxSaAcduwnod0U8FRKOXTbyCXxYOqeJOHROaE+YtVhLJyy+VVbexRH1464AD9nR79
         72aQyvT6m9duaasKaOSjNOkITCqb9yL/14xEUb1ojHd2WwzWVu4mU5TD9wxTOjuYzBdA
         vsGwxpoH9ADoJPUcQjGMZYaLW375kiY3+ALnN5BazvtAiSYRQPV5q3pkcwL4U8sl8B0s
         B0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCCJjTIiZbXh5jNzSqiRWXnP9N9eBXiYXmqaXk7agUo=;
        b=aehVxfau0lwY7labiH1OZpgZdF08qPqJD4139FNCW8Qk/Sd0JPmbkp8ZammRsqX+oa
         7VVmBZ1gQYgTQXWrNJqjsp4AxvCW1AzM3/v4qtZSdXQMjMn+y0m71vne4PRYf3fbmNit
         tpLGq+idCKubgc5fu7Sk8XzdQRM8rPmkuD74piZy7zQWxvV0N+sM2/khRVMDwtsnASUr
         w4EImHxzH+uJlyaHDa5mugvHdWCuNV6+iYc4zZCRPIMJXn5HQhRShdwDicm1PVvtFYyE
         MzA3jHAEJSOmnqYnp661mIDsXkpiFxu18WbomXwsrfBvkI4KheM3o5Rn9biB5+gt10v3
         NBVA==
X-Gm-Message-State: APf1xPBLkJTV0VTLAYXfRvSX32dkIXsjenzojQkTa+saYz06ao3PBWH4
        sXxNbu4lXW8wkv23EE3dLaa1uQ==
X-Google-Smtp-Source: AH8x225w9IrBA9u5KmLGR6TlGU/1oiW1zRX3wmU+CiSjR+XFdPdLdVK+zMEJxp1S5g8qUU/nxvlP+A==
X-Received: by 10.99.122.15 with SMTP id v15mr2017327pgc.387.1518174235712;
        Fri, 09 Feb 2018 03:03:55 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s89sm5498958pfk.35.2018.02.09.03.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 15/42] completion: use __gitcomp_builtin in _git_describe
Date:   Fri,  9 Feb 2018 18:01:54 +0700
Message-Id: <20180209110221.27224-16-pclouds@gmail.com>
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
 contrib/completion/git-completion.bash | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6e17caf8d7..7a98f01067 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1369,11 +1369,7 @@ _git_describe ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--all --tags --contains --abbrev= --candidates=
-			--exact-match --debug --long --match --always --first-parent
-			--exclude --dirty --broken
-			"
+		__gitcomp_builtin describe
 		return
 	esac
 	__git_complete_refs
-- 
2.16.1.207.gedba492059

