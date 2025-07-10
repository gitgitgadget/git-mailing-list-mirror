Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4895256C61
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155479; cv=none; b=U8G87WJa2N9RoH3F0r+3T1M7GuV0KZdUI613fIWwHnR3R9/qq1TZqg68XXZ+cry+avMa3eufVzFiuqtDvz1SH6gXUuhxv6QC0Q88dkcjvG5YqP6Gify6zIiyOxBsuvbMhLH1j6RqRKQAknlx6MSe1R1NtgcX6z6PtxmqTDBpZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155479; c=relaxed/simple;
	bh=lAkoEIx9PvdX+cX13VK+ysW/anmU1UshF6HTBMK+SBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZPvVxE06IJslwcLeJd4Ts8Pvs/lMuhQjnLszxjxWt6EWjfBvozyn1/+PWw9oTy8XSN0kacku0sk/kui+I1+Bn3BLa2HNfjvfWtCzx8JriNUPplQ7oSPleUih8ii0fERXo7abNqNhkVEfQXilV+jvc9m+AN9kgxLKNWxYe4e60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+jPheqh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+jPheqh"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso859623276.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155475; x=1752760275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceXSbAm3hrligKODgcQt7M7p6SIzVet8X6V8X/K4jL4=;
        b=b+jPheqhobc0ca+BeI32erzEJe+TyMhtKOpLU4iEMr3gmanc4GCDQKiS1U2BT3yBsW
         VYea/B15B6lmFkNtFLawiz8IQRNmlB4lB2pMWS7S1Nan7Hg8eWGNlpUzKmoDf95zB66d
         tp6tzSiL9QgFByljMpPKdToAEJNmhP9upJ3LhTj6nGTr7iQhqAb5rXRcrEA3tXXOoIj0
         GKdZsZII8HhEPh6z0cawYWyUXGy5R38y93FObBPtZcVkCEo3CG11q/V/3onSxUK2tqVu
         icuHS5JBVcCuOErcOBFlzopxeN10DVuu4ACGmGCt3hrp1iueD4Upn4V+/onl9KtyoSCO
         WOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155475; x=1752760275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceXSbAm3hrligKODgcQt7M7p6SIzVet8X6V8X/K4jL4=;
        b=nlf41F+Xdk/PTqA/KnSFdEU9OSFP6QvwPCf9XVBaBLqn0W9cyNx7BEhvVQT3JwTf4p
         HUPDY2EWzHNpgqcniHRvLuGFXyv/slWBC+TJU6IJ3flp/u0r+xvxdYWlHKxk55sNfpLY
         Oc5po6MTr8fNBFiWsru6/Dra5TUPRiUCtjOzWLeDlmau48tJeJ105jh9pxBlZYpXcfpF
         n4XLM/IfB340KEq2l1VJWbAK/8AM2N5+4PbTUcrIgthy9WkS34IkhUzrdhNkFLWNOref
         xV9V9yWPeR9PNYn2A8RItB3Tu8cQhDR51fB2T6mEdHiRGccH9P8JxFN6tsKNSyvuUPpV
         VhJw==
X-Forwarded-Encrypted: i=1; AJvYcCXIqNC7hk91mRovmRl0ciiNgw1IRVVRUuaqsW91AhZAVLL4lmCt60ibXwXLj4HJumFtZ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOYApExe87uNB/au02VjNDw4ec55Lyn0vd6mvWFx4hxyb4F/o
	M8yTl+A/y0mmsKZMqHlxwHqjgwSS1PTSnlePA+SoS122lNcgqZXSORvZ
X-Gm-Gg: ASbGncs87Z27QmQb+Os0oZhmDb2YdtrF2UhqV+BA1j3RI1gEvhppXc48D88OAK2aC1J
	v7BCVKE0BYZmdY4XzgnIU9hwHNRgnm3Lh5Vk8Rfp4Q/a+gXEytAGzyU8uYZ9hsHwtMYoNUMFrWB
	3GAgiqXeo/gJvnnvpGnzBE7UO5hweXF/bJEgXM5O4tEXrCyryrNZXPlN4c7d0ptkal2gxLePlZB
	1fwoc+7SCQp1p1Yr0gQ8sYKqMrDrpFFNX1wULXZpe4VgJsER99r/ZxnsqxWHQh1kP2uaC4e7hjp
	Vni1iXc5o7HHVab9LRz6zXBlpGZuN+4x5BpGtlmFQwwNqAZf3aXaXcEdNdFo+qEM+dHRHnaZO6e
	SFqOy2K+caFGoFulnmX3OhoZiPhoPK614v5bFyg==
X-Google-Smtp-Source: AGHT+IHGNYRjw/qNhAex5sllI++eRqjKTOUZRgKyrniQ+LSrRjRtPInVXisq8Fi4WUK63+XSaynOXA==
X-Received: by 2002:a05:6902:200d:b0:e82:249a:b3ee with SMTP id 3f1490d57ef6-e8b7a329b7dmr3104700276.15.1752155474659;
        Thu, 10 Jul 2025 06:51:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c538:4e9c:cfeb:f6ff? ([2600:1700:60ba:9810:c538:4e9c:cfeb:f6ff])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7afa3608sm426962276.26.2025.07.10.06.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:51:14 -0700 (PDT)
