Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F41E9B36
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810753; cv=none; b=LGd78bSpWSkjPOV58B5OOKVCq97T8s1tmhYn1uP2jO9lHEURZY2dEsNUlJOsWFjTL0XHKlRJcZ0MobY6d0v9spnU2W48wUPpmxdC80eFTJnS/eBwYMyai+DcDZ3XIDZUeO0osQg1J/Akh+QCjqmX+a8E+OigWV3Q2p/f4Ss5t5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810753; c=relaxed/simple;
	bh=uc3811tAsAAfFqMXZLw/jBrqgreoMiycvaZ/tYpTEt4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kB4dyUBPi47EDjxWmzU+5qq+uPTvXYRC9XjhCP3U3VMuHgamNsslHEbNeAZSaDehbIqKMVmM54G6dpHrIZ49LwgH/mXxi95tBq/8gjkj8QU2InZmQbzbrOKmUIrhOeXP+D3iwcvtBiD44ZC1zepmkLIJBw/XrAHUnhr1Lryt5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqx53GDo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqx53GDo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22438c356c8so4883945ad.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741810751; x=1742415551; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb1xBF+7pJMOEkdrfR95iAwyy3mcGN2p8RPsT+eCEQE=;
        b=Kqx53GDoUexbdoWBNSappQ5497RDWFhK5ajUrANpdFsFFNlpo2QvoFsT8LomSsKaxd
         ka8cmopI4h+DJ6GHmtGdWC5FYuaFbRdfpNT+J0VWmET05/hQTxjRJq1vepunBp+kBnCZ
         SfbrGmSIs/V2FGyqAhwcYYY2qF8Wtyt4zGP7b7KyYu2huZbUXBeKC+oIrbQfd+sNp/ng
         80y2mpUCRamg+gmxPvEaqPJxlE9Iw+tSGkf1Kk8iQCVnlqQTXoSB0kY5mTPQl7PxwtXR
         zPwFJtYplQJLd2S7aSZ0TfIuh1zJRhOGDg3cz3cvHABGqUjUWC7rEEzFq5AaD9hdwLn0
         Xa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810751; x=1742415551;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qb1xBF+7pJMOEkdrfR95iAwyy3mcGN2p8RPsT+eCEQE=;
        b=kpbrOGBSqClTcabBkUWx6iNxQ0ssWOBvAEIh9gfmoX6fldalmq9rW9EBkisj+jEWOc
         i6SzYnhZeRSRCp59xKhaz9TzotUX1ni5QTM0tr/ETdJIyedP6UNmopz1AsHEvFo0aVpr
         +sQi+TYA2VPZgso5lQyypfnS/uFG/EX495E5sxn2NgCDTeBfSVbnYjPwtScgKUq5EdSq
         5kaYw9SBa9+V+Fnu02w4Gr+8/MeMznBbz3cIDf4LkPLYIN4CwHi+ktDEQsohqnCfzboF
         l8j5ZFB1hO09nJZk+HDvCMxLw8PFtJyiPnZcsCvACmohLuuxCf/MlaXmk61iHSffCEax
         qAxQ==
X-Gm-Message-State: AOJu0YxX8+botet60hp3mklMRxqj3qdsB5Va0HFXFsqXTuZ3NdCLUz9c
	UZf5MeYHEmKZnyrrC0ge0eCvSDYzFidgIdpInu8EWJbVHwO8GLhioj0Whw==
X-Gm-Gg: ASbGncvAdZFiIcPB387bRaGA+fMcv1l6Xaqc9/haol2lQa6/KkFQopIyH15f5y7VQqU
	yItxDgBaa+1JqqhOw0MVPPtM+KynfSncF7LlPuMFdPoFEf2ac7TVvi3pyy1+YdfgOwPN9bzLz+H
	SBqWHOpTZXgOlieydAkjWycmE3dReY6CtKg9cV+bBueO24UnZz/LRMYw7hofg2hoeD4ggeimg50
	tmhjgxdMBp1t8tjzSdHJRwoLZub85Fb0XRvJnJu74c0F2racuY3ueeDv0MNiXb7Cc8MBMVSoDNm
	H0EZqWxxyXNRQ6Cq5GG9WiNB/4tnzf8V4I/g/oFKXcpP99ijTQ==
X-Google-Smtp-Source: AGHT+IFVB0AA44SXbmJSzRjaF5wopOXySLdWJHdT8WdOTiiiJPiOZsLjoyQrkSGA1rUng0EsFSbWdQ==
X-Received: by 2002:a17:903:c4:b0:220:e392:c73 with SMTP id d9443c01a7336-22428a8905emr268355085ad.22.1741810751519;
        Wed, 12 Mar 2025 13:19:11 -0700 (PDT)
Received: from [10.61.60.205] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f70bsm120263255ad.131.2025.03.12.13.19.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 13:19:11 -0700 (PDT)
Message-ID: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
Date: Thu, 13 Mar 2025 01:49:08 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: [GSoC PATCH] rm: fix sign comparison warnings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are multiple places in loops, where a signed and an
unsigned data type are compared. Git uses a mix of signed and unsigned
types to store lengths of arrays. This sometimes leads to using a signed
index for an array whose length is stored in an unsigned variable or
vice versa.

get_ours_cache_pos is a special case where the initial index
is derived from a signed variable, however, upon checking the usage of
the function, it is clear that it cannot be negative, and hence can be
replaced by an unsigned variable.

Replace signed data types with unsigned data types and vice versa
wherever necessary. In some cases, introduce a new variable, where both
signed and unsigned data types have been used to store lengths of arrays
in the same function, where previously only one variable was used to
iterate over both types. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 builtin/rm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 12ae086a55..4ebfa7539d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -5,7 +5,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "advice.h"
@@ -42,7 +41,12 @@ static struct {
 
 static int get_ours_cache_pos(const char *path, int pos)
 {
-	int i = -pos - 1;
+	/*
+	 * This function is only called when pos < 0, so -pos - 1 is
+	 * greater than or equal to 0, so it can be safely be stored in
+	 * an unsigned int.
+	 */
+	unsigned int i = -pos - 1;
 
 	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
 		if (ce_stage(the_repository->index->cache[i]) == 2)
@@ -58,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
 			      int *errs)
 {
 	if (files_list->nr) {
-		int i;
+		unsigned int i;
 		struct strbuf err_msg = STRBUF_INIT;
 
 		strbuf_addstr(&err_msg, main_msg);
@@ -271,6 +275,7 @@ int cmd_rm(int argc,
 {
 	struct lock_file lock_file = LOCK_INIT;
 	int i, ret = 0;
+	unsigned int j;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -314,8 +319,8 @@ int cmd_rm(int argc,
 	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
 		ensure_full_index(the_repository->index);
 
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
-		const struct cache_entry *ce = the_repository->index->cache[i];
+	for (j = 0; j < the_repository->index->cache_nr; j++) {
+		const struct cache_entry *ce = the_repository->index->cache[j];
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
-- 
2.48.1
