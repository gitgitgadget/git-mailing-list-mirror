Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C639A7FE
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210188; cv=none; b=aXrwI2lFnNlVvsqT7WZHeo5aCwkIjXA6m0TNWvLkKVE0f2DuofgPXS8Xdi9GteOsd/Wcm+IFc2xJqTEbhcHawLu+WqZ2oSNNBBYTBE0oHhFeOe4f6OQxP7KmGJAwrhLtWudyEIFVLTNYRCAZsFpBR8xssy2CnAzZuqNF+cx6unM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210188; c=relaxed/simple;
	bh=7dCl6xBkFBGJrPXHp0XTdx0UDG6XmRivdVy1KjUdOAo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=b+N7cWQ4XxqUtiwwVpWwE2OA8p0IwBrRwPuDsT+QJYXFYxMSHUuXihDkIs+7o64UsYygV6f/zt5k2/28uxfjVidE25rW4kBK5xqS8cwH/DReLfhsoE9NqlPZUTwfK9O5p3Dj4lSy6znzqKZ7Bk/gc4o7I7EwAd0fDd1WWhcvTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inwmVQ/D; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inwmVQ/D"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50904a8f421so18434381cf.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210184; x=1775814984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=92ACco72VkXVrr49kid0OoAr5CdzlBwB0TjJCZaSlGI=;
        b=inwmVQ/D85tVA0qXUS8VQNY4i1cxxHWLuvbW1W9MEIkVz/zHKiZzK+O/OMCH/ej+cp
         +m1JMEJ8BvfZYGcXC6o22Rq5+e3wfe/LMadOxDhmBR2IY3ppmm77d/lV64knA3BWVweI
         6/gvbnHgVMYQpyKenvprCcYIXp4CDRyGftXWtgUsVYTjTvcob8UvKu5if55IMs1u3hyP
         ZJSFeXDz1yNb/51d408lMOfvY3TyWm8ZPkBobSKYou8Oqwxv5l0nCtfkmAIjeAqwBwRv
         9yxXT3/twUzoZbII713c8PmnR8EgSkqjlYS1s3xLiOwDkV+ZG4YdtkwBapHkhkjiNE7N
         Geeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210184; x=1775814984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92ACco72VkXVrr49kid0OoAr5CdzlBwB0TjJCZaSlGI=;
        b=glAD9TCplbr5dWhWL+oYGB8J0oZO5Bws34CsYIm96wX9Idy6NPe7j8eVdlzQ2ob6Z1
         CSoWYLQBRnIhIddGM5SyAkmK00dse5ExP0k5Bvogax894rCC3W7/YNPBsKdA3qYuRcGh
         puCGlAyibo5ipLBlbqbpoAcN+c0dQmPkM1eifm/Hir6uJu24rJtIn0G7zLxz1KSVM7wC
         ODNHgtVZio2+AZBCHFJ8638HESr+lli0otmgz51ZvcsO8Vat3xyQSR6KuekArJzsIhFh
         98W3dNBbc2eWlEVUlpo+QpuF7ucCzRrqqBCNWZzOG+b1vgIvMzEvr3CnBzd4pDclPjrL
         qLQQ==
X-Gm-Message-State: AOJu0YydFdf8ZHV72f+PmduCFL4EbZzjbN3UQEIGcYd+HP0rLlUcKr/4
	zLOPHOo5t4rW8nryc1tLlv8dAIRdkO9yk38tUm7Ul2FUMbNcuJrJqk7wGebrTA==
X-Gm-Gg: ATEYQzxeHtfhWYJErt+7pcT62lGJHm+e9ds1qWR1+ABrY168zrpbZaUJoKhWAp5uI5L
	EpIXacsFL34udZ8N0CJg9vyQS6jr/QSnrrmJo0ewC9Zsg2QT8bMaO6BBjpBKfubfyaUuQfsH8T8
	lxzOaqxteh/g0TeFXjMo3lkews7rsJ2nyfENOhzyrKmP8640qaiBE6TqCBgydDVM23tf3JrbNI6
	0XactZHU6shyglrnwVAa0fCWj0L6FWbSLm9YDbQiCDTsJUYehzaix0tmaq+4UmC07ui62Qd6rT6
	RqfzK5+ydbWlrI/IuAC0FrL1HIM7MDVXpEe22sL9MltV0kH1Y2H1ZJwW8V9CqTuKIkIFOPKumNT
	VAwIedKE01zq6o4FT9i3c41UZT//daDj6NGIi6Dk1WhK4qXwYrYoQUHd74eu56cKc+rS1EuOmo+
	REWEVP1jnRCyPRpxgRvl0SZfoVA3YN
X-Received: by 2002:a05:622a:40cc:b0:50b:40bb:277e with SMTP id d75a77b69052e-50d62afd8b3mr31309041cf.55.1775210184193;
        Fri, 03 Apr 2026 02:56:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.166.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b885b69sm42369561cf.22.2026.04.03.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:56:23 -0700 (PDT)
Message-Id: <pull.2079.git.1775210183103.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Apr 2026 09:56:23 +0000
Subject: [PATCH] mingw: use strftime() directly in UCRT builds
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `mingw_strftime()` wrapper exists to work around msvcrt.dll's
incomplete `strftime()` implementation by dynamically loading the
version from ucrtbase.dll at runtime via `LoadLibrary()` +
`GetProcAddress()`. When the binary is already linked against UCRT
(i.e. when building in the UCRT64 environment), the linked-in
`strftime()` is the ucrtbase.dll version, making the dynamic loading
needless churn: It's calling the very same code.

Simply guard both the declaration and implementation so that the
unnecessary work-around is skipped in UCRT builds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: use strftime() directly in UCRT builds
    
    Since the MSYS2 project deprecated the MINGW64 environment
    [https://www.msys2.org/news/#2026-03-15-deprecating-the-mingw64-environment]
    on which Git for Windows relies, we have to prepare quite swiftly for a
    future where we switch to the UCRT64 environment instead. This patch is
    the only fall-out of that that concerns the Git source code.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2079%2Fdscho%2Fmingw-use-strftime-directly-in-UCRT-builds-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2079/dscho/mingw-use-strftime-directly-in-UCRT-builds-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2079

 compat/mingw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index c667a2dcda..338ec3535e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1394,6 +1394,9 @@ revert_attrs:
 size_t mingw_strftime(char *s, size_t max,
 		      const char *format, const struct tm *tm)
 {
+#ifdef _UCRT
+	size_t ret = strftime(s, max, format, tm);
+#else
 	/* a pointer to the original strftime in case we can't find the UCRT version */
 	static size_t (*fallback)(char *, size_t, const char *, const struct tm *) = strftime;
 	size_t ret;
@@ -1404,6 +1407,7 @@ size_t mingw_strftime(char *s, size_t max,
 		ret = strftime(s, max, format, tm);
 	else
 		ret = fallback(s, max, format, tm);
+#endif
 
 	if (!ret && errno == EINVAL)
 		die("invalid strftime format: '%s'", format);

base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
-- 
gitgitgadget
