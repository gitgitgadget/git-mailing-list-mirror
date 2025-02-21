Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F925332F
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164723; cv=none; b=inRz5iZ0EKKbCiOa+RUdRlTpJF9AxuoJz4gvKG7EtW7Z2FB8iWYOpd6nWnB3iqh7lM8uYqdTiMMD3+dV0q+05jnBh5WnktotRzW1gmgP4u9tRd2BMYHgwgfqZUBihVY3BvhxKtM5AaBykRfuz4jhcjtz2MrLlpFwMtjKlyanKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164723; c=relaxed/simple;
	bh=WUDuPJvUvWrwKs94DpXTw1gJShlhBTtqSvRB9qRuqt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pedPCsv75NbicxBS/YqpA4wmaEi2alB6kAg23rusjqMP1wYuslbd6VZw1OgkMLc+l6d7al+85drFtDb+q31dNuJMBurHBeNCM8tT9/HdqUIDAz4D3+PWbkHGEZNPObo41AR7tQj8IWhICtnxj0nEXT/N5D2IYcYF+m1zhoG7Eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcuwTgTg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcuwTgTg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4721bfdb565so28585381cf.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164720; x=1740769520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+Zq4FdR9RSEIcjfaw4KdkNm9g/Ip7kzz1JPhNg7iNs=;
        b=WcuwTgTgo9Dz703JVdgk1+RQ8RDc4aSEY8ikbtPeVxgMiZ3c6WB9Om5kWD61zPfg6e
         cFwpxR5TqH1BsYkAoWmc+qS2v8yGh9zSyQSleNp4WzVIF079LL/FLHa3OgS6thy8vXRx
         Vaa5asdAgmUhkpiya8rqWFkuO+T6iPgy7I32GqwHai88e7hLd5VQNURqyvKI3w7oOGxV
         YyxGu5qZxhp5cU2EAbm4LH5eYutIYCwb4rOzxPzuc7p4fdNqM0t4e66QZqingDBnqv1b
         4zdIBNUv4WVyWML6TJaxRlpNCxMWAc2ZW3EqXpxfiZGnV9x2hbcifd4r2q2aCsPifSYb
         wOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164720; x=1740769520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+Zq4FdR9RSEIcjfaw4KdkNm9g/Ip7kzz1JPhNg7iNs=;
        b=CrrHOgPmQoFqENuJOA9XUlJStT9rgVbJqqeA9+Zku5BMn6bcYHKPxyTJdmRKSUmssj
         j81fHGUlMpeoYRqpaiYQMQsbnvwl7XhbO4AGBW8ixEUDFxdMsEVYPiAe2hT3TOX3oOE0
         sLpR4Bim1O3J481PaoHk9oJ2S8bHc2gQUY9VIkADmXcUSWdEHU/8/VDlXMqM0OLTfh1J
         nI1EftEEFk1rFHyFOlbZDUDBcekEclbgCY7ZOdDWjlkXlEq3inReBMnrsY8lXgEFHBTN
         /oKIo2tOEuRPoAX9Co3lFgLcctTPOEkcnqDOJ5LgWkiFI0iisHm2cHKs7NCnzmdtISRc
         oQjw==
X-Gm-Message-State: AOJu0YziKTX3CNgcvCw+AxaEykynnXnBiF0A2xMLLHuAz159Fb4OWIjV
	2U+NNbnO06K285FSkvIKWRh0ATNoqCjmVIyNb/E6ibHgrH2ABbYjYvAAVzT1k14=
X-Gm-Gg: ASbGncsPkU1SJbSGbCatO7xoGNTUwgpfluthQmkXa4+dsGOJIWUpMBslArEAWRh3S6v
	rzcxknoMWqztzqEtBJcHrOgn+Fblg22+Zc5dIORDDnWHREnOBCQzSV+XWtNlVjCTCjSl5kkQ2Rq
	6i4vS+Im+docHO7kRTxGWxW44hl0/mYpvdJMiXPUmDCnLjcdbBraR4JPmaAntNVUVD8igqsJEEK
	gk3614Xj3P6E0JP65VvREf/IrEzG/nwyOrk4lV/Df+jvl3WIiYITji9g3BeQcjD0nM332cHXWBN
	h4iBPX7vgELrrv6U3HMG+xHTJ1Vy3mZb9PORJBUOpexhmqU7Jk2q
X-Google-Smtp-Source: AGHT+IFM24SOSQInHugF4htJVxWYH+cbGmFVFB9Fa32Z2yDyiuQwM8fQk6nHszu6hCfSb7jiov6UJg==
X-Received: by 2002:a05:622a:354:b0:472:1ee7:d41 with SMTP id d75a77b69052e-472228afd86mr55230131cf.9.1740164720188;
        Fri, 21 Feb 2025 11:05:20 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:19 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 6/8] serve: advertise object-info feature
Date: Fri, 21 Feb 2025 14:04:47 -0500
Message-ID: <20250221190451.12536-7-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
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
index f6dfe34a2b..92fd26fd0a 100644
--- a/serve.c
+++ b/serve.c
@@ -68,7 +68,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -76,6 +76,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.48.1

