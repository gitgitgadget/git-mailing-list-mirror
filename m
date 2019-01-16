Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B271D1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfAPKdA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:33:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43009 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so2645492pgk.10
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpk6yQunThNTIG8rf1WgtCKj97UVbEDXKwiz6S60EWg=;
        b=kzOyktL/DvK0HxF2jZoHtwOmagrRHM11PtSFAyasr/6Bx7zPMPVFVT22ZnHPDJu5ho
         kQeFwXyZO44G4jJfQ6oBsaRoaWgRqF3oSqf06JwM6PC901TmVRaD+vLnDNYhqOP8/YXJ
         pQtFlMSRH0Ja6Ro4t0+cOBQsriX8h7bgiiBZIetzo7XEA1lU4x7YaAqTM1NHQIg9F3tT
         J+FU1nhqI0l4ZOKuULzmY6DocVAFFfBFsW3BEYVvGQPyrFzLZRAU5oW6SEO9ByKR06MG
         FSm5tbny6vMOHvm0qwWbtP2A4LdSI5mwqUSToJnTtNR1MuyOhNUno+SvXvLxhSqIG1au
         rJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpk6yQunThNTIG8rf1WgtCKj97UVbEDXKwiz6S60EWg=;
        b=moDvmXI+4wIuWOIObtd4WziDxo32U5md8Vb4qiR2cQtc4mklchIoyAyCjxlEouZR1I
         Nx0S4m7rAjvbrcoBhh3Hzl9FK6XA1e5tWOb6TZzW23RcH8mmw/OHBOPASBRY9cadHZek
         Zu94n7lSFh22xOXQ+ilDfFPkbOiTwlJr3w8gE8IszcB68GRb3cESnNK6yUgl9upUMpI9
         SPaWZ/rdE+LDX10k+BAfgnrPwARuxUk+tTTFaZeOp+oGFtVTi04+rmWd6T3uF64dWS9j
         wteX5gH3Mfxh0uaFHoh2YCm6rfiUuWHUadvNGwTptHVfD4NousLbaiS0IYUYS4tRy88l
         iFQA==
X-Gm-Message-State: AJcUukeBJwL8UKZrFJtvxcSpKCg86XJgYFYAIxL5YDrLDF6WHKSqEMXd
        GI9nF9lRXyZSit0w3exZcicYjDdq
X-Google-Smtp-Source: ALg8bN6qmlEzNjgYGPYpnF38cw/4HHm4YVmrurpau92LNh6NyZXpNAiqTXdQwSut8eOXA4Y4mnhsgw==
X-Received: by 2002:a65:534b:: with SMTP id w11mr8202767pgr.125.1547634778643;
        Wed, 16 Jan 2019 02:32:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q199sm11182914pfc.97.2019.01.16.02.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/10] submodule clone: propagate extensions.worktreeConfig
Date:   Wed, 16 Jan 2019 17:31:58 +0700
Message-Id: <20190116103159.9305-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If this extension is already enabled on the superproject, the user
likes to use multiple worktrees very much and is already aware of
it. Enable it in submodules too so that when they want to make
secondary submodule worktrees, they will not be worried about enabling
it or migrating per-worktree config away.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b5d74cd415..8a12d2f0ed 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1449,6 +1449,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	repo_config_copy(&subrepo, the_repository, "submodule.alternateLocation");
 	repo_config_copy(&subrepo, the_repository, "submodule.alternateErrorStrategy");
+	repo_config_copy(&subrepo, the_repository, "extensions.worktreeConfig");
 
 	repo_clear(&subrepo);
 	strbuf_release(&sb);
-- 
2.20.0.482.g66447595a7

