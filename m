Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616EA18735A
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002958; cv=none; b=OCqOjmuyp7SO7Ou8Q+g3n6/MgtycB8PhIn2/3tM3ubm5Xg/d+xovKe72vrKpKqg0jvjFfZaPJ0ONY7Ac1zhC0PCYXIR5SHSIqr9PSePvS2cq70aFPPUjQsmmJoSsRg9YWFpAg/MTtUJqvhQPNx2ek1025aJHtZRmJ8vyT973iHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002958; c=relaxed/simple;
	bh=csLaUWzI2K/ecCG+2Ut3u9xalpjSiGE48Rooc7Ra9GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kehJXyidiUIuBv6OaYZH9svHI59zyDjMFTTHgLau+vMu1gi3y7zGZEoz3dsJbuwasJE2xa4DdmT1KoY/9jahM3wIdzYI1d05bjIZ7/E/w/xF/0km4gY+J6T6rQZUeXEOfG9M+2AYrQpBbydP+r0sIMGhBGq2ikL3yWfGUOvv8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgNgz1nM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgNgz1nM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f082d92864so17438605ad.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002956; x=1717607756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1esfsk1a9qwBh9D8DxGv1vLbnu5VRmdjNnTBMedCCUE=;
        b=IgNgz1nM2hZDnPSGzpE/6Msu65R+dFqUtllfI2HhNuLJs/MJOgPoQO7OINluSIQ+se
         08K99i79O1+tmUbpjySLEqpdOHf+J3Dm/gLxADh815grEjsGs6o+1r5qgg6n5MY4FPNw
         OlGxPydX+3Cg923FdhhNnRDINPi7vxhRTif7Ps6PpidNbhwnhu7wbmLmpVaNs+MGFdOE
         Zz9mdzD8+nURgkYIK8ZNxAad9A4WQXAKkd7VDgmOrhPIBw33XLLUGo0aNO4w39pE8f/3
         VZJg1NnAU88OsSMWdyFzIogwraSmzgwUKVcz0nKHXTWhynRmnbepBbkfVH6tWG5L9sJC
         XpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002956; x=1717607756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1esfsk1a9qwBh9D8DxGv1vLbnu5VRmdjNnTBMedCCUE=;
        b=UKlvKGwyDJn/HA0wBzieqJt088GtJVqzMMwD8ExP3nfHKKxtF858xZyCb1klwY4iW4
         zXDknfVIYHCOTSTS7uTgPYWWoNb2RTYJ/fAzEzA3XSIhlzHRakCrHTjpNJoc/scnWiWC
         gOkTO7twzaiEMN05xQXHSMsQc0Cw2gojoFbwl+Hcc3J2CySXVi79uv4ZeVmCHMp2PB7y
         V5VCS8epZbVLYepK/SshaVsVdchNiklNwLRbLGktBKPDDN6kXaWsqN7J5mV8xYtgFeMe
         ZGTdRBf5oJ7lapBYEF34gfTnxxeYXrpmmOsJrWQ8quTeGKNTj/tHiPDFWscIKzTBqjGe
         fyPQ==
X-Gm-Message-State: AOJu0YyGiItpHjTT0W8tzAn/BT2GcxyIQB/BVeQ3SL2lzPq9tEUZ4v/o
	iXiyPAdlXUfT5t8IltpYAIJsXpucsFyKVcZP9M6D4mQDkSZaL0ROSdFSdYDsWvE=
X-Google-Smtp-Source: AGHT+IHlAVvyc3EQOrRlZUMu5ENx4SvewKFYlgS4hfTQMOtqxqf5ykQB/IxdIlHTksJNhHsuTP8Upw==
X-Received: by 2002:a17:902:684f:b0:1e3:e246:2cd1 with SMTP id d9443c01a7336-1f4497e0a2amr146469285ad.62.1717002956157;
        Wed, 29 May 2024 10:15:56 -0700 (PDT)
Received: from Ubuntu.. ([171.51.169.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4757734b6sm79720225ad.234.2024.05.29.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:15:55 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v3 4/5] t: add test for put_be16()
Date: Wed, 29 May 2024 22:29:30 +0530
Message-ID: <20240529171439.18271-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529171439.18271-1-chandrapratap3519@gmail.com>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_be16() is a function defined in reftable/basics.{c, h} for which
there are no tests in the current setup. Add a test for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-basics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index b02ca02040..3c08218257 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -133,6 +133,16 @@ static void test_u24_roundtrip(void)
 	check_int(in, ==, out);
 }
 
+static void test_u16_roundtrip(void)
+{
+	uint32_t in = 0xfef1;
+	uint8_t dest[3];
+	uint32_t out;
+	put_be16(dest, in);
+	out = get_be16(dest);
+	check_int(in, ==, out);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
 	TEST(test_common_prefix(), "common_prefix_size works");
@@ -142,6 +152,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
 	TEST(test_names_equal(), "names_equal compares NULL-terminated string arrays");
 	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
+	TEST(test_u16_roundtrip(), "put_be16 and get_be16 work");
 
 	return test_done();
 }
-- 
2.45.GIT

