Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567077;
	b=UOGKqv13LXm/+4ym8N4ICjg1XWn7Ak4L3Vw627rJL5A8zCUiJ4RrhPz6cZqjZoh5mh3a
	 TfxH/Q8oKKenO+KxILlFXzKgnBbxfq5iZXuUqUZobDdPv344OEy0e/QVyD+H8sMp0HT95
	 67VB2sIv0Yq8CnbuiGX/tMnc8YWmEpJA/Jah5OtEsRqG2NJZCT+5Ly4DEz1gBmIZafVAt
	 uSNDTo5f5ef8rLt5dvFjBI0jGYr5hTNeQEwvKQKkvkK+qEpvzMnZbFpCBm5FucgrSQZ0U
	 KuN2eGzEoo3AbHi3RXcHn6WA9MsHnFgJaPfCeoC1YR96XFC0x3RBIqvIgQtessn4vHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=r61X0AqZevEqWQSEB7yrBnhO1mE9jYYT0yVQs7Xjnno=;
	b=Dqlf3VEEdi2edSKv8Y+ZTwSf4fT04soVV1K7re+b5Ao89HQnFQeowFmwJwSKUV8fVaQU
	 MXpLXI3HXbZCimN9Ex5qPnH1fe9KmyW3maRJiiOEFu3lp5MTZ9swE30qWro4iJAA8enOQ
	 N1wYml99L76Notuk2am2t0DTxdKA2c2aZb5n9z6DoVeGEBXMWuzCPA/7POTN5+4DLRqVZ
	 t1YBT9oobNh6DkCoTg0ZRwgSej8JiO7lTMskDhLPO+/DqQr2mJGGN9eUQaX85ALVzGBgh
	 KelMKqfUVn4zmFxX5YdOSJPtPcNbt1JDS/gbiLia0C7MdTsXxRFnuCYM19iu9J7H9oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jAbQVPwL;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B30606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B30606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jAbQVPwL
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4d198f1a591so243137b6e.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567076; x=1793171876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r61X0AqZevEqWQSEB7yrBnhO1mE9jYYT0yVQs7Xjnno=;
        b=jAbQVPwLx7h6xsPrzuz53f/zXMQ4X4zD8DAg2CzvdDSJuDfxfKguL2ARbPeI01i8fE
         pJqAbrR/fOXN+nPunKklQoQwEV8vK42KSbQcsLsCWU0IiZep+n08EOukbO5o4YnpLqT9
         mvV+TBv/4bppy9+g6hZSOw7heofgHxMLtAhKLJtSAXeUyXpcrLcuCVBxugHhMPrfD6+z
         FshosGFa5WP81SP8LMhZ1MQhlI41MmnP57LgJWQFQBVv0QHc+8XvuzQyhThjBRu+5jmF
         1b2rzfbOwoi7502v/xAORXKJ+bOnpvnD0yM+BB9rcewYV6fXAwL384ifQNw1S9UZosJ3
         xwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567076; x=1793171876;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r61X0AqZevEqWQSEB7yrBnhO1mE9jYYT0yVQs7Xjnno=;
        b=x+YkWWB4Mh+8gZcuAeooPW37Ue9zedNDUKJvmwlGCRUDoNmXD41ynECCdLXVp1Ho/q
         bGhdmZCZ1gqcR99kunBx/SNGNY1Z7xsVm0fFClgD0HQvievxb6lWMMxmPwv3tTjMDwyH
         0sQe8Xf3Gugwa0R9DDjdohkR7T16f6AzOkCbwFjt8AX7XNFiVnGfVIHUcDKsA3ihx++d
         Bt8+Wzo57D0Y3GWknB1ua5XXto+y+FmzeUARud3om4l+T23XXB34OG5NmPzQeCm4In/J
         V7SffeJIUNq7peGM8w6rdQp6Yl91qGPix45VZ9TM4Y1dFWVF+nWlnVt2K99J8ngJ4i42
         5+TQ==
