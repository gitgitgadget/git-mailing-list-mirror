Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331733A70E
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655068; cv=pass; b=VREK3uw921c9AzO9ZYpxwT17+6jw9X7ukfEzgHQ3IGMh0bT+EBwo75Ku8GdusYealsUHuiMNPWT53R9mEXjr7B0mc+nAZEXJAqCtTJ5GwVWLQa9F4jk2qIU1/ecuSq/ljrC+34tSyXjTS41ukUuQ4irKwU1zQjhlb2wQHEuFsk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655068; c=relaxed/simple;
	bh=UazJqykVSrylb6J7S33jPvKzIT6ZgwAAfjzR9He9ZLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RntoYC2WErVH2Ml8eX8uVgj/YynXwYhw5OqAGr2hQ6KMMptZdD9JN5hu1MZi7jp9IO4gROouAlYybth6/GCKRnZh2quJ/Tu3APAP6Cn7pS6Vczi5IPCO9FdjVHX7TjsBD3wQ/RRjmeiKHkT/HmDC1zmsv35b0eixI6FfbxIJRkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8g8Zjn/; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8g8Zjn/"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917917023d7so2240466d6.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 10:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791655066; cv=none;
        d=google.com; s=arc-20260327;
        b=nw9z59XJjIlyCJBVoDlCktyI2TkQkBUybuF2QoYM9S+Io2AJ5P8s8SZ2RMbWnO6oVo
         61Gu/jqmrjUEnNPi3F5BqubnKM1JZOPDIPEQoLnzmsAjEXd5dtkyPWEi+2idDv1rGPAR
         yNext40tJeTExmOavko50H3firp4Ivj+9vTZYi7kKgMO4D8rliuSwHQRe88jkcVBzGIZ
         1v64yZRMAtrJKOn1zOT/dGnEQRWjezc9qaoUyNF9yGHONZl8HKvieiv0EkKvcmGukGF0
         tB90xoSZ4Tx4ababSOecKOpytKFrZsXZme68A03WntqYscxAxceK9GUCiD0aWXB1Godl
         Hf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5Y9Ve3yvtmX4w6ct/Lrt3hnrurHp0EadPBCRtQXrhgA=;
        fh=bEkOUHB+vibrBffVlPn3HxK9B9lJkw0crHqnzwJCGis=;
        b=pLNcL9InzjMWi2H9pADUjO9heLb6defAhek8G+N5pfEW0I5vDnh8MGlHss2cBfLBFs
         9c6z3Bobt2Ra05rxXitscO7Yp3a5ohU8razvoU9xRUkD4jGHnww+PqKkNX8YUOvM4dGg
         wpqfAkvDgBB1oMKwwEhqgBDjMi7djKROSmb0j+7+WSbUPEBJQ0C70dKov7Ra/Nb2TCLk
         yCdNq7KBlYvyMvdIY6nIN60A4YX4E+rCk9aTEQJMkJ3vA6qxEOJyMk5gM23cVjWQV3om
         aHQekQkdD2VczGaWg9v3X2hM4gCa9e5EvSFhJF6ftq5vCfptLn+OLKQy+58I4hYVo/uv
         DaTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791655066; x=1792259866; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Y9Ve3yvtmX4w6ct/Lrt3hnrurHp0EadPBCRtQXrhgA=;
        b=P8g8Zjn/Ie01QglR63Y4bCz/UFx8zy9ibmnMWKDjKvbO+GRvwUj1VLJtdgs/l0IzMS
         yhTPPmj9yarKXyCe0va8BXLXqP+fxVU3M9/uqZq41j213mY10PnjCOOVSZ5H45qIZrA0
         XhZdvwVN1LrfjtQ6DAulzBtjoLdNanHLhhyp9zw6t+r4DQZpXaFN/W9qgTl1GqLYX7LV
         1YutqmAizxOuwoC11RL66B/DcZMN5KwZDuxo5IBGjyWadBc2VLQFcOCZZLWD/HQNuRhL
         SZrTWt3vV1Tphm8Q26D0/uX6yc2OCTuL11Xwe0FY1o25gRBggBagPf+8vOLlPp8mewHR
         iBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655066; x=1792259866;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Y9Ve3yvtmX4w6ct/Lrt3hnrurHp0EadPBCRtQXrhgA=;
        b=IsO/Yyjqe5WDDcA3uEHRGtiBuL9VfRuSkdQM86lnVY+FAqpUOjfgo+PIsgHLSNyPXo
         eq5gJvmB93zcVk8PxW5PzcVTPbbQ1t2nj5UZpiPOsHJ1U6pJ7UOgSQ47Qe2G1ZSrGIxe
         9vQCV6DTW+EXcvWRQ0kr0BvUYLBCUjz4ybsfQW6r5WfoFzt9E4dfcohwxtcvSqhHg7GK
         wl5ku40g1Zns9zlRFK1QnRnRTF69lSaGrKY1eYU4nwBDEoqKAaUDEAsIaT2QZNlI7CIb
         JIOlRghhOyybvggo/y5/LE7pWd+zWcDEDiA1jD/e3EPVA+UGmCNC6K5DRa9ZTpy3sIq1
         63Ew==
