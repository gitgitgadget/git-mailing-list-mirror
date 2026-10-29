Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233461;
	b=lB4D+jqJOjuANrNL5q6kCf9OpO8rLEnS/jURIhsM+CjzgCIDJMO3y42RzcWQP8+QluBc
	 01YOlvpxfstqPG9KOakvlDlhzI97hsciIkTALmRH3R/3njtuhCerQYxF1O2NZB/KzFqeA
	 U0Ea7zsPIjQ2i7n/Tx2I0FU6bgWJ+aX/tASEfPYZbo+aTpiPqTETinGGk4rC+IJrk2kns
	 7bQNF4DxIg9mnGBDRLJX4fAnc1SzKxjF1fzxxdhrWBfRdDvblbBuJNnAcQeT4ql13Zq2b
	 8+elUh2BMaI2af33qo1HdKDLy+K63YBeT+9JDZ8NO2Q++Z7JaOl5Xt62VfJcBoTc/bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=47/Z9OU9fXJNFo8CAl76rZuuH3pd8VoOkv+ELwsU5Yk=;
	b=gpBd6X+j66VHstQlJ7iz/bS2obqT5K+oOJC7CkExy5LMKdiRjVPaHRhifPl1fiNFHq1x
	 a7MMyABD2KGsizW4YLjxatzs80VGqCPgoKBH3siKZGIg68B8iQ4gKKK6LAleGqqV8KGtl
	 oRun99AuuGwo4DCGLKYb5LPlxHXSHsen2I8KbrXIJLZemQCKJ47Ow0CfdZcrZOtAOtZUC
	 4oUPStqtqeu73TDBuxb5UtwGvC2Pgdg0oVwUk7XTBzlNnt0fSxGp2nHrm8rIOBUcaJcIR
	 p/Rxvv2lOZbsWwsgDCdXhtS40BhKYW/H43OhQAAS7quDFMLxvOH2VgrBO61wQr+mdmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pM7BBxsu;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBED606A320
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 00:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDBED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pM7BBxsu
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6df0b02fe91so159403eaf.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233459; x=1793838259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47/Z9OU9fXJNFo8CAl76rZuuH3pd8VoOkv+ELwsU5Yk=;
        b=pM7BBxsuJ+B6fh4S8EfN1QF0GskLB2eAmq1Zc/4sw9nTnU2aJMxIqI8LH8Bg8R8cEP
         EYmyLdSXGbq93dHTxIAVFLCb2fKv6Q73L3VaPi/Vjjxv6JCmQWKPAtuDZiti5uVkBPzI
         XUFEZCiSMsYYN+a9r+jKSIVk5D2+WnHMXwW8j//jVYT8y7WNj8+HN7LDCOUiQYPv7+t0
         AQNUuSn2b2RIIp+EwXUyU0whnQZG/wFjQ8RCuAARESB3GvT0HaGL8wEpDTn2TWF5Fyg4
         3TKrk1/sXUFP4LHGmlBzMLiclCBfxxBfsCI39H/C1p5cxG+KFL6Hb9UTCiUBYK/Qb+kz
         4kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233459; x=1793838259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=47/Z9OU9fXJNFo8CAl76rZuuH3pd8VoOkv+ELwsU5Yk=;
        b=jSAnURxgXxD7Cepd56uJEZwX30rYcgcfvpYIBePeU25Sr5Vj1oP6cFoeNZGm8qZGjs
         PIE8JT8Xoyx45IQHcmVGvb/iDnWd/nS/urAcCRCdbm4RNuc+HYoDv+uZAbCTfKaJ6elc
         sBqyO13UCbHzK7Hlg+/gvZLwqYqzXtaiHnghKawNgldbrG8052XDCUOxxoYgwz8Qgi++
         NlJc5EX2/J7EVbbT6COjOgt70EZbGQMUB5iwK1njXrQP1DFkjEXaNjIGK54yqcOqjCEo
         BlVUqIhgcoC9R3Fmmbf0gc6Nvr4R8c4VG3G4HqIEyzkpIGG//9T5rfFEtfNGUVXCqTsE
         Xsqg==
