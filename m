Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267FEEBA
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743228201; cv=none; b=lly3OJ12Rr0nXlwc9o1hqdqvm1npGF5eX8G+JiM2TOcVMzsFdrxSY9gjGo9eDCLKlWLsqGdr2niJGzDaPlpBYpzRXeaN0w1Zy6Zm30khHlK6yc141BU5UYgQxmoDfqhCJHVzc6msME7XC3t6nLJSmmREVvkVKZuxcTQOzZ9IJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743228201; c=relaxed/simple;
	bh=3VGaBQuzQN+FFskByATjfAJynbrQz3nD1DxoxIMtl88=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fbYp3Gg1cLOQ3sFWJO5OIgtWEUSc0D7wMl54VctuH+DywFUNmqErOCvn9b6dWJJGnyyUMWeWAhJg+UjE0YFp68YWR+6jvyxxvacOULl1wcawsqyP9cz/cBt5f5ovaM+y0DKpaq4ocPvxSoU8JioVqp6sWqVV2ejUAyiOvgvZ4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcCNnUGg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcCNnUGg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224019ad9edso22817025ad.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743228196; x=1743832996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=401OpHDFmeNFu07d2Q6UKf0xJ8jjEwK1UNsLGImTfr0=;
        b=lcCNnUGgnR/SEfuN5UPJYEWrxqAE0L6Hngxu8GKv1o32wkAaBZZXjdDw4cFPA5fjuR
         nqc65zba5p0sm3LUbZM+HZn6ednci7r1dAjcrxLaEgfInxOGIpLkEkcQr4zi1IHdLxu0
         DHeyxOHGCXI+5/wb3ETK6Y0esxy7yAwNHNnBbryM1NZu/GG4tmuZqMvCsRy01Xd3miIp
         /Kr0jD4iL4TjnHVzMeAl9ICtXH5zbItjlFfXfWW4lrWveOPumo31BiapLL1/EhsWbnf8
         UHrAiUxl6bBDQ9rgNRdlKB9NvQ/WMJMzBNtGKtztjDFO3bsgCY512YuZdBtcvKVvyt57
         yU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743228196; x=1743832996;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=401OpHDFmeNFu07d2Q6UKf0xJ8jjEwK1UNsLGImTfr0=;
        b=Nkp5T8bDo83P71TzUwBSCYhFHtA3CUr2sZJsC17/ZTgWKXgj3asXIm7MvsV2JvEu98
         F3/v2mrlZuFKxhA1uk91NB5cv3UpxU+JENpFRwGIjdLQgpRqSiuQelLYrQSsdJxINTJJ
         d9jxuKtuffH6eEEHxMPJ5Eymu6P145hg8o6iuOymL+AFpLzbiJwbA1s3iU9Yzlt91XGt
         IRoyfUDNb6WrLfCro8kYHXmBo/k2gJX7OEixirA4skwFWtukK7fiTmEyk3dTS2p1SU2+
         GN+GkvVX3A/OSrKnc0P2v1JuF+XvhYkaSw0V0f0tq2tp5aIe/2JxZfs6trjwEt9YKj58
         y9Pw==
X-Gm-Message-State: AOJu0YxIzdrop+HAAJc7fcSeJ6FjEm4qo/GE9T3mp/VHhqRpn33EAuJD
	93mAv98cLe6eb7xHZGFcC2NjUDPcSLVBvhd4AWXy7F00Wzb5dmaClkPyXg==
X-Gm-Gg: ASbGncsXZ0jzENzUiu15AInUWqAn5Ov806GivC8i14fSgOJIUbC4CChzeU412EEyCXq
	A3d5zu6M7w1r0Sd5Dc2QadKQB49DkgnM7nRl6YzLGCIyvc7U8fMF1sxdnXt7OlEt0xU7lUdZ40i
	x85QgO1EjxZFFIUkO2pRslBDffutWyra8nY5zTkEVkemRDKy6Wy4qk7NeKpLSD9LhJO0+e3OtS3
	rVEL2S9Sv0WalqvwJjtKLNjzEGrg0fak3DMvyXCPMKYB2/O7fu2S+9F45euK8d8sCuf+r/dUwrV
	V0Idm7LDRmQPQC9ybusHBE5FCwW8o5ERd+1Y9Kajsr51h3jRoPHZq5YA1peGWQ==