X-Gm-Message-State: AFq9FYKErkLr/uGHxeS3JJKPwaXQAVcYkzwKp48RuqCzJ1RmeHMzHiLV
	+K8cVoNcnVoQwyMBIE7sI3aAWnUNqp+1smygED+ad03jnZ4V6SFy6XSu1vHRefhyILW64b0oeWV
	31Bo5+EVQ5sUqKAoDSdLIs6qwXrPlZOvitA==
X-Gm-Gg: AYBFou3gApXsNY0Am6GmuM+/zzQzzUpBq2hx9+xcF3R90mh8Y9DGjLcjKcNPL+u3jif
	LnykTzAV5EokuYAdWb/Np7phZzn5FR6bU9IsHsPrINRJkr7P/4S8vXqU7tUZKZ3lrLLPVis14Bp
	OdnHvtYT42i7okb0LOsNwCq4SuKxCm/SeC0GcyVVqpfsjHHuFQndNSNaESPOr9Hccif7MVKlk9y
	xXOibPrtq4gTgHx0q8aEb6fwQfqrlZBm/JE0mvdfJZV/f8tAW/860r2dVlpwCu/WVZO/Ks0EaB4
	XqYBBmTdi6WbbIvjmnpsLcYkTwqUkU6k8iXg6eztVpOIeilAthqhxVcAxSFV+nH6i7U5dhEyrEZ
	4IVpvxx1EJFPJeuN3WTIajka4xEEaHUUgzTBMYwqmBsBfFHU=
X-Received: by 2002:a05:620a:2995:b0:93e:acdd:b566 with SMTP id
 af79cd13be357-93ebd10bc2emr980063385a.2.1791655066348; Sat, 10 Oct 2026
 10:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
 <20261008204603.1988-2-curtis.allen.smith@gmail.com> <xmqqfqyfwi20.fsf@gitster.g>
In-Reply-To: <xmqqfqyfwi20.fsf@gitster.g>
From: Curtis Smith <curtis.allen.smith@gmail.com>
Date: Sat, 10 Oct 2026 11:57:34 -0600
X-Gm-Features: AclHuK-7bgp0njf3MoK9JFjSQs8jm1xnnHi7xI82KzBnupkA6VA-aWPad9yonXo
Message-ID: <CACnh8rJznfBDS9tfG49mFqB4J05KbxRWUh_q-OaCc5zfr3pgDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] read-cache: do not trust a size change when
 conversion is active
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> That's overly verbose.

Will fix.

> ... Why do we need to add a new function that compares converted
> data?

We don't.  The fix is only this:

--- a/read-cache.c
+++ b/read-cache.c
@@ -9,6 +9,7 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "convert.h"
 #include "date.h"
@@ -480,7 +481,8 @@ int ie_modified(struct index_state *istate,
-        (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
+        (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0) &&
+        !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
         return changed;

The existing index_fd() path then does the comparison, as it does when
only the mtime changed.  I have built and tested the fix by itself on
top of 6de20f6: the new t0020 tests pass with it and fail without it.

The rest is an optimization that skips converting and hashing when the
length already rules out a match.  I added it, and patch 2, expecting
cost to be the objection.  It belongs in a separate patch.

Without it, status on 200 modified 1 MB files under "* text=auto"
takes 507ms instead of 3ms, and on 10000 modified 2.6 KB files 129ms
instead of 20ms -- the same work the mtime branch already does.

After the first run, status on 10000 CRLF-rewritten 2.6 KB files
drops from 21ms to 5ms, because the index records their new sizes.

Shall I send v2 as only the fix, with a short log message, and offer
the rest separately if wanted?