Message-ID: <3c59af48-23fe-4cc7-87e9-1de94f509a2b@gmail.com>
Date: Thu, 10 Jul 2025 09:51:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5.1 3.5/4] revision: make helper for pathspec to bloom key
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn, git@vger.kernel.org, gitster@pobox.com,
 toon@iotcl.com
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/2025 4:48 AM, Lidong Yan wrote:
> @@ -710,23 +709,26 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	if (!revs->pruning.pathspec.nr)
>  		return;
>  
> -	revs->bloom_keyvecs_nr = 1;
> -	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
> -	pi = &revs->pruning.pathspec.items[0];
> +	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
> +	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
> +	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
> +		pi = &revs->pruning.pathspec.items[i];
>  
> -	/* remove single trailing slash from path, if needed */
> -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> -		path_alloc = xmemdupz(pi->match, pi->len - 1);
> -		path = path_alloc;
> -	} else
> -		path = pi->match;
> +		/* remove single trailing slash from path, if needed */
> +		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> +			path_alloc = xmemdupz(pi->match, pi->len - 1);
> +			path = path_alloc;
> +		} else
> +			path = pi->match;
>  
> -	len = strlen(path);
> -	if (!len)
> -		goto fail;
> +		len = strlen(path);
> +		if (!len)
> +			goto fail;
>  
> -	revs->bloom_keyvecs[0] =
> -		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
> +		revs->bloom_keyvecs[i] =
> +			bloom_keyvec_new(path, len, revs->bloom_filter_settings);
> +		FREE_AND_NULL(path_alloc);
> +	}

This diff is still bigger than I was hoping, so I'm sending a couple
of patches that simplify this code movement. Feel free to ignore
them as being too nit-picky.

--- >8 ---

From 69fa36dc615e140ae842b536f7da792beaebb272 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <stolee@gmail.com>
Date: Thu, 10 Jul 2025 08:06:29 -0400
Subject: [PATCH v5.1 3.5/4] revision: make helper for pathspec to bloom key

When preparing to use bloom filters in a revision walk, Git populates a
boom_keyvec with an array of bloom keys for the components of a path.
Before we create the ability to map multiple pathspecs to multiple
bloom_keyvecs, extract the conversion from a pathspec to a bloom_keyvec
into its own helper method. This simplifies the state that persists in
prepare_to_use_bloom_filter() as well as makes the next change much
simpler.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/revision.c b/revision.c
index 22bcfab7f93..4c09b594c55 100644
--- a/revision.c
+++ b/revision.c
@@ -687,14 +687,37 @@ static int forbid_bloom_filters(struct pathspec *spec)
 
 static void release_revisions_bloom_keyvecs(struct rev_info *revs);
 
-static void prepare_to_use_bloom_filter(struct rev_info *revs)
+static int convert_pathspec_to_filter(const struct pathspec_item *pi,
+				      struct bloom_keyvec **bloom_keyvec,
+				      const struct bloom_filter_settings *settings)
 {
-	struct pathspec_item *pi;
-	struct bloom_keyvec *bloom_keyvec;
-	char *path_alloc = NULL;
-	const char *path, *p;
 	size_t len;
+	const char *path;
+	char *path_alloc = NULL;
+	int res = 0;
+
+	/* remove single trailing slash from path, if needed */
+	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
+		path_alloc = xmemdupz(pi->match, pi->len - 1);
+		path = path_alloc;
+	} else
+		path = pi->match;
+
+	len = strlen(path);
+	if (!len) {
+		res = -1;
+		goto cleanup;
+	}
+
+	*bloom_keyvec = bloom_keyvec_new(path, len, settings);
 
+cleanup:
+	FREE_AND_NULL(path_alloc);
+	return res;
+}
+
+static void prepare_to_use_bloom_filter(struct rev_info *revs)
+{
 	if (!revs->commits)
 		return;
 
@@ -712,22 +735,12 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	revs->bloom_keyvecs_nr = 1;
 	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-	pi = &revs->pruning.pathspec.items[0];
 
-	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
-		path = path_alloc;
-	} else
-		path = pi->match;
-
-	len = strlen(path);
-	if (!len)
+	if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[0],
+				       &revs->bloom_keyvecs[0],
+				       revs->bloom_filter_settings))
 		goto fail;
 
-	revs->bloom_keyvecs[0] =
-		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
-
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
 		bloom_filter_atexit_registered = 1;
@@ -737,7 +750,6 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 fail:
 	revs->bloom_filter_settings = NULL;
-	free(path_alloc);
 	release_revisions_bloom_keyvecs(revs);
 }
 
-- 
2.47.2.vfs.0.2


