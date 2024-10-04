Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7881AE010
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069291; cv=none; b=KHZI5QT+W1in4VTRALD+aDSN7qCif+HBTUVUZr295Yi1SsWndoNLWnB29XCQ+lGI6xeQHH6gs2S6i5lNgdUI7njIhyDR/1BAMIy8MLyTrBSdsisKrQI/AmqXFUWT+TQ1l9DMvD+4sgDY9KbYYGXrpJjolHEVqdP+hCgdlwYOOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069291; c=relaxed/simple;
	bh=UUfevdBlS8iiBazi+W7Ag6ND1aDXxSnPIgg/tj3IU4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTfAwAYypcGDEnt6gN43GTOjmXM4x1RxF3Pp+difo23U5SQOQ5BMqkmB+V4JHNA1w8sBLlk2nDoY/8bc0StzkGxL1AV6oM9LdCDs/EGDeuFrk0H/WdYzRASskfmS4bRVrkUkGd77EzQrSkVpduuVSz6/wTiU4sGmuHMTM8QQQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNc9Ob1y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNc9Ob1y"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e053f42932so1849010a91.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728069289; x=1728674089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McSSWvrT2QbVI3ODfSz0MWw/80n838T994Y908TV/AY=;
        b=fNc9Ob1ykEpJbrW9/AHvkJjKKUsNvMJnzv8Ywhdp4bVDBOhBshtO8OiwHn0vyHyX83
         KbhF5A4w4TKNTwH4/jhof360O1t6fxUpGgDT/72hAJltvoj/WnQauMlR94fs1TwSEPdn
         SxIxbjQM5OBRAHYQsCtKN5RIinWaHjhigv7KluKdeg4xyu1SnKrnnOVhrT/HYwW+yxQs
         Rk7vWpTsvuVsLJmGJfWbib3Uy1RgYKWRradYoU2kpNMRkOOH7UHRgU9PTSi8WVQvTVT1
         AjqarNoOH/12aAjXSSgztOjPYEJ6S+O3qb1wJYzqK2PK50KW1dmTU1B5bjC6HjwOmW9o
         r48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069289; x=1728674089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McSSWvrT2QbVI3ODfSz0MWw/80n838T994Y908TV/AY=;
        b=bM1ymehsf3JYbJ81upjcRBAvPCc8r6N06nlmMHaBXhi3/1msQPyy0YlDdX3h/IktX/
         To6W7eYiENNF59tFZoe9vv3YpEFhvygdkZ5pBbGog8QbA6grAa+T/0aOsPZhxGJzyW2q
         zhrTN83idYlQ5x8h0IIgkjBcYA4VrsPgUeBRmqJo5cNjYwG4Rrkue+hlLLs+65mOF9hB
         yTc0GMLYhkbCV5flQ7bSTbmzVVLuS57dPn12xwgUxnIf+Kj0p+rVi4BO66caT/FrOL67
         1gG4a/FZPaULgPv+wbPmAlbMvGhoTn8bteSTadj5eYSbDG1EuL9BBa6QvhjcSouHujQk
         RT6w==
X-Gm-Message-State: AOJu0YztMRvpvmCvN0Bre3aSOsj3M0FEoWcXuAZ1ypAGL8i6X0xO/t0u
	hq2ejy0cspvGIoEPZGM5ppVIYFqM13r0tc7mUpa/k+mmjSBVbdXO
X-Google-Smtp-Source: AGHT+IEULkh7SXUz4yfnhC2n6Vm+sr3sg2/yFTj1X00nlkBP/15lH/mml4tQHeGvvsVHWNwCP1kxig==
X-Received: by 2002:a17:90b:1d83:b0:2e0:7571:25c4 with SMTP id 98e67ed59e1d1-2e1e63c1613mr4625287a91.36.1728069288829;
        Fri, 04 Oct 2024 12:14:48 -0700 (PDT)
Received: from localhost.localdomain ([60.186.86.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86a9400sm2006411a91.47.2024.10.04.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:14:48 -0700 (PDT)
From: Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To: shejialuo@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	ps@pks.im,
	sunshine@sunshineco.com,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 1/2] refs.c: remove redundant translation markers
Date: Sat,  5 Oct 2024 03:14:33 +0800
Message-ID: <20241004191433.64416-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0.rc1.4.g79da3975.dirty
In-Reply-To: <ZrSroE8vLlZCK2jp@ArchLinux>
References: <ZrSroE8vLlZCK2jp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Teng Long <dyroneteng@gmail.com>

shejialuo <shejialuo@gmail.com> wrote:

>> --- a/builtin/refs.c
>> +++ b/builtin/refs.c
>> @@ -1,4 +1,6 @@
>>  #include "builtin.h"
>> +#include "config.h"
>> +#include "fsck.h"
>>  #include "parse-options.h"
>>  #include "refs.h"
>>  #include "repository.h"
>> @@ -7,6 +9,9 @@
>>  #define REFS_MIGRATE_USAGE \
>>  	N_("git refs migrate --ref-format=<format> [--dry-run]")
>>  
>> +#define REFS_VERIFY_USAGE \
>> +	N_("git refs verify [--strict] [--verbose]")

This define may not require translation, then maybe it should
look like:

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index 24978a7b..3a799aa6 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -10,7 +10,7 @@
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
 
 #define REFS_VERIFY_USAGE \
-	N_("git refs verify [--strict] [--verbose]")
+	"git refs verify [--strict] [--verbose]"
 
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 {
-- 
2.43.0.rc1.4.g79da3975.dirty


Thanks.
