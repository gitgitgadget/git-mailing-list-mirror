Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564388;
	b=GuhWyXpVIECY1v/j7bMzPCltI32gpWD2McNSPTRFnfCb52oRj1v+/VQIglACdo0CmG9t
	 +anI2t9qH5M3F1uDejjKAaCTjssS9YjjoW+Z2m717fQlxWM+KGGJKrqKRwZSDt7MTztTz
	 p2sl143e9EtgspkUXTdp+1bA/kZONiFVQRyDCRuNbfeTbU5UNsi2mMI/3XfOL3WWKImfh
	 0IEoBC5LeJ0tui7IxielYuXOyW7//r9I/prUccItrhBNrnULmJpk58uCIMb2sXorFBwPR
	 GD3wqBJLuef2AVBV9KZoZV2OSf59veUdgDbwIk5koR6kHceuLZvadRNyDd5RJ5Wnj9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tt6SqRVH1D0X7C1wW8HqLSAR+F3APeeT8oelkvL0RJ8=;
	b=mja2Kbv2vf7eZ4JYviORg8P2oXK7s9QImVIDldC268DV3cmLi44YHxH/ywRQzw7vt5fM
	 w4/jzdGkPxcp/z7l1Wv/XXvEF7CNtGOWmUKdDSW6i8xLwlEeiCopMZyV1wyAUtn0odMAl
	 pvs1GFhqV3sc/aBrlLABBgm3UpoETMkkhhFxU0pGX2lJx9eg5SJAQ42Kc02oNoipUkgdA
	 ohmWHpQl1MHErCsPSTQqV+mRgca0KnUsswjK+aMI6ARII3B3RaA3j4fpBF7y6atfzSF5o
	 4Vyz5EH1wkMQc97AdjnWtdkmY0ZYv0O/ibIdR2JqPWboxbLFcpeQDc1VYO9YsYE9YIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aUETU3A+;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66C606A31F
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C66C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aUETU3A+
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso261677f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564387; x=1793169187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tt6SqRVH1D0X7C1wW8HqLSAR+F3APeeT8oelkvL0RJ8=;
        b=aUETU3A+CIUAP5x35l9me1tXp/VaWklqrw5efFHew3HWdYp18NKe11QfVS3ajM/MzR
         7ZY/sKUNlLKZjnoE28I9rKLImzYTMlM2F2ifBSBLKoVncUnuf/fnNZm7Z1fC7CNzR/hi
         KYo8kCqSQ6s1Uxc7t5cneHhtVtLuYNYUIozl9ZrF3XSBevYhMPxByzIugYgEOZtWDngK
         0bBoc5pNkjDZ8DylfC5HW87cMQBYk3U7onKnR40N5ds+JYZ/FFKVf8BcIVs5E9ZWG3e1
         Th5Tn8RQnjqNT6QHSva+UzbD3mAjdmul/bkciM4uwJMIC3VbB1CdmPGS9r2bD/dvDTHb
         szew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564387; x=1793169187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tt6SqRVH1D0X7C1wW8HqLSAR+F3APeeT8oelkvL0RJ8=;
        b=WYdED3vOY9R5Kon7hbrpGSpsGOm6asfBUUaV6ngqWMIm52qU/oqS44IcTZK8ZH/Bzs
         dW4mOIr4kXmz8+OynI8SF26/0+iyvFadw/49OlWy/F/KxQXaOYqUo6wetns/uGMX9lHZ
         QuWW2iQxAquyDNGh+h2I5Oz4htpvhaUBKviLJOxDKwh9E8sumy4b5+uZYw14FohlxFw6
         Ip3Joz2AzMVhFrtcpMxja5XUA/6NpDwqI8NRU6U6SX34RfpZlEC+ZDCvyOsHn31TcNdX
         N7kWKfBAO4bTHLvyFNaI/uxsNig+eytAMgySsoMDzWQVDrC+cz67fNCK8YSV67sDcuiN
         E34Q==
X-Gm-Message-State: AFq9FYLQO7k6KHRqDQg7t8MrROXoXUHYq4UEaNqGkEwNpsakMwYn52Lx
	12vvyyR8iGzA5d9v3Bad0NSrxJMSLy98ThEYiK6KFqIbIBntTysku4weZyfFbA==
