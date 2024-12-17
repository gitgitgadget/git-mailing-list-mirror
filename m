Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D801E489
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479272; cv=none; b=sPr3U3PiaMY5qjsz89x+kr3E3bevpmhQ3gUiRP5KMlI5NMnWp809tA0oTXUszUWoPJ8YcXeA/0O14ZMl2/ItqWee4HECPVPSWp8zU+KgCh1MIv+BgaOzhJRTrezWMF9f52aVlw1J+CjuQWGFnWwK+8VDowiL43ru0t9+5Tth3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479272; c=relaxed/simple;
	bh=VLSSWKjNiIS9NTm73Ld3UrHa616D+WV8Z0odVEf8s3U=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PAXXaU1hffHGkEQuhkCPPEM6T9gBjykYyKj8crrlCa8VxHDQx8v96cZe6vg7ou+6sFrx7TWCZdbQHE6gbZkJ3v3W4dUV1erBuM3wdBRokZTYo3HUdkgx3S2NJsa4HijhFLK6AG8FtGBia0a+Zrmg7Hx5D0ukV4hAEnCzw4+J5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbEauf08; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbEauf08"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43634b570c1so29865105e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 15:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734479269; x=1735084069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9/KcudCXy5EG8yGzTvZ09wRNHF2AriA5CjZ+kgKnu6s=;
        b=fbEauf08mpc1XTn8Db0Z46rOuMBVWFZGkzJBZUaIoRElL1eF6TglL/9H/56nvcuUpN
         HaFxRwNWQwPMBc233RY8O2XMEh2XIM5kkiZHn2yCv6I1us7vRN7i3arVHGm6CcpbhsMS
         7/poLlmpetvu4SUOoFnR+KJmj7Dn9JAfbro4G86ulg8LlTlootiVZSj1GXcd8OmN93qn
         xGUPYGjlD3AjlNDJYL4f161YcRjmbDfsZC3wgNhGIMvo1p6Pf6fXzb8J1ymkiO3Z7SAt
         +RLCK7mwT1/JlyWYiwuI2yPvM+dtfgKTOGtQKH2hH75kdQyZhuddqmVyyDwH0VJx2ZV5
         UBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734479269; x=1735084069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/KcudCXy5EG8yGzTvZ09wRNHF2AriA5CjZ+kgKnu6s=;
        b=dq43KWvYN6zZux3T99ftnU5cn3cCNkui4a09ZDKc7jQzy2KmxVBqhRNem+pF0A+qQn
         iCMqdMX8KWJct0JJ8R6KAs0dAGAPAEAeZJ8uqxTJc5q/oOG0NTvWhaLoK4LynyQu7Now
         a2jwYlzwJc43s+abjzvmMULyeEREIsN6272jjwSFY2TEa7tjb8Cqti2OkKHNNQXhDkTF
         unDRIKYn7RsvrYg6FbCNfAaa1xQomcTmssPXUYsEkrWnEmAb3X5cc/Z/aPAPwNLMY1fA
         g9Dmjjo9aTwTadRfSzlsIhbMqNDkk8fb2qoJZlvMeC2olxuNzwnQb8mYI6Wh5ka80Mil
         ayBQ==
X-Gm-Message-State: AOJu0Yy0NkHC8bhjkdoJvVyyJW/eaTa+i8A76k7mEk7QzWsputu5EjKx
	n2pHNA31KeQ/Sti4wMXTtlpxuVVHRJgIh9DBHMbHSgdvG6JuzOH+aHtZ6A==
X-Gm-Gg: ASbGncsM6S045xK3vNPvQbC0b7TCM3VdG6mC7zPj1dOTAICHxEO/+A3ibI/JigFhtrq
	w/Qfk1Z2dsmuOBBRQGwOEqycK8TxDjBQ8MBW7QF1DlwxFm2KxCWMdZBG+rW7tB5OTpublO4Ol6k
	eDU/R459oqkDN4rBHlVHzM+JaQWTmEZJbx/zJTt5SLsLaZjaYbJdYJ7zVRga2TIXcM3W8hShZxD
	l+z/C4TWWFdHxfhwKtVXquHK7JQH9BprHUHCRQOGtV7zfgXnY32AAKVwQ==
X-Google-Smtp-Source: AGHT+IGKs073qpPxE1+n6JzBy01kiiqCNb2rQ19uiPPK8gRk1eipNzquMWcJTxk5hOrkFerx3wtuQw==
X-Received: by 2002:a05:600c:468c:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-436553433ebmr4148815e9.5.1734479268758;
        Tue, 17 Dec 2024 15:47:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119ccsm1660245e9.24.2024.12.17.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:47:48 -0800 (PST)
Message-Id: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 23:47:47 +0000
Subject: [PATCH] doc: remove extra quotes in generated docs
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
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

Commit <FILL THIS IN> moved these variables from the Makefile to
asciidoc.conf.in, and in doing so added some extraneous quotes. These
are visible in the generated .xml files, at least, and possibly in other
locations:

```

```

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
    doc: remove extra quotes in generated docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1847%2Fspectral54%2Fdoc-remove-extra-quotes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1847/spectral54/doc-remove-extra-quotes-v1
Pull-Request: https://github.com/git/git/pull/1847

 Documentation/asciidoc.conf.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index dbe36a52eab..b89bccf2309 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -21,9 +21,9 @@ tilde=&#126;
 apostrophe=&#39;
 backtick=&#96;
 litdd=&#45;&#45;
-manmanual='Git Manual'
-mansource='Git @GIT_VERSION@'
-revdate='@GIT_DATE@'
+manmanual=Git Manual
+mansource=Git @GIT_VERSION@
+revdate=@GIT_DATE@
 
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]

base-commit: 0fc57dec578fcc8dcda5cc3de6b81fa1f6719770
-- 
gitgitgadget
