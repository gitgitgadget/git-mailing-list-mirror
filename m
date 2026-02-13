Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3436165E
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993308; cv=none; b=om3FzuhAfGQt1BcgZDZRCbdItuNVnuTAH+HhOTsNul8hr3TsMGKUpS2J0cy+9JRwKAXrR3ZGEdwWt2knxWLItK1ChPiKAlfu9/UJ6ANBhJZThpSYGMYcdjTnTTyeBKvfdNgJBq8crT/+VJZ6i4PyBgPyEX+2hpRZQvVz7sE/lVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993308; c=relaxed/simple;
	bh=WyMU6xhVXtADH2q3uL6AnUzqU+a+jiBkc6uaFu0SObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDjJLpAuk/Y6vQH3xcexTxxtETuBBuRRue1gRcrFJrvzY3vdfNSBnbn1jn98tAUihzFR5eZLulyn8A1W/sS1aheGBY3JE+d216MkivsAJ5sASkEscjAdA4evRay5FltcbcwGKXIMaVxxzrAxUgHdupPkE/I62YKdnmR2ayhvJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmtCdZFp; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmtCdZFp"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4837634de51so2477265e9.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770993305; x=1771598105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmS+176cq+lst1ItoNkMBQNRpNLOvlk6KePDp2KzfFk=;
        b=AmtCdZFpQiYWW//kUpZ04mw1WPgqpDQVvd/srbptU/ZsnGgZfbAJwozcbwrTKvztUA
         D4KOOf8zetjDecA27kU3sFKRMRC2EboNEK1jRJWHMhtm7rr/ARYbZPzvAPHMBZiogFBo
         RFVf0yo5fCpluBvf6Xuo/mJDF9dfNEvyiJ/B4KCcg1R8wzPbCrWz4881x7Bf+1UN+RVa
         v6emccpbXsnuHBmXYP5FbEH+UH13LdccIWarVMcaMrZFlp/1ULTanSL88J+MTw+ygTII
         N41vuonqgSdBzRgL23LbT36V4uMBCZwMzxi0JhiBT5Oe6YindTJErqzxM+zidXmUGL+1
         jRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993305; x=1771598105;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmS+176cq+lst1ItoNkMBQNRpNLOvlk6KePDp2KzfFk=;
        b=RJ9HXa89O5FaHUdFk4xVrElra8DoYuvB7x/1NZeav5VVZALosVO4eAqVH1fXIQgT4n
         PDwfJg+Cg0xDsqI65aOaj+zmyMuRL19PHg/Yi7hqDRZr/ZM5Xq2FiQRUYIfNHVJV1IU0
         1a6QkRTAFTxuVDzjSTPHBq8baxmpdMcTNmAfAPurIKOwRWgWODfz0u3Ua6/MEeMWYXq4
         8l2gqVfQhVcDqIsqQ+m+WVMLll2x3wuQsLWYLQ838AMFHCJCO+jBTFMIiDRGisNoaxC4
         UFDM25AkXSXmdswwTpis46zXK4TFyqE5CYwxq5WzQRziq5XfXE76KuYORjxohasGFp5z
         0EFw==
X-Gm-Message-State: AOJu0YwFYskLBGXQ/5gBEfl/qkeaYWaE25zNeIbb2KqLcDBxiz7/eE9O
	fUdF9Xx5XNmEBdvuvlZSf2qpc5cu1E1wICCeFJitZKH9Iztdmf440r6LZH2Aj+/n
X-Gm-Gg: AZuq6aJqbVLLx7PyJ2931CbYaszaAVBbyzKZqfHs9YAL06QVk0E9N7tLKs+GV6Q0oqM
	w5hhW0rsQjzEfoJqDgdWUqVT6XQMlbEZMVtbsPA3SKFJuScz1Xwa2dqfzkfdYWomjV6t8sjPxWw
	RdpLVzD+TsbuP6HIuQ7cqtIRAeiH7XvnbJwh6kLTi/QL6OvXYOVJVTaZXc2ANQYVtRW2JqrF4s2
	yqNx+/ChmNTnfViAUp2X2o7zjXA/2G3FpxPkFiqkqT5Y6bI1+KQGwvSK9opJV6kMOF3UJF0kgkG
	uuA64HINY32NLC+QaIsRhURCEDjNsXOa7w5QWUtYkdvsvubpUv9qLHCh1d0ELjj/Shq2Eq2wH7d
	tI4MO7WP0ENuH8PI4MMEKyk1HBszzHaZqViMUfnqO+9zpeg/30o7IpcZuDT6AFrtpjY//m6FVir
	nBvSaU8LLPJqaF8lZtW4r+L1Zjw7E=
X-Received: by 2002:a05:600c:620d:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-48371043046mr40828375e9.6.1770993305267;
        Fri, 13 Feb 2026 06:35:05 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm257083905e9.4.2026.02.13.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:35:04 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/2] templates: add .gitattributes entry for sample hooks
Date: Fri, 13 Feb 2026 14:34:48 +0000
Message-ID: <5f5e30914355ba108d8f4ce9157369e979f585e4.1770993281.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1770993281.git.phillip.wood@dunelm.org.uk>
References: <20260206090358.GA2761602@coredump.intra.peff.net> <cover.1770993281.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The sample hooks are shell scripts but the filenames end with ".sample"
so they need their own .gitattributes rule. Update our editorconfig
settings to match the attributes as well.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 .editorconfig  | 2 +-
 .gitattributes | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index 2d3929b5916..6e4eaa8e955 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,7 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
+[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile,templates/hooks/*.sample}]
 indent_style = tab
 tab_width = 8
 
diff --git a/.gitattributes b/.gitattributes
index 38b1c52fe0e..556322be01b 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -18,3 +18,4 @@ CODE_OF_CONDUCT.md -whitespace
 /Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
 /t/unit-tests/clar/test/expected/* whitespace=-blank-at-eof
+/templates/hooks/*.sample whitespace=indent,trail,space,incomplete text eol=lf
-- 
2.52.0.362.g884e03848a9