X-Gm-Message-State: AFq9FYK+dIk8NPDHnFGCX5+vFc6MVD0avsGzpWew8QIrr/NXSWo9B7QP
	CK39UPIjo4pAD5H5vSZ5fuv1lyJT4apX1PNlPmv6m7XetWmQKagl8p2GAzIfDQ==
X-Gm-Gg: AYBFou394UAtsybobbJODGDY+MsmZUfayz6SgvGH1eovfV5RPpfeDAafd7rR2cTZ+Gj
	jn8YeUszkvrj0/iX/NYUO47mIFHZOMzAMIKhFDTzsBl18M2WA0pOzHoHIdXYKjaq1PFsnWsJ7pf
	U8dtPBUBjm6H0noQ+Bu94ztdT11OHBB2KNGAAw0nDYdVxRNVl49Yt3sga0NhdPOgk5vtHSodjyO
	AWxv8OweiHDTao+VC3290KNuUHGISOS/JHTOxmFOPxk7Q81TMVS2FjC0p2xvcdpGrvdNl/s5CB3
	Jjjexy+s0QWUcIgPWaHY64NyD8uOzrJt/rypmIap6LLY4izdbmuGtzdvCSzHJ48owv3GxfxG6yi
	Nwtcpu4K8eUX8nj8iBRRBPPV4or/eJ/PVlb5amnBX+WUkPvYGjnCCSO/GPbqmOY/ronKeyzwfgR
	Es1nX03TyWyYQm0Y4CRrqatAIhELXY5d89+ev0yeOsYs1Jnm2eyRvcBM5pdOc8ai/MJZ24iFtwt
	Geb1mtIY74TtIUXj7No0oIT0TWVt3C0C5pi3IgIF0nUcihW+JVzSiO/ITej
X-Received: by 2002:a05:6808:c1b2:b0:551:2eeb:d53c with SMTP id 5614622812f47-5535c27b2bfmr708413b6e.44.1792567075981;
        Wed, 21 Oct 2026 00:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b7176907sm1361085b6e.12.2026.10.21.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:17:54 -0700 (PDT)
Message-Id: <876fb541a8e1d43731bb72ddbbf1c49da8760775.1792567061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
	<pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:17:41 +0000
Subject: [PATCH v3 4/4] worktree: keep the reflink probe referenced on Windows
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jason Newton <nevion@gmail.com>,
    Jason Newton <nevion@gmail.com>

From: Jason Newton <nevion@gmail.com>

The mingw build compiles with -Werror=unused-function. Putting the
reflink_supported() call in the non-Windows branch left that function
unused, so "win build" failed at builtin/worktree.c:445. Leave the
call in the common path. The Windows return still happens first.

Signed-off-by: Jason Newton <nevion@gmail.com>
---
 builtin/worktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 93fcaa5ecd..07adf6bb7f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -568,13 +568,15 @@ static int reflink_worktree(const char *path, const char *wt_git_dir,
 	 * reflink_file() refuses on Windows. Build 26200 is the version
 	 * named in git-lfs issue 6312; no later build is known to be fixed.
 	 * Auto mode stays quiet, matching the non-Windows fallback.
+	 * Return before the probe, but leave the call compiled: an #else
+	 * around it makes reflink_supported() unused under -Werror.
 	 */
 	if (!opts->quiet && opts->reflink != REFLINK_AUTO)
 		warning(_("reflink is disabled on Windows; block cloning "
 			  "can zero-fill files on Windows build 26200; "
 			  "falling back to a regular checkout"));
 	return 1;
-#else
+#endif
 	if (!reflink_supported(path)) {
 		/* In auto mode the fallback is expected, so stay quiet. */
 		if (!opts->quiet && opts->reflink != REFLINK_AUTO)
@@ -582,7 +584,6 @@ static int reflink_worktree(const char *path, const char *wt_git_dir,
 				  "falling back to a regular checkout"), path);
 		return 1;
 	}
-#endif
 
 	if (stat(path, &dst_st))
 		return error_errno(_("could not stat '%s'"), path);
-- 
gitgitgadget
