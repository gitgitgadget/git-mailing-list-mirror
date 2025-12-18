Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1921F4606
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766081927; cv=none; b=JBjrfAWYwWdain9jlz+2JqLre84mRXrTniFuiUdQe7lcp7dLDS5FUmGpz6JYqJCDIFVzmjlErNmsn2iGCHGamcf+u3kLN+E8SN3UvagPedj9YgCyIx4cIiEZGhz0GKY0fdERlOhHmKtkBHE00g/Dm/BxA6xmV5qHS9w/uWeQbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766081927; c=relaxed/simple;
	bh=P6R87T3WyT9WL+1Lj3jwcGe2t/bgw/wxeZvhKGV8Wi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e55kC0LS9snIPpi2fzi8gO0En89HYvY1iOJUHttcsLP7cxspk8M3o2+FAI2RDQIdKsgch89J+5WTpLuc+O074VVXsyxefdnrjJjSEce1w/mMZqMPpQIKLNLe8LstqY/9yDX5+Rg/Svg0HqOY4lJbR1PmvJnP+vcjVRKk9GbHPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a2ce041b2so1023596d6.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766081924; x=1766686724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yywYPUyruW2Xo3mmTUiisROpoXgd55nwL26xPyZXvqA=;
        b=Rs8hsPWwgr/HGuNVpllcpWfhqYsZ9vB8ylTv26WrXz0TxeaOVs25lyyCQGZxfiWoR7
         1WbL4AwVUbOPgwMjm1YsIdC1Oug+bg6A8iqsnTI+hWOZDppXZLDSQ1wLvagVsX6o6Hkw
         8EX1StXeGzJJJ8wSqYgDvZ3amQbzZOKpct11I+mTKDLoAGsqLfY1sVLekjl+kqBuHi3P
         //ztsNCDI8TxJEaYKnH1PBQ/7q2Px8rv5piuTtHeAtUD4orR44mRYrdFpVTy/5ME+wVg
         uAFTrPVw+yrTERxEhay9JiDW91Awp63ypp4a3hpGjqu7/W2tZXeCle3Hq2+4J/LllonI
         HgdA==
X-Gm-Message-State: AOJu0Yxl6RGuX/CFelNyhX7WNXBmtBOgBkm9qnsfOoR7ayHjzpn2btQv
	/loMuKbVZ/wKLO/P+qSeWeYqUFQ00qIPdSdJeIObIfVekReI6FIK4vnQyRPNsG86AgJC34Jfi9M
	1xE8wsk1U48o/Evoiyeqx7NpXps8CLd/fzMkM
X-Gm-Gg: AY/fxX6j3lIvfW19E1Zr0auHzNL0nXHk14AFq1RV/ogkAE7JtMVTdy51SVG34h+xc3w
	FAqBaeBddLD6glng4wB1lHWq13LiA9eZKLTEP4ZgBOZwbFr7tLv8G935C/0Ve+1kquflj5MZHoY
	d6UAbrYl4Xp6Kgy+fs0boSifjWhdyH2Bjjui0iAgCEWgk1fcZ2chz8iodDM/D5e7P349WzX9cH4
	I6hsUTUIyG5R/dhDZ3r/5C1rEJVB6OcbSLVoyl+BSZ3fbbxZihbpmNcKRD9JvS2vGdqvMUVuJJz
	2YEwp1IxnRTtE1+TkgCKfJRqElQu
X-Google-Smtp-Source: AGHT+IFqzAsggKK8pDkqre6FWxUMMRxsLRKC9SGwtMTf12Ik17PfEmwJJMUPjcyKepi5MHZIMQKJLEyOyB9fN9eaqG8=
X-Received: by 2002:ad4:5c8a:0:b0:70d:e7e1:840f with SMTP id
 6a1803df08f44-88d83f58bcamr7887586d6.3.1766081923557; Thu, 18 Dec 2025
 10:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.git.1766071566022.gitgitgadget@gmail.com>
In-Reply-To: <pull.2132.git.git.1766071566022.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 18 Dec 2025 13:18:32 -0500
X-Gm-Features: AQt7F2ro2GkhHMsBdtDMuyc0UMpQFC3IhaDfRf2CrbLbD7VkTzzFf8G_4NM_JSU
Message-ID: <CAPig+cRsKGERBk2pVotrKhhy5FCmmrQODTJEgkO8GuTY2SLbiA@mail.gmail.com>
Subject: Re: [PATCH] repository: cache->squash_msg is freed twice
To: AZero13 via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Greg Funni <gfunni234@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 10:26=E2=80=AFAM AZero13 via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Thankfully, it is set to NULL, so no security consequences.
> However, this is still a mistake that must be rectified.
>
> Signed-off-by: Greg Funni <gfunni234@gmail.com>
> ---
> diff --git a/repository.c b/repository.c
> @@ -349,7 +349,6 @@ out:
>  static void repo_clear_path_cache(struct repo_path_cache *cache)
>  {
> -       FREE_AND_NULL(cache->squash_msg);
>         FREE_AND_NULL(cache->squash_msg);
>         FREE_AND_NULL(cache->merge_msg);
>         FREE_AND_NULL(cache->merge_rr);

This mistake has been present since =C3=86var added this function in
759f340738 (repository.c: free the "path cache" in repo_clear(),
2022-03-04), so it isn't the result of someone else coming along and
adding a new field to the structure which needs freeing but then
botching the call to FREE_AND_NULL(). Moreover, this function does
free all the freeable members of repo_path_cache, hence, nothing is
being leaked, so it must have just been a silly copy/paste mistake in
the first place. Hence, this change makes sense.
