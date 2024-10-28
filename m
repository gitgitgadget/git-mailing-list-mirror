Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87141EE00F
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147723; cv=none; b=haswbg2Qg1UyUfK/2xhfyVY8rmyN5r0u4D8MTjCs0NsW+AhK3bgHwceiwsv3T3M1MfM0egGFCzi3usRRJs2iux5IYlm3SMk1+QFhokRL1jlVEVUZJAeQ2TwCBkkraWzUgFt91rMzYbfpysSDj+XH7n41cOe+Jzrlajo+8r5cag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147723; c=relaxed/simple;
	bh=yjyz+Vz840lW2No3gACSbRZE3MV5qia5BFfczHhmR5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1EvTDhiTVIp4or+1p2SO8hIT49qZc8Gv/TM7+5F3+qSm0lzUoUUy8c0J84uEcbswb2CrcsnDJkFg83Pc6TqRAColdmtdNRZBE6LqMlw/trraLJ99y3n0GuehUI/7Fq84WCMdMPimYqNbWOckhP+jtOBOOrFKvydxx4IDYwal40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUidnzfh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUidnzfh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46094b68e30so35525311cf.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147719; x=1730752519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=KUidnzfhzdrG5Sgz+NnHie/IrMvFrRm1lboY7OylZgKaO+OUFzRBy+eh9fh8KnnQPq
         9Xn1JtP7sEWVZpnpye7mDNm1hLRzcbpfdI6dwbJt3silA2xnrSM/zl7Gz10FvyaLiVHV
         jdwxL6cVFrV8Hz8O9BCrPINL9+lVmL4zchPLNJxz69nui1duRwPw/5m6AygZoFjwNs3N
         g1GrgRL6Ios0tvuxP632O4QlL4Gm8Urgj11EnyTK0rT4Oph4/nq07lfmrtJxidXa/mdI
         2gt3/JEu70XZjbrFX0fEuKXBC5B5YPEZxoj9tbCZliRPFIP0EXySYdgD1tVBhGQlQ7aS
         FQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147719; x=1730752519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=LhkxIc5+yQ7tUsshK5lQBHbuFba7W4oeVEPcUkwxYih9V9TLbVgXBJDpeFKunTiRbY
         J5F4pUxja/alAD1hMqkUKb+dK9n7r19C6CDjf+4TjVHXEZivCpwKagwwqWvfgEDjsUS/
         zhqTG6g6hld9ibzXtjEY1igMaDYmfg0gGBBZw6WkDT5zucS82VyBIZNZBpLqFXWmd++T
         8a+X7zOmodyFP5Y2GHHb2FSE5ASlaaBEa1KZitwD5zfKguPHmeq3DCMw4KdNKP6NQlyM
         SCyXUmSbgNbdkVJ+vi9fjfApCyaPUG+QzQ0NqFXTTXOCn3OVNabvIkANGpEmt/QFhk8B
         J7jA==
X-Gm-Message-State: AOJu0YzyHmbfotb62eW5KiiwbjnLS853p2jnO0xvflePVqgkdVJ8Xiaq
	o/hZGOikmiEJ0l/dQ8yDRJtSjCZHNsHtW8G9iDpBb6c9I9k1UyzVWJEh2ilq
X-Google-Smtp-Source: AGHT+IELs9/Cl4VdSR328OBSZAXBdvmFSjElVJHlaSLTLyOJ+SKDJWRqCRm8rDGyIaB8B/x9+OuWMg==
X-Received: by 2002:a05:622a:c5:b0:460:933a:f6c with SMTP id d75a77b69052e-4613c0303bfmr163867311cf.26.1730147719575;
        Mon, 28 Oct 2024 13:35:19 -0700 (PDT)
Received: from localhost.localdomain ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228c099sm38215791cf.46.2024.10.28.13.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 13:35:19 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v5 3/6] serve: advertise object-info feature
Date: Mon, 28 Oct 2024 16:34:54 -0400
Message-ID: <20241028203457.19715-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028203457.19715-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com>
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
index d674764a25..c3d8098642 100644
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

