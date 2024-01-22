Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E139846
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913525; cv=none; b=n8W8n4e879uhvXmPb9BlhGpZZd/+5DRHz7P1Zy+HH+fZAxNv25IUsLZTz4I7BEjImLCgZWG82Z/j0QGynbwtj4/e2M1PPo4XNhwHMyJPzmxpIomH+SsMdHXlOyFnvpPie1IUxApoKmslqptBcuT4lsDTqi/nPRaWpxJJG+fX+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913525; c=relaxed/simple;
	bh=LvYpSpV/7iegJ8GtnkSkOKQohoM2V+p663yM5ZeMZR0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t9DTcSiyO90HE0dPgZNnhTnVOBbFu2qAnckKN/W7BuMdD3dYSklfFpySAJkv7SQqHFEL/aPY6UXwZTZFP5g6+KmwnnQ+APrZe0820Va//KmUgnrWEpdXhe7MQfRrqi/LmiCzsHvNfadvtnbdcLOaMWgsbVTUJ2TjwvZnLWBkP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqPwr926; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqPwr926"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eab3912d5so10024095e9.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705913521; x=1706518321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEJ4Plhkr5M7OXZ1VH62B32jcDt6qZCiVQie0Se70rs=;
        b=ZqPwr926sf8QFI2ZNA6y4QMvziS1NLjhVnm52pFSunC7bkiuCizA/b0OI5JBZGNYNH
         s6hiGelLJtEXYK7drUoCimQxqehWCj890tTVOJhpMhmaHw/fEKXghjGE8xGiddsYAFaT
         psgyHtDiER8FwSUi4h1h9umO4tgrJiMaMBH3CUTWFHtGVkKNmzXeidvlK6eKFU74PzrR
         q/dKAjiI5u6Uvu0U2t38YzSvJPCmkqJ2pQxkwHzDackaXLqj2wDX+MPUrq7xSAsvmin6
         lDIomtDAOjJ44oXPTIcZGeofdi5eQuBi9LnnYGtmkXcg2Y2ak9P0Q6xBy2f3puX20AIE
         d1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913521; x=1706518321;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEJ4Plhkr5M7OXZ1VH62B32jcDt6qZCiVQie0Se70rs=;
        b=TahO6qD91EjP+wi2/h263l4B2Pz8KdXkt3jndXk4SQZHpaCP/jaY2bT32/GbrIMyhT
         Ns/JZh4YlHBodYDqw6brY3VHyMq4Gsu8PQOqS8pChAqDPW59PyubXuLX3rSo7liDxo3R
         6OjgRQ0Vdv2QM+zLWJ5INtqiyxAA953gLftVlZMj+aCULJFnpy7oeAsFKh0xI+qNCB+A
         85je1Ak9TMPqpkUSuQmJ98UE0dtkR9309r79MWh+bNb9+uvTVYJn5sFPLsytAf0bD1OO
         f4kuHPJrtUow65tXFA9qxlzm8Sknmbolf9dlzcNw/EUDsZRBkeBnzV3JFGysCDYIR+Kl
         PwHA==
X-Gm-Message-State: AOJu0YzeTgR9bZJuQpdR87qr2dBSXMvXTAbUv+05stlhPMGbwOIO9epM
	K5+GkfyTJV7It3YkykloMT5rsUGl21vZBJtwe+I02U5XxZgP9dDjqZ8Zokdu
X-Google-Smtp-Source: AGHT+IG2XKDv/xjiwb6r5qwGo7B7cRg4DfO3BzhUZMCmZYSdmZYE4tekLe2oTsXJjouCRb1KFeb6pw==
X-Received: by 2002:a05:600c:4ecf:b0:40e:ab32:28ba with SMTP id g15-20020a05600c4ecf00b0040eab3228bamr1098489wmq.72.1705913521011;
        Mon, 22 Jan 2024 00:52:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm38501970wmo.40.2024.01.22.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:52:00 -0800 (PST)
Message-ID: <4e2b03cdd4f57d91f1993c5e89e28f9115033161.1705913519.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jan 2024 08:51:58 +0000
Subject: [PATCH 1/2] git-compat-util: add strtol_i2
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

This function is an updated version of strtol_i function. It will
give more control to handle parsing of the characters after the
integer and better error handling while parsing numbers.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 git-compat-util.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5a..0a014c837d8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1309,6 +1309,29 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+#define strtol_i(s,b,r) strtol_i2((s), (b), (r), NULL)
+static inline int strtol_i2(char const *s, int base, int *result, char **endp)
+{
+	long ul;
+	char *dummy = NULL;
+
+	if (!endp)
+		endp = &dummy;
+	errno = 0;
+	ul = strtol(s, endp, base);
+	if (errno ||
+	    /*
+	     * if we are told to parse to the end of the string by
+	     * passing NULL to endp, it is an error to have any
+	     * remaining character after the digits.
+	     */
+	   (dummy && *dummy) ||
+	    *endp == s || (int) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 void git_stable_qsort(void *base, size_t nmemb, size_t size,
 		      int(*compar)(const void *, const void *));
 #ifdef INTERNAL_QSORT
-- 
gitgitgadget

