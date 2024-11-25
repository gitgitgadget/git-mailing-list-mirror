Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B713CFA6
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513004; cv=none; b=jlsSe4LsphhE57vFhzRqE7deX/NlZ0d8M3yhtsMLNa2Ec0/yYgOIQkj4iamR662Xul1oLdo0sWczCiVkaYHxMPYS2FMVv1bN+DJlTHR6ptgXKzXZMOgJIbIFzmWtHZa3VUA99lQNs9xHDGEXoLYbhjpa4uGbjQwQpeUo/vkPimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513004; c=relaxed/simple;
	bh=yjyz+Vz840lW2No3gACSbRZE3MV5qia5BFfczHhmR5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7jnx3TnXPvKqEU8mE2NKHe6uu9itFXSVJ4enETi2w4rRTc+yrdrygMtU+S8FjLjorTRBc2EUmkFKl2yMhX4Y9KkUhc/HdBcV0EUPHj8+jZbO8UbTSGiGniinupxKpuVZaeh/5aZp4MzO9S30vY5MwloXrvXJvKs+76zzK8kBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNsARKK4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNsARKK4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b35b1ca0c2so582239785a.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732513001; x=1733117801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=PNsARKK4E9aOyE+Uismnf6KxyNy1yDO7E/uCIJOCH7jE+ELVO7vniOT9V9iNoxPFBQ
         ZLBZqQoCMq7TyOTBx6VDkiCe859XAu5VxEgh3/CYyE0eUjePSQztaLpraPLjlhIUkbYu
         GPBGsld0kb75n+9YMn683SRgfHJAh/judOjnfCj1xMiESeQDaBXVOSxeCHI19aifHEXb
         qorSqZTUIAOV/lzFns0ccwBB2OQ8kU7YwFUkQEYU67v+uFIqaNPMUFK/aI/NbEbhzvVT
         XfS8Y8UboLteGib6WDbACG6afx66X+4WkMXG4sxtaaDUV964GgXQgaPmOgtPEr2uow6N
         kAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732513001; x=1733117801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=XnHAjR6o27oFBQJ3hRI9/Zz/4AJarOsZpCGSqiXk7RLiwpehsKtlxwRsmW0IBXZHNF
         6h81yxuZgJZSvfNRGmGEwj5d/roR8ZRNm3oKejcd+IFK3cemJhNN/meGvOUgAXCxkcWN
         R658gjJ3BQkRbAUptMhf8GFzompLE04qPdNBYnnmdLwlg/sotSTsNJO4mna2j8WTNMSL
         LST2qJeM7EGyHteUJSShgdyO3sAhHZsP23O96SJj0qyojgQtRQucVN7TMZHP7HXE+dlN
         jgWfnqXBMSbp6y3EMetqXwvvqFU8BxK+xhk2hw6ncqD8OU5VamoH605mMrkM14nDmIT5
         G1mQ==
X-Gm-Message-State: AOJu0YyC60Qtm2tNWITCBOJ8gwz8JCkyEVi7spSCqlCAZ4HaAxRmaUQ/
	REPavJM2c5mSphDpoiTcJrtpHD7IASEAK1piX+bIcTIbGGkGDsVdpdM+3Pv0
X-Gm-Gg: ASbGncu5fCMo2KFXqh9hY2v19We4slC/UU9gDXJCl61mXBo5QSFaq0YKjuXOfyamvge
	noIYLkC4UJulC0cc3qN7zAfbRl6f25jLimtId68tiJBySifSEPv/WQEfJFD/NH32qdrLYZNnxgt
	ggWWqFE58M/6ogKc1bu5f8hy2mvcvIs61/De1pYq3KEBgMQZ4zD1nIeVPb3/pn3qdadA1O08HG/
	ozJhs4ebJtCnIZKBaOjtUEcv6zl1h6/4Fo4X6rrBebAAot6DfFwcwz6BzDZCZsgTWJNFLm4j0na
	ew==
X-Google-Smtp-Source: AGHT+IHjjaqgfqamNmdn62CugCaj74ZFfUpr3P8j6DJtumY4jkiz7zWbtfTlIERo9llwocXvqXrO1Q==
X-Received: by 2002:a05:620a:28c9:b0:7a9:aa9e:3a9a with SMTP id af79cd13be357-7b50c141832mr2798104785a.18.1732513001327;
        Sun, 24 Nov 2024 21:36:41 -0800 (PST)
Received: from localhost.localdomain ([184.146.186.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90534sm320522585a.25.2024.11.24.21.36.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Nov 2024 21:36:41 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v7 4/6] serve: advertise object-info feature
Date: Mon, 25 Nov 2024 00:36:14 -0500
Message-ID: <20241125053616.25170-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125053616.25170-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
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

