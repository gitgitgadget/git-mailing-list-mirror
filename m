Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE627CCF0
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760588; cv=none; b=EhVArgCLswyOOsIzVoQCclP25E2idfh3t2PaD9amfJ6Sji+JB54ayUyF1C523fyzJXAbhr2o88Nr4iaMPy/DBf0RQziJF7OTaJskdLIcGWqQP6Guyi/SFo0CIORS+8PAvaC7TEQrchbgh/aweXaN9Z49WcnDSdfSGbevrvqXsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760588; c=relaxed/simple;
	bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDNTUhfAHTJnYmR612toa7dtc9ZyQlJzqcdlT1Z7oBJFPZ4hL2rpRzBw/xGoGaOwkjSJKdhuOC6D76RWmnNTINmGJFjSMiG9X/RJPw3eUnzfZt7xYMJTAsFtfOb5jx5l/lTQg0Z0BG56fc1OKfMNxe1cby568KQoIkUPYzG0p7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxGiouxs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxGiouxs"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so48603585e9.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760585; x=1760365385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=bxGiouxsZXzFBCxNy82JfbTB6rkU0FTIBQ43LAZsRjQGcZ0RSQ+JJxqR2sulshXFC0
         rk5B7UIfBUFwNzuMqgSL2yfADPLMdTWkp61+5v9NXV8TZPg9yyMbiVsqR6xFrcqJ71Fn
         +d/4WQS8OL2TLpPtI0Ps4Z0iNWFl1C3pGiy284n1vbshJO8a98SPWPvHg158NgzNS2L/
         G3JvmS5rRi8nQ1MBYUO6u0FJ2rzgO86TECUVy1Z+8fdXVuUf6kspp2xexVO4seWq/vVo
         etOLKFOVKs6xiU/66GVkJ1DSZmIOu0/ign7BJrc9CaLfzsxT9bWBQgiIiWbk62OjOnd3
         Ho3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760585; x=1760365385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=JZl2blnMMPb6fFdwKsQLvYB2yBya1fh8/pCAky/whNP59aaAVr4D16fUl6VJuTkQEg
         7mirPfDWeCIs7TLXSW+fWuI9yG9DlC4rdjA49NwsWbBC73RPbBlCXSGNwDCFtRg67mEa
         5MGAQ/9AXtNPPlyk762EpdACufpiZJn1a7cVwBpnpQouYHCyKG6J3XIuDMroP61A4Vmc
         WLo2Q+yxVirv71WydmngKXbRm+4QOKp3jtAQbhXPjIDUMWF9NUUt4X8HbrMww78Te9nx
         +Fta6aE34CsDA/+w0J3NSlkTmCKLLLxzUIRnVH73ZC3pvhowhxq7jEs7SSmgxcDwrNH7
         iX/g==
X-Gm-Message-State: AOJu0Yy5C0P7LKPEVPaxDP99t4h6E4bthxHpmPQs4bR/+vFdG5nwDLz6
	dJ5OJHxx/D2luWMr5mJWYGOc+83ipiOd7zKMGTMHxTSWOaM651eseUXKoETiUSj3
X-Gm-Gg: ASbGncvTZKmeYmel6znxl1sf4vujS3TiB+FZKrAJzcChiSCoamf6Ff3Ww/q0GZ3eUC4
	rjNa4ISH5RZctEsIu9qvqDIUimNBx+bwomR1iOwiyS3G0THFPzCKU5iIJ95GQWp5DaVYQYJFrSW
	rNxZvUIjyojF81SW4gIOu/sOtxdPjvrWvVUdmaIbhCZGUkWE6f10FqpI4yTQ/zsPHAzJaJp5ko9
	fSrmk0/6AksopG+d76oKOO0YmHnokPzN8rp3B5YCPUzbG1+1QNlXjJITtCftjTOWrhGxSiF61Uv
	DEeDbPYM3quK85TPK2sJOQmFw5T116vFK1NxfcB/0+awRaa6ZODFeji9Epa/zKRS91sen0ZBXuD
	ER1io9ZIdv/ncKeqeWAYjQTBi2YloeVbEo4udQfswpZW1fzK3QuYQhI1/
X-Google-Smtp-Source: AGHT+IFpPXll9V17ZjzP9a/2IodauIaNka9I0tQIoMzzRnaelXwhsqGLx5gXL4VU6Q79GVCz2XEHHw==
X-Received: by 2002:a05:600c:3b11:b0:46e:450d:e037 with SMTP id 5b1f17b1804b1-46e714ac852mr101604675e9.5.1759760584728;
        Mon, 06 Oct 2025 07:23:04 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:22:59 +0200
Subject: [PATCH v5 1/7] refs: remove unused headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-1-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MXxXI3MyhOANjk0OFz/v2RcqQ/zkeRwz
 Q+uSzoeR2z18YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DFAAoJED7VnySO
 Rox/W0gL/RwKYWWyZtRzmQCBRw90/6O6bHaRvHaG0JIOIv1VfaF5igwBj2gSNvLQVd7xDuVvFRp
 wN9duiQREYxIG0eEHaf1SDORKE6Fehf4VwN2psKfBSivC/PVStBMcZW5RUOLVTZ/1ZjOS7euYyQ
 CVDNpQsXL9yKG1Vmzh7mcFwttJPlCa20tBXSNjG6lHogbDjOuEIA11ZIX2jm2sY1z7j9toslAp3
 jtTyz6i2NiLJSvPXdvjkWe2Z0jw0LXfdVmap10T8lOI4Jlhlg5FaPYkbBrJkm0Yw97CQWFpDvM2
 /QtWEtubX/4AmXJBJHBrLJfAix7QgaK6qgwwh7JZ40AI9uSHN190bKJu+Ci5PjrUXOwzVWRZGzB
 +wUR79vtiTS1n+2YnxxvIMaFHOxExvk/xQ3cq6UBNpvJo46EstPcs4OyJ/Eb0XQu2144Im01opB
 ppXHAeLnd8H3qN6JcRg0+WEF09bWlKH+c6mqSh7yHOuGpKFc05AD70U2R+F0tsfHXDPYw3Ao+/5
 R0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the 'refs/' namespace, some of the included header files are not
needed, let's remove them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            | 1 -
 refs/files-backend.c    | 1 -
 refs/reftable-backend.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 1cb955961e..697adbd0dc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
-#include "string-list.h"
 #include "trace.h"
 
 static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1b3bf26add..d4fb033417 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -20,7 +20,6 @@
 #include "../dir-iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
-#include "../object-file.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9e889da2ff..2152349cb9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -11,7 +11,6 @@
 #include "../hex.h"
 #include "../iterator.h"
 #include "../ident.h"
-#include "../lockfile.h"
 #include "../object.h"
 #include "../path.h"
 #include "../refs.h"

-- 
2.51.0

