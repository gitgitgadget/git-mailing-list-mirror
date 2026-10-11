Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4741A682C
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747542; cv=none; b=u5JXLK8wc/YF+MAzXu7m7ziE8Z75Z04ZqNd+JhYRAxj8I3BG65ZBw82gQ75fgV49DRPEyi5kUSWJ0Qu474wnxZKGulqWONdCFRyZJBws//038+0d1H0T0iLJ77hg6hnvkgnpBZrtQhtF5H7mWgcj8OgiLZMLSMx0O4ZZyG+dj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747542; c=relaxed/simple;
	bh=KfJZfqpGqo4bXZhUZfEWIuJikP//BU/O/0sjwcBjXIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHQN83hINm4OAXfY3XlDE4Q8bi26blDncdBE5v3BT9bk4yjYIg7zWtT0U1P/Q6hMkU7My//+MB7eBDnzAXCImhhOVkXJsdGts3iQFdXlJyrCY9cFx5/1y1LGAG5RQAU7kAJEU05OzPH3ZLFI7Rl0i4kw2IrGFtZoSGELItDuodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUBxoErP; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUBxoErP"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4486081eec.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791747540; x=1792352340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Pjh1Fs9HdkImSC1HlSk17AiINMWEJGc/DZRS04m+zo=;
        b=mUBxoErP4G0FVjvXCwYy1VdcQZM1HqmCDYhVi6F9DFINQLjHSurPUJ1gz18z0hW80+
         7RxWU0QsEvMaCmgOxhUnwWd9mD2h460KMqth1oWFoFeGCmuvpIcDO7m53fCdh09sxLih
         G6fQDkiGtB6UV13aeCksncSxbeXgooNsUTLAcgdLdIF+c+z7csuH3H+M4u51EwKpEt5q
         wKXLAvgPoQyhihoPbLkdxKnOP1oFBpieoGpvj3zW+yLcdCU4a873rzyFCjMTQKjJ1piR
         v+jr+5FfseJFCeb1xq38qajkOP/KVIVsjf8mUNFCGGgAhbet7wMaK2Krd0BBD65qqjS/
         p3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791747540; x=1792352340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3Pjh1Fs9HdkImSC1HlSk17AiINMWEJGc/DZRS04m+zo=;
        b=quy2cQuJeqAw/T6uwfCpO2VZZKc5WLwN2j5YIViGI6hPfBBH6LxFpD3YxAWSmGz13K
         ns/EM7eXTUmuAdnAdkk5i4ZEEPK6c4fwhPf1dYBNCJaK1rNUiStuqgKLauHQw0ovv2VL
         uPP1iycs09m6ozxlcZAcJ054tvrhFvDyGIYgWs+qaYcLdB8fZUjlEGdCilvQOANUEUqU
         mMCA6pD7+i3hUGJGFUvAGE+Yx3xd/4AEuD0xC3mhKWbnzRDJQIvpWIOnXPv3LRMq9Lpd
         npmfTKhCuurSAx//PJiT8nviZWWBnNcxA/i6M7y3k0s9uu3xKL966ynbtFfh9d73nDc8
         5+vw==
X-Gm-Message-State: AFq9FYIxnDSq1sW2XT4LBWakgQvidzVwTN6I0s4wpLzR5+PtGXfp+syC
	RTwp2DWk8hTiR7JEwpwmgPPFlaX7iQ7DqRl6pWXOI7BmbvDebQxNMct2y33xLoJ3
X-Gm-Gg: AYBFou3j4/Qzrufz8DnAyMoQBw0nqOHq7Zo+xLawncAA+tvaIdMmcQWQj7TdfQlZ8jH
	Vn/4dKeGcA2nIyYDnnoieKVdGcqnE8gxh82P8CAvilFaGfg6gnigCpUrotNqDH8ScGKR4rvHkbO
	+yyLZy6qz4irvdpYYbE2eXR+bGtB53CTKGsRqUO71leAdMyyHlml83IkKOfgk4S/SL2ka+rldZK
	j9EJzWddmYsHY7m6kwasWB+HTeU/L21iaymidG+98CmU8XzEccng424dYbXhgQlwV11N9N1vF9b
	ZrLNOfZhplarAxxxzoHpMbQtGkowMyGVto+Uw0MsuX7Qa3mbpMNPW3eY1oYBJAf2WAWU1bR1Lze
	hD2yFkQXBAXTFxe0T1oxwQnHVYnt6c2SxyZjYiwmG+CzBYEOmKFzXod5bwKgAiQQ4frjePJEfPC
	zhzdU+4V0siV1/Bcz/zOCH2j0fC5UWCVeGUsixY1XIFumSDT/3+wGzpmcAbF3SALYE9Efx8YjHE
	InyoBMLqNQ1O8aAEJNiiBRbRtmCMwQBFzR0SCwsjw==
X-Received: by 2002:a05:7301:460f:b0:34c:bc38:e2ee with SMTP id 5a478bee46e88-3537e01ea2amr10556061eec.8.1791747540044;
        Sun, 11 Oct 2026 12:39:00 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.83.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm9311825eec.8.2026.10.11.12.38.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:38:59 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix lookup for new commits
Date: Sun, 11 Oct 2026 19:38:55 +0000
Message-ID: <20261011193855.43162-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
In-Reply-To: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Marc,

Sorry for the noise, my first mail lost its In-Reply-To header on the
way, so it is not in this thread. Resending the same review here.

I tried this on top of 6de20f609 with DEVELOPER=1 and did not get warnings.

> Queries for commits created during the same 'git fast-import'  session
> result in a crash:
>     < reset refs/heads/newbranch
>     < from <new-commit-oid>
>     > fatal: not a valid commit: <new-commit-oid>

I was able to repro this. With the patch fsck is clean and it works
nicely. Same goes for "commit" with "from <new-oid>", a tag made in
the same session, and a tag of a tag. Existing commits and tags and
"from <blob>" behave like before.

One small nitpick: there is a double space in "'git fast-import'  session".

> to avoid crash and (eventually) improve lookup speed.

Did you measure this? If not, maybe drop it or say it is only a
possible side effect.

> +static struct object_entry *dereference(struct object_entry *oe, struct object_id *oid);

This is over 80 columns, can it be wrapped like the definition?

>  builtin/fast-import.c | 18 ++++++++++++++----

I could not find a test for this. Can you add one to t9300? You can
get the new oid with get-mark and use it in a "reset ... from <oid>"
in the same stream.

Thanks,
Aniket
