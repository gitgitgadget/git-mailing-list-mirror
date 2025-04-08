Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0032641CC
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112931; cv=none; b=PjB2xjpdpQJnN7JYXvB72ApPCxvM5UH+LHCpQIVwsWIRH+DlEoR8+FxFBfuNwlrSKbOg+d6GUjSl+TzJM9xAagW2bDDJT50bhSTYK06ykAWt4th+bNsmrgwMkouTHbyhJUZYd0oJAA2eCtyJqi8K4iRcu6gNjE00O/SUs+iWgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112931; c=relaxed/simple;
	bh=X9cCPX/53jMAXlT5Ecrtmm/Nsfy31NDpVKLEPoxW4iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9BFmlCS6usb3V62RzZLdRvr5Bn1DDn1K3YXZ97KYrCSb3ayxpqif4tsDTZMCAPNrKWKfP0ImVNW5anpcEUE1k/aAf+2xlWGOUKhgbZT7XrHdihNV8S2rf3T9/U+AQsMCSe/cVHxbnI2P261K+D6HinI2yRH6mw7RwNfAf62U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdCIVK/n; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdCIVK/n"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so874547666b.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744112928; x=1744717728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt+yi0qX8SEXpzpClrFOQjxvE52O9X2iab58+UU7/zE=;
        b=TdCIVK/nkViJDwNxRKPbcpfZ61hVRD5E7Qt5wSgoAoccAdCxFVaSq7xsX6PBKtxzYt
         MTCiZ0DKeFQU/JNhqhcsClqCSLH5fnw6uluji5iv+pAa6jiXXIt+9MOymxs/nV760Gqz
         i4rfWH1oVHLSzAlfnzhPKeFmk7EFOosaZI6FPFODlx8ewsDcs4a9yqZTTtq5kGjHidh+
         uYiSKlHgJwqif6HFG6TCp2YP+2VsAGsq6UzOYUx8HA9vm4Acv6xZQ3tQvYOAWH7wbugW
         C86fqCT0qhLq1LqIrPt1FVqIxtqjWKy83+h5pDgsV3Pj14OcEGIB4MWvuaSjAkA0CM5b
         Y3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112928; x=1744717728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt+yi0qX8SEXpzpClrFOQjxvE52O9X2iab58+UU7/zE=;
        b=AoUMdhcx8srcN+GORY6NiLaTJsBC7r/SN28M173c9RoFR8QtelKzafTGZln28SSBs0
         QhKS3W0GfUrBNjvUSgXRToo8k+OhPd1AZfkzjWV82hwWj5QjIyqILZL9vf+BF2F9H/Ii
         lqZ7NSdzeYYjELd2biOyDUtt8911xrRM+0eYHo68/GiF5Y0rhh3JtjvytqfpEkEYeRuU
         M2fW3oKYMEdYbOcSEU0YuuSqVd4mOIqgeh5ipoMQpK7Y3H6AEetc1MFhpmzJN7ae1Q0Y
         iDHGT5uqdwHrzVBRkqEWpSMpifrP+EKRSZ7ZiPDhQz47GKMHN6jYkjhmhAp/S9xa6KBx
         UkEw==
X-Gm-Message-State: AOJu0YyEPsWqeHucYn+Wk9qa4AQgE8ECS01H4p9M0fBABk7NEqocsfr9
	6/9qk9vtkvVcoTQfE6GfNNrdpIOoqVOj7aisAXLCmxDxwnV7IvaiuvvmnTRRRw==
X-Gm-Gg: ASbGncv7EZ21bYrX/N8K4Ti61z2ZPbw+rY9sM5C3m2lt2caRPvfCXKkOCQrkXXAbRPu
	W7APgGibnTK90bB8z04Pl4xbomnnhF3pTc1jOSwO47KS2pWPJZ3hw5Oq4v3XwUaOK1DCCQ3hamL
	K6YcA/4dq5WWydsRyjl+aX2HPNLtyZJI3ZDaDWu4yG/H39fLQoybcqy17rtp5zyGaLZBcEyR0JI
	33N5OOvgg4lo2hqm418V0lOd62R3VcbhWw3h9Ewy9ttOOpvkeH4GjK5/r1JOeXl/tbQ4K+2Wplc
	a2g1HHQqeDs7isOavkyvNey/NTylQfUiNnAlCDzxYjXIsE0FXKUoHeoehHDkDX1fImDoJGateeI
	qbLyUbcnyph2MEKx9gNVAK+JnKlsuevxMBznO6V9VU2t+N0ygdw==
X-Google-Smtp-Source: AGHT+IFf3/aI62gMJ3RRKpGJdA+4qWH8B4pvtH7BN/c57CGqmUPqO5PNdEM1rJMAn3WJXIfSKueQVg==
X-Received: by 2002:a17:907:1c8c:b0:ac2:842c:8d04 with SMTP id a640c23a62f3a-ac7d6d04d05mr1385329266b.17.1744112927734;
        Tue, 08 Apr 2025 04:48:47 -0700 (PDT)
Received: from localhost.localdomain (host-95-230-249-134.business.telecomitalia.it. [95.230.249.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c018691csm904181266b.150.2025.04.08.04.48.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Apr 2025 04:48:47 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v5 1/1] t9811: Improve test coverage and clarity
Date: Tue,  8 Apr 2025 13:48:41 +0200
Message-Id: <20250408114841.58592-2-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250408114841.58592-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250408114841.58592-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the pipe following the `git tag`, ensuring the exit code is not 
hidden. Add explicit verification to check for expected and unexpected 
tags, increasing specificity and future-proofing a portion of the test.

---
 t/t9811-git-p4-label-import.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..593de09eb4 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag &&
+		git show-ref --verify refs/tags/TAG_F1_1 &&
+		git show-ref --verify refs/tags/TAG_F1_2 &&
+		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
 
 		cd main &&
 
@@ -208,7 +209,7 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git show-ref --verify refs/tags/TAG_F1_1 &&
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

