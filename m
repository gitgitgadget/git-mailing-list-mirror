Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FD210E1
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078627; cv=none; b=AWOQY3T4PtpsabqjJxrd36QU+JUUDTMPZgMsOaXTgamNoG2reO0RVGXczsnQIHa+rHkwrf2MKI9/557DR/mDj9QZLLqmVwBbtiqSV3ogE29yW0/IEM3Uf57Q9J+OE/zWYyN1j+PhaBWL0f/01PLp5/dpPXaNvZAf4X51HxnWGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078627; c=relaxed/simple;
	bh=iEGxSaC1BntFeMIp3n3obcSGfiHVUL352jX7ua3DwLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9+nkc1KN/QHYY7rAWcswms4jULBGyeIAYaLcj/aZr/Ui4Z/UJZOTsXT9+dIfZjziF5w/aPydvvKiko+Jd2hvefPhG4SHSzKqfCG3hwDjW0fy8Wyjg3S2GLvQycP/JjCAqxysxpbGnOos2JGoRkHYcPOE34m0R16/7IaQqUUN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=tgpywXHn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="tgpywXHn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2849282a12.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1708078623; x=1708683423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW0HG1x4H3DIiL2MNMPfCXPQgTQwncnnc3DFrilCLP4=;
        b=tgpywXHnr43ZjWMqPEUgw88vDN+VxRPF6v/CjK8FXc7vpOYgu5xGikXTT4RlKsQATM
         ONVIxRXeROmO+o37u6DFt8gkLxR/qMggMLCq3JDqHxl68NIqXIV5yFaXpzmHWJPSFZ6M
         Pt176sNcEOna/7egflRWgnEFWmdiGopDm34Fz0ngHy2tI/pvjyJsfJMV57MsnZxvuEhI
         syhCuJ0glQyIGCwSnNLzbnx/wL2WLaYsSSHZ2a3WIl5SyvLBVz/bpBgfH0/eJaJpKQUi
         m8sR9DXVCFUIDJaBYgS7A46phjyTr3k38zrk74fowDGf0R5mTv+8OEkaqNXnLXyM2IrC
         Gujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078623; x=1708683423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hW0HG1x4H3DIiL2MNMPfCXPQgTQwncnnc3DFrilCLP4=;
        b=AGd48b7YVq+siZvA0yNY6x09LGH8ccjzh40KEHdBwGxd63U0V5NuxKgGfV4m/x6/Op
         AiXc5MgpwBHSncRCSscwebwjRzFXnoBHjmIrBMj8UBzLJslE5sFmjZhcY5uYMOjPZNxp
         wjLBN0Iygv5ezmSL/JsvHw/MpCqDCEL2Speic5XxaBNXB/eFTBxlf+30VwwbVv+wbsgW
         zgnVpzRPfJvgRZIex+VDZGPHpJ6TemsYnKlJmO7FtcyF/ZWbsYSm31jxA4IJlSQ5kPk6
         1P1ewuJk8Q1xmjS0Qww/mWGuOY9BbiQsafJDFOMYq14N+XvFLKG2Z3kIAjtvsBYYHKGS
         vbwg==
X-Gm-Message-State: AOJu0YxsTWGm6Uh+odVdgz/FW2xSpZxF3MRRnK8DFntqx+dGFPqqLRmV
	E0deIcsdAksrUYsMxA01d8/80R04LQVL6d4tdbLHCVQdxQvfINmWp5HfFVnqJ5Kat6MmWMnrpO7
	aUPaTPg==
X-Google-Smtp-Source: AGHT+IHQB7xADSUfgo2tUdH3L5whMyFes89aYJU1ReNpyAyosI+HaDG27cGP0wbSkY9yH7b1LNiSNg==
X-Received: by 2002:a50:ef0f:0:b0:564:e4:d663 with SMTP id m15-20020a50ef0f000000b0056400e4d663mr415782eds.30.1708078622853;
        Fri, 16 Feb 2024 02:17:02 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7d9d4000000b00561fbfebdb5sm1337682eds.96.2024.02.16.02.17.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:17:01 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	newren@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [Improvements on messages 5/5] revision.c: trivial fix to message
Date: Fri, 16 Feb 2024 11:15:37 +0100
Message-ID: <20240216101647.28837-6-ash@kambanaria.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216101647.28837-1-ash@kambanaria.org>
References: <20240216101647.28837-1-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ancestry-path is an option, not a command - mark it as such.
This brings it in sync with the rest of usages in the file

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..e29aa10781 100644
--- a/revision.c
+++ b/revision.c
@@ -2320,7 +2320,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (skip_prefix(arg, "--ancestry-path=", &optarg)) {
 		struct commit *c;
 		struct object_id oid;
-		const char *msg = _("could not get commit for ancestry-path argument %s");
+		const char *msg = _("could not get commit for --ancestry-path argument %s");

 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
--
2.43.2