X-Gm-Gg: AYBFou2p79er83izVQ48TgXOQFEISbOM7DTUvOMMCyhORWkXyIwIMQ4n5F3g5uLTHC4
	xsiBFKbeIdPGeF/LmQJj1+m/1yFLgN7/6Soxt4C7xh6uX3H0NWKWta4pb14WrGOlFyOqgueIbJB
	9Fs89f7ZyiG5MYoUMdRnTQaUs4EC4WexWR5L0CJtoCMGLLl68xdJGBxg9qTV3g0XzaKq5y/K4Eu
	+FIsmMGyd4gCq/FPkeJMJWNtvuNVgdwX6Dt1/qKqueXrlxxu2/O9ImwTCykgNWDBTs9D0CTjJbY
	B2pDDmD/i4U0iWN0Lf4FXyjUSk6zgsqciAOksCCTzaKtn8GnM6xO9NmW+eR8HSO5A/JjhV8Eg2w
	j1XuiPRYVjJKCSAQvG/AnXNzeUYk3h9MDI6mgPC3XFoG5Z21InwjkeZ2Iz9yD7HPkhWgMyJv+X3
	rNAZ7wlcQ/bzR4qa99cJGzmgp6ZkpyT+9iteI6PGovSkR0wG5PRC6wOSkU/TxxQIzh2G2PKQ0xP
	UsAkb8m/yF5T4mGkThJ/sLPO+c77tykOJkykjU9iIV7lYPNDuvBONKa3AOgJlfaDMCXNxXCZ4JV
	xmoc0IkQbFvgxAPbxtw5JBdl3sgH0fh5KfKbFh274G8oEeOjHEUBN1yvt7hmRj+tEENrIaEGG2S
	hGii13Ghk+uppVJLd5hW6W7CH04ql5NqsAU7kfXRfHWDy7dAaT7DKuzNoNxs+h/h3bQ==
X-Received: by 2002:a05:6000:2512:b0:48e:2948:6fe3 with SMTP id ffacd0b85a97d-48e294871cbmr147500f8f.39.1792564386538;
        Tue, 20 Oct 2026 23:33:06 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:05 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 02/13] loose: rename repo_add_loose_object_map
Date: Wed, 21 Oct 2026 08:32:34 +0200
Message-ID: <20261021063245.2917625-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
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

From: "brian m. carlson" <sandals@crustytoothpaste.net>

The pointer it takes is not a struct repository, but a struct
odb_source_loose.  Let's rename this and we'll use it in our object
database abstraction in a future commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 loose.c            | 6 +++---
 loose.h            | 6 +++---
 odb/source-loose.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/loose.c b/loose.c
index fe8f540979..8d7ea27448 100644
--- a/loose.c
+++ b/loose.c
@@ -210,9 +210,9 @@ static int write_one_object(struct odb_source_loose *loose,
 	return -1;
 }
 
-int repo_add_loose_object_map(struct odb_source_loose *loose,
-			      const struct object_id *oid,
-			      const struct object_id *compat_oid)
+int source_add_loose_object_map(struct odb_source_loose *loose,
+				const struct object_id *oid,
+				const struct object_id *compat_oid)
 {
 	int inserted = 0;
 
diff --git a/loose.h b/loose.h
index f3b1e47363..6f0c8554ca 100644
--- a/loose.h
+++ b/loose.h
@@ -18,9 +18,6 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *dest_algo,
 			      struct object_id *dest);
-int repo_add_loose_object_map(struct odb_source_loose *loose,
-			      const struct object_id *oid,
-			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
 
@@ -28,5 +25,8 @@ int source_loose_object_map_oid(struct odb_source_loose *loose,
 				const struct object_id *src,
 				const struct git_hash_algo *to,
 				struct object_id *dest);
+int source_add_loose_object_map(struct odb_source_loose *loose,
+				const struct object_id *oid,
+				const struct object_id *compat_oid);
 
 #endif
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 0664634938..3c0c85f3e3 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -848,7 +848,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 		return -1;
 
 	if (compat_oid)
-		return repo_add_loose_object_map(loose, oid, compat_oid);
+		return source_add_loose_object_map(loose, oid, compat_oid);
 
 	return 0;
 }
@@ -970,7 +970,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(loose, oid, &compat_oid);
+		err = source_add_loose_object_map(loose, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
-- 
2.56.0.215.g47fdf2208c