X-Google-Smtp-Source: AGHT+IEKBwZEl/ZbS1D+v7cyx75I6Qd6V0FE3WcRlEyzN8UdWz4fmbiO4IA01hforLdlFYRbWDHqoA==
X-Received: by 2002:a17:902:ebc6:b0:224:c76:5e57 with SMTP id d9443c01a7336-2292f9e8652mr28647535ad.39.1743228195962;
        Fri, 28 Mar 2025 23:03:15 -0700 (PDT)
Received: from [10.61.238.175] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf4ebsm28351335ad.155.2025.03.28.23.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 23:03:15 -0700 (PDT)
Message-ID: <ecaaa968-f337-466b-b719-22ebb3587167@gmail.com>
Date: Sat, 29 Mar 2025 11:33:14 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v4] rm: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
 <0286b10c-2f38-43de-b727-bbebc2f05108@gmail.com>
Content-Language: en-US
In-Reply-To: <0286b10c-2f38-43de-b727-bbebc2f05108@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are multiple places in loops, where a signed and an
unsigned data type are compared. Git uses a mix of signed and unsigned
types to store lengths of arrays. This sometimes leads to using a signed
index for an array whose length is stored in an unsigned variable or
vice versa.

get_ours_cache_pos is a special case where i, though derived from a
signed variable is never negative. Move this part to the caller side
and make i an unsigned argument of the function. Rename i to
pos to make it descriptive, now that it is a function argument.

Replace signed data types with unsigned data types and vice versa
wherever necessary. Where both signed and unsigned data types have been
used, define a new variable in the scope of the for loop for use as the
iterator. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 builtin/rm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 12ae086a55..a6565a69cf 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -5,7 +5,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "advice.h"
@@ -40,14 +39,12 @@ static struct {
 	} *entry;
 } list;
 
-static int get_ours_cache_pos(const char *path, int pos)
+static int get_ours_cache_pos(const char *path, unsigned int pos)
 {
-	int i = -pos - 1;
-
-	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
-		if (ce_stage(the_repository->index->cache[i]) == 2)
-			return i;
-		i++;
+	while ((pos < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[pos]->name, path)) {
+		if (ce_stage(the_repository->index->cache[pos]) == 2)
+			return pos;
+		pos++;
 	}
 	return -1;
 }
@@ -58,7 +55,7 @@ static void print_error_files(struct string_list *files_list,
 			      int *errs)
 {
 	if (files_list->nr) {
-		int i;
+		unsigned int i;
 		struct strbuf err_msg = STRBUF_INIT;
 
 		strbuf_addstr(&err_msg, main_msg);
@@ -83,7 +80,7 @@ static void submodules_absorb_gitdir_if_needed(void)
 
 		pos = index_name_pos(the_repository->index, name, strlen(name));
 		if (pos < 0) {
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(name, -pos - 1);
 			if (pos < 0)
 				continue;
 		}
@@ -131,7 +128,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 			 * Skip unmerged entries except for populated submodules
 			 * that could lose history when removed.
 			 */
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(name, -pos - 1);
 			if (pos < 0)
 				continue;
 
@@ -314,7 +311,7 @@ int cmd_rm(int argc,
 	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
 		ensure_full_index(the_repository->index);
 
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
+	for (unsigned int i = 0; i < the_repository->index->cache_nr; i++) {
 		const struct cache_entry *ce = the_repository->index->cache[i];
 
 		if (!include_sparse &&
-- 
2.49.0
