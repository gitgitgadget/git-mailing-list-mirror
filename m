Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0811C93
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbfCH2My"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-336897b6bd6so2514877f8f.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351705; x=1703956505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFKpsdp2o3YTXIe4JCGPsqVbXJJnbQVjI8qM+BqcSMc=;
        b=FbfCH2MynlF+2GpI6qVQsluL+MMnwK5QxYwTZAa2F25f4VcENp1S9PRHrHX07NqqqF
         324t7d1LBBSSg+ENyWyUy3T5xDKlMZ3DiUbRLGgC9mMVeTaRkw1+PagkDL9C2+qOuT9C
         7NgKrV8MDCDOw1NmSxChE7DAxjEN+Dc7DY97gg0kxxqDhbwqN97ObBEzPwbqPYQNXYGG
         kmahQGS6fv4bApFh0/q7qYqpDAzlsh2W9spaooI+atK9dhQ/+2maKvaHtVBMaU/H7c+J
         KaLBsUGk03UvRrcKLEvrxEOSHlyLHqa4lhxz1rZxhxlC5zXB4c2lNX8ZLKESDddHuB0/
         kzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351705; x=1703956505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFKpsdp2o3YTXIe4JCGPsqVbXJJnbQVjI8qM+BqcSMc=;
        b=ApFWVhfCyv3EdA2h70S23tPZb1kBCXkxahqNxJ7r7wIHToUwRmF3yqTDqHE09uUvx7
         GV3BMlKg4v3a844l+lw5STDbEL+SeJ3hcF3Dq1Nd7M/oOmIEnakvREiPw9Kyk1d7Mxit
         1g1uHfQoNmVfGcsdP8u9qgyW6W+JJWWGtqQbxc39IFTE70q/wSoN3EmN0JyKTyh7r54O
         ZS7xrx5yMNW8xXLQ64g4OI9o0jlV51BTzltIQR6zmk2lVQ8rsJE3txd7cjgBEDF81YlG
         vEoWwnwO3Z6IpGPbITupVNl5hOe8hPcy6SjfvsbKm5Di43bQhnLTZsfLxO0dI3tIva3q
         ruNg==
X-Gm-Message-State: AOJu0Yywdbd6y1Upp7/mDK2YHcrguRV67PUIGOtuBUt0WsGOo415Vd0i
	wfUA8iqNV3H4FVqXFbX0UzkZgtjT77E=
X-Google-Smtp-Source: AGHT+IGmsQQeY+4X6WKdQxINGAX/+gUU7OBQ1on7LW46TEUDGSLOAJQbi7C6K/TadDaIqroAyO4mCw==
X-Received: by 2002:a05:6000:c3:b0:336:6143:b14c with SMTP id q3-20020a05600000c300b003366143b14cmr1684057wrx.33.1703351704669;
        Sat, 23 Dec 2023 09:15:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b00336a0c083easm2517676wrt.53.2023.12.23.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:04 -0800 (PST)
Message-ID: <2f8ff69314e6fbff828ea63eae2362fc6e3dea25.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:49 +0000
Subject: [PATCH v2 01/12] treewide: remove unnecessary includes from header
 files
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

There are three kinds of unnecessary includes:
  * includes which aren't directly needed, but which include some other
    forgotten include
  * includes which could be replaced by a simple forward declaration of
    some structs
  * includes which aren't needed at all

Remove the third kind of include.  Subsequent commits (and a subsequent
series) will work on removing some of the other kinds of includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fetch-pack.h       | 1 -
 midx.h             | 1 -
 ref-filter.h       | 1 -
 submodule-config.h | 1 -
 4 files changed, 4 deletions(-)

diff --git a/fetch-pack.h b/fetch-pack.h
index 8c7752fc821..6775d265175 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -2,7 +2,6 @@
 #define FETCH_PACK_H
 
 #include "string-list.h"
-#include "run-command.h"
 #include "protocol.h"
 #include "list-objects-filter-options.h"
 #include "oidset.h"
diff --git a/midx.h b/midx.h
index a5d98919c85..eb57a37519c 100644
--- a/midx.h
+++ b/midx.h
@@ -1,7 +1,6 @@
 #ifndef MIDX_H
 #define MIDX_H
 
-#include "repository.h"
 #include "string-list.h"
 
 struct object_id;
diff --git a/ref-filter.h b/ref-filter.h
index 1524bc463a5..4ecb6ab1c60 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -3,7 +3,6 @@
 
 #include "gettext.h"
 #include "oid-array.h"
-#include "refs.h"
 #include "commit.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/submodule-config.h b/submodule-config.h
index 2a37689cc27..e8164cca3e4 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -2,7 +2,6 @@
 #define SUBMODULE_CONFIG_CACHE_H
 
 #include "config.h"
-#include "hashmap.h"
 #include "submodule.h"
 #include "strbuf.h"
 #include "tree-walk.h"
-- 
gitgitgadget

