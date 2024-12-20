Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8615211A3D
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699531; cv=none; b=eW7xDH/DWJwPpCLbPVABnibyjp/koPkfiretMqbYvoqA4Gw54F6VtnOUxhEox6tpTbcjojgGLVuR/Jn8tof8lHwSoqyq9x/SOMetUCXji+Ggojt7iI/zYDUfx4jRw2P/8XerPUk/nf57AqJog/m8rmXEXdee0ISeZZEmg9L2pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699531; c=relaxed/simple;
	bh=MVnSrUvioqFI4KDF3g4VqBo9X2jgtmIqyx7foJhiz3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0KYAkz+whgIrkSbcOlV5vRaC89DMFfXdduy2rlXPv5Q4msWut9rjl11PNa3tRS8ViE6HcbLUEhst7jKP7x7Htxk4iPgtrH7vjfkfJ957DUY4QjKeLF9ShGkURajqNn313w1vSRmle2WtrZ2RQ5IvM1B6YFZrLoSzvZ19GHrAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+aWvtaA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+aWvtaA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa67ac42819so271909866b.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734699528; x=1735304328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGN8zYgDD+s953Dby9uj/oFzjOmgZ7Ra3WMpKF70POM=;
        b=C+aWvtaAhgwEN9iBSS6wKyRQJo1oXb8qLHNaIAOTBCGp46iiqxKUINfYa60j/2puxV
         i9Utegjaejp/jmbRk4KjVzLPZty8NAQNtTloCq2cW+AqfVUTHnX3BZSTJ7/GSfU//wjG
         SfbmmnsCOve4rda70wPswtRAZ33+++ABI/3lujMEP7QGo0krh7zLlcJtu2ftefraAXu7
         CoAG9KYHzsek0Zezq/DXuDWW7pzAlzdIX9pv7gcNwdIrCy7qr8/LBy+blJtQ8/mjHh/K
         dz6rOKmGJY1burjQtAILT2elTaSiQHdVyih1RZvtSa3Y+jTnD00xbWDJpiIXFsjBzp/a
         LSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734699528; x=1735304328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGN8zYgDD+s953Dby9uj/oFzjOmgZ7Ra3WMpKF70POM=;
        b=VNd0ZoT56VRQ9d8Wt1mZ2uNaZ+/JW6+Ire7KOMMz6E2Kk5gINOZKhQ6rs++0eKJpjT
         wonHRUGzoJemKFVNeD0Jix8oVfIcWZZcs1jUb58O2HFOJfr1wTJkch1b3FxmbNlNNNMj
         5CeWClFypkM0o37sFSBfDjAoFDwlFF/59Y4ygtie+gcdc4yzVq1xg1o2FjX4DrQHoNyb
         sv9/hI9SCKqjnctoPWIUcTJQc1viPsTnZrw5428NJsTRFfr68JeLQiQ2qQMjBAQwQpYM
         dI4k/tcpNqfyv8Mc6Q76SBXo8TuDkwNG1+S3FPhhzCuG70YxsvkG6UaBCrUP8PhwRtyX
         0vPQ==
X-Gm-Message-State: AOJu0YzVSU2dXQJ3iqs6MPZ2h8ZzLg/TbJi8HWgiVBed/c9j5eCT3ffn
	dVAbimwMArOzcWPMgmXBhMopuj+qcu0sVmZH/CuZBMJ5SZnRNTMS
X-Gm-Gg: ASbGncvTgSgCwEd2Rh5vutT/+Vvh6zT4NZEWgOBpxNGYMi34YLezgLvrwianwvDjoeu
	V7/jAyn4tN3DDNcmwAJiYLd1qxXyNUnuijHoK65Q409TEJIvedrPCQ4RIqaIlW2exS1RaZv34X1
	SPW6pycz5M8y56s7al4ibMi4HddlYhQHkxXNYhZ6DrfQX0kDF+t+emYDdDOU1qL9FUwd8zJ9Tut
	Dv/7VPi7obkXz2Wrsom+FNUSPQP1cstOMwk0fd8bSxmb7suZtB+O6LPx0u37ArdhMKHXA==
X-Google-Smtp-Source: AGHT+IGcNRzfZYz6pEjz0k/PmvrhNbch4mQ2b8roC9xzUWvZXrIodv5RwGGaNfNAaq4Wb8wgQqgVEQ==
X-Received: by 2002:a17:907:c26:b0:aab:cce0:f883 with SMTP id a640c23a62f3a-aac348c41bbmr230116566b.51.1734699527857;
        Fri, 20 Dec 2024 04:58:47 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06168bsm174462766b.173.2024.12.20.04.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:58:47 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	toon@iotcl.com
Subject: [PATCH] refs: mark invalid refname message for translation
Date: Fri, 20 Dec 2024 13:58:37 +0100
Message-ID: <20241220125837.2774153-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xmqq4j2zifmy.fsf@gitster.g>
References: <xmqq4j2zifmy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message produced by `transaction_refname_valid()` changes based
on whether the update is a ref update or a reflog update, with the use
of a ternary operator. This breaks translation since the sub-msg is not
marked for translation. Fix this by setting the entire message using a
`if {} else {}` block and marking each message for translation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Since the reflog migration topic has been merged to 'next', I am sending this 
as an individual patch which applies on top of 'kn/reflog-migration'. 

Junio, I'd also be happy to re-roll the series if that is better.

 refs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 58e543ce39..9c887427f2 100644
--- a/refs.c
+++ b/refs.c
@@ -1255,14 +1255,22 @@ static int transaction_refname_valid(const char *refname,
 		return 1;
 
 	if (is_pseudo_ref(refname)) {
-		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";
-		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
+		const char *refusal_msg;
+		if (flags & REF_LOG_ONLY)
+			refusal_msg = _("refusing to update reflog for pseudoref '%s'");
+		else
+			refusal_msg = _("refusing to update pseudoref '%s'");
+		strbuf_addf(err, refusal_msg, refname);
 		return 0;
 	} else if ((new_oid && !is_null_oid(new_oid)) ?
 		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 		 !refname_is_safe(refname)) {
-		const char *what = flags & REF_LOG_ONLY ? "reflog with bad name" : "ref with bad name";
-		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
+		const char *refusal_msg;
+		if (flags & REF_LOG_ONLY)
+			refusal_msg = _("refusing to update reflog with bad name '%s'");
+		else
+			refusal_msg = _("refusing to update ref with bad name '%s'");
+		strbuf_addf(err, refusal_msg, refname);
 		return 0;
 	}
 
-- 
2.47.1

