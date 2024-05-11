Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D201EA74
	for <git@vger.kernel.org>; Sat, 11 May 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428548; cv=none; b=pHVUTF1UZ32QBArMmTp/Abush/q9FFCCtGyH6Y9BdRfmw0va29/FpL+6rM4MjEtKVOk9JT9l/PMIpddfa8NGyuAeOw1jMxcT2ul5C9ZMYeL8Sg2w2ys6jQkSq22VHpfSFtAiv4MQ6ZxAwJhPdprg0MKmUD0fDXAioPVb+a390rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428548; c=relaxed/simple;
	bh=MjLCdSNulywHu4YVjEBroqJPKkyaendtDeOuIDgyuVc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KO+Uf824DyHFffiXWh4R3Ya/re3wKLWpNF/EHPbWX+0zKlyKLY+zkAVNrKPSjpDSsAteyt2VRc4B9/4FnGdGbQcvQRpwUSRgDC/cdhqHSEqtrcyYgHRFCNhr2JnDq6fVQP5PyoxFvV5Eo2BYT5y6cvmOOqogoCAN0IvQTFxHmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M310Dwys; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M310Dwys"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b2119da94so18266995e9.0
        for <git@vger.kernel.org>; Sat, 11 May 2024 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715428544; x=1716033344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOMbyP88kn3WbUcsKGAntBZ4+XMx7D+GexMyo84tsUw=;
        b=M310DwysmeJeOyd+BegmeChemgq+st9aHFmYnPQbWJMZCMjv3fOlbZ0LNeyDSeiaKi
         zaF+HeT6NqRRrgtVQih9YS+MeUVfOb1vm23XF+IJUwJ6cjV2WE2nuoxbxHyABxBjoX7o
         K4MVzyqq2ciSPKHguCOljQUyKbBYw+wJxY4InekXATGtwr0VfG0LBuv+I6Yo0XDc69xp
         D/1ut1XCe6RJcbWoEfaaD7n626d7Qbnw2G3U4cb1+PhS58Y4gKm7/QT1lJ/uf4NQHmDR
         +19cOF8nd9tnNCzSkFvd9tdghNSTD8zcxwgEMNsOMeAncTIMciM9U3My/my/7rSAuUB6
         e9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715428544; x=1716033344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOMbyP88kn3WbUcsKGAntBZ4+XMx7D+GexMyo84tsUw=;
        b=GgjE1wJ2qtVrHJhGfN7Nclg8yVh8B+zDLiQyWMTVBiPqipcDHiZfhsttUULJFB98o+
         +hZg8CD+Oaryy3ENb65aPlKJX6d4C3CZvjGzSUlQ1MYdZld3HB4g1zn/YBtnpTqI/7PA
         ZNgHl4BtVzrOIZ++dI2jwOMstgYrigGL1Vqv+MGaCwZ46/Yfmcsks1VmFl/Bu8en1ziB
         osFEwm5D9ivFqneYWJGfsgHv4gZwQ24g5jpPlVS9y6xUSdcJLhAJn9WfRiMqW34G0pC6
         6VVQxy/xIlm0/8ztjGlE9wMnSYQGAj5uBt6OoDewUE9L7PvdtZxnfqRFiz1YbZx14zuo
         ywZA==
X-Gm-Message-State: AOJu0Ywci3VUhNXhtKBDJP57oo8w0p3pdFNYA0z5CMR1Z4HWSy0zDbH+
	qvT3D2Y1IVwY2GWiPMoBRLMFUw4j05jeD8MM8b7j2EstYALNrqsuyf4+ZA==
X-Google-Smtp-Source: AGHT+IGbvbquVHnTowfeR16HMuQ2G+C74/lVkbsHjvCHWVrnSZFJYOspxkpya8m9D5FFgLa31UaL4w==
X-Received: by 2002:a05:600c:4fcd:b0:416:2471:e102 with SMTP id 5b1f17b1804b1-41fead6dabamr39409015e9.37.1715428544553;
        Sat, 11 May 2024 04:55:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm97040185e9.2.2024.05.11.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:55:44 -0700 (PDT)
Message-Id: <309c17c78f35296dd47e8b203413860eb62b239e.1715428542.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
	<pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 May 2024 11:55:41 +0000
Subject: [PATCH v2 1/2] osxkeychain: lock for exclusive execution
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
Cc: Bo Anderson <mail@boanderson.me>,
    Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

Resolves "failed to store: -25299" when "fetch.parallel 0" is configured
and there are many submodules.

The error code -25299 (errSecDuplicateItem) may be returned by
SecItemUpdate() in add_internet_password() if multiple instances of
git-credential-osxkeychain run in parallel. This patch introduces an
exclusive lock to serialize execution for avoiding this and other
potential issues.

Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6a40917b1ef..0884db48d0a 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -414,6 +414,9 @@ int main(int argc, const char **argv)
 	if (!argv[1])
 		die("%s", usage);
 
+	if (open(argv[0], O_RDONLY | O_EXLOCK) == -1)
+		die("failed to lock %s", argv[0]);
+
 	read_credential();
 
 	if (!strcmp(argv[1], "get"))
-- 
gitgitgadget

