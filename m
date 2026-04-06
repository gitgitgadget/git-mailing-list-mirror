Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E638C400
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499020; cv=none; b=RLV8TKypO4//45p4HQ7JatKgNWbz62XDLCfoTAjosduO7HFTjc7xdw1+Yae65j+p+f8W5DexHVqiYO9JexZimqP74GN7m8jQiclrkQE6B5KLooOpBq7m5/iYP/TIeEXUkcL14PHJQuk8ZCw0FDhW4xtnhiIoPVYVjK/XaQ4aPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499020; c=relaxed/simple;
	bh=LLwrp2FocJvjuGlZ9KqBSY+mMZlOQrOeDigNEqf3OF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ht7YFJ82td2+6HLaZQks03L/C7K/nbx/6s6bw85E4vtfRB+Ymevc16lv5yI3uwNbAJswJGW8X1XmIevPhlraIhVh6pUTBbuWpCfzrqwnLhDEi8lNkumbG2f4a5kEeZe4SBR61sD4rteGx7WmuGp7QZpzYFBe2YGfz5t9FiCxxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N73i3qq6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N73i3qq6"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89fc349b5c2so42487456d6.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775499018; x=1776103818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iJouRxl4qUg+MHoJyf+Fe8MRxLnA07tY4L6XLz1QTA=;
        b=N73i3qq6toq1go+1pL9DeACEhRCrQtc6V6Ir2/Ie0KCXiCwPZsY0eWOr7GJLfYzDet
         iAP1FwKG+kVTfp9za8KEW/kk9CbyF31zyzgT3poDpwcIS8Q8uFEIyOj2ITZToilnVTZu
         EehJasXbK2vwy9fWbdi8Y50JA4C7XJ0xYmgqqHPKM62tJ8sOK8saZS1ew//KI7jiX7lp
         3DHEW0ESfwu78UyKuzR37Scfrq8rugpEAZmWFwF9C405emY58on8YTJOdrOFbiFZ5Rfw
         uh7vHLZhY11X8CYS+q7EwQ8WYyAO5l4lRhMWKzeMdHh9U0M74SkxIF1M58B8v3C0M5f1
         o/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499018; x=1776103818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iJouRxl4qUg+MHoJyf+Fe8MRxLnA07tY4L6XLz1QTA=;
        b=Yn/c5AhM/4cGCgQUeHR2fvl5gbF91C84e0sMtmQA0kzhzMM9CopGv5C39HqawNw73b
         JRTO5uijszau0lBkBnOBWvgMkcuEpofeX6HJ3qxKTrtbLyYK726Xw91WfOOZT6ngfo1c
         V7TrZbk5CyAZAOY7viMP1GoU6mE3+4zB880bnGRvoBJwmhilJ+qwczkOyyOniNhb92cp
         lU4t6WSlLqDaO2oEehgnq5EhCWHEDw5WjDem3bpUJE8j3DhANRBKE8b+GiJp5sW5TRPC
         +G7WgEvTUC4ol0zyCMrxyGXHSr2DboD9/agDNNxgMgCAgqv+w3fNMnkGK6E3/qZkjqQd
         NFfw==
X-Forwarded-Encrypted: i=1; AJvYcCU5mvO/KOehWjkQsQPLBZaaWKm3+pPNO2byAHNfrn/wTCrSfyrfUcEfeFJ+fWVEwGjJoiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSAkZG7JvskOMAO8j3v8Ve75oaC8i5hXD+0LLy8NpIqUCEPGZ
	nw0SBJZ4rB61C2Ag/jvLgHbBWuOVnXav9xWnpKcP50TENdvyQWLy/5tp
X-Gm-Gg: AeBDievgBUGzX/5Q5E29gLfvleRjSGgs3MMIf5kVruAAIW+vs+Cqt2uZnjBFerUJvgw
	fy0kRbPnDDwpWu3avxlqSe/0CRgtbjuGXNM+BmsEPz6CvnEphpsWoM5+hHzH3i7J5caBFFyEFcX
	JHUSAtMI02LPg4EGq71swX/9Xgvolyqy+xqKVE+c5/JeL0bND4kMD11Rt7+Vv50GIjJNCd3W6Sj
	AQYSn6qq4k/I7wlsimR/ERNSxDXTudmV9pxMsNJOgRfRHISjiTviRvhOHKOIP5q/Sp0+y08eCyN
	5QaIFg3u0VWzTDA63KDVHWQ67jtae03BBFEQYa+kbjAwVDGaS/3mP9GLqHZ8AV6o0g6hmaDj4Be
	+Gw8U4u+pL0O3y32k0LTki+fN0MO61KN8vKN4YNqGtVtj0abawKgk7xq2l6Q6RoMsfHXk/ZuhzL
	uRCNYQCjmbmeT5fULU2DS/1Aa8JkZWhXlmtUqfv8z6jeLlzr0IXmbzfL34SuPk/eF6GbAbVA==
X-Received: by 2002:a05:6214:f2f:b0:89e:a170:6af2 with SMTP id 6a1803df08f44-8a7041fd22dmr225680006d6.41.1775499017746;
        Mon, 06 Apr 2026 11:10:17 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ab46b6079esm21156536d6.9.2026.04.06.11.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:10:17 -0700 (PDT)
Message-ID: <b0ee86fb-2fb8-4c7f-904d-66140b58164d@gmail.com>
Date: Mon, 6 Apr 2026 14:10:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cache-tree: fix inverted object existence check in
 cache_tree_fully_valid
To: David Lin <davidzylin@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, David Lin <davidlin@stripe.com>
References: <20260406151456.63620-1-davidlin@stripe.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260406151456.63620-1-davidlin@stripe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/2026 11:14 AM, David Lin wrote:
> cache_tree_fully_valid() is supposed to return 0 (not valid) when a
> tree object is missing from the object database. The condition
> currently returns 0 when odb_has_object() succeeds, which is the
> opposite of what is intended: the cache tree should be considered
> invalid when the object does not exist.

It looks like this negation occurred two refactors ago in
062b914c84 (treewide: convert users of `repo_has_object_file()` to
`has_object()`, 2025-04-29) which had this diff:

diff --git a/cache-tree.c b/cache-tree.c
index c0e1e9ee1d..fa3858e282 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -238,7 +238,9 @@ int cache_tree_fully_valid(struct cache_tree *it)
        int i;
        if (!it)
                return 0;
-       if (it->entry_count < 0 || !repo_has_object_file(the_repository, &it->oid))
+       if (it->entry_count < 0 ||
+           has_object(the_repository, &it->oid,
+                      HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
                return 0;
        for (i = 0; i < it->subtree_nr; i++) {
                if (!cache_tree_fully_valid(it->down[i]->cache_tree))
 
This was one hunk among many, so it is easy to miss that the ! was
lost as the function was renamed and moved to another line.

>  	if (it->entry_count < 0 ||
> -	    odb_has_object(the_repository->objects, &it->oid,
> +	    !odb_has_object(the_repository->objects, &it->oid,
>  			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
>  		return 0;

This fix (respecting the has_object to odb_has_object refactor)
is the correct one.

> +test_expect_success 'cache-tree is used by write-tree when valid' '
> +	test_commit use-valid &&
> +
> +	# write-tree with a valid cache-tree should skip cache_tree_update
> +	GIT_TRACE2_PERF="$(pwd)/trace.output" git write-tree &&
> +	! grep region_enter.*cache_tree.*update trace.output

nit: I think this would be better as "test_grep ! ..."

Thanks,
-Stolee

