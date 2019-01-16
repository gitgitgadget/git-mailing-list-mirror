Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684341F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391916AbfAPKdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:33:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33920 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389591AbfAPKdF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:33:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so2670156pga.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MG4Dk+rDN502CyNBz06Nn2JLdINDNpRoYWEOCtKr/0I=;
        b=jw1Pw5ARh2vNguHx1GeG8x14Nq6tF5S+vIfl5ZdqP+SaAeuy++nqHol+284M8m8ukz
         JqwYYFbxaeSMlw2cS265ZUD3Sb3Ee6btmauA2fTfrxpCvmUItFVxiS2MRh+31rKUIfYH
         VcT35uMPj7yTN0E8iFiL/V+2a15S6XMPZ/eMuk+Zi6F/iD74ZRf8CoYjCBUXTj1Cz2fW
         0Ornj/9ZPJ+Uu0n7slUP0CqPnw6b/AH42vICwQQAFvzHztK0I2jZKhkBlLJ2WCaMSBm3
         wkSg4BO79i4fk0738PkpkbMxZ5EJQnrw2rx0tILLvh4MBYSsSVvcaQqSnLJMGc2+JPi2
         58cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MG4Dk+rDN502CyNBz06Nn2JLdINDNpRoYWEOCtKr/0I=;
        b=kyxO8Hg/q2S5HKkEkdlcWv0yUX1fdIiul9aqw1q4mWhW9wHGyxBVjtxrmft6qDjlC5
         buEW7g+xiW603Uv597aT2pnRXzM3+mmeB4Y0UUrYoENSDgNmrT3wHWeMacOLO5Wkji4n
         +y2ejAgtUV0w+Z7B53vYX8pln3GuKZSYZa20wKV1vWd8A69l/RvStK27GHy4TpJNNb4N
         Xa+HTCIT7lEpQU6CFgs/JEVX1MUD56vaG6mLvoFmqVOpk78Bxqa2kISyMP7VI6OdS1CA
         H74KZWynkkELOqYvSaTdcHk9eS3vVk7jd/+ZnAajefIKiWhGRhNg08DnjHzSFqh+x6f7
         rBDA==
X-Gm-Message-State: AJcUukfTyYXiBoqSzrCbhwX5z78aWoF4h3fOt4Tr7x2EPacbsBkgMEeo
        0UgWvOZoR1l1+gRmerGF1sy0SGi+
X-Google-Smtp-Source: ALg8bN4CSGQHqFQWadXl6sh4bk0SU8OuHqQivwmr8EbtlCYyUG/dulvNOpYqnQ5eKrWSaXbHqNOLQg==
X-Received: by 2002:a65:6491:: with SMTP id e17mr8138157pgv.418.1547634784450;
        Wed, 16 Jan 2019 02:33:04 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m198sm8559138pga.10.2019.01.16.02.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:33:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/10] submodule ensure-core-worktree: write to config.worktree
Date:   Wed, 16 Jan 2019 17:31:59 +0700
Message-Id: <20190116103159.9305-11-pclouds@gmail.com>
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

Use repo_config_set_worktree_gently() to write core.worktree. If the
submodule has extensions.worktreeConfig on, the key will be in
config.worktree instead of config file and not affect any new
submodule's worktrees.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8a12d2f0ed..890de5902c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2063,18 +2063,16 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
 	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
-		char *cfg_file, *abs_path;
+		char *abs_path;
 		const char *rel_path;
 		struct strbuf sb = STRBUF_INIT;
 
-		cfg_file = repo_git_path(&subrepo, "config");
-
 		abs_path = absolute_pathdup(path);
 		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
 
-		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
+		if (repo_config_set_worktree_gently(&subrepo, "core.worktree", rel_path))
+			die(_("could not set '%s' to '%s'"), "core.worktree", rel_path);
 
-		free(cfg_file);
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-- 
2.20.0.482.g66447595a7

