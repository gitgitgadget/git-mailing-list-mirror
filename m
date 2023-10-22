Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D29101E3
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbrbBu5L"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31AE6
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1847710f8f.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011108; x=1698615908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptiY9uGr0tGcZYfRLICQClF0krFFysLZ7VCGpBGmACM=;
        b=RbrbBu5LeRsTcgnffOFBmUr9LYzJAwHDA8EEv/dBYMwjNTwaEyaBbX77VljZBvw4gJ
         ZDNUCAjqRPEYJajz2pU9NVe1/5CfKtzTGzY23GdHsDKEvxpJwJ1jYNeqD8UbMPLA+8E3
         x8OM5uxKdizrXHkuiVFnkg7DS5NyPwjyIQIamGAGUcTdPo3w2/siDM+4JEexYsWPN4NZ
         uDADscGvhgY32+y93rnqSbOsrasK2Em+h5mL2kyYHSP/Vw7BXmvyTTmytJVco3bUD9Ki
         Wog3UfQPzbJLaedKGTD63y/uv8rpqGs6xIQXpbv6Aiz133fS6awEtEQSaEFU65UDv6a/
         Dhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011108; x=1698615908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptiY9uGr0tGcZYfRLICQClF0krFFysLZ7VCGpBGmACM=;
        b=hFkm92MEr4IyiDqs5M5ar92ZRJvJ8mipC87Asm6WjYI/Bcp1N7WeRoWcwGAoYWEhII
         t0Iw39j8aPnjz0ZN8fYLu5JTTrJpnyOgf0HSwZlor5ST72K+5tSA7q1SlKKNmEd92wCa
         fkTq/8jcoKZZ8ZbBmKw8e9TotYKUoQy3MYbFy2upwU6K/3ZoZupGV9jdtwESle9HExVY
         CJgs7gwylJTeKHG5ofXD69qe9wlh482pn98EnxMh2VnRZxXSsyMVPh0FoOy5DSEpt84m
         d9XriuLbtUCV2nrGnPzErAzmZsTuLU23oxbFKQ1qd1o72gr8mGSpJRLX5k4U7ZtXmMbI
         jn2A==
X-Gm-Message-State: AOJu0Yy4qIXseHUcVxHt9niEzqRtVvNi1qCT4olGucR1cQOohvyJ7fE7
	s4iQuy5DdjRY7MTfyoypux2/Xt7KGEA=
X-Google-Smtp-Source: AGHT+IFk4Zt0mecEHd2tCfczQtm1xnLmmqYpj+L5E+xI//ywghnHbTpXuhAq/EYkKhL5YSa0dJOzBg==
X-Received: by 2002:a5d:6451:0:b0:32d:ba78:d60e with SMTP id d17-20020a5d6451000000b0032dba78d60emr4034932wrw.65.1698011107981;
        Sun, 22 Oct 2023 14:45:07 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0032d9523de65sm6291972wrp.48.2023.10.22.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:45:07 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 1/6] config: restructure color.decorate documentation
Date: Sun, 22 Oct 2023 22:44:27 +0100
Message-ID: <20231022214432.56325-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231022214432.56325-1-andy.koppe@gmail.com>
References: <20231019193911.1669705-1-andy.koppe@gmail.com>
 <20231022214432.56325-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List color.decorate slots in git-config documentation one-by-one in the
same way as color.grep slots, to aid readability and make it easier to
add slots.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 1795b2d16b..3453703f9b 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -74,10 +74,25 @@ color.diff.<slot>::
 	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
 
 color.decorate.<slot>::
-	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively
-	and `grafted` for grafted commits.
+	Use customized color for the output of 'git log --decorate' as well as
+	the `%d`, `%D` and `%(decorate)` placeholders in custom log formats,
+	whereby `<slot>` specifies which decoration elements the color applies
+	to:
++
+--
+`HEAD`;;
+	the current HEAD
+`branch`;;
+	local branches
+`remoteBranch`;;
+	remote-tracking branches
+`tag`;;
+	lightweight and annotated tags
+`stash`;;
+	the stash ref
+`grafted`;;
+	grafted and replaced commits
+--
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
-- 
2.42.GIT

