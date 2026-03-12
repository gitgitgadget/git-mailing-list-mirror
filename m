Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A587317170
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343356; cv=none; b=Xj0dUpP6DTeqkTWCw+crQ4TYx3eY7leHjYYEQ+6B5tEUuRBZWTo5Ay3YkB2ejHKSzQWwB8e1k6kxJNlaympe1ijFB91jk5VF+PBVql3/mbz9J/cHzYblV6QHYvBMkLTqL7dQtiu4R8Yt4BC2Zvx2shZsLcTSqBTcD6VmpNqCAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343356; c=relaxed/simple;
	bh=SimSezPDUX3sWC+meBWBAnslS8/egIYa67DAQbmHWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKg3NfDQeR/hGpX3dut4on+u0FwkAlflnvL8NgXjkMfrgsP2b98HehK6rnCLZeLditi2j/6B4lYSGTKlWJNMdm2FQ+E5xbi2SW+JCNG7XZd0WzES0jIcIJIlivg/47S8kkSUnKcF6V2bZH5bYsbP4fI8yaqXeazZLi7kjBNEwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRGPj3f5; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRGPj3f5"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so1018510fac.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773343354; x=1773948154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=eRGPj3f57ibc4kg/0V8aUqFm8UvTfn/U0lQ8P+z6raTFEJzVtSoA9i0N3kciTTnosA
         bdXwx4734ps6rw4NNIbvzGRNqAxuPI3TkA609yphn56FFycZSaWtX+Xi+8y1Vj51ILbm
         EWA1NTcw0TFDdPExI0FK+1p47vSeu9c1Ru7mAcV3euebYOllUAJZzH5fdwDMXf2t1j6s
         +c392EbggUbJDaOsNQAZIT90wJF+Uyz3enhGUN/lSm8iNNAf+zrH/4ArJR97iij442uF
         3V82WlPqmUBptd7ADGSltp0oAS81vUBhskbvuu42vCuIrK4qNJF7FrSi+0jAkx6hqqTO
         OoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343354; x=1773948154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=D853mNRUbznSyPhEEWTRrSMZnk8erL0G6/xI+fjGLAEEC5owLy84pkU6sypicYMr0U
         Nl9tP4KeoN7t7A0bhmNVuPxjuI/Tn0HuXYVzJVLnqO2W2Mqr0YOiGRpwrySRluXpOX3k
         NiSgfUlEY6kNUrmjmwwlGNFyI8VU0CfMWSALpqOyAIjSnnsaDOELhrzwyD7I7+qvyb0R
         ZyTNMlxL5AFJz3VdQD0iv+hgZoLbheUVuk4A3cc1/o8zxfkEMJqcGKwrUlt+d1TxKDrP
         JYj/kWTlPXaqmvhKDtINRuFf7VHD6jyEtAzxeoXUlD0dLE0TqxJ8bajaK6pP5CkPxAUk
         gi0g==
X-Gm-Message-State: AOJu0Yz6HKQ5j2R9Ye1ljSvbNPr3nUZtWCv5Dg714TklhDp+IaBoDRej
	aMDcrNEeYl+qzevs7SAVJwrWcthahAx2jDf6T5CWPahwOEDwTrLO/GDsdEYVmg==
X-Gm-Gg: ATEYQzzZ4aMiuWDIQw+XujWKMPBjsmYa3fxmJMUTqbufuldtEEIvLY8msS4algG8Bvt
	FbDuG3PrA4BPJe7mPxe6bXMsQOsa2RnO21YB3b5m8CoHtZssO6LHeGY4dAmYdNVbAKqffNZaSON
	7In+iN7I3jDCUM0qyAsR9+dfe1/KH40Iqf1n9bc5ueX0fp6e6DxGK5pjlgXtbwPWoC1XQaqi5JX
	hYbdFUyFXkxc6Htc79/SuzQmYnVqs+CdhqNLUmWUXsQxclu1tHJ2SpEQLLS9J2mVtyMhuPSGkr+
	MtGeMM1sVL5OTeKrn2qtuIFQG6i5Vq4PNuNcDHP1M3NFV6l1wkU+zJY14lrZ2mVgCpAH45dqhII
	7b7PrHqoBceifZfMqqyu49/OeZ6Z0ErRC4MYHMue0EVwUORjYLlT9CEFkTYR2IqFDhz4sa/YTJD
	p+Nd/Objc2tjsSr96sCQE/LtEqH4vQT4k=
X-Received: by 2002:a05:6871:2317:b0:409:9a0b:b733 with SMTP id 586e51a60fabf-417b905e164mr296837fac.10.1773343353862;
        Thu, 12 Mar 2026 12:22:33 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm6159987fac.18.2026.03.12.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:22:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 1/3] commit: remove unused forward declaration
Date: Thu, 12 Mar 2026 14:22:26 -0500
Message-ID: <20260312192228.481134-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260312192228.481134-1-jltobler@gmail.com>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
`sign_with_header()` was removed, but its forward declaration in
"commit.h" was left. Remove the unused declaration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f0c38cb444 100644
--- a/commit.h
+++ b/commit.h
@@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...);
 
-/* Sign a commit or tag buffer, storing the result in a header. */
-int sign_with_header(struct strbuf *buf, const char *keyid);
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
 				  unsigned long size,
-- 
2.53.0.381.g628a66ccf6

