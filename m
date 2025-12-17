Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148039B6DD
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980564; cv=none; b=HIC3WP4oK2Y+P+xi4pvBxnts+vuqzj/BRW/lrhHbfjaQEtvRzDxx3ZM4yefRb/PVDu9xb/2XbocJsXZ5MdbVyCmXRojmCaVj/eHg1XnMaNYIm1TsnNPICZSA6ZgC2R03+1+jB1KeU3pnOXChmZYNFFJkf/fqbUic6ZmIZRZgBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980564; c=relaxed/simple;
	bh=cKTXp0SrXJQ9WOjYDcEh67jAjQsIOV6T27iLaoQ/Ck8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZvUhCTRJ0bwRHmO1IpiJ55u9lQMd2hKoFeOTVwJOsLBWVgE7HRXTU0FQwJkViZSGvWm/9ejSdqzMCS2kTcOnbaB8V1QSMXiMiRbma2UT0gMoCsd1zpBxzs2xWaS3bqv/ea/uSWeEKlV6dAJj5vr+MxoQBkcCzp5WLMJHZvCgESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBheBL+r; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBheBL+r"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee1939e70bso57768501cf.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980561; x=1766585361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adrefF8P70lTBaRyE8kZyEeY0BGf9IE9oBZsX9KoAeg=;
        b=OBheBL+rSyi9MPwtKfX2N5Egsw2D8jltiflY2qXSHcGjtlPcXpl/fJmpr/DZwNnIqB
         4DbiXwAMIE43ucIg5bUWrBXQksp2j70JvNHvBlmdnALH+tgkSKZbmVPe6/Ap40Jfm7FP
         vbPB262utF88n3QX9fh6xCzp7VI51LTS0MWiFOBOIGY74yjlwTJhgb4Omvp9r65CBxrK
         RbEGcQh35mISrzxRmQco7PDii3VjGxkrM6qd4/343n2ifustPEEllLU9yBlnafKbRVBD
         kPHhC7h/uAU+liZ8Wl2XhoHZyYZtzJ8te5d6bSgBBAhqpe+c541B8TjK8FxGK0QIEuvM
         4rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980561; x=1766585361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adrefF8P70lTBaRyE8kZyEeY0BGf9IE9oBZsX9KoAeg=;
        b=IqkE+zd+ZrSlSw/t0A0mKdqmNgNnFzLChwb1pPX2/zVcE8j6qdo6wp+RtkbDBPvekF
         tkxQwgUbgEH50V9iRbDxAxeGlLqH8XO4B/+T2WzwjGM5y6nAoQgfURCpNlmoEVxLMeEL
         eJqxk39PTU3DjutEhXq5QPCpMxlVKWB1pfEBIK+eUN2NcmtT5ZyY2juMNPcmTsmEcDEw
         9arxi/0vhOcnsmeJ5m2v5WgrS29GS7NbAkznMYDhNB8flYf/jReu40Pdq72Gn3gR21y1
         PkkXey26E45yPKZbiAkubnVZXNU1C6ioiOKQNWTr/lS158AA5WwPOMc/nDK76mm9O7B3
         Zv7w==
X-Gm-Message-State: AOJu0YxkxdzmkDdO3lIlckm49ZMeAdvl+mwEZ4yAvUqJlf0tY7H1Uvkb
	a7+kLbEVe7kO18t9z1FrJucI7HTUetbPSRqbH5yobUFo0rynxEikSWSEiesa+s+4
X-Gm-Gg: AY/fxX5leSp/X5RPLBo4Lrjkt7+l+iYjrcjDvu3xAUFzG8SJD957zmQhpBXI2erxLfz
	udpvNxMjivuHyr1krJfh+BqRdFJbDwpwYqlJkgyXGO7IAn0N2FReUK367FX0JCnvCWRHk/dYEJk
	ru/LUhXDRbYTHoe4/eANCuerYac67etDfIVb9sDZUuZJJwdqIHCJLQEje7tgFrqaRrmG0aIYrd/
	vgoGDE0cEWqehz6oIBmjHfbiblPdKC7xY9pJUGQqwk0qBJZYHOMYLxitklkGDA9cHW3G/1pY8Qd
	zRXvJjuhTPYX5pGStVSlZJgo19GfrgH52lzZPJgFgoTHAYkUzWwmBp6yWvDOXdudcupunwNEL/d
	EVVxQpPkTnjDJWgUfpPj0SiHCD0R1GPUPhP3e61L6WG83udXDbOPomDgb7EaOTaUmxxo8SQXc5v
	lVE0hVOUQ9GIc=
X-Google-Smtp-Source: AGHT+IEmaCend82SzE78t7OheXXsDx3+gBPKKXlIbs5Z+0WwzzJOGJI1qk0/BvWdyApcpkUw8ZLvZA==
X-Received: by 2002:ac8:6f05:0:b0:4ed:65d9:162a with SMTP id d75a77b69052e-4f1d04e7793mr245522931cf.34.1765980560948;
        Wed, 17 Dec 2025 06:09:20 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c2e0f7sm32827241cf.21.2025.12.17.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:20 -0800 (PST)
Message-Id: <817f488523099b784432742328ea69646c6abafc.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:55 +0000
Subject: [PATCH 18/18] mingw: special-case index entries for symlinks with
 buggy size
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

In https://github.com/git-for-windows/git/pull/2637, we fixed a bug
where symbolic links' target path sizes were recorded incorrectly in the
index. The downside of this fix was that every user with tracked
symbolic links in their checkouts would see them as modified in `git
status`, but not in `git diff`, and only a `git add <path>` (or `git add
-u`) would "fix" this.

Let's do better than that: we can detect that situation and simply
pretend that a symbolic link with a known bad size (or a size that just
happens to be that bad size, a _very_ unlikely scenario because it would
overflow our buffers due to the trailing NUL byte) means that it needs
to be re-checked as if we had just checked it out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 990d4ead0d..260f4b3b2f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -470,6 +470,17 @@ int ie_modified(struct index_state *istate,
 	 * then we know it is.
 	 */
 	if ((changed & DATA_CHANGED) &&
+#ifdef GIT_WINDOWS_NATIVE
+	    /*
+	     * Work around Git for Windows v2.27.0 fixing a bug where symlinks'
+	     * target path lengths were not read at all, and instead recorded
+	     * as 4096: now, all symlinks would appear as modified.
+	     *
+	     * So let's just special-case symlinks with a target path length
+	     * (i.e. `sd_size`) of 4096 and force them to be re-checked.
+	     */
+	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
+#endif
 	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
 		return changed;
 
-- 
gitgitgadget
