Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E008481255
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908343; cv=none; b=Pk1BcTiCmwHKY9L0ARc6yG+44QfGcfPRmUYWqgBwTXutspeZnyhbLijzfAHX3c01wbdOzF5MUiiv0hehqZSu7euIamBldCjwqqgqP7lV2nbmKpu8Ps5qC6DPw2SZiYA/s7Wm9Wu+auQ9t+1Rv1uw6cxoOR8mHq+/WeB6YJYDoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908343; c=relaxed/simple;
	bh=DpsWonewEo/Jm6sm1eDeSwiSwUeCsTSF6SSDy39+qbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwv6yRN2MBYWLZ3Xe4WkCb1DMR7+MfJMt0xHG8ZVd5K99dVJ6PtV4pIHhZY3aoiJ/71pS/i3ukvzXBQpgbrV6D1su1jbB0vonTgpcqdKVANi6kbQU7eZbtCY/OOA23YCw2AJbZhL6paiodQK80ycJH/pBtt4lTk64nUxJhty2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXz9ulAQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXz9ulAQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so4420055e9.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908340; x=1783513140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZzE+fTvBfgYA75KM1pJbgpabzpzE521x2o7m3YjHsU=;
        b=fXz9ulAQDwroBayvNhRoJchw73yNP96VH5Zj27Jxd/osZu1364WstQNguocv3QUfJe
         BvaGByQcklcCAwnAXWPuU1I0nQVjiqJn6C268sIPXLpdNqtBBHoSSCdBwDnrNbV/cW20
         //tXEZnHvyVaUzk8DXSmYY1Zip4z9mTPQJCA4yF8Hp0ubzT+elHuiK26DYPNV181m3gc
         J5Hpn+GfWyKqQLCXko4bHxZTSQZTuP8AUrF8rlZ/chpWrOYCUweoYoFsk9Gy9slg+OnL
         etUzoPjDcuITYC+78YUdVmlLDLfUA+Yn+23E6crvRxy2GD67l3LwQ+6xvLO5rFnQCIos
         caRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908340; x=1783513140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZzE+fTvBfgYA75KM1pJbgpabzpzE521x2o7m3YjHsU=;
        b=BrYz6OBXEJ7sZAE39lrj/v+YETfaWzBNwG9huYvmOpDjbVoCmv0vXXMNPaNeqgHbfC
         DosoSsDeujNpwOEMYXLRVTTiZ1nnLmH3rJ6dfSVFhF+cEKnCfVwVWmT3RY55HSYrwzaP
         nWiS17dKhbwRe/8G+WGD9cWB2eO2Jav+pfjl1hhUmlbS93GrGg6HrhJhtiP0ux6s3jLS
         5WFWGh/Vv68GHZSJfmKa3JsL9qszuGotOKxHP+S4iM37Ur2ecTl5A5Ugm7xWRR5WKMUG
         KcR0pPtX6tT7lbfrwtCoR49IXoB4xE/ls3UP2p95jenyjbAhFUN0IRoakvhyKDiHfI0t
         8iYQ==
X-Gm-Message-State: AOJu0YyeUdxS7jUvqYPBG3MLi03bh0P0rE/DfenPn/h6lS0LgMtP5Z0y
	e2yxcl2VDLR7sUrhNbIFU9llnmwdI592CfUH0AKjN+UfXx52zic7e+jEl0skAXmn
X-Gm-Gg: AfdE7cnkD02HKYEsN5OSO6m8G+Zsc58iyEsLOzDG5iXPcpJXuluhLGejlhpg5u5OSfj
	hB9aSpIBuQJWVEp9n3x9sOewf0akeD1HAjvkWuIIhW09a8pTGl2Sa0/oDVHcnbbYiha8J/mkKRt
	c/Ob7EhKeY39zWIVp1PRGptUdg/XahY9auJ9n2WU9qzu0SZiAVmfM495jhtG0mfhH0yJfhg6Vbz
	QMmpzo5JrtmCFeSD4JuAYjcK6lYqxSNMHodYgqmbtIoF2f+ueneluy8wkZD/NBv4peMiof+4fqv
	VEJj0kGh3Lc+3cmmASwP7lu/KBFHWWMLSk1gm7JoGa1GfdqwqN4wbgzaXdfdQpy0tUQivTbiDIq
	w7ZOuGxU2i0ICDpcdZZTOa/ZI1DFVGk2+yfD7r3hYjwVzdVvLY8eAvingyAZ3t4Pm2XPFIzLtzs
	7OSRHEIgjqg38VYkq7POyk8XsPBl0sBjcyFTduxe0eZ0SZYESuMWOaiZF88oFed0v6tW9CUN6bq
	PmeNIdEl6KY/eigFMrQGX9PoVoWXejydvZQXV69sik5q+iHpKLwPQ3T7KiQGtox6rMXl+948AOD
	0//sEwKeWPIMsPO24N1SR/NPBvd0YfGx65gsGO5oaVdvF7evDUBAjQLkOrkkalAhVSBNKLxJzr2
	EIAv93fkb7w==
X-Received: by 2002:a05:600c:4e4c:b0:493:a909:8c71 with SMTP id 5b1f17b1804b1-493c3cd58a7mr7071305e9.7.1782908340235;
        Wed, 01 Jul 2026 05:19:00 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:59 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v15 09/13] serve: advertise object-info feature
Date: Wed,  1 Jul 2026 14:18:43 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-9-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what `object-info` components a server can
provide, advertise supported `object-info` features. This allows a
client to decide whether to query the server for object-info or fetch
as a fallback.

While at it, update the `object-info` section in `gitprotocol-v2.adoc`:
- Require full `obj-oid` explicitly.
- Fix parentheses.
- Define `obj-size` explicitly.
- Make `obj-size` optional in `obj-info` and document the behavior
  for unrecognized object IDs.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 11 ++++++++---
 serve.c                           |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index befa697d21..f21a6cbcaa 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -568,21 +568,26 @@ An `object-info` request takes the following arguments:
 
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
-	information for.
+	information for. They must be full object IDs.
 
 The response of `object-info` is a list of the requested object ids
 and associated requested information, each separated by a single space.
 
 	output = info flush-pkt
 
-	info = PKT-LINE(attrs) LF)
+	info = PKT-LINE(attrs LF)
 		*PKT-LINE(obj-info LF)
 
 	attrs = attr | attrs SP attrs
 
+	obj-size = 1*DIGIT
+
 	attr = "size"
 
-	obj-info = obj-id SP obj-size
+	obj-info = obj-id SP [obj-size]
+
+	If the server does not recognize the object id, the response will be
+	`obj-id SP` regardless of the number of attributes requested.
 
 bundle-uri
 ~~~~~~~~~~
diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
