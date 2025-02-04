Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FD15B0EF
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738642482; cv=none; b=PNmmhOvVEgc4c1SFHViDzmSoFLUjFK+tPtA3/LVq8hOlWTJIi5WZKGtqIBqm7c0PSKLtph+SYK1a0NBixnSFY7B4PvOd19ThRG24s1DaGGBT0+bzUju1la71F94n9sERwTtxzIN4qSHAyWaHIjijGMVlEI7uPD5skI4rTV9J9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738642482; c=relaxed/simple;
	bh=w+IMnUPbgPdSlyj1wAlUfFuREXKAMQth9M6sEL+3F3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o3aita6vIuy1lXZOQYs/a5hgQijb+1A7MOAj3nxxjQtv2XzFeH9KvcQrXHtl7MWqRJeAv6MpPv8xXRcBxoRRJvhzZQWmSGutZgNpeSoEA56mIk7s/13enU4p+bLeGWeP4kdas79O3gMqt54rL69P0gYzV1Xl5iiIwtAl7XcaMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WONEQehE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WONEQehE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21c2f1b610dso119902745ad.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738642480; x=1739247280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaAXsBSbN5mxDYCjqGEBXqV9IdfOiXkJtrNiGa6K7fk=;
        b=WONEQehEV0+3Brh3KNS0R3FOfyHqv7snz9V8xIAssy5LhSobki0p62ctxg7jRP2pHz
         Lu5wWhH31BgIxH0bNEZIZZEuuuFBOzAHKkMUxBLFWfo8OlbZVxnPFnu1oTuLsFaE0xWD
         evpbaKRhr6jqDx04wjZDUvtaqKZ64ltmzBcujW4IJlfvyE9HCWyHE4fnZe0ITRcRq5bc
         4SuDlJE3BdlsYjjhC0i4HjagVHdFoTC3/uHUQAyxsCdrSOvdhfBoNLpp/e+AMn0BY62b
         jbmORRHx73i2Y9Iot+xVhUL3K/jC0RjnZkr8WWJP+jLnWocATkwg3ovpbYr9a6p4ge/A
         Xzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738642480; x=1739247280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaAXsBSbN5mxDYCjqGEBXqV9IdfOiXkJtrNiGa6K7fk=;
        b=o5C6Pu5zderJd93QoWJHb1AnsF3lCFlDByM9BjEduIeDXL7sdJBf9lGIKBathJ8Nmg
         krk/Krqn4aNUlfjLp7BSAKebzZDHzSLGT5Cm1WmsiBZjC6t2ktd4gbimJDNqT+71X3dv
         ZkVp964XN7o8wfoIMTzYRkwC3KZG/sboDRL+Yc1VzexFKfnj2XJBu1vqTX0eoTZMgzxE
         dBjXvs/TJ2aRZczvpZO4yFzAt8jId1T6tDnjtCrP65R6Chfd0MqzBRXGXZjPh/nms4j3
         5FdAXy4Jh9QguZMuiTHDmVJuFLrk8pzh6cLOXkvoyOzmYEw8vsAJedtyFOzOfZKTagi4
         HF9w==
X-Gm-Message-State: AOJu0YxgjujaNfGsypE3Q+FWBviWjpD+lPlgNEMkkHoDUkwyY/LWvljy
	7UOPedVEAf1bjbd8UEYizOhZzm0SypHv2sjQx1+JDCMuX4KM+sFWxMmXQA==
X-Gm-Gg: ASbGncv3Tlkg5lGSHJ0sjW4/M+fzmwBB/zGwFxSEKkFK3ehJecYqPISpQ6FDuVZ05fQ
	iyA+iQu2Vv1Da9m4JTy+ssni75CRtE/o9n7clyeYMAldAYMyl129foF5BJfHmaaoo5hxn47gma4
	9TdiM3dimpCbLesqIKRisbPjahX/LSiw18I2cN7rptnAV9wzt5UvPkk6X3pf5xVJkKhGovWgbns
	T67W9Ob4ue59WuYYgxTt71oQA5fv5q7uZpbQ+upi/rLympH7cJdhPOCnRVq3ppqS0xbZERu0sMQ
	5c6gUJGOh8t9wg==
X-Google-Smtp-Source: AGHT+IHpEL4vNqmto8261+fWGRujqTUm/BLR/phDNmxCpm4ByQ1/J155jay6iu4Nab1IUg+hCbfysQ==
X-Received: by 2002:a17:902:f548:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-21dd7d73da9mr369459065ad.26.1738642479903;
        Mon, 03 Feb 2025 20:14:39 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f8522sm85893465ad.89.2025.02.03.20.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:14:38 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH] remote: relocate valid_remote_name
Date: Tue,  4 Feb 2025 09:44:30 +0530
Message-Id: <20250204041430.36035-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the `valid_remote_name()` function from `refspec.h` to `remote.h` to
better align with the separation of concerns.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
Junio mentioned in [1], the `valid_remote_name` function belongs in remote
header. This patch addresses that.

[1]: https://lore.kernel.org/git/xmqqikq0ruuk.fsf@gitster.g/
 refspec.c | 10 ----------
 refspec.h |  1 -
 remote.c  | 10 ++++++++++
 remote.h  |  2 ++
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/refspec.c b/refspec.c
index 6d86e04442..83ec7d7e62 100644
--- a/refspec.c
+++ b/refspec.c
@@ -236,16 +236,6 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	return ret;
 }
 
-int valid_remote_name(const char *name)
-{
-	int result;
-	struct strbuf refspec = STRBUF_INIT;
-	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
-	result = valid_fetch_refspec(refspec.buf);
-	strbuf_release(&refspec);
-	return result;
-}
-
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes)
 {
diff --git a/refspec.h b/refspec.h
index 69d693c87d..dc428f86f2 100644
--- a/refspec.h
+++ b/refspec.h
@@ -61,7 +61,6 @@ void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 void refspec_clear(struct refspec *rs);
 
 int valid_fetch_refspec(const char *refspec);
-int valid_remote_name(const char *name);
 
 struct strvec;
 /*
diff --git a/remote.c b/remote.c
index 0f6fba8562..3d451570cb 100644
--- a/remote.c
+++ b/remote.c
@@ -3003,3 +3003,13 @@ char *relative_url(const char *remote_url, const char *url,
 	free(out);
 	return strbuf_detach(&sb, NULL);
 }
+
+int valid_remote_name(const char *name)
+{
+	int result;
+	struct strbuf refspec = STRBUF_INIT;
+	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
+	result = valid_fetch_refspec(refspec.buf);
+	strbuf_release(&refspec);
+	return result;
+}
diff --git a/remote.h b/remote.h
index bda10dd5c8..0c14d665b6 100644
--- a/remote.h
+++ b/remote.h
@@ -461,4 +461,6 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+int valid_remote_name(const char *name);
+
 #endif

base-commit: 58b5801aa94ad5031978f8e42c1be1230b3d352f
-- 
2.34.1

