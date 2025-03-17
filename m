Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88406DDC1
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231250; cv=none; b=MrPhlOtXnBqSNUDPtfytI4aqyZoQpNvyeU2Kao8wdRW4gxpUIMw4FVVDX7shlr20MYJW+WDM+HUyDDAqz6vWzSnzUAiU7pWcXeFVvJwV9ObypPlNjSSvO5jNctkcTkkyhaRG0zm5k1bogaO29on6XribFcEBLMneUj1Tmn9ZhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231250; c=relaxed/simple;
	bh=fTHOGCHpz40ZDpZ/Er4RtnmqX+Ub5MaY683F6HIUYRc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZwrFTNT2ajiwDNQWxuO7lK2ebmccx0+IvaqqUhKGvsA3clRYYJedBmZ6WOPm1cAFnc33WMVglj5tNJMG+JnEF8ziGWDFZ+aHqDUfqcctD9jzjKnvpPYoGbWEFhyh52AWdrLgD4tXttUyeIidniSuzE6EE7a/jl/7246iOpoiNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ60NbZ+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ60NbZ+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so45615275ad.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742231248; x=1742836048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TLM9A6aYPyjlTPMx0NBMveMIY1Y+ENJaJqPgL2lHdE=;
        b=KJ60NbZ+r8qFQhbIA+6GHH1JBrIudoM/BijjLIx9EgF1ULDxNvkK8QZoTBePNWIzwO
         G905eg16o7HQMb6s9ll5ItsD/zZcKRddlFMKjnSSZ/yOrsXXgQ7mOwFz/eR1liXwurFM
         wYipBGAp4cSsIlirNeUv9AslhuDzBc0OZsza2MmlArUeMxZqPpwpfZK+Ze22leDKJNyA
         nWT/66weKy/aMgqJqLvdTyS98idn+lRLXmhfDfTiBqqJDQBUuzBjLJ/X2X6/jXViRK5j
         zgqb4Xsqsw7jV/SMgClc7IhEw5mSMAVYL4y7iPZk/TpO/6QDpcVkCxCkl+zGQZS21kIk
         Coxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231248; x=1742836048;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TLM9A6aYPyjlTPMx0NBMveMIY1Y+ENJaJqPgL2lHdE=;
        b=rW252eIQuikKki/Hg0GbrDHa0qjv+ts3r8sRZ5gZVUYQ22y0hoU7QGSQTLkCZhHgzM
         Xo7WrOrc8YW5cYGYudMPuyg1/BmDSlNFalvxP3Jw4KqIcoP590vq95nCW7wB6mmAKV91
         bAXvWjZj7oGlro2Nb5apNbjctuu21w91UF4XXaoR4b35GvPbsdA2u4EKb7e8rj3yT5mm
         kqrZeIVWihlTqdZhI55SwrmF1z8vPA/Y0qeVdymjwEfYIdeDKBHtyG1CrcGHtBO5ZLdl
         2Jw7Vri0VK39Aan76Y3jJhSU5tI6fB9V70zhk6EoCWzeLmZA6PYvvmharozBA4GSfx6T
         8bqg==
X-Gm-Message-State: AOJu0YxlOi8wH2SXm0XnOGiJjqAMxYcMw6Cb8fWJJxjietU5PPzW3p4p
	7RfNpJMQEn75JpFeRkzykX/1t8GzvKV/mq+14hYiKrU71vPYbCFirFCEWEHS
X-Gm-Gg: ASbGncvvyfc892kqPUl1KP1WWGfGlkBUsGonjx6YKQRYLq1neV42Gwe5972CY4PVRGw
	ggPt7V+Oer9OoYx2TyT1iWNnfdmCqlRz+jW1qXoluziXet998dY3yo1vAZVOm3JCAEAh3AobHof
	odMTor44N7hLn2gmu66m8gwSlKosaZi6FCXIbkp5ujzwHc3gPThMnV9emSoyeDEF8qALyzyacuj
	JlAmoLHSqS8pzxJD9REy6PF5JuMRXjdgQsLGapr8iEDlQbUdpNVCgue6Yyapx2Ty78A1qUB612b
	OAJwdC4tYfoIzbgVvAJv2Db2mXub+zPhKg4hAyaciImCKvPdQdP0zCr9UEIJmFI=
X-Google-Smtp-Source: AGHT+IGhELbd4Z0EqhED/AMo3JpKMHENhm0roU+gXI0jcIgSmGcgSO6jrXawMqNCRcGgcRXkNHKtPw==
X-Received: by 2002:a05:6a00:4fca:b0:736:eb7e:df39 with SMTP id d2e1a72fcca58-737572e0ab5mr447817b3a.24.1742231247596;
        Mon, 17 Mar 2025 10:07:27 -0700 (PDT)
Received: from [10.53.2.153] (125-86.iitb.ac.in. [103.21.125.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167da28sm7857638b3a.89.2025.03.17.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:07:27 -0700 (PDT)
Message-ID: <306aa7d0-3621-40ba-93c3-77536e56b73a@gmail.com>
Date: Mon, 17 Mar 2025 22:37:25 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v3] rm: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
Content-Language: en-US
In-Reply-To: <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
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
index 12ae086a55..a5c9fc644e 100644
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
+static int get_ours_cache_pos(const char *path, unsigned int inverted_pos)
 {
-	int i = -pos - 1;
-
-	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
-		if (ce_stage(the_repository->index->cache[i]) == 2)
-			return i;
-		i++;
+	while ((inverted_pos < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[inverted_pos]->name, path)) {
+		if (ce_stage(the_repository->index->cache[inverted_pos]) == 2)
+			return inverted_pos;
+		inverted_pos++;
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
2.48.1
