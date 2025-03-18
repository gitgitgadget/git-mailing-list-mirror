Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27CB214222
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321003; cv=none; b=Pqqzg3LWmR9hQurlkOS2yF845hseB4P2WR+WALd/HntmDbUXjFzc4GirsoF0s8Pr1fFEi4c86CApVrNYpNL/AQzaVdVSLq16yUB3uDc6R6L9MqWn829LsB/q9Dy2fIt8BNV0OE1mzqJ4mceEIwVTZAD+Z6m9r67WV71kmPBRTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321003; c=relaxed/simple;
	bh=qhZE+Hq/9C1A1BytGvjT/NC2rzmgMG/a7oLndbe3oYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CBpuufpQbRAtavBHxl7+o6us76vRpTBdLmmTbz6vBu8I5f6Sm5fOfoG/yPL13yBgFCHHqGdfpwg4JQlEDJO/tRLew9z4ESdz9FMcBZJmCvj+RwdDneWB9jdwhexbhSSOPfkJ/ufn2yw/rSJYknyrzpkbZw75vPgR+QpC6iYfJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=n89QSRa/; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="n89QSRa/"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 52II3DIQ021995-52II3DIS021995
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:03:13 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tubHV-000DcU-6v
	for git@vger.kernel.org; Tue, 18 Mar 2025 20:03:13 +0200
Received: from localhost (194.111.69.129) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Tue, 18 Mar
 2025 20:03:12 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 4f1b49a9;
	Tue, 18 Mar 2025 18:03:11 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH] format-patch: use raw format for notes
Date: Tue, 18 Mar 2025 20:02:51 +0200
Message-ID: <20250318180251.3712-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=sSdD0OBpvV4uasJAufMMIf95yKv/swiHLeGqZ7ZXQ+E=;
 b=n89QSRa/GWV0SBnO5OhZRnJDgTAtQk1sd+MCsP3NrlPS3zD4nxiffcezH+WjizWHkZMoeOO8dItJ
	HXcNKxIXmOr4H8e47GfFjJrkQDIH/ZHIjX1ZVPERd9+zfXuoktKhvfCqpPp4Kun9HVY4ehKqoKzs
	jruO2Daiv9f3+DsqaiQWcTma/pTxwdAIoMrTGp3G8XO/37vU0zKdQEq9m+2I8pSqzxXW779jfnMA
	ddQ7rSUD47Mns9oVhSz0FWsUSpVR+BB/EGxyDhtDAT5sUYrRFnfVxEnjV1guv3y4zokjbFsIJ7R1
	IuQmujFy1BJYUTOV5gAt36yxBp/bretJPfYyQg==

The default formatting of commit notes by git format-patch --notes
doesn't make a very good fit.  It would be more beneficial to use the
raw format for CMIT_FMT_EMAIL and CMIT_FMT_MBOXRD.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 log-tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 8b184d6776..c40a7599d0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -857,7 +857,9 @@ void show_log(struct rev_info *opt)
 		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
 
-		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
+		raw = (opt->commit_format == CMIT_FMT_USERFORMAT ||
+		       opt->commit_format == CMIT_FMT_EMAIL ||
+		       opt->commit_format == CMIT_FMT_MBOXRD);
 		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.30.2