X-Gm-Message-State: AFq9FYLbxWPA7KLnJnY3UuCIvUjRSwH5ZGBr3Xxiol1K2cx6P8enFvK1
	MGIzFycnJGl1ywVftRrhJy9ftupazPbW1Bn+2X/vSBtm4BdTEOABRpKRspKmJg==
X-Gm-Gg: AYBFou0T6mphQD+b3i1M5OzB4zuNeSgNuGGsxJTp2g4cGmOM0p7Z4i/8HGgwGwl2P0C
	56HvwkT754r8wJEE+Ob26u6OpRySY6EWlrc8LB3jpASsCH4zUp9A1XJv144UblOeN0czG1XaYQh
	WE6hJdCU++uVs6J4wuWFVOWUJlhr4W+agBm7hI645FVX488zp8NHXzzboNkFQdZoTsqDoAo2GEX
	S7Z6IztQH6nWDGld9M39pmry+mZEmxcav1pfWQVjJqpyAqbJMHl/xx+MzIPwQuGnmqUgGGz2lJ5
	UJg9ChfNCFKGNnH2A81Vksx/P8Tv9Q1Qdlp8P9mzLkWQUcEovwwalzw9TUB85KZNWwGi+KsG1o9
	X4jblu2R/Vn7ZFis9hrP38O03B5N9CHZETUn5FChPD+UTsoeTyQCXJFeqbwDay8KlsadFV4jjXH
	1oPbovZZlyqH+rl3EOFpsnwMal/wtHizwDOkT+TpvZ6Ylg/RC/D0cKJ1l0BtRwpqSicwg0gMgdm
	rO04qA+0zK/lLzxgV+GDaNTKsAh9x+UnUbTvJCsvTmUAmKsmtvuHdHJ8nF9oKv9Wp0c2wOfamLE
	DxRb7VUIkUNaWg4lm3bKwNUxSHwj/nV90gb8AQsWKrVSPnLQ7vbj3XJ2ZX8SApyJXQ+PJLE0lHV
	AKt+TaMBxCI694g==
X-Received: by 2002:a05:6820:3416:20b0:70e:177b:eafd with SMTP id 006d021491bc7-714ddd2ee02mr462059eaf.16.1793233459663;
        Wed, 28 Oct 2026 17:24:19 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm2976439eaf.5.2026.10.28.17.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:24:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/4] loose: use finite timeout when locking "loose-object-idx" file
Date: Wed, 28 Oct 2026 19:24:10 -0500
Message-ID: <20261029002413.3291184-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029002413.3291184-1-jltobler@gmail.com>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
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

Loose object index file writers first attempt to acquire a lock via
`repo_hold_lock_file_for_update_timeout()` and specify a timeout value
of -1. With a negative timeout value, the lock acquisition retries
indefinitely while the lockfile still exists. If a process dies while
holding the lock and leaves a stale lockfile behind, every subsequent
writer of the mapping file hangs forever instead of reporting an error.

Introduce LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS to set the timeout to 1000ms
and use it for all callers that lock a "loose-object-idx" file. A value
of 1000ms matches the default timeout used for "core.packedRefsTimeout"
and should provide concurrent writers sufficient time to acquire the
lock.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 loose.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3..c6f4ee0ec6 100644
--- a/loose.c
+++ b/loose.c
@@ -14,6 +14,8 @@
 
 static const char *loose_object_header = "# loose-object-idx\n";
 
+#define LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS 1000
+
 static inline int should_use_loose_object_map(struct repository *repo)
 {
 	return repo->compat_hash_algo && repo->gitdir;
@@ -137,7 +139,8 @@ int repo_write_loose_object_map(struct repository *repo)
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR, -1);
+						    LOCK_DIE_ON_ERROR,
+						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
 	iter = kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
 		goto errout;
@@ -180,7 +183,8 @@ static int write_one_object(struct odb_source_loose *loose,
 
 	strbuf_addf(&path, "%s/loose-object-idx", loose->base.path);
 	repo_hold_lock_file_for_update_timeout(loose->base.odb->repo, &lock,
-					       path.buf, LOCK_DIE_ON_ERROR, -1);
+					       path.buf, LOCK_DIE_ON_ERROR,
+					       LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
 	if (fd < 0)
-- 
2.56.0.173.gf57c9a7388

