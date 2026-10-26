Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024087;
	b=TcahrAYe/Rd+AgM7jCqGIWRWCJ9NPvWUVhRkrvGUrtg9eS80DVOXVPqt/k7QLDhD0SvS
	 4mVdJoZDO3DPi46FPNbAiY28f5DALNXNErRugYDL7Ka+ajUa+bl4WlTHEd2aVH7uzym4x
	 nE2TWcJxvCPgTQ1ER8fAwA2QLmllo07pDauNDp/w7tp0v+ytXYJf6lPVrho59AGeHvO4e
	 9plaGNoIH5jcZ1PzGL9PJpHYTxXl5SyL20t7TE0X6fsdnmRH3F+9d0AEnm/3ScGYRA8B0
	 dBPrS9rhiuS3Js66gs55YYtR75+DSxjcDSmChvM3ShPlDLUIjd2Uw477xSc8LowtTGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=92z2woYqgS74hnLIjYTPbjzof0E5qjSVFxQiwHJ5wLU=;
	b=U77UI0H8RmPtUhsq/RSpf5TJeuM92JOUQ0E21n9WSsie76wI7jmoADXt0AzQhhH9lWmJ
	 J7kKqdRZID65JDqMQRt+0S+mzsmknt1n+ixbhLR3bxKabm7D7NXEkNtLEF0cNCVa51OiN
	 rAsg02s75LVf5/VXxrWNIzH6rKPk1/PCRcn22F8Iriauazn+Y3MdgsjmzVPI7ofsQJWw2
	 fxoSKVpfc6QWfiwbz22tNzIyNbgceVFdYSE7YpbChQygDr8WeNzwc1s+90cJ9R8zgh0E7
	 5gMq/ZWgUfhsP2P+p/p0TuGwslSsDs+gkICJtkEM6nC84SkwxmNJxSBBA4aE8IGe8pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BgnS10EV;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D36606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D36606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BgnS10EV
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df54150dfso1649910f8f.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024086; x=1793628886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92z2woYqgS74hnLIjYTPbjzof0E5qjSVFxQiwHJ5wLU=;
        b=BgnS10EVcq/Mw0LzMkCIfinFPS0RKux0fJEa5k9//iGJbJGrbE+aP27oUsppBUpFd6
         HhX2d85aAEI8Cs//xb2OxsOY1REY5dqB9SgtOVM1SpiVb4IN7oA8Xb+Fiq1KjUZCl6E1
         rHBIIAylqXfPocOgV+1XMNTMZbmtrkgvf/FBMjFB2LiO/ajAtGPX64lZyB2Sp5XrU2jh
         zuTNI62iwFAIQsvzPh9fDodb2lrRtojDN8zrto/CuC6A6vaCo5WciHBtWVb/HjO1YUtu
         +fmy3wPccQ3GzbBQti6hobc1gz3n0iroN2mOTO1O/rgm7t1KMasCz76WDZtveJNjdiSe
         Ks0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024086; x=1793628886;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92z2woYqgS74hnLIjYTPbjzof0E5qjSVFxQiwHJ5wLU=;
        b=iuk34RjvEjGyPZ0RMeomhYcUdRutkylHVTHQdoCcS+FS28ECFv6zjDD5qwx6Ksb0jz
         mlXBHCoz0fr90CDWCZeGz5Q7Lt8gGW1VQYfyHwuXBu/0yUeKkR+4cBh6A5IMnXfYboPB
         x77CQbtsflWasemZdXqLjDY3zaXteDaEE2KiYSVxwCHwtIGEglkHmLvWcvxzHAAXsSGj
         cbSlDt5F5JCg1WN5VYf+MtcSOZEUGSJWPzn07U+h6bNFk0qHv7ubP74HVYzAepa1NyIm
         /vnpfdVui1DqGY8rrxcRuW7RUsnI/XFcCV9A2055z25GRmWJ4Ud+NbpWq74qJzIwMI3G
         Np2A==
X-Gm-Message-State: AFq9FYKWBNKMIqgCFA/ep51+lGdyulZ45tkncSrSlgJk4pncWMZ1uTT+
	jVTaZcqbVCLIN79RBP4uAn5lVMTXcXTezNA6VCMxtjbeULz8+OBAI+H4+hR5HA==
X-Gm-Gg: AYBFou2neIlJuzdXgQ2fPzYhkjuqM/XPTYEW0Ak/CAz6y2nPmOVdIF8sQIzcMqX+Wuw
	N4G/aLlqjM+O76aokvekoSuIpxZfwYWNw0NGvIFY1GVpb0IiI/uaGHbungfdxMMtWq/1NN8xcHy
	15pOW7EHxjoAzI1vC66kLeNT0RPvpZUmmRPgtDfYVTxcSCfhj/M3++RbYrhAYQEMARBNyGXqlk3
	2uHFZIgu2ADpXZt922HR0p3tSa9yB/r+fgA+m5yYN/c3gc9HruT1c7UrofQ2eVWfwlKyglQb83D
	h7E8+wF/aeh0QmZ/MbArx6RzL1r2baf8JPhkn1SVGK2XSfGhuPbetXhdEW5Pza8jYMoXIdvrm5r
	v5oPZvwlBq5ppafU3Y3368eyr/6zwpuWIAyIpr0OL058vF2hib7SCDGDwCQlcPXG18NxewJJGbY
	qH+lg9EpPRhYwtwQNhUlBJPLFl3Od4htzgdUSV77vWo1+qqTOw2EcMor6xA8B/2glbekpvReNRt
	fm/UD6mGgle7jrpDufnJEy+vV+NbGNZiVOqZlvTP0Gtw9h9KgmxoNr+/0uC2/JSdO5o60pVp8vO
	T37M
X-Received: by 2002:a05:6000:2289:b0:48d:f6d2:9c88 with SMTP id ffacd0b85a97d-48e3eb9fe3emr13041220f8f.47.1793024085101;
        Mon, 26 Oct 2026 07:14:45 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bdbsm13707958f8f.19.2026.10.26.07.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:14:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] CodingGuidelines: allow compound literals
Date: Mon, 26 Oct 2026 14:14:26 +0000
Message-ID: <a4b382c0373e1b410c4c1ef74b313f86076d48aa.1793024062.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.336.g97505d19352
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Our coding guidelines say that we'll allow compound literals from
mid 2026 if no problems are reported in relation to the test balloon
added in 01e49941d6 (reftable/system: provide thin wrapper for tempfile
subsystem, 2024-11-18). As no such reports have been received, update
the guidelines to allow this construct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
base-commit: 26d8d94e94df5535eecd036f16627493506a0614
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fcoding-guidelines-allow-compound-literals%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/26d8d94e9...a4b382c03
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/coding-guidelines-allow-compound-literals/v1

 Documentation/CodingGuidelines | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c06f5d3071..23a4d2186a 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -311,13 +311,8 @@ For C programs:
    . since late 2023 with 8277dbe987 we have been using the bool type
      from <stdbool.h>.
 
-   C99 features we have test balloons for:
-
-   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
-     compound literal syntax, e.g., (struct foo){ .member = value };
-     our hope is that no platforms we care about have trouble using
-     them, and officially adopt its wider use in mid 2026.  Do not add
-     more use of the syntax until that happens.
+   . since late 2024 with v2.48.0-rc0~20, we have been using compound
+     literals, e.g., (struct foo){ .member = value };
 
    New C99 features that we cannot use yet:
 
-- 
2.56.0.336.g97505d19352

