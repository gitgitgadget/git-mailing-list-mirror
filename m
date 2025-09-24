Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822528725A
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749074; cv=none; b=P7k/9CnA5cqUmwsGVlEm0Hf51rq5o35w38vBrX3JSWNnj5ItV02BvvZcdWvq3LmIP/qNi6shrYx9guJ/orbthzY1v4I5tfpcmFoTR8TtS5Xa/8SIjb1bzr7y3f8GZGmDeYRvgeYSMeaNokY2dDKVT5Po4qRsXiMQZvlhSyunl0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749074; c=relaxed/simple;
	bh=rhL7z2JuUNObAPJolsKbTI6C1GU/Lgrn+nn1ssbaLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMjmRoQDbNKndtGrxkqLF4b4BmEtj/c3zTPt4lu0U8BOzOYSgOmZR9i+PvZraOoa+QITOuyzrGFnGjfXUnUev4o+D1ifKLFmd+QBV7j53ANMVsMuNBOfBYQOG4t0v6gwSLWD6Wt9+XCUjw4v2eSK6CBK2x6qv7OeiyxMdvCTr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8FRTd3e; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8FRTd3e"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-75871cd9228so236534a34.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749072; x=1759353872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=E8FRTd3eA4eX9dKhPHZ6lbxucv5nV0ql/nFUNWDkI+ud07hSg6B0ocri/fTDMTB9jX
         BBuOmVopNMXmFfnkWmUFZBUqznAPgkqRXAnM6DGYtXa1sYZp713Gx2gAuw2KBYLcKfES
         aeK47TniVvx9/ByA654cuUoEfewg4LoMZ7Vo8f6cQF/rNYiE46xUNhK2RzSPlouuR7xL
         o0Id3RfN/1OmjSPF6A3V9BE4UhltS4EXmmxknTXAbTtDQ4xhE09X98CsuS1Akz6btNc2
         oc9NgAhmD0ADJt5xn4a/fPz3iCKYKZe9keDKjOmhZ9wJe5z4cJwGwiYc8ftpkODyof9s
         OtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749072; x=1759353872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=Ntm9BudpyR34jcwrSZGL7UoiD99kJ3KXZdCk8XOjPZlcxDHwDY0cWlEx6wdyn+s+F3
         6qF0ggxZ5NtLZT0PgU99UFTHO1ks34Zoo1jHdmJxGo/Mb7lw5nl/o72IBnVaGKOhbLtv
         uMvwMc4zc/HBBMvRECQfv72mxjFvEGhKNMYOpyPEb2jjFwq68CWDKl3YNb8u3X0jHRYZ
         00W7mDllh6GfRxrUpJmCY4pWyzuoGeHWCMZEkuvBRffFiPnyhhZE+ciB2J5uzxBMexlL
         IEFlBVULczYynycZdAYzitkx1TlDyaTmWamT12nLDiFslleF1Nen2hU+CsPxShubMLBp
         1v5A==
X-Gm-Message-State: AOJu0Yx4Bl/yTJkCYmdjcRgIElj7TYCVEDD2VkjH6wzx2NUTqwubGwHw
	lr0SbUv1paDQ5YnVYHT/J0nC30/mdZqdFDy7tHIIuFCwkuQQmgyfM110ya4Msg==
X-Gm-Gg: ASbGncu3VaUDEd1gMxGL9CmxLwtDLVPTzdjf/c0q4JFQ/4CDG7GPMuOi0ZaeHOon+Ae
	HJ0QDFSfnkYCImDuohOPIyFLVsZVmMUEgD+tI6DsOBEsE39X1bFX8TMW914NHrcndGEeS1vJvyp
	zg/appl3YjPbPMEIwlImS5BuEt6Vtv9v428LdQXMK9DHmANGMK2YM1qgGC/E5H974n2+sSPzeOd
	jpbe1kBhbeij8tvPj5cP436IfXCgncVJJ31K79l9Au9NGywsvJSrPh2qK+hgUHi+HwAfk7A2bUD
	5zNeRsZgatWS4OFOuQIqjwOeIeOUYqusItI7fbFa4DXXoyAAmqSxH03a7eiiVVufZluwpVjnCcG
	MMVjwgl70o4irzEk2Fu98sIQlYtPTPb0=
X-Google-Smtp-Source: AGHT+IGS3MVEtMAm0HFC82OcRFHjKshlfDxIsZN/q/FPBp4GvmOw7pb4ExREzTCkbRkSSNBlrCUhuA==
X-Received: by 2002:a05:6808:f93:b0:43c:f99c:c9d9 with SMTP id 5614622812f47-43f4cce5d2amr776466b6e.1.1758749071864;
        Wed, 24 Sep 2025 14:24:31 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/6] builtin/repo: rename repo_info() to cmd_repo_info()
Date: Wed, 24 Sep 2025 16:24:21 -0500
Message-ID: <20250924212426.2930029-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subcommand functions are often prefixed with `cmd_` to denote that they
are an entrypoint. Rename repo_info() to cmd_repo_info() accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..eeeab8fbd2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -136,8 +136,8 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix,
-		     struct repository *repo)
+static int cmd_repo_info(int argc, const char **argv, const char *prefix,
+			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
 	struct option options[] = {
@@ -161,7 +161,7 @@ int cmd_repo(int argc, const char **argv, const char *prefix,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
 		OPT_END()
 	};
 
-- 
2.51.0.193.g4975ec3473b

