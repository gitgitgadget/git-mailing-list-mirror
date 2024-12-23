Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C521D7E46
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996360; cv=none; b=GPA6qV0MeJ0uT1KePbTUJIvmKIpiLeOoSk9LtPngx8DmK1PtpnTvN+oEW0gsPkUGcSc12A2FUyqBtrCc6nNzhQBPQI0ZMn7azxq+ZGmMTLhAwYQ9rEZuVArqjE8dXtiU8NX+jvo/5PYIB/IIA9L+zsr/+VOPiI0jHjB+kDnRdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996360; c=relaxed/simple;
	bh=DgBA291+j6ejZVIrtQoPG7txaLVr23L8sLBk2ll5bUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZd+VvOORycfAW1O+5o21PXkv6JKzRk02T/8aKz9cvn2NomWLpyBgNnMbxJuesTJLRkTcT+oLGgUuusYmaCe92W4xjBbmLFZpVuGTfAgsm+tTC/4i9sigJX92pBRGVj8LKn2lNshvVATjXlOUZGAzLm3xkI2LGoIb6BKMCMEATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjHA53MO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjHA53MO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d92cd1e811so49901066d6.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996357; x=1735601157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq2fqDypuUUjO63eoWLT+d8CeGIKnq0xPOyYXXa21L0=;
        b=VjHA53MOTfx6rr1jjiHBS6ecqs+OE7+y5TkyiFdmrd85ltrbooKLA9VxDVGVFG4Jby
         MSy5X3alxwGrXPgbtWBqiDoW5HtW9bmszGSfZw/Va6JJEgf8a0giuNBSS0pBtBueKhvd
         i/pSmMdEMRR5L4WpGpjZ4uONasr5ddFX+Vge9SEUFk7Lk/4LlUZinALzoecsF3TjLX2H
         8IjPk3A868BpXIWrBRF0u4rLYS3JgSeoRn3J2axn6M5OHO3GUXAojQ6WYOqYodJzPv3m
         qG47+4CoxA6sn09Ln/BqSWB8ZgeDdIusAKgxroyNjCdYlCanH0Std8o7ccH85wQdAfTS
         wyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996357; x=1735601157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq2fqDypuUUjO63eoWLT+d8CeGIKnq0xPOyYXXa21L0=;
        b=sOXMjD4Dei3LUhbxcdmHcxJVyTk2dvCaBUZ2H1a+A/4GquxDA6RI2S7aEUnqeiOQuL
         q6WK2A3LWiwhOdTs2Ymx0VHsBvryM8+j4Gcrt7L/03UKbrwWWf5oGczxMRm8I67vbmdB
         4k89l+CyS8mVCnXI3qF0irWaqObPP3HmeUyt40khfb2f9dpzsmeqXLqCpf5+0aAYl+5L
         gMt1Vz28m2VAYDM8B8qy4UEsOdHEZAbvciUtrQoTRa8CP6IvJUEbaxNRqLoSuXCqxHq5
         HPYwR6jSule8fZIDDQRVecxuGKLfZtNT+rO0zLkMxYaqqfzi8TONhCSCDvZ56dWH8O8L
         By0Q==
X-Gm-Message-State: AOJu0Yyqu39Vnb+RIugeMEAU1LbDb+KD1ps6fMeMzRxyFY0indAarVIg
	if24Ac6sNZHE0rVCOV7xfs1+hhEtQaDnxKhjhc6iNF7ISVenwplLzy2HW/3x
X-Gm-Gg: ASbGncvPlnymDLVaedRCwARZYe8r7d6x5RJONMG6JLAdf77wr9fO5BLU5hRWhhJE7wH
	ZjeuCc2mZ6IDzTscwFpPKyMpPfT+aHN4mxlUyD7wR6i/aHcAIXwGC6tCLbqnMVf0XDFAIaVlDuw
	2eEOM4k4mR3fsbBSR2eM2ntieDbLHM3TqjLenFxSkqp3t+5IatwhE10I4IP8ZJGPdOmz37I3nVj
	3s0ieqUVSfChd/56UWHH8qEm85QdiI2g4b1MrN8yADMLLs3pd7Kt9LUY0fWZMN9RT4SQT7N3u/g
	C3mDgZoL4uzvR2wZeU3rvFNuGUDRwuNVmfKLZcm6Nt2Ru5q7UI3QZ3R+TV9eoQ==
X-Google-Smtp-Source: AGHT+IFWohacmVW/GJYDMZVOwfUM3TQzVAShPHFQPRRiy/643DngpMEzSB7Eh2XMYn0vmq9VV7FFAA==
X-Received: by 2002:a05:6214:124d:b0:6d8:ad28:adce with SMTP id 6a1803df08f44-6dd2360e147mr252751866d6.15.1734996357335;
        Mon, 23 Dec 2024 15:25:57 -0800 (PST)
Received: from localhost.localdomain (pool-174-118-208-220.cpe.net.cable.rogers.com. [174.118.208.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm47672496d6.61.2024.12.23.15.25.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 15:25:57 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v8 4/6] serve: advertise object-info feature
Date: Mon, 23 Dec 2024 19:25:21 -0400
Message-ID: <20241223232523.76236-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223232523.76236-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index c8694e3751..7a388d26d9 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.47.0

